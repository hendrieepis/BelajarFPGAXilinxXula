----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:37:15 01/30/2013 
-- Design Name: 
-- Module Name:    pinIOTest - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pinIOTest is
    Port ( 
	    data : out  STD_LOGIC_VECTOR (7 downto 0);
		 btn  : in  STD_LOGIC_VECTOR(7 Downto 0)
	 );
end pinIOTest;

architecture Behavioral of pinIOTest is

begin
  data<=btn;
  
end Behavioral;

