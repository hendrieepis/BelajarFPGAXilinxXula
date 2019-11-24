--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 2/9/2006
-- Copyright     : 2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    Concise implementation of FIFOs as described in XAPP131.
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



library ieee;
use ieee.std_logic_1164.all;

package fifo_pckg is

  -- 255 x 16 FIFO with common read and write clock.
  component fifo_255x16_cc
    port (
      clk      : in  std_logic;                      -- master clock
      rst      : in  std_logic;                      -- reset
      rd       : in  std_logic;                      -- read fifo control
      wr       : in  std_logic;                      -- write fifo control
      data_in  : in  std_logic_vector(15 downto 0);  -- input data bus
      data_out : out std_logic_vector(15 downto 0);  -- output data bus
      full     : out std_logic;                      -- fifo-full status
      empty    : out std_logic;                      -- fifo-empty status
      level    : out std_logic_vector(7 downto 0)    -- fifo level
      );
  end component fifo_255x16_cc;

  -- 255 x 16 FIFO with independent read and write clocks.
  component fifo_255x16_ic
    port (
      rd_clk   : in  std_logic;                      -- clock for reading from the FIFO
      wr_clk   : in  std_logic;                      -- clock for writing to the FIFO
      rst      : in  std_logic;                      -- reset
      rd       : in  std_logic;                      -- read fifo control
      wr       : in  std_logic;                      -- write fifo control
      data_in  : in  std_logic_vector(15 downto 0);  -- input data bus
      data_out : out std_logic_vector(15 downto 0);  -- output data bus
      full     : out std_logic;                      -- fifo-full status
      empty    : out std_logic;                      -- fifo-empty status
      level    : out std_logic_vector(7 downto 0)    -- fifo level
      );
  end component fifo_255x16_ic;

end package fifo_pckg;



library ieee, unisim;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use unisim.vcomponents.all;
use work.common.all;

-- 255 x 16 FIFO with common read and write clock.
entity fifo_255x16_cc is
  port (
    clk      : in  std_logic;                      -- master clock
    rst      : in  std_logic;                      -- reset
    rd       : in  std_logic;                      -- read fifo control
    wr       : in  std_logic;                      -- write fifo control
    data_in  : in  std_logic_vector(15 downto 0);  -- input data bus
    data_out : out std_logic_vector(15 downto 0);  -- output data bus
    full     : out std_logic;                      -- fifo-full status
    empty    : out std_logic;                      -- fifo-empty status
    level    : out std_logic_vector(7 downto 0)    -- fifo level
    );
end entity fifo_255x16_cc;

architecture arch of fifo_255x16_cc is
  signal full_i   : std_logic;
  signal empty_i  : std_logic;
  signal rd_addr  : std_logic_vector(7 downto 0) := "00000000";
  signal wr_addr  : std_logic_vector(7 downto 0) := "00000000";
  signal level_i  : std_logic_vector(7 downto 0) := "00000000";
  signal rd_allow : std_logic;
  signal wr_allow : std_logic;
begin

  bram1 : RAMB4_S16_S16 port map (addra => rd_addr, addrb => wr_addr,
                                  dia   => (others => '0'), dib => data_in, wea => '0', web => '1',
                                  clka  => clk, clkb => clk, rsta => '0', rstb => '0',
                                  ena   => rd_allow, enb => wr_allow, doa => data_out );

  rd_allow <= rd and not empty_i;
  wr_allow <= wr and not full_i;

  process (clk, rst)
  begin
    if rst = '1' then
      rd_addr   <= (others => '0');
      wr_addr   <= (others => '0');
      level_i   <= (others => '0');
    elsif rising_edge(clk) then
      if rd_allow = YES then
        rd_addr <= rd_addr + '1';
      end if;
      if wr_allow = YES then
        wr_addr <= wr_addr + '1';
      end if;
      if (wr_allow and not rd_allow and not full_i) = YES then
        level_i <= level_i + '1';
      elsif (rd_allow and not wr_allow and not empty_i) = YES then
        level_i <= level_i - '1';
      end if;
    end if;
  end process;

  full_i  <= YES when level_i = "11111111" else NO;
  full    <= full_i;
  empty_i <= YES when level_i = "00000000" else NO;
  empty   <= empty_i;
  level   <= level_i;

