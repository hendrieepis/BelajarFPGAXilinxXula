library IEEE, UNISIM;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use WORK.common.all;


package ata is

  component pioIntfc
    generic(
      FREQ     :     natural := 50_000  -- operating frequency in KHz
      );
    port(
      -- host side
      clk      : in  std_logic;         -- master clock
      pioRst   : in  std_logic;         -- async. reset
      pioRd    : in  std_logic;         -- initiate read operation
      pioWr    : in  std_logic;         -- initiate write operation
      pioAddr  : in  std_logic_vector(4 downto 0);  -- disk register address from host
      pioDIn   : in  std_logic_vector(15 downto 0);  -- data from host to disk
      pioDOut  : out std_logic_vector(15 downto 0);  -- data from disk to host
      pioBusy  : out std_logic;         -- read or write operation is in progress
      pioIntrq : out std_logic;         -- debounced interrupt from disk
      status   : out std_logic_vector(3 downto 0);  -- diagnostic status for the R/W

      -- disk side
      dior_n    : out std_logic;        -- disk register read-enable
      diow_n    : out std_logic;        -- disk register write-enable
      cs0_n     : out std_logic;        -- disk command block register select
      cs1_n     : out std_logic;        -- disk control block register select
      da        : out std_logic_vector(2 downto 0);  -- disk register address
      ddIn      : in  std_logic_vector(15 downto 0);  -- data from disk
      ddOut     : out std_logic_vector(15 downto 0);  -- data to disk
      ddOutEnbl : out std_logic;        -- enable data outputs to disk
      intrq     : in  std_logic;        -- interrupt from disk
      dmack_n   : out std_logic         -- DMA acknowledge
      );
  end component;

  component ataCntl
    generic(
      FREQ           :     natural := 50_000;  -- operating frequency in KHz
      SECTORS_PER_RW :     natural := 1  -- number of sectors to read/write
      );
    port(
      -- host side
      clk            : in  std_logic;   -- master clock
      rst            : in  std_logic;   -- reset
      rd             : in  std_logic;   -- initiate read operation
      wr             : in  std_logic;   -- initiate write operation
      abort          : in  std_logic;   -- aborts read/write sector operation
      head           : in  std_logic_vector(3 downto 0);  -- disk head for data access
      cylinder       : in  std_logic_vector(15 downto 0);  -- cylinder for data access
      sector         : in  std_logic_vector(7 downto 0);  -- sector for data access
      hDIn           : in  std_logic_vector(15 downto 0);  -- data from host       to disk
      hDOut          : out std_logic_vector(15 downto 0);  -- data from disk to host
      done           : out std_logic;   -- read or write operation is done
      status         : out std_logic_vector(6 downto 0);  -- diagnostic status            

      -- disk side
      dior_n    : out std_logic;        -- disk register read-enable
      diow_n    : out std_logic;        -- disk register write-enable
      cs0_n     : out std_logic;        -- disk command block register select
      cs1_n     : out std_logic;        -- disk control block register select
      da        : out std_logic_vector(2 downto 0);  -- register address
      ddIn      : in  std_logic_vector(15 downto 0);  -- data from disk
      ddOut     : out std_logic_vector(15 downto 0);  -- data to disk
      ddOutEnbl : out std_logic;        -- enable data outputs to disk
      intrq     : in  std_logic;        -- interrupt from disk
      dmack_n   : out std_logic         -- DMA acknowledge
      );
  end component;

end package ata;




library IEEE, UNISIM;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use WORK.common.all;

--------------------------------------------------------------------
-- Company : XESS Corp.
-- Engineer : Dave Vanden Bout
-- Creation Date : 04/14/2004
-- Copyright : 2004-2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
-- This module executes a timed read/write operation to one of the disk registers.
--
-- For a read operation, the host supplies a register address and pulls the read
-- control line high. The read operation begins on the next rising clock edge
-- and the busy signal goes high. The host gets the data from the disk register
-- once the busy signal goes low again.
--
-- For a write operation, the host supplies a register address and the data to
-- be stored there and pulls the write control line high. The write operation
-- begins on the nxt rising clock edge an the busy signal goes high. The register
-- contains the new data once the busy signal goes low again.
--
-- The 5-bit register address from the host contains the 3-bit disk register address
-- along with the control and command block register select bits in the most
-- significant bit positions.
--
-- Revision:
-- 1.0.2
--
-- Additional Comments:
-- 1.0.2:
-- Added PIO Modes 3 & 4 timing parameters.
-- 1.0.1:
-- Added PIO Mode 2 timing parameters.
-- 1.0.0:
-- Initial release.
--
-- License:
-- This code can be freely distributed and modified as long as
-- this header is not removed.
--------------------------------------------------------------------

