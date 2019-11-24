----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:40 02/25/2013 
-- Design Name: 
-- Module Name:    keyboard - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
entity keyboard is
  
  port (
    reset      : in  std_logic;
    kb_clk     : in  std_logic;
    kb_data    : in  std_logic;
    display    : out std_logic_vector(7 downto 0));
end keyboard;

architecture Behavioral of keyboard is
--  signal cntDiv    : integer   := 0;
--  signal clk25Hz   : std_logic := '0';
--  signal divref    : integer   := 1000000;
  signal shiftData : std_logic_vector (7 downto 0):="00000000";
  type   stateType is (stStart, st0, st1, st2, st3, st4, st5, st6, st7, stparity, stStop);
  signal state     : stateType := stStart;
begin  -- Behavioral

--  procDiv : process (clk)
--  begin  -- process clk25Hz
--    if rising_edge(clk) then
--      cntDiv <= cntDiv+1;
--      if cntDiv = divref then
--        clk25Hz <= not clk25Hz;
--        cntDiv  <= 0;
--      end if;
--    end if;
--  end process ProcDiv;
--  outClk25Hz <= clk25Hz;

  fsm : process (kb_clk, kb_data, reset)
  begin  -- process fsm
    if reset = '1' then                 -- asynchronous reset (active low)
      state <= stStart;
    elsif rising_edge(kb_clk) then      -- rising clock edge
      case state is
        when stStart =>
          state <= st0;
        when st0 =>
          state <= st1;
        when st1 =>
          state <= st2;
        when st2 =>
          state <= st3;
        when st3 =>
          state <= st4;
        when st4 =>
          state <= st5;
        when st5 =>
          state <= st6;
        when st6 =>
          state <= st7;
        when st7 =>
          state <= stparity;
        when stparity =>
          state <= stStop;
        when stStop =>
          state <= stStart;
        when others => null;
      end case;
    end if;
  end process fsm;

  -- purpose: output state
  -- type   : combinational
  -- inputs : state
  -- outputs: 
  fsmOutput : process (state)
  begin  -- process fsmOutput
    case state is
      when st0 =>
        shiftData(0) <= kb_data;
      when st1 =>
        shiftData(1) <= kb_data;
      when st2 =>
        shiftData(2) <= kb_data;
      when st3 =>
        shiftData(3) <= kb_data;
      when st4 =>
        shiftData(4) <= kb_data;
      when st5 =>
        shiftData(5) <= kb_data;
      when st6 =>
        shiftData(6) <= kb_data;
      when st7 =>
        shiftData(7) <= kb_data;
      when stStop=>
        display<=shiftData;
      when others => null;
    end case;
  end process fsmOutput;
 --display <= shiftData;
end Behavioral;



