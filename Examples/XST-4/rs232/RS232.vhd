--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 01/28/2006
-- Copyright     : 2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    This is a simple design example that echoes characters received through the 
--    RS232 port of the XST-3.0 Board back to the sending terminal.
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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity rs232 is
  port
    (
      clk           : in  std_logic;    -- 50 MHz clock on XSA Board
      td            : out std_logic;    -- RS232 transmitter line
      rd            : in  std_logic;    -- RS232 receiver line
      reset_n       : in  std_logic;    -- active-low reset input
      barled        : out std_logic_vector(8 downto 1);  -- bargraph LED
      ethernet_cs_n : out std_logic     -- Ethernet chip-enable
      );
end rs232;


architecture arch of rs232 is

  -- declaration for the UAR transmitter/receiver module
  component UART is
                   generic(BRDIVISOR :     integer range 0 to 65535 := 130);  -- Baud rate divisor
                 port (
-- Wishbone signals
                   WB_CLK_I          : in  std_logic;  -- clock
                   WB_RST_I          : in  std_logic;  -- Reset input
                   WB_ADR_I          : in  std_logic_vector(1 downto 0);  -- Adress bus          
                   WB_DAT_I          : in  std_logic_vector(7 downto 0);  -- DataIn Bus
                   WB_DAT_O          : out std_logic_vector(7 downto 0);  -- DataOut Bus
                   WB_WE_I           : in  std_logic;  -- Write Enable
                   WB_STB_I          : in  std_logic;  -- Strobe
                   WB_ACK_O          : out std_logic;  -- Acknowledge
-- process signals     
                   IntTx_O           : out std_logic;  -- Transmit interrupt: indicate waiting for Byte
                   IntRx_O           : out std_logic;  -- Receive interrupt: indicate Byte received
                   BR_Clk_I          : in  std_logic;  -- Clock used for Transmit/Receive
                   TxD_PAD_O         : out std_logic;  -- Tx RS232 Line
                   RxD_PAD_I         : in  std_logic);  -- Rx RS232 Line     
  end component;

  signal reset              : std_logic;  -- inversion of reset signal
  signal rcv, tx, tx_x      : std_logic_vector(7 downto 0);  -- receive/transmit character data
  signal write, strobe, ack : std_logic;  -- Wishbone interface control signals
  signal td_rdy, rd_rdy     : std_logic;  -- UART transmit/receive ready flags
  signal reg0               : std_logic_vector(1 downto 0);  -- register address for UART module
  type fsm_state is (read_char_state, write_char_state);  -- FSM states
  signal state, state_x     : fsm_state;  -- FSM state variable

begin

  -- Disable the Ethernet controller so it can't interfere with the peripheral bus
  -- that is also used by the switches and LEDs.
  ethernet_cs_n <= '1';

  -- The UART module needs an active-high reset, so invert it.
  reset <= not reset_n;

  -- UART register 0 is used to get data in and out of the UART module, so set the
  -- register address to 0 whenever the receiver has received a character or the
  -- transmitter is ready to send a character.
  reg0 <= "0" & not(rd_rdy or td_rdy);

  -- Instantiation of the UART module.
  u1 : uart
    generic map(
      -- The baud-rate divisor is calculated by dividing the clock frequency by
      -- the baud-rate and then dividing again by four (because the UART receiver
      -- module samples four times within each bit interval).  So for a 50 MHz clock
      -- and a baud-rate of 9600 bps, the divisor is (50,000,000 / 9600) / 4 = 1302.
      brdivisor => 1302
      )
    port map(
      wb_clk_i  => clk,
      wb_rst_i  => reset,
      wb_adr_i  => reg0,
      wb_dat_i  => tx,
      wb_dat_o  => rcv,
      wb_we_i   => write,
      wb_stb_i  => strobe,
      wb_ack_o  => ack,
      inttx_o   => td_rdy,
      intrx_o   => rd_rdy,
      br_clk_i  => clk,
      txd_pad_o => td,
      rxd_pad_i => rd
      );

  barled <= tx;                         -- Display the current character on the bargraph LEDs.

  -- The combinational part of a simple FSM that repeatedly waits for a character to be 
  -- received and then echoes the character back to the sender.
  process(rcv, td_rdy, rd_rdy, state)
  begin
    -- Set the default values of these signals so they don't inadvertently become latches.
    state_x       <= state;             -- Next state is the same as the current state.
    tx_x          <= tx;                -- Next character to transmit is the same as the current character.
    strobe        <= '0';               -- Don't initiate a Wishbone transaction.
    write         <= '0';               -- Don't write data to the UART.
    case state is
      when read_char_state  =>
        if rd_rdy = '1' then            -- Wait for the UART receiver to signal a character is ready.
          -- A character was received by the UART so ...
          strobe  <= '1';               -- activate the Wishbone bus, ...
          tx_x    <= rcv;               -- place the received character into the transmit character register, ...
          state_x <= write_char_state;  -- and go to the next state where the character will be echoed.
        end if;
      when write_char_state =>
        if td_rdy = '1' then            -- Wait for the UART transmitter to be ready to accept a character.
          -- The UART transmitter is available so ...
          strobe  <= '1';               -- activate the Wishbone bus ...
          write   <= '1';               -- write data in the transmit character register to the UART, ...
          state_x <= read_char_state;   -- and go back to wait for another character to be received.
        end if;
      when others           =>
        -- If the FSM is in some illegal state, then go back to the start and wait
        -- for a character to be received.
        state_x   <= read_char_state;
    end case;
  end process;

  -- The sequential part of the FSM that updates the signals with their next values.
  process(clk, reset)
  begin
    if reset = '1' then
      state <= read_char_state;         -- On reset, start off waiting to receive a character.
    elsif rising_edge(clk) then
      tx    <= tx_x;
      state <= state_x;
    end if;
  end process;

end arch;
