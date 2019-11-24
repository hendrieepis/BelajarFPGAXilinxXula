library IEEE;
use IEEE.std_logic_1164.all;

package test_dualport_core_pckg is
  component test_dualport_core
    generic(
      FREQ        :       natural := 50_000;  -- frequency of operation in KHz
      PIPE_EN     :       boolean := true;  -- enable fast, pipelined SDRAM operation
      DATA_WIDTH  :       natural := 16;  -- SDRAM data width
      SADDR_WIDTH :       natural := 13;  -- SDRAM row/col address width
      NROWS       :       natural := 4096;  -- number of rows in the SDRAM
      NCOLS       :       natural := 256;  -- number of columns in each SDRAM row
      BEG_ADDR    :       natural := 16#00_0000#;  -- beginning SDRAM address
      END_ADDR    :       natural := 16#3F_FFFF#;  -- ending SDRAM address
      BEG_TEST_LOW  :       natural := 16#00_0000#;  -- beginning test range address
      END_TEST_LOW  :       natural := 16#1F_FFFF#;  -- ending test range address
      BEG_TEST_HIGH :       natural := 16#20_0000#;  -- beginning test range address
      END_TEST_HIGH :       natural := 16#3F_FFFF#  -- ending test range address
      );
    port(
      button      : in    std_logic;      -- active-low pushbutton input
      clk         : in    std_logic;      -- main clock input from external clock source
      sclkfb      : in    std_logic;      -- feedback SDRAM clock with PCB delays
      sclk        : out   std_logic;      -- clock to SDRAM
      cke         : out   std_logic;      -- SDRAM clock-enable
      cs_n        : out   std_logic;      -- SDRAM chip-select
      ras_n       : out   std_logic;      -- SDRAM RAS
      cas_n       : out   std_logic;      -- SDRAM CAS
      we_n        : out   std_logic;      -- SDRAM write-enable
      ba          : out   std_logic_vector(1 downto 0);  -- SDRAM bank-address
      sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
      sData       : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
      dqmh        : out   std_logic;      -- SDRAM DQMH
      dqml        : out   std_logic;      -- SDRAM DQML
      led         : out   std_logic_vector(6 downto 0);  -- 7-segment LED
      heartBeat   : out   std_logic       -- heartbeat status (usually sent to parallel port status pin)
      );
  end component test_dualport_core;
end package test_dualport_core_pckg;




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.common.all;
use WORK.mem.all;
use WORK.xsasdram.all;
use WORK.sdram.all;


entity test_dualport_core is
  generic(
    FREQ        :       natural := 50_000;  -- frequency of operation in KHz
    PIPE_EN     :       boolean := true;  -- enable fast, pipelined SDRAM operation
    DATA_WIDTH  :       natural := 16;  -- SDRAM data width
    SADDR_WIDTH :       natural := 13;  -- SDRAM row/col address width
    NROWS       :       natural := 4096;  -- number of rows in the SDRAM
    NCOLS       :       natural := 256;  -- number of columns in each SDRAM row
    BEG_ADDR    :       natural := 16#00_0000#;  -- beginning SDRAM address
    END_ADDR    :       natural := 16#3F_FFFF#;  -- ending SDRAM address
    BEG_TEST_LOW  :       natural := 16#00_0000#;  -- beginning test range address
    END_TEST_LOW  :       natural := 16#1F_FFFF#;  -- ending test range address
    BEG_TEST_HIGH :       natural := 16#20_0000#;  -- beginning test range address
    END_TEST_HIGH :       natural := 16#3F_FFFF#  -- ending test range address
    );
  port(
    button      : in    std_logic;      -- active-low pushbutton input
    clk         : in    std_logic;      -- main clock input from external clock source
    sclkfb      : in    std_logic;      -- feedback SDRAM clock with PCB delays
    sclk        : out   std_logic;      -- clock to SDRAM
    cke         : out   std_logic;      -- SDRAM clock-enable
    cs_n        : out   std_logic;      -- SDRAM chip-select
    ras_n       : out   std_logic;      -- SDRAM RAS
    cas_n       : out   std_logic;      -- SDRAM CAS
    we_n        : out   std_logic;      -- SDRAM write-enable
    ba          : out   std_logic_vector( 1 downto 0);  -- SDRAM bank-address
    sAddr       : out   std_logic_vector(SADDR_WIDTH-1 downto 0);  -- SDRAM address bus
    sData       : inout std_logic_vector(DATA_WIDTH-1 downto 0);  -- data bus to/from SDRAM
    dqmh        : out   std_logic;      -- SDRAM DQMH
    dqml        : out   std_logic;      -- SDRAM DQML
    led         : out   std_logic_vector(6 downto 0);  -- 7-segment LED
    heartBeat   : out   std_logic       -- heartbeat status (usually sent to parallel port status pin)
    );
