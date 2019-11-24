----------------------------------------------------------------------------------
-- Company: XESS Corp.
-- Engineer: Dave Vanden Bout
-- 
-- Create Date: 08:08:00 05/04/2007 
-- Copyright: 2007, XESS Corp
-- Design Name: fintf_jtag
-- Module Name: fintf_jtag - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: WebPACK 6.3i
-- Description: Flash controller.
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.common.all;


package flashcntl_pckg is

  -- types of Flash chips
  constant SPANSION_29 : natural := 1;
  constant ATMEL_49    : natural := 2;

  component flashcntl
    generic(
      FPGA_TYPE   : natural := SPARTAN3; -- type of FPGA
      FLASH_TYPE  : natural := SPANSION_29;  -- type of Flash chip
      FREQ        : natural := 100_000;  -- clock frequency in KHz
      TSU         : natural := 35;       -- setup time for Flash chip (ns)
      TRD         : natural := 65;       -- read pulse duration. TSU + TRD = 100 ns
      TWR         : natural := 35;       -- write pulse duration (ns)
      THO         : natural := 45;       -- hold time for Flash chip (ns)
      DATA_WIDTH  : natural := 8;        -- data width of Flash chip
      ADDR_WIDTH  : natural := 21;       -- address width of Flash chip
      BLOCK_SIZE  : natural := 2048;     -- size of RAM block that buffers data programmed into Flash
      ERASED      : std_logic_vector(DATA_WIDTH-1 downto 0) := x"FF" -- erased value for Flash
      );
    port(
      reset       : in    std_logic;      -- reset input
      clkin       : in    std_logic;      -- main clock input
      h_rd        : in    std_logic;      -- read enable
      h_wr        : in    std_logic;      -- port A write enable
      h_erase     : in    std_logic;      -- flash chip erase enable
      h_blk_pgm   : in    std_logic;      -- block program enable
      h_addr      : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- address for read/write
      h_di        : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- data from JTAG instr. unit
      h_do        : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- data output from flash
      h_begun     : out   std_logic;      -- true when flash operation begun
      h_busy      : out   std_logic;      -- true when operation in progress
      h_done      : out   std_logic;      -- true when flash operation done
      f_byte_n    : out   std_logic;      -- Flash byte-wide/word-wide select
      f_ce_n      : out   std_logic;      -- Flash chip-enable
      f_we_n      : out   std_logic;      -- Flash write-enable
      f_oe_n      : out   std_logic;      -- Flash output-enable
      f_addr      : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Flash address bus
      f_data      : inout std_logic_vector(DATA_WIDTH-1 downto 0)  -- data bus to/from Flash
      );
  end component;
end package;



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.common.all;
use WORK.flashcntl_pckg.all;
use WORK.rwcntl_pckg.all;

library UNISIM;
use UNISIM.VComponents.all;


entity flashcntl is
  generic(
    FPGA_TYPE   : natural := SPARTAN3; -- type of FPGA
    FLASH_TYPE  : natural := SPANSION_29;  -- type of Flash chip
    FREQ        : natural := 100_000;  -- clock frequency in KHz
    TSU         : natural := 35;       -- setup time for Flash chip (ns)
    TRD         : natural := 65;       -- read pulse duration. TSU + TRD = 100 ns
    TWR         : natural := 35;       -- write pulse duration (ns)
    THO         : natural := 45;       -- hold time for Flash chip (ns)
    DATA_WIDTH  : natural := 8;        -- data width of Flash chip
    ADDR_WIDTH  : natural := 21;       -- address width of Flash chip
    BLOCK_SIZE  : natural := 2048;     -- size of RAM block that buffers data programmed into Flash
    ERASED      : std_logic_vector(DATA_WIDTH-1 downto 0) := x"FF" -- erased value for Flash
    );
  port(
    reset       : in    std_logic;      -- reset input
    clkin       : in    std_logic;      -- main clock input
    h_rd        : in    std_logic;      -- read enable
    h_wr        : in    std_logic;      -- port A write enable
    h_erase     : in    std_logic;      -- flash chip erase enable
    h_blk_pgm   : in    std_logic;      -- block program enable
    h_addr      : in    std_logic_vector(ADDR_WIDTH-1 downto 0); -- address for read/write
    h_di        : in    std_logic_vector(DATA_WIDTH-1 downto 0); -- data from JTAG instr. unit
    h_do        : out   std_logic_vector(DATA_WIDTH-1 downto 0); -- data output from flash
    h_begun     : out   std_logic;      -- true when flash operation begun
    h_busy      : out   std_logic;      -- true when operation in progress
    h_done      : out   std_logic;      -- true when flash operation done
    f_byte_n    : out   std_logic;      -- Flash byte-wide/word-wide select
    f_ce_n      : out   std_logic;      -- Flash chip-enable
    f_we_n      : out   std_logic;      -- Flash write-enable
    f_oe_n      : out   std_logic;      -- Flash output-enable
    f_addr      : out   std_logic_vector(ADDR_WIDTH-1 downto 0); -- Flash address bus
    f_data      : inout std_logic_vector(DATA_WIDTH-1 downto 0)  -- data bus to/from Flash
    );