end architecture arch;



library ieee, unisim;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use unisim.vcomponents.all;
use work.common.all;

-- 255 x 16 FIFO with independent read and write clocks.
entity fifo_255x16_ic is
  port (
    rd_clk   : in  std_logic;                      -- clock for reading from the FIFO
    wr_clk   : in  std_logic;                      -- clock for writing to the FIFO
    rst      : in  std_logic;                      -- reset
    rd       : in  std_logic;                      -- read fifo control
    wr       : in  std_logic;                      -- write fifo control
    data_in  : in  std_logic_vector(15 downto 0);  -- input data bus
    data_out : out std_logic_vector(15 downto 0);  -- output data bus
    full     : out std_logic;                      -- fifo-full status
    empty    : out std_logic;                      -- fifo-empty status
    level    : out std_logic_vector(7 downto 0)    -- fifo level
    );
end entity fifo_255x16_ic;

architecture arch of fifo_255x16_ic is
  signal full_i                   : std_logic;
  signal empty_i                  : std_logic;
  signal rd_addr                  : std_logic_vector(7 downto 0) := "00000000";
  signal gray_rd_addr             : std_logic_vector(7 downto 0);
  signal prev_gray_rd_addr        : std_logic_vector(7 downto 0);
  signal prev_gray_rd_addr_wrside : std_logic_vector(7 downto 0);
  signal wr_addr                  : std_logic_vector(7 downto 0) := "00000000";
  signal gray_wr_addr             : std_logic_vector(7 downto 0);
  signal gray_wr_addr_rdside      : std_logic_vector(7 downto 0);
  signal level_i                  : std_logic_vector(7 downto 0) := "00000000";
  signal rd_allow                 : std_logic;
  signal wr_allow                 : std_logic;
begin

  bram1 : RAMB4_S16_S16 port map (addra => rd_addr, addrb => wr_addr,
                                  dia   => (others => '0'), dib => data_in, wea => '0', web => '1',
                                  clka  => rd_clk, clkb => wr_clk, rsta => '0', rstb => '0',
                                  ena   => rd_allow, enb => wr_allow, doa => data_out );

  rd_allow <= rd and not empty_i;
  wr_allow <= wr and not full_i;

  process (rd_clk, rst)
  begin
    if rst = YES then
      rd_addr             <= (others => '0');
      prev_gray_rd_addr   <= binary2gray("11111111");
      gray_rd_addr        <= binary2gray("00000000");
      gray_wr_addr_rdside <= binary2gray("00000000");
    elsif rising_edge(rd_clk) then
      gray_wr_addr_rdside <= gray_wr_addr;
      if rd_allow = YES then
        rd_addr           <= rd_addr + '1';
        prev_gray_rd_addr <= gray_rd_addr;
        gray_rd_addr      <= binary2gray(rd_addr + 1);
      end if;
    end if;
  end process;

  process (wr_clk, rst)
  begin
    if rst = YES then
      wr_addr                  <= (others => '0');
      gray_wr_addr             <= binary2gray("00000000");
      prev_gray_rd_addr_wrside <= binary2gray("11111111");
    elsif rising_edge(wr_clk) then
      prev_gray_rd_addr_wrside <= prev_gray_rd_addr;
      if wr_allow = YES then
        wr_addr                <= wr_addr + '1';
        gray_wr_addr           <= binary2gray(wr_addr + '1');
      end if;
    end if;
  end process;

  full_i  <= YES when prev_gray_rd_addr_wrside = gray_wr_addr else NO;
  full    <= full_i;
  empty_i <= YES when gray_rd_addr = gray_wr_addr_rdside      else NO;
  empty   <= empty_i;
  level_i <= wr_addr - gray2binary(gray_rd_addr);
  level   <= level_i;

end architecture arch;
