library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.rand.all;


package mem is

  component memTest
    generic(
      DATA_WIDTH :     natural := 16;   -- memory data width
      ADDR_WIDTH :     natural := 23;   -- memory address width
      BEG_TEST   :     natural := 0;    -- beginning test range address
      END_TEST   :     natural := 16#FFFF#;  -- ending test range address
      STEP_SIZE  :     natural := 1     -- address increment
      );
    port(
      clk        : in  std_logic;       -- master clock input
      rst        : in  std_logic;       -- active-high reset
      done       : in  std_logic;       -- memory operation complete indicator
      dIn        : in  std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from memory
      rd         : out std_logic;       -- memory read control signal
      wr         : out std_logic;       -- memory write control signal
      abort      : out std_logic;       -- read/write sector abort
      addr       : out std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address to memory
      dOut       : out std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to memory
      progress   : out std_logic_vector(1 downto 0);  -- memory test progress indicator
      errbits    : out std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bits with errors
      err        : out std_logic        -- memory error flag
      );
  end component;

end package mem;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.rand.all;

entity memTest is
  generic(
    DATA_WIDTH :     natural := 16;     -- memory data width
    ADDR_WIDTH :     natural := 23;     -- memory address width
    BEG_TEST   :     natural := 0;      -- beginning test range address
    END_TEST   :     natural := 16#FFFF#;  -- ending test range address
    STEP_SIZE  :     natural := 1       -- address increment
    );
  port(
    clk        : in  std_logic;         -- master clock input
    rst        : in  std_logic;         -- active-high reset
    done       : in  std_logic;         -- memory operation complete indicator
    dIn        : in  std_logic_vector(DATA_WIDTH-1 downto 0);  -- data from memory
    rd         : out std_logic;         -- memory read control signal
    wr         : out std_logic;         -- memory write control signal
    abort      : out std_logic;         -- read/write sector abort
    addr       : out std_logic_vector(ADDR_WIDTH-1 downto 0);  -- address to memory
    dOut       : out std_logic_vector(DATA_WIDTH-1 downto 0);  -- data to memory
    progress   : out std_logic_vector(1 downto 0);  -- memory test progress indicator
    errbits    : out std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bits with errors
    err        : out std_logic          -- memory error flag
    );
end memTest;

