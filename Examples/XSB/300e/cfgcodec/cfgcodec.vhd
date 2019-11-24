library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cfgcodec is
  port
    (
      fpga_init_n : out std_logic;      -- INIT# pin
      fpga_clk    : in  std_logic_vector(1 downto 0);
      pb_d        : in  std_logic_vector(15 downto 0);  -- to parallel port data pin
      pb_a        : out std_logic_vector(19 downto 0);  -- to parallel port status pin
      au_csn_n    : out std_logic;      -- audio codec chip-enable
      au_bclk     : out std_logic;
      au_mclk     : out std_logic;
      au_lrck     : out std_logic;
      au_sdti     : out std_logic;
      au_sdto     : in  std_logic
      );
end cfgcodec;


architecture arch of cfgcodec is
  signal cnt : std_logic_vector(9 downto 0);
begin

  fpga_init_n      <= '0';              -- indicate that the codec is available for programming 
  pb_a(2 downto 0) <= "001";

  -- parallel port codec configuration interface 
  au_csn_n <= pb_d(3);

  process(fpga_clk(0))
  begin
    if(fpga_clk(0)'event and fpga_clk(0) = '1') then
      cnt <= cnt+1;
    end if;
  end process;

  au_lrck <= cnt(9);
  au_bclk <= cnt(3);
  au_mclk <= cnt(1);
  au_sdti <= au_sdto;

end arch;
