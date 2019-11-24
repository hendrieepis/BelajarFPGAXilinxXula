--------------------------------------------------------------------
-- Company : XESS Corp.
-- Engineer : Dave Vanden Bout
-- Creation Date : 06/13/2005
-- Copyright : 2005, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
-- This module tests the SDRAM controller and external SDRAM chip by
-- writing a random data pattern to the SDRAM and then reading it
-- back to see if the SDRAM contains the correct pattern.
--
--  +--------------+    +---------------+      +  -----------+
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |    memory    |    |    SDRAM      |      |   SDRAM   |
--  |    tester    |<==>|  controller   |<====>|   chip    |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  +--------------+    +---------------+      +  -----------+
--
-- Revision:
-- 1.0.0
--
-- Additional Comments:
--
-- License:
-- This code can be freely distributed and modified as long as
-- this header is not removed.
--------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

package test_board_core_pckg is
  component test_board_core
    generic(
      FREQ        :       natural := 50_000;  -- frequency of operation in KHz
      CLK_DIV     :       real    := 1.0;  -- divisor for FREQ (can only be 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 8.0 or 16.0)
      PIPE_EN     :       boolean := true;  -- enable fast, pipelined SDRAM operation
      DATA_WIDTH  :       natural := 16;  -- SDRAM data width
      SADDR_WIDTH :       natural := 13;  -- SDRAM row/col address width
      NROWS       :       natural := 4096;  -- number of rows in the SDRAM
      NCOLS       :       natural := 256;  -- number of columns in each SDRAM row
      -- beginning and ending addresses for the entire SDRAM
      BEG_ADDR    :       natural := 16#00_0000#;
      END_ADDR    :       natural := 16#3F_FFFF#;
      -- beginning and ending address for the memory tester
      BEG_TEST    :       natural := 16#00_0000#;
      END_TEST    :       natural := 16#3F_FFFF#
      );
    port(
      button_n    : in    std_logic;    -- active-low pushbutton input
      clk         : in    std_logic;    -- main clock input from external clock source
      clk1x       : out   std_logic;    -- copy of main clock from sync'ed by DLL for use by external logic
      sclkfb      : in    std_logic;    -- feedback SDRAM clock with PCB delays
      sclk        : out   std_logic;    -- clock to SDRAM
      cke         : out   std_logic;    -- SDRAM clock-enable
      cs_n        : out   std_logic;    -- SDRAM chip-select
      ras_n       : out   std_logic;    -- SDRAM RAS
      cas_n       : out   std_logic;    -- SDRAM CAS
      we_n        : out   std_logic;    -- SDRAM write-enable
      ba          : out   std_logic_vector(1 downto 0);  -- SDRAM bank-address
      sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
      sData       : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
      dqmh        : out   std_logic;    -- SDRAM DQMH
      dqml        : out   std_logic;    -- SDRAM DQML
      progress    : out   std_logic_vector(1 downto 0); -- test status (0X=in-progress, 11=success, 10=failure)
      err         : out   std_logic;    -- true if an error was found during test
      led         : out   std_logic_vector(6 downto 0);  -- 7-segment LED
      heartBeat   : out   std_logic     -- heartbeat status (usually sent to parallel port status pin)
      );
  end component test_board_core;
end package test_board_core_pckg;




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.mem.all;
use WORK.xsasdram.all;

entity test_board_core is
  generic(
    FREQ        :       natural := 50_000;  -- frequency of operation in KHz
    CLK_DIV     :       real    := 1.0;  -- divisor for FREQ (can only be 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 8.0 or 16.0)
    PIPE_EN     :       boolean := true;  -- enable fast, pipelined SDRAM operation
    DATA_WIDTH  :       natural := 16;  -- SDRAM data width
    SADDR_WIDTH :       natural := 13;  -- SDRAM row/col address width
    NROWS       :       natural := 4096;  -- number of rows in the SDRAM
    NCOLS       :       natural := 256;  -- number of columns in each SDRAM row
    -- beginning and ending addresses for the entire SDRAM
    BEG_ADDR    :       natural := 16#00_0000#;
    END_ADDR    :       natural := 16#3F_FFFF#;
    -- beginning and ending address for the memory tester
    BEG_TEST    :       natural := 16#00_0000#;
    END_TEST    :       natural := 16#3F_FFFF#
    );
  port(
    button_n    : in    std_logic;      -- active-low pushbutton input
    clk         : in    std_logic;      -- main clock input from external clock source
    clk1x       : out   std_logic;      -- copy of main clock from sync'ed by DLL for use by external logic
    sclkfb      : in    std_logic;      -- feedback SDRAM clock with PCB delays
    sclk        : out   std_logic;      -- clock to SDRAM
    cke         : out   std_logic;      -- SDRAM clock-enable
    cs_n        : out   std_logic;      -- SDRAM chip-select
    ras_n       : out   std_logic;      -- SDRAM RAS
    cas_n       : out   std_logic;      -- SDRAM CAS
    we_n        : out   std_logic;      -- SDRAM write-enable
    ba          : out   std_logic_vector(1 downto 0);  -- SDRAM bank-address
    sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
    sData       : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
    dqmh        : out   std_logic;      -- SDRAM DQMH
    dqml        : out   std_logic;      -- SDRAM DQML
    progress    : out   std_logic_vector(1 downto 0); -- test progress indicator
    err         : out   std_logic;      -- true if an error was found during test
    led         : out   std_logic_vector(6 downto 0);  -- 7-segment LED
    heartBeat   : out   std_logic       -- heartbeat status (usually sent to parallel port status pin)
    );
