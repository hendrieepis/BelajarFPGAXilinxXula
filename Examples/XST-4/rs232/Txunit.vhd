-------------------------------------------------------------------------------
-- Title      : UART
-- Project    : UART
-------------------------------------------------------------------------------
-- File        : Txunit.vhd
-- Author      : Philippe CARTON 
--               (pc@microsystemes.com / philippe.carton2@libertysurf.fr)
-- Organization: Microsystemes
-- Created     : 15/12/2001
-- Last update : 6/05/2002
-- Platform    : Foundation 3.1i
-- Simulators  : Foundation logic simulator
-- Synthesizers: Foundation Synopsys
-- Targets     : Xilinx Spartan
-- Dependency  : IEEE std_logic_1164
-------------------------------------------------------------------------------
-- Description: Txunit is a parallel to serial unit transmitter.
-------------------------------------------------------------------------------
-- Copyright (c) notice
--    This core adheres to the GNU public license 
--
-------------------------------------------------------------------------------
-- Revisions       :
-- Revision Number :
-- Version         :
-- Date    :
-- Modifier        : name <email>
-- Description     :
--
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity TxUnit is
  port (
     Clk    : in  Std_Logic;  -- Clock signal
     Reset  : in  Std_Logic;  -- Reset input
     Enable : in  Std_Logic;  -- Enable input
     LoadA  : in  Std_Logic;  -- Asynchronous Load
     TxD    : out Std_Logic;  -- RS-232 data output
     Busy   : out Std_Logic;  -- Tx Busy
     DataI  : in  Std_Logic_Vector(7 downto 0)); -- Byte to transmit
end entity;

architecture Behaviour of TxUnit is

  component synchroniser is
  port (
     C1 : in Std_Logic;	 -- Asynchronous signal
     C :  in Std_Logic;	 -- Clock
     O :  out Std_logic);-- Synchronised signal
  end component;
  
  signal TBuff    : Std_Logic_Vector(7 downto 0); -- transmit buffer
  signal TReg     : Std_Logic_Vector(7 downto 0); -- transmit register
  signal TBufL    : Std_Logic;  -- Buffer loaded
  signal LoadS    : Std_Logic;	-- Synchronised load signal

begin
  -- Synchronise Load on Clk
  SyncLoad : Synchroniser port map (LoadA, Clk, LoadS);
  Busy <= LoadS or TBufL;

  -- Tx process
  TxProc : process(Clk, Reset, Enable, DataI, TBuff, TReg, TBufL)
  variable BitPos : INTEGER range 0 to 10; -- Bit position in the frame
  begin
     if Reset = '1' then
        TBufL <= '0';
        BitPos := 0;
        TxD <= '1';        
     elsif Rising_Edge(Clk) then        
        if LoadS = '1' then
           TBuff <= DataI;
           TBufL <= '1';
        end if;
        if Enable = '1' then
           case BitPos is
              when 0 => -- idle or stop bit
                 TxD <= '1';
                 if TBufL = '1' then -- start transmit. next is start bit
                    TReg <= TBuff;
                    TBufL <= '0';
                    BitPos := 1;
                 end if;
              when 1 => -- Start bit
                 TxD <= '0';
                 BitPos := 2;
              when others =>
                 TxD <= TReg(BitPos-2); -- Serialisation of TReg
                 BitPos := BitPos + 1;                            
           end case;
           if BitPos = 10 then -- bit8. next is stop bit
              BitPos := 0;
           end if;
        end if;
     end if;
  end process;
end Behaviour;
