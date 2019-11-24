library IEEE, unisim;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use unisim.vcomponents.all;
use WORK.common.all;

entity ether_intfc is
  port(
    -- I/O
    pp_d        : in    std_logic_vector(7 downto 0);  -- parallel port data
    pp_s        : out   std_logic_vector(6 downto 3);  -- parallel port status
    pb_d        : inout std_logic_vector(15 downto 0);
    pb_a        : out   std_logic_vector(4 downto 0);
    pb_wr_n     : out   std_logic;
    pb_rd_n     : out   std_logic;
    ether_cs_n  : out   std_logic;
    ether_bhe_n : out   std_logic;
    ether_aen   : out   std_logic;
    s           : out   std_logic_vector(6 downto 0)
    );
end entity;

architecture arch of ether_intfc is

  -- states for FSM that gets address and data from PC parallel port and
  -- then reads/writes the ethernet chip
  type download_state_type is
    (
      load_a20,                         -- load address nybble A23-A20
      load_a16,                         -- load address nybble A19-A16
      load_a12,                         -- load address nybble A12-A15
      load_a8,                          -- load address nybble A8-A11
      load_a4,                          -- load address nybble A4-A7
      load_a0,                          -- load address nybble A0-A4
			read_reg,
			read_d12,
			read_d8,
			read_d4,
			read_d0,
      load_d12,                         -- load data nybble D15-D12
      load_d8,                          -- load data nybble D11-D8
      load_d4,                          -- load data nybble D7-D4
      load_d0,                          -- load data nybble D3-D0
			write_reg
      );
  signal download_state_r, download_state_x : download_state_type;

  -- address register that is loaded by nybbles from parallel port
  signal addr_r, addr_x : std_logic_vector(23 downto 0);
  -- data register that is loaded by nybbles from parallel port
  signal data_out_r, data_out_x : std_logic_vector(15 downto 0);
  signal data_in_r, data_in_x : std_logic_vector(15 downto 0);
  -- read, write and reset signals synchronized to SDRAM clock

  signal reset        : std_logic;      -- FSM reset from parallel port
  signal raw_clk, clk : std_logic;      -- slow clock from parallel port
  signal d            : std_logic_vector(3 downto 0);  -- nybble from parallel port
  signal status       : std_logic_vector(3 downto 0);  -- FSM status
	signal read : std_logic;

