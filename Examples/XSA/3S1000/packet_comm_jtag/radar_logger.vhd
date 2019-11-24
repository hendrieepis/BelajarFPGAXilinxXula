--------------------------------------------------------------------
-- Company : XESS Corp.
-- Engineer : Dave Vanden Bout
-- Creation Date : 12/01/2007
-- Copyright : 2007, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
-- This module connects the RADAR and packet communications modules.
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
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.radar.all;
use WORK.packet_comm_jtag_pckg.all;
use WORK.xsasdram.all;

entity radar_logger is
  generic(
    FREQ        :       natural := 100_000;  -- frequency of operation in KHz
	 CLK_DIV     :       real    := 1.0;
    PIPE_EN     :       boolean := false;    -- enable fast, pipelined SDRAM operation
	 ADDR_WIDTH  :       natural := 32;	      -- address width
    DATA_WIDTH  :       natural := 16;       -- data width
    SADDR_WIDTH :       natural := 13;       -- SDRAM row/col address width
    NROWS       :       natural := 8192;     -- number of rows in the SDRAM
    NCOLS       :       natural := 512;      -- number of columns in each SDRAM row
    -- beginning and ending addresses for the entire SDRAM
    BEG_ADDR    :       natural := 16#0000_0000#;
    END_ADDR    :       natural := 16#003F_FFFF#;
    -- beginning and ending address for the memory tester
    BEG_TEST    :       natural := 16#0000_0000#;
    END_TEST    :       natural := 16#003F_FFFF#
    );
  port(
    diag        : out   std_logic_vector(7 downto 0);

    button_n    : in    std_logic;           -- active-low pushbutton input
	 ce_n        : out   std_logic;           -- flash chip-enable
    clk         : in    std_logic;           -- main clock input from external clock source
    sclkfb      : in    std_logic;           -- feedback SDRAM clock with PCB delays
    sclk        : out   std_logic;           -- clock to SDRAM
    cke         : out   std_logic;           -- SDRAM clock-enable
    cs_n        : out   std_logic;           -- SDRAM chip-select
    ras_n       : out   std_logic;           -- SDRAM RAS
    cas_n       : out   std_logic;           -- SDRAM CAS
    we_n        : out   std_logic;           -- SDRAM write-enable
    ba          : out   std_logic_vector(1 downto 0); -- SDRAM bank-address
    sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0); -- SDRAM address bus
    sData       : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
    dqmh        : out   std_logic;          -- SDRAM DQMH
    dqml        : out   std_logic;          -- SDRAM DQML
--  progress    : out   std_logic_vector(1 downto 0); -- test progress indicator
--  err         : out   std_logic;          -- true if an error was found during test
    led         : out   std_logic_vector(6 downto 0)  -- 7-segment LED
--  heartBeat   : out   std_logic           -- heartbeat status (usually sent to parallel port status pin)
    );
end entity;


architecture arch of radar_logger is

  -- reset signals
  signal rst_i              : std_logic;    -- internal reset signal
  signal rst_cnt            : natural range 0 to 255;
  attribute INIT            : string;
  attribute INIT of rst_i   : signal is "1"; -- set the reset flag upon startup
  attribute INIT of rst_cnt : signal is "0";	-- reset the counter upon startup

  -- clock signals
  signal clk_i              : std_logic;    -- internal master clock signal
  signal clkb               : std_logic;    -- buffered input (non-DLL) clock
  signal lock               : std_logic;    -- SDRAM clock DLL lock indicator

  signal syncButton         : std_logic_vector(1 downto 0);  -- button input sync'ed to clock domain

  -- signals that go through the SDRAM host-side interface
  signal data_begun         : std_logic;    -- SDRAM operation started indicator
  signal data_earlyBegun    : std_logic;    -- SDRAM operation started indicator
  signal data_done          : std_logic;    -- SDRAM operation complete indicator
  signal data_rdDone        : std_logic;    -- SDRAM operation complete indicator
  signal data_addr          : std_logic_vector(ADDR_WIDTH-1 downto 0);  -- host address bus
  signal data_din           : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal data_dout          : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal data_rd            : std_logic;    -- host-side read control signal
  signal data_wr            : std_logic;    -- host-side write control signal
  signal data_rdPending     : std_logic;    -- read operation pending in SDRAM pipeline

  -- signals that go through the control interface of the packet comm. controller
  signal ctrl_addr          : std_logic_vector(ADDR_WIDTH-1 downto 0);  -- control address bus
  signal ctrl_din           : std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to control intfc.
  signal ctrl_dout          : std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from control intfc.
  signal ctrl_rd            : std_logic;    -- control intfc. read control signal
  signal ctrl_wr            : std_logic;    -- control intfc. write control signal

  -- status signals from the memory tester
  signal progress_i         : std_logic_vector(1 downto 0);  -- test progress indicator
  signal err_i              : std_logic;                     -- test error flag

