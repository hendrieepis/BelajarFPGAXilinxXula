library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity test_bus is
  port(
    fpga_init_n : out   std_logic;      -- CPLD interface chip-select
    sdram_clk   : in    std_logic;      -- main clock input from external clock source
    sdram_cke   : out   std_logic;      -- SDRAM clock-enable
    sdram_ce_n  : out   std_logic;      -- SDRAM chip-select
    sdram_ras_n : out   std_logic;      -- SDRAM RAS
    sdram_cas_n : out   std_logic;      -- SDRAM CAS
    sdram_we_n  : out   std_logic;      -- SDRAM write-enable
    pb_a        : out   std_logic_vector(19 downto 0);  -- SDRAM bank-address and address bus
    pb_d        : inout std_logic_vector(15 downto 0);  -- SDRAM data bus
    pb_ub_n     : out   std_logic;      -- SDRAM upper databus byte enable
    pb_lb_n     : out   std_logic       -- SDRAM lower databus byte enable
    );
end entity;

architecture arch of test_bus is
  signal   rst_i           : std_logic;  -- internal reset signal
  signal   rstCnt          : natural range 0 to 511;  -- reset timer
  signal   divCnt          : std_logic_vector(20 downto 0);  -- clock divider
	signal   shiftReg_r, shiftReg_x : std_logic_vector(37 downto 0);
begin

  fpga_init_n <= '1';                   -- disable CPLD interface

  process(sdram_clk)
  begin
    if rising_edge(sdram_clk) then
      if rstCnt /= 100 then
        rst_i   <= '1';
        rstCnt  <= rstCnt + 1;
      else
        rst_i   <= '0';  -- remove reset once counter reaches its threshold
      end if;
    end if;
  end process;

  process(sdram_clk)
  begin
    if rising_edge(sdram_clk) then
      divCnt <= divCnt+1;
    end if;
  end process;

  shiftReg_x <= shiftReg_r(0) & shiftReg_r(shiftReg_r'high downto 1) when rst_i='0' else
	              "11111111111111111111111111111111111110";

	process(sdram_clk)
	begin
	  if rising_edge(sdram_clk) then
		  if divCnt(5 downto 0)="111111" then
				shiftReg_r <= shiftReg_x;
      end if;
    end if;
  end process;

  pb_d <= shiftReg_r(15 downto 0);
	pb_a(14 downto 0) <= shiftReg_r(30 downto 16);
	sdram_cke <= shiftReg_r(31);
	sdram_ce_n <= shiftReg_r(32);
	sdram_cas_n <= shiftReg_r(33);
	sdram_ras_n <= shiftReg_r(34);
	sdram_we_n <= shiftReg_r(35);
	pb_ub_n <= shiftReg_r(36);
	pb_lb_n <= shiftReg_r(37);

end architecture;
