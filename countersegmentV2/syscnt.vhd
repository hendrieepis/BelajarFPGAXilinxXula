----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:10:42 12/02/2012 
-- Design Name: 
-- Module Name:    syscnt - Behavioral 
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

entity syscnt is
    Port ( clk_i : in  STD_LOGIC;
           counter_out : out  STD_LOGIC_VECTOR (6 downto 0)
          );
end syscnt;

architecture Behavioral of syscnt is

	COMPONENT Prescaller
	PORT(
		clk_i : IN std_logic;          
		psc_out : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT counterBCD
	PORT(
		clk_i : IN std_logic;          
		bcd_o : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;	
	

	COMPONENT decoder
	PORT(
		clk : IN std_logic;
		bcd : IN std_logic_vector(3 downto 0);          
		segment7 : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
   signal psc_cable: std_logic;
	signal bcd_o_cable: std_logic_vector(3 downto 0);
	
begin

	Inst_Prescaller: Prescaller PORT MAP(
		clk_i => clk_i,
		psc_out => psc_cable
	);
	

	Inst_counterBCD: counterBCD PORT MAP(
		clk_i => psc_cable ,
		bcd_o => bcd_o_cable
	);
	
		Inst_decoder: decoder PORT MAP(
		clk => psc_cable,
		bcd => bcd_o_cable,
		segment7 => counter_out
	);
end Behavioral;

