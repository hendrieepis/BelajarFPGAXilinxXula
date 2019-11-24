library ieee;
use ieee.std_logic_1164.all;

entity p3jtag is
  port(
    -- parallel port data and status pins
    ppd : in  std_logic_vector(6 downto 0);
    pps : out std_logic_vector(5 downto 3);

    -- Spartan2E FPGA pins
    S2_tck    : out std_logic;          -- driver to Spartan2E JTAG clock
    S2_tms    : out std_logic;          -- driver to Spartan2E JTAG mode input
    S2_tdi    : out std_logic;          -- driver to Spartan2E JTAG serial data input
    S2_tdo    : in  std_logic;          -- input from Spartan2E JTAG serial data output
    S2_prog_n : out std_logic;          -- driver to Spartan2E /PROGRAM pin
    S2_m      : out std_logic_vector(0 downto 0)  -- Spartan2E config mode pins
    );
end p3jtag;

architecture arch of p3jtag is
  constant NO                : std_logic                    := '0';
  constant YES               : std_logic                    := '1';
  constant LO                : std_logic                    := '0';
  constant HI                : std_logic                    := '1';
  constant SLAVE_SERIAL_MODE : std_logic_vector(0 downto 0) := "1";
begin

  -- the XSB power status is sent back through the parallel port status pin 3
  pps(3) <= HI;                         -- tell the PC that the VCC for the XSB board is OK
  -- the cable is detected by sending data through data pin 6 and returning
  -- it on status pins 5 and 7.  Status pin 7 is used by the JTAG TDO
  -- pin of the XC9500XL CPLD on the XSB Board, so place a shunt at position "xi"
  -- of jumper JP1 to make this connection.
  pps(5) <= ppd(6);

  S2_m      <= SLAVE_SERIAL_MODE;       -- set Spartan2E config mode pins
  S2_prog_n <= HI;                      -- prevent any accidental reconfiguration

  -- drive the Spartan2E JTAG pins from the parallel port when tristate
  -- control pin (parallel port data pin 3) is low.
  S2_tms <= ppd(2) when ppd(3) = LO else 'Z';
  S2_tck <= ppd(1) when ppd(3) = LO else 'Z';
  S2_tdi <= ppd(0) when ppd(3) = LO else 'Z';

  -- the JTAG TDO output is sent back through the status pin
  pps(4) <= S2_tdo when ppd(4) = HI else LO;

end arch;

