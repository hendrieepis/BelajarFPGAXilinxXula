library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity dwnldpar is
  port(
    -- parallel port data and status pins
    pp_d : in  std_logic_vector(7 downto 0);
    pp_s : out std_logic_vector(5 downto 3);

    -- FPGA configuration pins
    fpga_m         : out   std_logic_vector(0 downto 0);  -- config. mode select (out)
    fpga_program_n : out   std_logic;   -- active-low config. initiate (out)
    fpga_cclk      : out   std_logic;   -- config. clock (out)
    fpga_cs_n      : out   std_logic;   -- active-low chip-select (out)
    fpga_write_n   : out   std_logic;   -- active-low write-enable (out)
    fpga_init_n    : inout std_logic;   -- config. initialization (in)
    fpga_done      : in    std_logic;   -- config. done (in)
    fpga_tck       : out   std_logic;   -- JTAG clock (out)

    -- peripheral bus
    pb_d : inout std_logic_vector(7 downto 0);  -- config. data (out)
    pb_a : inout std_logic_vector(19 downto 0)  -- address bus (in)

    );
end entity dwnldpar;


architecture arch of dwnldpar is
  constant LO                  : std_logic                    := '0';
  constant HI                  : std_logic                    := '1';
  constant HIZ                 : std_logic                    := 'Z';
  constant SLAVE_PARALLEL_MODE : std_logic_vector(0 downto 0) := "0";
  signal   cclk                : std_logic;
  signal   config_data, nybble : std_logic_vector(3 downto 0);
  signal   cpld_addr           : std_logic_vector(3 downto 0);

begin

  nybble    <= pp_d(5 downto 2);                -- data from PC to board
  cpld_addr <= fpga_init_n & pb_a(2 downto 0);  -- selects CPLD profile

  process(pp_d, pb_a, nybble, config_data, cclk, fpga_done, cpld_addr)
  begin
    fpga_cs_n      <= HIZ;
    fpga_write_n   <= HIZ;
    pb_a           <= (others => HIZ);
    pb_d           <= (others => HIZ);
    fpga_tck       <= LO;               -- deactivate FPGA JTAG circuit
    fpga_m         <= SLAVE_PARALLEL_MODE;  -- set FPGA config mode
    fpga_program_n <= pp_d(7);          -- FPGA PROGRAM# comes from parallel port
    cclk           <= not pp_d(0);      -- internal configuration clock
    fpga_cclk      <= not cclk;         -- FPGA configuration clock (don't gate with DONE or miss end pulses!)

    if fpga_done = LO then              -- FPGA is not configured
      fpga_cs_n            <= LO;       -- enable writing of config. data
      fpga_write_n         <= LO;
      pb_d                 <= config_data & nybble;  -- two nybbles of config data
    else                                -- FPGA is configured
      fpga_cs_n            <= not pp_d(1);  -- clock for data interchange
      fpga_write_n         <= pp_d(6);  -- reset for data interchange FSM
      case conv_integer(unsigned(cpld_addr)) is
        when 0             =>           -- I2C programming is selected by the FPGA
          pb_d(0)          <= not pp_d(1);  -- I2C clock to SAA7114 & osc chips
          pb_d(1)          <= pp_d(6);  -- I2C data to SAA7114 & osc chips
          pp_s(3)          <= pb_a(3);  -- I2C clock from SAA7114 & osc chips
          pp_s(4)          <= pb_a(4);  -- I2C data from SAA7114 & osc chips
        when 1             =>           -- stereo codec programming is selected by the FPGA
          pb_d(0)          <= not pp_d(1);  -- config. clock to codec chip
          pb_d(1)          <= pp_d(6);  -- config. data to codec chip
          pb_d(3)          <= pp_d(5);  -- chip-select to codec chip
          pp_s(4)          <= pb_d(2);  -- config. data from codec chip
        when 2             =>           -- data interchange interface
          pb_d(5 downto 2) <= pp_d(5 downto 2);  -- data nybble from PC to FPGA
          pp_s(5 downto 3) <= pb_a(5 downto 3);  -- data bits from FPGA to PC
        when 3             =>           -- GXSPORT/XSPORT interface
          pb_d(6 downto 0) <= pp_d(6 downto 0);
          pp_s(5 downto 3) <= pb_a(5 downto 3);
        when 4 | 5 | 6 | 7 =>           -- currently undefine CPLD modes
        when others        =>           -- CPLD is not selected by the FPGA
          pp_s(5)          <= pb_a(19);  -- for reporting GXSTEST status
      end case;
    end if;

  end process;

  -- gather 4-bit data from parallel port
  process(cclk)
  begin
    if rising_edge(cclk) then
      config_data <= nybble;
    end if;
  end process;

end architecture arch;

