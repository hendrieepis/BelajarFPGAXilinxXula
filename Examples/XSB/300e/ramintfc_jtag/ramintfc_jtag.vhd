----------------------------------------------------------------------------------
-- Company: XESS Corp.
-- Engineer: Dave Vanden Bout
-- 
-- Create Date: 12:36:00 06/10/2006 
-- Copyright: 2006, XESS Corp
-- Design Name: ramintfc_jtag
-- Module Name: ramintfc_jtag - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: WebPACK 8.1.03i
-- Description: RAM upload/download via JTAG.
--   See ramintfc_jtag_core.vhd for details of operation.
--
-- Dependencies: 
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.common.all;
use work.userinstr_jtag_pckg.all;

library UNISIM;
use UNISIM.VComponents.all;


entity ramintfc_jtag is
  generic(
    DATA_WIDTH  :       natural := 16;       -- width of data
    HADDR_WIDTH :       natural := 32;       -- host-side address width
    RADDR_WIDTH :       natural := 20        -- RAM address bus width
    );
  port(
    fpga_init_n : out   std_logic;      -- CPLD interface chip-select
    clkin       : in    std_logic;      -- main clock input
    pb_d        : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- RAM data
    pb_a        : inout std_logic_vector(RADDR_WIDTH-1 downto 0); -- RAM address
    pb_oe_n     : out   std_logic;      -- PBus output-enable
    pb_we_n     : out   std_logic;      -- PBus write-enable
    pb_ub_n     : out   std_logic;      -- PBus upper-byte enable
    pb_lb_n     : out   std_logic;      -- PBus lower-byte enable
    ram_ce_n    : out   std_logic       -- RAM chip-enable
    );
end entity;


architecture arch of ramintfc_jtag is
  
  -- signals to/from the JTAG BSCAN module
  signal bscan_drck   : std_logic; -- JTAG clock from BSCAN module
  signal bscan_reset  : std_logic; -- true when BSCAN module is reset
  signal bscan_sel    : std_logic; -- true when BSCAN module selected
  signal bscan_shift  : std_logic; -- true when TDI & TDO are shifting data
  signal bscan_update : std_logic; -- BSCAN TAP is in update-dr state
  signal bscan_tdi    : std_logic; -- data received on TDI pin
  signal bscan_tdo    : std_logic; -- scan data sent to TDO pin
  
  -- signals to/from the RAM controller
  signal rrd          : std_logic; -- RAM read
  signal rwr          : std_logic; -- RAM write
  signal addr         : std_logic_vector(HADDR_WIDTH-1 downto 0); -- address bus to RAM
  signal dout         : std_logic_vector(DATA_WIDTH-1  downto 0); -- databus to RAM

  -- signals for handling RAM R/W access times  
  constant RW_PULSE_DURATION : natural := 2;
  signal done         : std_logic; -- true when RAM read/write is done
  signal done_cnt     : natural range 0 to RW_PULSE_DURATION := 0; --R/W pulse duration counter
  signal rwr_sreg     : std_logic_vector(1 downto 0) := "00";
  signal rrd_sreg     : std_logic_vector(1 downto 0) := "00";

begin

  fpga_init_n <= '1';        -- disable CPLD interface

  -- boundary-scan interface to FPGA JTAG port
  u_bscan : BSCAN_SPARTAN2
    port map(
      DRCK1   => bscan_drck,  -- JTAG clock
      RESET   => bscan_reset, -- true when JTAG TAP FSM is reset
      SEL1    => bscan_sel,   -- USER1 instruction enables execution of the RAM interface
      SHIFT   => bscan_shift, -- true when JTAG TAP FSM is in the SHIFT-DR state
      TDI     => bscan_tdi,   -- data bits from the PC arrive through here
      UPDATE  => bscan_update,
      TDO1    => bscan_tdo,   -- LSbit of the tdo register outputs onto TDO pin and to the PC
      TDO2    => '0'          -- not using this input, so just hold it low
      );

  -- JTAG interface
  u1: userinstr_jtag
    generic map(
      FPGA_TYPE        => SPARTAN2E,
      ENABLE_RAM_INTFC => true,
      DATA_WIDTH       => DATA_WIDTH,
      ADDR_WIDTH       => HADDR_WIDTH
      )
    port map(
      clk           => clkin,
      bscan_drck    => bscan_drck,
      bscan_reset   => bscan_reset,
      bscan_sel     => bscan_sel,
      bscan_shift   => bscan_shift,
      bscan_update  => bscan_update,
      bscan_tdi     => bscan_tdi,
      bscan_tdo     => bscan_tdo,
      rd            => rrd,
      wr            => rwr,
      begun         => done,
      done          => done,
      addr          => addr,
      din           => pb_d,
      dout          => dout,
      s             => open,
      test_progress => "11",
      test_failed   => NO
      );

  -- interface to the RAM
  pb_a     <= addr(pb_a'range);
  pb_d     <= (others=>HIZ) when rrd=YES else dout;
  pb_oe_n  <= LO when rrd=YES else HI;
  pb_we_n  <= LO when rwr=YES else HI;
  pb_ub_n  <= LO;
  pb_lb_n  <= LO;
  ram_ce_n <= LO;
  
  -- account for read/write access time when generating done signal
  process(clkin)
  begin
    if rising_edge(clkin) then
      rrd_sreg <= rrd & rrd_sreg(rrd_sreg'high downto 1);
      rwr_sreg <= rwr & rwr_sreg(rwr_sreg'high downto 1);
      if rwr_sreg = "10" or rrd_sreg = "10" then
        done_cnt <= RW_PULSE_DURATION;
      else
        if done_cnt /= 0 then
          done_cnt <= done_cnt - 1;
        end if;
      end if;
      if done_cnt = 1 then
        done <= YES;
      else
        done <= NO;
      end if;
    end if;
  end process;

end architecture;
