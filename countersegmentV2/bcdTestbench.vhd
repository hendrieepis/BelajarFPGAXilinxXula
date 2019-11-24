--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:45:50 12/02/2012
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/PBsegmentV2/bcdTestbench.vhd
-- Project Name:  PBsegmentV2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counterBCD
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
 
ENTITY bcdTestbench IS
END bcdTestbench;
 
ARCHITECTURE behavior OF bcdTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counterBCD
    PORT(
         clk_i : IN  std_logic;
         bcd_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';

 	--Outputs
   signal bcd_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counterBCD PORT MAP (
          clk_i => clk_i,
          bcd_o => bcd_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
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
