--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 12/01/2007
-- Copyright     : 2007, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    Simulated RADAR logger.
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

package radar is

  component radarTest
    generic(
      PIPE_EN         : boolean := false;  -- enable pipelined operations
      DATA_WIDTH      : natural := 16;     -- memory data width
      ADDR_WIDTH      : natural := 32;     -- memory address width
      BEG_TEST        : natural := 16#0000_0000#; -- beginning test range address
      END_TEST        : natural := 16#007F_FFFF#  -- ending test range address
      );
    port(
      clk             : in  std_logic;     -- master clock input
      rst             : in  std_logic;     -- reset
      doAgain         : in  std_logic;     -- re-do memory test

      data_addr       : out   std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address to SDRAM
      data_din        : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from SDRAM
      data_dout       : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to SDRAM
      data_rd         : out   std_logic;   -- SDRAM read control signal
      data_wr         : out   std_logic;   -- SDRAM write control signal
      data_begun      : in    std_logic;   -- SDRAM read/write operation started indicator
      data_rdPending  : in    std_logic;   -- SDRAM read operation pending in pipeline indicator
      data_done       : in    std_logic;   -- SDRAM read/write operation complete indicator

		ctrl_addr       : out   std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address to block RAM
		ctrl_din        : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from block RAM
		ctrl_dout       : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to block RAM
		ctrl_rd         : out   std_logic;   -- block RAM read control signal
		ctrl_wr         : out   std_logic;   -- block RAM write control signal

      progress        : out std_logic_vector(1 downto 0);  -- memory test progress indicator
      err             : out std_logic      -- memory error flag
      );
  end component;

end package radar;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
--use IEEE.std_logic_arith.all; -- use this when loading SDRAM with known value
use WORK.common.all;
use WORK.rand.all;

entity radarTest is
    generic(
      PIPE_EN         : boolean := false;  -- enable pipelined operations
      DATA_WIDTH      : natural := 16;     -- memory data width
      ADDR_WIDTH      : natural := 32;     -- memory address width
      BEG_TEST        : natural := 16#0000_0000#; -- beginning test range address
      END_TEST        : natural := 16#007F_FFFF#  -- ending test range address
      );
    port(
      clk             : in  std_logic;     -- master clock input
      rst             : in  std_logic;     -- reset
      doAgain         : in  std_logic;     -- re-do memory test

      data_addr       : out   std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address to SDRAM
      data_din        : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from SDRAM
      data_dout       : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to SDRAM
      data_rd         : out   std_logic;   -- SDRAM read control signal
      data_wr         : out   std_logic;   -- SDRAM write control signal
      data_begun      : in    std_logic;   -- SDRAM read/write operation started indicator
      data_rdPending  : in    std_logic;   -- SDRAM read operation pending in pipeline indicator
      data_done       : in    std_logic;   -- SDRAM read/write operation complete indicator

		ctrl_addr       : out   std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address to block RAM
		ctrl_din        : in    std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from block RAM
		ctrl_dout       : out   std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to block RAM
		ctrl_rd         : out   std_logic;   -- block RAM read control signal
		ctrl_wr         : out   std_logic;   -- block RAM write control signal

      progress        : out std_logic_vector(1 downto 0);  -- memory test progress indicator
      err             : out std_logic      -- memory error flag
      );
end radarTest;


