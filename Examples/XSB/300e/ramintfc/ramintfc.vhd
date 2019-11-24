library ieee, unisim;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use unisim.vcomponents.all;

entity ramintfc is
  generic
    (
      ADDR_LEN     :       positive := 28  -- number of address bits
      );
  port
    (
      pb_d         : inout std_logic_vector(15 downto 0);  -- Pbus data
      pb_a         : inout std_logic_vector(19 downto 0);  -- PBus address
      pb_oe_n      : out   std_logic;   -- PBus output-enable
      pb_we_n      : out   std_logic;   -- PBus write-enable
      pb_ub_n      : out   std_logic;   -- PBus upper-byte enable
      pb_lb_n      : out   std_logic;   -- PBus lower-byte enable
      ram_ce_n     : out   std_logic;   -- RAM chip-enable
      fpga_init_n  : out   std_logic;   -- CPLD chip-select
      fpga_write_n : in    std_logic;   -- state machine reset
      fpga_cs_n    : in    std_logic    -- upload/download clock
      );
end ramintfc;

-- This design performs two functions:
-- 1) downloading of data bytes into the XSB Board peripheral bus devices.
-- 2) uploading of data bytes from the XSB Board peripheral bus devices.
--
-- The state machine has eleven states. Seven are used to download a 28-bit address
-- one nybble at a time into an address register. The other four states are used
-- to download 16-bit data one nybble at a time and increment the address
-- register. The state machine stays in these four states so data bytes can
-- be loaded into the devices using only four clock cycles. The reset input
-- is used to move back to the first state so a new base address can be loaded
-- into the address register.
--
-- Only the first five states are used to upload the RAM data. The RAM
-- address is loaded into the circuit during these five cycles. The
-- most significant to least significant nybble of the RAM are presented
-- on four of the parallel port status pins during states two thru five,
-- respectively. The address for the RAM was loaded during the previous
-- five cycles.

architecture arch of ramintfc is
  type download_state_type is
    (
      -- download address four bits at a time
      dwnld_a3_a0,
      dwnld_a7_a4,
      dwnld_a11_a8,
      dwnld_a15_a12,
      dwnld_a19_a16,
      dwnld_a23_a20,
      dwnld_a27_a24,
      -- read or write the device on the PBus
      do_read,
      do_write,
      -- upload data three bits at a time 
      upld_d2_d0,
      upld_d5_d3,
      upld_d8_d6,
      upld_d11_d9,
      upld_d14_d12,
      upld_d15,
      -- download data four bits at a time
      dwnld_d3_d0,
      dwnld_d7_d4,
      dwnld_d11_d8,
      dwnld_d15_d12
      );
  signal download_state, next_download_state :    download_state_type;
  signal addr_reg, next_addr_reg             :    std_logic_vector(ADDR_LEN-1 downto 0);
  signal data_reg, next_data_reg             :    std_logic_vector(15 downto 0);
  signal clk, clk_buf                        :    std_logic;
  component ibuf port(i                      : in std_logic; o : out std_logic); end component;
  component bufg port(i                      : in std_logic; o : out std_logic); end component;
  alias up_port                              :    std_logic_vector(2 downto 0) is pb_a(5 downto 3);
  alias down_port                            :    std_logic_vector(3 downto 0) is pb_d(5 downto 2);
  alias reset                                :    std_logic is fpga_write_n;
  alias clk_in                               :    std_logic is fpga_cs_n;
  alias cpld_ce_n                            :    std_logic is fpga_init_n;
