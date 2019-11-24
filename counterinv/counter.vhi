
-- VHDL Instantiation Created from source file counter.vhd -- 09:20:45 11/28/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT counter
	PORT(
		clk_i : IN std_logic;          
		systick : OUT std_logic;
		counter_o : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_counter: counter PORT MAP(
		clk_i => ,
		systick => ,
		counter_o => 
	);


