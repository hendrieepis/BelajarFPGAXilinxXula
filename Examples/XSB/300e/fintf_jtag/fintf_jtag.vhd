----------------------------------------------------------------------------------
-- Company: XESS Corp.
-- Engineer: Dave Vanden Bout
-- 
-- Create Date: 12:36:00 06/10/2006 
-- Copyright: 2006, XESS Corp
-- Design Name: fintf_jtag
-- Module Name: fintf_jtag - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: WebPACK 6.3i
-- Description: Flash upload/download via JTAG.
--   See userinstr_jtag.vhd and flashcntl.vhd for details of operation.
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.common.all;
use WORK.userinstr_jtag_pckg.all;
use WORK.flashcntl_pckg.all;
use WORK.rwcntl_pckg.all;

library UNISIM;
use UNISIM.VComponents.all;

entity fintf_jtag is
  generic(
    FREQ        : natural := 67_000;   -- clock frequency in KHz
    TSU         : natural := 0;        -- setup time for Flash chip (ns)
    TRD         : natural := 120;      -- read pulse duration. TSU + TRD = 100 ns
    TWR         : natural := 90;       -- write pulse duration (ns)
    THO         : natural := 0;        -- hold time for Flash chip (ns)
    DATA_WIDTH  : natural := 8;        -- data width of Flash chip
    ADDR_WIDTH  : natural := 19;       -- address width of Flash chip
    BLOCK_SIZE  : natural := 512;      -- size of RAM block that buffers data programmed into Flash
    ERASED      : std_logic_vector(DATA_WIDTH-1 downto 0) := x"FF" -- erased value for Flash
    );
  port(
    fpga_init_n : out   std_logic;     -- CPLD interface chip-select
    clkin       : in    std_logic;     -- main clock input
    pb_d        : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- RAM data
    pb_a        : inout std_logic_vector(ADDR_WIDTH-1 downto 0); -- RAM address
    pb_oe_n     : out   std_logic;     -- PBus output-enable
    pb_we_n     : out   std_logic;     -- PBus write-enable
    flash_ce_n  : out   std_logic      -- chip-enable for XSB FLASH
    );
end entity;


architecture arch of fintf_jtag is

  constant BLOCK_ADDR_WIDTH : natural := log2(BLOCK_SIZE); -- addr width of block RAM

  -- Counter that generates the initial reset.
  constant RESET_DLY  : natural := 10;
  signal reset_cntr   : natural range 0 to 15 := 0;
  signal reset        : std_logic;
  
  -- signals to/from the JTAG BSCAN module
  signal bscan_drck   : std_logic; -- JTAG clock from BSCAN module
  signal bscan_reset  : std_logic; -- true when BSCAN module is reset
  signal bscan_sel    : std_logic; -- true when BSCAN module selected
  signal bscan_shift  : std_logic; -- true when TDI & TDO are shifting data
  signal bscan_update : std_logic; -- BSCAN TAP is in update-dr state
  signal bscan_tdi    : std_logic; -- data received on TDI pin
  signal bscan_tdo    : std_logic; -- scan data sent to TDO pin

  -- Signals to/from the FSM that sequences the reads/writes for the Flash operations.
  signal h_rd         : std_logic; -- read enable
  signal h_wr         : std_logic; -- port A write enable
  signal h_erase      : std_logic; -- flash chip erase enable
  signal h_blk_pgm    : std_logic; -- block program enable
  signal h_begun      : std_logic; -- true when flash operation begun
  signal begun        : std_logic; -- true when flash or block RAM operation has begun
  signal h_busy       : std_logic; -- true when operation in progress
  signal h_done       : std_logic; -- true when flash operation done
  signal done         : std_logic; -- true when flash or block RAM operation is done
  signal h_di         : std_logic_vector(DATA_WIDTH-1 downto 0); -- data from JTAG instr. unit
  signal h_do         : std_logic_vector(DATA_WIDTH-1 downto 0); -- data output from flash
  signal h_addr       : std_logic_vector(ADDR_WIDTH-1 downto 0); -- address for read/write

begin

  fpga_init_n <= '1';        -- disable CPLD interface

  -- Generate a reset signal for everything.  
  process(clkin)
  begin
    if rising_edge(clkin) then
      reset <= NO;
      if reset_cntr < RESET_DLY then
        reset <= YES;
        reset_cntr <= reset_cntr + 1;
      end if;
    end if;
  end process;

  -- boundary-scan interface to FPGA JTAG port
  u_bscan : BSCAN_SPARTAN2
    port map(
      DRCK1   => bscan_drck,  -- JTAG clock
      RESET   => bscan_reset, -- true when JTAG TAP FSM is reset
      SEL1    => bscan_sel,   -- USER1 instruction enables execution of the RAM interface
      SHIFT   => bscan_shift, -- true when JTAG TAP FSM is in the SHIFT-DR state
      TDI     => bscan_tdi,   -- data bits from the PC arrive through here
      UPDATE  => bscan_update,
      TDO1    => bscan_tdo,   -- LSbit of the tdo register outputs onto TDO pin and to the PC
      TDO2    => '0'          -- not using this input, so just hold it low
      );
  
  -- JTAG interface
  u1: userinstr_jtag
    generic map(
      FPGA_TYPE          => SPARTAN2E,
      ENABLE_FLASH_INTFC => true,
      DATA_WIDTH         => DATA_WIDTH,
      ADDR_WIDTH         => ADDR_WIDTH,
      BLOCK_ADDR_WIDTH   => BLOCK_ADDR_WIDTH
      )
    port map(
      clk           => clkin,
      bscan_drck    => bscan_drck,
      bscan_reset   => bscan_reset,
      bscan_sel     => bscan_sel,
      bscan_shift   => bscan_shift,
      bscan_update  => bscan_update,
      bscan_tdi     => bscan_tdi,
      bscan_tdo     => bscan_tdo,
      rd            => h_rd,
      wr            => h_wr,
      erase         => h_erase,
      blk_pgm       => h_blk_pgm,
      begun         => begun,
      done          => done,
      addr          => h_addr, 
      din           => h_do,
      dout          => h_di,
      test_progress => "11",
      test_failed   => NO
      );

  done  <= h_wr or h_done;
  begun <= h_wr or h_begun;

  u2: flashcntl
    generic map(
    FPGA_TYPE  => SPARTAN2E,
    FLASH_TYPE => ATMEL_49,    
    FREQ       => FREQ,
    TSU        => TSU,  
    TRD        => TRD,  
    TWR        => TWR,
    THO        => THO,
    DATA_WIDTH => DATA_WIDTH,
    ADDR_WIDTH => ADDR_WIDTH,
    BLOCK_SIZE => BLOCK_SIZE,
    ERASED     => ERASED
    )
  port map(
    reset      => reset, 
    clkin      => clkin,
    h_rd       => h_rd,
    h_wr       => h_wr,
    h_erase    => h_erase,
    h_blk_pgm  => h_blk_pgm,
    h_addr     => h_addr,
    h_di       => h_di,
    h_do       => h_do,
    h_begun    => h_begun,
    h_busy     => h_busy,
    h_done     => h_done,
    f_byte_n   => open,
    f_ce_n     => flash_ce_n,
    f_we_n     => pb_we_n,
    f_oe_n     => pb_oe_n,
    f_addr     => pb_a,
    f_data     => pb_d
    );

end architecture;
