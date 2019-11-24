--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 2/9/2006
-- Copyright     : 2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    This is a finite-state machine that grabs frames of video in
--    ITU-R BT.656 4:2:2 format and creates grayscale pixels from each
--    8-bit luminance value.  The pixels are then stored in a FIFO.
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


package framegrabber_pckg is

  component framegrabber
    port(
      reset       : in  std_logic;      -- initiate a reset
      grab_frame  : in  std_logic;      -- initiate capture of a video frame
      -- video decoder interface
      video_clk   : in  std_logic;      -- clock from video codec (27 MHz)
      video_in    : in  std_logic_vector(7 downto 0);  -- sampled video data from codec
      -- pixel data output
      pixel_clk   : in  std_logic;      -- clock for outputing pixels from FIFO
      pixel_avail : out std_logic;      -- indicates pixel data is available in the FIFO
      pixel_rd    : in  std_logic;      -- initiate read of pixel data from the FIFO
      pixel_out   : out std_logic_vector(15 downto 0);  -- pixel data output from the FIFO
      -- miscellaneous
      status      : out std_logic_vector(7 downto 0)  -- FSM status for debugging
      );
  end component framegrabber;

end package framegrabber_pckg;



library ieee, work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.fifo_pckg.all;
use work.common.all;


entity framegrabber is
  port(
      reset       : in  std_logic;      -- initiate a reset
      grab_frame  : in  std_logic;      -- initiate capture of a video frame
      -- video decoder interface
      video_clk   : in  std_logic;      -- clock from video codec (27 MHz)
      video_in    : in  std_logic_vector(7 downto 0);  -- sampled video data from codec
      -- pixel data output
      pixel_clk   : in  std_logic;      -- clock for outputing pixels from FIFO
      pixel_avail : out std_logic;      -- indicates pixel data is available in the FIFO
      pixel_rd    : in  std_logic;      -- initiate read of pixel data from the FIFO
      pixel_out   : out std_logic_vector(15 downto 0);  -- pixel data output from the FIFO
      -- miscellaneous
      status      : out std_logic_vector(7 downto 0)  -- FSM status for debugging
    );
end framegrabber;


architecture arch of framegrabber is