begin

  -- transfer input clock onto internal clock network
  u0 : ibuf port map(i => clk_in, o => clk_buf);
  u1 : bufg port map(i => clk_buf, o => clk);

  process(down_port, addr_reg, data_reg, pb_d, reset, download_state, clk_buf)
  begin
    -- set default signal values to prevent implied latches
    cpld_ce_n                       <= '0';
    ram_ce_n                        <= '1';
    pb_oe_n                         <= '1';
    pb_we_n                         <= '1';
    pb_ub_n                         <= '0';
    pb_lb_n                         <= '0';
    pb_a                            <= addr_reg(pb_a'range);
    pb_a(2 downto 0)                <= "010";
    pb_d                            <= (others => 'Z');
    next_addr_reg                   <= addr_reg;  -- address register
    next_data_reg                   <= data_reg;  -- data register
    case download_state is
      -- first state (reset brings us here)
      when dwnld_a3_a0                         =>
        next_addr_reg(3 downto 0)   <= down_port;  -- store this piece of the address
        next_download_state         <= dwnld_a7_a4;  -- go to next state
        up_port                     <= "000";  -- output status info
      when dwnld_a7_a4                         =>
        next_addr_reg(7 downto 4)   <= down_port;  -- store this piece of the address
        next_download_state         <= dwnld_a11_a8;  -- go to next state
        up_port                     <= "001";  -- output status info
      when dwnld_a11_a8                        =>
        next_addr_reg(11 downto 8)  <= down_port;  -- store this piece of the address
        next_download_state         <= dwnld_a15_a12;  -- go to next state
        up_port                     <= "010";  -- output status info
      when dwnld_a15_a12                       =>
        next_addr_reg(15 downto 12) <= down_port;  -- store this piece of the address
        next_download_state         <= dwnld_a19_a16;  -- go to next state
        up_port                     <= "011";  -- output status info
      when dwnld_a19_a16                       =>
        next_addr_reg(19 downto 16) <= down_port;  -- store this piece of the address
        next_download_state         <= dwnld_a23_a20;  -- go to next state
        up_port                     <= "100";  -- output status info
      when dwnld_a23_a20                       =>
        next_addr_reg(23 downto 20) <= down_port;  -- store this piece of the address
        next_download_state         <= dwnld_a27_a24;  -- go to next state
        up_port                     <= "101";  -- output status info
      when dwnld_a27_a24                       =>
        next_addr_reg(27 downto 24) <= down_port;  -- store this piece of the address
        if(down_port(3) = '0') then
          next_download_state       <= do_read;
        else
          next_download_state       <= dwnld_d3_d0;
        end if;
        up_port                     <= "110";  -- output status info
      when do_read                             =>
        cpld_ce_n                   <= '1';  -- disable CPLD so PBus is free
        -- enable RAM and its outputs so we can read RAM data
        ram_ce_n                    <= '0';
        pb_oe_n                     <= '0';
        pb_ub_n                     <= '0';
        pb_lb_n                     <= '0';
        pb_a                        <= addr_reg(pb_a'range);
        next_data_reg               <= pb_d;  -- store data from PBus device
        next_addr_reg               <= addr_reg + 1;  -- inc. address for next read op
        next_download_state         <= upld_d2_d0;
      when upld_d2_d0                          =>
        up_port                     <= data_reg(2 downto 0);
        next_download_state         <= upld_d5_d3;
      when upld_d5_d3                          =>
        up_port                     <= data_reg(5 downto 3);
        next_download_state         <= upld_d8_d6;
      when upld_d8_d6                          =>
        up_port                     <= data_reg(8 downto 6);
        next_download_state         <= upld_d11_d9;
      when upld_d11_d9                         =>
        up_port                     <= data_reg(11 downto 9);
        next_download_state         <= upld_d14_d12;
      when upld_d14_d12                        =>
        up_port                     <= data_reg(14 downto 12);
        next_download_state         <= upld_d15;
      when upld_d15                            =>
        up_port                     <= "00" & data_reg(15);
        next_download_state         <= do_read;
      when dwnld_d3_d0                         =>
        next_data_reg(3 downto 0)   <= down_port;  -- store this piece of the data
        next_download_state         <= dwnld_d7_d4;  -- go to next state
        up_port                     <= "101";  -- output status info
      when dwnld_d7_d4                         =>
        next_data_reg(7 downto 4)   <= down_port;  -- store this piece of the data
        next_download_state         <= dwnld_d11_d8;  -- go to next state
        up_port                     <= "100";  -- output status info
      when dwnld_d11_d8                        =>
        next_data_reg(11 downto 8)  <= down_port;  -- store this piece of the data
        next_download_state         <= dwnld_d15_d12;  -- go to next state
        up_port                     <= "011";  -- output status info
      when dwnld_d15_d12                       =>
        next_data_reg(15 downto 12) <= down_port;  -- store this piece of the data
        next_download_state         <= do_write;  -- go to next state
        up_port                     <= "010";  -- output status info
      when do_write                            =>
        cpld_ce_n                   <= '1';  -- disable CPLD so PBus is free
        -- enable RAM so we can write data to RAM
        ram_ce_n                    <= '0';
        pb_we_n                     <= clk_buf;  -- write occurs in second half of cycle
        pb_d                        <= data_reg;
        pb_ub_n                     <= '0';
        pb_lb_n                     <= '0';
        pb_a                        <= addr_reg(pb_a'range);
        next_addr_reg               <= addr_reg + 1;  -- inc. address for next write op
        next_download_state         <= dwnld_d3_d0;
      when others                              =>
        next_download_state         <= dwnld_a3_a0;
        up_port                     <= "111";
    end case;
  end process;

  process(reset, clk)
  begin
    if (reset = '1') then
      -- asynchronous reset
      download_state <= dwnld_a3_a0;    -- reset state machine to start
    elsif (clk'event and clk = '1') then
      -- update registers on the rising clock edge
      download_state <= next_download_state;
      addr_reg       <= next_addr_reg;
      data_reg       <= next_data_reg;
    end if;
  end process;

end arch;