end entity;

architecture arch of test_dualport_core is
  constant HADDR_WIDTH : natural := log2(END_ADDR-BEG_ADDR+1);
  signal   rst_i       : std_logic;     -- internal reset signal
  signal   clk_i       : std_logic;     -- internal master clock signal
  signal   clk_b       : std_logic;     -- buffered input (non-DLL) clock
  signal   lock        : std_logic;     -- SDRAM clock DLL lock indicator
  signal   dataIn      : std_logic_vector(DATA_WIDTH-1 downto 0);  -- input databus from SDRAM
  signal   dataOut     : std_logic_vector(DATA_WIDTH-1 downto 0);  -- output databus to SDRAM
  signal   divCnt      : std_logic_vector(22 downto 0);  -- clock divider
  signal   syncButton   : std_logic_vector(1 downto 0);

  signal   begun0       : std_logic;     -- SDRAM operation started indicator
  signal   earlyBegun0  : std_logic;     -- SDRAM operation started indicator
  signal   rdPending0   : std_logic;
  signal   done0        : std_logic;     -- SDRAM operation complete indicator
  signal   rdDone0      : std_logic;     -- SDRAM operation complete indicator
  signal   hAddr0       : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host address bus
  signal   hDIn0        : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal   hDOut0       : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal   rd0          : std_logic;     -- host-side read control signal
  signal   wr0          : std_logic;     -- host-side write control signal
  signal   progress0    : std_logic_vector(1 downto 0);  -- test progress indicator
  signal   err0         : std_logic;     -- test error flag

  signal   begun1       : std_logic;     -- SDRAM operation started indicator
  signal   earlyBegun1  : std_logic;     -- SDRAM operation started indicator
  signal   rdPending1   : std_logic;
  signal   done1        : std_logic;     -- SDRAM operation complete indicator
  signal   rdDone1      : std_logic;     -- SDRAM operation complete indicator
  signal   hAddr1       : std_logic_vector(HADDR_WIDTH-1 downto 0);  -- host address bus
  signal   hDIn1        : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data to SDRAM
  signal   hDOut1       : std_logic_vector(DATA_WIDTH-1 downto 0);  -- host-side data from SDRAM
  signal   rd1          : std_logic;     -- host-side read control signal
  signal   wr1          : std_logic;     -- host-side write control signal
  signal   progress1    : std_logic_vector(1 downto 0);  -- test progress indicator
  signal   err1         : std_logic;     -- test error flag

  signal   mrst         : std_logic;    
  signal   mbegun       : std_logic;    
  signal   mearlyBegun  : std_logic;    
  signal   mrdPending   : std_logic;
  signal   mdone        : std_logic;    
  signal   mrdDone      : std_logic;    
  signal   mhAddr       : std_logic_vector(HADDR_WIDTH-1 downto 0);
  signal   mhDIn        : std_logic_vector(DATA_WIDTH-1 downto 0); 
  signal   mhDOut       : std_logic_vector(DATA_WIDTH-1 downto 0); 
  signal   mstatus      : std_logic_vector(3 downto 0); 
  signal   mrd          : std_logic;     
  signal   mwr          : std_logic;     

  attribute INIT          : string;
  attribute INIT of rst_i : signal is "1";
