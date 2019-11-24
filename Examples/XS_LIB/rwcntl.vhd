library IEEE, UNISIM;
use IEEE.std_logic_1164.all;

package rwcntl_pckg is

  -- read/write controller
  component rwcntl
    generic(
      FREQ         :       natural := 50_000;  -- operating frequency in KHz
      TSU          :       natural := 10;  -- address/data setup time before read/write pulse (ns)
      TRD          :       natural := 50;  -- read-enable pulse duration (ns)
      TWR          :       natural := 50;  -- write-enable pulse duration (ns)
      THO          :       natural := 10;  -- address/data hold time after read/write pulse (ns)
      DATA_WIDTH   :       natural := 16;  -- data bus width
      ADDR_WIDTH   :       natural := 23  -- address bus width
      );
    port(
      -- host side
      clk          : in    std_logic;   -- master clock
      rst          : in    std_logic;   -- asynchronous reset
      rd           : in    std_logic;   -- initiate read operation
      wr           : in    std_logic;   -- initiate write operation
      begun        : out   std_logic;     -- read or write operation has begun
      busy         : out   std_logic;   -- read or write operation in-progress
      done         : out   std_logic;   -- read or write operation is done
      hAddr        : in    std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address from host to RAM
      hDIn         : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from host to RAM
      hDOut        : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from RAM to host
      status       : out   std_logic_vector(3 downto 0);  -- diagnostic status of the FSM         
      -- RAM side
      rAddr        : out   std_logic_vector(ADDR_WIDTH-1 downto 0);  -- RAM address bus
      rData        : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- RAM data bus
      we_n         : out   std_logic;   -- write-enable
      oe_n         : out   std_logic    -- output-enable
      );
  end component;

end package rwcntl_pckg;




----------------------------------------------------------------------------------
-- Company: XESS Corp.
-- Engineer: Dave Vanden Bout
-- 
-- Create Date: 12:36:00 06/29/2006 
-- Copyright: 2006, XESS Corp
-- Design Name: rwcntl
-- Module Name: rwcntl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: WebPACK 8.1.03i
-- Description: SDRAM upload/download via JTAG.
--   R/W controller that manages setup, hold and access times for reading/writing
--   external memory devices.
--   Read operation:
--     1) Send address and assert read control input.
--     2) Release the read control once the begun output is asserted.
--     3) Latch the data output once the done output is asserted.
--   Write operation:
--     1) Send address and data and assert write control input.
--     2) Release the write control once the begun output is asserted.
--
-- Dependencies: 
--
-- Revision:
--    1.0.0
--
-- Additional Comments:
--    1.0.0:
--        Initial release.
--
-- License:
--    This code can be freely distributed and modified as long as
--    this header is not removed.
--------------------------------------------------------------------

library IEEE, UNISIM;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;

entity rwcntl is
  generic(
    FREQ         :       natural := 50_000;  -- operating frequency in KHz
    TSU          :       natural := 10;  -- address/data setup time before read/write pulse (ns)
    TRD          :       natural := 50;  -- read-enable pulse duration (ns)
    TWR          :       natural := 50;  -- write-enable pulse duration (ns)
    THO          :       natural := 10;  -- address/data hold time after read/write pulse (ns)
    DATA_WIDTH   :       natural := 16;  -- data bus width
    ADDR_WIDTH   :       natural := 23  -- address bus width
    );
  port(
    -- host side
    clk          : in    std_logic;     -- master clock
    rst          : in    std_logic;     -- asynchronous reset
    rd           : in    std_logic;     -- initiate read operation
    wr           : in    std_logic;     -- initiate write operation
    begun        : out   std_logic;     -- read or write operation has begun
    busy         : out   std_logic;     -- read or write operation in-progress
    done         : out   std_logic;     -- read or write operation is done
    hAddr        : in    std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address from host to RAM
    hDIn         : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from host to RAM
    hDOut        : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from RAM to host
    status       : out   std_logic_vector(3 downto 0);  -- diagnostic status of the FSM         
    -- RAM side
    rAddr        : out   std_logic_vector(ADDR_WIDTH-1 downto 0);  -- RAM address bus
    rData        : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- RAM data bus
    we_n         : out   std_logic;     -- RAM write-enable
    oe_n         : out   std_logic      -- RAM output-enable
    );
end rwcntl;


architecture arch of rwcntl is

  -- RAM timing parameters converted into clock cycles (based on FREQ)
  constant NORM       : natural := 1_000_000;  -- normalize ns * KHz
  constant TSU_CYCLES : natural := 1+((TSU*FREQ)/NORM);
  constant TRD_CYCLES : natural := 1+((TRD*FREQ)/NORM);
  constant TWR_CYCLES : natural := 1+((TWR*FREQ)/NORM);
  constant THO_CYCLES : natural := 1+((THO*FREQ)/NORM);

  -- timer registers that count down times for various RAM operations
  signal timer : natural range 0 to int_max(TSU_CYCLES,int_max(TRD_CYCLES,int_max(TWR_CYCLES,THO_CYCLES)));

  -- states of the RAM controller FSM
  type cntlState is (
    WAITING,                            -- waiting for the host to initiate a read or write
    RD_PULSE,                           -- read pulse is active
    RD_HOLD,                            -- hold address after read pulse
    WR_PULSE,                           -- write pulse is active
    WR_HOLD                             -- holding address/data after write pulse
    );
  signal state : cntlState;             -- FSM state register

begin

  process(rst, clk)
  begin
    if rst = YES then
      rData         <= (others => 'Z');
      begun         <= NO;
      busy          <= NO;
      done          <= NO;
      oe_n          <= '1';
      we_n          <= '1';
      timer         <= 0;
      state         <= WAITING;
    elsif rising_edge(clk) then
      done          <= NO;
      begun         <= NO;
      -- main timer for sequencing RAM operations               
      if timer /= 0 then
        -- decrement the timer and do nothing else since the previous operation has not completed yet.
        timer       <= timer - 1;
        status      <= "0000";
      else
        case state is
          when WAITING         =>
            if rd = YES then
              rAddr <= hAddr;
              rData <= (others => 'Z');
              begun <= YES;
              busy  <= YES;
              timer <= TSU_CYCLES;
              state <= RD_PULSE;
            elsif wr = YES then
              rAddr <= hAddr;
              rData <= hDin;
              begun <= YES;
              busy  <= YES;
              timer <= TSU_CYCLES;
              state <= WR_PULSE;
            else
              rData <= (others => 'Z');
              busy  <= NO;
            end if;
          when RD_PULSE        =>
            oe_n    <= '0';
            timer   <= TRD_CYCLES;
            state   <= RD_HOLD;
          when RD_HOLD         =>
            hDOut   <= rData;
            oe_n    <= '1';
            done    <= YES;
            timer   <= THO_CYCLES;
            state <= WAITING;
          when WR_PULSE =>
            we_n  <= '0';
            timer <= TRD_CYCLES;
            state <= WR_HOLD;
          when WR_HOLD =>
            we_n <= '1';
            done <= YES;
            timer <= THO_CYCLES;
            state <= WAITING;
          when others =>
        end case;
      end if;
    end if;
  end process;

end arch;
