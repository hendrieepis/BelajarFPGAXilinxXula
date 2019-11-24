library ieee, unisim;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use unisim.vcomponents.all;


entity p4jtag is
  port(
    -- parallel port data and status pins
    pp_d : in  std_logic_vector(6 downto 0);
    pp_s : out std_logic_vector(5 downto 3);

    -- programmable oscillator
    master_clk : in  std_logic;
    clka, clkb : out std_logic;

    -- FPGA configuration pins
    fpga_tck    : out std_logic;        -- driver to FPGA JTAG clock
    fpga_tms    : out std_logic;        -- driver to FPGA JTAG mode input
    fpga_tdi    : out std_logic;        -- driver to FPGA JTAG serial data input
    fpga_tdo    : in  std_logic;        -- input from FPGA JTAG serial data output
    fpga_cclk   : out std_logic;        -- driver to FPGA config clock
    fpga_prog_n : out std_logic         -- driver to FPGA /PROGRAM pin
    );
end entity p4jtag;


architecture arch of p4jtag is

  constant NO          : std_logic := '0';
  constant YES         : std_logic := '1';
  constant LO          : std_logic := '0';
  constant HI          : std_logic := '1';
  signal   clk_divider : std_logic_vector(1 downto 0);

begin

  fpga_prog_n <= 'Z';                   -- external pullup keeps the PROGRAM# pin from going low and erasing the FPGA
  fpga_cclk   <= HI;                    -- keep the configuration clock from pulsing

  -- drive the FPGA JTAG pins from the parallel port
  fpga_tms <= pp_d(2);
  fpga_tck <= pp_d(1);
  fpga_tdi <= pp_d(0);

  -- the JTAG TDO output is sent back through the status pin
  pp_s(4) <= fpga_tdo;

  -- generate clocks for the FPGA
  process(master_clk)
  begin
    if(rising_edge(master_clk)) then
      clk_divider <= clk_divider + 1;
    end if;
  end process;
  clka            <= master_clk;        -- master clock
  clkb            <= clk_divider(0);    -- master clock / 2

end architecture arch;

