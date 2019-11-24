----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:37 11/24/2012 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk_i : in  STD_LOGIC;
--	        reset : in  std_logic;
			  systick : out std_logic;
           counter_o : out  std_logic_vector(7 downto 0));
			  
end counter;

architecture Behavioral of counter is
signal psc:  std_logic_vector(22 downto 0) := (others=>'0');
signal clk_r: std_logic_vector(7 downto 0) := (others=>'0');
signal tick: std_logic:='0';
begin
  CounterProcess: process (clk_i)
  begin
     if rising_edge(clk_i) then
--	     if reset='1' then
--		     psc   <= (others=>'0');
--			  clk_r <= (others=>'0');
--			  tick <='0';
--	  	  else
		    if psc  < "11111111111111111111111" then
		       psc<=psc+1;
		    else
		  	    psc <= (others=>'0');
				 tick <=  tick xor '1';
			    clk_r <= clk_r+1;
		    end if;
--		  end if;
	  end if;
  end process;
  counter_o <= not clk_r;
  systick <= tick;
end Behavioral;

