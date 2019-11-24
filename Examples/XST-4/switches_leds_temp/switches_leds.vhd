--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 01/28/2006
-- Copyright     : 2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    This design	takes two four-bit numbers entered through the DIP switch of 
--    the XST-3.0 Board and displays their sum or difference on the LED digits.
--
-- Revision:
--    1.0.0
--
-- Additional Comments:
--    1.0.0:
--        Initial release.
--
-- License:
--    This code can be freely distributed and modified as long as
--    this header is not removed.
--------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity switches_leds is
  port ( a          : in  std_logic_vector(3 downto 0); -- 4-bit operand
         b          : in  std_logic_vector(3 downto 0);	-- 4-bit operand
         lsdigit    : out std_logic_vector(6 downto 0);	-- least-signif. digit of result
         msdigit    : out std_logic_vector(6 downto 0);	-- most-signif. digit of result
         op         : in  std_logic_vector(0 downto 0);	-- arithmetic operation selector
         ether_cs_n : out std_logic -- Ethernet chip-enable
				);
end switches_leds;


architecture Behavioral of switches_leds is

  -- Here are the possible arithmetic operations for this circuit.
  constant ADD            :     std_logic_vector(0 downto 0) := "1";
  constant SUBTRACT       :     std_logic_vector(0 downto 0) := "0";

  signal   c              :     std_logic_vector(7 downto 0); -- result of the operation

	-- declaration for the LED decoder used to convert the result for display.
  component
    led_decoder port ( i  : in  std_logic_vector(3 downto 0);
                       o  : out std_logic_vector(6 downto 0));
  end component;

begin

  -- Disable the Ethernet controller so it can't interfere with the peripheral bus
	-- that is also used by the switches and LEDs.
  ether_cs_n <= '1';
	
	-- Perform the addition or subtraction depending upon the operation selector.
	-- Note that the operands are extended from four to eight bits each so we will
	-- get an eight-bit result.
  process(a, b, op)
  begin
    if op = ADD then
      c      <= ("0000" & a) + ("0000" & b);
    else
      c      <= ("0000" & a) - ("0000" & b);
    end if;
  end process;

  -- display the upper and lower nybbles of the result on the LED digits
  least_significant_digit :     led_decoder port map(i => c(3 downto 0), o => lsdigit);
  most_significant_digit  :     led_decoder port map(i => c(7 downto 4), o => msdigit);

end Behavioral;



--------------------------------------------------------------------
-- Description:
--    This design	takes a four-bit number and generates the appropriate
--    pattern that will display the corresponding hexadecimal number on
--    a 7-segment LED.
--
-- Revision:
--    1.0.0
--
-- Additional Comments:
--    1.0.0:
--        Initial release.
--------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity led_decoder is
  port ( i : in  std_logic_vector(3 downto 0);
         o : out std_logic_vector(6 downto 0));
end led_decoder;

architecture Behavioral of led_decoder is
  constant DIGIT_ZERO  : std_logic_vector(6 downto 0) := "0111111";
  constant DIGIT_ONE   : std_logic_vector(6 downto 0) := "0000110";
  constant DIGIT_TWO   : std_logic_vector(6 downto 0) := "1011011";
  constant DIGIT_THREE : std_logic_vector(6 downto 0) := "1001111";
  constant DIGIT_FOUR  : std_logic_vector(6 downto 0) := "1100110";
  constant DIGIT_FIVE  : std_logic_vector(6 downto 0) := "1101101";
  constant DIGIT_SIX   : std_logic_vector(6 downto 0) := "1111101";
  constant DIGIT_SEVEN : std_logic_vector(6 downto 0) := "0000111";
  constant DIGIT_EIGHT : std_logic_vector(6 downto 0) := "1111111";
  constant DIGIT_NINE  : std_logic_vector(6 downto 0) := "1101111";
  constant LETTER_A    : std_logic_vector(6 downto 0) := "1110111";
  constant LETTER_B    : std_logic_vector(6 downto 0) := "1111100";
  constant LETTER_C    : std_logic_vector(6 downto 0) := "0111001";
  constant LETTER_D    : std_logic_vector(6 downto 0) := "1011110";
  constant LETTER_E    : std_logic_vector(6 downto 0) := "1111001";
  constant LETTER_F    : std_logic_vector(6 downto 0) := "1110001";
begin
  with i select
    o <= DIGIT_ZERO when "0000",
    DIGIT_ONE       when "0001",
    DIGIT_TWO       when "0010",
    DIGIT_THREE     when "0011",
    DIGIT_FOUR      when "0100",
    DIGIT_FIVE      when "0101",
    DIGIT_SIX       when "0110",
    DIGIT_SEVEN     when "0111",
    DIGIT_EIGHT     when "1000",
    DIGIT_NINE      when "1001",
    LETTER_A        when "1010",
    LETTER_B        when "1011",
    LETTER_C        when "1100",
    LETTER_D        when "1101",
    LETTER_E        when "1110",
    LETTER_F        when others;
end Behavioral;
