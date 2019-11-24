----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:26:41 12/28/2006 
-- Design Name: 
-- Module Name:    adder - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           led : out  STD_LOGIC_VECTOR (6 downto 0));
end adder;

architecture Behavioral of adder is
	signal sum: std_logic_vector(4 downto 0);
	signal led_n: std_logic_vector(led'range);
begin

	sum <= ("0" & a) + ("0" & b);
	
   led_n <=
			"1000000" when sum="00000" else  --0
			"1111001" when sum="00001" else  --1
         "0100100" when sum="00010" else  --2
         "0110000" when sum="00011" else  --3
         "0011001" when sum="00100" else  --4
         "0010010" when sum="00101" else  --5
         "0000010" when sum="00110" else  --6
         "1111000" when sum="00111" else  --7
         "0000000" when sum="01000" else  --8
         "0010000" when sum="01001" else  --9
         "0001000" when sum="01010" else  --A
         "0000011" when sum="01011" else  --b
         "1000110" when sum="01100" else  --C
         "0100001" when sum="01101" else  --d
         "0000110" when sum="01110" else  --E
         "0001110" when sum="01111" else  --F
         "0101100";								--?
			
	led <= not led_n;
 				
end Behavioral;