architecture arch of memTest is

  -- states of the memory tester state machine
  type testState is (
    INIT,                               -- init
    LOAD,                               -- load memory with pseudo-random data
    COMPARE,                            -- compare memory contents with pseudo-random data
    STOP                                -- stop and indicate memory status
    );
  signal state_r, state_next : testState;  -- state register and next state

  -- registers
  signal addr_r, addr_next       : unsigned(addr'range);  -- address register
  signal err_r, err_next         : std_logic;  -- error flag
  signal errcnt_r, errcnt_next   : unsigned(addr'high+1 downto 0);  -- error counter
  signal errbits_r, errbits_next : std_logic_vector(errbits'range);  -- records data bits with errors
  signal cnt_r, cnt_next         : unsigned(dOut'range);  -- error counter

  -- internal signals
  signal   ld           : std_logic;    -- load random number gen with seed value
  signal   cke          : std_logic;    -- clock-enable for random number gen
  signal   rand         : std_logic_vector(dOut'range);  -- random number from generator
  signal   seed         : std_logic_vector(dIn'range);  -- random number starting seed
  constant mask         : std_logic_vector(dOut'range) := "1111111111111111";  -- comparison mask
  constant errthreshold : integer                      := 0;  -- error threshold
  constant addr_mask    : unsigned(addr'range)         := TO_UNSIGNED(16#FF#, addr'length);

begin

  seed <= (others => '1');              -- random number seed is 111...111
--      seed <= TO_UNSIGNED(65535,16);

  -- random number generator module
  u0 : randGen
    generic map(
      DATA_WIDTH => DATA_WIDTH
      )
    port map(
      clk        => clk,                -- input clock
      cke        => cke,                -- clock-enable to control when new random num is computed
      ld         => ld,                 -- load seed control signal
      seed       => seed,               -- random number seed
      rand       => rand                -- random number output from generator
      );

  -- connect internal registers to external busses      
  addr    <= std_logic_vector(addr_r);  -- memory address bus driven by memory address register
--      dOut <= cnt_r;                  -- always output the current random number to the memory
  dOut    <= rand;                      -- always output the current random number to the memory
  err     <= err_r;                     -- output the current memory error status
  errbits <= errbits_r;

  -- memory test controller state machine operations
  combinatorial : process(state_r, err_r, addr_r, dIn, rand, done, errcnt_r, errbits_r, cnt_r)
  begin

    -- default operations (do nothing unless explicitly stated in the following case statement)
    rd           <= NO;                 -- no memory write
    wr           <= NO;                 -- no memory read
    abort        <= NO;
    ld           <= NO;                 -- don't load the random number generator
    cke          <= NO;                 -- don't generate a new random number
    addr_next    <= addr_r;             -- next address is the same as current address
    errcnt_next  <= errcnt_r;
    errbits_next <= errbits_r;
    cnt_next     <= cnt_r;
    err_next     <= err_r;              -- error flag is unchanged
    state_next   <= state_r;            -- no change in memory tester state

    -- **** compute the next state and operations ****
    case state_r is

      when INIT                 =>      -- initialize the memory test controller
        progress     <= "00";           -- indicate the current controller state
        ld           <= YES;            -- load random number seed
        cke          <= YES;            -- enable clocking of rand num gen so seed gets loaded
        cnt_next     <= TO_UNSIGNED(0, cnt_next'length);
        addr_next    <= TO_UNSIGNED(BEG_TEST, addr_next'length);  -- load starting mem address
        err_next     <= NO;             -- clear memory error flag
        errcnt_next  <= TO_UNSIGNED(0, errcnt_next'length);
        errbits_next <= (others => '0');
        state_next   <= LOAD;           -- go to LOAD state and write pattern to memory

      when LOAD =>                      -- load the memory with data from the random number generator
        progress       <= "01";         -- indicate the current controller state
        if done = NO then               -- current write operation is not complete
          wr           <= YES;          -- keep write signal active since memory write is not done
        else                            -- current write operation is complete
          wr           <= NO;           -- release write signal when write op is complete
          if addr_r /= TO_UNSIGNED(END_TEST, addr_r'length) then
                                        -- not at the end of the memory test range yet
            cnt_next   <= cnt_r + 1;
            addr_next  <= addr_r + STEP_SIZE;  -- so increment address
            cke        <= YES;          -- and enable generator clock to get new random num
          else
                                        -- else end of the memory test range has been reached
            abort      <= YES;
            cke        <= YES;          -- enable generator clock and
            ld         <= YES;          -- reload the generator with the seed value
            cnt_next   <= TO_UNSIGNED(0, cnt_next'length);
            addr_next  <= TO_UNSIGNED(BEG_TEST, addr'length);  -- reset to start of test range
            state_next <= COMPARE;      -- go to the COMPARE state and check memory contents
          end if;
        end if;

      when COMPARE =>                   -- re-run the generator and compare it to memory contents
        progress        <= "10";        -- indicate the current controller state
        if done = NO then               -- current read operation is not complete
          rd            <= YES;         -- keep read signal active since memory read is not done
        else                            -- current read operation is complete
          rd            <= NO;          -- release the read signal when read op is complete
          errbits_next  <= errbits_r or ((dIn xor rand) and mask);
-- if (dIn and mask) /= (cnt_r and mask) then  -- compare value from memory to random number
          if (dIn and mask) /= (rand and mask) then  -- compare value from memory to random number
            errcnt_next <= errcnt_r + 1;  -- increment error counter if they don't match
          end if;
          if addr_r = (TO_UNSIGNED(END_TEST-16#FF#, addr_r'length) or addr_mask) then
            abort       <= YES;
            state_next  <= STOP;        -- go to STOP state once entire range has been checked
          end if;
          cnt_next      <= cnt_r + 1;
          addr_next     <= addr_r + STEP_SIZE;  -- increment address to check next memory location
          cke           <= YES;         -- and enable generator clock to get next random num
        end if;

      when others =>                    -- memory test is complete
        if errcnt_r > errthreshold then
          err_next <= YES;
        end if;
        progress   <= "11";             -- indicate the current controller state

    end case;

  end process;


  -- update the registers of the memory tester controller       
  update : process(clk, rst)
  begin
    if rst = YES then
      -- go to starting state and clear error flag when reset occurs
      state_r   <= INIT;
      cnt_r     <= TO_UNSIGNED(0, cnt_r'length);
      errcnt_r  <= TO_UNSIGNED(0, errcnt_r'length);
      errbits_r <= (others => '0');
      err_r     <= NO;
    elsif rising_edge(clk) then
      -- update error flag, address register, and state
      state_r   <= state_next;
      cnt_r     <= cnt_next;
      errcnt_r  <= errcnt_next;
      errbits_r <= errbits_next;
      err_r     <= err_next;
      addr_r    <= addr_next;
    end if;
  end process;

end arch;
