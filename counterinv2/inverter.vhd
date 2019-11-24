----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:47:44 11/28/2012 
-- Design Name: 
-- Module Name:    inverter - Behavioral 
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

entity inverter is
    Port ( indata : in  STD_LOGIC_VECTOR (7 downto 0);
           outdata : out  STD_LOGIC_VECTOR (7 downto 0));
end inverter;

architecture Behavioral of inverter is

begin
process (indata)
begin
   outdata<= not indata ;
end process;
   
end Behavioral;

