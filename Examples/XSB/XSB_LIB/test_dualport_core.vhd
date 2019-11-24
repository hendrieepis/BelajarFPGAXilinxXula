--------------------------------------------------------------------
-- Company : XESS Corp.
-- Engineer : Dave Vanden Bout
-- Creation Date : 06/13/2005
-- Copyright : 2005, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
-- This module tests the dualport module for the SDRAM controller.
-- Two parallel memory testers are connected to the port0 and port1
-- channels of the dualport module.  Each tester independently writes
-- a random data pattern to a section of the SDRAM and then reads it
-- back to see if the SDRAM contains the correct pattern.  This tests
-- that the dualport module is actually providing two independent
-- read/write paths to the SDRAM that do not interfere with each other.
--
--  +---------+    +--------------+    +---------------+      +-----------+
--  | memory  |    |              |    |               |      |           |
--  | tester  |<==>|              |    |               |      |           |
--  |   0     |    |              |    |               |      |           |
--  +---------+    |   dualport   |    |    SDRAM      |      |   SDRAM   |
--                 |    module    |<==>|  controller   |<====>|   chip    |
--  +---------+    |              |    |               |      |           |
--  | memory  |    |              |    |               |      |           |
--  | tester  |<==>|              |    |               |      |           |
--  |   1     |    |              |    |               |      |           |
--  +---------+    +--------------+    +---------------+      +-----------+
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

package test_dualport_core_pckg is
  component test_dualport_core
    generic(
      FREQ        :       natural := 67_000;  -- frequency of operation in KHz
      PIPE_EN     :       boolean := true;  -- enable fast, pipelined SDRAM operation
      DATA_WIDTH  :       natural := 16;  -- SDRAM data width
      SADDR_WIDTH :       natural := 13;  -- SDRAM row/col address width
      NROWS       :       natural := 4096;  -- number of rows in the SDRAM
      NCOLS       :       natural := 512;  -- number of columns in each SDRAM row
      -- beginning and ending addresses for the entire SDRAM
      BEG_ADDR    :       natural := 16#00_0000#;
      END_ADDR    :       natural := 16#7F_FFFF#;
      -- beginning and ending address for the memory tester attached to port 0
      BEG_TEST_0  :       natural := 16#00_0000#;
      END_TEST_0  :       natural := 16#3F_FFFF#;
      -- beginning and ending address for the memory tester attached to port 1
      BEG_TEST_1  :       natural := 16#40_0000#;
      END_TEST_1  :       natural := 16#7F_FFFF#;
      -- allocate time slots between ports 0 and 1
      PORT_TIME_SLOTS :   std_logic_vector(15 downto 0) := "1111111100000000"
      );
    port(
      clk         : in    std_logic;      -- main clock input from external clock source
      cke         : out   std_logic;      -- SDRAM clock-enable
      cs_n        : out   std_logic;      -- SDRAM chip-select
      ras_n       : out   std_logic;      -- SDRAM RAS
      cas_n       : out   std_logic;      -- SDRAM CAS
      we_n        : out   std_logic;      -- SDRAM write-enable
      ba          : out   std_logic_vector(1 downto 0);  -- SDRAM bank-address
      sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
      sDataIn     : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from SDRAM
      sDataOut    : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to SDRAM
      sDataOutEn  : out   std_logic;      -- high when data is output to SDRAM
      dqmh        : out   std_logic;      -- SDRAM DQMH
      dqml        : out   std_logic;      -- SDRAM DQML
      progress    : out   std_logic_vector(1 downto 0); -- test progress indicator
      led         : out   std_logic_vector(15 downto 0);  -- dual seven-segment LEDs
      heartBeat   : out   std_logic       -- heartbeat status (usually sent to parallel port status pin)
      );
  end component test_dualport_core;
end package test_dualport_core_pckg;




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.mem.all;
use WORK.sdram.all;

