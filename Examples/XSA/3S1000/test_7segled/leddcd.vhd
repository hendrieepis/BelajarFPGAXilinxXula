----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:23 05/13/2006 
-- Design Name: 
-- Module Name:    leddcd - Behavioral 
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

entity leddcd is
    Port ( d : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (6 downto 0));
end leddcd;

architecture Behavioral of leddcd is

begin

	s <="1110111" when d="0000" else
		"0010010" when d="0001" else
		"1011101" when d="0010" else
		"1011011" when d="0011" else
		"0111010" when d="0100" else
		"1101011" when d="0101" else
		"1101111" when d="0110" else
		"1010010" when d="0111" else
		"1111111" when d="1000" else
		"1111011" when d="1001" else
		"1111110" when d="1010" else
		"0101111" when d="1011" else
		"0001101" when d="1100" else
		"0011111" when d="1101" else
		"1101101" when d="1110" else
		"1101100";

end Behavioral;

