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
    clk        : in  std_logic;
    kb_clk     : in  std_logic;
    kb_data    : in  std_logic;
    display    : out std_logic_vector(7 downto 0);
    outClk25Hz : out std_logic);
end keyboard;

architecture Behavioral of keyboard is
  signal cntDiv    : integer   := 0;
  signal clk25Hz   : std_logic := '0';
  signal divref    : integer   := 1000000;
  signal shiftData : std_logic_vector (8 downto 0);
begin  -- Behavioral

  procDiv : process (clk)
  begin  -- process clk25Hz
    if rising_edge(clk) then
      cntDiv <= cntDiv+1;
      if cntDiv = divref then
        clk25Hz <= not clk25Hz;
        cntDiv  <= 0;
      end if;
    end if;
  end process ProcDiv;
  outClk25Hz <= clk25Hz;

  main : process (clk25Hz, reset)
  begin  -- process main
    if reset = '0' then                 -- asynchronous reset (active low)
      display <= (others => '0');
    elsif rising_edge(clk25Hz) then     -- rising clock edge
      shiftData(8 downto 1) <= shiftData(7 downto 0);
      shiftData(0)          <= kb_data;
    end if;
  end process main;
end Behavioral;



