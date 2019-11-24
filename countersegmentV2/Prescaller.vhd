----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:54:06 12/02/2012 
-- Design Name: 
-- Module Name:    Prescaller - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Prescaller is
    Port ( clk_i : in  STD_LOGIC;
           psc_out : out  STD_LOGIC);
end Prescaller;

architecture Behavioral of Prescaller is
signal clk_r: std_logic_vector(23 downto 0) := (others=>'0');
begin

process (clk_i)
begin 
   if rising_edge(clk_i) then
	   clk_r <= clk_r+1;
	end if;
end process;
psc_out<=clk_r(23);
end Behavioral;

