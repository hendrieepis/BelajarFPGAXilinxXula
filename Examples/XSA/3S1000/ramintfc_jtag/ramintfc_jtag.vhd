----------------------------------------------------------------------------------
-- Company: XESS Corp.
-- Engineer: Dave Vanden Bout
-- 
-- Create Date: 12:36:00 06/10/2006 
-- Copyright: 2006, XESS Corp
-- Design Name: ramintfc_jtag
-- Module Name: ramintfc_jtag - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: WebPACK 6.3i
-- Description: SDRAM/RAM upload/download via JTAG.
--   See userinstr_jtag.vhd for details of operation.
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
use work.common.all;
use work.userinstr_jtag_pckg.all;
use work.xsasdram.all;

library UNISIM;
use UNISIM.VComponents.all;


entity ramintfc_jtag is
  generic(
    FREQ        :       natural := 100_000;  -- clock frequency in KHz
    DATA_WIDTH  :       natural := 16;       -- width of data
    HADDR_WIDTH :       natural := 32;       -- host-side address width
    SADDR_WIDTH :       natural := 13;       -- SDRAM address bus width
    NROWS       :       natural := 8192;     -- number of rows in each SDRAM bank
    NCOLS       :       natural := 512       -- number of words in each row
    );
  port(
    ce_n        : out   std_logic;      -- Flash RAM chip-enable
    clkin       : in    std_logic;      -- main clock input
    clkfb       : in    std_logic;      -- feedback clock mirrors SDRAM clock
    clkout      : out   std_logic;      -- clock to SDRAM
    cke         : out   std_logic;      -- SDRAM clock-enable
    cs_n        : out   std_logic;      -- SDRAM chip-select
    ras_n       : out   std_logic;      -- SDRAM RAS
    cas_n       : out   std_logic;      -- SDRAM CAS
    we_n        : out   std_logic;      -- SDRAM write-enable
    ba          : out   std_logic_vector( 1 downto 0);  -- SDRAM bank-address
    sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
    sData       : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
    dqmh        : out   std_logic;      -- SDRAM DQMH
    dqml        : out   std_logic;      -- SDRAM DQML
    led_dp      : out   std_logic;      -- 7-segment LED decimal-point
    s           : out   std_logic_vector(6 downto 0)  -- 7-segment LED segments
    );
end entity;


architecture arch of ramintfc_jtag is

  -- counter that generates the initial reset for the SDRAM controller
  constant RESET_DLY  : natural := 10;
  signal rst_cntr     : natural range 0 to 15 := 0;
  
  -- signals to/from the JTAG BSCAN module
  signal bscan_drck   : std_logic; -- JTAG clock from BSCAN module
  signal bscan_reset  : std_logic; -- true when BSCAN module is reset
  signal bscan_sel    : std_logic; -- true when BSCAN module selected
  signal bscan_shift  : std_logic; -- true when TDI & TDO are shifting data
  signal bscan_update : std_logic; -- BSCAN TAP is in update-dr state
  signal bscan_tdi    : std_logic; -- data received on TDI pin
  signal bscan_tdo    : std_logic; -- scan data sent to TDO pin
  
  -- signals to/from the SDRAM controller
  signal sdram_reset  : std_logic; -- reset to SDRAM controller
  signal clk1x        : std_logic; -- main DLL clock generated from clkin
  signal bufclk       : std_logic; -- buffered version of clkin
  signal hrd          : std_logic; -- host read enable
  signal hwr          : std_logic; -- host write enable
  signal earlyOpBegun : std_logic; -- true when current read/write has begun
  signal done         : std_logic; -- true when current read/write is done
  signal hAddr        : std_logic_vector(HADDR_WIDTH-1 downto 0); -- host address
  signal hDin         : std_logic_vector(DATA_WIDTH-1 downto 0); -- data input from host
  signal hDOut        : std_logic_vector(DATA_WIDTH-1 downto 0); -- host data output to host
  
begin

  ce_n <= '1';                -- disable Flash RAM

  -- generate a reset signal for the SDRAM controller  
  process(bufclk) -- use buffered clock because DLL might not have locked
  begin
    if rising_edge(bufclk) then
      if rst_cntr < RESET_DLY then
        sdram_reset <= YES;
        rst_cntr <= rst_cntr + 1;
      else
        sdram_reset <= NO;
      end if;
    end if;
  end process;

  -- boundary-scan interface to FPGA JTAG port
  u_bscan : BSCAN_SPARTAN3
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
      
  led_dp <= bscan_sel;        -- light LED decimal-point when BSCAN receives USER1 instr
  
  -- JTAG interface
  u1: userinstr_jtag
    generic map(
      FPGA_TYPE        => SPARTAN3,
      ENABLE_RAM_INTFC => true,
      DATA_WIDTH       => DATA_WIDTH,
      ADDR_WIDTH       => HADDR_WIDTH
      )
    port map(
      clk          => clk1x,
      bscan_drck   => bscan_drck,
      bscan_reset  => bscan_reset,
      bscan_sel    => bscan_sel,
      bscan_shift  => bscan_shift,
      bscan_update => bscan_update,
      bscan_tdi    => bscan_tdi,
      bscan_tdo    => bscan_tdo,
      rd           => hrd,
      wr           => hwr,
      begun        => earlyOpBegun,
      done         => done,
      addr         => hAddr,
      din          => hDOut,
      dout         => hDIn,
      s            => s,
      test_progress => "11",
      test_failed   => NO
      );

  -- SDRAM controller
  u2 : xsaSDRAMCntl
    generic map(
      FREQ         => FREQ,
      PIPE_EN      => false,
      DATA_WIDTH   => DATA_WIDTH,
      NROWS        => NROWS,
      NCOLS        => NCOLS,
      HADDR_WIDTH  => HADDR_WIDTH,
      SADDR_WIDTH  => SADDR_WIDTH
      )
    port map(
      clk          => clkin,
      bufclk       => bufclk,
      clk1x        => clk1x,
      clk2x        => open,
      lock         => open,
      rst          => sdram_reset,
      rd           => hrd,
      wr           => hwr,
      rdPending    => open,
      opBegun      => open,
      earlyOpBegun => earlyOpBegun,
      rdDone       => open,
      done         => done,
      hAddr        => hAddr,
      hDIn         => hDIn,
      hDOut        => hDOut,
      status       => open,
      sclkfb       => clkfb,
      sclk         => clkout,
      cke          => cke,
      cs_n         => cs_n,
      ras_n        => ras_n,
      cas_n        => cas_n,
      we_n         => we_n,
      ba           => ba,
      sAddr        => sAddr,
      sData        => sData,
      dqmh         => dqmh,
      dqml         => dqml
      );

end architecture;