begin

  -- internal reset flag is set active by config. bitstream
  -- and then gets reset after clocks start.
  process(clk_b)
  begin
    if(clk_b'event and clk_b = '1') then
      if lock = NO then
        rst_i <= YES;                   -- keep in reset until DLLs start up and lock
      else
        rst_i <= NO;                    -- release reset once DLLs lock
      end if;
    end if;
  end process;

  -- synchronize the pushbutton to the main clock
  process(clk_b)
  begin
    if(clk_b'event and clk_b = '1') then
      syncButton <= not(button) & syncButton(syncButton'high downto 1);
    end if;
  end process;

  -- generic memory tester module
  gen_fast_memtest : if PIPE_EN generate
    fast_u0_low        : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn0'length,
        ADDR_WIDTH => hAddr0'length,
        BEG_TEST   => BEG_TEST_LOW,
        END_TEST   => END_TEST_LOW
        )
      port map(
        clk        => clk_i,             -- master internal clock
        rst        => rst_i,             -- reset
        doAgain    => syncButton(0),     -- re-do the memory test
        begun      => earlyBegun0,       -- SDRAM controller operation started
        done       => rdDone0,           -- SDRAM controller operation complete
        dIn        => hDOut0,            -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending0,        -- tell the memory tester if the SDRAM has pending reads
        rd         => rd0,               -- host-side SDRAM read control from memory tester
        wr         => wr0,               -- host-side SDRAM write control from memory tester
        addr       => hAddr0,            -- host-side address from memory tester
        dOut       => hDIn0,             -- host-side data to SDRAM from memory tester
        progress   => progress0,         -- current phase of memory test
        err        => err0               -- memory test error flag
        );
    fast_u0_high       : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn0'length,
        ADDR_WIDTH => hAddr0'length,
        BEG_TEST   => BEG_TEST_HIGH,
        END_TEST   => END_TEST_HIGH
        )
      port map(
        clk        => clk_i,             -- master internal clock
        rst        => rst_i,             -- reset
        doAgain    => syncButton(0),     -- re-do the memory test
        begun      => earlyBegun1,       -- SDRAM controller operation started
        done       => rdDone1,           -- SDRAM controller operation complete
        dIn        => hDOut1,            -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending1,        -- tell the memory tester if the SDRAM has pending reads
        rd         => rd1,               -- host-side SDRAM read control from memory tester
        wr         => wr1,               -- host-side SDRAM write control from memory tester
        addr       => hAddr1,            -- host-side address from memory tester
        dOut       => hDIn1,             -- host-side data to SDRAM from memory tester
        progress   => progress1,         -- current phase of memory test
        err        => err1               -- memory test error flag
        );
  end generate;
  gen_slow_memtest : if not PIPE_EN generate
    slow_u0_low        : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn0'length,
        ADDR_WIDTH => hAddr0'length,
        BEG_TEST   => BEG_TEST_LOW,
        END_TEST   => END_TEST_LOW
        )
      port map(
        clk        => clk_i,             -- master internal clock
        rst        => rst_i,             -- reset
        doAgain    => syncButton(0),     -- re-do the memory test
        begun      => begun0,            -- SDRAM controller operation started
        done       => done0,             -- SDRAM controller operation complete
        dIn        => hDOut0,            -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending0,        -- tell the memory tester if the SDRAM has pending reads
        rd         => rd0,               -- host-side SDRAM read control from memory tester
        wr         => wr0,               -- host-side SDRAM write control from memory tester
        addr       => hAddr0,            -- host-side address from memory tester
        dOut       => hDIn0,             -- host-side data to SDRAM from memory tester
        progress   => progress0,         -- current phase of memory test
        err        => err0               -- memory test error flag
        );
    slow_u0_high       : memTest
      generic map(
        PIPE_EN    => PIPE_EN,
        DATA_WIDTH => hDIn0'length,
        ADDR_WIDTH => hAddr0'length,
        BEG_TEST   => BEG_TEST_HIGH,
        END_TEST   => END_TEST_HIGH
        )
      port map(
        clk        => clk_i,             -- master internal clock
        rst        => rst_i,             -- reset
        doAgain    => syncButton(0),     -- re-do the memory test
        begun      => begun1,            -- SDRAM controller operation started
        done       => done1,             -- SDRAM controller operation complete
        dIn        => hDOut1,            -- host-side data from SDRAM goes to memory tester
        rdPending  => rdPending1,        -- tell the memory tester if the SDRAM has pending reads
        rd         => rd1,               -- host-side SDRAM read control from memory tester
        wr         => wr1,               -- host-side SDRAM write control from memory tester
        addr       => hAddr1,            -- host-side address from memory tester
        dOut       => hDIn1,             -- host-side data to SDRAM from memory tester
        progress   => progress1,         -- current phase of memory test
        err        => err1               -- memory test error flag
        );
  end generate;

  -- SDRAM dualport
  u1 : dualport
	  generic map(
                  PIPE_EN     => PIPE_EN,
                  PORT_TIME_SLOTS => "1111111110000000",
                  DATA_WIDTH  => hDIn0'length,
                  HADDR_WIDTH => hAddr0'length
            )
          port map(
                  clk          => clk_i,

      rst0         => rst_i,
      rd0          => rd0,              
      wr0          => wr0,              
      rdPending0   => rdPending0,       
      opBegun0     => begun0,           
      earlyOpBegun0 => earlyBegun0,      
      rdDone0      => rdDone0,          
      done0        => done0,            
      hAddr0       => hAddr0,           
      hDIn0        => hDIn0,            
      hDOut0       => hDOut0,           
      status0      => open,            

      rst1         => rst_i,
      rd1          => rd1,              
      wr1          => wr1,              
      rdPending1   => rdPending1,       
      opBegun1     => begun1,           
      earlyOpBegun1 => earlyBegun1,      
      rdDone1      => rdDone1,          
      done1        => done1,            
      hAddr1       => hAddr1,           
      hDIn1        => hDIn1,            
      hDOut1       => hDOut1,           
      status1      => open,            

      rst          => mrst, 
      rd           => mrd,
      wr           => mwr,
      rdPending    => mrdPending, 
      opBegun      => mbegun, 
      earlyOpBegun => mearlyBegun, 
      rdDone       => mrdDone, 
      done         => mdone, 
      hAddr        => mhAddr,  
      hDIn         => mhDIn, 
      hDOut        => mhDOut, 
      status       => mstatus 
		  );


  -- SDRAM memory controller module
  u2 : xsaSDRAMCntl
    generic map(
      FREQ         => FREQ,             -- master clock frequency
      PIPE_EN      => PIPE_EN,
      DATA_WIDTH   => hDIn0'length,      -- width of the host and SDRAM databus  
      NROWS        => NROWS,            -- number of rows in the SDRAM
      NCOLS        => NCOLS,            -- number of columns in each row
      HADDR_WIDTH  => hAddr0'length,     -- host-side address width
      SADDR_WIDTH  => sAddr'length      -- SDRAM-side address width
      )
    port map(
      clk          => clk,              -- master clock from external clock source (unbuffered)
      bufclk       => clk_b,            -- buffered master clock output
      clk1x        => clk_i,            -- synchronized master clock (accounts for delays to external SDRAM)
      clk2x        => open,             -- synchronized doubled master clock
      lock         => lock,             -- DLL lock indicator
      rst          => mrst,            -- reset
      rd           => mrd,             -- host-side SDRAM read control from memory tester
      wr           => mwr,             -- host-side SDRAM write control from memory tester
      rdPending    => mrdPending,      -- read operation to SDRAM is in progress
      opBegun      => mbegun,          -- indicates memory read/write has begun
      earlyOpBegun => mearlyBegun,     -- early indicator that memory operation has begun
      rdDone       => mrdDone,         -- indicates SDRAM memory read operation is done
      done         => mdone,           -- indicates SDRAM memory read or write operation is done
      hAddr        => mhAddr,          -- host-side address from memory tester to SDRAM
      hDIn         => mhDIn,           -- test data pattern from memory tester to SDRAM
      hDOut        => mhDOut,          -- SDRAM data output to memory tester
      status       => mstatus,         -- SDRAM controller state (for diagnostics)
      sclkfb       => sclkfb,           -- clock feedback with added external PCB delays
      sclk         => sclk,             -- synchronized clock to external SDRAM
      cke          => cke,              -- SDRAM clock enable
      cs_n         => cs_n,             -- SDRAM chip-select
      ras_n        => ras_n,            -- SDRAM RAS
      cas_n        => cas_n,            -- SDRAM CAS
      we_n         => we_n,             -- SDRAM write-enable
      ba           => ba,               -- SDRAM bank address
      sAddr        => sAddr,            -- SDRAM address
      sData        => sData,            -- SDRAM databus
      dqmh         => dqmh,             -- SDRAM DQMH
      dqml         => dqml              -- SDRAM DQML
      );

  -- indicate the phase of the memory test on the LED   
  led(2 downto 0) <= "001" when progress0="00" else
                   "010" when progress0="01" else
                   "100" when progress0="10" else
                   "111" when err0=YES else
                   "000";
  led(5 downto 3) <= "001" when progress1="00" else
                   "010" when progress1="01" else
                   "100" when progress1="10" else
                   "111" when err1=YES else
                   "000";
  led(6)          <= '0';

  -- generate some slow signals from the master clock
  process(clk_b)
  begin
    if(clk_b'event and clk_b = '1') then
      divCnt <= divCnt+1;
    end if;
  end process;

  -- send a heartbeat signal back to the PC so the testing program knows
  -- the status of the memory test:
  --   50% duty cycle -> test in progress
  --   75% duty cycle -> test passed
  --   25% duty cycle -> test failed
  heartBeat <= divCnt(16)               when progress0/="11" else  -- test in progress
            divCnt(16) or divCnt(15) when err0 = NO       else  -- test passed
            divCnt(16) and divCnt(15);  -- test failed                              
end arch;
