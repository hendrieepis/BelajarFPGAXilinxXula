----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:34 11/23/2012 
-- Design Name: 
-- Module Name:    blinker - Behavioral 
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinker is
    Port ( clk_i : in  STD_LOGIC;
           blinker_o : out  STD_LOGIC;
			  segA  : out STD_Logic;
			  en1    : out STD_Logic;
			  en2    : out STD_Logic;
			  en3    : out STD_Logic;
			  en4    : out STD_Logic;
			  sw1    : in  STD_Logic;
			  sw2    : in  STD_Logic;
			  sw3    : in  STD_Logic;
			  sw4    : in  STD_Logic
			  );
end blinker;

architecture Behavioral of blinker is
signal clk_r : std_logic_vector(24 downto 0) := (others=>'0');


begin
process (clk_i)
begin
   if rising_edge(clk_i) then
	   clk_r <= clk_r + 1;
	end if;
	
end process;
blinker_o <= clk_r(24);
segA <= not clk_r(24);
en1 <=sw1;
en2 <=sw2;
en3 <=sw3;
en4 <=sw4;

	
end Behavioral;
