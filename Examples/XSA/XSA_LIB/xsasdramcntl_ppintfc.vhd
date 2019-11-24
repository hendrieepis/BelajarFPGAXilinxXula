--------------------------------------------------------------------
-- Company : XESS Corp.
-- Engineer : Dave Vanden Bout
-- Creation Date : 10/28/2005
-- Copyright : 2005, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    Customizes the XSA SDRAM controller module by adding
--    a secondary port that allows the SDRAM to be read/written
--    through the parallel port while the SDRAM is in operation.
--
--                   +--------------+    +---------------+      +  -----------+
--    host-side      |              |    |               |      |           |
--       port    <==>|              |    |               |      |           |
--                   |              |    |               |      |           |
--                   |   dualport   |    |    SDRAM      |      |   SDRAM   |
--                   |    module    |<==>|  controller   |<====>|   chip    |
--  +                                   -----------+    |              |    |               |      |           |
--  | parallel  |    |              |    |               |      |           |
--  |   port    |<==>|              |    |               |      |           |
--  | interface |    |              |    |               |      |           |
--  +-----------+    +--------------+    +---------------+      +  -----------+
--
-- Revision:
-- 1.0.0
--
-- Additional Comments:
--
-- License:
-- This code can be freely distributed and modified as long as
-- this header is not removed.
--------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

package XSASDRAM_ppintfc_pckg is
  component XSASDRAMCntl_ppintfc
    generic(
      FREQ                 :       natural := 50_000;  -- operating frequency in KHz
      CLK_DIV              :       real    := 1.0;  -- divisor for FREQ (can only be 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 8.0 or 16.0)
      PIPE_EN              :       boolean := false;  -- if true, enable pipelined read operations
      MAX_NOP              :       natural := 10000;  -- number of NOPs before entering self-refresh
      MULTIPLE_ACTIVE_ROWS :       boolean := true;  -- if true, allow an active row in each bank
      DATA_WIDTH           :       natural := 16;  -- host & SDRAM data width
      NROWS                :       natural := 4096;  -- number of rows in SDRAM array
      NCOLS                :       natural := 512;  -- number of columns in SDRAM array
      HADDR_WIDTH          :       natural := 24;  -- host-side address width
      SADDR_WIDTH          :       natural := 13  -- SDRAM-side address width
      );
    port(
      ppd                  : in    std_logic_vector(7 downto 0);  -- parallel port data
      pps                  : out   std_logic_vector(6 downto 3);  -- parallel port status
      clk                  : in    std_logic;  -- main clock input from external clock source
      bufclk               : out   std_logic;  -- buffered master clock output
      clk1x                : out   std_logic;  -- synchronized master clock (accounts for delays to external SDRAM)
      clk2x                : out   std_logic;  -- synchronized doubled master clock
      lock                 : out   std_logic;  -- DLL lock indicator
      rst                  : in    std_logic;  -- reset
      rd                   : in    std_logic;  -- host-side SDRAM read control from dualport
      wr                   : in    std_logic;  -- host-side SDRAM write control from dualport
      earlyOpBegun         : out   std_logic;  -- early indicator that memory operation has begun
      opBegun              : out   std_logic;  -- indicates memory read/write has begun
      rdPending            : out   std_logic;  -- read operation to SDRAM is in progress
      done                 : out   std_logic;  -- indicates SDRAM memory read or write operation is done
      rdDone               : out   std_logic;  -- indicates SDRAM memory read operation is done
      hAddr                : in    std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host-side address from dualport to SDRAM
      hDIn                 : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- SDRAM data input from host-side logic
      hDOut                : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- SDRAM data output to dualport
      status               : out   std_logic_vector(3 downto 0);  -- SDRAM controller state (for diagnostics)
      sclkfb               : in    std_logic;  -- feedback SDRAM clock with PCB delays
      sclk                 : out   std_logic;  -- clock to SDRAM
      cke                  : out   std_logic;  -- SDRAM clock-enable
      cs_n                 : out   std_logic;  -- SDRAM chip-select
      ras_n                : out   std_logic;  -- SDRAM RAS
      cas_n                : out   std_logic;  -- SDRAM CAS
      we_n                 : out   std_logic;  -- SDRAM write-enable
      ba                   : out   std_logic_vector(1 downto 0);  -- SDRAM bank-address
      sAddr                : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
      sData                : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
      dqmh                 : out   std_logic;  -- SDRAM DQMH
      dqml                 : out   std_logic  -- SDRAM DQML
      );
  end component XSASDRAMCntl_ppintfc;
