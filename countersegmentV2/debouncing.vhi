
-- VHDL Instantiation Created from source file debouncing.vhd -- 10:13:27 12/02/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT debouncing
	PORT(
		clk_i : IN std_logic;
		dbin : IN std_logic;          
		dbout : OUT std_logic
		);
	END COMPONENT;

	Inst_debouncing: debouncing PORT MAP(
		clk_i => ,
		dbin => ,
		dbout => 
	);


