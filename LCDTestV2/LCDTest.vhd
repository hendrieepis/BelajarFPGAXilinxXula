--Please maintain this header statement
--     http://www.pyroelectro.com
--if you use this code. Thank You!!!!!
--Created by Chris @ PyroElectro.com

--
--
	--Necessary Header Files
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

	--Define The Core Entity
ENTITY LCD IS
PORT(   
		--Counter/VGA Timing
		CLK		: IN STD_LOGIC;
		
		--LCD Control Signals
		LCD_ENABLE 	: OUT STD_LOGIC;
		LCD_RW 	: OUT STD_LOGIC;
		LCD_RS 	: OUT STD_LOGIC;
		
		--LCD Data Signals
		LCD_DATA 	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end LCD;

	--Define The Architecture Of The Entity
ARCHITECTURE behavior of LCD IS

type state_type is (	S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, 
							S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, 
							S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, 
							S30, S31, S32, S33, S34, S35, S36, S37, S38, S39, IDLE);
signal current_state: state_type;

BEGIN

PROCESS
VARIABLE cnt: INTEGER RANGE 0 TO 1750000;
BEGIN

WAIT UNTIL(clk'EVENT) AND (clk = '1');

	--Count Clock Ticks
	IF(cnt = 1750000)THEN		
		cnt := 0;
	ELSE
		cnt := cnt  + 1;
	END IF;

	--Slowly Move Into Next States
	IF(cnt = 1500000)THEN		
	--Next State Logic
	
		case current_state is

		
-------------------Function Set-------------------
			 when S0 =>
				current_state <= S1;
				
				LCD_DATA		<= "00110000";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';

			 when S1 =>
				current_state <= S2;

				LCD_DATA		<= "00110000";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S2 =>
				current_state <= S3;

				LCD_DATA		<= "00110000";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';

-------------------Reset Display-------------------				
			 when S3 =>
				current_state <= S4;

				LCD_DATA		<= "00000001";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S4 =>
				current_state <= S5;

				LCD_DATA		<= "00000001";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';	
				
			 when S5 =>
				current_state <= S6;				
				
				LCD_DATA		<= "00000001";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';

-------------------Display On-------------------				
			 when S6 =>
				current_state <= S7;					

				LCD_DATA		<= "00001110";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S7 =>
				current_state <= S8;
	
				LCD_DATA		<= "00001110";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S8 =>
				current_state <= S9;	

				LCD_DATA		<= "00001110";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
				
-------------------Write 'P'-------------------				
			 when S9 =>
				current_state <= S10;			

				LCD_DATA		<= x"50";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
			 when S10 =>
				current_state <= S11;

				LCD_DATA		<= x"50";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
-------------------WRITE 'Y'-------------------						
			 when S11 =>
				current_state <= S12;				

				LCD_DATA		<= X"59";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
						
			 when S12 =>
				current_state <= S13;	
				
				LCD_DATA		<= X"59";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';						
				
-------------------WRITE 'R'-------------------						
			 when S13 =>
				current_state <= S14;				
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
			 when S14 =>
				current_state <= S15;
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		

-------------------WRITE 'O'-------------------							
			 when S15 =>
				current_state <= S16;
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
			 when S16 =>
				current_state <= S17;
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
-------------------WRITE 'E'-------------------					
			 when S17 =>
				current_state <= S18;	
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S18 =>
				current_state <= S19;
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'L'-------------------					
			 when S19 =>
				current_state <= S20;	
				LCD_DATA		<= X"4C";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S20 =>
				current_state <= S21;
				LCD_DATA		<= X"4C";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'E'-------------------					
			 when S21 =>
				current_state <= S22;	
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S22 =>
				current_state <= S23;
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'C'-------------------					
			 when S23 =>
				current_state <= S24;	
				LCD_DATA		<= X"43";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S24 =>
				current_state <= S25;
				LCD_DATA		<= X"43";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'T'-------------------					
			 when S25 =>
				current_state <= S26;	
				LCD_DATA		<= X"54";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S26 =>
				current_state <= S27;
				LCD_DATA		<= X"54";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'R'-------------------					
			 when S27 =>
				current_state <= S28;	
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S28 =>
				current_state <= S29;
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'O'-------------------					
			 when S29 =>
				current_state <= S30;	
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S30 =>
				current_state <= S31;
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE '.'-------------------					
			 when S31 =>
				current_state <= S32;	
				LCD_DATA		<= X"2E";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S32 =>
				current_state <= S33;
				LCD_DATA		<= X"2E";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
		
-------------------WRITE 'c'-------------------					
			 when S33 =>
				current_state <= S34;	
				LCD_DATA		<= X"63";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S34 =>
				current_state <= S35;
				LCD_DATA		<= X"63";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'o'-------------------					
			 when S35 =>
				current_state <= S36;	
				LCD_DATA		<= X"6F";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S36 =>
				current_state <= S37;
				LCD_DATA		<= X"6F";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			

-------------------WRITE 'm'-------------------					
			 when S37 =>
				current_state <= S38;	
				LCD_DATA		<= X"6D";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S38 =>
				current_state <= S39;
				LCD_DATA		<= X"6D";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
		
			 when S39 =>
				current_state <= IDLE;				
				
			 when IDLE	=>
				current_state <= IDLE;
				
		    when others =>
				current_state <= IDLE;		 
	
		end case;	

	END IF;
	
END PROCESS;

END behavior;