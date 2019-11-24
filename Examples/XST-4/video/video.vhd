------------------------------------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 2/9/2006
-- Copyright     : 2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    This is a simple design to grab frames of video data and display them on a VGA monitor.
--    When a button is pressed, the video codec dumps a stream of pixels in ITU-R BT.656 format,
--    8-bit 4:2:2 with embedded syncs to the framegrabber module using a sampling clock of 27 MHz.
--    The framegrabber loads the pixels into a FIFO (along with some framing information).
--    A finite-state machine (FSM) offloads the pixels from the FIFO at 50 MHz and stores the 
--    pixels into SDRAM while interleaving the lines of video from the odd and even fields.
--    Another address counter is used to read stored pixels from the SDRAM at 50 MHz and load them
--    into a FIFO.  The VGA generator retrieves pixels from this FIFO and displays them on a monitor.
--   __________                                                                                                                   
--  |          |    _________      ______________                                                                                 
--  | Parallel |   |         |    |              |     __________                                                                 
--  |   Port   |   | Button  |    | Address Cntr |    |          |                                                                
--  |__________|   |_________|    |    + FSM     |--->|          |                                                                
--       |              |         |______________|    |          |                                                                
--       |              |                             |          |                                                                
--   ____V____      ____V____      ______________     |          |      ____________       _______                                
--  |         |    |         |    |              |    |          |     |            |     |       |                               
--  |  Video  |--->|  Frame  |--->|     FIFO     |--->|          |     |            |     |       |                               
--  |  Codec  |    | Grabber |    |______________|    |          |     |            |     |       |                               
--  |_________|    |_________|                        |          |     |   SDRAM    |     |       |                               
--                                                    | Dualport |<--->| Controller |<--->| SDRAM |                               
--   _________      _________      ______________     |          |     |            |     |       |                               
--  |         |    |         |    |              |    |          |     |            |     |       |                               
--  | Monitor |<---|   VGA   |<---|     FIFO     |<---|          |     |            |     |       |                               
--  |_________|    |_________|    |______________|    |          |     |____________|     |_______|                               
--                                                    |          |                                                                
--                                 ______________     |          |                                                                
--                                |              |    |          |                                                                
--                                | Address Cntr |--->|          |                                                                
--                                |______________|    |__________|                                                                
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
------------------------------------------------------------------------------------------------


library ieee, unisim, work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.framegrabber_pckg.all;
use unisim.vcomponents.all;
use work.vga_pckg.all;
use work.xsasdram.all;
use work.sdram.all;
use work.common.all;


