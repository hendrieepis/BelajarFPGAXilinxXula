--*********************************************************************
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
-- �2012 - X Engineering Software Systems Corp. (www.xess.com)
--*********************************************************************

--*********************************************************************
-- SD Memory Card Interface.
-- Reads/writes a single or multiple blocks of data to/from an SD flash card.
-- (Based on work by by Steven J. Merrifield, June 2008:
-- http://stevenmerrifield.com/tools/sd.vhd)
--*********************************************************************


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CommonPckg.all;

package SdCardPckg is

  component SdCardCtrl is
    generic (
      FREQ_G       : real    := 100.0;  -- Master clock frequency (MHz).
      SPI_FREQ_G   : real    := 0.4;  -- Clock frequency to the SD card (MHz).
      BLOCK_SIZE_G : natural := 512     -- Number of bytes in an SD card block.
      );
    port (
      -- Interface signals into the host.
      clk_i      : in  std_logic;       -- Master clock.
      reset_i    : in  std_logic                    := NO;  -- active-high, synchronous  reset.
      rd_i       : in  std_logic                    := NO;  -- active-high read block request.
      wr_i       : in  std_logic                    := NO;  -- active-high write block request.
      continue_i : in  std_logic                    := NO;  -- If true, inc address and continue R/W.
      addr_i     : in  std_logic_vector(31 downto 0);       -- Block address.
      data_i     : in  std_logic_vector(7 downto 0) := x"00";  -- Data to write to block.
      data_o     : out std_logic_vector(7 downto 0);  -- Data read from block.
      busy_o     : out std_logic;  -- High when controller is busy performing some operation.
      xfer_o     : out std_logic;  -- High when data is xferred between host and controller.
      -- I/O signals to the external SD card.
      cs_o       : out std_logic;       -- Active-low chip-select.
      sclk_o     : out std_logic;       -- Serial clock to SD card.
      mosi_o     : out std_logic;       -- Serial data output to SD card.
      miso_i     : in  std_logic                    := ZERO  -- Serial data input from SD card.
      );
  end component;

end package;




library ieee;
use ieee.math_real.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CommonPckg.all;

entity SdCardCtrl is
  generic (
    FREQ_G          : real    := 100.0;  -- Master clock frequency (MHz).
    INIT_SPI_FREQ_G : real    := 0.4;  -- Slow SPI clock freq. during initialization (MHz).
    SPI_FREQ_G      : real    := 25.0;  -- Operational SPI freq. to the SD card (MHz).
    BLOCK_SIZE_G    : natural := 512    -- Number of bytes in an SD card block.
    );
  port (
    -- Interface signals into the host.
    clk_i      : in  std_logic;         -- Master clock.
    reset_i    : in  std_logic                     := NO;  -- active-high, synchronous  reset.
    rd_i       : in  std_logic                     := NO;  -- active-high read block request.
    wr_i       : in  std_logic                     := NO;  -- active-high write block request.
    continue_i : in  std_logic                     := NO;  -- If true, inc address and continue R/W.
    addr_i     : in  std_logic_vector(31 downto 0);        -- Block address.
    data_i     : in  std_logic_vector(7 downto 0)  := x"00";  -- Data to write to block.
    data_o     : out std_logic_vector(7 downto 0);  -- Data read from block.
    busy_o     : out std_logic;  -- High when controller is busy performing some operation.
    xfer_o     : out std_logic;  -- High when data is xferred between host and controller.
    error_o    : out std_logic_vector(15 downto 0) := (others => NO);
    -- I/O signals to the external SD card.
    cs_o       : out std_logic;         -- Active-low chip-select.
    sclk_o     : out std_logic;         -- Serial clock to SD card.
    mosi_o     : out std_logic;         -- Serial data output to SD card.
    miso_i     : in  std_logic                     := ZERO  -- Serial data input from SD card.
    );
end entity;

architecture arch of SdCardCtrl is

  -- Data token, plus data block, plus CRC bytes.

  signal sclk_r : std_logic := ZERO;

begin
  
  process(clk_i)

    type FsmState_t is (               -- States of the SD card controller FSM.
      INIT,  -- Send initialization clock pulses to the deselected SD card.    
      SEND_CMD0,                        -- Send CMD0 to the SD card.
      SEND_CMD55,                       -- Send CMD55 to the SD card. 
      SEND_CMD41,                       -- Send CMD41 to the SD card.
      CHECK_IDLE,  -- Check if the SD card has left the IDLE state.     
      WAIT_FOR_HOST_RW,  -- Wait for the host to issue a read or write command.
      READ_START_TOKEN,  -- Scan for token at the start of block of read data. 
      READ_DATA,   -- Read a block of data from the SD card.
      READ_CRC,  -- Get the CRC that follows a block of data from the SD card.
      WRITE_DATA,  -- Write a start token, block of data and two CRC bytes.
      WRITE_BUSY_WAIT,   -- Wait for SD card to finish writing the data block.
      END_BLOCK_RW,      -- Disable SD card chip-select after each block R/W.
      TRANSMIT,                         -- Start sending command/data.
      SHIFT_OUT,   -- Shift out remaining command/data bits.
      GET_CMD_RESPONSE,  -- Get the response of the SD card to a command.
      RECEIVE                           -- Receive bits from the SD card.
      );
    variable state_v    : FsmState_t;   -- Current state of the FSM.
    variable rtnState_v : FsmState_t;  -- State FSM returns to when FSM subroutine completes.

    constant CLKS_PER_INIT_SCLK_C      : real    := FREQ_G / INIT_SPI_FREQ_G;
    constant CLKS_PER_SCLK_C           : real    := FREQ_G / SPI_FREQ_G;
    constant MAX_CLKS_PER_SCLK_C       : real    := fmax(CLKS_PER_INIT_SCLK_C, CLKS_PER_SCLK_C);
    constant MAX_CLKS_PER_SCLK_PHASE_C : natural := integer(round(MAX_CLKS_PER_SCLK_C / 2.0));
    variable clkDivider_v              : natural range 0 to MAX_CLKS_PER_SCLK_PHASE_C;
    variable clkCntr_v                 : natural range 0 to MAX_CLKS_PER_SCLK_PHASE_C;
    constant INIT_SCLK_PHASE_PERIOD_C  : natural := integer(round(CLKS_PER_INIT_SCLK_C / 2.0));
    constant SCLK_PHASE_PERIOD_C       : natural := integer(round(CLKS_PER_SCLK_C / 2.0));

    constant NUM_INIT_CLKS_C : natural := 160;  -- Number of initialization clocks to SD card.
    variable bitCnt_v        : natural range 0 to NUM_INIT_CLKS_C;  -- Tx/Rx bit counter.

    constant CRC_SIZE_C        : natural := 2;  -- Number of CRC bytes for read/write blocks.
    constant WRITE_DATA_SIZE_C : natural := 1 + BLOCK_SIZE_G + CRC_SIZE_C;
    variable byteCnt_v         : natural range 0 to WRITE_DATA_SIZE_C;  -- Tx/Rx byte counter.

    -- Command bytes for various SD card operations.
    constant CMD0_C            : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#40# + 0, 8));
    constant CMD55_C           : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#40# + 55, 8));
    constant CMD41_C           : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#40# + 41, 8));
    constant READ_BLK_CMD_C  : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#40# + 17, 8));
    constant WRITE_BLK_CMD_C : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#40# + 24, 8));

    variable addr_v : unsigned(addr_i'range);  -- Address of current block for R/W operations.

    -- Most SD card ops don't need CRC, so use a fake one to fill up the space.
    constant FAKE_CRC_C : std_logic_vector(7 downto 0) := x"FF";

    -- Maximum Tx to SD card consists of command + address + CRC. Data Tx is just a single byte.
    variable tx_v : std_logic_vector(CMD0_C'length + addr_v'length + FAKE_CRC_C'length - 1 downto 0);  -- Data/command to SD card.
    alias txCmd_v is tx_v;              -- Command transmission shift register.
    alias txData_v is tx_v(tx_v'high downto tx_v'high - data_i'length + 1);  -- Data byte transmission shift register.

    variable rx_v              : std_logic_vector(data_i'range);  -- Data/status byte from SD card.
    constant R1_IDLE_BIT_POS_C : natural := rx_v'low;  -- Position of IDLE bit in R1 response from SD card.

    variable getCmdResponse_v : boolean;  -- When true, get R1 response from SD card to cmd Tx.
    variable rtnData_v        : boolean;  -- When true, signal to host about arrival of data byte from SD card.

    constant DELAY_BETWEEN_BLOCK_RW_C : natural := SCLK_PHASE_PERIOD_C;
    
  begin
    if rising_edge(clk_i) then
      
      xfer_o <= NO;  -- Default request of the host is "no transfer of data".

      if reset_i = YES then
        state_v   := INIT;
        clkCntr_v := 0;                 -- Initialize the clock pulse counter.
        busy_o    <= YES;  -- Busy since the SD card interface is not initialized, yet.
        
      elsif clkCntr_v /= 0 then
        -- Don't do anything until the clock pulse counter reaches zero.
        -- This generates the slower SPI clock from the faster main clock.
        clkCntr_v := clkCntr_v - 1;
        
      else
        -- Clock pulse counter has reached zero, so perform some action on the SD card.
        
        busy_o <= YES;  -- SD card interface is busy by default. (Only false when waiting for R/W from host.)

        case state_v is
          
          when INIT =>  -- Deselect the SD card and send it a bunch of clock pulses with MOSI high.
            clkDivider_v     := INIT_SCLK_PHASE_PERIOD_C;  -- Set SPI clock frequency during initialization.
            sclk_r           <= LO;     -- Start with low clock to the SD card.
            cs_o             <= HI;     -- Disable the SD card.
            getCmdResponse_v := false;  -- Don't expect a response from the SD card.
            rtnData_v        := false;  -- No data from the SD card to return to the host.
            addr_v           := (others => ZERO);
            txCmd_v          := (others => ONE);  -- Load command register with all ones.
--            bitCnt_v      := NUM_INIT_CLKS_C;  -- Generate this many clock pulses.
            bitCnt_v         := 10;     -- Generate this many clock pulses.
            state_v          := TRANSMIT;  -- Use transmit subroutine to generate clock pulses.
            rtnState_v       := SEND_CMD0;  -- Then go to this state after the clock pulses are done.
            
          when SEND_CMD0 =>             -- Send CMD0 to the SD card.
            cs_o             <= LO;     -- Enable the SD card.
            txCmd_v          := CMD0_C & std_logic_vector(addr_v) & x"95";  -- 0x95 is the only correct CRC needed.
            bitCnt_v         := txCmd_v'length;  -- Set bit counter to the size of the command.
            getCmdResponse_v := true;  -- Sending a command that generates a response.
            state_v          := TRANSMIT;  -- Go to FSM subroutine to send the command.
            rtnState_v       := SEND_CMD55;  -- Then go to this state after the command is sent.

          when SEND_CMD55 =>            -- Send CMD55 to the SD card.
            txCmd_v    := CMD55_C & std_logic_vector(addr_v) & FAKE_CRC_C;
            bitCnt_v   := txCmd_v'length;  -- Set bit counter to the size of the command.
            state_v    := TRANSMIT;  -- Go to FSM subroutine to send the command.
            rtnState_v := SEND_CMD41;  -- Then go to this state after the command is sent.
            
          when SEND_CMD41 =>            -- Send CMD41 to the SD card.
            txCmd_v    := CMD41_C & std_logic_vector(addr_v) & FAKE_CRC_C;
            bitCnt_v   := txCmd_v'length;  -- Set bit counter to the size of the command.
            state_v    := TRANSMIT;  -- Go to FSM subroutine to send the command.
            rtnState_v := CHECK_IDLE;  -- Then go to this state after the command is sent.
            
          when CHECK_IDLE =>
            -- The CMD55, CMD41 sequence should cause the SD card to leave the IDLE state
            -- and become ready for SPI read/write operations. If not, then repeat the CMD55, CMD41 sequence.
            if rx_v(R1_IDLE_BIT_POS_C) = ZERO then
              state_v := WAIT_FOR_HOST_RW;
            else
              state_v := SEND_CMD55;
            end if;
            
          when WAIT_FOR_HOST_RW =>  -- Wait for the host to read or write a block of data from the SD card.
            clkDivider_v     := SCLK_PHASE_PERIOD_C;  -- Set SPI clock frequency for normal operation.
            getCmdResponse_v := true;  -- Get R1 response to any commands issued to the SD card.
            if rd_i = YES then  -- send READ command and address to the SD card.
              cs_o <= LO;               -- Enable the SD card.
              if continue_i = YES then
                addr_v  := addr_v + 1;
                txCmd_v := READ_BLK_CMD_C & std_logic_vector(addr_v) & FAKE_CRC_C;
              else
                txCmd_v := READ_BLK_CMD_C & addr_i & x"FF";
                addr_v  := unsigned(addr_i);
              end if;
              bitCnt_v   := txCmd_v'length;  -- Set bit counter to the size of the command.
              state_v    := TRANSMIT;  -- Go to FSM subroutine to send the command.
              rtnState_v := READ_START_TOKEN;  -- Then go to this state after the command is sent.
            elsif wr_i = YES then  -- send WRITE command and address to the SD card.
              cs_o <= LO;               -- Enable the SD card.
              if continue_i = YES then
                addr_v  := addr_v + 1;
                txCmd_v := WRITE_BLK_CMD_C & std_logic_vector(addr_v) & FAKE_CRC_C;
              else
                txCmd_v := WRITE_BLK_CMD_C & addr_i & x"FF";
                addr_v  := unsigned(addr_i);
              end if;
              bitCnt_v   := txCmd_v'length;  -- Set bit counter to the size of the command.
              state_v    := TRANSMIT;  -- Go to FSM subroutine to send the command.
              rtnState_v := WRITE_DATA;  -- Then go to this state after the command is sent.
              byteCnt_v  := WRITE_DATA_SIZE_C;
            else              -- Do nothing and wait for command from host.
              cs_o    <= HI;            -- Deselect the SD card.
              busy_o  <= NO;  -- SD card interface is waiting for R/W from host, so it's not busy.
              state_v := WAIT_FOR_HOST_RW;  -- Keep waiting for command from host.
            end if;
            
          when READ_START_TOKEN =>
            -- The SD card will output 0xFE token at the start of the block of read data. So scan 
            -- MISO for a low bit and then get the block of data bytes that follows. 
            if sclk_r = HI and miso_i = LO then
              byteCnt_v := BLOCK_SIZE_G - 1;  -- Set the byte counter for the # of data bytes in a block.
              state_v   := READ_DATA;  -- Go to FSM subroutine to read the data block.
            end if;
            sclk_r    <= not sclk_r;    -- Toggle the SPI clock...
            clkCntr_v := clkDivider_v;  -- and set the duration of the next clock phase.

          when READ_DATA =>         -- Read a block of data from the SD card.
            rtnData_v := true;
            bitCnt_v  := rx_v'length - 1;  -- Set the bit counter for the next data byte.
            state_v   := RECEIVE;       -- Get the next data byte.
            if byteCnt_v /= 0 then  -- Haven't received the entire block of data from the SD card, yet.
              byteCnt_v  := byteCnt_v - 1;   -- One less byte to receive.
              rtnState_v := READ_DATA;  -- Then return here to keep getting more data bytes.
            else  -- This is the last byte of data to read from the SD card block.
              rtnState_v := READ_CRC;   -- Then get the CRC for the data block.
              byteCnt_v  := CRC_SIZE_C - 1;  -- CRC is multi-byte.
            end if;
            
          when READ_CRC =>  -- Get the CRC that follows a block of data from the SD card.
            rtnData_v := false;
            bitCnt_v  := rx_v'length - 1;  -- Set the bit counter for the CRC byte.
            state_v   := RECEIVE;       -- Get a CRC byte.
            if byteCnt_v /= 0 then
              byteCnt_v  := byteCnt_v - 1;  -- One less CRC byte to receive.
              rtnState_v := READ_CRC;   -- Still reading CRC.
            else
              rtnState_v := END_BLOCK_RW;  -- Done reading CRC, so terminate this block read op.
            end if;
            
          when WRITE_DATA =>  -- Write a start token, block of data and two CRC bytes.
            getCmdResponse_v := false;  -- Sending data bytes so there's no command response from SD card.
            if byteCnt_v /= 0 then
              tx_v := (others => ONE);  -- Only using 8 bits, so make sure others are set high.
              if byteCnt_v = WRITE_DATA_SIZE_C then
                txData_v := x"FE";      -- Starting data block token.
              elsif byteCnt_v = 2 or byteCnt_v = 1 then
                txData_v := x"FF";      -- Two (phony) CRC bytes.
              else                      -- Send bytes in data block.
                txData_v := data_i;  -- Load shift register with data from host.
                xfer_o   <= YES;        -- Signal host to provide new data.
              end if;
              bitCnt_v   := txData_v'length;
              state_v    := TRANSMIT;   -- Send data byte to SD card.
              rtnState_v := WRITE_DATA;
              byteCnt_v  := byteCnt_v - 1;
            else
              bitCnt_v   := rx_v'length - 1;
              state_v    := RECEIVE;  -- Get response of SD card to the write operation.
              rtnState_v := WRITE_BUSY_WAIT;
            end if;
            
          when WRITE_BUSY_WAIT =>  -- Wait for SD card to finish writing the data block.
            sclk_r    <= not sclk_r;    -- Toggle the SPI clock...
            clkCntr_v := clkDivider_v;  -- and set the duration of the next clock phase.
            if sclk_r = HI and miso_i = HI then
              -- The SD card will pull MISO low while it is busy, and raise it when it is done.
              clkCntr_v := 0;
              state_v   := END_BLOCK_RW;  -- SD card done, so terminate this block write op.
            end if;
            
          when END_BLOCK_RW =>  -- Disable SD card chip-select after each block R/W.
            cs_o      <= HI;
            clkCntr_v := DELAY_BETWEEN_BLOCK_RW_C;
            state_v   := WAIT_FOR_HOST_RW;
            
          when TRANSMIT =>
            -- Start sending command/data by lowering SCLK and outputing MSB of command/data
            -- so it has plenty of setup before the rising edge of SCLK.
            sclk_r    <= LO;  -- Lower the SCLK (although it should already be low).
            clkCntr_v := clkDivider_v;  -- Set the duration of the low SCLK.
            mosi_o    <= tx_v(tx_v'high);  -- Output MSB of command/data.
            tx_v      := tx_v(tx_v'high-1 downto 0) & ONE;  -- Shift command/data register by one bit.
            bitCnt_v  := bitCnt_v - 1;  -- The first bit has been sent, so decrement bit counter.
            state_v   := SHIFT_OUT;  -- Go here to shift out the rest of the command/data bits.
            
          when SHIFT_OUT =>  -- Shift out remaining command/data bits and (possibly) get response from SD card.
            sclk_r    <= not sclk_r;    -- Toggle the SPI clock...
            clkCntr_v := clkDivider_v;  -- and set the duration of the next clock phase.
            if sclk_r = HI then
              -- SCLK is going to be flipped from high to low, so output the next command/data bit
              -- so it can setup while SCLK is low.
              if bitCnt_v /= 0 then  -- Keep sending bits until the bit counter hits zero.
                mosi_o   <= tx_v(tx_v'high);
                tx_v     := tx_v(tx_v'high-1 downto 0) & ONE;
                bitCnt_v := bitCnt_v - 1;
              else
                if getCmdResponse_v then
                  state_v  := GET_CMD_RESPONSE;  -- Get a response to the command from the SD card.
                  bitCnt_v := 7;        -- Length of the expected response.
                else
                  state_v   := rtnState_v;  -- Return to calling state (no need to get a response).
                  clkCntr_v := 0;  -- Clear timer so next SPI op can begin ASAP with SCLK low.
                end if;
              end if;
            end if;

          when GET_CMD_RESPONSE =>  -- Get the response of the SD card to a command.
            if sclk_r = HI and miso_i = LO then  -- MISO will be held high by SD card until 1st bit of R1 response, which is 0.
              -- Shift in the MSB bit of the response.
              rx_v     := rx_v(rx_v'high-1 downto 0) & miso_i;
              bitCnt_v := bitCnt_v - 1;
              state_v  := RECEIVE;  -- Now receive the reset of the response.
            end if;
            sclk_r    <= not sclk_r;    -- Toggle the SPI clock...
            clkCntr_v := clkDivider_v;  -- and set the duration of the next clock phase.

          when RECEIVE =>               -- Receive bits from the SD card.
            if sclk_r = HI then   -- Bits enter after the rising edge of SCLK.
              rx_v := rx_v(rx_v'high-1 downto 0) & miso_i;
              if bitCnt_v /= 0 then     -- More bits left to receive.
                bitCnt_v := bitCnt_v - 1;
              else                      -- Last bit has been received.
                if rtnData_v then       -- Send the received data to the host.
                  data_o <= rx_v;
                  xfer_o <= YES;  -- Signal to the host that the data is ready.
                end if;
                if getCmdResponse_v then

                end if;
                state_v := rtnState_v;  -- Return to calling state.
              end if;
            end if;
            sclk_r    <= not sclk_r;    -- Toggle the SPI clock...
            clkCntr_v := clkDivider_v;  -- and set the duration of the next clock phase.

          when others =>
            state_v := WAIT_FOR_HOST_RW;
        end case;
      end if;
    end if;
  end process;

  sclk_o <= sclk_r;  -- Output the generated SPI clock for the SD card.
  
end architecture;