end entity;


architecture arch of flashcntl is
  
  -- States of the Flash controller FSM.
  type cntlState is (
    RAM_BLK_INIT,     -- initializing block RAM to erased value of Flash
    FLASH_NOP,        -- no operation
    FLASH_ERASE,      -- erasing entire Flash chip
    FLASH_ERASE_2,FLASH_ERASE_3,FLASH_ERASE_4,FLASH_ERASE_5,FLASH_ERASE_6,FLASH_ERASE_7,
    FLASH_WRITE,      -- writing to Flash (this is a subroutine)
    FLASH_BLK_PGM,    -- programming block ram into Flash
    FLASH_BLK_PGM_2,FLASH_BLK_PGM_3,FLASH_BLK_PGM_4,FLASH_BLK_PGM_5,FLASH_BLK_PGM_6,
    FLASH_READ        -- reading from Flash
    );
  signal flash_state     : cntlState;       -- FSM state register
  signal rtn_flash_state : cntlState;       -- return-to state for FSM subroutines
    
  -- Signals to/from dualport block RAM to FSM.
  constant BLOCK_ADDR_WIDTH : natural := log2(BLOCK_SIZE);
  signal blk_addr_b   : std_logic_vector(BLOCK_ADDR_WIDTH-1 downto 0); -- port B address
  signal blk_di_b     : std_logic_vector(DATA_WIDTH-1 downto 0); -- port B data input
  signal blk_do_b     : std_logic_vector(DATA_WIDTH-1 downto 0); -- port B data output
  signal blk_en_b     : std_logic; -- port B enable
  signal blk_we_b     : std_logic; -- port B write enable
  
  -- Signals to/from external memory R/W controller that obeys Flash timing parameters.
  signal rw_addr      : std_logic_vector(ADDR_WIDTH-1 downto 0); -- ext. mem. address
  signal rw_di        : std_logic_vector(DATA_WIDTH-1 downto 0); -- data input to ext. mem.
  signal rw_do        : std_logic_vector(DATA_WIDTH-1 downto 0); -- data output from ext. mem.
  signal rw_wr        : std_logic; -- write enable
  signal rw_rd        : std_logic; -- read enable
  signal rw_begun     : std_logic; -- true when read/write has begun
  signal rw_busy      : std_logic; -- true when read/write is in-progress
  signal rw_done      : std_logic; -- true when read/write is done
  
  signal erase_cmd_addr1,
         erase_cmd_addr2,
         erase_cmd_addr3,
         erase_cmd_addr4,
         erase_cmd_addr5,
         erase_cmd_addr6,
         pgm_cmd_addr1,
         pgm_cmd_addr2,
         pgm_cmd_addr3    : std_logic_vector(15 downto 0);
  signal erase_cmd_data1,
         erase_cmd_data2,
         erase_cmd_data3,
         erase_cmd_data4,
         erase_cmd_data5,
         erase_cmd_data6,
         pgm_cmd_data1,
         pgm_cmd_data2,
         pgm_cmd_data3    : std_logic_vector(7 downto 0);

