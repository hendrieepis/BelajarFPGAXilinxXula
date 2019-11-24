----------------------------------------------------------------------------------
-- Description: SDRAM & flash upload/download via JTAG.
-- Creator: Dave Vanden Bout / XESS Corp.
-- Date: 06/07/2010 
--
-- Revision:
--    1.0.0
--
-- Additional Comments:
--    1.0.0:
--        Initial release.
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
--------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.common.all;
use work.fjmem_config_pack.all;         -- SDRAM & flash parameters
use work.fjmem_pack.all;
use work.fjmem.all;
use work.xsasdram.all;

library UNISIM;
use UNISIM.VComponents.all;


entity fjmem_intfc is
  port(
    clkin         : in    std_logic;    -- main clock input
    ------------------- SDRAM interface --------------------
    sdram_clkfb   : in    std_logic;    -- feedback clock mirrors SDRAM clock
    sdram_clkout  : out   std_logic;    -- clock to SDRAM
    sdram_cke     : out   std_logic;    -- SDRAM clock-enable
    sdram_cs_n    : out   std_logic;    -- SDRAM chip-select
    sdram_ras_n   : out   std_logic;    -- SDRAM RAS
    sdram_cas_n   : out   std_logic;    -- SDRAM CAS
    sdram_we_n    : out   std_logic;    -- SDRAM write-enable
    sdram_ba      : out   std_logic_vector(1 downto 0);   -- SDRAM bank-address
    sdram_addr    : out   std_logic_vector(12 downto 0);  -- SDRAM address bus
    sdram_data    : inout std_logic_vector(sdram_data_width_c-1 downto 0);  -- data bus to/from SDRAM
    sdram_dqmh    : out   std_logic;    -- SDRAM DQMH
    sdram_dqml    : out   std_logic;    -- SDRAM DQML
    ------------------- flash RAM interface --------------------
    flash_byte_n  : out   std_logic;  -- low level puts flash in byte-wide mode
    flash_reset_n : out   std_logic;    -- reset for Flash
    flash_ce_n    : out   std_logic;    -- chip-enable for Flash
    flash_oe_n    : out   std_logic;    -- output-enable for Flash
    flash_we_n    : out   std_logic;    -- write-enable for Flash
    flash_addr    : out   std_logic_vector(flash_addr_width_c-1 downto 0);  -- Flash address bus
    flash_data    : inout std_logic_vector(flash_data_width_c-1 downto 0)  -- Flash data bus
    );
end entity;


