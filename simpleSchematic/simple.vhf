--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : simple.vhf
-- /___/   /\     Timestamp : 11/11/2013 08:50:51
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl /home/hendri/Documents/workspaceXilinx/simpleSchematic/simple.vhf -w /home/hendri/Documents/workspaceXilinx/simpleSchematic/simple.sch
--Design Name: simple
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity simple is
   port ( a : in    std_logic; 
          b : in    std_logic; 
          c : in    std_logic; 
          f : out   std_logic);
end simple;

architecture BEHAVIORAL of simple is
   attribute BOX_TYPE   : string ;
   signal XLXN_11 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
begin
   XLXI_14 : AND2
      port map (I0=>b,
                I1=>a,
                O=>XLXN_11);
   
   XLXI_15 : AND2
      port map (I0=>c,
                I1=>XLXN_11,
                O=>f);
   
end BEHAVIORAL;


