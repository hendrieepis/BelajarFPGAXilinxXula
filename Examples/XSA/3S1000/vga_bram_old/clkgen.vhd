----------------------------------------------------------------------------------
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-- 02111-1307, USA.
--
-- ©1997-2010 - X Engineering Software Systems Corp.
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:18:33 09/21/2010 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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

package ClkGen_pckg is

  component ClkGen
    generic (
      BASE_FREQ : real                  := 12.0;  -- input frequency in MHz
      CLK_MUL   : natural range 1 to 32 := 25;    -- frequency multiplier
      CLK_DIV   : natural range 1 to 32 := 3      -- frequency divider
      );
    port (
      I : in  std_logic;                          -- clock input
      O : out std_logic                           -- generated clock output
      );
  end component;

end package;


library IEEE;
use IEEE.STD_LOGIC_1164.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity ClkGen is
  generic (
    BASE_FREQ : real                  := 100.0;  -- input frequency in MHz
    CLK_MUL   : natural range 2 to 32 := 2;      -- frequency multiplier
    CLK_DIV   : natural range 1 to 32 := 2       -- frequency divider
    );
  port (
    I : in  std_logic;                           -- clock input
    O : out std_logic                            -- generated clock output
    );
end ClkGen;

architecture Behavioral of ClkGen is
begin

  u0 : DCM
    generic map (
      CLKDV_DIVIDE          => 2.0,
      CLKFX_DIVIDE          => CLK_DIV,  --  Can be any interger from 1 to 32
      CLKFX_MULTIPLY        => CLK_MUL,  --  Can be any integer from 1 to 32
      CLKIN_DIVIDE_BY_2     => false,  --  TRUE/FALSE to enable CLKIN divide by two feature
      CLKIN_PERIOD          => 1000.0 / BASE_FREQ,  --  Specify period of input clock in ns
      CLKOUT_PHASE_SHIFT    => "NONE",  --  Specify phase shift of NONE, FIXED or VARIABLE
      CLK_FEEDBACK          => "NONE",  --  Specify clock feedback of NONE, 1X or 2X
      DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
      DFS_FREQUENCY_MODE    => "LOW",   --  HIGH or LOW frequency mode for DLL
      DLL_FREQUENCY_MODE    => "LOW",   --  HIGH or LOW frequency mode for DLL
      DUTY_CYCLE_CORRECTION => true,   --  Duty cycle correction, TRUE or FALSE
      FACTORY_JF            => X"C080",
      PHASE_SHIFT           => 0,  --  Amount of fixed phase shift from -255 to 255
      STARTUP_WAIT          => false)  --  Delay configuration DONE until DCM LOCK, TRUE/FALSE
    port map (
      RST   => '0',                     -- DCM asynchronous reset input
      CLKIN => I,                  -- Clock input (from IBUFG, BUFG or DCM)
      CLKFX => O                        -- Generated clock output
      );

end Behavioral;