entity video is
  generic(
    SDRAM_NROWS     :       natural := 8192;  -- 4096 for XSA-50, XSA-100; 8192 for XSA-200, XSA-3S1000
    SDRAM_NCOLS     :       natural := 512;  -- 256 for XSA-50; 512 for XSA-100, XSA-200, XSA-3S1000
    DATA_WIDTH      :       natural := 16;  -- SDRAM databus width
    SADDR_WIDTH     :       natural := 13;  -- # of SDRAM address bits
    HADDR_WIDTH     :       natural := 24;  -- host-side address width
    MASTER_CLK_FREQ :       natural := 100_000;  -- master clock frequency
    MASTER_CLK_DIV  :       real    := 2.0;  -- SDRAM frequency = MASTER_CLK_FREQ / MASTER_CLK_DIV
		VGA_CLK_FREQ    :       natural := 50_000; -- pixel clock = MASTER_CLK_FREQ / MASTER_CLK_DIV
    PIXEL_WIDTH     :       natural := 16;  -- width of a pixel in memory
    NUM_RGB_BITS    :       natural := 3;  -- #bits in each R,G,B component of a pixel
    PIXELS_PER_LINE :       natural := 720;  -- width of image in pixels
    LINES_PER_FRAME :       natural := 525;  -- height of image in scanlines
    FIT_TO_SCREEN   :       boolean := false  -- adapt video timing to fit image width x height
    );
  port(
    clk_in          : in    std_logic;  -- master clock (100 MHz)
    grab_frame_n    : in    std_logic;  -- active-low signal to initiate capture of a video frame
    -- video decoder interface
    vidin_clk       : in    std_logic;  -- video decoder clock (27 MHz)
    vidin_y         : in    std_logic_vector(7 downto 0);  -- sampled video data
    status          : out   std_logic_vector(7 downto 0);  -- FSM status for debugging
    -- VGA monitor interface
    r               : out   std_logic_vector(NUM_RGB_BITS-1 downto 0);  -- red
    g               : out   std_logic_vector(NUM_RGB_BITS-1 downto 0);  -- green
    b               : out   std_logic_vector(NUM_RGB_BITS-1 downto 0);  -- blue
    hsync_n         : out   std_logic;  -- horizontal sync
    vsync_n         : out   std_logic;  -- vertical sync
    -- SDRAM interface
    sclkfb          : in    std_logic;  -- clock from SDRAM after PCB delays
    sclk            : out   std_logic;  -- SDRAM clock sync'ed to master clock
    cke             : out   std_logic;  -- clock-enable to SDRAM
    cs_n            : out   std_logic;  -- chip-select to SDRAM
    ras_n           : out   std_logic;  -- SDRAM row address strobe
    cas_n           : out   std_logic;  -- SDRAM column address strobe
    we_n            : out   std_logic;  -- SDRAM write enable
    ba              : out   std_logic_vector(1 downto 0);  -- SDRAM bank address bits
    sAddr           : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM row/column address
    sData           : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- SDRAM in/out databus
    dqmh            : out   std_logic;  -- high databits I/O mask
    dqml            : out   std_logic;  -- low databits I/O mask
    -- PC-to-video decoder I2C interface
    lp_d            : in    std_logic_vector(1 downto 0);  -- parallel port data pins
    lp_s            : out   std_logic_vector(4 downto 3);  -- parallel port status pins
    scl             : inout std_logic;  -- bidirectional I2C clock signal
    sda             : inout std_logic   -- bidirectional I2C data signal
    );
end video;


architecture arch of video is

  signal clk : std_logic;               -- clock derived from master clock and sync'ed to SDRAM clock

  signal reset     : std_logic;         -- internal reset
  signal reset_cnt : natural range 0 to 7;  -- counter for assertion of internal reset

  signal grab_frame_sync : std_logic_vector(2 downto 1);  -- sync grab initiation to master clock

  -- framegrabber->SDRAM interface
	signal buffered_vidin_clk         : std_logic;  -- buffered clock from video decoder
  signal pixel_avail                : std_logic;  -- indicates the availability of a pixel from the framegrabber
  signal pixel_rd                   : std_logic;  -- initiates the read of a pixel from the framegrabber
  signal pixel_from_framegrabber    : std_logic_vector(15 downto 0);  -- pixel from framegrabber
  signal store_wr                   : std_logic;  -- initiates store of pixel to SDRAM
  signal store_wr_begun             : std_logic;  -- indicates pixel store operation has begun
  signal pixel_cntr, pixel_cntr_x   : natural range 0 to PIXELS_PER_LINE-1;  -- counts pixels within a line of video
  signal store_cntr, store_cntr_x   : natural range 0 to (2**HADDR_WIDTH)-1;  -- address at which to store pixel
  signal store_address              : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- address at which to store pixel
  type svs is (wait_for_pixel, store_pixel);  -- framegrabber->SDRAM FSM states
  signal store_state, store_state_x : svs;  -- state of framegrabber->SDRAM FSM

  -- SDRAM->VGA interface
  signal vga_eof       : std_logic;     -- indicates the end of a frame of VGA video
  signal vga_full      : std_logic;     -- indicates the FIFO to the VGA generator is full
  signal read_rd       : std_logic;     -- initiates a read of a pixel from SDRAM
  signal read_rd_begun : std_logic;     -- indicates the pixel read operation has begun
  signal read_rd_done  : std_logic;     -- indicates the SDRAM has delivered the pixel
  signal pixel_to_vga  : std_logic_vector(15 downto 0);  -- pixel from SDRAM to VGA generator
  signal read_cntr     : natural range 0 to (2**HADDR_WIDTH)-1;  -- address from which to read pixel
  signal read_address  : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- address from which to read pixel

  -- SDRAM-controller side of SDRAM dualport
  signal rst_i          : std_logic;
  signal rd_i           : std_logic;
  signal wr_i           : std_logic;
  signal earlyOpBegun_i : std_logic;
  signal opBegun_i      : std_logic;
  signal rdPending_i    : std_logic;
  signal done_i         : std_logic;
  signal rdDone_i       : std_logic;
  signal hAddr_i        : std_logic_vector(HADDR_WIDTH-1 downto 0);
  signal hDIn_i         : std_logic_vector(DATA_WIDTH-1 downto 0);
  signal hDOut_i        : std_logic_vector(DATA_WIDTH-1 downto 0);
  signal status_i       : std_logic_vector(3 downto 0);

  -- I2C interface signals
  signal scl_out : std_logic;           -- output on I2C clock line
  signal scl_in  : std_logic;           -- input from I2C clock line
  signal sda_out : std_logic;           -- output on I2C data line
  signal sda_in  : std_logic;           -- input from I2C data line