begin

  ce_n <= HI;  -- disable external flash chip

  ------------------------------------------------------------------------
  -- internal reset flag is set active by config. bitstream
  -- and then gets reset after the DLL-generated clock starts.
  ------------------------------------------------------------------------
  process(clkb)
  begin
    if rising_edge(clkb) then
      if lock = NO then
        rst_i   <= YES;  -- keep in reset until DLLs start up and lock
        rst_cnt <= 0;
      else
        if rst_cnt=100 then
          rst_i <= NO;   -- release reset once DLLs lock and reset counter reaches 0
        else
          rst_cnt <= rst_cnt + 1;
          rst_i <= YES;
        end if;
      end if;
    end if;
  end process;
  
  ------------------------------------------------------------------------
  -- synchronize the pushbutton to the main clock.  The LSB of syncButton
  -- is high when the pushbutton is pressed.
  ------------------------------------------------------------------------
  process(clkb)
  begin
    if rising_edge(clkb) then
      syncButton <= not(button_n) & syncButton(syncButton'high downto 1);
    end if;
  end process;

  ------------------------------------------------------------------------
  -- Instantiate the RADAR tester that connects to the packet comm. controller.
  ------------------------------------------------------------------------
  u1 : radarTest
    generic map(
      PIPE_EN        => PIPE_EN,
      DATA_WIDTH     => DATA_WIDTH,
      ADDR_WIDTH 	   => ADDR_WIDTH,
      BEG_TEST   	   => BEG_TEST,
      END_TEST   	   => END_TEST
      )
    port map(
      clk            => clk_i, -- use the DLL sync'ed clock to drive logic, not the main input clock
      rst            => rst_i,  
      doAgain        => syncButton(0),

      data_addr      => data_addr, 
      data_din       => data_din,  
      data_dout      => data_dout, 
      data_rd        => data_rd,   
      data_wr        => data_wr,   
      data_begun     => data_begun,
      data_rdPending => data_rdPending,
      data_done      => data_done, 

		ctrl_addr      => ctrl_addr, 
		ctrl_din       => ctrl_din,  
		ctrl_dout      => ctrl_dout, 
		ctrl_rd        => ctrl_rd,   
		ctrl_wr        => ctrl_wr,  

      progress       => progress_i,  
      err            => err_i
      );

  ------------------------------------------------------------------------
  -- Instantiate the packet comm. controller that connects to the RADAR tester
  -- module and interfaces to the JTAG pins and the external SDRAM chip.
  ------------------------------------------------------------------------
  u2 : packet_comm_jtag
    generic map(
      FREQ              => FREQ,
      CLK_DIV           => CLK_DIV,
      PIPE_EN           => PIPE_EN,
      DATA_WIDTH        => DATA_WIDTH,
      ADDR_WIDTH        => ADDR_WIDTH,
      SADDR_WIDTH       => SADDR_WIDTH,
      NROWS             => NROWS,
      NCOLS             => NCOLS
      )
    port map(
	   rst               => rst_i,
      clkin             => clk,
		clkb              => clkb,
		clkout            => clk_i, -- this output clock is sync'ed to the main input clock 
		lock              => lock,

      data_addr         => data_addr,
      data_din          => data_dout,
      data_dout         => data_din,
      data_rd           => data_rd,
      data_wr           => data_wr,
      data_begun        => data_begun,
      data_earlyOpBegun => open,
      data_rdPending    => data_rdPending,
      data_done         => data_done,
      data_rdDone       => data_rdDone,

		ctrl_addr         => ctrl_addr,     
		ctrl_din          => ctrl_dout,     
		ctrl_dout         => ctrl_din,     
		ctrl_rd           => ctrl_rd,     
		ctrl_wr           => ctrl_wr,     

      sdram_clkfb       => sclkfb,    
      sdram_clkout      => sclk,   
      sdram_cke         => cke,     
      sdram_cs_n        => cs_n,     
      sdram_ras_n       => ras_n,    
      sdram_cas_n       => cas_n,   
      sdram_we_n        => we_n,    
      sdram_ba          => ba,      
      sdram_addr        => sAddr,     
      sdram_data        => sData,    
      sdram_dqmh        => dqmh,    
      sdram_dqml        => dqml    
      );

  ------------------------------------------------------------------------
  -- Indicate the phase of the memory tester on the segments of the 
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
  led <= "0010010" when progress_i = "00" else  -- "1" during initialization
         "1011101" when progress_i = "01" else  -- "2" when writing to memory
         "1011011" when progress_i = "10" else  -- "3" when reading from memory
         "1101101" when err_i = YES       else  -- "E" if memory test failed
         "1110111";                             -- "O" if memory test passed

end architecture;
