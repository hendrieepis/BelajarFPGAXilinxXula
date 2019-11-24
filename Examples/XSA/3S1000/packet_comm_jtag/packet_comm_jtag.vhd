----------------------------------------------------------------------------------
-- Company: XESS Corp.
-- Engineer: Dave Vanden Bout
-- 
-- Create Date: 08:00:00 11/12/2007 
-- Copyright: 2007, XESS Corp
-- Design Name: packet_comm_jtag
-- Module Name: packet_comm_jtag - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: WebPACK 6.3i
-- Description: Upload/Download packets to/from RAM via JTAG.
--   See userinstr_jtag.vhd for details of operation.
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
use IEEE.std_logic_1164.all;

package packet_comm_jtag_pckg is
  component packet_comm_jtag
    generic(
      FREQ              : natural := 100_000; -- frequency of operation in KHz
      CLK_DIV           : real    := 1.0;     -- divisor for FREQ (can only be 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 8.0 or 16.0)
      PIPE_EN           : boolean := false;   -- disable fast, pipelined SDRAM operation
      DATA_WIDTH        : natural := 16;      -- SDRAM/block RAM data width
      ADDR_WIDTH        : natural := 32;      -- host-side address width
      SADDR_WIDTH       : natural := 13;      -- SDRAM row/col address width
      NROWS             : natural := 8192;    -- number of rows in the SDRAM
      NCOLS             : natural := 512;     -- number of columns in each SDRAM row
      -- allocate time slots between ports 0 and 1.  Port 0 gets 15/16 of the bandwidth, port 1 gets 1/16.
      PORT_TIME_SLOTS   :       std_logic_vector(15 downto 0) := "0000000000000001"
      );
    port(
	   rst               : in    std_logic;      -- active-high reset input
      clkin             : in    std_logic;      -- main clock input
		clkb              : out   std_logic;      -- buffered version of main input clock
		clkout		      : out   std_logic;      -- generated clock sync'ed to main clock input
		lock              : out   std_logic;      -- indicates when DLLs have locked to main clock input

		-- host-side interface to SDRAM (used for transfer of large data sets)
      data_addr         : in    std_logic_vector(ADDR_WIDTH-1 downto 0);  -- host-side address bus to SDRAM
      data_din          : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
      data_dout         : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
      data_rd           : in    std_logic;      -- host-side read control signal
      data_wr           : in    std_logic;      -- host-side write control signal
      data_begun        : out   std_logic;      -- read/write operation started indicator
      data_earlyOpBegun : out   std_logic;      -- read/write operation started indicator
      data_rdPending    : out   std_logic;      -- read operation pending in SDRAM pipeline indicator
      data_done         : out   std_logic;      -- read/write operation complete indicator
      data_rdDone       : out   std_logic;      -- read operation complete indicator

		-- host-side interface to block RAM (used for transfer of control info and small data sets)
		ctrl_addr         : in    std_logic_vector(ADDR_WIDTH-1 downto 0);
		ctrl_din          : in    std_logic_vector(DATA_WIDTH-1 downto 0);
		ctrl_dout         : out   std_logic_vector(DATA_WIDTH-1 downto 0);
		ctrl_rd           : in    std_logic;
		ctrl_wr           : in    std_logic;

		-- interface to external SDRAM
      sdram_clkfb       : in    std_logic;      -- feedback clock mirrors SDRAM clock
      sdram_clkout      : out   std_logic;      -- clock to SDRAM
      sdram_cke         : out   std_logic;      -- SDRAM clock-enable
      sdram_cs_n        : out   std_logic;      -- SDRAM chip-select
      sdram_ras_n       : out   std_logic;      -- SDRAM RAS
      sdram_cas_n       : out   std_logic;      -- SDRAM CAS
      sdram_we_n        : out   std_logic;      -- SDRAM write-enable
      sdram_ba          : out   std_logic_vector( 1 downto 0);  -- SDRAM bank-address
      sdram_addr        : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
      sdram_data        : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
      sdram_dqmh        : out   std_logic;      -- SDRAM DQMH
      sdram_dqml        : out   std_logic       -- SDRAM DQML
      );
  end component packet_comm_jtag;
end package packet_comm_jtag_pckg;




library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.common.all;
use work.userinstr_jtag_pckg.all;
use work.xsasdram.all;
use work.sdram.all;

library UNISIM;
use UNISIM.VComponents.all;


