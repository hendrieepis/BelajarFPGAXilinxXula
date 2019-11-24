--------------------------------------------------------------------
-- Company : XESS Corp.
-- Engineer : Dave Vanden Bout
-- Creation Date : 03/31/2008
-- Copyright : 2008, XESS Corp
-- Tool Versions : WebPACK 9.2.03i
--
-- Description:
-- This module tests the external SRAM chip by
-- writing a random data pattern to the SRAM and then reading it
-- back to see if the SRAM contains the correct pattern.
--
--  +--------------+    +---------------+      +-----------+
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |    memory    |    |     R/W       |      |   SRAM    |
--  |    tester    |<==>|  controller   |<====>|   chip    |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  |              |    |               |      |           |
--  +--------------+    +---------------+      +-----------+
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

package test_sram_pckg is
  component test_sram
    generic(
      FREQ        : natural := 50_000;  -- frequency of operation in KHz
      DATA_WIDTH  : natural := 16;      -- SRAM data width
      RADDR_WIDTH : natural := 21;      -- SRAM address width
      -- beginning and ending addresses for the entire SRAM
      BEG_ADDR    : natural := 16#00_0000#;
      END_ADDR    : natural := 16#3F_FFFF#;
      -- beginning and ending address for the memory tester
      BEG_TEST    : natural := 16#00_0000#;
      END_TEST    : natural := 16#3F_FFFF#
      );
    port(
      button_n : in    std_logic;       -- active-low pushbutton input
      clk      : in    std_logic;  -- main clock input from external clock source
      cs_n     : out   std_logic;       -- SRAM chip-select
      oe_n     : out   std_logic;       -- SRAM output-enable
      we_n     : out   std_logic;       -- SRAM write-enable
      rAddr    : out   std_logic_vector(RADDR_WIDTH-1 downto 0);  -- SRAM address bus
      rData    : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SRAM
      progress : out   std_logic_vector(1 downto 0);  -- test status (0X=in-progress, 11=success, 10=failure)
      err      : out   std_logic   -- true if an error was found during test
      );
  end component test_sram;
end package test_sram_pckg;




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.mem.all;
use WORK.rwcntl_pckg.all;

entity test_sram is
  generic(
    FREQ        : natural := 50_000;    -- frequency of operation in KHz
    DATA_WIDTH  : natural := 16;        -- SRAM data width
    RADDR_WIDTH : natural := 21;        -- SRAM row/col address width
    -- beginning and ending addresses for the entire SRAM
    BEG_ADDR    : natural := 16#00_0000#;
    END_ADDR    : natural := 16#3F_FFFF#;
    -- beginning and ending address for the memory tester
    BEG_TEST    : natural := 16#00_0000#;
    END_TEST    : natural := 16#3F_FFFF#
    );
  port(
    button_n : in    std_logic;         -- active-low pushbutton input
    clk      : in    std_logic;  -- main clock input from external clock source
    cs_n     : out   std_logic;         -- SRAM chip-select
    oe_n     : out   std_logic;         -- SRAM output-enable
    we_n     : out   std_logic;         -- SRAM write-enable
    rAddr    : out   std_logic_vector(RADDR_WIDTH-1 downto 0);  -- SRAM address bus
    rData    : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SRAM
    progress : out   std_logic_vector(1 downto 0);  -- test status (0X=in-progress, 11=success, 10=failure)
    err      : out   std_logic   -- true if an error was found during test
    );
end entity;

architecture arch of test_sram is
  constant HADDR_WIDTH : natural := log2(END_ADDR-BEG_ADDR+1);
  signal rst_i         : std_logic;     -- internal reset signal
  signal dataIn        : std_logic_vector(DATA_WIDTH-1 downto 0);  -- input databus from SDRAM
  signal dataOut       : std_logic_vector(DATA_WIDTH-1 downto 0);  -- output databus to SDRAM
--  signal   divCnt      : std_logic_vector(22 downto 0);  -- clock divider
  signal syncButton    : std_logic_vector(1 downto 0);  -- button input sync'ed to clock domain

  signal rst_cnt : natural range 0 to 255;

  -- signals that go through the SDRAM host-side interface
  signal begun     : std_logic;         -- SDRAM operation started indicator
--  signal earlyBegun : std_logic;        -- SDRAM operation started indicator
  signal done      : std_logic;         -- SDRAM operation complete indicator
--  signal rdDone     : std_logic;        -- SDRAM operation complete indicator
  signal hAddr     : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host address bus
  signal hDIn      : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal hDOut     : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal rd        : std_logic;         -- host-side read control signal
  signal wr        : std_logic;         -- host-side write control signal
  signal rdPending : std_logic;  -- read operation pending in SDRAM pipeline

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
  process(clk)
  begin
    if rising_edge(clk) then
      if rst_i = YES then
        rst_i <= NO;
      end if;
    end if;
  end process;

  ------------------------------------------------------------------------
  -- synchronize the pushbutton to the main clock.  The LSB of syncButton
  -- is high when the pushbutton is pressed.
  ------------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
      syncButton <= not(button_n) & syncButton(syncButton'high downto 1);
    end if;
  end process;

  ------------------------------------------------------------------------
  -- Instantiate memory tester without memory pipelining.
  ------------------------------------------------------------------------
  rdPending <= NO;
  slow_memtest : memTest
    generic map(
      PIPE_EN    => false,
      DATA_WIDTH => DATA_WIDTH,
      ADDR_WIDTH => HADDR_WIDTH,
      BEG_TEST   => BEG_TEST,
      END_TEST   => END_TEST
      )
    port map(
      clk       => clk,                 -- master internal clock
      rst       => rst_i,               -- reset
      doAgain   => syncButton(0),       -- re-do the memory test
      begun     => begun,               -- SRAM controller operation started
      done      => done,                -- SRAM controller operation complete
      dIn       => hDOut,  -- host-side data from SRAM goes to memory tester
      rdPending => rdPending,  -- tell the memory tester if the SRAM has pending reads
      rd        => rd,     -- host-side SRAM read control from memory tester
      wr        => wr,     -- host-side SRAM write control from memory tester
      addr      => hAddr,               -- host-side address from memory tester
      dOut      => hDIn,   -- host-side data to SRAM from memory tester
      progress  => progress_i,          -- current phase of memory test
      err       => err_i                -- memory test error flag
      );

  ------------------------------------------------------------------------
  -- Instantiate the SRAM interface that connects to the memory tester
  -- module and interfaces to the external SRAM chip.
  ------------------------------------------------------------------------
  u1 : rwcntl
    generic map(
      FREQ       => FREQ,
      TSU        => 10,
      TRD        => 20,
      TWR        => 20,
      THO        => 10,
      DATA_WIDTH => DATA_WIDTH,
      ADDR_WIDTH => RADDR_WIDTH
      )
    port map(
      -- host side
      clk    => clk,
      rst    => rst_i,
      rd     => rd,
      wr     => wr,
      begun  => begun,
      busy   => open,
      done   => done,
      hAddr  => hAddr,
      hDIn   => hDIn,
      hDOut  => hDOut,
      status => open,
      -- RAM side
      rAddr  => rAddr,
      rData  => rData,
      we_n   => we_n,
      oe_n   => oe_n
      );

  cs_n     <= LO;
  progress <= progress_i;
  err      <= err_i;

end architecture;
