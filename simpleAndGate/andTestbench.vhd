--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:06:59 11/15/2013
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/simpleAndGate/andTestbench.vhd
-- Project Name:  simpleAndGate
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: andvhdl
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY andTestbench IS
END andTestbench;
 
ARCHITECTURE behavior OF andTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT andvhdl
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         f : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal f : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: andvhdl PORT MAP (
          a => a,
          b => b,
          f => f
        );


   -- Stimulus process
   stim_proc1: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		a <= not a;
   end process;
	
	   stim_proc2: process
   begin		
      -- hold reset state for 100 ns.
      wait for 50 ns;	
		b <= not b;
   end process;

END;
