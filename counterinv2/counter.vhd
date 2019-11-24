----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:49:43 11/26/2012 
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
    Port ( clk_i : in  STD_LOGIC;
           systick : out  STD_LOGIC;
           counter_o : out  STD_LOGIC_VECTOR (7 downto 0));
end counter;

architecture Behavioral of counter is

signal clk_s: std_logic_vector(22 downto 0) :=(others=>'0');
signal clk_r: std_logic_vector(7 downto 0) :=(others=>'0');
signal psc_o: std_logic :='0';
signal tick: std_logic :='0';

begin
aaa: process (clk_i,clk_s)
begin
  if rising_edge(clk_i) then
      clk_s<=clk_s+1;  
  end if;
  psc_o <= clk_s(22);
end process;

bbb: process (psc_o)
begin
   if rising_edge(psc_o) then
		tick <= not tick ;
		clk_r <= clk_r+1;
	end if;
end process;

counter_o <= clk_r;
systick <= tick; 
end Behavioral;

