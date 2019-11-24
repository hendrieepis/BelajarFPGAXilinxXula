--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 01/30/2006
-- Copyright     : 2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    This is a simple design example that writes data to sectors 
--    on an IDE hard disk and then reads it back to verify it.
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
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.mem.all;
use WORK.ata.all;
use WORK.debounce_pckg.all;


-- disk tester

entity ide is
  generic(
    BEG_ADDR      :       natural := 16#000000#;  -- beginning address
    END_ADDR      :       natural := 16#FFFFFF#;  -- ending address
    BEG_TEST      :       natural := 16#000000#;  -- beginning test range address
    END_TEST      :       natural := 16#01FFFF#  -- ending test range address
    );
  port(
    clk           : in    std_logic;    -- main clock input from external clock source
    rerun_test_n  : in    std_logic;    -- re-run the test when low
    dior_n        : out   std_logic;    -- disk read enable
    diow_n        : out   std_logic;    -- disk write enable
    dcs0_n        : out   std_logic;    -- disk command register block select
    dcs1_n        : out   std_logic;    -- disk control register block select
    da            : out   std_logic_vector(2 downto 0);  -- disk register address bus
    dd            : inout std_logic_vector(15 downto 0);  -- disk data bus
    dirq          : in    std_logic;    -- disk interrupt request
    dmack_n       : out   std_logic;    -- DMA acknowledge
    ethernet_cs_n : out   std_logic;    -- ethernet chip-enable
    flash_ce_n    : out   std_logic;    -- flash chip-enable
    status        : out   std_logic_vector(6 downto 0)  -- LED status indicator
    );
end ide;

architecture arch of ide is
  constant ADDR_WIDTH             : natural := log2(END_ADDR-BEG_ADDR+1);
  signal   rst                    : std_logic;  -- reset signal
  signal   rstCnt                 : unsigned(1 downto 0);  -- reset timer
  signal   memtest_reset          : std_logic;  -- re-run test
  signal   debounced_rerun_test_n : std_logic;
  signal   rd                     : std_logic;  -- host-side read control signal
  signal   wr                     : std_logic;  -- host-side write control signal
  signal   abort                  : std_logic;  -- abort current disk command
  signal   hAddr                  : std_logic_vector(ADDR_WIDTH-1 downto 0);  -- host address bus
  signal   hDIn                   : std_logic_vector(15 downto 0);  -- host-side data to disk
  signal   hDOut                  : std_logic_vector(15 downto 0);  -- host-side data from disk
  signal   done                   : std_logic;  -- disk operation complete indicator
  signal   dData                  : std_logic_vector(15 downto 0);  -- local disk data bus
  signal   outEnable              : std_logic;  -- enable local disk data bus to disk data bus
  signal   progress               : std_logic_vector(1 downto 0);  -- test progress indicator
  signal   err                    : std_logic;  -- test error flag
  signal   errbits                : std_logic_vector(dd'range);  -- shows data bits with errors
  signal   sector                 : std_logic_vector(7 downto 0);  -- current disk sector
  signal   cylinder               : std_logic_vector(15 downto 0);  -- current disk cylinder
  signal   head                   : std_logic_vector(3 downto 0);  -- current disk head

begin

  -- Disable the Ethernet controller so it can't interfere with the peripheral bus
  -- that is also used by the disk.
  ethernet_cs_n <= '1';

  -- Disable the flash chip
  flash_ce_n <= '1';

  -- debounce the signal that re-runs the disk write/read test
  u2 : debounce
    generic map(DEBOUNCE_CNT => 20_000_000)
    port map(clk             => clk, sig_in => rerun_test_n, sig_out => debounced_rerun_test_n);

  -- assert the reset for a few clock cycles after startup
  process(clk)
  begin
    if rising_edge(clk) then
      if rstCnt /= TO_UNSIGNED(1, rstCnt'length) then
        rst    <= '1';
        rstCnt <= rstCnt + 1;
      else
        rst    <= '0';                  -- remove reset
      end if;
    end if;
  end process;

  -- generic memory tester module
  memtest_reset <= rst or not debounced_rerun_test_n;
  u0 : memTest
    generic map(
      DATA_WIDTH => hDIn'length,
      ADDR_WIDTH => hAddr'length,
      BEG_TEST   => BEG_TEST,
      END_TEST   => END_TEST,
      STEP_SIZE  => 1
      )
    port map(
      clk        => clk,                -- master clock
      rst        => memtest_reset,      -- reset
      done       => done,               -- disk operation complete
      dIn        => hDOut,              -- host-side data from disk goes to memory tester
      rd         => rd,                 -- host-side disk read control from memory tester
      wr         => wr,                 -- host-side disk write control from memory tester
      abort      => abort,              -- memory tester requests abort of the current disk command
      addr       => hAddr,              -- host-side address from memory tester
      dOut       => hDIn,               -- host-side data to disk comes from memory tester
      progress   => progress,           -- current phase of memory test
      errbits    => errbits,            -- shows data bits with errors
      err        => err                 -- memory test error flag
      );

  -- Ignore the lower 8-bits of the host address from the memory tester
  -- because the 256 words in a sector are addressed sequentially.
  -- But use the next nine address bits to select the cylinder where
  -- the sector is located.
--  cylinder <= "000000000" & hAddr(23 downto 17);
--  head     <= hAddr(16 downto 13);
--  sector   <= "00" & hAddr(12 downto 8) & "0";
  cylinder(8 downto 0)  <= hAddr(16 downto 8);
  cylinder(15 downto 9) <= (others => '0');  -- zero the upper bits of the cylinder address

  -- disk interface
  u1 : ataCntl
    generic map(
      FREQ           => 100_000,        -- operating frequency in KHz
      SECTORS_PER_RW => 32
      )
    port map(
      -- host side
      clk            => clk,            -- master clock
      rst            => rst,            -- reset
      rd             => rd,             -- initiate read operation
      wr             => wr,             -- initiate write operation
      abort          => abort,          -- abort the current read/write operation
      done           => done,           -- read or write operation is done
--      head           => head,
--      cylinder       => cylinder,
--      sector         => sector,
      head           => x"0",           -- fix the disk head for data access
      cylinder       => cylinder,       -- cylinder for data access from memory tester
      sector         => x"05",          -- fix the sector for data access
      hDIn           => hDIn,           -- data from host       to disk
      hDOut          => hDOut,          -- data from disk to host
      status         => status,         -- diagnostic status for the operation          

      -- disk side
      dior_n    => dior_n,              -- disk register read-enable
      diow_n    => diow_n,              -- disk register write-enable
      cs0_n     => dcs0_n,              -- disk command block register select
      cs1_n     => dcs1_n,              -- disk control block register select
      da        => da(2 downto 0),      -- register address
      ddOut     => dData,               -- data to disk
      ddOutEnbl => outEnable,           -- enable data outputs to disk
      ddIn      => dd,                  -- data from disk
      intrq     => dirq,                -- interrupt request from disk
      dmack_n   => dmack_n              -- DMA cknowledge
      );

  -- Manage the databus during the various phases of the test.   
  dd <=
    -- tristate the disk databus when data is read from the disk during memory test read phase
    "ZZZZZZZZZZZZZZZZ"                when progress /= "11" and outEnable = '0' else
    -- drive the disk databus with data from the memory tester during memory test write phase
    dData                             when progress /= "11" and outEnable = '1' else
    -- display an "E" after the memory test completes if an error was detected
    "01111001" & errbits(15 downto 8) when progress = "11" and err = YES        else
    -- display an "O" after the memory test completes if no error was found
    "0011111100000000";

end arch;
