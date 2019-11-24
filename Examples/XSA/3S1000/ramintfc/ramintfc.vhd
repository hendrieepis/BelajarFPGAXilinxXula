library IEEE;
use IEEE.std_logic_1164.all;
use WORK.ramintfc_pckg.all;
use WORK.xsasdram.all;


entity ramintfc is
  generic(
    FREQ        :       natural := 100_000;  -- clock frequency in KHz
    DATA_WIDTH  :       natural := 16;  -- width of data
    HADDR_WIDTH :       natural := 24;  -- host-side address width
    SADDR_WIDTH :       natural := 13;  -- SDRAM address bus width
    NROWS       :       natural := 8192;  -- number of rows in each SDRAM bank
    NCOLS       :       natural := 512  -- number of words in each row
    );
  port(
    -- I/O
    ppd         : in    std_logic_vector(7 downto 0);  -- parallel port data
    pps         : out   std_logic_vector(6 downto 3);  -- parallel port status
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
    addr        : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
    data        : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to SDRAM
    dqmh        : out   std_logic;      -- SDRAM DQMH
    dqml        : out   std_logic;      -- SDRAM DQML
    s           : out   std_logic_vector(6 downto 0)  -- 7-segment LED
    );
end entity;


architecture arch of ramintfc is
  signal clk1x        : std_logic;
  signal sdram_reset  : std_logic;
  signal lock         : std_logic;
  signal rd           : std_logic;
  signal wr           : std_logic;
  signal earlyOpBegun : std_logic;
  signal done         : std_logic;
  signal hAddr        : std_logic_vector(HADDR_WIDTH-1 downto 0);
  signal hDin         : std_logic_vector(DATA_WIDTH-1 downto 0);
  signal hDOut        : std_logic_vector(DATA_WIDTH-1 downto 0);
begin

  ce_n <= '1';                          -- disable Flash RAM

  -- This module reads data from the SDRAM controller and sends it to
  -- the parallel port, and reads data from the parallel port and sends
  -- it to the SDRAM controller.
  u1 : ramintfc_core generic map (
    DATA_WIDTH     => DATA_WIDTH,
    HADDR_WIDTH    => HADDR_WIDTH
    )
    port map (
      ppd          => ppd,
      pps          => pps,
      clkin        => clkin,
      clk1x        => clk1x,
      sdram_reset  => sdram_reset,
      lock         => lock,
      rd           => rd,
      wr           => wr,
      earlyOpBegun => earlyOpBegun,
      done         => done,
      hAddr        => hAddr,
      hDIn         => hDIn,
      hDOut        => hDOut,
      s            => s
      );

  -- This module is the SDRAM controller.
  u2 : xsaSDRAMCntl
    generic map(
      FREQ         => FREQ,
      DATA_WIDTH   => DATA_WIDTH,
      NROWS        => NROWS,
      NCOLS        => NCOLS,
      HADDR_WIDTH  => HADDR_WIDTH,
      SADDR_WIDTH  => SADDR_WIDTH
      )
    port map(
      clk          => clkin,
      bufclk       => open,
      clk1x        => clk1x,
      clk2x        => open,
      lock         => lock,
      rst          => sdram_reset,
      rd           => rd,
      wr           => wr,
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
      sAddr        => addr,
      sData        => data,
      dqmh         => dqmh,
      dqml         => dqml
      );

end architecture;