entity packet_comm_jtag is
    generic(
      FREQ              : natural := 100_000; -- frequency of operation in KHz
      CLK_DIV           : real    := 1.0;     -- divisor for FREQ (can only be 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 8.0 or 16.0)
      PIPE_EN           : boolean := false;   -- disable fast, pipelined SDRAM operation
      DATA_WIDTH        : natural := 16;      -- SDRAM/block RAM data width
      ADDR_WIDTH        : natural := 32;      -- host-side address width
      SADDR_WIDTH       : natural := 13;      -- SDRAM row/col address width
      NROWS             : natural := 8192;    -- number of rows in the SDRAM
      NCOLS             : natural := 512;     -- number of columns in each SDRAM row
      -- allocate time slots between ports 0 and 1.  Port 0 gets 15/16 of the bandwidth, port 1 gets 1/16.
      PORT_TIME_SLOTS   :       std_logic_vector(15 downto 0) := "0000000000000001"
      );
    port(
	   rst               : in    std_logic;      -- active-high reset input
      clkin             : in    std_logic;      -- main clock input
		clkb              : out   std_logic;      -- buffered version of main input clock
		clkout		      : out   std_logic;      -- generated clock sync'ed to main clock input
		lock              : out   std_logic;      -- indicates when DLLs have locked to main clock input

		-- host-side interface to SDRAM (used for transfer of large data sets)
      data_addr         : in    std_logic_vector(ADDR_WIDTH-1 downto 0);  -- host-side address bus to SDRAM
      data_din          : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
      data_dout         : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
      data_rd           : in    std_logic;      -- host-side read control signal
      data_wr           : in    std_logic;      -- host-side write control signal
      data_begun        : out   std_logic;      -- read/write operation started indicator
      data_earlyOpBegun : out   std_logic;      -- read/write operation started indicator
      data_rdPending    : out   std_logic;      -- read operation pending in SDRAM pipeline indicator
      data_done         : out   std_logic;      -- read/write operation complete indicator
      data_rdDone       : out   std_logic;      -- read operation complete indicator

		-- host-side interface to block RAM (used for transfer of control info and small data sets)
		ctrl_addr         : in    std_logic_vector(ADDR_WIDTH-1 downto 0);
		ctrl_din          : in    std_logic_vector(DATA_WIDTH-1 downto 0);
		ctrl_dout         : out   std_logic_vector(DATA_WIDTH-1 downto 0);
		ctrl_rd           : in    std_logic;
		ctrl_wr           : in    std_logic;

		-- interface to external SDRAM
      sdram_clkfb       : in    std_logic;      -- feedback clock mirrors SDRAM clock
      sdram_clkout      : out   std_logic;      -- clock to SDRAM
      sdram_cke         : out   std_logic;      -- SDRAM clock-enable
      sdram_cs_n        : out   std_logic;      -- SDRAM chip-select
      sdram_ras_n       : out   std_logic;      -- SDRAM RAS
      sdram_cas_n       : out   std_logic;      -- SDRAM CAS
      sdram_we_n        : out   std_logic;      -- SDRAM write-enable
      sdram_ba          : out   std_logic_vector( 1 downto 0);  -- SDRAM bank-address
      sdram_addr        : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
      sdram_data        : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
      sdram_dqmh        : out   std_logic;      -- SDRAM DQMH
      sdram_dqml        : out   std_logic       -- SDRAM DQML
      );
end entity;