entity test_dualport_core is
  generic(
    FREQ        :       natural := 50_000;  -- frequency of operation in KHz
    PIPE_EN     :       boolean := true;  -- enable fast, pipelined SDRAM operation
    DATA_WIDTH  :       natural := 16;  -- SDRAM data width
    SADDR_WIDTH :       natural := 13;  -- SDRAM row/col address width
    NROWS       :       natural := 4096;  -- number of rows in the SDRAM
    NCOLS       :       natural := 256;  -- number of columns in each SDRAM row
    -- beginning and ending addresses for the entire SDRAM
    BEG_ADDR    :       natural := 16#00_0000#;
    END_ADDR    :       natural := 16#3F_FFFF#;
    -- beginning and ending address for the memory tester attached to port 0
    BEG_TEST_0  :       natural := 16#00_0000#;
    END_TEST_0  :       natural := 16#1F_FFFF#;
    -- beginning and ending address for the memory tester attached to port 1
    BEG_TEST_1  :       natural := 16#20_0000#;
    END_TEST_1  :       natural := 16#3F_FFFF#;
    -- allocate time slots between ports 0 and 1
    PORT_TIME_SLOTS :   std_logic_vector(15 downto 0) := "1111111111110000"
    );
  port(
    clk         : in    std_logic;      -- main clock input from external clock source
    cke         : out   std_logic;      -- SDRAM clock-enable
    cs_n        : out   std_logic;      -- SDRAM chip-select
    ras_n       : out   std_logic;      -- SDRAM RAS
    cas_n       : out   std_logic;      -- SDRAM CAS
    we_n        : out   std_logic;      -- SDRAM write-enable
    ba          : out   std_logic_vector(1 downto 0);  -- SDRAM bank-address
    sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
    sDataIn     : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from SDRAM
    sDataOut    : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to SDRAM
    sDataOutEn  : out   std_logic;      -- high when data is output to SDRAM
    dqmh        : out   std_logic;      -- SDRAM DQMH
    dqml        : out   std_logic;      -- SDRAM DQML
    progress    : out   std_logic_vector(1 downto 0); -- test progress indicator
    led         : out   std_logic_vector(15 downto 0);  -- dual seven-segment LEDs
    heartBeat   : out   std_logic       -- heartbeat status (usually sent to parallel port status pin)
    );
end entity;

architecture arch of test_dualport_core is
  constant HADDR_WIDTH     : natural := log2(END_ADDR-BEG_ADDR+1);
  signal   rst_i           : std_logic;  -- internal reset signal
  signal   rstCnt          : natural range 0 to 511;  -- reset timer
  signal   dataIn          : std_logic_vector(DATA_WIDTH-1 downto 0);  -- input databus from SDRAM
  signal   dataOut         : std_logic_vector(DATA_WIDTH-1 downto 0);  -- output databus to SDRAM
  signal   divCnt          : unsigned(20 downto 0);  -- clock divider

  -- signals that go through the dualport module port0 and port1 ports and to the SDRAM controller
  signal begun0, begun1, begun                : std_logic;  -- read/write operation started indicator
  signal earlyBegun0, earlyBegun1, earlyBegun : std_logic;  -- read/write operation started indicator
  signal rdPending0, rdPending1, rdPending    : std_logic;  -- read operation pending in SDRAM pipeline indicator
  signal done0, done1, done                   : std_logic;  -- read/write operation complete indicator
  signal rdDone0, rdDone1, rdDone             : std_logic;  -- read operation complete indicator
  signal hAddr0, hAddr1, hAddr                : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host-side address bus
  signal hDIn0, hDIn1, hDIn                   : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal hDOut0, hDOut1, hDOut                : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal rd0, rd1, rd                         : std_logic;  -- host-side read control signal
  signal wr0, wr1, wr                         : std_logic;  -- host-side write control signal
  signal rst                                  : std_logic;  -- SDRAM controller reset
  signal status                               : std_logic_vector(3 downto 0);  -- SDRAM controller status

  -- status signals from the memory testers connected to port0 and port1
  signal progress0, progress1 : std_logic_vector(1 downto 0);  -- test progress indicator
  signal err0, err1           : std_logic;  -- test error flag

