library IEEE;
use IEEE.std_logic_1164.all;
use WORK.test_dualport_core_pckg.all;
use work.common.all;

entity test_dualport is
  port(
    fpga_init_n : out   std_logic;      -- CPLD interface chip-select
    sdram_clk   : in    std_logic;      -- main clock input from external clock source
    sdram_cke   : out   std_logic;      -- SDRAM clock-enable
    sdram_ce_n  : out   std_logic;      -- SDRAM chip-select
    sdram_ras_n : out   std_logic;      -- SDRAM RAS
    sdram_cas_n : out   std_logic;      -- SDRAM CAS
    sdram_we_n  : out   std_logic;      -- SDRAM write-enable
    pb_a        : out   std_logic_vector(19 downto 0);  -- SDRAM bank-address and address bus
    pb_d        : inout std_logic_vector(15 downto 0);  -- SDRAM data bus
    pb_ub_n     : out   std_logic;      -- SDRAM upper databus byte enable
    pb_lb_n     : out   std_logic       -- SDRAM lower databus byte enable
    );
end entity;

architecture arch of test_dualport is
  signal   sData           : std_logic_vector(pb_d'range);
  signal   led             : std_logic_vector(15 downto 0);
  signal   sDataOutEn      : std_logic;
  signal   progress        : std_logic_vector(1 downto 0);
begin

  fpga_init_n <= '1';                   -- disable CPLD interface

  u0: test_dualport_core
    generic map(
      FREQ => 67_000,
      PIPE_EN => true,
      DATA_WIDTH => pb_d'length,
      SADDR_WIDTH => 13, 
      NROWS => 4096,
      NCOLS => 512,
      BEG_ADDR => 16#00_0000#,
      END_ADDR => 16#7F_FFFF#,
      BEG_TEST_0 => 16#00_0000#,
      END_TEST_0 => 16#3F_FFFF#,
      BEG_TEST_1 => 16#40_0000#,
      END_TEST_1 => 16#7F_FFFF#
      )
    port map(
      clk    => sdram_clk,
      cke    => sdram_cke,
      cs_n   => sdram_ce_n,
      ras_n  => sdram_ras_n,
      cas_n  => sdram_cas_n,
      we_n   => sdram_we_n,
      ba     => pb_a(14 downto 13),  -- SDRAM bank address
      sAddr  => pb_a(12 downto 0),   -- SDRAM address
      sDataIn => pb_d,
      sDataOut => sData,
      sDataOutEn => sDataOutEn,
      dqmh   => pb_ub_n,             -- SDRAM DQMH
      dqml   => pb_lb_n,             -- SDRAM DQML
      progress => progress,
      led    => led,
      heartBeat => pb_a(19)
      );

  -- indicate the phase of the memory test on the LED   
  pb_d <= "ZZZZZZZZZZZZZZZZ"      when progress /= "11" and sDataOutEn = NO else
          sData                   when progress /= "11" and sDataOutEn = YES else
          led;

end architecture;
