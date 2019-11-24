----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:35 12/02/2012 
-- Design Name: 
-- Module Name:    debouncing - Behavioral 
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

entity debouncing is
    Port ( clk_i : in  STD_LOGIC;
           dbin : in  STD_LOGIC;
           dbout : out  STD_LOGIC);
end debouncing;


architecture Behavioral of debouncing is
signal Q1, Q2, Q3 : std_logic;
begin
process(clk_i)
begin
   if (clk_i'event and clk_i = '1') then
         Q1 <= dbin;
         Q2 <= Q1;
         Q3 <= Q2;
   end if;
end process;
dbout <= Q1 and Q2 and (not Q3);

end Behavioral;

