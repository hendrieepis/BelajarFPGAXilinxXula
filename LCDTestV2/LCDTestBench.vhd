LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY LCDTestBench IS
END LCDTestBench;
 
ARCHITECTURE behavior OF LCDTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LCDTest
    PORT(
         dataLCD : OUT  std_logic_vector(3 downto 0);
         en : OUT  std_logic;
         rs : OUT  std_logic;
         reset : IN  std_logic;
         clock : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal dataLCD : std_logic_vector(3 downto 0);
   signal en : std_logic;
   signal rs : std_logic;

   -- Clock period definitions
   constant clock_period : time := 83.3 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LCDTest PORT MAP (
          dataLCD => dataLCD,
          en => en,
          rs => rs,
          reset => reset,
          clock => clock
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
--      wait for 100 ns;	

--      wait for clock_period*10;

      -- insert stimulus here 

--      wait;
   wait for 500ns;
	reset <= '1';
   end process;
END;