begin

  -- The dual-port block RAM buffers data that is to be written to the Flash.
  -- Port A is written with data, while port B is used to read the data and program it into the Flash.
  blk_ram_s3: if FPGA_TYPE = SPARTAN3 generate
    blk_ram : RAMB16_S9_S9
      port map (
        SSRA  => reset, 
        CLKA  => clkin,
        ADDRA => h_addr(BLOCK_ADDR_WIDTH-1 downto 0), -- lower portion of Flash address is used to address block RAM
        DIA   => h_di, -- data word received from the PC through the JTAG interface
        DIPA  => "0",      -- parity input (not used)  
        DOA   => open,     -- output databus (not used)   
        ENA   => h_wr, -- enable port A   
        WEA   => h_wr, -- write-enable for port A
        SSRB  => reset,
        CLKB  => clkin,
        ADDRB => blk_addr_b,
        DIB   => blk_di_b, -- input databus is set to erased Flash value for block RAM initialization     
        DIPB  => "0",      -- parity input (not used)   
        DOB   => blk_do_b, -- output databus goes to Flash input databus
        ENB   => blk_en_b, -- enable port B
        WEB   => blk_we_b  -- write-enable port B
      );
  end generate;
  blk_ram_s2: if FPGA_TYPE = SPARTAN2 or FPGA_TYPE = SPARTAN2E generate
    blk_ram : RAMB4_S8_S8
      port map (
        RSTA => reset, 
        CLKA => clkin,
        ADDRA => h_addr(BLOCK_ADDR_WIDTH-1 downto 0), -- lower portion of Flash address is used to address block RAM
        DIA => h_di, -- data word received from the PC through the JTAG interface
        DOA => open,     -- output databus (not used)   
        ENA => h_wr, -- enable port A   
        WEA => h_wr, -- write-enable for port A
        RSTB => reset,
        CLKB => clkin,
        ADDRB => blk_addr_b,
        DIB => blk_di_b, -- input databus is set to erased Flash value for block RAM initialization     
        DOB => blk_do_b, -- output databus goes to Flash input databus
        ENB => blk_en_b, -- enable port B
        WEB => blk_we_b  -- write-enable port B
      );
  end generate;

  
  -- This FSM performs the sequences of write/reads to the Flash chip that will
  -- erase/program/read the Flash contents.
  process(reset,clkin)
  begin

  case FLASH_TYPE is
      when ATMEL_49    =>
        erase_cmd_addr1 <= x"5555";
        erase_cmd_data1 <= x"AA";
        erase_cmd_addr2 <= x"2AAA";
        erase_cmd_data2 <= x"55";
        erase_cmd_addr3 <= x"5555";
        erase_cmd_data3 <= x"80";
        erase_cmd_addr4 <= x"5555";
        erase_cmd_data4 <= x"AA";
        erase_cmd_addr5 <= x"2AAA";
        erase_cmd_data5 <= x"55";
        erase_cmd_addr6 <= x"5555";
        erase_cmd_data6 <= x"10";
        pgm_cmd_addr1   <= x"5555";
        pgm_cmd_data1   <= x"AA";
        pgm_cmd_addr2   <= x"2AAA";
        pgm_cmd_data2   <= x"55";
        pgm_cmd_addr3   <= x"5555";
        pgm_cmd_data3   <= x"A0";
      when others =>  -- SPANSION_29
        erase_cmd_addr1 <= x"0AAA";
        erase_cmd_data1 <= x"AA";
        erase_cmd_addr2 <= x"0555";
        erase_cmd_data2 <= x"55";
        erase_cmd_addr3 <= x"0AAA";
        erase_cmd_data3 <= x"80";
        erase_cmd_addr4 <= x"0AAA";
        erase_cmd_data4 <= x"AA";
        erase_cmd_addr5 <= x"0555";
        erase_cmd_data5 <= x"55";
        erase_cmd_addr6 <= x"0AAA";
        erase_cmd_data6 <= x"10";
        pgm_cmd_addr1   <= x"0AAA";
        pgm_cmd_data1   <= x"AA";
        pgm_cmd_addr2   <= x"0555";
        pgm_cmd_data2   <= x"55";
        pgm_cmd_addr3   <= x"0AAA";
        pgm_cmd_data3   <= x"A0";
    end case;
    
    if reset = YES then
      -- don't do anything when reset
      blk_addr_b      <= (others=>'0'); -- starting block RAM address for initialization that follows
      blk_en_b        <= NO;
      blk_we_b        <= NO;
      rw_wr           <= NO;
      rw_rd           <= NO;
      h_begun         <= NO;
      h_busy          <= NO;
      h_done          <= NO;
      flash_state     <= RAM_BLK_INIT; -- starting state after reset
      rtn_flash_state <= FLASH_NOP;
      
    elsif rising_edge(clkin) then
      case flash_state is
      
        -- Initialize the block RAM with the value stored in an erased Flash location.
        -- This means the block RAM can be partially filled and then programmed into Flash
        -- and the unused Flash locations will be left in their erased state.
        when RAM_BLK_INIT =>
          blk_en_b <= YES;
          blk_we_b <= YES;
          blk_di_b <= ERASED;
          blk_addr_b <= blk_addr_b + 1; -- progress through the RAM block
          -- End initialization when address is BLOCK_SIZE-1.
          -- One more write to location BLOCK_SIZE will occur after this.
          -- Since the address will rollover, the actual write occurs to location 0
          -- so the entire block RAM gets initialized to the erase value.
          if blk_addr_b = BLOCK_SIZE-1 then
            flash_state <= FLASH_NOP;
          end if;
          
        -- Wait for a Flash erase, program or read operation to arrive.  
        when FLASH_NOP =>
          blk_addr_b <= (others=>'0'); -- set address to zero in case Flash programming is initiated
          blk_en_b <= NO;    -- disable block RAM until it is needed
          blk_we_b <= NO;    -- disable writes to block RAM after initialization is done
          rw_wr <= NO;       -- no writing to external Flash during NOP state
          rw_rd <= NO;       -- no reading of external Flash during NOP state
          h_done <= NO;      -- remove the done signal that was asserted when the previous operation finished
          if h_erase = YES then
            h_begun <= YES;  -- erase operation has begun
            h_busy <= YES;   -- busy doing erase operation
            flash_state <= FLASH_ERASE; -- go to states where Flash erasure occurs
          elsif h_blk_pgm = YES then
            h_begun <= YES;  -- Flash programming operation has begun
            h_busy <= YES;   -- busy programming Flash
            flash_state <= FLASH_BLK_PGM; -- go to states where Flash programming occurs
          elsif h_rd = YES then
            h_begun <= YES;  -- reading from Flash has begun
            h_busy <= YES;   -- busy reading from Flash
            rw_addr <= h_addr; -- send the address to read from to the external Flash interface
            flash_state <= FLASH_READ; -- go to the states where Flash reading occurs
          else
            h_begun <= NO;   -- no operation has been initiated
            h_busy <= NO;    -- no operation is in-progress
          end if;
          
        -- Erase the entire Flash chip.  This requires a series of writes to specific addresses
        -- and then reading from the Flash until databus bit 7 is high, indicating the chip is erased.
        when FLASH_ERASE =>
          h_begun <= NO; -- remove the begun signal after one cycle
          rw_addr <= (others=>'0');
          rw_addr(erase_cmd_addr1'range) <= erase_cmd_addr1;
          rw_di <= erase_cmd_data1;
          flash_state <= FLASH_WRITE; -- subroutine to write to the Flash address
          rtn_flash_state <= FLASH_ERASE_2; -- go to the next state after the write is done
        when FLASH_ERASE_2 =>
          rw_addr(erase_cmd_addr2'range) <= erase_cmd_addr2;
          rw_di <= erase_cmd_data2;
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_ERASE_3;
        when FLASH_ERASE_3 =>
          rw_addr(erase_cmd_addr3'range) <= erase_cmd_addr3;
          rw_di <= erase_cmd_data3;
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_ERASE_4;
        when FLASH_ERASE_4 =>
          rw_addr(erase_cmd_addr4'range) <= erase_cmd_addr4;
          rw_di <= erase_cmd_data4;
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_ERASE_5;
        when FLASH_ERASE_5 =>
          rw_addr(erase_cmd_addr5'range) <= erase_cmd_addr5;
          rw_di <= erase_cmd_data5;
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_ERASE_6;
        when FLASH_ERASE_6 =>
          -- the actual chip erase starts after this write operation
          rw_addr(erase_cmd_addr6'range) <= erase_cmd_addr6;
          rw_di <= erase_cmd_data6;
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_ERASE_7;
        when FLASH_ERASE_7 =>
          -- now wait for the chip erase to complete
          rw_rd <= not(rw_busy); -- read any Flash location when the external Flash interface is not busy
          -- the erase is done if bit 7 of the value read from Flash is high
          if rw_done = YES and rw_do(7) = '1' then
            h_done <= YES; -- indicate that the erase is done
            flash_state <= FLASH_NOP; -- go wait for something else to do
          end if;

        -- Program the contents of the block RAM into the Flash.
        -- (It's necessary that the block RAM address counter is set to 0 before entering.)        
        -- This requires a series of writes to specific addresses and then writing the data to the
        -- Flash address.  Then the address is read until databus bit 7 matches the data that was written,
        -- indicating the programming was successful.
        when FLASH_BLK_PGM =>
          h_begun <= NO; -- remove the begun signal after one cycle
          blk_en_b <= YES; -- enable the block RAM in order to read its contents
          flash_state <= FLASH_BLK_PGM_2;
        when FLASH_BLK_PGM_2 =>
          rw_addr <= (others=>'0');
          rw_addr(pgm_cmd_addr1'range) <= pgm_cmd_addr1;
          rw_di <= pgm_cmd_data1;
          flash_state <= FLASH_WRITE; -- subroutine to write to the Flash address
          rtn_flash_state <= FLASH_BLK_PGM_3; -- go to the next state after the write is done
        when FLASH_BLK_PGM_3 =>
          -- write operation: (0x555) <= 0x55
          rw_addr(pgm_cmd_addr2'range) <= pgm_cmd_addr2;
          rw_di <= pgm_cmd_data2;
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_BLK_PGM_4;
        when FLASH_BLK_PGM_4 =>
          -- write operation: (0xAAA) <= 0xA0
          rw_addr(pgm_cmd_addr3'range) <= pgm_cmd_addr3;
          rw_di <= pgm_cmd_data3;
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_BLK_PGM_5;
        when FLASH_BLK_PGM_5 =>
          -- The actual programming of the Flash location occurs here.
          -- The Flash address is formed from the concatenation of the upper bits of
          -- the starting address received by the JTAG instruction execution unit with
          -- the lower bits coming from the block RAM address.          
          rw_addr <= h_addr(h_addr'high downto blk_addr_b'high+1) & blk_addr_b;
          rw_di <= blk_do_b; -- send the data from the block RAM to the Flash chip
          flash_state <= FLASH_WRITE;
          rtn_flash_state <= FLASH_BLK_PGM_6;
        when FLASH_BLK_PGM_6 =>
          -- now wait for the Flash location to complete its programming
          rw_rd <= not(rw_busy); -- read the Flash location when the external Flash interface is not busy
          -- the programming is done if bit 7 of the value read from Flash is the same as the value written to Flash
          if rw_done = YES and rw_do(7) = rw_di(7) then
            blk_addr_b <= blk_addr_b + 1;-- increment the address to block RAM and the Flash
            if blk_addr_b = BLOCK_SIZE-1 then
              -- exit once all the block RAM data is programmed into the Flash
              h_done <= YES; -- indicate that the programming is done
              flash_state <= RAM_BLK_INIT; -- initialize the block RAM to the erased state and return to the NOP state
            else
              -- otherwise, keep programming the Flash
              flash_state <= FLASH_BLK_PGM;
            end if;
          end if;
          
        -- Read the value from the Flash address registered during the NOP state.
        when FLASH_READ =>
          h_begun <= NO; -- remove the begun signal after one cycle
          rw_rd <= not(rw_busy); -- read the Flash location when the external Flash interface is not busy
          -- once the data from Flash is available, return it back to the JTAG interface
          if rw_done = YES then
            h_do <= rw_do; -- register the data read from the Flash
            h_done <= YES; -- indicate that the read operation is done
            flash_state <= FLASH_NOP; -- go wait for something else to do
          end if;
          
        -- This is an FSM subroutine that writes a data value to Flash
        when FLASH_WRITE =>
          rw_wr <= not(rw_busy); -- write to the Flash location when the external Flash interface is not busy
          -- return to the main line of execution in the FSM when the Flash interface is done writing to the Flash
          if rw_done = YES then
            flash_state <= rtn_flash_state;
          end if;
          
        when others =>
          null;
      end case;
    end if;
  end process;


  f_ce_n   <= '0'; -- enable Flash
  f_byte_n <= '0'; -- use Flash in byte-wide mode (not word-wide)

  -- external memory R/W controller that obeys Flash timing parameters
  u_flash: rwcntl
    generic map(
      FREQ       => FREQ,
      TSU        => TSU,
      TRD        => TRD,
      TWR        => TWR,
      THO        => THO,
      DATA_WIDTH => DATA_WIDTH,
      ADDR_WIDTH => ADDR_WIDTH
      )
    port map(
      rst    => reset,
      clk    => clkin,
      rd     => rw_rd,
      wr     => rw_wr,
      begun  => rw_begun,
      busy   => rw_busy,
      done   => rw_done,
      hAddr  => rw_addr,
      hDIn   => rw_di,
      hDOut  => rw_do,
      status => open,        
      rAddr  => f_addr,
      rData  => f_data,
      oe_n   => f_oe_n,
      we_n   => f_we_n
      );

end architecture;