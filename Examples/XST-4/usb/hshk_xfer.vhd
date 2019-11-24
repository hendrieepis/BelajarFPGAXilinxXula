----------------------------------------------------------------------------------
-- Copyright (C) 2010 Dave Vanden Bout / XESS Corp. / www.xess.com
--
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
----------------------------------------------------------------------------------
-- This module manages a handshake interface between a master
-- and a slave.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

package hshk_xfer_pckg is
  component hshk_xfer
    port (
      reset     : in    std_logic;      -- Asynchronous reset.
      clk       : in    std_logic;      -- Actions occur on rising clock edge.
      -- master-side interface
      m_din     : in    std_logic_vector;  -- Data from master to slave.
      m_dout    : out   std_logic_vector;  -- Data from slave to master.
      m_rd      : in    std_logic;  -- Master initiates a read from the slave.
      m_wr      : in    std_logic;  -- Master initiates a write to the slave.
      m_flush   : in    std_logic;  -- Master flushes any data from the slave,
      m_done    : out   std_logic;  -- Master operation is complete when this signal goes high.
      m_stall   : out   std_logic;  -- Master operation was successful when this signal goes high.
      -- slave-side interface
      s_dio     : inout std_logic_vector;  -- Databus to the slave.
      s_dirout  : out   std_logic;  -- Data is moving from master to slave when high, from slave to master when low.
      s_flush   : out   std_logic;      -- Flush the slave when high.
      s_hshkout : out   std_logic;      -- Handshake from master to slave.
      s_hshkin  : in    std_logic;      -- Handshake from slave to master.
      s_stall   : in    std_logic       -- status of slave operation.
      );
  end component;
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hshk_xfer is
  port (
    reset     : in    std_logic;        -- Asynchronous reset.
    clk       : in    std_logic;        -- Actions occur on rising clock edge.
    -- master-side interface
    m_din     : in    std_logic_vector;  -- Data from master to slave.
    m_dout    : out   std_logic_vector;  -- Data from slave to master.
    m_rd      : in    std_logic;  -- Master initiates a read from the slave.
    m_wr      : in    std_logic;  -- Master initiates a write to the slave.
    m_flush   : in    std_logic;  -- Master flushes any data from the slave,
    m_done    : out   std_logic;  -- Master operation is complete when this signal goes high.
    m_stall   : out   std_logic;  -- Master R/W operation is stalled when this signal goes high.
    -- slave-side interface
    s_dio     : inout std_logic_vector;  -- Databus to the slave.
    s_dirout  : out   std_logic;  -- Data is moving from master to slave when high, from slave to master when low.
    s_flush   : inout std_logic;        -- Flush the slave when high.
    s_hshkout : out   std_logic;        -- Handshake from master to slave.
    s_hshkin  : in    std_logic;        -- Handshake from slave to master.
    s_stall   : in    std_logic         -- R/W operation is stalled when high.
    );
end hshk_xfer;

architecture Behavioral of hshk_xfer is
  constant HIGH_Z : std_logic_vector(s_dio'range) := (others => 'Z');
  signal hshkout  : std_logic                     := '0';  -- Internal copy of s_hshkout output.
  signal hshkin   : std_logic                     := '0';  -- Sync'ed copy of s_hshkin input.
begin

  -- Master handshake output to the slave mirrors its internal copy.
  s_hshkout <= hshkout;

  -- Sync the handshake from the slave to the clock domain.
  process(clk)
  begin
    if rising_edge(clk) then
      hshkin <= s_hshkin;
    end if;
  end process;

  process (clk, reset, hshkout, hshkin)
    variable handshake_state : std_logic_vector(1 downto 0);
  begin
    handshake_state := hshkout & hshkin;
    if reset = '1' then
      s_dio   <= HIGH_Z;
      hshkout <= '0';
      s_flush <= 'Z';
      m_done  <= '0';
      m_stall <= '0';
    elsif rising_edge(clk) then
      m_done  <= '0';
      m_stall <= '0';
      case handshake_state is
        when "00" =>  -- Quiescent state: master and slave handshakes are both low.
          if m_flush = '1' then         -- Flush the slave buffer.
            s_flush  <= '1';    -- Signal the slave to flush its buffer.
            hshkout  <= '1';            -- Raise the handshake to the slave.
          elsif m_rd = '1' then         -- Read a byte of data from the slave.
            s_flush  <= '0';    -- Read operation, so no slave flush needed.
            s_dirout <= '0';    -- Data is coming from the slave to the master.
            s_dio    <= HIGH_Z;         -- Let the slave drive the data bus.
            hshkout  <= '1';            -- Raise the handshake to the slave.
          elsif m_wr = '1' then  -- Write a byte of data from the master to the slave.
            s_flush  <= '0';    -- Write operation, so no slave flush needed.
            s_dirout <= '1';    -- Data is coming from the master to the slave.
            s_dio    <= m_din;  -- The master drives the databus with the data.
            hshkout  <= '1';            -- Raise the handshake to the slave.
          else                          -- Do nothing.
            hshkout <= '0';  -- Nothing to do so don't bother the slave.
          end if;
        when "10" =>  -- Waiting for the slave to acknowledge the handshake from the master.
          null;
        when "11" =>  -- Slave has acknowledged the handshake from the master.
          if s_stall = '1' then
            m_stall <= '1';  -- Signal a stall to the master if the slave has stalled the transfer.
          else
            if m_rd = '1' then
              m_dout <= s_dio;  -- Latch the data from the slave if the master requested a read op.
            end if;
            s_flush <= 'Z';             -- Release the slave flush signal.
            s_dio   <= HIGH_Z;          -- Release the databus.
            m_done  <= '1';  -- Raise done signal to master. It will be lowered again in one cycle.
            hshkout <= '0';  -- Lower the master handshake to begin terminating the transfer.
          end if;
        when "01" =>  -- Waiting for slave to lower its handshake so we can return to quiescent state.
          null;       -- done and stall signals to master will be lowered here.
        when others =>
          s_dio   <= HIGH_Z;
          hshkout <= '0';
          s_flush <= 'Z';
      end case;
    end if;
  end process;

end Behavioral;