end entity;

architecture arch of test_board_core is
  constant HADDR_WIDTH : natural := log2(END_ADDR-BEG_ADDR+1);
  signal   rst_i       : std_logic;     -- internal reset signal
  signal   clk_i       : std_logic;     -- internal master clock signal
  signal   clk_b       : std_logic;     -- buffered input (non-DLL) clock
  signal   lock        : std_logic;     -- SDRAM clock DLL lock indicator
  signal   dataIn      : std_logic_vector(DATA_WIDTH-1 downto 0);  -- input databus from SDRAM
  signal   dataOut     : std_logic_vector(DATA_WIDTH-1 downto 0);  -- output databus to SDRAM
  signal   divCnt      : std_logic_vector(22 downto 0);  -- clock divider
  signal   syncButton  : std_logic_vector(1 downto 0);  -- button input sync'ed to clock domain
  
  signal rst_cnt    : natural range 0 to 255;

  -- signals that go through the SDRAM host-side interface
  signal begun      : std_logic;        -- SDRAM operation started indicator
  signal earlyBegun : std_logic;        -- SDRAM operation started indicator
  signal done       : std_logic;        -- SDRAM operation complete indicator
  signal rdDone     : std_logic;        -- SDRAM operation complete indicator
  signal hAddr      : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host address bus
  signal hDIn       : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal hDOut      : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal rd         : std_logic;        -- host-side read control signal
  signal wr         : std_logic;        -- host-side write control signal
  signal rdPending  : std_logic;        -- read operation pending in SDRAM pipeline

  -- status signals from the memory tester
  signal progress_i : std_logic_vector(1 downto 0);  -- test progress indicator
  signal err_i      : std_logic;                     -- test error flag

  -- set the reset flag upon startup
  attribute INIT          : string;
  attribute INIT of rst_i : signal is "1";