architecture arch of fjmem_intfc is

  -- clock and reset signals
  signal clk1x  : std_logic;  -- main DLL clock generated from clkin by DLL in SDRAM controller
  signal bufclk : std_logic;            -- buffered version of clkin
  signal reset  : std_logic;

  -- signals to/from the JTAG BSCAN module
  signal bscan_drck   : std_logic;      -- JTAG clock from BSCAN module
  signal bscan_reset  : std_logic;      -- true when BSCAN module is reset
  signal bscan_sel    : std_logic;      -- true when BSCAN module selected
  signal bscan_shift  : std_logic;  -- true when TDI & TDO are shifting data
  signal bscan_update : std_logic;      -- BSCAN TAP is in update-dr state
  signal bscan_tdi    : std_logic;      -- data received on TDI pin
  signal bscan_tdo    : std_logic;      -- scan data sent to TDO pin

  -- Signals to/from the fjmem JTAG interface
  signal fjmem_strobe : std_logic;
  signal fjmem_rd     : std_logic;
  signal fjmem_wr     : std_logic;
  signal fjmem_ack    : std_logic;
  signal fjmem_cs     : std_logic_vector(num_blocks_c-1 downto 0);
  signal fjmem_addr   : std_logic_vector(max_addr_width_c-1 downto 0);
  signal fjmem_din    : std_logic_vector(max_data_width_c-1 downto 0);
  signal fjmem_dout   : std_logic_vector(fjmem_din'range);

  -- signals to/from the flash memory interface
  signal stretched_strobe : std_logic;

  -- signals to/from the SDRAM controller
  signal sdram_hrd          : std_logic;  -- host read enable
  signal sdram_hwr          : std_logic;  -- host write enable
  signal sdram_earlyOpBegun : std_logic;  -- true when current read/write has begun
  signal sdram_done         : std_logic;  -- true when current read/write is done
  signal sdram_haddr        : std_logic_vector(sdram_addr_width_c-1 downto 0);  -- host address
  signal sdram_hdin         : std_logic_vector(sdram_data_width_c-1 downto 0);  -- data input from host
  signal sdram_hdout        : std_logic_vector(sdram_hdin'range);  -- host data output to host
  
begin

  -- generate a reset signal  
  process(bufclk)  -- use buffered clock because DLL might not have locked
    constant reset_dly_c : natural               := 10;
    variable rst_cntr    : natural range 0 to 15 := 0;
  begin
    if rising_edge(bufclk) then
      reset <= NO;
      if rst_cntr < reset_dly_c then
        reset    <= YES;
        rst_cntr := rst_cntr + 1;
      end if;
    end if;
  end process;

  -- boundary-scan interface to FPGA JTAG port
  u_bscan : BSCAN_SPARTAN3
    port map(
      DRCK1  => bscan_drck,             -- JTAG clock
      RESET  => bscan_reset,            -- true when JTAG TAP FSM is reset
      SEL1   => bscan_sel,  -- USER1 instruction enables execution of the RAM interface
      SHIFT  => bscan_shift,  -- true when JTAG TAP FSM is in the SHIFT-DR state
      TDI    => bscan_tdi,  -- data bits from the PC arrive through here
      UPDATE => bscan_update,
      TDO1   => bscan_tdo,  -- LSbit of the tdo register outputs onto TDO pin and to the PC
      TDO2   => '0'         -- not using this input, so just hold it low
      );

  -- JTAG/memory-bus interface
  u1 : fjmem_core
    port map(
      -- JTAG Interface ---------------------------------------------------------
      clkdr_i  => bscan_drck,
      trst_i   => '0',
      shift_i  => bscan_shift,
      update_i => bscan_update,
      tdi_i    => bscan_tdi,
      tdo_o    => bscan_tdo,
      -- Memory Bus Interface -------------------------------------------------------
      clk_i    => clk1x,
      res_i    => reset,
      strobe_o => fjmem_strobe,
      read_o   => fjmem_rd,
      write_o  => fjmem_wr,
      ack_i    => fjmem_ack,
      cs_o     => fjmem_cs,
      addr_o   => fjmem_addr,
      din_i    => fjmem_din,
      dout_o   => fjmem_dout
      );

  -- Stretch the fjmem_strobe for use by the flash memory.
  -- (The fjmem_strobe signal only lasts for a single clock cycle.)
  process(clk1x)
    constant pulse_len_c  : natural               := 10;
    variable strobe_timer : natural range 0 to 15 := 0;
  begin
    if rising_edge(clk1x) then
      stretched_strobe <= '0';
      if fjmem_strobe = '1' then
        strobe_timer := pulse_len_c;
        stretched_strobe <= '1';
      end if;
      if strobe_timer /= 0 then
        strobe_timer     := strobe_timer - 1;
        stretched_strobe <= '1';
      end if;
    end if;
  end process;

  -- Generate the flash RAM control signals and mux the ACK signal and data buses from the memories to the fjmem_core.
  process (fjmem_cs, fjmem_wr, fjmem_rd, fjmem_addr, fjmem_dout, sdram_done, sdram_hdout, flash_data, stretched_strobe)
  begin
    -- Setup default values for these signals.
    fjmem_din   <= (others => '0');
    fjmem_ack   <= '0';
    sdram_haddr <= (others => '0');
    sdram_hdin  <= (others => '0');
    flash_ce_n  <= '1';
    flash_we_n  <= '1';
    flash_oe_n  <= '1';
    flash_addr  <= (others => '0');
    flash_data  <= (others => '0');
    case (fjmem_cs) is
      when "01" =>                      -- SDRAM
        sdram_haddr                  <= fjmem_addr(sdram_haddr'range);
        sdram_hdin                   <= fjmem_dout(sdram_hdin'range);
        fjmem_ack                    <= sdram_done;
        fjmem_din(sdram_hdout'range) <= sdram_hdout;
      when "10" =>                      -- flash
        flash_ce_n                  <= '0';
        flash_addr                  <= fjmem_addr(flash_addr'range);
        fjmem_ack                   <= '1';
        fjmem_din(flash_data'range) <= flash_data;
        if fjmem_wr = '1' then
          flash_we_n <= not stretched_strobe;
          flash_data <= fjmem_dout(flash_data'range);
        elsif fjmem_rd = '1' then
          flash_oe_n <= '0';
          flash_data <= (others => 'Z');
        end if;
      when others =>
        null;
    end case;
  end process;

  flash_byte_n  <= '0';        -- Place flash memory into byte-wide mode.
  flash_reset_n <= not reset;           -- Reset the flash upon startup.

  -- Generate the SDRAM R/W control signals.
  process(clk1x)
  begin
    if rising_edge(clk1x) then
      if fjmem_cs(0) = '1' then
        if fjmem_strobe = '1' then
          -- Read/write the SDRAM once it is selected and the strobe occurs.
          -- (The strobe should only last for 1 clock cycle.)
          sdram_hwr <= fjmem_wr;
          sdram_hrd <= fjmem_rd;
        elsif sdram_earlyOpBegun = '1' then
          -- Remove the latched R/W signals once the R/W operation begins.
          sdram_hwr <= '0';
          sdram_hrd <= '0';
        end if;
      else
        -- Clear the R/W signals whenever the SDRAM is not selected.
        sdram_hwr <= '0';
        sdram_hrd <= '0';
      end if;
    end if;
  end process;

  -- SDRAM controller
  u2 : xsaSDRAMCntl
    generic map(
      FREQ        => 100_000,
      PIPE_EN     => false,
      DATA_WIDTH  => sdram_data_width_c,
      NROWS       => 8192,
      NCOLS       => 512,
      HADDR_WIDTH => sdram_addr_width_c,
      SADDR_WIDTH => 13
      )
    port map(
      clk          => clkin,
      bufclk       => bufclk,
      clk1x        => clk1x,
      clk2x        => open,
      lock         => open,
      rst          => reset,
      rd           => sdram_hrd,
      wr           => sdram_hwr,
      rdPending    => open,
      opBegun      => open,
      earlyOpBegun => sdram_earlyOpBegun,
      rdDone       => open,
      done         => sdram_done,
      hAddr        => sdram_haddr,
      hDIn         => sdram_hdin,
      hDOut        => sdram_hdout,
      status       => open,
      sclkfb       => sdram_clkfb,
      sclk         => sdram_clkout,
      cke          => sdram_cke,
      cs_n         => sdram_cs_n,
      ras_n        => sdram_ras_n,
      cas_n        => sdram_cas_n,
      we_n         => sdram_we_n,
      ba           => sdram_ba,
      sAddr        => sdram_addr,
      sData        => sdram_data,
      dqmh         => sdram_dqmh,
      dqml         => sdram_dqml
      );

end architecture;
