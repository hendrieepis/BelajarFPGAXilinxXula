library IEEE, unisim;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use unisim.vcomponents.all;

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_pport_cpld is
  port ( clk  : in  std_logic;
         load : in  std_logic;
         din  : in  std_logic_vector(3 downto 0);
         dout : out std_logic_vector(3 downto 0));
end test_pport_cpld;

architecture Behavioral of test_pport_cpld is
  signal d : std_logic_vector(din'range);
-- signal clk_i,clk_buf: std_logic;
begin
-- u2 : ibuf port map(I => clk, O => clk_i);  -- slow FSM clock comes through
--  u3 : bufg port map(I => clk_i, O => clk_buf);  -- one pin of the parallel port
  process(clk)
  begin
    if rising_edge(clk) then
      if load = '1' then
        d <= din;
      else
        d <= d+1;
      end if;
    end if;
  end process;
  dout    <= d;

end Behavioral;
