--
-- FPGA design which controls the loading of the XSA Flash
-- with data from the PC parallel port.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity fintf is
  generic (
    ADDR_LEN      :       positive := 21  -- number of address bits for Flash
    );
  port (
    clka          : in    std_logic;    -- main clock
    flash_d       : inout std_logic_vector(7 downto 0);  -- Flash data bus
    flash_a       : inout std_logic_vector(ADDR_LEN-1 downto 0);  -- Flash address bus
    flash_ce_n    : inout std_logic;    -- chip-enable for Flash
    flash_oe_n    : out   std_logic;    -- output-enable for Flash
    flash_we_n    : out   std_logic;    -- write-enable for Flash
    flash_reset_n : out   std_logic     -- reset for Flash
    );
end entity;


architecture arch of fintf is

  constant LO  : std_logic := '0';
  constant HI  : std_logic := '1';
  constant NO  : std_logic := '0';
  constant YES : std_logic := '1';

  -- states for the FSM that programs the Flash
  type flash_state_type is
    (
      init_status,                      -- initialize status bits back to PC
      read_flash,                       -- read byte from Flash address
      read_flash_1,
      read_flash_2,
      load_a20,                         -- load address nybble A23-A20
      load_a16,                         -- load address nybble A19-A16, read data nybble D7-D5
      load_a12,                         -- load address nybble A12-A15, read data nybble D4-D2
      load_a8,                          -- load address nybble A8-A11,  read data nybble D1-D0
      load_a4,                          -- load address nybble A4-A7
      load_a0,                          -- load address nybble A0-A4
      load_d4,                          -- load data nybble D4-D7
      load_d0,                          -- load data nybble D0-D3
      write_flash,                      -- write byte to Flash address
      write_flash_1,
      write_flash_2,
      write_flash_3,
      write_flash_4
      );

  -- registers
  signal flash_state_r, flash_state_x : flash_state_type;  -- FSM state register
  signal addr_r, addr_x               : std_logic_vector(23 downto 0);  -- Flash address register
  signal data_r, data_x               : std_logic_vector(flash_d'range);  -- Flash data register
  signal timer_r, timer_x             : integer;
  signal ce_timer_r, ce_timer_x       : integer;
  signal pp_clk_shfreg                : std_logic_vector(2 downto 0);

  signal pp_clk_rising_edge  : std_logic;
  signal pp_clk_falling_edge : std_logic;

  alias pp_status : std_logic_vector(2 downto 0) is flash_a(3 downto 1);  -- FSM status or Flash data back to PC through par. port
  alias pp_reset  : std_logic is flash_a(9);  -- reset from parallel port
  alias pp_clk    : std_logic is flash_a(10);  -- clock from parallel port
  alias pp_nybble : std_logic_vector(3 downto 0) is flash_a(14 downto 11);  -- addr/data nybble from parallel port

  constant NORM              : integer := 1000;
  constant FREQ              : integer := 100;  -- clka frequency in MHz
  constant FLASH_ACCESS_TIME : integer := (120 * FREQ) / NORM;
  constant FLASH_SETUP_TIME  : integer := ( 20 * FREQ) / NORM;
  constant FLASH_WRITE_TIME  : integer := (120 * FREQ) / NORM;
  constant FLASH_HOLD_TIME   : integer := ( 20 * FREQ) / NORM;
  constant CE_ACCESS_TIME    : integer := (100 * FREQ) / NORM;

  -- flag used to make sure FSM gets initialized on startup (should be 0 after config is done)
  signal init_reset_n : std_logic;

begin

  flash_reset_n <= HI;                  -- remove Flash reset so the chip is enabled


  -- this process detects edges in the slow clock from the parallel port
  -- whenever the FPGA is not accessing the Flash.
  process(clka)
  begin
    if rising_edge(clka) then
      pp_clk_shfreg   <= pp_clk & pp_clk_shfreg(pp_clk_shfreg'high downto 1);
    end if;
  end process;
  pp_clk_rising_edge  <= YES when pp_clk_shfreg(1 downto 0) = "10" and ce_timer_r = 0 else NO;
  pp_clk_falling_edge <= YES when pp_clk_shfreg(1 downto 0) = "01" and ce_timer_r = 0 else NO;


  -- this process directs the state transitions of the Flash programming
  -- state machine and sets the control outputs for each state
  process(data_r, addr_r, flash_state_r, timer_r, ce_timer_r, flash_d, pp_nybble, pp_clk_rising_edge, pp_clk_falling_edge)
  begin

    -- set default values for outputs
    flash_ce_n <= HI;                   -- FPGA is not accessing Flash
    flash_oe_n <= 'Z';                  -- release the control, address and data lines
    flash_we_n <= 'Z';
    -- flash_oe_n <= HI;
    -- flash_we_n <= HI;
    flash_a    <= (others => 'Z');
    flash_d    <= (others => 'Z');
    pp_status  <= (others => 'Z');

    -- default updates for address, data and FSM state registers 
    data_x        <= data_r;
    addr_x        <= addr_r;
    flash_state_x <= flash_state_r;

    -- decrement any non-zero timers
    if timer_r /=0 then timer_x       <= timer_r - 1;    else timer_x <= 0; end if;
    if ce_timer_r /=0 then ce_timer_x <= ce_timer_r - 1; else ce_timer_x <= 0; end if;

    -- state transitions
    case flash_state_r is

      -- initialize the status pins from the FSM back to the parallel port
      when init_status =>
        pp_status     <= "000";
        flash_state_x <= read_flash;

        -- read the Flash byte at the address stored in the address register.
        -- start by lowering Flash CE# to enable the Flash and make the CPLD
        --   release any Flash control, address and data lines. 
      when read_flash =>
        flash_ce_n    <= LO;
        flash_state_x <= read_flash_1;

        -- output the address and lower the Flash OE# to start the read.
        -- initialize the timer for the Flash access time.
        -- initialize the CE# timer so that the reset and clock pins from the
        --   parallel port are not checked until a few cycles after the
        --       Flash access is complete.
      when read_flash_1 =>
        flash_ce_n    <= LO;
        flash_oe_n    <= LO;
        flash_we_n    <= HI;
        flash_a       <= addr_r(flash_a'range);
        timer_x       <= FLASH_ACCESS_TIME;
        ce_timer_x    <= FLASH_ACCESS_TIME + CE_ACCESS_TIME;
        flash_state_x <= read_flash_2;

        -- wait until the Flash access time is done and then store the
        -- data from the Flash in the data register.
      when read_flash_2 =>
        flash_ce_n      <= LO;
        flash_oe_n      <= LO;
        flash_we_n      <= HI;
        flash_a         <= addr_r(flash_a'range);
        if timer_r = 0 then
          data_x        <= flash_d(data_x'range);
          flash_state_x <= load_a20;
        end if;

        -- start loading the address for the next Flash operation.
        -- the address is assembled a piece at a time on the rising edge of
        --   the slow clock from the parallel port.
      when load_a20 =>
        pp_status            <= "000";
        addr_x(23 downto 20) <= pp_nybble;
        if pp_clk_rising_edge = YES then
          flash_state_x      <= load_a16;
        end if;

        -- load the next piece of the address and also output the upper
        --   bits of the data from the completed Flash read through the
        --   parallel port.
      when load_a16 =>
        pp_status            <= data_r(7 downto 5);
        addr_x(19 downto 16) <= pp_nybble;
        if pp_clk_rising_edge = YES then
          flash_state_x      <= load_a12;
        end if;

        -- load the next piece of the address and also output the middle
        --   bits of the Flash data.
      when load_a12 =>
        pp_status            <= data_r(4 downto 2);
        addr_x(15 downto 12) <= pp_nybble;
        if pp_clk_rising_edge = YES then
          flash_state_x      <= load_a8;
        end if;

        -- load the next piece of the address and also output the lower
        --   bits of the Flash data.
      when load_a8 =>
        pp_status           <= "0" & data_r(1 downto 0);
        addr_x(11 downto 8) <= pp_nybble;
        if pp_clk_rising_edge = YES then
          flash_state_x     <= load_a4;
        end if;

        -- load the next piece of the address and also output
        --   FSM status information through the parallel port that lets
        --   the PC know the current FSM state.
      when load_a4 =>
        pp_status          <= "001";
        addr_x(7 downto 4) <= pp_nybble;
        if pp_clk_rising_edge = YES then
          flash_state_x    <= load_a0;
        end if;

        -- load the final piece of the address and also output
        --   FSM status information.
      when load_a0 =>
        pp_status          <= "010";
        addr_x(3 downto 0) <= pp_nybble;
        if pp_clk_rising_edge = YES then
          flash_state_x    <= load_d4;
        end if;

        -- load the upper piece of data that is to be written to Flash.
      when load_d4 =>
        pp_status          <= "011";
        data_x(7 downto 4) <= pp_nybble;
        if pp_clk_rising_edge = YES then
          flash_state_x    <= load_d0;
        end if;

        -- load the lower piece of the data on the FALLING edge of the
        --   slow parallel port clock.
      when load_d0 =>
        pp_status          <= "100";
        data_x(3 downto 0) <= pp_nybble;
        if pp_clk_falling_edge = YES then
          flash_state_x    <= write_flash;
        end if;

        -- now use the second half of the slow parallel port clock cycle
        --   to write the data to the Flash.
      when write_flash =>
        pp_status     <= "100";
        flash_ce_n    <= LO;
        timer_x       <= FLASH_SETUP_TIME;
        flash_state_x <= write_flash_1;

        -- enable the Flash and output the address and data, but don't
        --   lower the WE# until the setup time has elapsed.
      when write_flash_1 =>
        flash_ce_n      <= LO;
        flash_oe_n      <= HI;
        flash_we_n      <= HI;
        flash_a         <= addr_r(flash_a'range);
        flash_d         <= data_r(flash_d'range);
        if timer_r = 0 then
          timer_x       <= FLASH_WRITE_TIME;
          flash_state_x <= write_flash_2;
        end if;

        -- now lower the WE# and keep the address and data steady
        --   until the write time has elapsed.
        -- initialize the CE# timer so that the reset and clock pins from the
        --   parallel port are not checked until a few cycles after the
        --       Flash access is complete.
      when write_flash_2 =>
        flash_ce_n      <= LO;
        flash_oe_n      <= HI;
        flash_we_n      <= LO;
        flash_a         <= addr_r(flash_a'range);
        flash_d         <= data_r(flash_d'range);
        if timer_r = 0 then
          timer_x       <= FLASH_HOLD_TIME;
          ce_timer_x    <= FLASH_HOLD_TIME + CE_ACCESS_TIME;
          flash_state_x <= write_flash_3;
        end if;

        -- now raise the WE# and keep the address and data steady
        --   until the hold time has elapsed.
      when write_flash_3 =>
        flash_ce_n      <= LO;
        flash_oe_n      <= HI;
        flash_we_n      <= HI;
        flash_a         <= addr_r(flash_a'range);
        flash_d         <= data_r(flash_d'range);
        if timer_r = 0 then
          flash_state_x <= write_flash_4;
        end if;

        -- once the Flash write operation is complete, wait for the
        --   rising edge of the parallel port clock and go back to
        --   the initial FSM state.
      when write_flash_4 =>
        pp_status       <= "100";
        if pp_clk_rising_edge = YES then
          flash_state_x <= init_status;
        end if;

        -- this state returns the FSM to its initial state
      when others =>
        flash_state_x <= init_status;
        timer_x       <= 0;
        ce_timer_x    <= 0;

    end case;

  end process;


  -- update the FSM state and other registers
  process(clka)
  begin
    if rising_edge(clka) then
      -- reset the FSM if the FPGA has just been configured, or if the FPGA is
      --   no longer accessing the Flash (CE# = 1) and enough time has passed
      --   (CE# timer = 0) so that the reset from the parallel port is valid.
      if init_reset_n = LO or (ce_timer_r = 0 and flash_ce_n = HI and pp_reset = HI) then
        flash_state_r <= init_status;
        timer_r       <= 0;
        ce_timer_r    <= 0;
        init_reset_n  <= HI;
        -- reading the Flash requires the PC program to load an address and then
        -- reset the FSM to get the data from that address when the FSM restarts.
        -- the address and data registers should not be altered by reset because
        -- this will prevent the PC from getting the data from the address that
        -- was loaded prior to the reset.

        -- update the FSM registers if reset is not asserted
        else
          flash_state_r <= flash_state_x;
        timer_r         <= timer_x;
        ce_timer_r      <= ce_timer_x;
        data_r          <= data_x;      -- never alter the data register during reset!!
        addr_r          <= addr_x;      -- never alter the address register during reset!!
      end if;
    end if;

  end process;

end architecture;

