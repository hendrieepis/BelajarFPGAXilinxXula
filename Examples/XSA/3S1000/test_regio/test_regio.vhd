library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.common.all;
use work.regio_jtag_pckg.all;
use work.userinstr_jtag_pckg.all;


--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

entity test_regio is
    Port(
	   clk : in std_logic;
		tmp_out : out std_logic
    );
end test_regio;

architecture Behavioral of test_regio is
	signal rd: std_logic;
	signal wr: std_logic;
	signal done: std_logic;
	signal addr: std_logic_vector(3 downto 0);
	signal dOut: std_logic_vector(15 downto 0);
	signal dIn: std_logic_vector(dOut'range);

   signal addr_natural : natural range 0 to 15;
   constant NUM_REGS : integer := 4;
   type reg_file_type is array(0 to NUM_REGS-1) of std_logic_vector(dOut'range);
   signal reg_file : reg_file_type;
begin

u1: regio_jtag
	generic map(
		FPGA_TYPE  => SPARTAN3,
		RPT_WIDTH  => 8,
		ADDR_WIDTH => addr'length,
		DATA_WIDTH => dOut'length
	)
	port map(
      rclk  => clk,
      rrd   => rd,
      rwr   => wr,
      rdone => done,
      rAddr => addr,
      rDin  => dOut,
      rDout => dIn
	);

addr_natural <= CONV_INTEGER(addr);
tmp_out <= rd;

process(clk)
begin
	if rising_edge(clk) then
	   done <= NO;
		if rd = YES then
			dOut <= reg_file(addr_natural);
			done <= YES;
		end if;
		if wr = YES then
			reg_file(addr_natural) <= dIn;
			done <= YES;
		end if;
	end if;
end process;

end Behavioral;
