LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
 
ENTITY counterseg IS
END counterseg;
 
ARCHITECTURE behavior OF counterseg IS 
 
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      --wait;
	  for i in 0 to 9 loop
        bcd <= conv_std_logic_vector(i,4);
        wait for 2 ns;
     end loop;
   end process;

END;
