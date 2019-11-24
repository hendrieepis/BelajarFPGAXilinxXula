library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.common.all;
use work.userinstr_jtag_pckg.all;
use work.i2c_master_pckg.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity i2c_jtag is
  Generic(
    FPGA_TYPE : natural := SPARTAN3;
    CLK_FREQ  : natural := 100_000;
    I2C_FREQ  : natural := 100
  );
  Port(
    clk       : in std_logic;
    ce_n      : out std_logic;
    led       : out std_logic_vector(6 downto 0);
    scl       : inout std_logic;
    sda       : inout std_logic
  );
end i2c_jtag;

architecture Behavioral of i2c_jtag is

  -- counter that generates the initial reset for the SDRAM controller
  constant RESET_DLY  : natural := 10;
  signal reset_cntr   : natural range 0 to 15 := 0;
  signal reset        : std_logic := HI;
  
  -- signals to/from the JTAG BSCAN module
  signal bscan_drck   : std_logic; -- JTAG clock from BSCAN module
  signal bscan_reset  : std_logic; -- true when BSCAN module is reset
  signal bscan_sel    : std_logic; -- true when BSCAN module selected
  signal bscan_shift  : std_logic; -- true when TDI & TDO are shifting data
  signal bscan_update : std_logic; -- BSCAN TAP is in update-dr state
  signal bscan_tdi    : std_logic; -- data received on TDI pin
  signal bscan_tdo    : std_logic; -- scan data sent to TDO pin

  signal do_rw      : std_logic;
  signal rd         : std_logic;
  signal wr         : std_logic;
  signal done       : std_logic;
  signal addr       : std_logic_vector(3 downto 0);
  signal din        : std_logic_vector(7 downto 0);
  signal dout       : std_logic_vector(7 downto 0);

  signal scl_i    : std_logic;
  signal scl_o    : std_logic;
  signal scl_oe_n : std_logic;
  signal sda_i    : std_logic;
  signal sda_o    : std_logic;
  signal sda_oe_n : std_logic;
  
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if reset_cntr < RESET_DLY then
        reset <= HI;
        reset_cntr <= reset_cntr + 1;
      else
        reset <= LO;
      end if;
    end if;
  end process;

  ce_n <= '1';                -- disable Flash RAM

  -- boundary-scan interface to FPGA JTAG port
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
      
--  led_dp <= bscan_sel;        -- light LED decimal-point when BSCAN receives USER1 instr
  
  -- JTAG interface
  u1: userinstr_jtag
    generic map(
      FPGA_TYPE        => SPARTAN3,
      ENABLE_RAM_INTFC => true,
      DATA_WIDTH       => din'length,
      ADDR_WIDTH       => addr'length
      )
    port map(
      clk           => clk,
      bscan_drck    => bscan_drck,
      bscan_reset   => bscan_reset,
      bscan_sel     => bscan_sel,
      bscan_shift   => bscan_shift,
      bscan_update  => bscan_update,
      bscan_tdi     => bscan_tdi,
      bscan_tdo     => bscan_tdo,
      rd            => rd,
      wr            => wr,
      begun         => done,
      done          => done,
      addr          => addr,
      din           => din,
      dout          => dout,
      s             => led,
      test_progress => "11",
      test_failed   => NO
      );

  do_rw <= rd or wr;

  u2: i2c_master_top
    generic map(
      ARST_LVL => HI
      )
    port map(
      wb_clk_i      => clk,
      wb_rst_i      => reset,
      arst_i        => reset,
      wb_adr_i      => unsigned(addr(2 downto 0)),
      wb_dat_i      => dout,
      wb_dat_o      => din,
      wb_we_i       => wr,
      wb_stb_i      => do_rw,
      wb_cyc_i      => HI,
      wb_ack_o      => done,
      wb_inta_o     => open,
      -- i2c lines
      scl_pad_i     => scl_i,
      scl_pad_o     => scl_o,
      scl_padoen_o  => scl_oe_n,
      sda_pad_i     => sda_i,
      sda_pad_o     => sda_o,
      sda_padoen_o  => sda_oe_n
      );
      
    scl <= scl_o when scl_oe_n=LO else 'Z';
    sda <= sda_o when sda_oe_n=LO else 'Z';
    scl_i <= scl;
    sda_i <= sda;

end Behavioral;
