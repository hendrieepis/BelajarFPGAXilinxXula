
-- VHDL Instantiation Created from source file inverter.vhd -- 09:21:10 11/28/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT inverter
	PORT(
		indata : IN std_logic_vector(7 downto 0);          
		outdata : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_inverter: inverter PORT MAP(
		indata => ,
		outdata => 
	);


