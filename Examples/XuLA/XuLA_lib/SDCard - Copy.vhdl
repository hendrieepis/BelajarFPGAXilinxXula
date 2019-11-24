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
-- ©2012 - X Engineering Software Systems Corp. (www.xess.com)
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
      FREQ_G       : real    := 100.0;  -- Clock frequency of the FPGA logic (MHz).
      SPI_FREQ_G   : real    := 0.4;  -- Clock frequency to the SD card (MHz).
      BLOCK_SIZE_G : natural := 512
      );
    port (
      -- Interface signals into the FPGA logic.
      reset_i    : in  std_logic                    := NO;
      clk_i      : in  std_logic;
      addr_i     : in  std_logic_vector(31 downto 0);
      rd_i       : in  std_logic                    := NO;
      wr_i       : in  std_logic                    := NO;
      continue_i : in  std_logic                    := NO;  -- If true, inc address and continue R/W.
      data_i     : in  std_logic_vector(7 downto 0) := x"00";
      data_o     : out std_logic_vector(7 downto 0);
      busy_o     : out std_logic;
      xfer_o     : out std_logic;
      -- I/O signals to the external SD card.
      cs_o       : out std_logic;
      mosi_o     : out std_logic;
      miso_i     : in  std_logic                    := ZERO;
      sclk_o     : out std_logic
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
    FREQ_G       : real    := 100.0;  -- Clock frequency of the FPGA logic (MHz).
    SPI_FREQ_G   : real    := 0.4;    -- Clock frequency to the SD card (MHz).
    BLOCK_SIZE_G : natural := 512
    );
  port (
    -- Interface signals into the FPGA logic.
    reset_i    : in  std_logic                    := NO;
    clk_i      : in  std_logic;
    addr_i     : in  std_logic_vector(31 downto 0);
    rd_i       : in  std_logic                    := NO;
    wr_i       : in  std_logic                    := NO;
    continue_i : in  std_logic                    := NO;  -- If true, inc address and continue R/W.
    data_i     : in  std_logic_vector(7 downto 0) := x"00";
    data_o     : out std_logic_vector(7 downto 0);
    busy_o     : out std_logic;
    xfer_o     : out std_logic;
    -- I/O signals to the external SD card.
    cs_o       : out std_logic;
    mosi_o     : out std_logic;
    miso_i     : in  std_logic                    := ZERO;
    sclk_o     : out std_logic
    );
end entity;