end package XSASDRAM_ppintfc_pckg;


library IEEE;
use IEEE.std_logic_1164.all;
use WORK.common.all;
use WORK.xsasdram.all;
use WORK.sdram.all;
use WORK.ramintfc_pckg.all;

entity XSASDRAMCntl_ppintfc is
  generic(
    FREQ                 :       natural := 50_000;  -- operating frequency in KHz
    CLK_DIV              :       real    := 1.0;  -- divisor for FREQ (can only be 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 8.0 or 16.0)
    PIPE_EN              :       boolean := false;  -- if true, enable pipelined read operations
    MAX_NOP              :       natural := 10000;  -- number of NOPs before entering self-refresh
    MULTIPLE_ACTIVE_ROWS :       boolean := true;  -- if true, allow an active row in each bank
    DATA_WIDTH           :       natural := 16;  -- host & SDRAM data width
    NROWS                :       natural := 4096;  -- number of rows in SDRAM array
    NCOLS                :       natural := 512;  -- number of columns in SDRAM array
    HADDR_WIDTH          :       natural := 24;  -- host-side address width
    SADDR_WIDTH          :       natural := 13  -- SDRAM-side address width
    );
  port(
    ppd                  : in    std_logic_vector(7 downto 0);  -- parallel port data
    pps                  : out   std_logic_vector(6 downto 3);  -- parallel port status
    clk                  : in    std_logic;  -- main clock input from external clock source
    bufclk               : out   std_logic;  -- buffered master clock output
    clk1x                : out   std_logic;  -- synchronized master clock (accounts for delays to external SDRAM)
    clk2x                : out   std_logic;  -- synchronized doubled master clock
    lock                 : out   std_logic;  -- DLL lock indicator
    rst                  : in    std_logic;  -- reset
    rd                   : in    std_logic;  -- host-side SDRAM read control from dualport
    wr                   : in    std_logic;  -- host-side SDRAM write control from dualport
    earlyOpBegun         : out   std_logic;  -- early indicator that memory operation has begun
    opBegun              : out   std_logic;  -- indicates memory read/write has begun
    rdPending            : out   std_logic;  -- read operation to SDRAM is in progress
    done                 : out   std_logic;  -- indicates SDRAM memory read or write operation is done
    rdDone               : out   std_logic;  -- indicates SDRAM memory read operation is done
    hAddr                : in    std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host-side address from dualport to SDRAM
    hDIn                 : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- SDRAM data input from host-side logic
    hDOut                : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- SDRAM data output to dualport
    status               : out   std_logic_vector(3 downto 0);  -- SDRAM controller state (for diagnostics)
    sclkfb               : in    std_logic;  -- feedback SDRAM clock with PCB delays
    sclk                 : out   std_logic;  -- clock to SDRAM
    cke                  : out   std_logic;  -- SDRAM clock-enable
    cs_n                 : out   std_logic;  -- SDRAM chip-select
    ras_n                : out   std_logic;  -- SDRAM RAS
    cas_n                : out   std_logic;  -- SDRAM CAS
    we_n                 : out   std_logic;  -- SDRAM write-enable
    ba                   : out   std_logic_vector(1 downto 0);  -- SDRAM bank-address
    sAddr                : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
    sData                : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
    dqmh                 : out   std_logic;  -- SDRAM DQMH
    dqml                 : out   std_logic  -- SDRAM DQML
    );
end entity;

architecture arch of XSASDRAMCntl_ppintfc is
  signal bufclk_i : std_logic;          -- buffered input (non-DLL) clock
  signal clk1x_i  : std_logic;          -- internal master clock signal
  signal clk2x_i  : std_logic;          -- internal master clock signal
  signal lock_i   : std_logic;          -- SDRAM clock DLL lock indicator

  -- signals that go through the dualport module port0 and port1 ports and to the SDRAM controller
  signal rst1, rst_i                   : std_logic;  -- SDRAM controller reset
  signal rd1, rd_i                     : std_logic;  -- host-side read control signal
  signal wr1, wr_i                     : std_logic;  -- host-side write control signal
  signal earlyOpBegun1, earlyOpBegun_i : std_logic;  -- read/write operation started indicator
  signal opBegun1, opBegun_i           : std_logic;  -- read/write operation started indicator
  signal rdPending1, rdPending_i       : std_logic;  -- read operation pending in SDRAM pipeline indicator
  signal done1, done_i                 : std_logic;  -- read/write operation complete indicator
  signal rdDone1, rdDone_i             : std_logic;  -- read operation complete indicator
  signal hAddr1, hAddr_i               : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host-side address bus
  signal hDIn1, hDIn_i                 : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal hDOut1, hDOut_i               : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal status1, status_i             : std_logic_vector(3 downto 0);

