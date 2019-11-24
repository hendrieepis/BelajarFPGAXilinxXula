
-- VHDL Instantiation Created from source file decoder.vhd -- 17:48:53 11/28/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT decoder
	PORT(
		clk : IN std_logic;
		bcd : IN std_logic_vector(3 downto 0);          
		segment7 : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	Inst_decoder: decoder PORT MAP(
		clk => ,
		bcd => ,
		segment7 => 
	);


