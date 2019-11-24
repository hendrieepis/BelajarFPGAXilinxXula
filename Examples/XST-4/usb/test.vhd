--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:55:53 09/14/2010
-- Design Name:   
-- Module Name:   C:/xesscorp/PRODUCTS/BITSTREAMS/XST-4/usb/test.vhd
-- Project Name:  usb
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: usb
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behavior of test is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component usb
    port(
      clk           : in    std_logic;
      reset_n       : in    std_logic;  -- active-low reset input
      dio           : inout std_logic_vector (7 downto 0);
      dirout        : out   std_logic;
      flush         : out   std_logic;
      hshkout       : out   std_logic;
      hshkin        : in    std_logic;
      status        : in    std_logic_vector (1 downto 0);
      ethernet_cs_n : out   std_logic   -- ethernet chip-enable
      );
  end component;


  --Inputs
  signal clk     : std_logic                    := '0';
  signal reset_n : std_logic                    := '1';
  signal hshkin  : std_logic                    := '0';
  signal status  : std_logic_vector(1 downto 0) := (others => '0');

  --BiDirs
  signal dio : std_logic_vector(7 downto 0);

  --Outputs
  signal dirout  : std_logic;
  signal flush   : std_logic;
  signal hshkout : std_logic;

  -- Clock period definitions
  constant clk_period : time := 10 ns;

  signal datareg : std_logic_vector(dio'range) := (others => '0');
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : usb port map (
    clk     => clk,
    reset_n => reset_n,
    dio     => dio,
    dirout  => dirout,
    flush   => flush,
    hshkout => hshkout,
    hshkin  => hshkin,
    status  => status
    );

  -- Clock process definitions
  clk_process : process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if dirout = '1' and hshkout = '1' then
        datareg <= dio;
      end if;
      hshkin <= hshkout;
    end if;
  end process;

  dio <= datareg when hshkout = '1' and dirout = '0' else (others => 'Z');


  -- Stimulus process
  stim_proc : process
  begin
    reset_n <= '1';
    wait for clk_period*50;
    reset_n <= '0';
	wait for clk_period;
	reset_n <= '1';
    wait;
  end process;

end;
