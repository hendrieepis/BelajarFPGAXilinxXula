--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:35:31 11/06/2013
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/simpleGate/SimpeGateTestBench.vhd
-- Project Name:  simpleGate
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SimpleGate
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
 
ENTITY SimpeGateTestBench IS
END SimpeGateTestBench;
 
ARCHITECTURE behavior OF SimpeGateTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SimpleGate
    PORT(
         inA : IN  std_logic_vector(3 downto 0);
         OutY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal inA : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal OutY : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SimpleGate PORT MAP (
          inA => inA,
          OutY => OutY
        );

 

   -- Stimulus process
   stim_proc1: process
   begin		
      wait;
   end process;

END;
