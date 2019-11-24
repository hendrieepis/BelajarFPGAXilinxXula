library ieee, unisim;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use unisim.vcomponents.all;
use work.common.all;


entity xessjtag is
  port(
    -- parallel port data and status pins
    pp_d : in  std_logic_vector(7 downto 0);
    pp_s : out std_logic_vector(5 downto 3);

    -- FPGA configuration pins
    fpga_tck    : out std_logic;        -- driver to FPGA JTAG clock
    fpga_tms    : out std_logic;        -- driver to FPGA JTAG mode input
    fpga_tdi    : out std_logic;        -- driver to FPGA JTAG serial data input
    fpga_tdo    : in  std_logic;        -- input from FPGA JTAG serial data output
    fpga_m      : out std_logic_vector(0 downto 0);  -- config. mode select
    fpga_cclk   : out std_logic;        -- driver to FPGA config clock
    fpga_prog_n : out std_logic;        -- driver to FPGA /PROGRAM pin
    fpga_init_n : in  std_logic;        -- input from FPGA to select CPLD when low
    fpga_done   : in  std_logic;        -- input from FPGA done pin
    flash_ce_n  : in  std_logic;        -- Flash chip-enable

    -- peripheral bus
    pb_d : inout std_logic_vector(7 downto 0);  -- config. data (out)
    pb_a : inout std_logic_vector(19 downto 0)  -- address bus (in)
    );
end entity xessjtag;


architecture arch of xessjtag is

  constant SLAVE_PARALLEL_MODE : std_logic_vector(0 downto 0) := "0";
  signal   test_vector         : std_logic_vector(7 downto 0);  -- complete test vector sent from PC to configured FPGA
  signal   upper_test_vector   : std_logic_vector(3 downto 0);	-- upper nybble of test vector
  signal   cpld_addr           : std_logic_vector(3 downto 0);

begin

  fpga_m      <= SLAVE_PARALLEL_MODE;  -- set FPGA config mode (not important; we use JTAG for config.)
  fpga_cclk   <= HI;       -- keep the configuration clock from pulsing
  fpga_prog_n <= pp_d(7);  -- programming pulse comes from parallel port
  cpld_addr   <= fpga_init_n & pb_a(2 downto 0);  -- FPGA (when configured) selects CPLD profile

  -- drive the FPGA JTAG pins from the parallel port
  fpga_tms <= pp_d(2);
  fpga_tck <= pp_d(1);
  fpga_tdi <= pp_d(0);

  -- the JTAG TDO output is sent back through the status pin
  pp_s(4) <= fpga_tdo;
  pp_s(5) <= 'Z';
  pp_s(3) <= 'Z';
  
  -- Assemble test vectors sent through the parallel port to the FPGA.
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

  -- Handle various CPLD interface tasks selected by address from FPGA.
  process(fpga_done, cpld_addr)
  begin
    pb_a           <= (others => HIZ);
    pb_d           <= (others => HIZ);

    if fpga_done = HI then              -- FPGA is configured
      case conv_integer(unsigned(cpld_addr)) is
        when 0             =>           -- I2C programming is selected by the FPGA
          null;
          --pb_d(0)          <= not pp_d(1);  -- I2C clock to SAA7114 & osc chips
          --pb_d(1)          <= pp_d(6);  -- I2C data to SAA7114 & osc chips
          --pp_s(3)          <= pb_a(3);  -- I2C clock from SAA7114 & osc chips
          --pp_s(4)          <= pb_a(4);  -- I2C data from SAA7114 & osc chips
        when 1             =>           -- stereo codec programming is selected by the FPGA
          null;
          --pb_d(0)          <= not pp_d(1);  -- config. clock to codec chip
          --pb_d(1)          <= pp_d(6);  -- config. data to codec chip
          --pb_d(3)          <= pp_d(5);  -- chip-select to codec chip
          --pp_s(4)          <= pb_d(2);  -- config. data from codec chip
        when 2             =>           -- data interchange interface
          null;
          --pb_d(5 downto 2) <= pp_d(5 downto 2);  -- data nybble from PC to FPGA
          --pp_s(5 downto 3) <= pb_a(5 downto 3);  -- data bits from FPGA to PC
        when 3             =>           -- GXSPORT/XSPORT interface
          pb_d(7 downto 0) <= test_vector;
          --pp_s(5 downto 3) <= pb_a(5 downto 3);
        when 4 | 5 | 6 | 7 =>           -- currently undefined CPLD modes
          null;
        when others        =>           -- CPLD is not selected by the FPGA
          null;
      end case;
    end if;

  end process;

end architecture arch;

