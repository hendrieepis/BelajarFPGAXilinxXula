library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blink is
    Port ( clk_i : in  STD_LOGIC;
           blinkout : out  STD_LOGIC);
end blink;

architecture Behavioral of blink is
signal psc: std_logic_vector(24 downto 0) :=(others=>'0');
begin
process (clk_i)
begin
   if rising_edge(clk_i) then
	    psc<= psc+1;
	end if;
end process;
   blinkout <= psc(24);
end Behavioral;
