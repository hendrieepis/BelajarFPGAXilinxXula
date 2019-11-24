--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:13:31 02/02/2013
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/P6-keypad/keypadTestbench.vhd
-- Project Name:  P6-keypad
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keypad
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
 
ENTITY keypadTestbench IS
END keypadTestbench;
 
ARCHITECTURE behavior OF keypadTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keypad
    PORT(
         reset : IN  std_logic;
         keyIn : IN  std_logic_vector(3 downto 0);
         keyOut : OUT  std_logic_vector(3 downto 0);
         dataout : OUT  std_logic_vector(7 downto 0);
         Strobe : OUT  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal keyIn : std_logic_vector(3 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal keyOut : std_logic_vector(3 downto 0);
   signal dataout : std_logic_vector(7 downto 0);
   signal Strobe : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keypad PORT MAP (
          reset => reset,
          keyIn => keyIn,
          keyOut => keyOut,
          dataout => dataout,
          Strobe => Strobe,
          clk => clk
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
    reset <= '0';
    wait for 100ns;
    reset <= '1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