begin

  -- connect signals from the parallel port to the FSM
  u1 : ibuf port map(I => pp_d(1), O => raw_clk);  -- slow FSM clock comes through
  u2 : bufg port map(I => raw_clk, O => clk);  -- one pin of the parallel port
  reset            <= pp_d(0);          -- FSM reset
  d                <= pp_d(5 downto 2);  -- data nybble that carries address/data for SDRAM ops
	read <= pp_d(6);
  pp_s(6 downto 3) <= status;           -- FSM status info back to PC


  -- FSM that gathers address and data from the PC on write operations to SDRAM and
  -- passes data from SDRAM back to PC on read operations.
  process(addr_r, data_out_r, data_in_r, d, download_state_r, clk)
  begin
    -- set default signal values to prevent implied latches
    ether_bhe_n              <= HI;
    ether_aen                <= HI;
    ether_cs_n               <= LO;
    pb_rd_n                  <= HI;
    pb_wr_n                  <= HI;
    pb_d                     <= (others => 'Z');
    pb_a                     <= addr_r(pb_a'range);
    status                   <= "1111";
    s                        <= "0000000";
    -- reload registers with their current contents
    addr_x                   <= addr_r;  -- address register
    data_out_x               <= data_out_r;  -- data register
    data_in_x                <= data_in_r;  -- data register
    case download_state_r is
      -- first state (reset brings us here)
      when load_a20                     =>
        -- MSNybble of address register loaded from parallel port
        addr_x(23 downto 20) <= d(3 downto 0);
        download_state_x     <= load_a16;  -- go to next state
        status               <= "0000";  -- output state on status pins
        s                    <= "0000001";  -- indicate current state on LEDs
      when load_a16                     =>
        -- next nybble of address register loaded from parallel port
        addr_x(19 downto 16) <= d(3 downto 0);
        download_state_x     <= load_a12;  -- go to next state
        status               <= "0001";  -- pass MSNybble of RAM data back through the status pins
        s                    <= "0000010";  -- indicate current state on LEDs
      when load_a12                     =>
        -- next nybble of address register loaded from parallel port
        addr_x(15 downto 12) <= d(3 downto 0);
        download_state_x     <= load_a8;  -- go to next state
        status               <= "0010";  -- pass next nybble of RAM data back through the status pins
        s                    <= "0000100";  -- indicate current state on LEDs
      when load_a8                      =>
        -- next nybble of address register loaded from parallel port
        addr_x(11 downto 8)  <= d(3 downto 0);
        download_state_x     <= load_a4;  -- go to next state
        status               <= "0011";  -- pass next nybble of RAM data back through the status pins
        s                    <= "0001000";  -- indicate current state on LEDs
      when load_a4                      =>
        -- next nybble of address register loaded from parallel port
        addr_x(7 downto 4)   <= d(3 downto 0);
        download_state_x     <= load_a0;  -- go to next state
        status               <= "0100";  -- pass LSNybble of RAM data back through the status pins
        s                    <= "0010000";  -- indicate current state on LEDs
      when load_a0                      =>
        -- next nybble of address register loaded from parallel port
        addr_x(3 downto 0)   <= d(3 downto 0);
				if read=YES then
					download_state_x <= read_reg;
				else
					download_state_x <= load_d12;
				end if;
        status               <= "0101";  -- output state on status pins
        s                    <= "0100000";  -- indicate current state on LEDs
			when read_reg =>
        pb_rd_n              <= LO;    -- read ethernet chip in second half of cycle
				data_in_x <= pb_d;
				download_state_x <= read_d12;
				status <= "0110";
				s <= "1000000";
			when read_d12 =>
				download_state_x <= read_d8;
				status <= data_in_r(15 downto 12);
				s <= "0000001";
			when read_d8 =>
				download_state_x <= read_d4;
				status <= data_in_r(11 downto 8);
				s <= "0000010";
			when read_d4 =>
				download_state_x <= read_d0;
				status <= data_in_r(7 downto 4);
				s <= "0000100";
			when read_d0 =>
				download_state_x <= load_a20;
				status <= data_in_r(3 downto 0);
				s <= "0001000";
      when load_d12                     =>
        -- data register loaded with MSNybble of data from parallel port
        data_out_x(15 downto 12) <= d;
        download_state_x     <= load_d8;  -- go to next state
        status               <= "0110";  -- output state on status pins
        s                    <= "1000000";  -- indicate current state on LEDs
      when load_d8                      =>
        -- data register loaded with MSNybble of data from parallel port
        data_out_x(11 downto 8)  <= d;
        download_state_x     <= load_d4;  -- go to next state
        status               <= "0111";  -- output state on status pins
        s                    <= "1000001";  -- indicate current state on LEDs
      when load_d4                      =>
        -- data register loaded with MSNybble of data from parallel port
        data_out_x(7 downto 4)   <= d;
        download_state_x     <= load_d0;  -- go to next state
        status               <= "1000";  -- output state on status pins
        s                    <= "1000010";  -- indicate current state on LEDs
      when load_d0                      =>
        -- data register loaded with MSNybble of data from parallel port
        data_out_x(3 downto 0)   <= d;
        download_state_x     <= write_reg;  -- go to next state
        status               <= "1001";  -- output state on status pins
        s                    <= "1000100";  -- indicate current state on LEDs
			when write_reg =>
				pb_d <= data_out_r;
				pb_wr_n <= not clk;
				download_state_x <= load_a20;
				status <= "1010";
				s <= "1001000";
      when others                       =>
        -- erroneous state so return to reset state
        download_state_x     <= load_a20;
    end case;
  end process;

  process(reset, clk)
  begin
    if reset = YES then
      -- asynchronous reset
      download_state_r <= load_a20;        -- reset state machine to start
      data_out_r       <= (others => LO);  -- clear data register
      -- DO NOT CLEAR THE ADDRESS REGISTER!!  We use the reset signal
      -- during RAM upload operations to reset the state machine, but
      -- we need to retain the RAM address for the read operation.
    elsif rising_edge(clk) then
      -- update registers on the rising clock edge
      download_state_r <= download_state_x;
      addr_r           <= addr_x;
      data_out_r       <= data_out_x;
			data_in_r <= data_in_x;
    end if;
  end process;

end architecture;
