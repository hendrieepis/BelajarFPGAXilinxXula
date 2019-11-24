library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity syscnt is
    Port ( clk_i : in  STD_LOGIC;
	        pb_i : in  STD_LOGIC;
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
	
	COMPONENT debouncing
	PORT(
		clk_i : IN std_logic;
		dbin : IN std_logic;          
		dbout : OUT std_logic
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
	signal db_cable: std_logic;
	signal bcd_o_cable: std_logic_vector(3 downto 0);
	
begin

	Inst_Prescaller: Prescaller PORT MAP(
		clk_i => clk_i,
		psc_out => psc_cable
	);
	
	Inst_debouncing: debouncing PORT MAP(
		clk_i => psc_cable,
		dbin => pb_i,
		dbout => db_cable
	);
	
	Inst_counterBCD: counterBCD PORT MAP(
		clk_i => db_cable ,
		bcd_o => bcd_o_cable
	);
	
		Inst_decoder: decoder PORT MAP(
		clk => db_cable,
		bcd => bcd_o_cable,
		segment7 => counter_out
	);
end Behavioral;