begin

  ----------------------------------------------------------------------------------------------
  -- Generate a reset and release it after a few clocks.
  ----------------------------------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
      if reset_cnt = 7 then
        reset     <= NO;
      else
        reset     <= YES;
        reset_cnt <= reset_cnt + 1;
      end if;
    end if;
  end process;

  ----------------------------------------------------------------------------------------------
  -- Synchronize the framegrabber initiation input to the clock domain by passing it
  -- through a chain of flip-flops.
  ----------------------------------------------------------------------------------------------
  process(clk, reset)
  begin
    if reset = YES then
      grab_frame_sync <= "00";
    elsif rising_edge(clk) then
      grab_frame_sync <= grab_frame_sync(grab_frame_sync'high-1 downto 1) & not grab_frame_n;
    end if;
  end process;

  ----------------------------------------------------------------------------------------------
  -- The framegrabber module interfaces to the video codec and delivers the pixels.
  ----------------------------------------------------------------------------------------------
	ux: ibuf port map(I=>vidin_clk,O=>buffered_vidin_clk); -- Buffer the clock input for the XSA-200.
  u0 : framegrabber port map (
    reset       => reset,
    video_clk   => buffered_vidin_clk,
    video_in    => vidin_y,
    grab_frame  => grab_frame_sync(grab_frame_sync'high),
    pixel_clk   => clk,
    pixel_avail => pixel_avail,
    pixel_rd    => pixel_rd,
    pixel_out   => pixel_from_framegrabber,
    status      => status
    );

  ----------------------------------------------------------------------------------------------
  -- This FSM controls the transfer of pixels from the framegrabber module into the SDRAM.
  ----------------------------------------------------------------------------------------------
  -- Combinational portion of the FSM
  process(store_cntr, pixel_cntr, store_state, pixel_avail, pixel_from_framegrabber, store_wr_begun)
  begin
    -- Set the default values for these signals.
    pixel_rd      <= NO;
    store_wr      <= NO;
    store_cntr_x  <= store_cntr;
    pixel_cntr_x  <= pixel_cntr;
    store_state_x <= store_state;

    case store_state is
      
			when wait_for_pixel =>
        if pixel_avail = YES then
          -- A pixel is available from the framegrabber, so read it and store it into SDRAM.
          pixel_rd          <= YES;
          store_state_x     <= store_pixel;
        end if;
      
			when store_pixel    =>
        -- The upper two bits of the pixel indicate the current field of the interleaved
        -- video (bit 14) and whether the field has just changed (bit 15 is the sync bit).
        -- A pixel with the sync bit set does not contain any valid pixel data so it isn't stored
        -- into SDRAM.  It is just used to reset the counter to the appropriate address for
        -- the start of each field.  (The video lines in each field are interleaved through
        -- the SDRAM.)   
        if pixel_from_framegrabber(15) = HI then  -- The video field has changed ... 
          pixel_cntr_x      <= 0;       -- so reset the pixel counter ...
                                        -- and set the starting SDRAM address for the field.
          if pixel_from_framegrabber(14) = '0' then
                                        -- Even fields start at SDRAM address 0.
            store_cntr_x    <= 0;
          else
                                        -- Odd fields start at (SDRAM address 0) + (length of a video line).
            store_cntr_x    <= PIXELS_PER_LINE;
          end if;
          -- Determine the next state.
          if pixel_avail = YES then
                                        -- If another pixel is available, then initiate a read and immediately return
                                        -- to this state to store it. 
            pixel_rd        <= YES;
            store_state_x   <= store_pixel;
          else
                                        -- Otherwise, wait for another pixel to arrive.
            store_state_x   <= wait_for_pixel;
          end if;
          -- The sync bit is cleared, so store the pixel data into SDRAM.
        else
          store_wr          <= YES;     -- Initiate the store into SDRAM. 
          if store_wr_begun = YES then
                                        -- The store operation has begun, so update the SDRAM address pointer.
            if pixel_cntr = PIXELS_PER_LINE-1 then
                                        -- Reached the end of the current line of video, so move the pointer
                                        -- to the start of the next interleaved line in SDRAM. 
              store_cntr_x  <= store_cntr+PIXELS_PER_LINE+1;
              pixel_cntr_x  <= 0;       -- Reset the counter for the line of pixels.
            else
                                        -- Otherwise, just increment the address pointer and pixel counter.
              store_cntr_x  <= store_cntr+1;
              pixel_cntr_x  <= pixel_cntr+1;
            end if;
            -- Determine the next state.
            if pixel_avail = YES then
                                        -- If another pixel is available, then initiate a read and immediately return
                                        -- to this state to store it. 
              pixel_rd      <= YES;
              store_state_x <= store_pixel;
            else
                                        -- Otherwise, wait for another pixel to arrive.
              store_state_x <= wait_for_pixel;
            end if;
          end if;
        end if;

			when others         =>
        -- If in an erroneous state, go to a valid state.
        store_state_x       <= wait_for_pixel;

    end case;
  end process;  -- End of the combinational portion of the FSM
  ----------------------------------------------------------------------------------------------
  -- Sequential portion of the FSM.
  process(clk, reset)
  begin
    if reset = YES then
      store_cntr            <= 0;
      pixel_cntr            <= 0;
      store_state           <= wait_for_pixel;
    elsif rising_edge(clk) then
      store_cntr            <= store_cntr_x;
      pixel_cntr            <= pixel_cntr_x;
      store_state           <= store_state_x;
    end if;
  end process;
  ----------------------------------------------------------------------------------------------
  -- Convert the address counter into a std_logic_vector that can be used by the SDRAM controller.
  store_address             <= CONV_STD_LOGIC_VECTOR(store_cntr, store_address'length);

  ----------------------------------------------------------------------------------------------
  -- This is the dualport module that gives both the framegrabber and the VGA generator
  -- access to the SDRAM.
  ----------------------------------------------------------------------------------------------
  u1 : dualport
    generic map(
      PIPE_EN         => true,
      PORT_TIME_SLOTS => "0000000000000000",  -- Give the framegrabber complete priority over the VGA.
      DATA_WIDTH      => DATA_WIDTH,
      HADDR_WIDTH     => HADDR_WIDTH
      )
    port map(
      clk             => clk,
      -- Framegrabber interface attaches to port 0 and has complete priority over the VGA generator
      -- since we would rather mess-up the display for a single frame-time rather than miss data
      -- from the framegrabber.
      rst0            => reset,
      rd0             => NO,
      wr0             => store_wr,
      earlyOpBegun0   => store_wr_begun,
      opBegun0        => open,
      rdPending0      => open,
      rdDone0         => open,
      done0           => open,
      hAddr0          => store_address,
      hDIn0           => pixel_from_framegrabber,
      hDOut0          => open,
      status0         => open,
      -- VGA interface
      rst1            => reset,
      rd1             => read_rd,
      wr1             => NO,
      earlyOpBegun1   => read_rd_begun,
      opBegun1        => open,
      rdPending1      => open,
      rdDone1         => read_rd_done,
      done1           => open,
      hAddr1          => read_address,
      hDIn1           => "0000000000000000",
      hDOut1          => pixel_to_vga,
      status1         => open,
      -- Connections to the SDRAM controller.
      rst             => rst_i,
      rd              => rd_i,
      wr              => wr_i,
      earlyOpBegun    => earlyOpBegun_i,
      opBegun         => opBegun_i,
      rdPending       => rdPending_i,
      rdDone          => rdDone_i,
      done            => done_i,
      hAddr           => hAddr_i,
      hDIn            => hDIn_i,
      hDOut           => hDOut_i,
      status          => status_i
      );

  ----------------------------------------------------------------------------------------------
  -- Instantiate the SDRAM controller that connects to the dualport
  -- module and interfaces to the external SDRAM chip.
  ----------------------------------------------------------------------------------------------
  u2 : xsaSDRAMCntl
    generic map(
      FREQ                 => MASTER_CLK_FREQ,
			CLK_DIV              => MASTER_CLK_DIV,
      PIPE_EN              => true,     -- Enable pipelining for maximum SDRAM bandwidth.
      MULTIPLE_ACTIVE_ROWS => true,     -- Allow multiple active rows in SDRAM for maximum bandwidth.
      MAX_NOP              => 1000000,  -- Disable self-refresh since it takes too long to re-awaken the SDRAM with video timing.
      DATA_WIDTH           => DATA_WIDTH,
      NROWS                => SDRAM_NROWS,
      NCOLS                => SDRAM_NCOLS,
      HADDR_WIDTH          => HADDR_WIDTH,
      SADDR_WIDTH          => SADDR_WIDTH
      )
    port map(
      clk                  => clk_in,
      clk1x                => clk,
      rst                  => rst_i,
      rd                   => rd_i,
      wr                   => wr_i,
      earlyOpBegun         => earlyOpBegun_i,
      opBegun              => opBegun_i,
      rdPending            => rdPending_i,
      done                 => done_i,
      rdDone               => rdDone_i,
      hAddr                => hAddr_i,
      hDIn                 => hDIn_i,
      hDOut                => hDOut_i,
      status               => status_i,
      sclkfb               => sclkfb,
      sclk                 => sclk,
      cke                  => cke,
      cs_n                 => cs_n,
      ras_n                => ras_n,
      cas_n                => cas_n,
      we_n                 => we_n,
      ba                   => ba,
      sAddr                => sAddr,
      sData                => sData,
      dqmh                 => dqmh,
      dqml                 => dqml
      );

  ----------------------------------------------------------------------------------------------
  -- The VGA generator gets data from the SDRAM and displays it on a monitor.
  ----------------------------------------------------------------------------------------------
  u3 : vga
    generic map (
      FREQ            => 50_000,
      PIXEL_WIDTH     => PIXEL_WIDTH,
      PIXELS_PER_LINE => PIXELS_PER_LINE,
      LINES_PER_FRAME => LINES_PER_FRAME,
      NUM_RGB_BITS    => NUM_RGB_BITS,
      FIT_TO_SCREEN   => FIT_TO_SCREEN
      )
    port map(
      rst             => reset,
      clk             => clk,
      wr              => read_rd_done,
      pixel_data_in   => pixel_to_vga,
      full            => vga_full,
      eof             => vga_eof,
      r               => r,
      g               => g,
      b               => b,
      hsync_n         => hsync_n,
      vsync_n         => vsync_n,
      blank           => open
      );
  ----------------------------------------------------------------------------------------------
  -- Read pixels from the SDRAM as long as the VGA FIFO buffer is not full.
  read_rd <= not(vga_full);

  ----------------------------------------------------------------------------------------------
  -- Update the address counter used by the VGA generator to get pixels from SDRAM.
  ----------------------------------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
      if vga_eof = YES then
        read_cntr <= 0;                 -- Reset the address at the end of a video frame.
      elsif read_rd_begun = YES then
        read_cntr <= read_cntr + 1;     -- Go to the next address once the read of the current address has begun.
      end if;
    end if;
  end process;
  ----------------------------------------------------------------------------------------------
  -- Convert the address counter into a std_logic_vector that can be used by the SDRAM controller.
  read_address    <= CONV_STD_LOGIC_VECTOR(read_cntr, read_address'length);

  ----------------------------------------------------------------------------------------------
  -- This is the parallel port -> I2C interface that is used to initialize the video decoder
  -- from the PC.
  ----------------------------------------------------------------------------------------------
  scl_out <= lp_d(0);
  sda_out <= lp_d(1);
  lp_s(3) <= scl_in;
  lp_s(4) <= sda_in;
  scl     <= '0' when scl_out = '0' else 'Z';
  sda     <= '0' when sda_out = '0' else 'Z';
  scl_in  <= scl;
  sda_in  <= sda;

end arch;