begin

  ------------------------------------------------------------------------
  -- Instantiate the parallel port-SDRAM interface
  ------------------------------------------------------------------------
  u1 : ramintfc_core
    generic map(
      DATA_WIDTH   => DATA_WIDTH,
      HADDR_WIDTH  => HADDR_WIDTH
      )
    port map(
      ppd          => ppd,
      pps          => pps,
      clkin        => clk,
      clk1x        => clk1x_i,
      lock         => lock_i,
      sdram_reset  => rst1,
      rd           => rd1,
      wr           => wr1,
      earlyOpBegun => earlyOpBegun1,
      done         => done1,
      hAddr        => hAddr1,
      hDIn         => hDIn1,
      hDOut        => hDOut1,
      s            => open
      );

  ------------------------------------------------------------------------
  -- Instantiate the dualport module
  ------------------------------------------------------------------------
  u2 : dualport
    generic map(
      PIPE_EN         => PIPE_EN,
      PORT_TIME_SLOTS => "1111111111111111",
      DATA_WIDTH      => DATA_WIDTH,
      HADDR_WIDTH     => HADDR_WIDTH
      )
    port map(
      clk             => clk1x_i,
      -- external SDRAM interface
      rst0            => rst,
      rd0             => rd,
      wr0             => wr,
      earlyOpBegun0   => earlyOpBegun,
      opBegun0        => opBegun,
      rdPending0      => rdPending,
      rdDone0         => rdDone,
      done0           => done,
      hAddr0          => hAddr,
      hDIn0           => hDIn,
      hDOut0          => hDOut,
      status0         => status,
      -- parallel port SDRAM interface
      rst1            => rst1,
      rd1             => rd1,
      wr1             => wr1,
      earlyOpBegun1   => earlyOpBegun1,
      opBegun1        => open,
      rdPending1      => open,
      rdDone1         => open,
      done1           => done1,
      hAddr1          => hAddr1,
      hDIn1           => hDIn1,
      hDOut1          => hDOut1,
      status1         => open,
      -- connections to the SDRAM controller
      rst             => rst_i,
      rd              => rd_i,
      wr              => wr_i,
      earlyOpBegun    => earlyOpBegun_i,
      opBegun         => opBegun_i,
      rdPending       => rdPending_i,
      rdDone          => rdDone_i,
      done            => done_i,
      hAddr           => hAddr_i,
      hDIn            => hDIn_i,
      hDOut           => hDOut_i,
      status          => status_i
      );

  ------------------------------------------------------------------------
  -- Instantiate the SDRAM controller that connects to the dualport
  -- module and interfaces to the external SDRAM chip.
  ------------------------------------------------------------------------
  u3 : xsaSDRAMCntl
    generic map(
      FREQ         => FREQ,
      CLK_DIV      => CLK_DIV,
      PIPE_EN      => PIPE_EN,
      DATA_WIDTH   => DATA_WIDTH,
      NROWS        => NROWS,
      NCOLS        => NCOLS,
      HADDR_WIDTH  => HADDR_WIDTH,
      SADDR_WIDTH  => SADDR_WIDTH
      )
    port map(
      clk          => clk,
      bufclk       => bufclk_i,
      clk1x        => clk1x_i,
      clk2x        => clk2x_i,
      lock         => lock_i,
      rst          => rst_i,
      rd           => rd_i,
      wr           => wr_i,
      earlyOpBegun => earlyOpBegun_i,
      opBegun      => opBegun_i,
      rdPending    => rdPending_i,
      done         => done_i,
      rdDone       => rdDone_i,
      hAddr        => hAddr_i,
      hDIn         => hDIn_i,
      hDOut        => hDOut_i,
      status       => status_i,
      sclkfb       => sclkfb,
      sclk         => sclk,
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

  bufclk <= bufclk_i;
  clk1x  <= clk1x_i;
  clk2x  <= clk2x_i;
  lock   <= lock_i;

end arch;
