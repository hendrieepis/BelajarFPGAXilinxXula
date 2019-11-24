----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:42:44 12/04/2010 
-- Design Name: 
-- Module Name:    VgaDisplay - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package VgaDisplay_pckg is

  component VgaDisplay
    port (
      Clk     : in  std_logic;
      Reset   : in  std_logic;
      Hsync_n : out std_logic;
      Vsync_n : out std_logic;
      Rgb     : out std_logic_vector (2 downto 0);
      Row     : in  std_logic_vector (7 downto 0);
      Col     : in  std_logic_vector (7 downto 0);
      Char    : in  std_logic_vector (7 downto 0)
      );
  end component;

end package;


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.VgaPckg.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VgaDisplay is
  port (
    Clk     : in  std_logic;
    Reset   : in  std_logic;
    Hsync_n : out std_logic;
    Vsync_n : out std_logic;
    Rgb     : out std_logic_vector (2 downto 0);
    Row     : in  std_logic_vector (7 downto 0);
    Col     : in  std_logic_vector (7 downto 0);
    Char    : in  std_logic_vector (7 downto 0)
    );
end VgaDisplay;



architecture Behavioral of VgaDisplay is

  component CharRom
    port (
      clka  : in  std_logic;
      addra : in  std_logic_vector(11 downto 0);
      douta : out std_logic_vector(7 downto 0));
  end component;

  component ScreenRam
    port (
      clka  : in  std_logic;
      wea   : in  std_logic_vector(0 downto 0);
      addra : in  std_logic_vector(10 downto 0);
      dina  : in  std_logic_vector(7 downto 0);
      clkb  : in  std_logic;
      addrb : in  std_logic_vector(10 downto 0);
      doutb : out std_logic_vector(7 downto 0));
  end component;

  constant NUM_TEXT_COLS_C : natural := 40;
  constant NUM_TEXT_ROWS_C : natural := 25;

  signal RamAddr  : std_logic_vector(10 downto 0);
  signal RamData  : std_logic_vector(7 downto 0);
  signal RomAddr  : std_logic_vector(11 downto 0);
  signal RomData  : std_logic_vector(7 downto 0);
  signal CharAddr : std_logic_vector(10 downto 0);

begin
  
  CharAddr <= CONV_STD_LOGIC_VECTOR(CONV_INTEGER(Row) * NUM_TEXT_COLS_C + CONV_INTEGER(Col), CharAddr'length);

  u1 : ScreenRam
    port map (
      clka  => Clk,
      wea   => "1",
      addra => CharAddr,
      dina  => Char,
      clkb  => Clk,
      addrb => RamAddr,
      doutb => RamData
      );

  u2 : CharRom
    port map (
      clka  => Clk,
      addra => RomAddr,
      douta => RomData
      );

  u3 : TextVga
    generic map (
      FREQ_G          => 100.0,
      CLK_DIV_G       => 4,
      CHAR_WIDTH_G    => 8,
      CHAR_HEIGHT_G   => 8,
      NUM_TEXT_COLS_G => NUM_TEXT_COLS_C,
      NUM_TEXT_ROWS_G => NUM_TEXT_ROWS_C,
    OFFSET_RIGHT_G  => 40,
    OFFSET_DOWN_G => 80,
      FIT_TO_SCREEN_G => false
      )
    port map (
      rst_p     => Reset,
      clk_p     => Clk,
      hSync_bp  => Hsync_n,
      VSync_bp  => Vsync_n,
      rgb_p     => Rgb,
      ramAddr_p => RamAddr,
      ramData_p => RamData,
      romAddr_p => RomAddr,
      romData_p => RomData
      );

end Behavioral;

