--------------------------------------------------------------------
-- Company       : XESS Corp.
-- Engineer      : Dave Vanden Bout
-- Creation Date : 05/30/2006
-- Copyright     : 2006, XESS Corp
-- Tool Versions : WebPACK 6.3.03i
--
-- Description:
--    Switch debouncer.
--
-- Revision:
--    1.0.0
--
-- Additional Comments:
--    1.0.0:
--        Initial release.
--
-- License:
--    This code can be freely distributed and modified as long as
--    this header is not removed.
--------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

package debounce_pckg is

  component debounce
    generic(
      DEBOUNCE_CNT :     natural := 1000
      );
    port(
      clk          : in  std_logic;
      sig_in       : in  std_logic;
      sig_out      : out std_logic
      );
  end component;

end package debounce_pckg;


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity debounce is
  generic(
    DEBOUNCE_CNT :     natural := 1000
    );
  port(
    clk          : in  std_logic;
    sig_in       : in  std_logic;
    sig_out      : out std_logic
    );
end debounce;

architecture Behavioral of debounce is
  signal debounce_cntr : natural range DEBOUNCE_CNT downto 0;
  signal prev_sig_in   : std_logic;
begin

  process(clk, debounce_cntr, sig_in, prev_sig_in)
  begin
    if rising_edge(clk) then
      if sig_in = prev_sig_in then
        if debounce_cntr = 0 then
          sig_out       <= sig_in;
        else
          debounce_cntr <= debounce_cntr - 1;
        end if;
      else
        debounce_cntr   <= DEBOUNCE_CNT;
        prev_sig_in     <= sig_in;
      end if;
    end if;
  end process;

end Behavioral;