architecture arch of radarTest is

  -- states of the memory tester state machine
  type testState is (
    INIT,                               -- init
    LOAD,                               -- load memory with pseudo-random data
    COMPARE,                            -- compare memory contents with pseudo-random data
    EMPTY_PIPE,                         -- empty read pipeline
	 LOAD_ADDRL,                         -- load lower word of address into block RAM
	 LOAD_ADDRH,								 -- load upper word of address into block RAM
	 LOAD_LENGTH,								 -- load length of data to upload from SDRAM
	 WAIT_FOR_UPLOAD, WAIT_FOR_UPLOAD_1, -- wait for PC to upload data from SDRAM
    STOP                                -- stop and indicate memory status
    );
  signal state_r, state_x : testState;  -- state register and next state

  -- block RAM addresses for various control registers
  constant ADDRL_REG  : std_logic_vector(ctrl_addr'range) := "00"; -- LSB of SDRAM starting address
  constant ADDRH_REG  : std_logic_vector(ctrl_addr'range) := "01"; -- MSB of SDRAM starting address
  constant LENGTH_REG : std_logic_vector(ctrl_addr'range) := "10"; -- length of SDRAM data block

  -- registers
  signal data_addr_r, data_addr_x : unsigned(data_addr'range);  -- SDRAM address register
  signal err_r, err_x   : std_logic;    -- error flag

  -- internal signals
  signal ld   : std_logic;              -- load random number gen with seed value
  signal cke  : std_logic;              -- clock-enable for random number gen
  signal rand : std_logic_vector(data_dout'range);  -- random number from generator
  signal seed : std_logic_vector(data_din'range);   -- random number starting seed

begin

  seed <= (others => '1');        -- random number seed is 111...111

  -- random number generator module
  u0 : randGen
    generic map(
      DATA_WIDTH => seed'length
      )
    port map(
      clk        => clk,          -- input clock
      cke        => cke,          -- clock-enable to control when new random num is computed
      ld         => ld,           -- load seed control signal
      seed       => seed,         -- random number seed
      rand       => rand          -- random number output from generator
      );

  -- connect internal registers to external busses 
  -- SDRAM address bus driven by SDRAM address register     
  data_addr <= std_logic_vector(data_addr_r); -- linear SDRAM addressing
  data_dout <= rand;                    -- always output the current random number to the SDRAM
--  data_dout <= CONV_STD_LOGIC_VECTOR(16#DEAD#,16); -- for clearing SDRAM to a known value
  err  <= err_r;                        -- output the current memory error status

  -- memory test controller state machine operations
  combinatorial : process(state_r, err_r, data_addr_r, data_din, ctrl_din, rand, data_begun, data_done, data_rdPending, doAgain)
  begin

    -- default operations (do nothing unless explicitly stated in the following case statement)
	 ctrl_rd      <= NO;            -- no control register read
	 ctrl_wr      <= NO;            -- no control register write
	 ctrl_addr    <= (others=>'0'); -- control register address defaults to zero
	 ctrl_dout    <= (others=>'0'); -- control register data defaults to zero
    data_rd      <= NO;            -- no SDRAM read
    data_wr      <= NO;            -- no SDRAM write
    ld           <= NO;            -- don't load the random number generator
    cke          <= NO;            -- don't generate a new random number
    data_addr_x  <= data_addr_r;   -- next address is the same as current address
    err_x        <= err_r;         -- error flag is unchanged
    state_x      <= state_r;       -- no change in memory tester state

    -- **** compute the next state and operations ****
    case state_r is

      ------------------------------------------------------
      -- initialize the memory test controller
      ------------------------------------------------------
      when INIT =>
        progress    <= "00";      -- indicate the current controller state
        ld          <= YES;       -- load random number seed
        cke         <= YES;       -- enable clocking of rand num gen so seed gets loaded
        data_addr_x <= TO_UNSIGNED(BEG_TEST, data_addr_x'length);  -- load starting mem address
        err_x       <= NO;        -- clear memory error flag
        state_x     <= LOAD;      -- next go to LOAD state and write pattern to SDRAM

      when LOAD => -- load the SDRAM with data from the random number generator
        progress           <= "01"; -- indicate the current controller state
        if PIPE_EN then
          data_wr          <= YES;
          if data_begun = YES then
            if data_addr_r /= END_TEST then
              data_addr_x  <= data_addr_r + 1; -- so increment address
              cke          <= YES;  -- and enable generator clock to get new random num
            else
              cke          <= YES;  -- enable generator clock and
              ld           <= YES;  -- reload the generator with the seed value
              data_addr_x  <= TO_UNSIGNED(BEG_TEST, data_addr_x'length); -- reset to start of test range
              state_x      <= COMPARE;
            end if;
          end if;
        else
          if data_done = NO then
            data_wr        <= YES;
          elsif data_addr_r /= END_TEST then
            data_addr_x    <= data_addr_r + 1; -- so increment address
            cke            <= YES;  -- and enable generator clock to get new random num
          else
            cke            <= YES;  -- enable generator clock and
            ld             <= YES;  -- reload the generator with the seed value
            data_addr_x    <= TO_UNSIGNED(BEG_TEST, data_addr_x'length); -- reset to start of test range
            state_x        <= COMPARE;
          end if;
        end if;

      when COMPARE => -- re-run the generator and compare it to SDRAM contents
        progress           <= "10";  -- indicate the current controller state
        if PIPE_EN then
          data_rd          <= YES;
          if data_begun = YES then
            data_addr_x    <= data_addr_r + 1; -- increment address to check next SDRAM location
          end if;
          if data_addr_r = END_TEST then
            state_x        <= EMPTY_PIPE;
          end if;
          if data_done = YES then
            if data_din /= rand then -- compare value from SDRAM to random number
              err_x        <= YES;   -- error if they don't match
            end if;
            cke            <= YES;   -- enable generator clock to get next random num
          end if;
        else
          if data_done = NO then     -- current read operation is not complete
            data_rd        <= YES;   -- keep read signal active since SDRAM read is not done
          else                       -- current read operation is complete
            data_rd        <= NO;    -- release the read signal when read op is complete
            if data_din /= rand then -- compare value from SDRAM to random number
              err_x   <= YES;        -- error if they don't match
            end if;
            if data_addr_r = END_TEST then
              state_x <= LOAD_ADDRL; -- go to STOP state once entire range has been checked
            end if;
            data_addr_x    <= data_addr_r + 1; -- increment address to check next SDRAM location
            cke       <= YES;        -- and enable generator clock to get next random num
          end if;
        end if;

      when EMPTY_PIPE =>
        progress  <= "10";           -- indicate the current controller state
        if data_done = YES then
          if data_din /= rand then   -- compare value from SDRAM to random number
            err_x <= YES;            -- error if they don't match
          end if;
          cke     <= YES;            -- enable generator clock to get next random num
        end if;
        if data_rdPending = NO then
          state_x <= LOAD_ADDRL;
        end if;

      when LOAD_ADDRL => -- store the LSB of the SDRAM address in the control register
        progress  <= "10";
		  ctrl_addr <= ADDRL_REG;      -- register address
		  ctrl_dout <= X"5555";			 -- LSB of address (junk address in this example)
		  ctrl_wr   <= YES;				 -- activate write to register
		  state_x   <= LOAD_ADDRH;

      when LOAD_ADDRH => -- store the MSB of the SDRAM address in the control register
        progress  <= "10";
		  ctrl_addr <= ADDRH_REG;		 -- register address
		  ctrl_dout <= X"AAAA";			 -- MSB of address (junk address in this example)
		  ctrl_wr   <= YES;				 -- activate write to register
		  state_x   <= LOAD_LENGTH;

      when LOAD_LENGTH => -- store the length of the block of SDRAM data
        progress  <= "10";
		  ctrl_addr <= LENGTH_REG;		 -- register address
		  ctrl_dout <= X"5A5A";			 -- length of the block of SDRAM data
		  ctrl_wr   <= YES;				 -- activate the write to register
		  state_x   <= WAIT_FOR_UPLOAD;

      when WAIT_FOR_UPLOAD => -- read the value from the length register 
        progress  <= "10";
		  ctrl_addr <= LENGTH_REG;		 -- register address
		  ctrl_rd   <= YES;				 -- activate the read from the register
		  state_x   <= WAIT_FOR_UPLOAD_1; -- the value will be available in the next state

      when WAIT_FOR_UPLOAD_1 => -- the value read from the length register is available now
        progress  <= "10";
		  ctrl_addr <= LENGTH_REG;     -- register address
		  ctrl_rd   <= YES;				 -- read the register again
		  if(ctrl_din /= 0) then
		    state_x <= WAIT_FOR_UPLOAD_1; -- keep checking the length value if it is not zero
        else
		    state_x <= STOP;				 -- exit this state if the length value has been cleared to zero
        end if;

      when others =>                 -- memory test is complete
        progress  <= "11";           -- indicate the current controller state
        if doAgain = YES then
          ld      <= YES;            -- load random number seed
          cke     <= YES;            -- enable clocking of rand num gen so seed gets loaded
          data_addr_x <= TO_UNSIGNED(BEG_TEST, data_addr_x'length); -- load starting mem address
          err_x   <= NO;             -- clear memory error flag
          state_x <= INIT;           -- go to the INIT state and and re-do memory test
        end if;

    end case;

  end process;


  -- update the registers of the memory tester controller       
  update : process(clk,rst)
  begin
    if rst = YES then
      -- go to starting state and clear error flag when reset occurs
      state_r <= INIT;
    elsif rising_edge(clk) then
      -- update error flag, address register, and state
      err_r   <= err_x;
      data_addr_r  <= data_addr_x;
      state_r <= state_x;
    end if;
  end process;

end arch;
