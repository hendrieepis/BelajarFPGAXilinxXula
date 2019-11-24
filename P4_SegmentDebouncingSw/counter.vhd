----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:50:31 01/26/2013 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity counter is
	Port(clk_i     : in  STD_LOGIC;
		 systick   : out STD_LOGIC;
		 counter_o : out STD_LOGIC_VECTOR(3 downto 0));
end counter;
architecture Behavioral of counter is
	signal psc   : std_logic_vector(23 downto 0) := (others => '0');
	signal clk_r : std_logic_vector(3 downto 0)  := (others => '0');
	signal tick  : std_logic                     := '0';
begin
	process(clk_i)
	begin
		if rising_edge(clk_i) then
			if psc <= "11111111111111111111111" then
				psc <= psc + 1;
			else
				psc  <= (others => '0');
				tick <= tick xor '1';
				if clk_r < 9 then
					clk_r <= clk_r + 1;
				else
					clk_r <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	counter_o <= clk_r;
	systick   <= tick;
end Behavioral;