--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:51:58 12/02/2012
-- Design Name:   
-- Module Name:   /home/hendri/Documents/workspaceXilinx/PBsegmentV2/decoderTestbench.vhd
-- Project Name:  PBsegmentV2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder
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
use IEEE.std_logic_arith.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY decoderTestbench IS
END decoderTestbench;
 
ARCHITECTURE behavior OF decoderTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder
    PORT(
         clk : IN  std_logic;
         bcd : IN  std_logic_vector(3 downto 0);
         segment7 : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal bcd : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal segment7 : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder PORT MAP (
          clk => clk,
          bcd => bcd,
          segment7 => segment7
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
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for clk_period*10;
--
--      -- insert stimulus here 
--
--   for i in 0 to 9 loop
--     bcd <= CONV_STD_LOGIC_VECTOR(i, 4);
--   end loop;
     -- hold reset state for 100 ns.
  --    wait for 100 ns;

   --   wait for clk_period*10;

      -- insert stimulus here 

      --wait;
          for i in 0 to 9 loop
        bcd <= conv_std_logic_vector(i,4);
       wait for clk_period/3;
     end loop;

   end process;

END;