architecture arch of packet_comm_jtag is

  signal ctrl_en           : std_logic; -- active when host-side interface asserts control port read or write
  
  -- signals to/from the JTAG BSCAN module
  signal bscan_drck        : std_logic; -- JTAG clock from BSCAN module
  signal bscan_reset       : std_logic; -- true when BSCAN module is reset
  signal bscan_sel         : std_logic; -- true when BSCAN module selected
  signal bscan_shift       : std_logic; -- true when TDI & TDO are shifting data
  signal bscan_update      : std_logic; -- BSCAN TAP is in update-dr state
  signal bscan_tdi         : std_logic; -- data received on TDI pin
  signal bscan_tdo         : std_logic; -- scan data sent to TDO pin
  signal jtag_rd           : std_logic; -- active when JTAG interface is accepting data
  signal jtag_wr           : std_logic; -- active when data from JTAG interface is available
  signal jtag_begun        : std_logic; -- read/write operation started indicator
  signal jtag_earlyOpBegun : std_logic; -- read/write operation started indicator
  signal jtag_rdPending    : std_logic; -- read operation pending in SDRAM pipeline indicator
  signal jtag_done         : std_logic; -- read/write operation complete indicator
  signal jtag_rdDone       : std_logic; -- read operation complete indicator
  signal jtag_addr         : std_logic_vector(ADDR_WIDTH-1 downto 0); -- host-side address bus
  signal jtag_dout         : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM

  -- signals between the JTAG interface, block RAM and SDRAM
  signal jtag_sdram_en     : std_logic; -- active when address from JTAG is in SDRAM address range
  signal jtag_blkram_en    : std_logic; -- active when address from JTAG is in block RAM address range
  signal jtag_sdram_rd     : std_logic; -- active when JTAG is reading in SDRAM address range
  signal jtag_sdram_wr     : std_logic; -- active when JTAG is writing in SDRAM address range
  signal jtag_din          : std_logic_vector(DATA_WIDTH-1 downto 0); -- data from SDRAM/block RAM to JTAG
  signal jtag_sdram_dout   : std_logic_vector(DATA_WIDTH-1 downto 0); -- data from SDRAM to JTAG
  signal jtag_sdram_begun  : std_logic; -- active when SDRAM R/W operation has been initiated
  signal jtag_sdram_done   : std_logic; -- active when SDRAM R/W operation is done
  signal jtag_blkram_dout  : std_logic_vector(DATA_WIDTH-1 downto 0); -- data from block RAM to JTAG
  signal jtag_blkram_begun : std_logic; -- active when block RAM R/W operation has been initiated
  signal jtag_blkram_done  : std_logic; -- active when block RAM R/W operation is done
  
  -- signals to/from the SDRAM controller
  signal sdram_reset       : std_logic; -- reset to SDRAM controller
  signal clk1x             : std_logic; -- DLL sync'ed version of main clock
  signal bufclk            : std_logic; -- buffered version of main clock
  signal begun             : std_logic; -- read/write operation started indicator
  signal earlyOpBegun      : std_logic; -- read/write operation started indicator
  signal rdPending         : std_logic; -- read operation pending in SDRAM pipeline indicator
  signal done              : std_logic; -- read/write operation complete indicator
  signal rdDone            : std_logic; -- read operation complete indicator
  signal hAddr             : std_logic_vector(ADDR_WIDTH-1 downto 0);  -- host-side address bus
  signal hDIn              : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal hDOut             : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal rd                : std_logic; -- host-side read control signal
  signal wr                : std_logic; -- host-side write control signal
  signal status            : std_logic_vector(3 downto 0);  -- SDRAM controller status
  
