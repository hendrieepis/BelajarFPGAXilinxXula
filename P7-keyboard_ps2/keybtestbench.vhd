
library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity keybtestbench is
end keybtestbench;

architecture behavior of keybtestbench is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component keyboard
    port(
      reset      : in  std_logic;
      clk        : in  std_logic;
      kb_clk     : in  std_logic;
      kb_data    : in  std_logic;
      display    : out std_logic_vector(7 downto 0);
      outClk25Hz : out std_logic
      );
  end component;


  --Inputs
  signal reset   : std_logic := '0';
  signal clk     : std_logic := '0';
  signal kb_clk  : std_logic := '0';
  signal kb_data : std_logic := '0';

  --Outputs
  signal Display    : std_logic_vector(7 downto 0);
  signal ShiftData  : std_logic_vector(7 downto 0);
  signal outClk25Hz : std_logic;

  -- Clock period definitions
  constant clk_period    : time := 20 ns;
  constant kb_clk_period : time := 10 ns;


  -- purpose: keyboard generate pattern
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : keyboard port map (
    reset      => reset,
    clk        => clk,
    kb_clk     => kb_clk,
    kb_data    => kb_data,
    display    => display,
    outClk25Hz => outClk25Hz
    );

  -- Clock process definitions
  clk_process : process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;

  -- Stimulus process
  stim_proc : process
  begin
    -- hold reset state for 100 ns.
     wait for 100 ns;
     keyprint(x"05", kb_data, kb_clk);
    --wait for clk_period*10;
    --keyprint(x"f0", kb_data, kb_clk);

    -- insert stimulus here 

    wait;
  end process;

end;
