--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 05/17/2005
-- Copyright     : 2005, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    Interface that allows reading and writing data between the PC parallel port
--    and the RAM on the XSA Board.
--
-- Revision:
--    1.2.0
--
-- Additional Comments:
--    1.2.0:
--        Improved slow clock generation.
--    1.1.0:
--        Separated SDRAM controller module from RAM interface.
--    1.0.0:
--        Initial release.
--
-- License:
--    This code can be freely distributed and modified as long as
--    this header is not removed.
--------------------------------------------------------------------



library IEEE, unisim;
use IEEE.std_logic_1164.all;

package ramintfc_pckg is

  component ramintfc_core
    generic(
      DATA_WIDTH   :     natural := 16;  -- width of data
      HADDR_WIDTH  :     natural := 24  -- host-side address width
      );
    port(
      -- I/O
      ppd          : in  std_logic_vector(7 downto 0);  -- parallel port data
      pps          : out std_logic_vector(6 downto 3);  -- parallel port status
      clkin        : in  std_logic;     -- main clock input
      clk1x        : in  std_logic;     -- locked clock from SDRAM controller
      sdram_reset  : out std_logic;     -- reset to SDRAM controller
      lock         : in  std_logic;     -- indicates SDRAM clock DLLs have locked
      rd           : out std_logic;     -- read control signal to host-side of SDRAM controller
      wr           : out std_logic;     -- write control signal to host-side of SDRAM controller
      earlyOpBegun : in  std_logic;     -- indicates when read/write operation has begun
      done         : in  std_logic;     -- indicates when SDRAM read/write operation is done
      hAddr        : out std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host-side address to SDRAM controller
      hDIn         : out std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to host-side of SDRAM controller
      hDOut        : in  std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from host-side of SDRAM controller
      s            : out std_logic_vector(6 downto 0)  -- 7-segment LED
      );
  end component;

end package ramintfc_pckg;



library IEEE, unisim;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use unisim.vcomponents.all;
use WORK.common.all;

entity ramintfc_core is
  generic(
    DATA_WIDTH   :     natural := 16;   -- width of data
    HADDR_WIDTH  :     natural := 24    -- host-side address width
    );
  port(
    -- I/O
    ppd          : in  std_logic_vector(7 downto 0);  -- parallel port data
    pps          : out std_logic_vector(6 downto 3);  -- parallel port status
    clkin        : in  std_logic;       -- main clock input
    clk1x        : in  std_logic;       -- locked clock from SDRAM controller
    sdram_reset  : out std_logic;       -- reset to SDRAM controller
    lock         : in  std_logic;       -- indicates SDRAM clock DLLs have locked
    rd           : out std_logic;       -- read control signal to host-side of SDRAM controller
    wr           : out std_logic;       -- write control signal to host-side of SDRAM controller
    earlyOpBegun : in  std_logic;       -- indicates when read/write operation has begun
    done         : in  std_logic;       -- indicates when SDRAM read/write operation is done
    hAddr        : out std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host-side address to SDRAM controller
    hDIn         : out std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to host-side of SDRAM controller
    hDOut        : in  std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from host-side of SDRAM controller
    s            : out std_logic_vector(6 downto 0)  -- 7-segment LED
    );
end entity;

architecture arch of ramintfc_core is

  -- states for FSM that gets address and data from PC parallel port and
  -- then reads/writes the SDRAM
  type download_state_type is
    (
      load_a20,                         -- load address nybble A23-A20
      load_a16,                         -- load address nybble A19-A16
      load_a12,                         -- load address nybble A12-A15
      load_a8,                          -- load address nybble A8-A11
      load_a4,                          -- load address nybble A4-A7
      load_a0,                          -- load address nybble A0-A4
      load_d12,                         -- load data nybble D15-D12
      load_d8,                          -- load data nybble D11-D8
      load_d4,                          -- load data nybble D7-D4
      load_d0                           -- load data nybble D3-D0
      );
  signal download_state_r, download_state_x : download_state_type;

  -- address output register that is loaded with contents of address register
  signal hAddr_r, hAddr_x             : std_logic_vector(HADDR_WIDTH-1 downto 0);
  -- address register that is loaded by nybbles from parallel port
  signal addr_r, addr_x               : std_logic_vector(23 downto 0);
  -- data register that is loaded by nybbles from parallel port
  signal data_r, data_x               : std_logic_vector(15 downto 4);
  -- register for holding data read from the SDRAM
  signal data_in_r                    : std_logic_vector(15 downto 0);
  -- read/write signals synchronized to SDRAM clock
  signal slow_rd, rd_i, slow_wr, wr_i : std_logic;
  signal rd_edge, wr_edge             : std_logic_vector(2 downto 0);

  signal reset               : std_logic;  -- FSM reset from parallel port
  signal slowclk, bufslowclk : std_logic;  -- slow clock from parallel port
  signal pp_clk_shfreg       : std_logic_vector(3 downto 0);  -- shift register for generating slow clock
  signal d                   : std_logic_vector(3 downto 0);  -- nybble from parallel port
  signal status              : std_logic_vector(3 downto 0);  -- FSM status
  signal sdram_reset_r       : std_logic;

  -- start out with a reset of the SDRAM controller
  attribute INIT                  : string;
  attribute INIT of sdram_reset_r : signal is "1";