entity pioIntfc is
  generic(
    FREQ     :     natural := 50_000    -- operating frequency in KHz
    );
  port(
    -- host side
    clk      : in  std_logic;           -- master clock
    pioRst   : in  std_logic;           -- async. reset
    pioRd    : in  std_logic;           -- initiate read operation
    pioWr    : in  std_logic;           -- initiate write operation
    pioAddr  : in  std_logic_vector(4 downto 0);  -- disk register address from host
    pioDIn   : in  std_logic_vector(15 downto 0);  -- data from host       to disk
    pioDOut  : out std_logic_vector(15 downto 0);  -- data from disk to host
    pioBusy  : out std_logic;           -- read or write operation is in progress
    pioIntrq : out std_logic;           -- debounced interrupt from disk
    status   : out std_logic_vector(3 downto 0);  -- diagnostic status for the R/W

    -- disk side
    dior_n    : out std_logic;          -- disk register read-enable
    diow_n    : out std_logic;          -- disk register write-enable
    cs0_n     : out std_logic;          -- disk command block register select
    cs1_n     : out std_logic;          -- disk control block register select
    da        : out std_logic_vector(2 downto 0);  -- disk register address
    ddIn      : in  std_logic_vector(15 downto 0);  -- data from disk
    ddOut     : out std_logic_vector(15 downto 0);  -- data to disk
    ddOutEnbl : out std_logic;          -- enable data outputs to disk
    intrq     : in  std_logic;          -- interrupt from disk
    dmack_n   : out std_logic           -- DMA acknowledge
    );
end pioIntfc;


architecture arch of pioIntfc is
  -- PIO mode 0 timing parameters in ns
  constant Top    : natural := 600;     -- minimum cycle time between R/W operations
  constant Tsetup : natural := 70;      -- address/data setup before R/W pulse
  constant Tpulse : natural := 290;     -- R/W pulse width
  -- PIO mode 2 timing parameters in ns
--  constant Top    : natural := 240;   -- minimum cycle time between R/W operations
--  constant Tsetup : natural := 30;    -- address/data setup before R/W pulse
--  constant Tpulse : natural := 100;   -- R/W pulse width
  -- PIO mode 3 timing parameters in ns
--  constant Top    : natural := 180;   -- minimum cycle time between R/W operations
--  constant Tsetup : natural := 30;    -- address/data setup before R/W pulse
--  constant Tpulse : natural := 80;   -- R/W pulse width
  -- PIO mode 4 timing parameters in ns
