library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

Library UNISIM;
use UNISIM.vcomponents.all;

entity Prescaller is
    Port ( clk_i : in  STD_LOGIC;
           psc_out : out  STD_LOGIC);
end Prescaller;

architecture Behavioral of Prescaller is
signal clk_r: std_logic_vector(17 downto 0) := (others=>'0');
begin

process (clk_i,clk_r)
begin 
   if rising_edge(clk_i) then
	   clk_r <= clk_r+1;
	end if;
end process;
   BUFG_inst : BUFG
   port map (
      O => psc_out,     -- Clock buffer output
      I => clk_r(17)      -- Clock buffer input
   );

end Behavioral;

