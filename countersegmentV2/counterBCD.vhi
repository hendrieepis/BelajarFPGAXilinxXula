
-- VHDL Instantiation Created from source file counterBCD.vhd -- 10:15:14 12/02/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT counterBCD
	PORT(
		clk_i : IN std_logic;          
		bcd_o : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_counterBCD: counterBCD PORT MAP(
		clk_i => ,
		bcd_o => 
	);


