library IEEE;
use IEEE.std_logic_1164.all;
use WORK.test_board_core_pckg.all;

entity test_board is
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
    s      : out   std_logic_vector(6 downto 0);  -- 7-segment LED
    pps    : out   std_logic_vector(6 downto 3)  -- outputs to parallel port status bits
    );
end entity;

architecture arch of test_board is
begin

  ce_n <= '1';                          -- disable Flash RAM

  u0 : test_board_core
    generic map(
      FREQ        => 50_000,
      PIPE_EN     => true,
      DATA_WIDTH  => sData'length,
      SADDR_WIDTH => sAddr'length,
      NROWS       => 4096,
      NCOLS       => 512,
      BEG_ADDR    => 16#00_0000#,
      END_ADDR    => 16#7F_FFFF#,
      BEG_TEST    => 16#00_0000#,
      END_TEST    => 16#7F_FFFF#
      )
    port map(
      button_n    => sw2,
      clk         => clk,
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
      heartBeat   => pps(6)
      );

end arch;