begin

  ------------------------------------------------------------------------
  -- boundary-scan interface to FPGA JTAG port
  ------------------------------------------------------------------------
  u_bscan : BSCAN_SPARTAN3
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
  
  ------------------------------------------------------------------------
  -- JTAG interface
  ------------------------------------------------------------------------
  u1: userinstr_jtag
    generic map(
      FPGA_TYPE        => SPARTAN3,
      ENABLE_RAM_INTFC => true,
      DATA_WIDTH       => DATA_WIDTH,
      ADDR_WIDTH       => ADDR_WIDTH
      )
    port map(
      clk              => clk1x,
      bscan_drck       => bscan_drck,
      bscan_reset      => bscan_reset,
      bscan_sel        => bscan_sel,
      bscan_shift      => bscan_shift,
      bscan_update     => bscan_update,
      bscan_tdi        => bscan_tdi,
      bscan_tdo        => bscan_tdo,
      rd               => jtag_rd,
      wr               => jtag_wr,
      begun            => jtag_begun,
      done             => jtag_done,
      addr             => jtag_addr,
      din              => jtag_din,
      dout             => jtag_dout,
      s                => open,
      test_progress    => "11",
      test_failed      => NO
      );

  ------------------------------------------------------------------------
  -- Address decoder that sends JTAG interface memory commands to the
  -- SDRAM or the block RAM
  ------------------------------------------------------------------------

  -- SDRAM is enabled for addresses with "00" in the LSBs, otherwise access block RAM
  jtag_sdram_en     <= YES when jtag_addr(jtag_addr'high downto jtag_addr'high-1)="00" else NO;
  jtag_blkram_en    <= not jtag_sdram_en; -- enable block RAM if SDRAM is not enabled
  -- only allow read/writes to SDRAM when SDRAM is enabled
  jtag_sdram_rd     <= jtag_rd and jtag_sdram_en;
  jtag_sdram_wr     <= jtag_wr and jtag_sdram_en;
  -- return data from SDRAM or block RAM depending upon which is enabled
  jtag_din          <= jtag_sdram_dout when jtag_sdram_en=HI else jtag_blkram_dout;
  -- select the begun and done status signals depending upon which memory is enabled 
  jtag_begun        <= jtag_sdram_begun when jtag_sdram_en=HI else jtag_blkram_begun;
  jtag_done         <= jtag_sdram_done  when jtag_sdram_en=HI else jtag_blkram_done;
  -- block RAM begin and done signals are easy since the R/W operation begins and
  -- completes in a single cycle after the R/W control is activated.
  jtag_blkram_begun <= jtag_wr or jtag_rd;
  jtag_blkram_done  <= jtag_wr or jtag_rd;

  ------------------------------------------------------------------------
  -- Instantiate the SDRAM dualport module
  ------------------------------------------------------------------------
  u2 : dualport
    generic map(
      PIPE_EN         => PIPE_EN,
      PORT_TIME_SLOTS => PORT_TIME_SLOTS,
      DATA_WIDTH      => DATA_WIDTH,
      HADDR_WIDTH     => ADDR_WIDTH
      )
    port map(
      clk             => clk1x,
      -- external port connections to SDRAM
      rst0            => rst,
      rd0             => data_rd,
      wr0             => data_wr,
      rdPending0      => data_rdPending,
      opBegun0        => data_begun,
      earlyOpBegun0   => data_earlyOpBegun,
      rdDone0         => data_rdDone,
      done0           => data_done,
      hAddr0          => data_addr,
      hDIn0           => data_din,
      hDOut0          => data_dout,
      status0         => open,
      -- JTAG interface connections to SDRAM
      rst1            => rst,
      rd1             => jtag_sdram_rd,
      wr1             => jtag_sdram_wr,
      rdPending1      => jtag_rdPending,
      opBegun1        => open,
      earlyOpBegun1   => jtag_sdram_begun,
      rdDone1         => open,
      done1           => jtag_sdram_done,
      hAddr1          => jtag_addr,
      hDIn1           => jtag_dout,
      hDOut1          => jtag_sdram_dout,
      status1         => open,
      -- connections to the SDRAM controller
      rst             => sdram_reset,
      rd              => rd,
      wr              => wr,
      rdPending       => rdPending,
      opBegun         => begun,
      earlyOpBegun    => earlyOpBegun,
      rdDone          => rdDone,
      done            => done,
      hAddr           => hAddr,
      hDIn            => hDIn,
      hDOut           => hDOut,
      status          => status
      );

  ------------------------------------------------------------------------
  -- SDRAM controller
  ------------------------------------------------------------------------
  u3 : xsaSDRAMCntl
    generic map(
      FREQ         => FREQ,
      PIPE_EN      => PIPE_EN,
      DATA_WIDTH   => DATA_WIDTH,
      NROWS        => NROWS,
      NCOLS        => NCOLS,
      HADDR_WIDTH  => ADDR_WIDTH,
      SADDR_WIDTH  => SADDR_WIDTH
      )
    port map(
      clk          => clkin,
      bufclk       => bufclk,
      clk1x        => clk1x,
      clk2x        => open,
      lock         => lock,
      rst          => sdram_reset,
      rd           => rd,
      wr           => wr,
      rdPending    => rdPending,
      opBegun      => begun,
      earlyOpBegun => earlyOpBegun,
      rdDone       => rdDone,
      done         => done,
      hAddr        => hAddr,
      hDIn         => hDIn,
      hDOut        => hDOut,
      status       => status,
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

  clkout  <= clk1x;  -- output clock is the DLL sync'ed version of the main clock
  clkb    <= bufclk; -- also output the buffered, non-sync'ed version of the main clock
  ctrl_en <= ctrl_rd or ctrl_wr; -- control interface is enabled if it is read or written

  ------------------------------------------------------------------------
  -- Block RAM for passing control information between PC and FPGA
  ------------------------------------------------------------------------
  u4 : RAMB16_S18_S18
    generic map (
      INIT_A       => X"00000",      --  Value of output RAM registers on Port A at startup
      INIT_B       => X"00000",      --  Value of output RAM registers on Port B at startup
      SRVAL_A      => X"00000",      --  Port A ouput value upon SSR assertion
      SRVAL_B      => X"00000",      --  Port B ouput value upon SSR assertion
      WRITE_MODE_A => "WRITE_FIRST", --  WRITE_FIRST so writes complete before data is read
      WRITE_MODE_B => "WRITE_FIRST"
		)
    port map (
      -- external port connections to block RAM
      CLKA         => clk1x,
      SSRA         => LO,           -- don't reset this port
      DOA          => ctrl_dout,
      DOPA         => open,         -- don't use parity outputs
      ADDRA        => ctrl_addr(9 downto 0),
      DIA          => ctrl_din,
      DIPA         => "00",         -- don't use parity inputs
      ENA          => ctrl_en,
      WEA          => ctrl_wr,
      -- JTAG interface connections to block RAM
      CLKB         => clk1x,
      SSRB         => LO,           -- don't reset this port
      DOB          => jtag_blkram_dout,
      DOPB         => open,         -- don't use parity outputs
      ADDRB        => jtag_addr(9 downto 0),
      DIB          => jtag_dout,
      DIPB         => "00",         -- don't use parity inputs
      ENB          => jtag_blkram_en,
      WEB          => jtag_wr
      );

end architecture;
