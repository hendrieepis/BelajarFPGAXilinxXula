library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity ROM is
	Port(dataOut : out STD_LOGIC_VECTOR(7 downto 0);
		 reset   : in  std_logic;
		 Rs      : out STD_LOGIC;
		 En      : out STD_LOGIC;
		 clk     : in  STD_LOGIC);
end ROM;

architecture Behavioral of ROM is
	signal cntOut : integer  := 0;
	signal pscOut : std_logic                    := '0';
	signal pscClk : std_logic                    := '0';
begin
	PSC : process(clk)
		variable prescaller : integer range 0 to 60000 := 0;
	begin
		if (clk'event and clk = '1') then
			if prescaller < 60000 then
				prescaller := prescaller + 1;
			else
				prescaller := 0;
				pscOut     <= not pscOut;
			end if;
		end if;
	end process PSC;

	BUFG_inst : BUFG
		port map(
			O => pscClk,                -- Clock buffer output
			I => pscOut                 -- Clock buffer input
		);

	MYCNT : process(pscClk,reset)
	begin
		if (pscClk'event and pscClk = '1') then
			if (reset = '0') then
				cntOut <= 0;
			elsif (cntOut /= 22) then
				cntOut <= cntOut + 1;
			end if;
		end if;
	end process MYCNT;

	ROM : process(pscClk, cntOut)
	begin
		if (pscClk'event and pscClk = '1') then
			case cntOut is
				when 0 => --delay
					En<='1'; Rs <= '0'; dataOut <= "00110000";
				when 1 => --function set 1
					En<='1'; Rs <= '0'; dataOut <= "00110000";
				when 2 => --function set 1
					En<='0'; Rs <= '0'; dataOut <= "00110000";	
									
				when 3 => --function set 1
					En<='1'; Rs <= '0'; dataOut <= "00110000";
				when 4 => --function set 1
					En<='0'; Rs <= '0'; dataOut <= "00110000";
										
				when 5 => --function set 1
					En<='1'; Rs <= '0'; dataOut <= "00110000";
				when 6 => --function set 1
					En<='0'; Rs <= '0'; dataOut <= "00110000";
				
				when 7 => --function set 8 bit
					En<='1'; Rs <= '0'; dataOut <= "00111001";
				when 8 => --function set 8 bit
					En<='0'; Rs <= '0'; dataOut <= "00111001";	
									
				when 9 => --display off
					En<='1'; Rs <= '0'; dataOut <= "00001000";
				when 10 => --display off
					En<='0'; Rs <= '0'; dataOut <= "00001000";
										
				when 11 => --display clear
					En<='1'; Rs <= '0'; dataOut <= "00000001";
				when 12 => --display clear
					En<='0'; Rs <= '0'; dataOut <= "00000001";
										
				when 13 => --entry mode
					En<='1'; Rs <= '0'; dataOut <= "00000110";
				when 14 => --entry mode
					En<='0'; Rs <= '0'; dataOut <= "00000110";
										
				when 15 => --display on
					En<='1'; Rs  <= '0'; dataOut <= "00001110"; 
				when 16 => --display on
					En<='0'; Rs  <= '0'; dataOut <= "00001110"; 
										
				when 17 => -- 'O'
					En<='1'; Rs  <= '1'; dataOut <= "01001111"; 
				when 18 => -- 'O'
					En<='0'; Rs  <= '1'; dataOut <= "01001111"; 
										
				when 19 => -- 'K'
					En<='1'; Rs  <= '1'; dataOut <= "01001011"; 
				when 20 => -- 'K'
					En<='0'; Rs  <= '1'; dataOut <= "01001011"; 
										
				when others =>
					dataOut <= "00000000";
			end case;
		end if;
	end process ROM;

end Behavioral;
