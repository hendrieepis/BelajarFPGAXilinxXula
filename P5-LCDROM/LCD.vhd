LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY LCD IS
END LCD;
 
ARCHITECTURE behavior OF LCD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ROM
    PORT(
         dataOut : OUT  std_logic_vector(7 downto 0);
         reset : IN  std_logic;
         Rs : OUT  std_logic;
         En : OUT  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal dataOut : std_logic_vector(7 downto 0);
   signal Rs : std_logic;
   signal En : std_logic;

   -- Clock period definitions
   constant clk_period : time :=83.3 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ROM PORT MAP (
          dataOut => dataOut,
          reset => reset,
          Rs => Rs,
          En => En,
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
		reset <='0';
		wait for 100 ns;	
		reset <='1';

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
