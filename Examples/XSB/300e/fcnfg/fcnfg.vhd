--
-- XC9500 CPLD design which controls the configuration of the XSB Spartan2
-- with data from the Flash chip.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fcnfg is
  generic
    (
      ADDR_LEN :    positive := 20      -- number of Flash address bits
      );
  port
    (
      cpld_clk : in std_logic;          -- clock from DS1075 prog. osc.

      -- Flash address and control pins
      pb_a       : out std_logic_vector(ADDR_LEN-1 downto 0);  -- Flash address
      flash_ce_n : out std_logic;       -- Flash chip-enable
      pb_oe_n    : out std_logic;       -- Flash output-enable
      pb_we_n    : out std_logic;       -- Flash write-enable

      -- Spartan2 configuration pins
      fpga_program_n : out std_logic;   -- Spartan2 PROGRAM pin
      fpga_cclk      : out std_logic;   -- Spartan2 config clock
      fpga_cs_n      : out std_logic;   -- Spartan2 config chip-select
      fpga_write_n   : out std_logic;   -- Spartan2 config write-enable
      fpga_init_n    : in  std_logic;   -- Spartan2 config init status
      fpga_bsy       : in  std_logic;   -- Spartan2 config busy status
      fpga_done      : in  std_logic;   -- Spartan2 config done status
      fpga_m         : out std_logic_vector(0 downto 0)  -- Spartan2 config. mode pins   
      );
end fcnfg;

architecture arch of fcnfg is
  constant LO    : std_logic := '0';
  constant HI    : std_logic := '1';
  constant FLOAT : std_logic := 'Z';

  signal clk_cnt         : std_logic_vector(3 downto 0);
  signal cclk            : std_logic;
  signal programb, cs    : std_logic;
  signal addr, next_addr : std_logic_vector(ADDR_LEN-1 downto 0);
  signal poweron_reset   : std_logic;
  signal poweron_cnt     : std_logic_vector(19 downto 0);
  signal button_progb    : std_logic;
begin

  -- set Spartan2 mode to Slave Parallel so it can be configured from Flash
  fpga_m <= "0";

  -- Flash is enabled for reading while Spartan2 is not yet configured
  -- and then the Flash pins float when configuration is done
  pb_oe_n    <= LO when (fpga_done = LO) else FLOAT;
  flash_ce_n <= LO when (fpga_done = LO) else FLOAT;
  pb_we_n    <= HI when (fpga_done = LO) else FLOAT;  -- disable Flash writes

  -- generate configuration clock for Spartan2 from the XSB clock.
  -- The XSB clock should be 24 MHz, so divide by 16
  -- to exceed the access time of the Flash.
  process(cpld_clk)
  begin
    if(cpld_clk'event and cpld_clk = HI) then
      clk_cnt <= clk_cnt + 1;
    end if;
  end process;
  cclk        <= clk_cnt(3);            -- internal configuration clock
  fpga_cclk   <= cclk;                  -- also send config. clock to Spartan2

  -- Apply reset when the power to the XSB Board is first applied.
  -- Remove the power-on reset after the counter reaches 0.
  process(cclk)
  begin
    if(cclk'event and cclk = HI) then
      if(poweron_cnt = 0) then
        poweron_reset <= LO;            -- remove reset when timeout expires
        else
          poweron_cnt <= poweron_cnt - 1;
        poweron_reset <= HI;
      end if;
    end if;
  end process;

  -- initiate Spartan2 configuration by lowering the /PROGRAM pin
  -- during the initial power-on reset and then raising it when
  -- the power-on timeout expires and the manual program control is high
  programb       <= not(poweron_reset);
  fpga_program_n <= programb;

  -- Select the Spartan2 for configuration as long as the /PROGRAM pin
  -- is not held low and the INIT pin is not low.
  process(cclk, programb)
  begin
    if(programb = LO) then
      cs <= LO;
    elsif(cclk'event and cclk = HI) then
      cs <= fpga_init_n;
    end if;
  end process;

  -- Select the Spartan2 for configuration by lowering its chip-select
  -- and write inputs when the internal chip-select is high.  Then
  -- float these pins after the Spartan2 configuration is done.
  fpga_cs_n    <= not(cs) when (fpga_done = LO) else FLOAT;
  fpga_write_n <= not(cs) when (fpga_done = LO) else FLOAT;

  -- increment the Flash address so the next byte of configuration
  -- data is presented to the Spartan2.  Stop incrementing if the
  -- Spartan2 is not selected, signals a config. error (INIT=0), or
  -- is busy.  Reset the address counter to zero whenever the
  -- /PROGRAM pin goes low and a new configuration sequence begins.
  process(cclk)
  begin
    if(cclk'event and cclk = HI) then
      if((cs = HI) and (fpga_init_n = HI) and (fpga_bsy = LO)) then
        addr <= addr + 1;
      elsif(programb = LO) then
        addr <= (others => LO);
      end if;
    end if;
  end process;

  -- pass the Flash address out to the Flash chip.  Float the address
  -- lines once configuration is done.
  pb_a <= addr when (fpga_done = LO) else (others => FLOAT);

end arch;

