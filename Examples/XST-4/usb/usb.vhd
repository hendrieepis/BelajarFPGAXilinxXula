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
-- This module uses the handshake transfer module to receive
-- data from the USB port, perform an operation on it, and send
-- it back.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.hshk_xfer_pckg.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity usb is
  port (clk           : in    std_logic;
        reset_n       : in    std_logic;  -- active-low reset input
        dio           : inout std_logic_vector (7 downto 0);
        dirout        : out   std_logic;
        flush         : out   std_logic;
        hshkout       : out   std_logic;
        hshkin        : in    std_logic;
        stall         : in    std_logic;
        ethernet_cs_n : out   std_logic   -- ethernet chip-enable
        );
end usb;

architecture Behavioral of usb is
  type FSM_STATE is (READ_FROM_SLAVE, WRITE_TO_SLAVE);
  signal state   : FSM_STATE := READ_FROM_SLAVE;
  signal m_din   : std_logic_vector(dio'range);
  signal m_dout  : std_logic_vector(dio'range);
  signal data    : std_logic_vector(dio'range);
  signal reset   : std_logic;
  signal m_rd    : std_logic;
  signal m_wr    : std_logic;
  signal m_stall : std_logic;
  signal m_done  : std_logic;
begin
  process(clk, reset_n)
  begin
    if reset_n = '0' then
      reset <= '1'; -- Reset the handshake interface module.
      m_rd  <= '0';
      m_wr  <= '0';
      state <= READ_FROM_SLAVE;
    elsif rising_edge(clk) then
	  reset <= '0'; -- Release handshake interface module from reset.
      case state is
        when READ_FROM_SLAVE =>
		  -- Perform a read operation from the slave.
		  -- Stay in this state until the read operation completes.
          m_rd  <= '1';
          if m_done = '1' then
            data  <= m_dout; -- Store the received data.
            m_rd  <= '0'; -- Stop reading data.
            state <= WRITE_TO_SLAVE; -- Go to next state.
          end if;
        when WRITE_TO_SLAVE =>
		  -- Perform a write operation to the slave.
		  -- Stay in this state until the write operation completes.
          m_wr  <= '1';
          m_din <= data + 7; -- Write back the received data + 7
          if m_done = '1' then
            m_wr  <= '0'; -- Stop writing the data.
            state <= READ_FROM_SLAVE; -- Go back and read the next byte of data.
          end if;
        when others =>
          state <= READ_FROM_SLAVE;
      end case;
    end if;
  end process;

  -- Connections to the handshake interface module.
  u1 : hshk_xfer
    port map (
      clk       => clk,
      reset     => reset,
      m_din     => m_din,
      m_dout    => m_dout,
      m_rd      => m_rd,
      m_wr      => m_wr,
      m_flush   => '0', -- No flushing is done in this example.
      m_done    => m_done,
      m_stall   => m_stall,
      s_dio     => dio,
      s_dirout  => dirout,
      s_flush   => flush,
      s_hshkout => hshkout,
      s_hshkin  => hshkin,
      s_stall   => stall
      );

-- Disable the Ethernet controller so it can't interfere with the peripheral bus
-- that is also used by the USB interface.
  ethernet_cs_n <= '1';

end Behavioral;

