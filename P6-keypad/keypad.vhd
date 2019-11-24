-------------------------------------------------------------------------------
-- Title      : keypad Controller
-- Project    : Source files in two directories, custom library name, VHDL'87
-------------------------------------------------------------------------------
-- File       : keypad.vhd
-- Author     : hendri  <hendri@eepis-its.edu>
-- Created    : 2013-02-03
-- Last update: 2013-02-03
-- Platform   : Spartan 3E 
-------------------------------------------------------------------------------
-- Description: This example code of keypad controller.This result will be
-- shown in 7 segment. I used Basys2  Development board from Digilent
-------------------------------------------------------------------------------
-- Copyright (c) 2013 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2013-02-03  1.0      hendri  Created
-------------------------------------------------------------------------------

library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.all;
use UNISIM.vcomponents.all;
--use IEEE.NUMERIC_STD.all;
--use IEEE.std_logic_unsigned.all;

entity keypad is

  port(
    reset  : in  std_logic;
    keyIn  : in  std_logic_vector(3 downto 0);
    keyOut : out std_logic_vector(3 downto 0);
    DBGOut : out std_logic_vector(3 downto 0);  --Debug keypad
    DBGIn  : out std_logic_vector(3 downto 0);  --Debug Keypad
    pinSeg : out std_logic_vector(6 downto 0);  --Debug clock
    enseg  : out std_logic;
    DP     : out std_logic;
    clk_i  : in  std_logic);
end keypad;

architecture Behavioral of keypad is
  signal   pulseSig : std_logic                    := '0';
  signal   PSCClk   : std_logic                    := '0';
  signal   PSCout   : std_logic                    := '0';
  signal   sigCn    : std_logic_vector(3 downto 0) := (others => '0');
  type     ROMtable is array (0 to 15) of std_logic_vector(6 downto 0);  -- dataSevenSegment  
  constant ROMdata  : ROMtable                     :=
    (
      "1000000", "1111001", "0100100", "0110000" ,
      "0011001" , "0010010" , "0000010" , "1111000" ,
      "0000000" , "0011000" , "0001000" , "0000011" ,
      "1000110" , "0100001" , "0000110" , "0001110"
      );
begin
  Prescaller : process (clk_i)
    variable cntpsc : integer := 0;
  begin  -- process Prescaller  500.000 for 10 ms
    if rising_edge(clk_i) then
      if cntpsc < 500000/2 then
        cntpsc := cntpsc+1;
      else
        cntpsc := 0;
        PSCout <= not PSCout;
      end if;
    end if;
  end process Prescaller;

  BUFG_inst : BUFG
    port map(
      O => PSCClk,                      -- Clock buffer output
      I => PSCout                       -- Clock buffer input
      );
  enseg <= '0';

  process(PSCClk, reset)
    variable counter : integer := 0;
  begin  -- process keypad
    if reset = '1' then                 -- asynchronous reset (active low)
      DBGOut  <= (others => '0');
      counter := 0;
      pinSeg  <= ROMdata(0);
    elsif PSCClk'event and PSCClk = '1' then  -- rising clock edge
      if counter > 7 then
        counter := 0;
      end if;
      if counter <= 7 then
        pulseSig <= not pulseSig;
        case counter is
          when 0 =>
            sigCn  <= "1011";
            keyOut <= sigCn;
            DBGOut <= sigCn;
          when 1 =>
            if keyIn = "0111" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(1);
            elsif keyIn = "1011" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(2);
            elsif keyIn = "1101" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(3);
            elsif keyIn = "1110" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(10);
            end if;
          when 2 =>
            sigCn  <= "1101";
            keyOut <= sigCn;
            DBGOut <= sigCn;
          when 3 =>
            if keyIn = "0111" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(4);
            elsif keyIn = "1011" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(5);
            elsif keyIn = "1101" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(6);
            elsif keyIn = "1110" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(11);
            end if;
          when 4 =>
            sigCn  <= "1110";
            keyOut <= sigCn;
            DBGOut <= sigCn;
          when 5 =>
            if keyIn = "0111" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(7);
            elsif keyIn = "1011" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(8);
            elsif keyIn = "1101" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(9);
            elsif keyIn = "1110" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(12);
            end if;
          when 6 =>
            sigCn  <= "0111";
            keyOut <= sigCn;
            DBGOut <= sigCn;
          when others =>
            if keyIn = "0111" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(14);
            elsif keyIn = "1011" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(0);
            elsif keyIn = "1101" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(15);
            elsif keyIn = "1110" then
              DBGIn  <= keyIn;
              pinSeg <= ROMdata(13);
            end if;
        end case;
        counter := counter + 1;
      end if;
    end if;
  end process;
  DP <= pulseSig;
end Behavioral;

