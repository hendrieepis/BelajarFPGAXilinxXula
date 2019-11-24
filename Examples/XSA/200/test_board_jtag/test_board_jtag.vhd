----------------------------------------------------------------------------------
-- Company: XESS Corp.
-- Engineer: Dave Vanden Bout
-- 
-- Create Date: 12:36:00 05/05/2006 
-- Copyright: 2006, XESS Corp
-- Design Name: test_board_jtag
-- Module Name: test_board_jtag - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions:  WebPACK 6.3i
-- Description: Test board via JTAG.
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
use work.test_board_core_pckg.all;

library UNISIM;
use UNISIM.VComponents.all;


entity test_board_jtag is
  generic(
    FREQ        :       natural := 100_000;  -- clock frequency in KHz
    DATA_WIDTH  :       natural := 16;       -- width of data
    HADDR_WIDTH :       natural := 32;       -- host-side address width
    SADDR_WIDTH :       natural := 13;       -- SDRAM address bus width
    NROWS       :       natural := 8192;     -- number of rows in each SDRAM bank
    NCOLS       :       natural := 512;      -- number of words in each row
    -- beginning and ending addresses for the entire SDRAM
    BEG_ADDR    :       natural := 16#00_0000#;
    END_ADDR    :       natural := 16#FF_FFFF#;
    -- beginning and ending address for the memory tester
    BEG_TEST    :       natural := 16#00_0000#;
    END_TEST    :       natural := 16#FF_FFFF#
    );
  port(
    ce_n   : out   std_logic;           -- Flash RAM chip-enable
    sw2    : in    std_logic;           -- active-low pushbutton input
    clk    : in    std_logic;           -- main clock input from external clock source
    sclkfb : in    std_logic;           -- feedback SDRAM clock with PCB delays
    sclk   : out   std_logic;           -- clock to SDRAM
    cke    : out   std_logic;           -- SDRAM clock-enable
    cs_n   : out   std_logic;           -- SDRAM chip-select
    ras_n  : out   std_logic;           -- SDRAM RAS
    cas_n  : out   std_logic;           -- SDRAM CAS
    we_n   : out   std_logic;           -- SDRAM write-enable
    ba     : out   std_logic_vector( 1 downto 0);  -- SDRAM bank-address
    sAddr  : out   std_logic_vector(12 downto 0);  -- SDRAM address bus
    sData  : inout std_logic_vector(15 downto 0);  -- data bus to/from SDRAM
    dqmh   : out   std_logic;           -- SDRAM DQMH
    dqml   : out   std_logic;           -- SDRAM DQML
    led_dp : out   std_logic;           -- 7-segment LED decimal-point
    s      : out   std_logic_vector(6 downto 0)  -- 7-segment LED segments
    );
end test_board_jtag;


architecture Behavioral of test_board_jtag is
  
  -- signals to/from the JTAG BSCAN module
  signal bscan_drck    : std_logic; -- JTAG clock from BSCAN module
  signal bscan_reset   : std_logic; -- true when BSCAN module is reset
  signal bscan_sel     : std_logic; -- true when BSCAN module selected
  signal bscan_shift   : std_logic; -- true when TDI & TDO are shifting data
  signal bscan_update  : std_logic; -- BSCAN TAP is in update-dr state
  signal bscan_tdi     : std_logic; -- data received on TDI pin
  signal bscan_tdo     : std_logic; -- scan data sent to TDO pin
  
  signal clk1x         : std_logic;

  signal run_test      : std_logic; -- set to run the test
  signal run           : std_logic; -- run test either from JTAG instr or manual button
  signal test_progress : std_logic_vector(1 downto 0); -- progress of the test
  signal test_failed   : std_logic; -- true if an error was found during the test

begin

  ce_n <= '1';               -- disable Flash RAM

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

  led_dp <= bscan_sel;        -- light the LED decimal-point when the USER1 instruction is received
  
  -- JTAG interface
  u1: userinstr_jtag
    generic map(
      FPGA_TYPE         => SPARTAN2,
      ENABLE_TEST_INTFC => true,
      DATA_WIDTH        => DATA_WIDTH
      )
    port map(
      clk           => clk1x,
      bscan_drck    => bscan_drck,
      bscan_reset   => bscan_reset,
      bscan_sel     => bscan_sel,
      bscan_shift   => bscan_shift,
      bscan_update  => bscan_update,
      bscan_tdi     => bscan_tdi,
      bscan_tdo     => bscan_tdo,
      begun         => YES, -- don't care
      done          => YES, -- don't care
      din           => "0000000000000000", -- don't care
      run_test      => run_test,
      test_progress => test_progress,
      test_failed   => test_failed
      );

  run <= run_test and sw2; -- run test when instruction is given or button is pressed

  -- board diagnostic unit
  u0 : test_board_core
    generic map(
      FREQ        => FREQ,
      PIPE_EN     => true,
      DATA_WIDTH  => DATA_WIDTH,
      SADDR_WIDTH => SADDR_WIDTH,
      NROWS       => NROWS,
      NCOLS       => NCOLS,
      BEG_ADDR    => BEG_ADDR,
      END_ADDR    => END_ADDR,
      BEG_TEST    => BEG_TEST,
      END_TEST    => END_TEST
      )
    port map(
      button_n    => run,
      clk         => clk,
      clk1x       => clk1x,
      sclkfb      => sclkfb,
      sclk        => sclk,
      cke         => cke,
      cs_n        => cs_n,
      ras_n       => ras_n,
      cas_n       => cas_n,
      we_n        => we_n,
      ba          => ba,
      sAddr       => sAddr,
      sData       => sData,
      dqmh        => dqmh,
      dqml        => dqml,
      led         => s,
      heartBeat   => open,
      progress    => test_progress,
      err         => test_failed
      );

end Behavioral;

