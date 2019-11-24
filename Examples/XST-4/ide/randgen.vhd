--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 05/17/2005
-- Copyright     : 2005, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    Loadable LFSR random number generator.
--
-- Revision:
--    1.0.1
--
-- Additional Comments:
--    1.0.1:
--        Fixed shift-register update.
--    1.0.0:
--        Initial release.
--
-- License:
--    This code can be freely distributed and modified as long as
--    this header is not removed.
--------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;


package rand is

  component randGen                     -- loadable LFSR random number generator
    generic(
      DATA_WIDTH :     natural := 8
      );
    port(
      clk        : in  std_logic;       -- main clock input
      cke        : in  std_logic;       -- clock enable
      ld         : in  std_logic;       -- load enable for seed
      seed       : in  std_logic_vector(DATA_WIDTH-1 downto 0);  -- random number seed value
      rand       : out std_logic_vector(DATA_WIDTH-1 downto 0)  -- output for random number
      );
  end component;

end package rand;



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;


entity randGen is
  generic(
    DATA_WIDTH :     natural := 8
    );
  port(
    clk        : in  std_logic;         -- main clock input
    cke        : in  std_logic;         -- clock enable
    ld         : in  std_logic;         -- load enable for seed
    seed       : in  std_logic_vector(DATA_WIDTH-1 downto 0);  -- random number seed value
    rand       : out std_logic_vector(DATA_WIDTH-1 downto 0)  -- output for random number
    );
end randGen;


architecture arch of randGen is

  signal r_r, r_next : std_logic_vector(rand'range);  -- random number shift register
  signal new_bit     : std_logic;       -- feedback bit into LSB of LFSR

begin

  -- use the length parameter to select the bits in the shift register
  -- which will be XOR'ed to compute the bit fed back into the 
  -- least significant bit of the shift register
  new_bit <=
    r_r(1) xor r_r(0)                           when r_r'length = 2  else
    r_r(2) xor r_r(1)                           when r_r'length = 3  else
    r_r(3) xor r_r(2)                           when r_r'length = 4  else
    r_r(4) xor r_r(2)                           when r_r'length = 5  else
    r_r(5) xor r_r(4)                           when r_r'length = 6  else
    r_r(6) xor r_r(3)                           when r_r'length = 7  else
    r_r(7) xor r_r(5) xor r_r(4) xor r_r(3)     when r_r'length = 8  else
    r_r(11) xor r_r(10) xor r_r(7) xor r_r(5)   when r_r'length = 12 else
    r_r(15) xor r_r(12) xor r_r(11) xor r_r(10) when r_r'length = 16 else
    r_r(19) xor r_r(16)                         when r_r'length = 20 else
    r_r(23) xor r_r(22) xor r_r(21) xor r_r(16) when r_r'length = 24 else
    r_r(27) xor r_r(24)                         when r_r'length = 28 else
    r_r(31) xor r_r(30) xor r_r(29) xor r_r(9)  when r_r'length = 32 else
    r_r(r_r'length-1);

  r_next <=
    r_r  when cke = NO else             -- reload current value if clock disabled
    seed when ld = YES else             -- load with seed value
    r_r(r_r'high-1 downto 0) & new_bit;  -- otherwise, shift register left and append feedback bit

  process(clk)
  begin
    if rising_edge(clk) then            -- update shift register on rising clock edge
      r_r <= r_next;
    end if;
  end process;

  rand <= r_r;                          -- output the random number in the shift register

end arch;