--  constant Top    : natural := 120;   -- minimum cycle time between R/W operations
--  constant Tsetup : natural := 20;    -- address/data setup before R/W pulse
--  constant Tpulse : natural := 70;   -- R/W pulse width

  constant Thold : natural := Top-Tsetup-Tpulse;  -- address/data hold after R/W pulse

  -- PIO mode timing parameters converted into clock cycles (based on FREQ)
  constant NORM         : natural := 1_000_000;  -- normalize ns * KHz
  constant OP_CYCLES    : natural := 1+((Top*FREQ)/NORM);
  constant SETUP_CYCLES : natural := 1+((Tsetup*FREQ)/NORM);
  constant PULSE_CYCLES : natural := 1+((Tpulse*FREQ)/NORM);
  constant HOLD_CYCLES  : natural := 1+((Thold*FREQ)/NORM);

  -- timer register that counts down times for the phases of the disk R/W operation
  signal timer_r, timer_x : natural range OP_CYCLES downto 0;

  -- states of the PIO interface state machine
  type cntlState is (
    RW_SETUP,                           -- setup address/data before read pulse
    RD_PULSE,                           -- read pulse active
    RD_HOLD,                            -- hold address/data after read pulse
    WR_PULSE,                           -- write pulse active
    WR_HOLD                             -- hold address/data after write pulse
    );
  signal state_r, state_x : cntlState;  -- state register and next state

  -- PIO interface registers
  signal pioBusy_r, pioBusy_x     : std_logic;  -- R/W in-progress register
  signal dior_r, dior_x           : std_logic;  -- disk read signal register
  signal diow_r, diow_x           : std_logic;  -- disk write signal register
  signal da_r, da_x               : std_logic_vector(pioAddr'range);  -- disk register address register
  signal ddOut_r, ddOut_x         : std_logic_vector(ddOut'range);  -- data output to disk register
  signal ddOutEnbl_r, ddOutEnbl_x : std_logic;  -- enable data output to disk register
  signal ddIn_r, ddIn_x           : std_logic_vector(ddIn'range);  -- data input from disk register

  -- reports the status of the PIO interface
  signal status_r, status_x : std_logic_vector(3 downto 0);

  -- debounce counter for the interrupt request input
  signal   intrqCnt_r, intrqCnt_x : unsigned(3 downto 0);
  constant DEBOUNCE_CNT           : natural := 10;
  signal   pioIntrq_r, pioIntrq_x : std_logic;
  signal   intrq_r, intrq_x       : std_logic;

begin

  -----------------------------------------------------------
  -- attach some internal signals to the host and disk ports 
  -----------------------------------------------------------

  dior_n    <= dior_r;
  diow_n    <= diow_r;
  da        <= da_r(da'range);
  cs0_n     <= da_r(3);
  cs1_n     <= da_r(4);
  ddOut     <= ddOut_r;
  ddOutEnbl <= ddOutEnbl_r;
  pioDOut   <= ddIn_r;                  -- output data to host is the input data from the disk
  pioBusy   <= pioBusy_r;
  pioIntrq  <= pioIntrq_r;
  status    <= status_r;
  dmack_n   <= HI;                      -- never acknowledge DMA requests from disk

  -----------------------------------------------------------
  -- debounce the interrupt signal from the disk 
  -----------------------------------------------------------
  debounce : process(intrq, intrqCnt_r, intrq_r, pioIntrq_r)
  begin

    intrq_x    <= intrq;
    pioIntrq_x <= pioIntrq_r;

    if(intrq = intrq_r) then
      if(intrqCnt_r = DEBOUNCE_CNT) then
        intrqCnt_x <= (others => '0');
        pioIntrq_x <= intrq_r;
      else
        intrqCnt_x <= intrqCnt_r + 1;
      end if;
    else
      intrqCnt_x   <= (others => '0');
    end if;

  end process debounce;

  -----------------------------------------------------------
  -- compute the next state and outputs 
  -----------------------------------------------------------

  combinatorial : process(pioRd, pioWr, pioAddr, pioDIn, state_r, timer_r, dior_r, pioBusy_r,
                          diow_r, da_r, ddOut_r, ddOutEnbl_r, ddIn_r, ddIn, status_r)
  begin

    -----------------------------------------------------------
    -- setup default values for signals 
    -----------------------------------------------------------

    state_x     <= state_r;
    dior_x      <= dior_r;
    diow_x      <= diow_r;
    da_x        <= da_r;
    ddOut_x     <= ddOut_r;
    ddOutEnbl_x <= ddOutEnbl_r;
    ddIn_x      <= ddIn_r;
    pioBusy_x   <= pioBusy_r;
    status_x    <= status_r;

    -----------------------------------------------------------
    -- update the timers 
    -----------------------------------------------------------

    -- main timer for sequencing the phases of the R/W waveforms                
    if timer_r /= 0 then
      -- decrement the timer and do nothing else since the previous 
      -- phase has not completed yet.
      timer_x <= timer_r - 1;
    else
      -- the previous phase has completed once the timer hits zero.
      -- By default, leave the timer at zero.  A R/W op will set it
      -- to non-zero below.
      timer_x <= timer_r;

      -----------------------------------------------------------
      -- compute the next state and outputs 
      -----------------------------------------------------------
      case state_r is

        -----------------------------------------------------------
        -- wait for a disk read or write operation 
        -----------------------------------------------------------
        when RW_SETUP =>
          dior_x        <= HI;          -- don't read or write the disk until requested
          diow_x        <= HI;
          ddOutEnbl_x   <= NO;          -- don't drive disk data bus until requested
          if(pioRd = YES) then
                                        -- a read operation is requested
            pioBusy_x   <= YES;         -- set busy bit
            da_x        <= pioAddr;     -- output disk register address
            timer_x     <= SETUP_CYCLES;  -- set timer for address setup
            state_x     <= RD_PULSE;    -- next state after address setup completes
            status_x    <= "0010";
          elsif(pioWr = YES) then
                                        -- a write operation is requested
            pioBusy_x   <= YES;         -- set busy bit
            da_x        <= pioAddr;     -- output disk register address
            ddOut_x     <= pioDIn;      -- output data to disk
            ddOutEnbl_x <= YES;         -- enable output bus
            timer_x     <= SETUP_CYCLES;  -- set timer for address/data setup
            state_x     <= WR_PULSE;    -- next state after address/data setup completes
            status_x    <= "0100";
          else
                                        -- no operation is requested
            pioBusy_x   <= NO;          -- clear busy bit
            state_x     <= RW_SETUP;    -- return to this state and wait for R/W request
            status_x    <= "0001";
          end if;

          -----------------------------------------------------------
          -- pulse disk read control signal 
          -----------------------------------------------------------
        when RD_PULSE =>
          dior_x  <= LO;                -- lower disk read control line
          timer_x <= PULSE_CYCLES;      -- load duration of read pulse
          state_x <= RD_HOLD;           -- next state after pulse completes

          -----------------------------------------------------------
          -- get data and hold address after read pulse ends 
          -----------------------------------------------------------
        when RD_HOLD =>
          ddIn_x  <= ddIn;              -- load the data from the disk
          dior_x  <= HI;                -- terminate the read pulse
          timer_x <= HOLD_CYCLES;       -- insert hold period after read operation
          state_x <= RW_SETUP;          -- look for another operation after the hold period

          -----------------------------------------------------------
          -- pulse disk write control signal 
          -----------------------------------------------------------
        when WR_PULSE =>
          diow_x  <= LO;                -- lower disk write control line
          timer_x <= PULSE_CYCLES;      -- load duration of write pulse
          state_x <= WR_HOLD;           -- next state after pulse completes

          -----------------------------------------------------------
          -- hold address and data after write pulse ends 
          -----------------------------------------------------------
        when WR_HOLD =>
          diow_x  <= HI;                -- terminate the write pulse
          timer_x <= HOLD_CYCLES;       -- insert hold period after write operation
          state_x <= RW_SETUP;          -- look for another operation after the hold period

          -----------------------------------------------------------
          -- unknown state
          -----------------------------------------------------------
        when others =>
          state_x  <= RW_SETUP;         -- reset state if in erroneous state
          status_x <= "1000";

      end case;
    end if;
  end process combinatorial;


  -----------------------------------------------------------
  -- update registers on the appropriate clock edge     
  -----------------------------------------------------------

  update : process(pioRst, clk)
  begin

    if pioRst = YES then
      -- asynchronous reset
      state_r     <= RW_SETUP;
      timer_r     <= 0;
      pioBusy_r   <= NO;
      pioIntrq_r  <= NO;
      intrq_r     <= NO;
      intrqCnt_r  <= (others => '0');
      dior_r      <= HI;
      diow_r      <= HI;
      da_r        <= (others => '0');
      ddOut_r     <= (others => '0');
      ddOutEnbl_r <= NO;
      ddIn_r      <= (others => '0');
      status_r    <= (others => '0');
    elsif rising_edge(clk) then
      state_r     <= state_x;
      timer_r     <= timer_x;
      pioBusy_r   <= pioBusy_x;
      pioIntrq_r  <= pioIntrq_x;
      intrq_r     <= intrq_x;
      intrqCnt_r  <= intrqCnt_x;
      dior_r      <= dior_x;
      diow_r      <= diow_x;
      da_r        <= da_x;
      ddOut_r     <= ddOut_x;
      ddOutEnbl_r <= ddOutEnbl_x;
      ddIn_r      <= ddIn_x;
      status_r    <= status_x;
    end if;

  end process update;

end arch;





library IEEE, UNISIM;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.ata.all;

--------------------------------------------------------------------
-- Company : XESS Corp.
-- Engineer : Dave Vanden Bout
-- Creation Date : 04/14/2004
-- Copyright : 2004-2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
-- This module reads or write a one or more 256-word sectors of the disk.
--
-- For a read operation, the host supplies the head, cylinder and beginning
-- sector to be read and pulls the read control line high. The read operation
-- begins on the next rising clock edge. A word of data from the sector can
-- be read each time the done signal goes high. Lowering the read control line
-- will temporarily halt the flow of data. The data flow will resume once the
-- read control line is raised again. The sector read operation can be terminated
-- by raising the abort control line.
--
-- For a write operation, the host supplies the head, cylinder, beginning sector,
-- and initial data word to be written and pulls the write control line high.
-- The write operation begins on the next rising clock edge. A word of data is
-- written to the sector each time the done signal goes high, after which new data
-- must be supplied. Lowering the write control line will temporarily halt the
-- flow of data. The data flow will resume once the write control line is raised
-- again. The sector write operation can be terminated by raising the abort control line.
--
-- Revision:
-- 1.0.1
--
-- Additional Comments:
-- 1.0.1:
-- Added multisector R/W.
-- Added enhanced ATA status output.
-- 1.0.0:
-- Initial release.
--
-- License:
-- This code can be freely distributed and modified as long as
-- this header is not removed.
--------------------------------------------------------------------

entity ataCntl is
  generic(
    FREQ           :     natural := 50_000;  -- operating frequency in KHz
    SECTORS_PER_RW :     natural := 1   -- number of sectors to read/write
    );
  port(
    -- host side
    clk            : in  std_logic;     -- master clock
    rst            : in  std_logic;     -- reset
    rd             : in  std_logic;     -- initiate read operation
    wr             : in  std_logic;     -- initiate write operation
    abort          : in  std_logic;     -- aborts       read/write sector operation
    head           : in  std_logic_vector(3 downto 0);  -- disk head for data access
    cylinder       : in  std_logic_vector(15 downto 0);  -- cylinder for data access
    sector         : in  std_logic_vector(7 downto 0);  -- sector for data access
    hDIn           : in  std_logic_vector(15 downto 0);  -- data from host to disk
    hDOut          : out std_logic_vector(15 downto 0);  -- data from disk to host
    done           : out std_logic;     -- read or write operation is done
    status         : out std_logic_vector(6 downto 0);  -- diagnostic status            

    -- disk side
    dior_n    : out std_logic;          -- disk register read-enable
    diow_n    : out std_logic;          -- disk register write-enable
    cs0_n     : out std_logic;          -- disk command block register select
    cs1_n     : out std_logic;          -- disk control block register select
    da        : out std_logic_vector(2 downto 0);  -- register address
    ddIn      : in  std_logic_vector(15 downto 0);  -- data from disk
    ddOut     : out std_logic_vector(15 downto 0);  -- data to disk
    ddOutEnbl : out std_logic;          -- enable data outputs to disk
    intrq     : in  std_logic;          -- interrupt from disk
    dmack_n   : out std_logic           -- DMA acknowledge
    );
end ataCntl;



architecture arch of ataCntl is

  -- disk register addresses: (cs1,cs0,da2,da1,da0)
  constant CONTROL_REG    : std_logic_vector(4 downto 0) := "01110";
  constant DATA_REG       : std_logic_vector(4 downto 0) := "10000";
  constant SECTOR_CNT_REG : std_logic_vector(4 downto 0) := "10010";
  constant SECTOR_REG     : std_logic_vector(4 downto 0) := "10011";
  constant CYL_LOW_REG    : std_logic_vector(4 downto 0) := "10100";
  constant CYL_HIGH_REG   : std_logic_vector(4 downto 0) := "10101";
  constant DRIVE_HEAD_REG : std_logic_vector(4 downto 0) := "10110";
  constant CMD_REG        : std_logic_vector(4 downto 0) := "10111";
  constant STATUS_REG     : std_logic_vector(4 downto 0) := "10111";

  -- commands for disk
  constant DRIVE_RESET_CMD   : std_logic_vector(7 downto 0) := x"0C";
  constant DRIVE_RELEASE_CMD : std_logic_vector(7 downto 0) := x"08";
  constant NOP_CMD           : std_logic_vector(7 downto 0) := x"00";
  constant READ_SECTOR_CMD   : std_logic_vector(7 downto 0) := x"20";
  constant WRITE_SECTOR_CMD  : std_logic_vector(7 downto 0) := x"30";

  -- disk status register bits
  constant STATUS_REG_BSY : natural := 7;
  constant STATUS_REG_DRQ : natural := 3;
  constant STATUS_REG_ERR : natural := 0;

  -- number of 16-bit words per disk sector
  constant SECTOR_SIZE : natural := 256;

  -- states of the ATA drive interface state machine
  type cntlState is (
    WAIT_FOR_NOT_BUSY,
    WAIT_FOR_NOT_BUSY_1,
    RESET_DRIVE,
    RESET_DRIVE_1,
    ABORT_1,
    WAIT_FOR_CMD,
    SETUP_DRIVE,
    SETUP_DRIVE_1,
    SETUP_DRIVE_2,
    SETUP_DRIVE_3,
    SETUP_DRIVE_4,
    SETUP_DRIVE_5,
    WRITE_WORDS,
    WRITE_WORDS_1,
    WRITE_WORDS_2,
    WRITE_WORDS_3,
    WRITE_WORDS_4,
    WRITE_WORDS_5,
    READ_WORDS,
    READ_WORDS_1,
    READ_WORDS_2,
    READ_WORDS_3,
    error
    );
  signal state_r, state_x       : cntlState;  -- state register and next state
  signal rtnState_r, rtnState_x : cntlState;  -- state register and next state

  -- ATA drive interface registers
  signal cmd_r, cmd_x         : std_logic_vector(7 downto 0);  -- ATA drive command (e.g. READ_SECTOR)
  signal wordCnt_r, wordCnt_x : natural range SECTOR_SIZE-1 downto 0;  -- counts words read from sector
  signal status_r, status_x   : std_logic_vector(status'range);

  constant ERROR_FLAG : natural := 0;   -- position of error flag bit in status register

  -- PIO interface signals
  signal pioRd    : std_logic;          -- initiate read operation
  signal pioWr    : std_logic;          -- initiate write operation
  signal pioBusy  : std_logic;          -- read or write operation in-progress
  signal pioIntrq : std_logic;          -- debounced interrupt from disk
  signal pioAddr  : std_logic_vector(4 downto 0);  -- register address from host
  signal pioDIn   : std_logic_vector(15 downto 0);  -- data from host       to disk
  signal pioDOut  : std_logic_vector(15 downto 0);  -- data from disk to host

begin

  -------------------------------------------------------------------
  -- instantiate the low-level interface to the disk registers
  -------------------------------------------------------------------

  u0 : pioIntfc
    generic map(
      FREQ     => FREQ
      )
    port map(
      clk      => clk,
      pioRst   => rst,
      pioRd    => pioRd,
      pioWr    => pioWr,
      pioAddr  => pioAddr,
      pioDIn   => pioDIn,
      pioDOut  => pioDOut,
      pioBusy  => pioBusy,
      pioIntrq => pioIntrq,
      status   => open,

      dior_n    => dior_n,
      diow_n    => diow_n,
      cs0_n     => cs0_n,
      cs1_n     => cs1_n,
      da        => da,
      ddIn      => ddIn,
      ddOut     => ddOut,
      ddOutEnbl => ddOutEnbl,
      intrq     => intrq,
      dmack_n   => dmack_n
      );

  -----------------------------------------------------------
  -- attach some internal signals to the host and disk ports 
  -----------------------------------------------------------

  hdOut  <= pioDOut;
  status <= status_r;

  -----------------------------------------------------------
  -- compute the next state and outputs 
  -----------------------------------------------------------

  combinatorial : process(state_r, rd, wr, head, cylinder, sector, hDIn, cmd_r, pioDOut,
                          status_r, pioBusy, pioIntrq, wordCnt_r, rtnState_r)
  begin

    -----------------------------------------------------------
    -- setup default values for signals 
    -----------------------------------------------------------

    done       <= NO;
    pioRd      <= NO;
    pioWr      <= NO;
    pioDIn     <= (others => '0');
    pioAddr    <= (others => '0');
    state_x    <= state_r;
    rtnState_x <= rtnState_r;
    cmd_x      <= cmd_r;
    wordCnt_x  <= wordCnt_r;
    status_x   <= status_r;

    if(pioBusy = NO) then

      -----------------------------------------------------------
      -- compute the next state and outputs 
      -----------------------------------------------------------

      case state_r is

        -----------------------------------------------------------------
        -- set and then clear the reset bit in the disk control register
        -----------------------------------------------------------------                               
        when RESET_DRIVE   =>
          pioWr              <= YES;
          pioAddr            <= CONTROL_REG;
          pioDIn(7 downto 0) <= DRIVE_RESET_CMD;
          state_x            <= RESET_DRIVE_1;
          status_x           <= "0000010";
        when RESET_DRIVE_1 =>
          pioWr              <= YES;
          pioAddr            <= CONTROL_REG;
          pioDIn(7 downto 0) <= DRIVE_RELEASE_CMD;
          state_x            <= WAIT_FOR_NOT_BUSY;  -- wait for the drive to go non-busy after reset
          rtnState_x         <= WAIT_FOR_CMD;
          status_x           <= "0000100";

          -----------------------------------------------------------------
          -- abort the current command by issuing a NOP command
          -----------------------------------------------------------------                             
        when ABORT_1 =>
          pioWr              <= YES;
          pioAddr            <= CMD_REG;
          pioDIn(7 downto 0) <= NOP_CMD;
          state_x            <= WAIT_FOR_NOT_BUSY;
          rtnState_x         <= WAIT_FOR_CMD;
          status_x           <= "0000110";

          -----------------------------------------------------------------
          -- wait for the busy bit in the disk status register to clear
          -----------------------------------------------------------------                             
        when WAIT_FOR_NOT_BUSY   =>
          pioRd     <= YES;
          pioAddr   <= STATUS_REG;
          state_x   <= WAIT_FOR_NOT_BUSY_1;
          status_x  <= "0001000";
        when WAIT_FOR_NOT_BUSY_1 =>
          if(pioDOut(STATUS_REG_BSY) = YES) then
            state_x <= WAIT_FOR_NOT_BUSY;  -- busy bit not clear so check it again
          else
            state_x <= rtnState_r;      -- pop the state registers
          end if;
          status_x  <= "0001010";

          -----------------------------------------------------------------
          -- wait for a read or write sector command
          -----------------------------------------------------------------                             
        when WAIT_FOR_CMD =>
          if(rd = YES) then
                                        -- read a sector of the disk
            wordCnt_x  <= SECTOR_SIZE-1;  -- set number of words to read from sector
            cmd_x      <= READ_SECTOR_CMD;  -- command for rading a sector
            state_x    <= SETUP_DRIVE;  -- setup the disk registers for reading the sector
            rtnState_x <= READ_WORDS;
          elsif(wr = YES) then
                                        -- write a sector of the disk
            wordCnt_x  <= SECTOR_SIZE-1;  -- set number of words to write to sector
            cmd_x      <= WRITE_SECTOR_CMD;  -- command for writing a sector
            state_x    <= SETUP_DRIVE;  -- setup the disk registers for writing the sector
            rtnState_x <= WRITE_WORDS;
          else
                                        -- no operation requested
            state_x    <= WAIT_FOR_CMD;  -- keep waiting for a R/W command
          end if;
          status_x     <= "0001100";

          -----------------------------------------------------------------
          -- setup the disk to read or write a sector
          -----------------------------------------------------------------                             
        when SETUP_DRIVE   =>
          -- load the sector count register with the number of sectors to be read/written
          pioWr               <= YES;
          pioAddr             <= SECTOR_CNT_REG;
          pioDIn              <= CONV_STD_LOGIC_VECTOR(SECTORS_PER_RW, pioDIn'length);
          state_x             <= SETUP_DRIVE_1;
          status_x            <= "0001110";
        when SETUP_DRIVE_1 =>
          -- load the number of the sector that will be read/written
          pioWr               <= YES;
          pioAddr             <= SECTOR_REG;
          pioDIn(7 downto 0)  <= sector;
          state_x             <= SETUP_DRIVE_2;
          status_x            <= "0010000";
        when SETUP_DRIVE_2 =>
          -- load the number of the cylinder that contains the desired sector
          pioWr               <= YES;
          pioAddr             <= CYL_LOW_REG;
          pioDIn(7 downto 0)  <= cylinder(7 downto 0);
          state_x             <= SETUP_DRIVE_3;
          status_x            <= "0010010";
        when SETUP_DRIVE_3 =>
          pioWr               <= YES;
          pioAddr             <= CYL_HIGH_REG;
          pioDIn(7 downto 0)  <= cylinder(15 downto 8);
          state_x             <= SETUP_DRIVE_4;
          status_x            <= "0010100";
        when SETUP_DRIVE_4 =>
          -- load the number of the head that accesses the desired cylinder
          pioWr               <= YES;
          pioAddr             <= DRIVE_HEAD_REG;
          pioDIn(7 downto 0)  <= "1010" & head;
          state_x             <= SETUP_DRIVE_5;
          status_x            <= "0010110";
        when SETUP_DRIVE_5 =>
          -- load the command (read sector or write sector)
          pioWr               <= YES;
          pioAddr             <= CMD_REG;
          pioDIn(cmd_r'range) <= cmd_r;
          state_x             <= rtnState_r;
          status_x            <= "0011000";

          -----------------------------------------------------------------
          -- write data to the disk sector
          -----------------------------------------------------------------                             
        when WRITE_WORDS   =>
          state_x                <= WAIT_FOR_NOT_BUSY;
          rtnState_x             <= WRITE_WORDS_1;
          status_x               <= "0011000";
        when WRITE_WORDS_1 =>
          -- check the data request bit to see if the sector is ready for read/write ops
          if(pioDOut(STATUS_REG_DRQ) = YES) then
            state_x              <= WRITE_WORDS_2;  -- if ready, then write sector state
          elsif(pioDOut(STATUS_REG_ERR) = YES) then
            status_x(ERROR_FLAG) <= YES;  -- tell the host there was an error
            state_x              <= error;
          else
                                        -- data not ready, so read status again
            pioRd                <= YES;
            pioAddr              <= STATUS_REG;
            state_x              <= WRITE_WORDS_1;
          end if;
          status_x               <= "0011010";
        when WRITE_WORDS_2 =>
          -- write another word to the disk each time the write control is high
          if(wr = YES) then
            pioWr                <= YES;
            pioAddr              <= DATA_REG;
            pioDIn               <= hDIn;
            state_x              <= WRITE_WORDS_3;
          else
            state_x              <= WRITE_WORDS_2;  -- halt writes to disk when wr is inactive
          end if;
          status_x               <= "0011100";
        when WRITE_WORDS_3 =>
          done                   <= YES;  -- tell the host this word has been written to disk
          if(wordCnt_r = 0) then
            -- this sector is done, so write the next sector
            state_x              <= WRITE_WORDS_4;
          else
            -- otherwise, write the next word to this sector
            wordCnt_x            <= wordCnt_r - 1;
            state_x              <= WRITE_WORDS_2;
          end if;
          status_x               <= "0011110";
        when WRITE_WORDS_4 =>
          -- wait for the interrupt from the disk that indicates the write of the
          -- current sector is done.
          if(pioIntrq = YES) then
                                        -- the interrupt has arrived, so see if there are more sectors to write
            pioRd                <= YES;
            pioAddr              <= STATUS_REG;
            state_x              <= WRITE_WORDS_5;
          else
                                        -- keep waiting for the interrupt
            state_x              <= WRITE_WORDS_4;
          end if;
          status_x               <= "0100000";
        when WRITE_WORDS_5 =>
          if(pioDOut(STATUS_REG_DRQ) = YES) then
                                        -- if the disk is still busy, then there are more sectors to write
            wordCnt_x            <= SECTOR_SIZE-1;  -- set number of words to write to the next sector
            state_x              <= WRITE_WORDS_2;
          else
                                        -- there are no more sectors to write, so go wait for another command
            state_x              <= WAIT_FOR_CMD;
          end if;
          status_x               <= "0100010";

          -----------------------------------------------------------------
          -- read data from the disk sector
          -----------------------------------------------------------------                             
        when READ_WORDS   =>
          if(pioIntrq = YES) then
            pioRd     <= YES;
            pioAddr   <= STATUS_REG;
            state_x   <= READ_WORDS_1;
          else
            state_x   <= READ_WORDS;
          end if;
          status_x    <= "0100100";
        when READ_WORDS_1 =>
          -- read another word from the disk each time the read control is high
          if(rd = YES) then
            pioRd     <= YES;
            pioAddr   <= DATA_REG;
            state_x   <= READ_WORDS_2;
          else
            state_x   <= READ_WORDS_1;  -- halt reads from disk when rd is inactive
          end if;
          status_x    <= "0100110";
        when READ_WORDS_2 =>
          done        <= YES;           -- tell the host a word has been read and is available
          if(wordCnt_r = 0) then
                                        -- this sector is done, so read the next sector
            pioRd     <= YES;
            pioAddr   <= STATUS_REG;
            state_x   <= READ_WORDS_3;
          else
                                        -- otherwise, read the next word from this sector
            wordCnt_x <= wordCnt_r - 1;
            state_x   <= READ_WORDS_1;
          end if;
          status_x    <= "0101000";
        when READ_WORDS_3 =>
          if(pioDOut(STATUS_REG_BSY) = YES) then
                                        -- there are more sectors still to read
            wordCnt_x <= SECTOR_SIZE-1;  -- set number of words to read from the next sector
            state_x   <= READ_WORDS;
          else
                                        -- there are no more sectors to read, so go wait for another command
            state_x   <= WAIT_FOR_CMD;
          end if;
          status_x    <= "0101010";


          -----------------------------------------------------------------
          -- error state.  Requires a reset to leave this state
          -----------------------------------------------------------------                             
        when error =>
          state_x              <= error;
          status_x(ERROR_FLAG) <= YES;

          -----------------------------------------------------------------
          -- unknown state.  Go to the error state
          -----------------------------------------------------------------                             
        when others =>
          state_x              <= error;
          status_x(ERROR_FLAG) <= YES;

      end case;
    end if;
  end process combinatorial;


  -----------------------------------------------------------
  -- update registers on the appropriate clock edge     
  -----------------------------------------------------------

  update : process(rst, clk)
  begin

    if rst = YES then
      -- asynchronous reset
      state_r    <= RESET_DRIVE;        -- upon reset, reset the drive
      rtnState_r <= WAIT_FOR_CMD;       -- and then wait for read/write commands
      cmd_r      <= (others => '0');
      wordCnt_r  <= 0;
      status_r   <= (others => '0');    -- clear the status register
    elsif rising_edge(clk) then
      if(abort = YES) then
        -- abort a read or write sector command and go back to wait for another command
        state_r  <= ABORT_1;
      else
        state_r  <= state_x;
      end if;
      rtnState_r <= rtnState_x;
      cmd_r      <= cmd_x;
      wordCnt_r  <= wordCnt_x;
      status_r   <= status_x;
    end if;

  end process update;

end arch;