begin

  -- release the SDRAM controller reset once the SDRAM clock has stabilized
  process(clk1x)
  begin
    if(clk1x'event and clk1x = HI) then
      if lock = HI then
        sdram_reset_r <= LO;
      end if;
    end if;
  end process;
  sdram_reset         <= sdram_reset_r;

  -- connect signals from the parallel port to the FSM
  reset           <= ppd(0);            -- FSM reset
  d               <= ppd(5 downto 2);   -- data nybble that carries address/data for SDRAM ops
  pps(6 downto 3) <= status;            -- FSM status info back to PC
  
  -- generate a slow FSM clock from the clock that arrives through one pin of the parallel port
  process(sdram_reset_r,clk1x)
  begin
	if sdram_reset_r = HI then
	  pp_clk_shfreg   <= (others=>'0');
	  slowclk         <= LO;
    elsif rising_edge(clk1x) then
      pp_clk_shfreg   <= ppd(1) & pp_clk_shfreg(pp_clk_shfreg'high downto 1);
      if pp_clk_shfreg(3 downto 0) = "1100" then
        slowclk         <= HI;
      elsif pp_clk_shfreg(3 downto 0) = "0011" then
        slowclk         <= LO;
      end if;
    end if;
  end process;
  u3 : bufg port map(I => slowclk, O => bufslowclk);

  -- FSM that gathers address and data from the PC on write operations to SDRAM and
  -- passes data from SDRAM back to PC on read operations.
  process(hAddr_r, addr_r, data_r, data_in_r, d, download_state_r, bufslowclk)
  begin
    -- set default signal values to prevent implied latches
    slow_rd                  <= NO;
    slow_wr                  <= NO;
    status                   <= "1111";
    s                        <= "0000000";
    hAddr                    <= hAddr_r;
    hDin                     <= data_r & d;
    -- reload registers with their current contents
    hAddr_x                  <= hAddr_r;  -- address output register
    addr_x                   <= addr_r;  -- address register
    data_x                   <= data_r;  -- data register
    case download_state_r is
      -- first state (reset brings us here)
      when load_a20 =>
        -- MSNybble of address register loaded from parallel port
        addr_x(23 downto 20) <= d(3 downto 0);
        -- load address output register with contents of address register.
        -- this outputs the address loaded in the previous six cycles.
        hAddr_x              <= addr_r(HADDR_WIDTH-1 downto 0);
        download_state_x     <= load_a16;  -- go to next state
        status               <= "0000";  -- output state on status pins
        s                    <= "0000001";  -- indicate current state on LEDs
      when load_a16 =>
        -- next nybble of address register loaded from parallel port
        addr_x(19 downto 16) <= d(3 downto 0);
        download_state_X     <= load_a12;  -- go to next state
        slow_rd              <= YES;    -- initiate a read operation of the SDRAM
        status               <= data_in_r(15 downto 12);  -- pass MSNybble of RAM data back through the status pins
        s                    <= "0000010";  -- indicate current state on LEDs
      when load_a12 =>
        -- next nybble of address register loaded from parallel port
        addr_x(15 downto 12) <= d(3 downto 0);
        download_state_x     <= load_a8;  -- go to next state
        status               <= data_in_r(11 downto 8);  -- pass next nybble of RAM data back through the status pins
        s                    <= "0000100";  -- indicate current state on LEDs
      when load_a8  =>
        -- next nybble of address register loaded from parallel port
        addr_x(11 downto 8)  <= d(3 downto 0);
        download_state_x     <= load_a4;  -- go to next state
        status               <= data_in_r(7 downto 4);  -- pass next nybble of RAM data back through the status pins
        s                    <= "0001000";  -- indicate current state on LEDs
      when load_a4  =>
        -- next nybble of address register loaded from parallel port
        addr_x(7 downto 4)   <= d(3 downto 0);
        download_state_x     <= load_a0;  -- go to next state
        status               <= data_in_r(3 downto 0);  -- pass LSNybble of RAM data back through the status pins
        s                    <= "0010000";  -- indicate current state on LEDs
      when load_a0  =>
        -- next nybble of address register loaded from parallel port
        addr_x(3 downto 0)   <= d(3 downto 0);
        download_state_X     <= load_d12;  -- go to next state
        -- if uploading RAM contents, the reset should now be 
        -- asserted so we go back to the first state
        status               <= "0101";  -- output state on status pins
        s                    <= "0100000";  -- indicate current state on LEDs
      when load_d12 =>
        -- load address output register with contents of address register.
        hAddr_x              <= addr_r(HADDR_WIDTH-1 downto 0);
        -- data register loaded with MSNybble of data from parallel port
        data_x(15 downto 12) <= d;
        download_state_x     <= load_d8;  -- go to next state
        status               <= "0110";  -- output state on status pins
        s                    <= "1000000";  -- indicate current state on LEDs
      when load_d8  =>
        -- data register loaded with MSNybble of data from parallel port
        data_x(11 downto 8)  <= d;
        download_state_x     <= load_d4;  -- go to next state
        status               <= "0111";  -- output state on status pins
        s                    <= "1000001";  -- indicate current state on LEDs
      when load_d4  =>
        -- data register loaded with MSNybble of data from parallel port
        data_x(7 downto 4)   <= d;
        download_state_x     <= load_d0;  -- go to next state
        status               <= "1000";  -- output state on status pins
        s                    <= "1000010";  -- indicate current state on LEDs
      when load_d0  =>
        -- initiate a write to the RAM in the second half of the cycle when
        -- the final nybble of data is setup
        slow_wr              <= not bufslowclk;
        -- increment the address register for the next write operation.
        -- the new address is not output until the next cycle.
        addr_x               <= addr_r + 1;
        -- return to the previous state for another RAM write operation.
        -- use the reset input to break out of the four-state cycle.
        download_state_x     <= load_d12;  -- go to next state
        status               <= "1001";  -- output state on status pins
        s                    <= "1000100";  -- indicate current state on LEDs
      when others   =>
        -- erroneous state so return to reset state
        download_state_x     <= load_a20;
    end case;
  end process;

  process(reset, bufslowclk)
  begin
    if reset = YES then
      -- asynchronous reset
      download_state_r <= load_a20;        -- reset state machine to start
      data_r           <= (others => LO);  -- clear data register
      -- DO NOT CLEAR THE ADDRESS REGISTER!!  We use the reset signal
      -- during RAM upload operations to reset the state machine, but
      -- we need to retain the RAM address for the read operation.
    elsif rising_edge(bufslowclk) then
      -- update registers on the rising clock edge
      download_state_r <= download_state_x;
      addr_r           <= addr_x;
      data_r           <= data_x;
    end if;
  end process;

  process(bufslowclk)
  begin
    -- update the address presented to the RAM on the falling clock
    -- edge.  This keeps the address change away from the rising clock
    -- edge when the read and write signals go active, so there is no chance of
    -- a race condition.
    if falling_edge(bufslowclk) then
      hAddr_r <= hAddr_x;
    end if;
  end process;

  -- Sync the read and write controls from the state machine to the SDRAM clock.
  -- Activate SDRAM read or write on the rising edge of the sync'ed
  -- read or write signal and keep the signal active until the RAM acknowledges.
  process(clk1x)
  begin
    if rising_edge(clk1x) then
      rd_edge     <= slow_rd & rd_edge(rd_edge'high downto 1);
      rd_i        <= (rd_edge(1) and not rd_edge(0)) or (rd_i and not earlyOpBegun);
      wr_edge     <= slow_wr & wr_edge(wr_edge'high downto 1);
      wr_i        <= (wr_edge(1) and not wr_edge(0)) or (wr_i and not earlyOpBegun);
      -- update data input from SDRAM when acknowledgement comes
      if(done = HI and slow_rd = HI) then
        data_in_r <= hDout;
      end if;
    end if;
  end process;
  rd              <= rd_i;
  wr              <= wr_i;

end architecture;
