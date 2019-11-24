library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncing is
    Port ( clk_i : in  STD_LOGIC;
           dbin : in  STD_LOGIC;
           dbout : out  STD_LOGIC);
end debouncing;


architecture Behavioral of debouncing is
signal Q1, Q2, Q3 : std_logic;
begin
A: process(clk_i)
begin
   if (clk_i'event and clk_i = '1') then
         Q1 <= dbin;
         Q2 <= Q1;
         Q3 <= Q2;
   end if;
end process;

B: process(clk_i)
begin
   if (clk_i'event and clk_i = '1') then
        dbout <= Q1 and Q2 and (not Q3);
   end if;
end process;

end Behavioral;
