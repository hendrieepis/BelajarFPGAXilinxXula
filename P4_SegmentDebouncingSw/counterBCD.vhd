library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity counterBCD is
    Port ( clk_i : in  STD_LOGIC;
           bcd_o : out  STD_LOGIC_VECTOR (3 downto 0));
end counterBCD;

architecture Behavioral of counterBCD is
signal clk_r: std_logic_vector (3 downto 0) := (others=>'0');
begin
process (clk_i)
begin
  if rising_edge(clk_i) then
     if(clk_r < 9) then
       clk_r<= clk_r+1;
	  else
	    clk_r<= (others => '0');
	  end if; 
  end if;
end process;
bcd_o <= clk_r;
end Behavioral;