library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;


entity LCDTest is
    Port ( dataLCD : out  STD_LOGIC_VECTOR (3 downto 0);
			  en	   : OUT STD_LOGIC;
           rs 	   : OUT STD_LOGIC;
  	        reset  : in STD_LOGIC;
		     clock  : in STD_LOGIC
);
end LCDTest;

architecture Behavioral of LCDTest is
type state_value is (sta0,sta1,sta2,stb0,stb1,stb2,stc0,stc1,stc2,std0,std1,std2,
	                  ste0,ste1,ste2,ste3,ste4,ste5,stf0,stf1,stf2,stf3,stf4,stf5,
	                  stg0,stg1,stg2,stg3,stg4,stg5,sth0,sth1,sth2,sth3,sth4,sth5,
	                  sti0,sti1,sti2,sti3,sti4,sti5,stj0,stj1,stj2,stj3,stj4,stj5
							
);

signal pres_state,next_state : state_value;
signal clk_s: std_logic_vector(16 downto 0) := (others=>'0');
signal clock_o: std_logic :='0';
begin

prescaller: process (clock,clk_s)
begin
  if rising_edge(clock) then
     clk_s<=clk_s+1;
  end if;
 -- clock_o <=clk_s(16);
end process prescaller;

BUFG_inst : BUFG
   port map (
      O => clock_o,     -- Clock buffer output
      I => clk_s(16)      -- Clock buffer input
   );
--fsm register
statereg:process (clock_o,reset)
begin
  if (reset = '0') then
     pres_state<=sta0;
  elsif (clock_o='1' and clock_o'event) then
     pres_state<=next_state;
  end if;
end process statereg;

fsm: process (pres_state)
begin
  case pres_state is
--  step 1
  when sta0 => next_state <=sta1;
  when sta1 => next_state <=sta2;
  when sta2 => next_state <=stb0;

--step 2
  when stb0 => next_state <=stb1;
  when stb1 => next_state <=stb2;
  when stb2 => next_state <=stc0;
--step 3
  when stc0 => next_state <=stc1;
  when stc1 => next_state <=stc2;
  when stc2 => next_state <=std0;
--step 4     
  when std0 => next_state <=std1;
  when std1 => next_state <=std2;
  when std2 => next_state <=ste0;
--step 5
  when ste0 => next_state <=ste1;
  when ste1 => next_state <=ste2;
  when ste2 => next_state <=ste3;
  when ste3 => next_state <=ste4;
  when ste4 => next_state <=ste5;
  when ste5 => next_state <=stf0;
--step 6 function set
  when stf0 => next_state <=stf1;
  when stf1 => next_state <=stf2;
  when stf2 => next_state <=stf3;
  when stf3 => next_state <=stf4;
  when stf4 => next_state <=stf5;
  when stf5 => next_state <=stg0;
--step 7 display off
  when stg0 => next_state <=stg1;
  when stg1 => next_state <=stg2;
  when stg2 => next_state <=stg3;
  when stg3 => next_state <=stg4;
  when stg4 => next_state <=stg5;
  when stg5 => next_state <=sth0;

--step 7 entry mode set
  when sth0 => next_state <=sth1;
  when sth1 => next_state <=sth2;
  when sth2 => next_state <=sth3;
  when sth3 => next_state <=sth4;
  when sth4 => next_state <=sth5;
  when sth5 => next_state <=sti0;
--end init

-- display on
  when sti0 => next_state <=sti1;
  when sti1 => next_state <=sti2;
  when sti2 => next_state <=sti3;
  when sti3 => next_state <=sti4;
  when sti4 => next_state <=sti5;
  when sti5 => next_state <=stj0;


-- display character 'H'
  when stj0 =>  next_state <=stj1;
  when stj1 =>  next_state <=stj2;
  when stj2 =>  next_state <=stj3;
  when stj3 =>  next_state <=stj4;
  when stj4 =>  next_state <=stj5;
  when stj5 =>  next_state <=stj5;

  end case;
end process fsm;    


output :process (clock_o,pres_state)
begin
  case pres_state is
--  step 1
  when sta0=> 
         dataLCD <= "0011";
         en <= '0';
         rs <='0';
         
  when sta1 => 
         en <= '1';
  when sta2 => 
         en <= '0';
 
--step 2
  when stb0=> 
         dataLCD <= "0011";
         en <= '0';
         rs <='0';
 
  when stb1 => 
         en <= '1';
  when stb2 => 
         en <= '0';
--step 3
  when stc0=> 
         dataLCD <= "0011";
         en <= '0';
         rs <='0';
  when stc1 => 
         en <= '1';
  when stc2 => 
         en <= '0';
--step 4     
  when std0=> 
         dataLCD <= "0010";
         en <= '0';
         rs <='0';
  when std1 => 
         en <= '1';
  when std2 => 
         en <= '0';
--step 5
  when ste0=> 
         dataLCD <= "0010";
         en <= '0';
         rs <='0';
  when ste1 => 
         en <= '1';
  when ste2 => 
         en <= '0';
  when ste3=> 
         dataLCD <= "1000";
         en <= '0';
         rs <='0';
  when ste4 => 
         en <= '1';
  when ste5 => 
         en <= '0';
--step 6 function set
  when stf0=> 
         dataLCD <= "0000";
         en <= '0';
         rs <='0';
  when stf1 => 
         en <= '1';
  when stf2 => 
         en <= '0';
  when stf3=> 
         dataLCD <= "1000";
         en <= '0';
         rs <='0';
  when stf4 => 
         en <= '1';
  when stf5 => 
         en <= '0';
--step 7 display off
  when stg0=> 
         dataLCD <= "0000";
         en <= '0';
         rs <='0';
  when stg1 => 
         en <= '1';
  when stg2 => 
         en <= '0';
  when stg3=> 
         dataLCD <= "0001";
         en <= '0';
         rs <='0';
  when stg4 => 
         en <= '1';
  when stg5 => 
         en <= '0';
			------------------------
--step 8 entry mode set
  when sth0=> 
         dataLCD <= "0000";
         en <= '0';
         rs <='0';
  when sth1 => 
         en <= '1'; 
  when sth2 => 
         en <= '0';
  when sth3=> 
         dataLCD <= "0110";
         en <= '0';
         rs <='0';
  when sth4 => 
         en <= '1';
  when sth5 => 
         en <= '0';
--end init

-- display on
  when sti0=> 
         dataLCD <= "0000";
         en <= '0';
         rs <='0';
  when sti1 => 
         en <= '1'; 
  when sti2 => 
         en <= '0';
  when sti3=> 
         dataLCD <= "1110";
         en <= '0';
         rs <='0';
  when sti4 => 
         en <= '1';
  when sti5 => 
         en <= '0';
-- display character 'H'

  when stj0=> 
         dataLCD <= "0100";
         en <= '0';
         rs <='1';
  when stj1 => 
         en <= '1'; 
  when stj2 => 
         en <= '0';
  when stj3=> 
         dataLCD <= "1000";
         en <= '0';
         rs <='1';
  when stj4 => 
         en <= '1';
  when stj5 => 
         en <= '0';
  end case;
end process;

end Behavioral;