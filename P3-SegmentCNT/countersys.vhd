----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:54 11/27/2012 
-- Design Name: 
-- Module Name:    countersys - Behavioral 
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

entity countersys is
    Port ( clk : in  STD_LOGIC;
	        systick : OUT std_logic;
           segdata : out  STD_LOGIC_VECTOR (6 downto 0));
end countersys;

architecture Behavioral of countersys is
	COMPONENT decoder
	PORT(
		clk : IN std_logic;
		bcd : IN std_logic_vector(3 downto 0);          
		segment7 : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
	COMPONENT counter
	PORT(
		clk_i : IN std_logic;          
		systick : OUT std_logic;
		counter_o : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	scounter: std_logic_vector(7 downto 0);
begin

	Inst_decoder: decoder PORT MAP(
		clk => ,
		bcd => ,
		segment7 => 
	);
	
	Inst_counter: counter PORT MAP(
		clk_i => clk,
		systick => systick,
		counter_o => scounter 
	);
end Behavioral;

