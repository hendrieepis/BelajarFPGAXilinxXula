library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cfgi2c is
  port
    (
      fpga_init_n : out   std_logic;    -- INIT# pin
      pb_d        : in    std_logic_vector(1 downto 0);  -- to parallel port data pin
      pb_a        : out   std_logic_vector(4 downto 0);  -- to parallel port status pin
      i2c_scl     : inout std_logic;    -- bidirectional I2C clock signal
      i2c_sda     : inout std_logic     -- bidirectional I2C data signal
      );
end cfgi2c;


architecture arch of cfgi2c is
begin

  fpga_init_n      <= '0';              -- indicate that the I2C is available for programming   
  pb_a(2 downto 0) <= "000";

  -- parallel port I2C interface 
  pb_a(3) <= i2c_scl;
  pb_a(4) <= i2c_sda;
  i2c_scl <= '0' when pb_d(0) = '0' else 'Z';
  i2c_sda <= '0' when pb_d(1) = '0' else 'Z';

end arch;
