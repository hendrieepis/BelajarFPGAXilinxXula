--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:02:19 12/02/2012
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/PBsegmentV2/pscTestBench.vhd
-- Project Name:  PBsegmentV2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Prescaller
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
 
ENTITY pscTestBench IS
END pscTestBench;
 
ARCHITECTURE behavior OF pscTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Prescaller
    PORT(
         clk_i : IN  std_logic;
         clkpsc : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';

 	--Outputs
   signal clkpsc : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 83.3 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Prescaller PORT MAP (
          clk_i => clk_i,
          clkpsc => clkpsc
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
   clkpsc_process :process
   begin
		clkpsc <= '0';
		wait for clkpsc_period/2;
		clkpsc <= '1';
		wait for clkpsc_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
