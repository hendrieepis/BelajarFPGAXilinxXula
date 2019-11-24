----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:18:39 11/06/2013 
-- Design Name: 
-- Module Name:    SimpleGate - Behavioral 
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

entity SimpleGate is
    Port ( inA : in  STD_LOGIC_VECTOR (2 downto 0);
           OutY : out  STD_LOGIC);
end SimpleGate;

architecture Behavioral of SimpleGate is

begin
    OutY<=inA(0) AND inA(1) AND inA(2);

end Behavioral;

