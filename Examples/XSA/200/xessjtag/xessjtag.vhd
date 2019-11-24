library ieee, unisim;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use unisim.vcomponents.all;
use work.common.all;


entity xessjtag is
  port(
    -- parallel port data and status pins
    pp_d : in  std_logic_vector(7 downto 0);
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
    fpga_prog_n : out std_logic;        -- driver to FPGA /PROGRAM pin
    fpga_done   : in  std_logic;        -- input from FPGA done pin
    fpga_d      : out std_logic_vector(7 downto 0);  -- drivers to FPGA config data pins and 7-seg LED
    fpga_pp_d   : out std_logic_vector(7 downto 0);  -- parallel port data to FPGA
    fpga_pp_s   : in  std_logic_vector(5 downto 3);  -- parallel port status from FPGA
    flash_ce_n  : in  std_logic         -- Flash chip-enable
    );
end entity xessjtag;


architecture arch of xessjtag is

  signal   test_vector : std_logic_vector(7 downto 0);  -- complete test vector sent from PC to configured FPGA
  signal   upper_test_vector: std_logic_vector(3 downto 0);	-- upper nybble of test vector
  signal   clk_divider : std_logic_vector(0 downto 0);

begin

  fpga_cclk   <= HI;                    -- keep the configuration clock from pulsing
  fpga_prog_n <= LO when pp_d(7) = LO   else 'Z';  -- programming pulse comes from parallel port

  -- drive the FPGA JTAG pins from the parallel port
  fpga_tms <= pp_d(2);
  fpga_tck <= pp_d(1);
  fpga_tdi <= pp_d(0);

  -- the JTAG TDO output is sent back through the status pin
  pp_s(4) <= fpga_tdo;
  pp_s(5) <= 'Z';
  pp_s(3) <= 'Z';
  
  process(fpga_done,flash_ce_n)
  begin
    if (fpga_done = HI) and (flash_ce_n = HI) then
      fpga_d <= "ZZZZZZ1Z"; -- show FPGA config status on LED-DP if flash is not in use
    else
      fpga_d <= (others=>'Z'); -- release control of FPGA Flash/LED pins when FPGA lowers Flash chip-enable
    end if;
  end process;
  
  -- Handle sending test vectors through the parallel port to the configured FPGA.
  -- Output the test vector to the FPGA if it is configured and the flash is not in contention.
  process(pp_d(0))
  begin
    if falling_edge(pp_d(0)) then
	   if pp_d(6) = HI then
        upper_test_vector <= pp_d(5 downto 2);
		end if;
    end if;
    if rising_edge(pp_d(0)) then
	   if pp_d(6) = HI then
        test_vector <= upper_test_vector & pp_d(5 downto 2);
		end if;
    end if;
  end process;
  process(fpga_done,flash_ce_n)
  begin
    if (fpga_done = HI) and (flash_ce_n = HI) then
      fpga_pp_d <= test_vector;
    else
      fpga_pp_d <= (others=>'Z');
    end if;
  end process;

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