begin

  ------------------------------------------------------------------------
  -- internal reset flag is set active right after configuration is done
  -- because the reset counter starts at zero, and then gets reset after
  -- the counter reaches its upper threshold.
  ------------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
      if rstCnt /= 100 then
        rst_i   <= '1';
        rstCnt  <= rstCnt + 1;
      else
        rst_i   <= '0';  -- remove reset once counter reaches its threshold
      end if;
    end if;
  end process;

  ------------------------------------------------------------------------
  -- Instantiate two memory testers that support memory pipelining if that option is enabled
  ------------------------------------------------------------------------
  gen_fast_memtest     : if PIPE_EN generate
    -- memory tester attached to dualport port 0
    fast_memtest_port0 : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn0'length,
        ADDR_WIDTH => hAddr0'length,
        BEG_TEST   => BEG_TEST_0,
        END_TEST   => END_TEST_0
        )
      port map(
        clk        => clk,              -- master clock
        rst        => rst_i,            -- reset
        doAgain    => NO,               -- only run the test once
        begun      => earlyBegun0,      -- SDRAM controller operation started
        done       => rdDone0,          -- SDRAM controller operation complete
        dIn        => hDOut0,           -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending0,       -- tell the memory tester if the SDRAM has pending reads
        rd         => rd0,              -- host-side SDRAM read control from memory tester
        wr         => wr0,              -- host-side SDRAM write control from memory tester
        addr       => hAddr0,           -- host-side address from memory tester
        dOut       => hDIn0,            -- host-side data to SDRAM from memory tester
        progress   => progress0,        -- current phase of memory test
        err        => err0              -- memory test error flag
        );
    -- memory tester attached to dualport port 1
    fast_memtest_port1 : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn1'length,
        ADDR_WIDTH => hAddr1'length,
        BEG_TEST   => BEG_TEST_1,
        END_TEST   => END_TEST_1
        )
      port map(
        clk        => clk,
        rst        => rst_i,
        doAgain    => NO,
        begun      => earlyBegun1,
        done       => rdDone1,
        dIn        => hDOut1,
        rdPending  => rdPending1,
        rd         => rd1,
        wr         => wr1,
        addr       => hAddr1,
        dOut       => hDIn1,
        progress   => progress1,
        err        => err1
        );
  end generate;

  ------------------------------------------------------------------------
  -- Instantiate two memory testers without memory pipelining if that option is disabled
  ------------------------------------------------------------------------
  gen_slow_memtest     : if not PIPE_EN generate
    -- memory tester attached to dualport port 0
    slow_memtest_port0 : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn0'length,
        ADDR_WIDTH => hAddr0'length,
        BEG_TEST   => BEG_TEST_0,
        END_TEST   => END_TEST_0
        )
      port map(
        clk        => clk,              -- master internal clock
        rst        => rst_i,            -- reset
        doAgain    => NO,               -- only run the test once
        begun      => begun0,           -- SDRAM controller operation started
        done       => done0,            -- SDRAM controller operation complete
        dIn        => hDOut0,           -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending0,       -- tell the memory tester if the SDRAM has pending reads
        rd         => rd0,              -- host-side SDRAM read control from memory tester
        wr         => wr0,              -- host-side SDRAM write control from memory tester
        addr       => hAddr0,           -- host-side address from memory tester
        dOut       => hDIn0,            -- host-side data to SDRAM from memory tester
        progress   => progress0,        -- current phase of memory test
        err        => err0              -- memory test error flag
        );
    -- memory tester attached to dualport port 1
    slow_memtest_port1 : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn1'length,
        ADDR_WIDTH => hAddr1'length,
        BEG_TEST   => BEG_TEST_1,
        END_TEST   => END_TEST_1
        )
      port map(
        clk        => clk,
        rst        => rst_i,
        doAgain    => NO,
        begun      => begun1,
        done       => done1,
        dIn        => hDOut1,
        rdPending  => rdPending1,
        rd         => rd1,
        wr         => wr1,
        addr       => hAddr1,
        dOut       => hDIn1,
        progress   => progress1,
        err        => err1
        );
  end generate;

  progress <= progress0 and progress1;

  ------------------------------------------------------------------------
  -- Instantiate the dualport module
  ------------------------------------------------------------------------
  u1 : dualport
    generic map(
      PIPE_EN         => PIPE_EN,
      PORT_TIME_SLOTS => PORT_TIME_SLOTS,
      DATA_WIDTH      => DATA_WIDTH,
      HADDR_WIDTH     => HADDR_WIDTH
      )
    port map(
      clk             => clk,
      -- memory tester port 0 connections
      rst0            => rst_i,
      rd0             => rd0,
      wr0             => wr0,
      rdPending0      => rdPending0,
      opBegun0        => begun0,
      earlyOpBegun0   => earlyBegun0,
      rdDone0         => rdDone0,
      done0           => done0,
      hAddr0          => hAddr0,
      hDIn0           => hDIn0,
      hDOut0          => hDOut0,
      status0         => open,
      -- memory tester port 1 connections
      rst1            => rst_i,
      rd1             => rd1,
      wr1             => wr1,
      rdPending1      => rdPending1,
      opBegun1        => begun1,
      earlyOpBegun1   => earlyBegun1,
      rdDone1         => rdDone1,
      done1           => done1,
      hAddr1          => hAddr1,
      hDIn1           => hDIn1,
      hDOut1          => hDOut1,
      status1         => open,
      -- connections to the SDRAM controller
      rst             => rst,
      rd              => rd,
      wr              => wr,
      rdPending       => rdPending,
      opBegun         => begun,
      earlyOpBegun    => earlyBegun,
      rdDone          => rdDone,
      done            => done,
      hAddr           => hAddr,
      hDIn            => hDIn,
      hDOut           => hDOut,
      status          => status
      );

  ------------------------------------------------------------------------
  -- Instantiate the SDRAM controller that connects to the memory tester
  -- module and interfaces to the external SDRAM chip.
  ------------------------------------------------------------------------
  u2 : sdramCntl
    generic map(
      FREQ         => FREQ,
      IN_PHASE     => false,
      PIPE_EN      => PIPE_EN,
      MAX_NOP      => 10000,
      DATA_WIDTH   => DATA_WIDTH,
      NROWS        => NROWS,
      NCOLS        => NCOLS,
      HADDR_WIDTH  => HADDR_WIDTH,
      SADDR_WIDTH  => SADDR_WIDTH
      )
    port map(
      clk          => clk,           -- master clock from external clock source (unbuffered)
      lock         => YES,           -- no DLLs, so frequency is always locked
      rst          => rst_i,         -- reset
      rd           => rd,            -- host-side SDRAM read control from memory tester
      wr           => wr,            -- host-side SDRAM write control from memory tester
      earlyOpBegun => earlyBegun,    -- early indicator that memory operation has begun
      opBegun      => begun,         -- indicates memory read/write has begun
      rdPending    => rdPending,     -- read operation to SDRAM is in progress
      done         => done,          -- SDRAM memory read/write done indicator
      rdDone       => rdDone,        -- indicates SDRAM memory read operation is done
      hAddr        => hAddr,         -- host-side address from memory tester to SDRAM
      hDIn         => hDIn,          -- test data pattern from memory tester to SDRAM
      hDOut        => hDOut,         -- SDRAM data output to memory tester
      status       => open,          -- SDRAM controller state (for diagnostics)
      cke          => cke,           -- SDRAM clock enable
      ce_n         => cs_n,          -- SDRAM chip-select
      ras_n        => ras_n,         -- SDRAM RAS
      cas_n        => cas_n,         -- SDRAM CAS
      we_n         => we_n,          -- SDRAM write-enable
      ba           => ba,            -- SDRAM bank address
      sAddr        => sAddr,         -- SDRAM address
      sDIn         => sDataIn,       -- data in from SDRAM
      sDOut        => sDataOut,      -- data out to SDRAM
      sDOutEn      => sDataOutEn,    -- high when data is sent to SDRAM
      dqmh         => dqmh,          -- SDRAM DQMH
      dqml         => dqml           -- SDRAM DQML
      );

  ------------------------------------------------------------------------
  -- Indicate the phase of memory tester 0 on the segments of the 
  -- seven-segment LED.  The phases of the memory test are
  -- indicated as shown below (|=LED OFF; *=LED ON):
  -- 
  --       ----*           *****            *****           ******           ******
  --      |    *          |    *           |    *           *    *           *    |
  --       ----*          ******            *****           *----*           ******
  --      |    *          *    |           |    *           *    *           *    |
  --       ----*          *****             *****           ******           ******
  --  Initialization  Writing pattern  Reading pattern    Memory test  or  Memory test
  --      Phase          to memory       from memory        passed           failed
  ------------------------------------------------------------------------
  led(7 downto 0) <= "00000110" when progress0 = "00" else  -- "1" during initialization
                     "01011011" when progress0 = "01" else  -- "2" when writing to memory
                     "01001111" when progress0 = "10" else  -- "3" when reading from memory
                     "01111001" when err0 = YES       else  -- "E" if memory test failed
                     "00111111";                            -- "O" if memory test passed

  ------------------------------------------------------------------------
  -- Indicate the phase of memory tester 1 on the segments of the 
  -- seven-segment LED.  The phases of the memory test are
  -- indicated as shown below (|=LED OFF; *=LED ON):
  -- 
  --       ----*           *****            *****           ******           ******
  --      |    *          |    *           |    *           *    *           *    |
  --       ----*          ******            *****           *----*           ******
  --      |    *          *    |           |    *           *    *           *    |
  --       ----*          *****             *****           ******           ******
  --  Initialization  Writing pattern  Reading pattern    Memory test  or  Memory test
  --      Phase          to memory       from memory        passed           failed
  ------------------------------------------------------------------------
  led(15 downto 8) <= "00000110" when progress1 = "00" else  -- "1" during initialization
                      "01011011" when progress1 = "01" else  -- "2" when writing to memory
                      "01001111" when progress1 = "10" else  -- "3" when reading from memory
                      "01111001" when err1 = YES       else  -- "E" if memory test failed
                      "00111111";                            -- "O" if memory test passed

  ------------------------------------------------------------------------
  -- Generate some slow signals from the master clock.
  ------------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
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
  heartBeat <= divCnt(16)                 when (progress0/="11") or (progress1/="11") else  -- test in progress
               divCnt(16) or divCnt(15)   when (err0 = NO) and (err1 = NO)            else  -- test passed
               divCnt(16) and divCnt(15);                                                   -- test failed                              

end architecture;