-- states for the framegrabber FSM
  type fgs is (
    wait_for_embedded_sync,
    wait_for_embedded_sync_1,
    wait_for_embedded_sync_2,
    check_embedded_sync,
    grab_chromab,
    grab_luminance1,
    grab_chromar,
    grab_luminance2
    );
  signal framegrabber_state : fgs; -- framegrabber state register
	alias  es                 : std_logic_vector(video_in'range) is video_in; -- embedded sync
  signal prev_es            : std_logic_vector(video_in'range); -- previous embedded sync value
  signal prev_grab_frame    : std_logic; -- previous value for grab frame initiator
  signal grab_in_progress   : std_logic; -- indicates when frame grabbing is occuring
  signal field_id           : std_logic; -- current field of a frame of video
  signal field_change       : std_logic; -- indicates when the video field has switched from odd-to-even or even-to-odd
  signal luminance          : std_logic_vector(7 downto 0); -- luminance portion of ITU-R BT.656 format
  signal chromar            : std_logic_vector(7 downto 0); -- red chromiance portion
  signal chromab            : std_logic_vector(7 downto 0); -- blue chromiance portion
  signal pixel_wr           : std_logic; -- initiates a write of a pixel to the FIFO buffer
  signal pixel_in           : std_logic_vector(15 downto 0); -- pixel going into FIFO
  signal empty              : std_logic; -- indicates when the are no pixels in the FIFO

begin

  ----------------------------------------------------------------------------------------------
  -- Simple state machine that interprets the ITU-R BT.656 4:2:2 pixel stream from the video 
	-- decoder and latches the luminance component of the video (grayscale frame grabbing).
	-- The pixel stream is formatted as follows:
  --                    __    __    __    __    __    __    __    __         
  --       27 MHz clock   \__/  \__/  \__/  \__/  \__/  \__/  \__/  \__/.....
  --                     ____  ____  ____  ____  ____  ____  ____  ____      
  -- ITU-R BT.656 4:2:2 / FF \/ 00 \/ 00 \/ ES \/ Cb \/ Y0 \/ Cr \/ Y1 \.....
  --       Pixel Stream \____/\____/\____/\____/\____/\____/\____/\____/     
  --                    <----Embedded Sync-----><--------Pixels---------.....
	--
	-- A marker (FF-00-00) is followed by the embedded sync byte (ES).  This is followed by
	-- 1440 bytes - 720 luminance values (Y), 360 blue chromiance values (Cb) and 360 red
	-- chromiance values (Cr).
  ----------------------------------------------------------------------------------------------
  process(video_clk, reset)
  begin
    if reset = YES then
      grab_in_progress   <= NO;
      prev_grab_frame    <= NO;
      framegrabber_state <= wait_for_embedded_sync;
      status             <= "00000000";  -- Indicate the FSM is in the reset state.
    elsif rising_edge(video_clk) then
      -- Set default values for these control signals.
      field_id     <= '0';
      field_change <= NO;
      pixel_wr     <= NO;

      case framegrabber_state is

        -- The following three states look for the marker FF-00-00 that precedes
        -- the embedded sync in the pixel stream.
        when wait_for_embedded_sync =>
          if video_in = 16#FF# then
            framegrabber_state <= wait_for_embedded_sync_1;
          else
            framegrabber_state <= wait_for_embedded_sync;
          end if;
          status               <= "00000001";
        when wait_for_embedded_sync_1 =>
          if video_in = 16#00# then
            framegrabber_state <= wait_for_embedded_sync_2;
          else
            framegrabber_state <= wait_for_embedded_sync;
          end if;
          status               <= "00000010";
        when wait_for_embedded_sync_2 =>
          if video_in = 16#00# then
            framegrabber_state <= check_embedded_sync;
          else
            framegrabber_state <= wait_for_embedded_sync;
          end if;
          status               <= "00000010";

          -- Now look at the embedded sync to determine where we are in the video frame.
          -- Embedded sync bit functions:
          --   Bit 4: Horizontal sync bit.  1=end-active-video (EAV); 0=start-active-video (SAV).
          --   Bit 5: Vertical sync bit.  1=vertical blanking; 0=active video.
          --   Bit 6: Interleaved field identifier.  1=field 1; 0=field 0.
        when check_embedded_sync =>
          -- Look for EAV because all the important signals change state then.
          if es(4) = HI then
					  -- Now look for the start of a video frame as indicated by a field id of 0 and
						-- a transition of the vertical sync bit from 1 to 0.
            if es(6 downto 5) = "00" and prev_es(6 downto 5) = "01" then
						  -- Now look and see if a frame capture has just been requested and only capture
							-- a single frame per request.
              if grab_frame = YES and prev_grab_frame = NO then
                grab_in_progress <= YES;         -- Start capturing the frame.
              else
                grab_in_progress <= NO; 
              end if;
              prev_grab_frame    <= grab_frame;  -- Store the state of the frame capture request.
              -- Set the field id and the change-of-field indicator and write the pixel to
							-- the FIFO.  This pixel contains no actual image data.  It serves only to indicate
							-- the start of a frame of pixels to whatever reads from the FIFO.
              field_id           <= '0';
              field_change       <= YES;
              pixel_wr           <= YES;
            end if;

					  -- Look for the start of the interleaved field 1 in a video frame as indicated by a
						-- field id of 1 and a transition of the vertical sync bit from 1 to 0.
            if es(6 downto 5) = "10" and prev_es(6 downto 5) = "11" and grab_in_progress = YES then
              field_id     <= '1';
              field_change <= YES;
              pixel_wr     <= YES;
            end if;

            prev_es <= es; -- Store the embedded sync so we can check for field changes.
          end if;

          if es(5 downto 4)="00" and grab_in_progress=YES then
					  framegrabber_state <= grab_chromab; -- Start storing pixels if video is active and a capture is in progress.
          else
					  framegrabber_state <= wait_for_embedded_sync; -- Otherwise, wait for the next embedded sync and check again.
          end if;
          status               <= "00000100";

        -- The blue chromiance is output by the video decoder during this cycle.  Pixel values of
				-- 0xFF and 0x00 are not valid.  If 0xFF is received, then it would have to be the start
				-- of the marker preceding an embedded sync.  Any other value is a valid blue chromiance
				-- value which is ignored and the FSM moves to the next state.
        when grab_chromab =>
				  case video_in is
					  when "11111111" => framegrabber_state <= wait_for_embedded_sync_1;
						when others => framegrabber_state <= grab_luminance1;
          end case;
          status               <= "00001000";

        -- The luminance is output by the video decoder during this cycle.  If a valid luminance
				-- value is seen, the luminance is written into the FIFO and the FSM moves to the next state.
        when grab_luminance1 =>
				  case video_in is
					  when "11111111" => framegrabber_state <= wait_for_embedded_sync_1;
						when others =>
              luminance          <= video_in;
              pixel_wr           <= YES;
						  framegrabber_state <= grab_chromar;
          end case;
          status               <= "00010000";

        -- The red chromiance is output by the video decoder during this cycle.  If a valid
				-- chromiance value is seen, it is ignored and the FSM moves to the next state.
        when grab_chromar =>
				  case video_in is
					  when "11111111" => framegrabber_state <= wait_for_embedded_sync_1;
						when others => framegrabber_state <= grab_luminance2;
          end case;
          status               <= "00100000";

        -- The luminance is output by the video decoder during this cycle.  If a valid luminance
				-- value is seen, the luminance is written into the FIFO and the FSM returns to the
				-- beginning of the four-state cycle.
        when grab_luminance2 =>
				  case video_in is
					  when "11111111" => framegrabber_state <= wait_for_embedded_sync_1;
						when others =>
              luminance          <= video_in;
              pixel_wr           <= YES;
						  framegrabber_state <= grab_chromab;
          end case;
          status               <= "01000000";

        -- Handle erroneous states.
        when others =>
          framegrabber_state <= wait_for_embedded_sync;
          status             <= "10000000";
      end case;
    end if;
  end process;

  ----------------------------------------------------------------------------------------------
  -- Create a grayscale pixel by making each three-bit RGB component equal to the upper three bits
	-- of the luminance.  Also embed in the upper two bits of the pixel the current field of the
	-- frame and an indicator of whether the field has changed.  These are used to determine the
	-- start of a frame by whatever reads the pixels from the FIFO.  The format of the 16-bit pixel
	-- is CF00 000R RRGG GBBB where C = field change bit, F = field id bit, R = red, G = green,
	-- and B = blue.
  ----------------------------------------------------------------------------------------------
  pixel_in <= field_change & field_id & "00000" 
	            & luminance(7 downto 5) & luminance(7 downto 5) & luminance(7 downto 5);

  ----------------------------------------------------------------------------------------------
  -- This FIFO buffers the pixels.  The FIFO supports independent read and write clocks because
	-- whatever reads pixels from the FIFO may not be synchronized to the 27 MHz clock from the
	-- video codec that is used to write pixels to the FIFO. 
  ----------------------------------------------------------------------------------------------
  u0 : fifo_255x16_ic
    port map (
      rst      => reset,
      wr_clk   => video_clk,
      wr       => pixel_wr,
      data_in  => pixel_in,
      rd_clk   => pixel_clk,
      rd       => pixel_rd,
      data_out => pixel_out,
      full     => open,
      empty    => empty,
      level    => open
      );
  pixel_avail <= not empty; -- Pixels are available to be read if the FIFO is not empty.

end arch;
