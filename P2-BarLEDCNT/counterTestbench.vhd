--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:04:22 11/25/2012
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/counter/counterTestbench.vhd
-- Project Name:  counter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter
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
 
ENTITY counterTestbench IS
END counterTestbench;
 
ARCHITECTURE behavior OF counterTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
    PORT(
         clk_i : IN  std_logic;
         reset : IN  std_logic;
         counter_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal counter_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 83.3 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          clk_i => clk_i,
          reset => reset,
          counter_o => counter_o
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
