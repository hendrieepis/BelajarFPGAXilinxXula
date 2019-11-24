-- Vhdl test bench created from schematic /home/hendri/Documents/workspaceXilinx/simpleSchematic/simple.sch - Mon Nov 11 08:57:06 2013
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY simple_simple_sch_tb IS
END simple_simple_sch_tb;
ARCHITECTURE behavioral OF simple_simple_sch_tb IS 

   COMPONENT simple
   PORT( a	:	IN	STD_LOGIC; 
          b	:	IN	STD_LOGIC; 
          f	:	OUT	STD_LOGIC; 
          c	:	IN	STD_LOGIC);
   END COMPONENT;

   SIGNAL a	:	STD_LOGIC;
   SIGNAL b	:	STD_LOGIC;
   SIGNAL f	:	STD_LOGIC;
   SIGNAL c	:	STD_LOGIC;

BEGIN

   UUT: simple PORT MAP(
		a => a, 
		b => b, 
		f => f, 
		c => c
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      WAIT for 25 ns; -- will wait forever
		c <= not c;
   END PROCESS;
	
	tb1 : PROCESS
   BEGIN
      WAIT for 50 ns; -- will wait forever
		b <= not b;
   END PROCESS;
	
	tb2 : PROCESS
   BEGIN
      WAIT for 100 ns; -- will wait forever
		a <= not a;
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
