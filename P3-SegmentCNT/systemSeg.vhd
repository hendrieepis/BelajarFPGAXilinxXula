----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:48:29 11/28/2012 
-- Design Name: 
-- Module Name:    systemSeg - Behavioral 
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

entity systemSeg is
    Port ( clk : in  STD_LOGIC;
           systick : out  STD_LOGIC;
           counter_out : out  STD_LOGIC_VECTOR (6 downto 0));
end systemSeg;

architecture Behavioral of systemSeg is
	
	COMPONENT counter
	PORT(
		clk_i : IN std_logic;          
		systick : OUT std_logic;
		counter_o : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT decoder
	PORT(
		clk : IN std_logic;
		bcd : IN std_logic_vector(3 downto 0);          
		segment7 : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	signal cable : std_logic_vector(3 downto 0);
begin

	Inst_counter: counter PORT MAP(
		clk_i => clk,
		systick => systick,
		counter_o => cable
	);
	
	Inst_decoder: decoder PORT MAP(
		clk => clk,
		bcd => cable ,
		segment7 => counter_out
	);	

end Behavioral;