architecture arch of SdCardCtrl is
  type FsmState_t is (
    INIT,              -- Send clock pulses to the deselected SD card.
    CMD0,                               -- Send CMD0 command to SD card.
    CMD55,                              -- Send CMD55 command to SD card.
    CMD41,                              -- Send CMD41 command to SD card.
    CHECK_IDLE,        -- Check to see if SD card has left the IDLE state.
    WAIT_FOR_HOST_RW,                   -- wait for read or write pulse
    READ_BLOCK_WAIT,
    READ_BLOCK_DATA,
    READ_BLOCK_CRC,
    WRITE_BLOCK_DATA,                   -- loop through all data bytes
    WRITE_BLOCK_BYTE,                   -- send one byte
    SHIFT_OUT_BLOCK_BYTE,
    WRITE_BLOCK_WAIT,                   -- wait until not busy
    SEND_CMD,
    SHIFT_OUT_CMD,
    GET_RESPONSE,
    RECEIVE_BYTE
    );

  -- Data token, plus data block, plus CRC bytes.
  constant CRC_SIZE_C        : natural := 2;
  constant WRITE_DATA_SIZE_C : natural := 1 + BLOCK_SIZE_G + CRC_SIZE_C;

  signal state_r       : FsmState_t;
  signal rtnState_r    : FsmState_t;
  signal sclk_s        : std_logic := ZERO;
  signal cmd_r         : std_logic_vector(47 downto 0);
  signal dataIn_r      : std_logic_vector(data_i'range);
  signal dataOut_r     : std_logic_vector(data_i'range);
  signal addr_r        : unsigned(addr_i'range);
  signal getResponse_r : std_logic;
  signal rtnData_r     : std_logic;

begin
  
  process(clk_i, reset_i)
    constant MAX_NUM_BITS_C    : natural := 160;
    variable byteCnt_v         : natural range 0 to WRITE_DATA_SIZE_C;
    variable bitCnt_v          : natural range 0 to MAX_NUM_BITS_C;
    constant CLKS_PER_SCLK_C   : natural := integer(ceil(FREQ_G / SPI_FREQ_G));
    variable clkDivider_v      : natural range 0 to CLKS_PER_SCLK_C / 2 - 1;
    constant R1_IDLE_BIT_POS_C : natural := dataIn_r'low;
    variable addr_v            : unsigned(addr_r'range);
    variable dataIn_v          : std_logic_vector(dataIn_r'range);
  begin
    if rising_edge(clk_i) then
      
      xfer_o <= NO;  -- Default request of the host is "no transfer of data".

      if reset_i = YES then
        sclk_s       <= LO;             -- Start with low clock to the SD card.
        clkDivider_v := 0;
        busy_o       <= YES;  -- Busy since the SD card interface is not initialized, yet.
        state_r      <= INIT;
        
      elsif clkDivider_v /= 0 then
        -- Don't do anything until the clock divider reaches zero.
        -- This generates the slower SPI clock from the faster main clock.
        clkDivider_v := clkDivider_v - 1;
        
      else
        -- Clock divider has reached zero, so perform some action on the SD card.
        
        busy_o <= YES;  -- SD card interface is busy by default. (Only false when waiting for R/W from host.)

        case state_r is
          
          when INIT =>  -- Deselect the SD card and just send it a bunch of clock pulses with MOSI set high.
            cs_o          <= HI;        -- Disable the SD card.
            cmd_r         <= (others => ONE);  -- Load command register with all ones.
--            bitCnt_v      := MAX_NUM_BITS_C;  -- Generate this many clock pulses.
            bitCnt_v      := 10;  -- Generate this many clock pulses.
            state_r       <= SEND_CMD;  -- Use SEND COMMAND subroutine to generate clock pulses.
            getResponse_r <= NO;  -- Don't expect a response from the SD card.
            rtnData_r     <= NO;
            rtnState_r    <= CMD0;  -- Then go to this state after the clock pulses are done.
            
          when CMD0 =>                  -- Send CMD0 to the SD card.
            cs_o          <= LO;        -- Enable the SD card.
            cmd_r         <= x"400000000095";  -- 0x40 | 0x00 = 0x40
            bitCnt_v      := cmd_r'length;  -- Set bit counter to the size of the command.
            getResponse_r <= YES;  -- Sending a command that generates a response.
            state_r       <= SEND_CMD;  -- Go to FSM subroutine to send the command.
            rtnState_r    <= CMD55;  -- Then go to this state after the command is sent.

          when CMD55 =>                 -- Send CMD55 to the SD card.
            cmd_r      <= x"770000000001";  -- 0x40 | 0x37 (55) = 0x77
            bitCnt_v   := cmd_r'length;  -- Set bit counter to the size of the command.
            state_r    <= SEND_CMD;  -- Go to FSM subroutine to send the command.
            rtnState_r <= CMD41;  -- Then go to this state after the command is sent.
            
          when CMD41 =>                 -- Send CMD41 to the SD card.
            cmd_r      <= x"690000000001";  -- 0x40 | 0x29 (41) = 0x69
            bitCnt_v   := cmd_r'length;  -- Set bit counter to the size of the command.
            state_r    <= SEND_CMD;  -- Go to FSM subroutine to send the command.
            rtnState_r <= CHECK_IDLE;  -- Then go to this state after the command is sent.
            
          when CHECK_IDLE =>
            -- The CMD55, CMD41 sequence should cause the SD card to leave the IDLE state
            -- and become ready for read/write operations. If not, then repeat the CMD55, CMD41 sequence.
            if dataIn_r(R1_IDLE_BIT_POS_C) = ZERO then
              state_r <= WAIT_FOR_HOST_RW;
            else
              state_r <= CMD55;
            end if;
            
          when WAIT_FOR_HOST_RW =>  -- Wait for the host to read or write a block of data from the SD card.
            addr_v := addr_r + 1;
            if rd_i = YES then  -- send READ command and address to the SD card.
              if continue_i = YES then
                cmd_r  <= x"51" & std_logic_vector(addr_v) & x"FF";
                addr_r <= addr_v;
              else
                cmd_r  <= x"51" & addr_i & x"FF";
                addr_r <= unsigned(addr_i);
              end if;
              bitCnt_v   := cmd_r'length;  -- Set bit counter to the size of the command.
              state_r    <= SEND_CMD;  -- Go to FSM subroutine to send the command.
              rtnState_r <= READ_BLOCK_WAIT;  -- Then go to this state after the command is sent.
            elsif wr_i = YES then  -- send WRITE command and address to the SD card.
              if continue_i = YES then
                cmd_r  <= x"58" & std_logic_vector(addr_v) & x"FF";
                addr_r <= addr_v;
              else
                cmd_r  <= x"58" & addr_i & x"FF";
                addr_r <= unsigned(addr_i);
              end if;
              bitCnt_v   := cmd_r'length;  -- Set bit counter to the size of the command.
              state_r    <= SEND_CMD;  -- Go to FSM subroutine to send the command.
              rtnState_r <= WRITE_BLOCK_DATA;  -- Then go to this state after the command is sent.
              byteCnt_v  := WRITE_DATA_SIZE_C;
            else              -- Do nothing and wait for command from host.
              busy_o  <= NO;  -- SD card interface is waiting for R/W from host, so it's not busy.
              state_r <= WAIT_FOR_HOST_RW;  -- Keep waiting for command from host.
            end if;
            
          when READ_BLOCK_WAIT =>
            -- The SD card will output 0xFE after it accepts the READ command. So scan the SD card 
            -- output to see when it is low and then get the block of data that follows. 
            if sclk_s = HI and miso_i = LO then
              byteCnt_v  := BLOCK_SIZE_G - 1;  -- Set the byte counter for the # of data bytes in a block.
              state_r    <= READ_BLOCK_DATA;  -- Go to FSM subroutine to read the data block.
            end if;
            sclk_s       <= not sclk_s;    -- Toggle the SPI clock...
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- and set the duration of the next clock phase.

          when READ_BLOCK_DATA =>   -- Read a block of data from the SD card.
            rtnData_r  <= YES;
            bitCnt_v   := dataIn_r'length - 1;  -- Set the bit counter for the next data byte.
            state_r    <= RECEIVE_BYTE;    -- Get the next data byte.
            if byteCnt_v /= 0 then  -- Haven't received the entire block of data from the SD card, yet.
              byteCnt_v  := byteCnt_v - 1;   -- One less byte to receive.
              rtnState_r <= READ_BLOCK_DATA;  -- Then return here to keep getting more data bytes.
            else  -- This is the last byte of data to read from the SD card block.
              rtnState_r <= READ_BLOCK_CRC;  -- Then get the CRC for the data block.
              byteCnt_v  := CRC_SIZE_C - 1;  -- CRC is multi-byte.
            end if;
            
          when READ_BLOCK_CRC =>  -- Get the CRC that follows a block of data from the SD card.
            rtnData_r <= NO;
            bitCnt_v  := dataIn_r'length - 1;  -- Set the bit counter for the CRC byte.
            state_r   <= RECEIVE_BYTE;  -- Get a CRC byte.
            if byteCnt_v /= 0 then
              byteCnt_v  := byteCnt_v - 1;     -- One less CRC byte to receive.
              rtnState_r <= READ_BLOCK_CRC;    -- Still reading CRC.
            else
              rtnState_r <= WAIT_FOR_HOST_RW;  -- Done reading CRC, so go wait for another R/W from host.
            end if;
            
          when WRITE_BLOCK_DATA =>  -- Write a start token, block of data and two CRC bytes.
            if byteCnt_v /= 0 then
              if byteCnt_v = WRITE_DATA_SIZE_C then
                dataOut_r <= x"FE";     -- Starting data block token.
              elsif byteCnt_v = 2 or byteCnt_v = 1 then
                dataOut_r <= x"FF";     -- Two (phony) CRC bytes.
              else                      -- Send bytes in data block.
                dataOut_r <= data_i;  -- Load shift register with data from host.
                xfer_o    <= YES;       -- Signal host to provide new data.
              end if;
              bitCnt_v  := dataOut_r'length;
              state_r   <= WRITE_BLOCK_BYTE;  -- Send data byte to SD card.
              byteCnt_v := byteCnt_v - 1;
            else
              bitCnt_v   := dataIn_r'length - 1;
              state_r    <= RECEIVE_BYTE;
              rtnState_r <= WRITE_BLOCK_WAIT;
            end if;

          when WRITE_BLOCK_BYTE =>
            -- Start sending data by lowering SCLK and outputing MSB of data
            -- so it has plenty of setup before the rising edge of SCLK.
            sclk_s       <= LO;  -- Lower the SCLK (although it should already be low).
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- Set the duration of the low SCLK.
            mosi_o       <= dataOut_r(dataOut_r'high);  -- Output MSB of data.
            dataOut_r    <= dataOut_r(dataOut_r'high-1 downto 0) & ONE;  -- Shift data register by one bit.
            bitCnt_v     := bitCnt_v - 1;  -- The first bit has been sent, so decrement bit counter.
            state_r      <= SHIFT_OUT_BLOCK_BYTE;  -- Go here to shift out the rest of the data bits.

          when SHIFT_OUT_BLOCK_BYTE =>  -- Shift out remaining data bits to SD card.
            sclk_s       <= not sclk_s;            -- Toggle the SPI clock...
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- and set the duration of the next clock phase.
            if sclk_s = HI then
              -- SCLK is going to be flipped from high to low, so output the next data bit
              -- so it can setup while SCLK is low.
              if bitCnt_v /= 0 then  -- Keep sending bits until the bit counter hits zero.
                mosi_o    <= dataOut_r(dataOut_r'high);
                dataOut_r <= dataOut_r(dataOut_r'high-1 downto 0) & ONE;
                bitCnt_v  := bitCnt_v - 1;
              else
                state_r      <= WRITE_BLOCK_DATA;  -- Go back and process next byte in block of data.
                clkDivider_v := 0;  -- Clear timer so next SPI op can begin ASAP with SCLK low.
              end if;
            end if;
            
          when WRITE_BLOCK_WAIT =>  -- Wait for SD card to finish writing the data block.
            sclk_s       <= not sclk_s;  -- Toggle the SPI clock...
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- and set the duration of the next clock phase.
            if sclk_s = HI and miso_i = HI then
              -- The SD card will pull MISO low while it is busy, and raise it when it is done.
              clkDivider_v := 0;
              state_r      <= WAIT_FOR_HOST_RW;
            end if;
            
          when SEND_CMD =>
            -- Start sending command by lowering SCLK and outputing MSB of command
            -- so it has plenty of setup before the rising edge of SCLK.
            sclk_s       <= LO;  -- Lower the SCLK (although it should already be low).
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- Set the duration of the low SCLK.
            mosi_o       <= cmd_r(cmd_r'high);        -- Output MSB of command.
            cmd_r        <= cmd_r(cmd_r'high-1 downto 0) & ONE;  -- Shift command register by one bit.
            bitCnt_v     := bitCnt_v - 1;  -- The first bit has been sent, so decrement bit counter.
            state_r      <= SHIFT_OUT_CMD;  -- Go here to shift out the rest of the command bits.
            
          when SHIFT_OUT_CMD =>  -- Shift out remaining command bits and (possibly) get response from SD card.
            sclk_s       <= not sclk_s;      -- Toggle the SPI clock...
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- and set the duration of the next clock phase.
            if sclk_s = HI then
              -- SCLK is going to be flipped from high to low, so output the next command bit
              -- so it can setup while SCLK is low.
              if bitCnt_v /= 0 then  -- Keep sending bits until the bit counter hits zero.
                mosi_o   <= cmd_r(cmd_r'high);
                cmd_r    <= cmd_r(cmd_r'high-1 downto 0) & ONE;
                bitCnt_v := bitCnt_v - 1;
              else
                if getResponse_r = YES then
                  state_r  <= GET_RESPONSE;  -- Get a response to the command from the SD card.
                  bitCnt_v := 7;        -- Length of the expected response.
                else
                  state_r      <= rtnState_r;  -- Return to calling state (no need to get a response).
                  clkDivider_v := 0;  -- Clear timer so next SPI op can begin ASAP with SCLK low.
                end if;
              end if;
            end if;

          when GET_RESPONSE =>  -- Get the response of the SD card to a command.
            if sclk_s = HI and miso_i = LO then  -- MISO will be held high by SD card until 1st bit of R1 response, which is 0.
              -- Shift in the MSB bit of the response.
              dataIn_r <= dataIn_r(dataIn_r'high-1 downto 0) & miso_i;
              bitCnt_v := bitCnt_v - 1;
              state_r  <= RECEIVE_BYTE;  -- Now receive the reset of the response.
            end if;
            sclk_s       <= not sclk_s;  -- Toggle the SPI clock...
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- and set the duration of the next clock phase.

          when RECEIVE_BYTE =>          -- Receive bits from the SD card.
            if sclk_s = HI then  -- Data bits enter after the rising edge of SCLK.
              dataIn_v := dataIn_r(dataIn_r'high-1 downto 0) & miso_i;
              dataIn_r <= dataIn_v;
              if bitCnt_v /= 0 then     -- More bits left to receive.
                bitCnt_v := bitCnt_v - 1;
              else                      -- Last bit has been received.
                if rtnData_r = YES then  -- Send the received data to the host.
                  data_o <= dataIn_v;
                  xfer_o <= YES;  -- Signal to the host that the data is ready.
                end if;
                state_r <= rtnState_r;  -- Return to calling state.
              end if;
            end if;
            sclk_s       <= not sclk_s;  -- Toggle the SPI clock...
            clkDivider_v := CLKS_PER_SCLK_C / 2 - 1;  -- and set the duration of the next clock phase.

          when others =>
            state_r <= WAIT_FOR_HOST_RW;
        end case;
      end if;
    end if;
  end process;

  sclk_o <= sclk_s;  -- Output the generated SPI clock for the SD card.
  
end architecture;