begin

  ------------------------------------------------------------------------
  -- internal reset flag is set active by config. bitstream
  -- and then gets reset after clocks start.
  ------------------------------------------------------------------------
  process(clk_b)
  begin
    if rising_edge(clk_b) then
      if lock = NO then
        rst_i   <= YES;                 -- keep in reset until DLLs start up and lock
        rst_cnt <= 100;
      else
        if rst_cnt=0 then
          rst_i <= NO;                  -- release reset once DLLs lock and reset counter reaches 0
        else
          rst_cnt <= rst_cnt - 1;
          rst_i <= YES;
        end if;
      end if;
    end if;
  end process;
  
  ------------------------------------------------------------------------
  -- synchronize the pushbutton to the main clock.  The LSB of syncButton
  -- is high when the pushbutton is pressed.
  ------------------------------------------------------------------------
  process(clk_b)
  begin
    if rising_edge(clk_b) then
      syncButton <= not(button_n) & syncButton(syncButton'high downto 1);
    end if;
  end process;

  ------------------------------------------------------------------------
  -- Instantiate a memory tester that supports memory pipelining if that option is enabled
  ------------------------------------------------------------------------
  gen_fast_memtest : if PIPE_EN generate
    fast_memtest   : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => DATA_WIDTH,
        ADDR_WIDTH => HADDR_WIDTH,
        BEG_TEST   => BEG_TEST,
        END_TEST   => END_TEST
        )
      port map(
        clk        => clk_i,            -- master internal clock
        rst        => rst_i,            -- reset
        doAgain    => syncButton(0),    -- re-do the memory test if the button is pushed
        begun      => earlyBegun,       -- SDRAM controller operation started
        done       => rdDone,           -- SDRAM controller operation complete
        dIn        => hDOut,            -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending,        -- tell the memory tester if the SDRAM has pending reads
        rd         => rd,               -- host-side SDRAM read control from memory tester
        wr         => wr,               -- host-side SDRAM write control from memory tester
        addr       => hAddr,            -- host-side address from memory tester
        dOut       => hDIn,             -- host-side data to SDRAM from memory tester
        progress   => progress_i,       -- current phase of memory test
        err        => err_i             -- memory test error flag
        );
  end generate;

  ------------------------------------------------------------------------
  -- Instantiate memory tester without memory pipelining if that option is disabled
  ------------------------------------------------------------------------
  gen_slow_memtest : if not PIPE_EN generate
    slow_memtest   : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => DATA_WIDTH,
        ADDR_WIDTH => HADDR_WIDTH,
        BEG_TEST   => BEG_TEST,
        END_TEST   => END_TEST
        )
      port map(
        clk        => clk_i,            -- master internal clock
        rst        => rst_i,            -- reset
        doAgain    => syncButton(0),    -- re-do the memory test
        begun      => begun,            -- SDRAM controller operation started
        done       => done,             -- SDRAM controller operation complete
        dIn        => hDOut,            -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending,        -- tell the memory tester if the SDRAM has pending reads
        rd         => rd,               -- host-side SDRAM read control from memory tester
        wr         => wr,               -- host-side SDRAM write control from memory tester
        addr       => hAddr,            -- host-side address from memory tester
        dOut       => hDIn,             -- host-side data to SDRAM from memory tester
        progress   => progress_i,       -- current phase of memory test
        err        => err_i             -- memory test error flag
        );
  end generate;

  ------------------------------------------------------------------------
  -- Instantiate the SDRAM controller that connects to the memory tester
  -- module and interfaces to the external SDRAM chip.
  ------------------------------------------------------------------------
  u1 : xsaSDRAMCntl
    generic map(
      FREQ                 => FREQ,
      CLK_DIV              => CLK_DIV,
      PIPE_EN              => PIPE_EN,
      DATA_WIDTH           => DATA_WIDTH,
      MULTIPLE_ACTIVE_ROWS => true,
      NROWS                => NROWS,
      NCOLS                => NCOLS,
      HADDR_WIDTH          => HADDR_WIDTH,
      SADDR_WIDTH          => SADDR_WIDTH
      )
    port map(
      clk                  => clk,      -- master clock from external clock source (unbuffered)
      bufclk               => clk_b,    -- buffered master clock output
      clk1x                => clk_i,    -- synchronized master clock (accounts for delays to external SDRAM)
      clk2x                => open,     -- synchronized doubled master clock
      lock                 => lock,     -- DLL lock indicator
      rst                  => rst_i,    -- reset
      rd                   => rd,       -- host-side SDRAM read control from memory tester
      wr                   => wr,       -- host-side SDRAM write control from memory tester
      rdPending            => rdPending,  -- read operation to SDRAM is in progress
      opBegun              => begun,    -- indicates memory read/write has begun
      earlyOpBegun         => earlyBegun,  -- early indicator that memory operation has begun
      rdDone               => rdDone,   -- indicates SDRAM memory read operation is done
      done                 => done,     -- indicates SDRAM memory read or write operation is done
      hAddr                => hAddr,    -- host-side address from memory tester to SDRAM
      hDIn                 => hDIn,     -- test data pattern from memory tester to SDRAM
      hDOut                => hDOut,    -- SDRAM data output to memory tester
      status               => open,     -- SDRAM controller state (for diagnostics)
      sclkfb               => sclkfb,   -- clock feedback with added external PCB delays
      sclk                 => sclk,     -- synchronized clock to external SDRAM
      cke                  => cke,      -- SDRAM clock enable
      cs_n                 => cs_n,     -- SDRAM chip-select
      ras_n                => ras_n,    -- SDRAM RAS
      cas_n                => cas_n,    -- SDRAM CAS
      we_n                 => we_n,     -- SDRAM write-enable
      ba                   => ba,       -- SDRAM bank address
      sAddr                => sAddr,    -- SDRAM address
      sData                => sData,    -- SDRAM databus
      dqmh                 => dqmh,     -- SDRAM DQMH
      dqml                 => dqml      -- SDRAM DQML
      );
      
  clk1x <= clk_i;  -- send sync'ed master clock back to external logic

  ------------------------------------------------------------------------
  -- Indicate the phase of the memory tester on the segments of the 
  -- seven-segment LED.  The phases of the memory test are
  -- indicated as shown below (|=LED OFF; *=LED ON):
  -- 
  --       ----*           *****            *****           ******           ******
  --      |    *          |    *           |    *           *    *           *    |
  --       ----*          ******            *****           *  ----*           ******
  --      |    *          *    |           |    *           *    *           *    |
  --       ----*          *****             *****           ******           ******
  --  Initialization  Writing pattern  Reading pattern    Memory test  or  Memory test
  --      Phase          to memory       from memory        passed           failed
  ------------------------------------------------------------------------
  led <= "0010010" when progress_i = "00" else  -- "1" during initialization
         "1011101" when progress_i = "01" else  -- "2" when writing to memory
         "1011011" when progress_i = "10" else  -- "3" when reading from memory
         "1101101" when err_i = YES       else  -- "E" if memory test failed
         "1110111";                     -- "O" if memory test passed

  ------------------------------------------------------------------------
  -- Generate some slow signals from the master clock.
  ------------------------------------------------------------------------
  process(clk_b)
  begin
    if rising_edge(clk_b) then
      divCnt <= divCnt+1;
    end if;
  end process;

  ------------------------------------------------------------------------
  -- Send a heartbeat signal back to the PC to indicate
  -- the status of the memory test:
  --   50% duty cycle -> test in progress
  --   75% duty cycle -> test passed
  --   25% duty cycle -> test failed
  ------------------------------------------------------------------------
  heartBeat <= divCnt(16)               when progress_i/="11" else  -- test in progress
               divCnt(16) or divCnt(15) when err_i = NO       else  -- test passed
               divCnt(16) and divCnt(15);  -- test failed                              

  progress    <= progress_i;
  err         <= err_i;

end architecture;
