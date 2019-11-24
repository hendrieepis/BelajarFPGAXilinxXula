--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:25:06 11/28/2012
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/counterinv/counterTestbench.vhd
-- Project Name:  counterinv
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: countersys
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
 
    COMPONENT countersys
    PORT(
         clk : IN  std_logic;
         systick : OUT  std_logic;
         countp : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal systick : std_logic;
   signal countp : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 83.3 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: countersys PORT MAP (
          clk => clk,
          systick => systick,
          countp => countp
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
