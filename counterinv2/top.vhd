----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:20:25 11/28/2012 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    Port ( clk : in  STD_LOGIC;
			  systick : OUT std_logic;
           count : out  STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is
	COMPONENT counter
	PORT(
		clk_i : IN std_logic;          
		systick : OUT std_logic;
		counter_o : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT inverter
	PORT(
		indata : IN std_logic_vector(7 downto 0);          
		outdata : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	signal cable: std_logic_vector(7 downto 0);
	
begin

	Inst_counter: counter PORT MAP(
		clk_i => clk,
		systick => systick,
		counter_o => cable
	);
	
		Inst_inverter: inverter PORT MAP(
		indata => cable ,
		outdata => count
	);


end Behavioral;

