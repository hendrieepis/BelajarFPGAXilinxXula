--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.40xd
--  \   \         Application: netgen
--  /   /         Filename: LCDTest_timesim.vhd
-- /___/   /\     Timestamp: Mon Jan  7 21:14:56 2013
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -s 4 -pcf LCDTest.pcf -rpw 100 -tpw 0 -ar Structure -tm LCDTest -insert_pp_buffers true -w -dir netgen/par -ofmt vhdl -sim LCDTest.ncd LCDTest_timesim.vhd 
-- Device	: 3s50avq100-4 (PRODUCTION 1.42 2012-10-12)
-- Input file	: LCDTest.ncd
-- Output file	: /home/hendri/Documents/workspaceXilinx/LCDTest/netgen/par/LCDTest_timesim.vhd
-- # of Entities	: 1
-- Design Name	: LCDTest
-- Xilinx	: /opt/Xilinx/14.3/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity LCDTest is
  port (
    en : out STD_LOGIC; 
    reset : in STD_LOGIC := 'X'; 
    clock : in STD_LOGIC := 'X'; 
    rs : out STD_LOGIC; 
    dataLCD : out STD_LOGIC_VECTOR ( 3 downto 0 ) 
  );
end LCDTest;

architecture Structure of LCDTest is
  signal clock_BUFGP : STD_LOGIC; 
  signal pres_state_FSM_FFd20_488 : STD_LOGIC; 
  signal pres_state_FSM_FFd17_489 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_490 : STD_LOGIC; 
  signal pres_state_FSM_FFd11_491 : STD_LOGIC; 
  signal pres_state_FSM_FFd23_492 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_493 : STD_LOGIC; 
  signal pres_state_FSM_FFd53_495 : STD_LOGIC; 
  signal pres_state_FSM_FFd5_496 : STD_LOGIC; 
  signal pres_state_FSM_FFd29_497 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_498 : STD_LOGIC; 
  signal pres_state_FSM_FFd50_499 : STD_LOGIC; 
  signal pres_state_FSM_FFd47_500 : STD_LOGIC; 
  signal pres_state_FSM_FFd32_501 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_502 : STD_LOGIC; 
  signal pres_state_FSM_FFd41_504 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_505 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_506 : STD_LOGIC; 
  signal pres_state_FSM_FFd35_507 : STD_LOGIC; 
  signal en_OBUF_508 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_509 : STD_LOGIC; 
  signal pres_state_FSM_FFd37_510 : STD_LOGIC; 
  signal pres_state_FSM_FFd31_511 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_512 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_514 : STD_LOGIC; 
  signal pres_state_FSM_FFd25_515 : STD_LOGIC; 
  signal pres_state_FSM_FFd43_516 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_517 : STD_LOGIC; 
  signal pres_state_FSM_FFd19_519 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_520 : STD_LOGIC; 
  signal pres_state_FSM_FFd13_521 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_522 : STD_LOGIC; 
  signal pres_state_FSM_FFd7_524 : STD_LOGIC; 
  signal pres_state_FSM_FFd10_525 : STD_LOGIC; 
  signal pres_state_FSM_FFd49_526 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_527 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_529 : STD_LOGIC; 
  signal pres_state_FSM_FFd52_530 : STD_LOGIC; 
  signal dataLCD_or0000 : STD_LOGIC; 
  signal reset_IBUF_0 : STD_LOGIC; 
  signal clock_o : STD_LOGIC; 
  signal pres_state_FSM_FFd54_541 : STD_LOGIC; 
  signal pres_state_FSM_FFd21_542 : STD_LOGIC; 
  signal pres_state_FSM_FFd27_543 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_544 : STD_LOGIC; 
  signal pres_state_FSM_FFd51_545 : STD_LOGIC; 
  signal pres_state_FSM_FFd9_546 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_547 : STD_LOGIC; 
  signal pres_state_FSM_FFd15_548 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_549 : STD_LOGIC; 
  signal pres_state_FSM_FFd33_550 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_551 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_552 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_553 : STD_LOGIC; 
  signal pres_state_FSM_FFd45_554 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_555 : STD_LOGIC; 
  signal pres_state_FSM_FFd39_556 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_557 : STD_LOGIC; 
  signal pres_state_FSM_FFd3_558 : STD_LOGIC; 
  signal N2 : STD_LOGIC; 
  signal clk_s_0_DXMUX_602 : STD_LOGIC; 
  signal clk_s_0_XORF_600 : STD_LOGIC; 
  signal clk_s_0_LOGIC_ONE_599 : STD_LOGIC; 
  signal clk_s_0_CYINIT_598 : STD_LOGIC; 
  signal clk_s_0_CYSELF_589 : STD_LOGIC; 
  signal clk_s_0_BXINV_587 : STD_LOGIC; 
  signal clk_s_0_DYMUX_583 : STD_LOGIC; 
  signal clk_s_0_XORG_581 : STD_LOGIC; 
  signal clk_s_0_CYMUXG_580 : STD_LOGIC; 
  signal clk_s_0_LOGIC_ZERO_578 : STD_LOGIC; 
  signal clk_s_0_CYSELG_569 : STD_LOGIC; 
  signal clk_s_0_G : STD_LOGIC; 
  signal clk_s_0_CLKINV_567 : STD_LOGIC; 
  signal clk_s_2_DXMUX_650 : STD_LOGIC; 
  signal clk_s_2_XORF_648 : STD_LOGIC; 
  signal clk_s_2_CYINIT_647 : STD_LOGIC; 
  signal clk_s_2_F : STD_LOGIC; 
  signal clk_s_2_DYMUX_634 : STD_LOGIC; 
  signal clk_s_2_XORG_632 : STD_LOGIC; 
  signal clk_s_2_CYSELF_630 : STD_LOGIC; 
  signal clk_s_2_CYMUXFAST_629 : STD_LOGIC; 
  signal clk_s_2_CYAND_628 : STD_LOGIC; 
  signal clk_s_2_FASTCARRY_627 : STD_LOGIC; 
  signal clk_s_2_CYMUXG2_626 : STD_LOGIC; 
  signal clk_s_2_CYMUXF2_625 : STD_LOGIC; 
  signal clk_s_2_LOGIC_ZERO_624 : STD_LOGIC; 
  signal clk_s_2_CYSELG_615 : STD_LOGIC; 
  signal clk_s_2_G : STD_LOGIC; 
  signal clk_s_2_CLKINV_613 : STD_LOGIC; 
  signal clk_s_4_DXMUX_698 : STD_LOGIC; 
  signal clk_s_4_XORF_696 : STD_LOGIC; 
  signal clk_s_4_CYINIT_695 : STD_LOGIC; 
  signal clk_s_4_F : STD_LOGIC; 
  signal clk_s_4_DYMUX_682 : STD_LOGIC; 
  signal clk_s_4_XORG_680 : STD_LOGIC; 
  signal clk_s_4_CYSELF_678 : STD_LOGIC; 
  signal clk_s_4_CYMUXFAST_677 : STD_LOGIC; 
  signal clk_s_4_CYAND_676 : STD_LOGIC; 
  signal clk_s_4_FASTCARRY_675 : STD_LOGIC; 
  signal clk_s_4_CYMUXG2_674 : STD_LOGIC; 
  signal clk_s_4_CYMUXF2_673 : STD_LOGIC; 
  signal clk_s_4_LOGIC_ZERO_672 : STD_LOGIC; 
  signal clk_s_4_CYSELG_663 : STD_LOGIC; 
  signal clk_s_4_G : STD_LOGIC; 
  signal clk_s_4_CLKINV_661 : STD_LOGIC; 
  signal clk_s_6_DXMUX_746 : STD_LOGIC; 
  signal clk_s_6_XORF_744 : STD_LOGIC; 
  signal clk_s_6_CYINIT_743 : STD_LOGIC; 
  signal clk_s_6_F : STD_LOGIC; 
  signal clk_s_6_DYMUX_730 : STD_LOGIC; 
  signal clk_s_6_XORG_728 : STD_LOGIC; 
  signal clk_s_6_CYSELF_726 : STD_LOGIC; 
  signal clk_s_6_CYMUXFAST_725 : STD_LOGIC; 
  signal clk_s_6_CYAND_724 : STD_LOGIC; 
  signal clk_s_6_FASTCARRY_723 : STD_LOGIC; 
  signal clk_s_6_CYMUXG2_722 : STD_LOGIC; 
  signal clk_s_6_CYMUXF2_721 : STD_LOGIC; 
  signal clk_s_6_LOGIC_ZERO_720 : STD_LOGIC; 
  signal clk_s_6_CYSELG_711 : STD_LOGIC; 
  signal clk_s_6_G : STD_LOGIC; 
  signal clk_s_6_CLKINV_709 : STD_LOGIC; 
  signal clk_s_8_DXMUX_794 : STD_LOGIC; 
  signal clk_s_8_XORF_792 : STD_LOGIC; 
  signal clk_s_8_CYINIT_791 : STD_LOGIC; 
  signal clk_s_8_F : STD_LOGIC; 
  signal clk_s_8_DYMUX_778 : STD_LOGIC; 
  signal clk_s_8_XORG_776 : STD_LOGIC; 
  signal clk_s_8_CYSELF_774 : STD_LOGIC; 
  signal clk_s_8_CYMUXFAST_773 : STD_LOGIC; 
  signal clk_s_8_CYAND_772 : STD_LOGIC; 
  signal clk_s_8_FASTCARRY_771 : STD_LOGIC; 
  signal clk_s_8_CYMUXG2_770 : STD_LOGIC; 
  signal clk_s_8_CYMUXF2_769 : STD_LOGIC; 
  signal clk_s_8_LOGIC_ZERO_768 : STD_LOGIC; 
  signal clk_s_8_CYSELG_759 : STD_LOGIC; 
  signal clk_s_8_G : STD_LOGIC; 
  signal clk_s_8_CLKINV_757 : STD_LOGIC; 
  signal clk_s_10_DXMUX_842 : STD_LOGIC; 
  signal clk_s_10_XORF_840 : STD_LOGIC; 
  signal clk_s_10_CYINIT_839 : STD_LOGIC; 
  signal clk_s_10_F : STD_LOGIC; 
  signal clk_s_10_DYMUX_826 : STD_LOGIC; 
  signal clk_s_10_XORG_824 : STD_LOGIC; 
  signal clk_s_10_CYSELF_822 : STD_LOGIC; 
  signal clk_s_10_CYMUXFAST_821 : STD_LOGIC; 
  signal clk_s_10_CYAND_820 : STD_LOGIC; 
  signal clk_s_10_FASTCARRY_819 : STD_LOGIC; 
  signal clk_s_10_CYMUXG2_818 : STD_LOGIC; 
  signal clk_s_10_CYMUXF2_817 : STD_LOGIC; 
  signal clk_s_10_LOGIC_ZERO_816 : STD_LOGIC; 
  signal clk_s_10_CYSELG_807 : STD_LOGIC; 
  signal clk_s_10_G : STD_LOGIC; 
  signal clk_s_10_CLKINV_805 : STD_LOGIC; 
  signal clk_s_12_DXMUX_890 : STD_LOGIC; 
  signal clk_s_12_XORF_888 : STD_LOGIC; 
  signal clk_s_12_CYINIT_887 : STD_LOGIC; 
  signal clk_s_12_F : STD_LOGIC; 
  signal clk_s_12_DYMUX_874 : STD_LOGIC; 
  signal clk_s_12_XORG_872 : STD_LOGIC; 
  signal clk_s_12_CYSELF_870 : STD_LOGIC; 
  signal clk_s_12_CYMUXFAST_869 : STD_LOGIC; 
  signal clk_s_12_CYAND_868 : STD_LOGIC; 
  signal clk_s_12_FASTCARRY_867 : STD_LOGIC; 
  signal clk_s_12_CYMUXG2_866 : STD_LOGIC; 
  signal clk_s_12_CYMUXF2_865 : STD_LOGIC; 
  signal clk_s_12_LOGIC_ZERO_864 : STD_LOGIC; 
  signal clk_s_12_CYSELG_855 : STD_LOGIC; 
  signal clk_s_12_G : STD_LOGIC; 
  signal clk_s_12_CLKINV_853 : STD_LOGIC; 
  signal clk_s_14_DXMUX_938 : STD_LOGIC; 
  signal clk_s_14_XORF_936 : STD_LOGIC; 
  signal clk_s_14_CYINIT_935 : STD_LOGIC; 
  signal clk_s_14_F : STD_LOGIC; 
  signal clk_s_14_DYMUX_922 : STD_LOGIC; 
  signal clk_s_14_XORG_920 : STD_LOGIC; 
  signal clk_s_14_CYSELF_918 : STD_LOGIC; 
  signal clk_s_14_CYMUXFAST_917 : STD_LOGIC; 
  signal clk_s_14_CYAND_916 : STD_LOGIC; 
  signal clk_s_14_FASTCARRY_915 : STD_LOGIC; 
  signal clk_s_14_CYMUXG2_914 : STD_LOGIC; 
  signal clk_s_14_CYMUXF2_913 : STD_LOGIC; 
  signal clk_s_14_LOGIC_ZERO_912 : STD_LOGIC; 
  signal clk_s_14_CYSELG_903 : STD_LOGIC; 
  signal clk_s_14_G : STD_LOGIC; 
  signal clk_s_14_CLKINV_901 : STD_LOGIC; 
  signal clk_s_16_DXMUX_959 : STD_LOGIC; 
  signal clk_s_16_XORF_957 : STD_LOGIC; 
  signal clk_s_16_CYINIT_956 : STD_LOGIC; 
  signal clk_s_16_rt_954 : STD_LOGIC; 
  signal clk_s_16_CLKINV_946 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_1_CYINIT_991 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_1_CYSELF_983 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_1_BXINV_981 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_1_CYMUXG_980 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_1_LOGIC_ONE_978 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_1_CYSELG_972 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_CYSELF_1015 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_CYMUXFAST_1014 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_CYAND_1013 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_FASTCARRY_1012 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_CYMUXG2_1011 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_CYMUXF2_1010 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_LOGIC_ONE_1009 : STD_LOGIC; 
  signal pres_state_FSM_Out54_wg_cy_3_CYSELG_1003 : STD_LOGIC; 
  signal en_OBUF_LOGIC_ONE_1036 : STD_LOGIC; 
  signal en_OBUF_CYINIT_1035 : STD_LOGIC; 
  signal en_OBUF_CYSELF_1029 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYINIT_1065 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYSELF_1059 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_BXINV_1057 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYMUXG_1056 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_LOGIC_ONE_1054 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYSELG_1048 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYSELF_1089 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYMUXFAST_1088 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYAND_1087 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_FASTCARRY_1086 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYMUXG2_1085 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYMUXF2_1084 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_LOGIC_ONE_1083 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYSELG_1077 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYSELF_1119 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYMUXFAST_1118 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYAND_1117 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_FASTCARRY_1116 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYMUXG2_1115 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYMUXF2_1114 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_LOGIC_ONE_1113 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYSELG_1107 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_CYSELF_1149 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_CYMUXFAST_1148 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_CYAND_1147 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_FASTCARRY_1146 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_CYMUXG2_1145 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_CYMUXF2_1144 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_LOGIC_ONE_1143 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_7_CYSELG_1137 : STD_LOGIC; 
  signal dataLCD_or0000_LOGIC_ONE_1170 : STD_LOGIC; 
  signal dataLCD_or0000_CYINIT_1169 : STD_LOGIC; 
  signal dataLCD_or0000_CYSELF_1163 : STD_LOGIC; 
  signal en_O : STD_LOGIC; 
  signal rs_O : STD_LOGIC; 
  signal rs_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal rs_OBUF_1193 : STD_LOGIC; 
  signal rs_OUTPUT_OTCLK1INV_1187 : STD_LOGIC; 
  signal dataLCD_0_O : STD_LOGIC; 
  signal dataLCD_0_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_0_1210 : STD_LOGIC; 
  signal dataLCD_0_OUTPUT_OTCLK1INV_1204 : STD_LOGIC; 
  signal dataLCD_1_O : STD_LOGIC; 
  signal dataLCD_1_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_1_1227 : STD_LOGIC; 
  signal dataLCD_1_OUTPUT_OTCLK1INV_1221 : STD_LOGIC; 
  signal dataLCD_2_O : STD_LOGIC; 
  signal dataLCD_2_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_2_1244 : STD_LOGIC; 
  signal dataLCD_2_OUTPUT_OTCLK1INV_1238 : STD_LOGIC; 
  signal dataLCD_3_O : STD_LOGIC; 
  signal dataLCD_3_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_3_1261 : STD_LOGIC; 
  signal dataLCD_3_OUTPUT_OTCLK1INV_1255 : STD_LOGIC; 
  signal clock_BUFGP_IBUFG_1270 : STD_LOGIC; 
  signal reset_IBUF_1277 : STD_LOGIC; 
  signal BUFG_inst_S_INVNOT : STD_LOGIC; 
  signal BUFG_inst_I0_INV : STD_LOGIC; 
  signal clock_BUFGP_BUFG_S_INVNOT : STD_LOGIC; 
  signal clock_BUFGP_BUFG_I0_INV : STD_LOGIC; 
  signal dataLCD_mux0000_0_F5MUX_1311 : STD_LOGIC; 
  signal dataLCD_mux0000_0_F : STD_LOGIC; 
  signal dataLCD_mux0000_0_BXINV_1300 : STD_LOGIC; 
  signal dataLCD_mux0000_0_1_1298 : STD_LOGIC; 
  signal pres_state_FSM_FFd10_DXMUX_1330 : STD_LOGIC; 
  signal pres_state_FSM_FFd10_DYMUX_1322 : STD_LOGIC; 
  signal pres_state_FSM_FFd10_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd10_CLKINV_1319 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_DXMUX_1354 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_DYMUX_1346 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd12_CLKINV_1343 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_DXMUX_1378 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_DYMUX_1370 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd14_CLKINV_1367 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_DXMUX_1402 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_DYMUX_1394 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd22_CLKINV_1391 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_DXMUX_1426 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_DYMUX_1418 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd16_CLKINV_1415 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_DXMUX_1450 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_DYMUX_1442 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd24_CLKINV_1439 : STD_LOGIC; 
  signal pres_state_FSM_FFd32_DXMUX_1474 : STD_LOGIC; 
  signal pres_state_FSM_FFd32_DYMUX_1466 : STD_LOGIC; 
  signal pres_state_FSM_FFd32_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd32_CLKINV_1463 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_DXMUX_1498 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_DYMUX_1490 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd18_CLKINV_1487 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_DXMUX_1522 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_DYMUX_1514 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd26_CLKINV_1511 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_DXMUX_1546 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_DYMUX_1538 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd34_CLKINV_1535 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_DXMUX_1570 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_DYMUX_1562 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd42_CLKINV_1559 : STD_LOGIC; 
  signal pres_state_FSM_FFd20_DXMUX_1594 : STD_LOGIC; 
  signal pres_state_FSM_FFd20_DYMUX_1586 : STD_LOGIC; 
  signal pres_state_FSM_FFd20_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd20_CLKINV_1583 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_DXMUX_1618 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_DYMUX_1610 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd28_CLKINV_1607 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_DXMUX_1642 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_DYMUX_1634 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd36_CLKINV_1631 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_DXMUX_1666 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_DYMUX_1658 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd44_CLKINV_1655 : STD_LOGIC; 
  signal pres_state_FSM_FFd52_DXMUX_1690 : STD_LOGIC; 
  signal pres_state_FSM_FFd52_DYMUX_1682 : STD_LOGIC; 
  signal pres_state_FSM_FFd52_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd52_CLKINV_1679 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_DXMUX_1714 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_DYMUX_1706 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd30_CLKINV_1703 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_DXMUX_1738 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_DYMUX_1730 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd38_CLKINV_1727 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_DXMUX_1762 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_DYMUX_1754 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd46_CLKINV_1751 : STD_LOGIC; 
  signal pres_state_FSM_FFd54_DXMUX_1786 : STD_LOGIC; 
  signal pres_state_FSM_FFd54_BXINV_1785 : STD_LOGIC; 
  signal pres_state_FSM_FFd54_DYMUX_1778 : STD_LOGIC; 
  signal pres_state_FSM_FFd54_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd54_CLKINV_1775 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_DXMUX_1809 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_DYMUX_1801 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd40_CLKINV_1798 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_DXMUX_1833 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_DYMUX_1825 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd48_CLKINV_1822 : STD_LOGIC; 
  signal pres_state_FSM_FFd50_DXMUX_1857 : STD_LOGIC; 
  signal pres_state_FSM_FFd50_DYMUX_1849 : STD_LOGIC; 
  signal pres_state_FSM_FFd50_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd50_CLKINV_1846 : STD_LOGIC; 
  signal rs_mux0000 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_DYMUX_1909 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_BYINV_1908 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_CLKINV_1906 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_CEINV_1905 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_DYMUX_1924 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_CLKINV_1921 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_DXMUX_1948 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_DYMUX_1940 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd4_CLKINV_1937 : STD_LOGIC; 
  signal N2_pack_1 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_DXMUX_1996 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_DYMUX_1988 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd6_CLKINV_1985 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_DXMUX_2020 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_DYMUX_2012 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd8_CLKINV_2009 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_FFY_RSTAND_1915 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_FFY_RSTAND_1929 : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal NlwInverterSignal_rs_CLK : STD_LOGIC; 
  signal NlwInverterSignal_dataLCD_0_CLK : STD_LOGIC; 
  signal NlwInverterSignal_dataLCD_1_CLK : STD_LOGIC; 
  signal NlwInverterSignal_dataLCD_2_CLK : STD_LOGIC; 
  signal NlwInverterSignal_dataLCD_3_CLK : STD_LOGIC; 
  signal clk_s : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal Mcount_clk_s_cy : STD_LOGIC_VECTOR ( 14 downto 0 ); 
  signal Mcount_clk_s_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal pres_state_FSM_Out54_wg_lut : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal pres_state_FSM_Out54_wg_cy : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal dataLCD_or0000_wg_lut : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal dataLCD_or0000_wg_cy : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal dataLCD_mux0000 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
begin
  clk_s_0_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      O => clk_s_0_LOGIC_ZERO_578
    );
  clk_s_0_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      O => clk_s_0_LOGIC_ONE_599
    );
  clk_s_0_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_XORF_600,
      O => clk_s_0_DXMUX_602
    );
  clk_s_0_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      I0 => clk_s_0_CYINIT_598,
      I1 => Mcount_clk_s_lut(0),
      O => clk_s_0_XORF_600
    );
  clk_s_0_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      IA => clk_s_0_LOGIC_ONE_599,
      IB => clk_s_0_CYINIT_598,
      SEL => clk_s_0_CYSELF_589,
      O => Mcount_clk_s_cy(0)
    );
  clk_s_0_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_BXINV_587,
      O => clk_s_0_CYINIT_598
    );
  clk_s_0_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_lut(0),
      O => clk_s_0_CYSELF_589
    );
  clk_s_0_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => '0',
      O => clk_s_0_BXINV_587
    );
  clk_s_0_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_XORG_581,
      O => clk_s_0_DYMUX_583
    );
  clk_s_0_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      I0 => Mcount_clk_s_cy(0),
      I1 => clk_s_0_G,
      O => clk_s_0_XORG_581
    );
  clk_s_0_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_CYMUXG_580,
      O => Mcount_clk_s_cy(1)
    );
  clk_s_0_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      IA => clk_s_0_LOGIC_ZERO_578,
      IB => Mcount_clk_s_cy(0),
      SEL => clk_s_0_CYSELG_569,
      O => clk_s_0_CYMUXG_580
    );
  clk_s_0_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_G,
      O => clk_s_0_CYSELG_569
    );
  clk_s_0_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_0_CLKINV_567
    );
  clk_s_1 : X_FF
    generic map(
      LOC => "SLICE_X19Y23",
      INIT => '0'
    )
    port map (
      I => clk_s_0_DYMUX_583,
      CE => VCC,
      CLK => clk_s_0_CLKINV_567,
      SET => GND,
      RST => GND,
      O => clk_s(1)
    );
  clk_s_2_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      O => clk_s_2_LOGIC_ZERO_624
    );
  clk_s_2_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_XORF_648,
      O => clk_s_2_DXMUX_650
    );
  clk_s_2_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      I0 => clk_s_2_CYINIT_647,
      I1 => clk_s_2_F,
      O => clk_s_2_XORF_648
    );
  clk_s_2_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_LOGIC_ZERO_624,
      IB => clk_s_2_CYINIT_647,
      SEL => clk_s_2_CYSELF_630,
      O => Mcount_clk_s_cy(2)
    );
  clk_s_2_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_LOGIC_ZERO_624,
      IB => clk_s_2_LOGIC_ZERO_624,
      SEL => clk_s_2_CYSELF_630,
      O => clk_s_2_CYMUXF2_625
    );
  clk_s_2_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(1),
      O => clk_s_2_CYINIT_647
    );
  clk_s_2_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_F,
      O => clk_s_2_CYSELF_630
    );
  clk_s_2_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_XORG_632,
      O => clk_s_2_DYMUX_634
    );
  clk_s_2_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      I0 => Mcount_clk_s_cy(2),
      I1 => clk_s_2_G,
      O => clk_s_2_XORG_632
    );
  clk_s_2_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_CYMUXFAST_629,
      O => Mcount_clk_s_cy(3)
    );
  clk_s_2_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(1),
      O => clk_s_2_FASTCARRY_627
    );
  clk_s_2_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      I0 => clk_s_2_CYSELG_615,
      I1 => clk_s_2_CYSELF_630,
      O => clk_s_2_CYAND_628
    );
  clk_s_2_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_CYMUXG2_626,
      IB => clk_s_2_FASTCARRY_627,
      SEL => clk_s_2_CYAND_628,
      O => clk_s_2_CYMUXFAST_629
    );
  clk_s_2_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_LOGIC_ZERO_624,
      IB => clk_s_2_CYMUXF2_625,
      SEL => clk_s_2_CYSELG_615,
      O => clk_s_2_CYMUXG2_626
    );
  clk_s_2_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_G,
      O => clk_s_2_CYSELG_615
    );
  clk_s_2_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_2_CLKINV_613
    );
  clk_s_4_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      O => clk_s_4_LOGIC_ZERO_672
    );
  clk_s_4_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_XORF_696,
      O => clk_s_4_DXMUX_698
    );
  clk_s_4_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      I0 => clk_s_4_CYINIT_695,
      I1 => clk_s_4_F,
      O => clk_s_4_XORF_696
    );
  clk_s_4_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_LOGIC_ZERO_672,
      IB => clk_s_4_CYINIT_695,
      SEL => clk_s_4_CYSELF_678,
      O => Mcount_clk_s_cy(4)
    );
  clk_s_4_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_LOGIC_ZERO_672,
      IB => clk_s_4_LOGIC_ZERO_672,
      SEL => clk_s_4_CYSELF_678,
      O => clk_s_4_CYMUXF2_673
    );
  clk_s_4_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(3),
      O => clk_s_4_CYINIT_695
    );
  clk_s_4_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_F,
      O => clk_s_4_CYSELF_678
    );
  clk_s_4_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_XORG_680,
      O => clk_s_4_DYMUX_682
    );
  clk_s_4_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      I0 => Mcount_clk_s_cy(4),
      I1 => clk_s_4_G,
      O => clk_s_4_XORG_680
    );
  clk_s_4_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_CYMUXFAST_677,
      O => Mcount_clk_s_cy(5)
    );
  clk_s_4_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(3),
      O => clk_s_4_FASTCARRY_675
    );
  clk_s_4_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      I0 => clk_s_4_CYSELG_663,
      I1 => clk_s_4_CYSELF_678,
      O => clk_s_4_CYAND_676
    );
  clk_s_4_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_CYMUXG2_674,
      IB => clk_s_4_FASTCARRY_675,
      SEL => clk_s_4_CYAND_676,
      O => clk_s_4_CYMUXFAST_677
    );
  clk_s_4_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_LOGIC_ZERO_672,
      IB => clk_s_4_CYMUXF2_673,
      SEL => clk_s_4_CYSELG_663,
      O => clk_s_4_CYMUXG2_674
    );
  clk_s_4_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_G,
      O => clk_s_4_CYSELG_663
    );
  clk_s_4_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_4_CLKINV_661
    );
  clk_s_6_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      O => clk_s_6_LOGIC_ZERO_720
    );
  clk_s_6_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_XORF_744,
      O => clk_s_6_DXMUX_746
    );
  clk_s_6_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      I0 => clk_s_6_CYINIT_743,
      I1 => clk_s_6_F,
      O => clk_s_6_XORF_744
    );
  clk_s_6_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_LOGIC_ZERO_720,
      IB => clk_s_6_CYINIT_743,
      SEL => clk_s_6_CYSELF_726,
      O => Mcount_clk_s_cy(6)
    );
  clk_s_6_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_LOGIC_ZERO_720,
      IB => clk_s_6_LOGIC_ZERO_720,
      SEL => clk_s_6_CYSELF_726,
      O => clk_s_6_CYMUXF2_721
    );
  clk_s_6_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(5),
      O => clk_s_6_CYINIT_743
    );
  clk_s_6_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_F,
      O => clk_s_6_CYSELF_726
    );
  clk_s_6_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_XORG_728,
      O => clk_s_6_DYMUX_730
    );
  clk_s_6_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      I0 => Mcount_clk_s_cy(6),
      I1 => clk_s_6_G,
      O => clk_s_6_XORG_728
    );
  clk_s_6_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_CYMUXFAST_725,
      O => Mcount_clk_s_cy(7)
    );
  clk_s_6_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(5),
      O => clk_s_6_FASTCARRY_723
    );
  clk_s_6_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      I0 => clk_s_6_CYSELG_711,
      I1 => clk_s_6_CYSELF_726,
      O => clk_s_6_CYAND_724
    );
  clk_s_6_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_CYMUXG2_722,
      IB => clk_s_6_FASTCARRY_723,
      SEL => clk_s_6_CYAND_724,
      O => clk_s_6_CYMUXFAST_725
    );
  clk_s_6_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_LOGIC_ZERO_720,
      IB => clk_s_6_CYMUXF2_721,
      SEL => clk_s_6_CYSELG_711,
      O => clk_s_6_CYMUXG2_722
    );
  clk_s_6_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_G,
      O => clk_s_6_CYSELG_711
    );
  clk_s_6_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_6_CLKINV_709
    );
  clk_s_8_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      O => clk_s_8_LOGIC_ZERO_768
    );
  clk_s_8_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_XORF_792,
      O => clk_s_8_DXMUX_794
    );
  clk_s_8_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      I0 => clk_s_8_CYINIT_791,
      I1 => clk_s_8_F,
      O => clk_s_8_XORF_792
    );
  clk_s_8_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_LOGIC_ZERO_768,
      IB => clk_s_8_CYINIT_791,
      SEL => clk_s_8_CYSELF_774,
      O => Mcount_clk_s_cy(8)
    );
  clk_s_8_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_LOGIC_ZERO_768,
      IB => clk_s_8_LOGIC_ZERO_768,
      SEL => clk_s_8_CYSELF_774,
      O => clk_s_8_CYMUXF2_769
    );
  clk_s_8_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(7),
      O => clk_s_8_CYINIT_791
    );
  clk_s_8_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_F,
      O => clk_s_8_CYSELF_774
    );
  clk_s_8_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_XORG_776,
      O => clk_s_8_DYMUX_778
    );
  clk_s_8_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      I0 => Mcount_clk_s_cy(8),
      I1 => clk_s_8_G,
      O => clk_s_8_XORG_776
    );
  clk_s_8_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_CYMUXFAST_773,
      O => Mcount_clk_s_cy(9)
    );
  clk_s_8_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(7),
      O => clk_s_8_FASTCARRY_771
    );
  clk_s_8_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      I0 => clk_s_8_CYSELG_759,
      I1 => clk_s_8_CYSELF_774,
      O => clk_s_8_CYAND_772
    );
  clk_s_8_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_CYMUXG2_770,
      IB => clk_s_8_FASTCARRY_771,
      SEL => clk_s_8_CYAND_772,
      O => clk_s_8_CYMUXFAST_773
    );
  clk_s_8_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_LOGIC_ZERO_768,
      IB => clk_s_8_CYMUXF2_769,
      SEL => clk_s_8_CYSELG_759,
      O => clk_s_8_CYMUXG2_770
    );
  clk_s_8_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_G,
      O => clk_s_8_CYSELG_759
    );
  clk_s_8_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_8_CLKINV_757
    );
  clk_s_10_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      O => clk_s_10_LOGIC_ZERO_816
    );
  clk_s_10_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_XORF_840,
      O => clk_s_10_DXMUX_842
    );
  clk_s_10_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      I0 => clk_s_10_CYINIT_839,
      I1 => clk_s_10_F,
      O => clk_s_10_XORF_840
    );
  clk_s_10_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_LOGIC_ZERO_816,
      IB => clk_s_10_CYINIT_839,
      SEL => clk_s_10_CYSELF_822,
      O => Mcount_clk_s_cy(10)
    );
  clk_s_10_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_LOGIC_ZERO_816,
      IB => clk_s_10_LOGIC_ZERO_816,
      SEL => clk_s_10_CYSELF_822,
      O => clk_s_10_CYMUXF2_817
    );
  clk_s_10_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(9),
      O => clk_s_10_CYINIT_839
    );
  clk_s_10_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_F,
      O => clk_s_10_CYSELF_822
    );
  clk_s_10_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_XORG_824,
      O => clk_s_10_DYMUX_826
    );
  clk_s_10_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      I0 => Mcount_clk_s_cy(10),
      I1 => clk_s_10_G,
      O => clk_s_10_XORG_824
    );
  clk_s_10_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_CYMUXFAST_821,
      O => Mcount_clk_s_cy(11)
    );
  clk_s_10_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(9),
      O => clk_s_10_FASTCARRY_819
    );
  clk_s_10_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      I0 => clk_s_10_CYSELG_807,
      I1 => clk_s_10_CYSELF_822,
      O => clk_s_10_CYAND_820
    );
  clk_s_10_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_CYMUXG2_818,
      IB => clk_s_10_FASTCARRY_819,
      SEL => clk_s_10_CYAND_820,
      O => clk_s_10_CYMUXFAST_821
    );
  clk_s_10_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_LOGIC_ZERO_816,
      IB => clk_s_10_CYMUXF2_817,
      SEL => clk_s_10_CYSELG_807,
      O => clk_s_10_CYMUXG2_818
    );
  clk_s_10_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_G,
      O => clk_s_10_CYSELG_807
    );
  clk_s_10_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_10_CLKINV_805
    );
  clk_s_12_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      O => clk_s_12_LOGIC_ZERO_864
    );
  clk_s_12_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_XORF_888,
      O => clk_s_12_DXMUX_890
    );
  clk_s_12_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      I0 => clk_s_12_CYINIT_887,
      I1 => clk_s_12_F,
      O => clk_s_12_XORF_888
    );
  clk_s_12_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_LOGIC_ZERO_864,
      IB => clk_s_12_CYINIT_887,
      SEL => clk_s_12_CYSELF_870,
      O => Mcount_clk_s_cy(12)
    );
  clk_s_12_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_LOGIC_ZERO_864,
      IB => clk_s_12_LOGIC_ZERO_864,
      SEL => clk_s_12_CYSELF_870,
      O => clk_s_12_CYMUXF2_865
    );
  clk_s_12_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(11),
      O => clk_s_12_CYINIT_887
    );
  clk_s_12_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_F,
      O => clk_s_12_CYSELF_870
    );
  clk_s_12_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_XORG_872,
      O => clk_s_12_DYMUX_874
    );
  clk_s_12_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      I0 => Mcount_clk_s_cy(12),
      I1 => clk_s_12_G,
      O => clk_s_12_XORG_872
    );
  clk_s_12_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_CYMUXFAST_869,
      O => Mcount_clk_s_cy(13)
    );
  clk_s_12_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(11),
      O => clk_s_12_FASTCARRY_867
    );
  clk_s_12_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      I0 => clk_s_12_CYSELG_855,
      I1 => clk_s_12_CYSELF_870,
      O => clk_s_12_CYAND_868
    );
  clk_s_12_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_CYMUXG2_866,
      IB => clk_s_12_FASTCARRY_867,
      SEL => clk_s_12_CYAND_868,
      O => clk_s_12_CYMUXFAST_869
    );
  clk_s_12_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_LOGIC_ZERO_864,
      IB => clk_s_12_CYMUXF2_865,
      SEL => clk_s_12_CYSELG_855,
      O => clk_s_12_CYMUXG2_866
    );
  clk_s_12_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_G,
      O => clk_s_12_CYSELG_855
    );
  clk_s_12_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_12_CLKINV_853
    );
  clk_s_14_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      O => clk_s_14_LOGIC_ZERO_912
    );
  clk_s_14_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_XORF_936,
      O => clk_s_14_DXMUX_938
    );
  clk_s_14_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      I0 => clk_s_14_CYINIT_935,
      I1 => clk_s_14_F,
      O => clk_s_14_XORF_936
    );
  clk_s_14_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_LOGIC_ZERO_912,
      IB => clk_s_14_CYINIT_935,
      SEL => clk_s_14_CYSELF_918,
      O => Mcount_clk_s_cy(14)
    );
  clk_s_14_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_LOGIC_ZERO_912,
      IB => clk_s_14_LOGIC_ZERO_912,
      SEL => clk_s_14_CYSELF_918,
      O => clk_s_14_CYMUXF2_913
    );
  clk_s_14_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(13),
      O => clk_s_14_CYINIT_935
    );
  clk_s_14_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_F,
      O => clk_s_14_CYSELF_918
    );
  clk_s_14_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_XORG_920,
      O => clk_s_14_DYMUX_922
    );
  clk_s_14_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      I0 => Mcount_clk_s_cy(14),
      I1 => clk_s_14_G,
      O => clk_s_14_XORG_920
    );
  clk_s_14_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(13),
      O => clk_s_14_FASTCARRY_915
    );
  clk_s_14_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      I0 => clk_s_14_CYSELG_903,
      I1 => clk_s_14_CYSELF_918,
      O => clk_s_14_CYAND_916
    );
  clk_s_14_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_CYMUXG2_914,
      IB => clk_s_14_FASTCARRY_915,
      SEL => clk_s_14_CYAND_916,
      O => clk_s_14_CYMUXFAST_917
    );
  clk_s_14_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_LOGIC_ZERO_912,
      IB => clk_s_14_CYMUXF2_913,
      SEL => clk_s_14_CYSELG_903,
      O => clk_s_14_CYMUXG2_914
    );
  clk_s_14_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_G,
      O => clk_s_14_CYSELG_903
    );
  clk_s_14_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_14_CLKINV_901
    );
  clk_s_16_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y31",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_16_XORF_957,
      O => clk_s_16_DXMUX_959
    );
  clk_s_16_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y31"
    )
    port map (
      I0 => clk_s_16_CYINIT_956,
      I1 => clk_s_16_rt_954,
      O => clk_s_16_XORF_957
    );
  clk_s_16_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y31",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_CYMUXFAST_917,
      O => clk_s_16_CYINIT_956
    );
  clk_s_16_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y31",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_16_CLKINV_946
    );
  clk_s_16_rt : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X19Y31"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => clk_s(16),
      O => clk_s_16_rt_954
    );
  pres_state_FSM_Out54_wg_cy_1_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X17Y17"
    )
    port map (
      O => pres_state_FSM_Out54_wg_cy_1_LOGIC_ONE_978
    );
  pres_state_FSM_Out54_wg_cy_1_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X17Y17"
    )
    port map (
      IA => pres_state_FSM_Out54_wg_cy_1_LOGIC_ONE_978,
      IB => pres_state_FSM_Out54_wg_cy_1_CYINIT_991,
      SEL => pres_state_FSM_Out54_wg_cy_1_CYSELF_983,
      O => pres_state_FSM_Out54_wg_cy(0)
    );
  pres_state_FSM_Out54_wg_cy_1_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X17Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_cy_1_BXINV_981,
      O => pres_state_FSM_Out54_wg_cy_1_CYINIT_991
    );
  pres_state_FSM_Out54_wg_cy_1_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X17Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_lut(0),
      O => pres_state_FSM_Out54_wg_cy_1_CYSELF_983
    );
  pres_state_FSM_Out54_wg_cy_1_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X17Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => '0',
      O => pres_state_FSM_Out54_wg_cy_1_BXINV_981
    );
  pres_state_FSM_Out54_wg_cy_1_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X17Y17"
    )
    port map (
      IA => pres_state_FSM_Out54_wg_cy_1_LOGIC_ONE_978,
      IB => pres_state_FSM_Out54_wg_cy(0),
      SEL => pres_state_FSM_Out54_wg_cy_1_CYSELG_972,
      O => pres_state_FSM_Out54_wg_cy_1_CYMUXG_980
    );
  pres_state_FSM_Out54_wg_cy_1_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X17Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_lut(1),
      O => pres_state_FSM_Out54_wg_cy_1_CYSELG_972
    );
  pres_state_FSM_Out54_wg_lut_1_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X17Y17"
    )
    port map (
      ADR0 => pres_state_FSM_FFd23_492,
      ADR1 => pres_state_FSM_FFd8_493,
      ADR2 => pres_state_FSM_FFd14_490,
      ADR3 => pres_state_FSM_FFd11_491,
      O => pres_state_FSM_Out54_wg_lut(1)
    );
  pres_state_FSM_Out54_wg_cy_3_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X17Y18"
    )
    port map (
      O => pres_state_FSM_Out54_wg_cy_3_LOGIC_ONE_1009
    );
  pres_state_FSM_Out54_wg_cy_3_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X17Y18"
    )
    port map (
      IA => pres_state_FSM_Out54_wg_cy_3_LOGIC_ONE_1009,
      IB => pres_state_FSM_Out54_wg_cy_3_LOGIC_ONE_1009,
      SEL => pres_state_FSM_Out54_wg_cy_3_CYSELF_1015,
      O => pres_state_FSM_Out54_wg_cy_3_CYMUXF2_1010
    );
  pres_state_FSM_Out54_wg_cy_3_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X17Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_lut(2),
      O => pres_state_FSM_Out54_wg_cy_3_CYSELF_1015
    );
  pres_state_FSM_Out54_wg_cy_3_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X17Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_cy_1_CYMUXG_980,
      O => pres_state_FSM_Out54_wg_cy_3_FASTCARRY_1012
    );
  pres_state_FSM_Out54_wg_cy_3_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X17Y18"
    )
    port map (
      I0 => pres_state_FSM_Out54_wg_cy_3_CYSELG_1003,
      I1 => pres_state_FSM_Out54_wg_cy_3_CYSELF_1015,
      O => pres_state_FSM_Out54_wg_cy_3_CYAND_1013
    );
  pres_state_FSM_Out54_wg_cy_3_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X17Y18"
    )
    port map (
      IA => pres_state_FSM_Out54_wg_cy_3_CYMUXG2_1011,
      IB => pres_state_FSM_Out54_wg_cy_3_FASTCARRY_1012,
      SEL => pres_state_FSM_Out54_wg_cy_3_CYAND_1013,
      O => pres_state_FSM_Out54_wg_cy_3_CYMUXFAST_1014
    );
  pres_state_FSM_Out54_wg_cy_3_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X17Y18"
    )
    port map (
      IA => pres_state_FSM_Out54_wg_cy_3_LOGIC_ONE_1009,
      IB => pres_state_FSM_Out54_wg_cy_3_CYMUXF2_1010,
      SEL => pres_state_FSM_Out54_wg_cy_3_CYSELG_1003,
      O => pres_state_FSM_Out54_wg_cy_3_CYMUXG2_1011
    );
  pres_state_FSM_Out54_wg_cy_3_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X17Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_lut(3),
      O => pres_state_FSM_Out54_wg_cy_3_CYSELG_1003
    );
  pres_state_FSM_Out54_wg_lut_3_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X17Y18"
    )
    port map (
      ADR0 => pres_state_FSM_FFd50_499,
      ADR1 => pres_state_FSM_FFd47_500,
      ADR2 => pres_state_FSM_FFd32_501,
      ADR3 => pres_state_FSM_FFd44_502,
      O => pres_state_FSM_Out54_wg_lut(3)
    );
  en_OBUF_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X17Y19"
    )
    port map (
      O => en_OBUF_LOGIC_ONE_1036
    );
  en_OBUF_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X17Y19"
    )
    port map (
      IA => en_OBUF_LOGIC_ONE_1036,
      IB => en_OBUF_CYINIT_1035,
      SEL => en_OBUF_CYSELF_1029,
      O => en_OBUF_508
    );
  en_OBUF_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X17Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_cy_3_CYMUXFAST_1014,
      O => en_OBUF_CYINIT_1035
    );
  en_OBUF_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X17Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out54_wg_lut(4),
      O => en_OBUF_CYSELF_1029
    );
  pres_state_FSM_Out54_wg_lut_4_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X17Y19"
    )
    port map (
      ADR0 => pres_state_FSM_FFd41_504,
      ADR1 => pres_state_FSM_FFd38_505,
      ADR2 => pres_state_FSM_FFd26_506,
      ADR3 => pres_state_FSM_FFd35_507,
      O => pres_state_FSM_Out54_wg_lut(4)
    );
  dataLCD_or0000_wg_cy_1_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y16"
    )
    port map (
      O => dataLCD_or0000_wg_cy_1_LOGIC_ONE_1054
    );
  dataLCD_or0000_wg_cy_1_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X15Y16"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_1_LOGIC_ONE_1054,
      IB => dataLCD_or0000_wg_cy_1_CYINIT_1065,
      SEL => dataLCD_or0000_wg_cy_1_CYSELF_1059,
      O => dataLCD_or0000_wg_cy(0)
    );
  dataLCD_or0000_wg_cy_1_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_1_BXINV_1057,
      O => dataLCD_or0000_wg_cy_1_CYINIT_1065
    );
  dataLCD_or0000_wg_cy_1_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(0),
      O => dataLCD_or0000_wg_cy_1_CYSELF_1059
    );
  dataLCD_or0000_wg_cy_1_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => '0',
      O => dataLCD_or0000_wg_cy_1_BXINV_1057
    );
  dataLCD_or0000_wg_cy_1_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X15Y16"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_1_LOGIC_ONE_1054,
      IB => dataLCD_or0000_wg_cy(0),
      SEL => dataLCD_or0000_wg_cy_1_CYSELG_1048,
      O => dataLCD_or0000_wg_cy_1_CYMUXG_1056
    );
  dataLCD_or0000_wg_cy_1_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(1),
      O => dataLCD_or0000_wg_cy_1_CYSELG_1048
    );
  dataLCD_or0000_wg_lut_1_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y16"
    )
    port map (
      ADR0 => pres_state_FSM_FFd40_512,
      ADR1 => pres_state_FSM_FFd29_497,
      ADR2 => pres_state_FSM_FFd32_501,
      ADR3 => pres_state_FSM_FFd31_511,
      O => dataLCD_or0000_wg_lut(1)
    );
  dataLCD_or0000_wg_cy_3_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      O => dataLCD_or0000_wg_cy_3_LOGIC_ONE_1083
    );
  dataLCD_or0000_wg_cy_3_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_3_LOGIC_ONE_1083,
      IB => dataLCD_or0000_wg_cy_3_LOGIC_ONE_1083,
      SEL => dataLCD_or0000_wg_cy_3_CYSELF_1089,
      O => dataLCD_or0000_wg_cy_3_CYMUXF2_1084
    );
  dataLCD_or0000_wg_cy_3_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(2),
      O => dataLCD_or0000_wg_cy_3_CYSELF_1089
    );
  dataLCD_or0000_wg_cy_3_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X15Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_1_CYMUXG_1056,
      O => dataLCD_or0000_wg_cy_3_FASTCARRY_1086
    );
  dataLCD_or0000_wg_cy_3_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      I0 => dataLCD_or0000_wg_cy_3_CYSELG_1077,
      I1 => dataLCD_or0000_wg_cy_3_CYSELF_1089,
      O => dataLCD_or0000_wg_cy_3_CYAND_1087
    );
  dataLCD_or0000_wg_cy_3_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_3_CYMUXG2_1085,
      IB => dataLCD_or0000_wg_cy_3_FASTCARRY_1086,
      SEL => dataLCD_or0000_wg_cy_3_CYAND_1087,
      O => dataLCD_or0000_wg_cy_3_CYMUXFAST_1088
    );
  dataLCD_or0000_wg_cy_3_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_3_LOGIC_ONE_1083,
      IB => dataLCD_or0000_wg_cy_3_CYMUXF2_1084,
      SEL => dataLCD_or0000_wg_cy_3_CYSELG_1077,
      O => dataLCD_or0000_wg_cy_3_CYMUXG2_1085
    );
  dataLCD_or0000_wg_cy_3_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(3),
      O => dataLCD_or0000_wg_cy_3_CYSELG_1077
    );
  dataLCD_or0000_wg_lut_3_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y17"
    )
    port map (
      ADR0 => pres_state_FSM_FFd22_517,
      ADR1 => pres_state_FSM_FFd20_488,
      ADR2 => pres_state_FSM_FFd43_516,
      ADR3 => pres_state_FSM_FFd23_492,
      O => dataLCD_or0000_wg_lut(3)
    );
  dataLCD_or0000_wg_cy_5_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      O => dataLCD_or0000_wg_cy_5_LOGIC_ONE_1113
    );
  dataLCD_or0000_wg_cy_5_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_5_LOGIC_ONE_1113,
      IB => dataLCD_or0000_wg_cy_5_LOGIC_ONE_1113,
      SEL => dataLCD_or0000_wg_cy_5_CYSELF_1119,
      O => dataLCD_or0000_wg_cy_5_CYMUXF2_1114
    );
  dataLCD_or0000_wg_cy_5_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(4),
      O => dataLCD_or0000_wg_cy_5_CYSELF_1119
    );
  dataLCD_or0000_wg_cy_5_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_3_CYMUXFAST_1088,
      O => dataLCD_or0000_wg_cy_5_FASTCARRY_1116
    );
  dataLCD_or0000_wg_cy_5_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      I0 => dataLCD_or0000_wg_cy_5_CYSELG_1107,
      I1 => dataLCD_or0000_wg_cy_5_CYSELF_1119,
      O => dataLCD_or0000_wg_cy_5_CYAND_1117
    );
  dataLCD_or0000_wg_cy_5_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_5_CYMUXG2_1115,
      IB => dataLCD_or0000_wg_cy_5_FASTCARRY_1116,
      SEL => dataLCD_or0000_wg_cy_5_CYAND_1117,
      O => dataLCD_or0000_wg_cy_5_CYMUXFAST_1118
    );
  dataLCD_or0000_wg_cy_5_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_5_LOGIC_ONE_1113,
      IB => dataLCD_or0000_wg_cy_5_CYMUXF2_1114,
      SEL => dataLCD_or0000_wg_cy_5_CYSELG_1107,
      O => dataLCD_or0000_wg_cy_5_CYMUXG2_1115
    );
  dataLCD_or0000_wg_cy_5_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(5),
      O => dataLCD_or0000_wg_cy_5_CYSELG_1107
    );
  dataLCD_or0000_wg_lut_5_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y18"
    )
    port map (
      ADR0 => pres_state_FSM_FFd11_491,
      ADR1 => pres_state_FSM_FFd14_490,
      ADR2 => pres_state_FSM_FFd46_522,
      ADR3 => pres_state_FSM_FFd13_521,
      O => dataLCD_or0000_wg_lut(5)
    );
  dataLCD_or0000_wg_cy_7_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      O => dataLCD_or0000_wg_cy_7_LOGIC_ONE_1143
    );
  dataLCD_or0000_wg_cy_7_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_7_LOGIC_ONE_1143,
      IB => dataLCD_or0000_wg_cy_7_LOGIC_ONE_1143,
      SEL => dataLCD_or0000_wg_cy_7_CYSELF_1149,
      O => dataLCD_or0000_wg_cy_7_CYMUXF2_1144
    );
  dataLCD_or0000_wg_cy_7_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(6),
      O => dataLCD_or0000_wg_cy_7_CYSELF_1149
    );
  dataLCD_or0000_wg_cy_7_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_5_CYMUXFAST_1118,
      O => dataLCD_or0000_wg_cy_7_FASTCARRY_1146
    );
  dataLCD_or0000_wg_cy_7_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      I0 => dataLCD_or0000_wg_cy_7_CYSELG_1137,
      I1 => dataLCD_or0000_wg_cy_7_CYSELF_1149,
      O => dataLCD_or0000_wg_cy_7_CYAND_1147
    );
  dataLCD_or0000_wg_cy_7_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_7_CYMUXG2_1145,
      IB => dataLCD_or0000_wg_cy_7_FASTCARRY_1146,
      SEL => dataLCD_or0000_wg_cy_7_CYAND_1147,
      O => dataLCD_or0000_wg_cy_7_CYMUXFAST_1148
    );
  dataLCD_or0000_wg_cy_7_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_7_LOGIC_ONE_1143,
      IB => dataLCD_or0000_wg_cy_7_CYMUXF2_1144,
      SEL => dataLCD_or0000_wg_cy_7_CYSELG_1137,
      O => dataLCD_or0000_wg_cy_7_CYMUXG2_1145
    );
  dataLCD_or0000_wg_cy_7_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(7),
      O => dataLCD_or0000_wg_cy_7_CYSELG_1137
    );
  dataLCD_or0000_wg_lut_7_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y19"
    )
    port map (
      ADR0 => pres_state_FSM_FFd50_499,
      ADR1 => pres_state_FSM_FFd5_496,
      ADR2 => pres_state_FSM_FFd4_527,
      ADR3 => pres_state_FSM_FFd2_498,
      O => dataLCD_or0000_wg_lut(7)
    );
  dataLCD_or0000_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y20"
    )
    port map (
      O => dataLCD_or0000_LOGIC_ONE_1170
    );
  dataLCD_or0000_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X15Y20"
    )
    port map (
      IA => dataLCD_or0000_LOGIC_ONE_1170,
      IB => dataLCD_or0000_CYINIT_1169,
      SEL => dataLCD_or0000_CYSELF_1163,
      O => dataLCD_or0000
    );
  dataLCD_or0000_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X15Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_7_CYMUXFAST_1148,
      O => dataLCD_or0000_CYINIT_1169
    );
  dataLCD_or0000_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(8),
      O => dataLCD_or0000_CYSELF_1163
    );
  dataLCD_or0000_wg_lut_8_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y20"
    )
    port map (
      ADR0 => pres_state_FSM_FFd47_500,
      ADR1 => pres_state_FSM_FFd1_529,
      ADR2 => pres_state_FSM_FFd53_495,
      ADR3 => pres_state_FSM_FFd52_530,
      O => dataLCD_or0000_wg_lut(8)
    );
  en_OBUF : X_OBUF
    generic map(
      LOC => "PAD59"
    )
    port map (
      I => en_O,
      O => en
    );
  rs_OBUF : X_OBUF
    generic map(
      LOC => "PAD60"
    )
    port map (
      I => rs_O,
      O => rs
    );
  rs_OUTPUT_OFF_O1_DDRMUX : X_BUF
    generic map(
      LOC => "PAD60",
      PATHPULSE => 592 ps
    )
    port map (
      I => rs_mux0000,
      O => rs_OUTPUT_OFF_ODDRIN1_MUX
    );
  rs_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD60",
      PATHPULSE => 592 ps
    )
    port map (
      I => rs_OBUF_1193,
      O => rs_O
    );
  rs_586 : X_LATCHE
    generic map(
      LOC => "PAD60",
      INIT => '0'
    )
    port map (
      I => rs_OUTPUT_OFF_ODDRIN1_MUX,
      GE => VCC,
      CLK => NlwInverterSignal_rs_CLK,
      SET => GND,
      RST => GND,
      O => rs_OBUF_1193
    );
  rs_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD60",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => rs_OUTPUT_OTCLK1INV_1187
    );
  dataLCD_0_OBUF : X_OBUF
    generic map(
      LOC => "PAD44"
    )
    port map (
      I => dataLCD_0_O,
      O => dataLCD(0)
    );
  dataLCD_0_OUTPUT_OFF_O1_DDRMUX : X_BUF
    generic map(
      LOC => "PAD44",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_mux0000_0_F5MUX_1311,
      O => dataLCD_0_OUTPUT_OFF_ODDRIN1_MUX
    );
  dataLCD_0_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD44",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_0_1210,
      O => dataLCD_0_O
    );
  dataLCD_0 : X_LATCHE
    generic map(
      LOC => "PAD44",
      INIT => '0'
    )
    port map (
      I => dataLCD_0_OUTPUT_OFF_ODDRIN1_MUX,
      GE => VCC,
      CLK => NlwInverterSignal_dataLCD_0_CLK,
      SET => GND,
      RST => GND,
      O => dataLCD_0_1210
    );
  dataLCD_0_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD44",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_0_OUTPUT_OTCLK1INV_1204
    );
  dataLCD_1_OBUF : X_OBUF
    generic map(
      LOC => "PAD43"
    )
    port map (
      I => dataLCD_1_O,
      O => dataLCD(1)
    );
  dataLCD_1_OUTPUT_OFF_O1_DDRMUX : X_BUF
    generic map(
      LOC => "PAD43",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_mux0000(1),
      O => dataLCD_1_OUTPUT_OFF_ODDRIN1_MUX
    );
  dataLCD_1_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD43",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_1_1227,
      O => dataLCD_1_O
    );
  dataLCD_1 : X_LATCHE
    generic map(
      LOC => "PAD43",
      INIT => '0'
    )
    port map (
      I => dataLCD_1_OUTPUT_OFF_ODDRIN1_MUX,
      GE => VCC,
      CLK => NlwInverterSignal_dataLCD_1_CLK,
      SET => GND,
      RST => GND,
      O => dataLCD_1_1227
    );
  dataLCD_1_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD43",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_1_OUTPUT_OTCLK1INV_1221
    );
  dataLCD_2_OBUF : X_OBUF
    generic map(
      LOC => "PAD25"
    )
    port map (
      I => dataLCD_2_O,
      O => dataLCD(2)
    );
  dataLCD_2_OUTPUT_OFF_O1_DDRMUX : X_BUF
    generic map(
      LOC => "PAD25",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_mux0000(2),
      O => dataLCD_2_OUTPUT_OFF_ODDRIN1_MUX
    );
  dataLCD_2_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD25",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_2_1244,
      O => dataLCD_2_O
    );
  dataLCD_2 : X_LATCHE
    generic map(
      LOC => "PAD25",
      INIT => '0'
    )
    port map (
      I => dataLCD_2_OUTPUT_OFF_ODDRIN1_MUX,
      GE => VCC,
      CLK => NlwInverterSignal_dataLCD_2_CLK,
      SET => GND,
      RST => GND,
      O => dataLCD_2_1244
    );
  dataLCD_2_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD25",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_2_OUTPUT_OTCLK1INV_1238
    );
  dataLCD_3_OBUF : X_OBUF
    generic map(
      LOC => "PAD24"
    )
    port map (
      I => dataLCD_3_O,
      O => dataLCD(3)
    );
  dataLCD_3_OUTPUT_OFF_O1_DDRMUX : X_BUF
    generic map(
      LOC => "PAD24",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_mux0000(3),
      O => dataLCD_3_OUTPUT_OFF_ODDRIN1_MUX
    );
  dataLCD_3_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD24",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_3_1261,
      O => dataLCD_3_O
    );
  dataLCD_3 : X_LATCHE
    generic map(
      LOC => "PAD24",
      INIT => '0'
    )
    port map (
      I => dataLCD_3_OUTPUT_OFF_ODDRIN1_MUX,
      GE => VCC,
      CLK => NlwInverterSignal_dataLCD_3_CLK,
      SET => GND,
      RST => GND,
      O => dataLCD_3_1261
    );
  dataLCD_3_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD24",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_3_OUTPUT_OTCLK1INV_1255
    );
  clock_BUFGP_IBUFG : X_BUF
    generic map(
      LOC => "PAD92",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock,
      O => clock_BUFGP_IBUFG_1270
    );
  reset_IBUF : X_BUF
    generic map(
      LOC => "PAD91",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset,
      O => reset_IBUF_1277
    );
  BUFG_inst : X_BUFGMUX
    generic map(
      LOC => "BUFGMUX_X1Y10"
    )
    port map (
      I0 => BUFG_inst_I0_INV,
      I1 => GND,
      S => BUFG_inst_S_INVNOT,
      O => clock_o
    );
  BUFG_inst_SINV : X_INV
    generic map(
      LOC => "BUFGMUX_X1Y10",
      PATHPULSE => 592 ps
    )
    port map (
      I => '1',
      O => BUFG_inst_S_INVNOT
    );
  BUFG_inst_I0_USED : X_BUF
    generic map(
      LOC => "BUFGMUX_X1Y10",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s(16),
      O => BUFG_inst_I0_INV
    );
  clock_BUFGP_BUFG : X_BUFGMUX
    generic map(
      LOC => "BUFGMUX_X2Y1"
    )
    port map (
      I0 => clock_BUFGP_BUFG_I0_INV,
      I1 => GND,
      S => clock_BUFGP_BUFG_S_INVNOT,
      O => clock_BUFGP
    );
  clock_BUFGP_BUFG_SINV : X_INV
    generic map(
      LOC => "BUFGMUX_X2Y1",
      PATHPULSE => 592 ps
    )
    port map (
      I => '1',
      O => clock_BUFGP_BUFG_S_INVNOT
    );
  clock_BUFGP_BUFG_I0_USED : X_BUF
    generic map(
      LOC => "BUFGMUX_X2Y1",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP_IBUFG_1270,
      O => clock_BUFGP_BUFG_I0_INV
    );
  dataLCD_mux0000_0_F5MUX : X_MUX2
    generic map(
      LOC => "SLICE_X16Y23"
    )
    port map (
      IA => dataLCD_mux0000_0_1_1298,
      IB => dataLCD_mux0000_0_F,
      SEL => dataLCD_mux0000_0_BXINV_1300,
      O => dataLCD_mux0000_0_F5MUX_1311
    );
  dataLCD_mux0000_0_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd54_541,
      O => dataLCD_mux0000_0_BXINV_1300
    );
  dataLCD_mux0000_0_1 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X16Y23"
    )
    port map (
      ADR0 => pres_state_FSM_FFd51_545,
      ADR1 => pres_state_FSM_FFd48_544,
      ADR2 => pres_state_FSM_FFd21_542,
      ADR3 => pres_state_FSM_FFd27_543,
      O => dataLCD_mux0000_0_1_1298
    );
  pres_state_FSM_FFd10_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd11_491,
      O => pres_state_FSM_FFd10_DXMUX_1330
    );
  pres_state_FSM_FFd10_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd10_525,
      O => pres_state_FSM_FFd10_DYMUX_1322
    );
  pres_state_FSM_FFd10_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd10_SRINVNOT
    );
  pres_state_FSM_FFd10_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd10_CLKINV_1319
    );
  pres_state_FSM_FFd12_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd13_521,
      O => pres_state_FSM_FFd12_DXMUX_1354
    );
  pres_state_FSM_FFd12_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd12_547,
      O => pres_state_FSM_FFd12_DYMUX_1346
    );
  pres_state_FSM_FFd12_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd12_SRINVNOT
    );
  pres_state_FSM_FFd12_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd12_CLKINV_1343
    );
  pres_state_FSM_FFd14_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd15_548,
      O => pres_state_FSM_FFd14_DXMUX_1378
    );
  pres_state_FSM_FFd14_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd14_490,
      O => pres_state_FSM_FFd14_DYMUX_1370
    );
  pres_state_FSM_FFd14_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd14_SRINVNOT
    );
  pres_state_FSM_FFd14_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd14_CLKINV_1367
    );
  pres_state_FSM_FFd22_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd23_492,
      O => pres_state_FSM_FFd22_DXMUX_1402
    );
  pres_state_FSM_FFd22_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd22_517,
      O => pres_state_FSM_FFd22_DYMUX_1394
    );
  pres_state_FSM_FFd22_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd22_SRINVNOT
    );
  pres_state_FSM_FFd22_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd22_CLKINV_1391
    );
  pres_state_FSM_FFd16_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd17_489,
      O => pres_state_FSM_FFd16_DXMUX_1426
    );
  pres_state_FSM_FFd16_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd16_520,
      O => pres_state_FSM_FFd16_DYMUX_1418
    );
  pres_state_FSM_FFd16_SRINV : X_INV
    generic map(
      LOC => "SLICE_X13Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd16_SRINVNOT
    );
  pres_state_FSM_FFd16_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd16_CLKINV_1415
    );
  pres_state_FSM_FFd24_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd25_515,
      O => pres_state_FSM_FFd24_DXMUX_1450
    );
  pres_state_FSM_FFd24_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd24_549,
      O => pres_state_FSM_FFd24_DYMUX_1442
    );
  pres_state_FSM_FFd24_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd24_SRINVNOT
    );
  pres_state_FSM_FFd24_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd24_CLKINV_1439
    );
  pres_state_FSM_FFd32_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd33_550,
      O => pres_state_FSM_FFd32_DXMUX_1474
    );
  pres_state_FSM_FFd32_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd32_501,
      O => pres_state_FSM_FFd32_DYMUX_1466
    );
  pres_state_FSM_FFd32_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd32_SRINVNOT
    );
  pres_state_FSM_FFd32_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd32_CLKINV_1463
    );
  pres_state_FSM_FFd18_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd19_519,
      O => pres_state_FSM_FFd18_DXMUX_1498
    );
  pres_state_FSM_FFd18_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd18_551,
      O => pres_state_FSM_FFd18_DYMUX_1490
    );
  pres_state_FSM_FFd18_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd18_SRINVNOT
    );
  pres_state_FSM_FFd18_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd18_CLKINV_1487
    );
  pres_state_FSM_FFd26_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd27_543,
      O => pres_state_FSM_FFd26_DXMUX_1522
    );
  pres_state_FSM_FFd26_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd26_506,
      O => pres_state_FSM_FFd26_DYMUX_1514
    );
  pres_state_FSM_FFd26_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd26_SRINVNOT
    );
  pres_state_FSM_FFd26_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd26_CLKINV_1511
    );
  pres_state_FSM_FFd34_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd35_507,
      O => pres_state_FSM_FFd34_DXMUX_1546
    );
  pres_state_FSM_FFd34_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd34_509,
      O => pres_state_FSM_FFd34_DYMUX_1538
    );
  pres_state_FSM_FFd34_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd34_SRINVNOT
    );
  pres_state_FSM_FFd34_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd34_CLKINV_1535
    );
  pres_state_FSM_FFd42_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd43_516,
      O => pres_state_FSM_FFd42_DXMUX_1570
    );
  pres_state_FSM_FFd42_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd42_552,
      O => pres_state_FSM_FFd42_DYMUX_1562
    );
  pres_state_FSM_FFd42_SRINV : X_INV
    generic map(
      LOC => "SLICE_X17Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd42_SRINVNOT
    );
  pres_state_FSM_FFd42_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X17Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd42_CLKINV_1559
    );
  pres_state_FSM_FFd20_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd21_542,
      O => pres_state_FSM_FFd20_DXMUX_1594
    );
  pres_state_FSM_FFd20_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd20_488,
      O => pres_state_FSM_FFd20_DYMUX_1586
    );
  pres_state_FSM_FFd20_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd20_SRINVNOT
    );
  pres_state_FSM_FFd20_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd20_CLKINV_1583
    );
  pres_state_FSM_FFd28_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd29_497,
      O => pres_state_FSM_FFd28_DXMUX_1618
    );
  pres_state_FSM_FFd28_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd28_514,
      O => pres_state_FSM_FFd28_DYMUX_1610
    );
  pres_state_FSM_FFd28_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd28_SRINVNOT
    );
  pres_state_FSM_FFd28_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd28_CLKINV_1607
    );
  pres_state_FSM_FFd36_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd37_510,
      O => pres_state_FSM_FFd36_DXMUX_1642
    );
  pres_state_FSM_FFd36_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd36_553,
      O => pres_state_FSM_FFd36_DYMUX_1634
    );
  pres_state_FSM_FFd36_SRINV : X_INV
    generic map(
      LOC => "SLICE_X13Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd36_SRINVNOT
    );
  pres_state_FSM_FFd36_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd36_CLKINV_1631
    );
  pres_state_FSM_FFd44_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd45_554,
      O => pres_state_FSM_FFd44_DXMUX_1666
    );
  pres_state_FSM_FFd44_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd44_502,
      O => pres_state_FSM_FFd44_DYMUX_1658
    );
  pres_state_FSM_FFd44_SRINV : X_INV
    generic map(
      LOC => "SLICE_X16Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd44_SRINVNOT
    );
  pres_state_FSM_FFd44_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd44_CLKINV_1655
    );
  pres_state_FSM_FFd52_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd53_495,
      O => pres_state_FSM_FFd52_DXMUX_1690
    );
  pres_state_FSM_FFd52_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd52_530,
      O => pres_state_FSM_FFd52_DYMUX_1682
    );
  pres_state_FSM_FFd52_SRINV : X_INV
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd52_SRINVNOT
    );
  pres_state_FSM_FFd52_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd52_CLKINV_1679
    );
  pres_state_FSM_FFd30_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd31_511,
      O => pres_state_FSM_FFd30_DXMUX_1714
    );
  pres_state_FSM_FFd30_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd30_555,
      O => pres_state_FSM_FFd30_DYMUX_1706
    );
  pres_state_FSM_FFd30_SRINV : X_INV
    generic map(
      LOC => "SLICE_X13Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd30_SRINVNOT
    );
  pres_state_FSM_FFd30_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd30_CLKINV_1703
    );
  pres_state_FSM_FFd38_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd39_556,
      O => pres_state_FSM_FFd38_DXMUX_1738
    );
  pres_state_FSM_FFd38_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd38_505,
      O => pres_state_FSM_FFd38_DYMUX_1730
    );
  pres_state_FSM_FFd38_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd38_SRINVNOT
    );
  pres_state_FSM_FFd38_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd38_CLKINV_1727
    );
  pres_state_FSM_FFd46_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd47_500,
      O => pres_state_FSM_FFd46_DXMUX_1762
    );
  pres_state_FSM_FFd46_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd46_522,
      O => pres_state_FSM_FFd46_DYMUX_1754
    );
  pres_state_FSM_FFd46_SRINV : X_INV
    generic map(
      LOC => "SLICE_X16Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd46_SRINVNOT
    );
  pres_state_FSM_FFd46_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd46_CLKINV_1751
    );
  pres_state_FSM_FFd54_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd54_BXINV_1785,
      O => pres_state_FSM_FFd54_DXMUX_1786
    );
  pres_state_FSM_FFd54_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X17Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => '0',
      O => pres_state_FSM_FFd54_BXINV_1785
    );
  pres_state_FSM_FFd54_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd54_541,
      O => pres_state_FSM_FFd54_DYMUX_1778
    );
  pres_state_FSM_FFd54_SRINV : X_INV
    generic map(
      LOC => "SLICE_X17Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd54_SRINVNOT
    );
  pres_state_FSM_FFd54_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X17Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd54_CLKINV_1775
    );
  pres_state_FSM_FFd40_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd41_504,
      O => pres_state_FSM_FFd40_DXMUX_1809
    );
  pres_state_FSM_FFd40_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd40_512,
      O => pres_state_FSM_FFd40_DYMUX_1801
    );
  pres_state_FSM_FFd40_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd40_SRINVNOT
    );
  pres_state_FSM_FFd40_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd40_CLKINV_1798
    );
  pres_state_FSM_FFd48_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd49_526,
      O => pres_state_FSM_FFd48_DXMUX_1833
    );
  pres_state_FSM_FFd48_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd48_544,
      O => pres_state_FSM_FFd48_DYMUX_1825
    );
  pres_state_FSM_FFd48_SRINV : X_INV
    generic map(
      LOC => "SLICE_X16Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd48_SRINVNOT
    );
  pres_state_FSM_FFd48_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd48_CLKINV_1822
    );
  pres_state_FSM_FFd50_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd51_545,
      O => pres_state_FSM_FFd50_DXMUX_1857
    );
  pres_state_FSM_FFd50_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd50_499,
      O => pres_state_FSM_FFd50_DYMUX_1849
    );
  pres_state_FSM_FFd50_SRINV : X_INV
    generic map(
      LOC => "SLICE_X16Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd50_SRINVNOT
    );
  pres_state_FSM_FFd50_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd50_CLKINV_1846
    );
  rs_mux00001 : X_LUT4
    generic map(
      INIT => X"FCFC",
      LOC => "SLICE_X16Y21"
    )
    port map (
      ADR0 => VCC,
      ADR1 => pres_state_FSM_FFd3_558,
      ADR2 => pres_state_FSM_FFd6_557,
      ADR3 => VCC,
      O => rs_mux0000
    );
  dataLCD_mux0000_3_1 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X15Y15"
    )
    port map (
      ADR0 => pres_state_FSM_FFd33_550,
      ADR1 => pres_state_FSM_FFd3_558,
      ADR2 => pres_state_FSM_FFd9_546,
      ADR3 => pres_state_FSM_FFd39_556,
      O => dataLCD_mux0000(3)
    );
  pres_state_FSM_FFd1_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd1_BYINV_1908,
      O => pres_state_FSM_FFd1_DYMUX_1909
    );
  pres_state_FSM_FFd1_BYINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => '1',
      O => pres_state_FSM_FFd1_BYINV_1908
    );
  pres_state_FSM_FFd1_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd1_CLKINV_1906
    );
  pres_state_FSM_FFd1_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd2_498,
      O => pres_state_FSM_FFd1_CEINV_1905
    );
  pres_state_FSM_FFd2_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd3_558,
      O => pres_state_FSM_FFd2_DYMUX_1924
    );
  pres_state_FSM_FFd2_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd2_CLKINV_1921
    );
  pres_state_FSM_FFd4_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd5_496,
      O => pres_state_FSM_FFd4_DXMUX_1948
    );
  pres_state_FSM_FFd4_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd4_527,
      O => pres_state_FSM_FFd4_DYMUX_1940
    );
  pres_state_FSM_FFd4_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd4_SRINVNOT
    );
  pres_state_FSM_FFd4_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd4_CLKINV_1937
    );
  dataLCD_mux0000_1_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X17Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => N2_pack_1,
      O => N2
    );
  dataLCD_mux0000_1_SW0 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X17Y22"
    )
    port map (
      ADR0 => pres_state_FSM_FFd54_541,
      ADR1 => pres_state_FSM_FFd51_545,
      ADR2 => pres_state_FSM_FFd48_544,
      ADR3 => pres_state_FSM_FFd45_554,
      O => N2_pack_1
    );
  pres_state_FSM_FFd6_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd7_524,
      O => pres_state_FSM_FFd6_DXMUX_1996
    );
  pres_state_FSM_FFd6_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd6_557,
      O => pres_state_FSM_FFd6_DYMUX_1988
    );
  pres_state_FSM_FFd6_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd6_SRINVNOT
    );
  pres_state_FSM_FFd6_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd6_CLKINV_1985
    );
  pres_state_FSM_FFd8_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd9_546,
      O => pres_state_FSM_FFd8_DXMUX_2020
    );
  pres_state_FSM_FFd8_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd8_493,
      O => pres_state_FSM_FFd8_DYMUX_2012
    );
  pres_state_FSM_FFd8_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd8_SRINVNOT
    );
  pres_state_FSM_FFd8_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd8_CLKINV_2009
    );
  Mcount_clk_s_lut_0_INV_0 : X_LUT4
    generic map(
      INIT => X"0F0F",
      LOC => "SLICE_X19Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => clk_s(0),
      ADR3 => VCC,
      O => Mcount_clk_s_lut(0)
    );
  clk_s_0 : X_FF
    generic map(
      LOC => "SLICE_X19Y23",
      INIT => '0'
    )
    port map (
      I => clk_s_0_DXMUX_602,
      CE => VCC,
      CLK => clk_s_0_CLKINV_567,
      SET => GND,
      RST => GND,
      O => clk_s(0)
    );
  clk_s_3 : X_FF
    generic map(
      LOC => "SLICE_X19Y24",
      INIT => '0'
    )
    port map (
      I => clk_s_2_DYMUX_634,
      CE => VCC,
      CLK => clk_s_2_CLKINV_613,
      SET => GND,
      RST => GND,
      O => clk_s(3)
    );
  clk_s_2 : X_FF
    generic map(
      LOC => "SLICE_X19Y24",
      INIT => '0'
    )
    port map (
      I => clk_s_2_DXMUX_650,
      CE => VCC,
      CLK => clk_s_2_CLKINV_613,
      SET => GND,
      RST => GND,
      O => clk_s(2)
    );
  clk_s_5 : X_FF
    generic map(
      LOC => "SLICE_X19Y25",
      INIT => '0'
    )
    port map (
      I => clk_s_4_DYMUX_682,
      CE => VCC,
      CLK => clk_s_4_CLKINV_661,
      SET => GND,
      RST => GND,
      O => clk_s(5)
    );
  clk_s_4 : X_FF
    generic map(
      LOC => "SLICE_X19Y25",
      INIT => '0'
    )
    port map (
      I => clk_s_4_DXMUX_698,
      CE => VCC,
      CLK => clk_s_4_CLKINV_661,
      SET => GND,
      RST => GND,
      O => clk_s(4)
    );
  clk_s_7 : X_FF
    generic map(
      LOC => "SLICE_X19Y26",
      INIT => '0'
    )
    port map (
      I => clk_s_6_DYMUX_730,
      CE => VCC,
      CLK => clk_s_6_CLKINV_709,
      SET => GND,
      RST => GND,
      O => clk_s(7)
    );
  clk_s_6 : X_FF
    generic map(
      LOC => "SLICE_X19Y26",
      INIT => '0'
    )
    port map (
      I => clk_s_6_DXMUX_746,
      CE => VCC,
      CLK => clk_s_6_CLKINV_709,
      SET => GND,
      RST => GND,
      O => clk_s(6)
    );
  clk_s_9 : X_FF
    generic map(
      LOC => "SLICE_X19Y27",
      INIT => '0'
    )
    port map (
      I => clk_s_8_DYMUX_778,
      CE => VCC,
      CLK => clk_s_8_CLKINV_757,
      SET => GND,
      RST => GND,
      O => clk_s(9)
    );
  clk_s_8 : X_FF
    generic map(
      LOC => "SLICE_X19Y27",
      INIT => '0'
    )
    port map (
      I => clk_s_8_DXMUX_794,
      CE => VCC,
      CLK => clk_s_8_CLKINV_757,
      SET => GND,
      RST => GND,
      O => clk_s(8)
    );
  clk_s_11 : X_FF
    generic map(
      LOC => "SLICE_X19Y28",
      INIT => '0'
    )
    port map (
      I => clk_s_10_DYMUX_826,
      CE => VCC,
      CLK => clk_s_10_CLKINV_805,
      SET => GND,
      RST => GND,
      O => clk_s(11)
    );
  clk_s_10 : X_FF
    generic map(
      LOC => "SLICE_X19Y28",
      INIT => '0'
    )
    port map (
      I => clk_s_10_DXMUX_842,
      CE => VCC,
      CLK => clk_s_10_CLKINV_805,
      SET => GND,
      RST => GND,
      O => clk_s(10)
    );
  clk_s_13 : X_FF
    generic map(
      LOC => "SLICE_X19Y29",
      INIT => '0'
    )
    port map (
      I => clk_s_12_DYMUX_874,
      CE => VCC,
      CLK => clk_s_12_CLKINV_853,
      SET => GND,
      RST => GND,
      O => clk_s(13)
    );
  clk_s_12 : X_FF
    generic map(
      LOC => "SLICE_X19Y29",
      INIT => '0'
    )
    port map (
      I => clk_s_12_DXMUX_890,
      CE => VCC,
      CLK => clk_s_12_CLKINV_853,
      SET => GND,
      RST => GND,
      O => clk_s(12)
    );
  clk_s_15 : X_FF
    generic map(
      LOC => "SLICE_X19Y30",
      INIT => '0'
    )
    port map (
      I => clk_s_14_DYMUX_922,
      CE => VCC,
      CLK => clk_s_14_CLKINV_901,
      SET => GND,
      RST => GND,
      O => clk_s(15)
    );
  clk_s_14 : X_FF
    generic map(
      LOC => "SLICE_X19Y30",
      INIT => '0'
    )
    port map (
      I => clk_s_14_DXMUX_938,
      CE => VCC,
      CLK => clk_s_14_CLKINV_901,
      SET => GND,
      RST => GND,
      O => clk_s(14)
    );
  clk_s_16 : X_FF
    generic map(
      LOC => "SLICE_X19Y31",
      INIT => '0'
    )
    port map (
      I => clk_s_16_DXMUX_959,
      CE => VCC,
      CLK => clk_s_16_CLKINV_946,
      SET => GND,
      RST => GND,
      O => clk_s(16)
    );
  pres_state_FSM_Out54_wg_lut_0_Q : X_LUT4
    generic map(
      INIT => X"0033",
      LOC => "SLICE_X17Y17"
    )
    port map (
      ADR0 => VCC,
      ADR1 => pres_state_FSM_FFd20_488,
      ADR2 => VCC,
      ADR3 => pres_state_FSM_FFd17_489,
      O => pres_state_FSM_Out54_wg_lut(0)
    );
  pres_state_FSM_Out54_wg_lut_2_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X17Y18"
    )
    port map (
      ADR0 => pres_state_FSM_FFd5_496,
      ADR1 => pres_state_FSM_FFd2_498,
      ADR2 => pres_state_FSM_FFd53_495,
      ADR3 => pres_state_FSM_FFd29_497,
      O => pres_state_FSM_Out54_wg_lut(2)
    );
  dataLCD_or0000_wg_lut_0_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y16"
    )
    port map (
      ADR0 => pres_state_FSM_FFd34_509,
      ADR1 => pres_state_FSM_FFd37_510,
      ADR2 => pres_state_FSM_FFd38_505,
      ADR3 => pres_state_FSM_FFd35_507,
      O => dataLCD_or0000_wg_lut(0)
    );
  dataLCD_or0000_wg_lut_2_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y17"
    )
    port map (
      ADR0 => pres_state_FSM_FFd41_504,
      ADR1 => pres_state_FSM_FFd25_515,
      ADR2 => pres_state_FSM_FFd28_514,
      ADR3 => pres_state_FSM_FFd26_506,
      O => dataLCD_or0000_wg_lut(2)
    );
  dataLCD_or0000_wg_lut_4_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y18"
    )
    port map (
      ADR0 => pres_state_FSM_FFd17_489,
      ADR1 => pres_state_FSM_FFd19_519,
      ADR2 => pres_state_FSM_FFd44_502,
      ADR3 => pres_state_FSM_FFd16_520,
      O => dataLCD_or0000_wg_lut(4)
    );
  dataLCD_or0000_wg_lut_6_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y19"
    )
    port map (
      ADR0 => pres_state_FSM_FFd49_526,
      ADR1 => pres_state_FSM_FFd7_524,
      ADR2 => pres_state_FSM_FFd8_493,
      ADR3 => pres_state_FSM_FFd10_525,
      O => dataLCD_or0000_wg_lut(6)
    );
  pres_state_FSM_FFd9 : X_FF
    generic map(
      LOC => "SLICE_X14Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd10_DYMUX_1322,
      CE => VCC,
      CLK => pres_state_FSM_FFd10_CLKINV_1319,
      SET => GND,
      RST => pres_state_FSM_FFd10_SRINVNOT,
      O => pres_state_FSM_FFd9_546
    );
  pres_state_FSM_FFd10 : X_FF
    generic map(
      LOC => "SLICE_X14Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd10_DXMUX_1330,
      CE => VCC,
      CLK => pres_state_FSM_FFd10_CLKINV_1319,
      SET => GND,
      RST => pres_state_FSM_FFd10_SRINVNOT,
      O => pres_state_FSM_FFd10_525
    );
  pres_state_FSM_FFd11 : X_FF
    generic map(
      LOC => "SLICE_X12Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd12_DYMUX_1346,
      CE => VCC,
      CLK => pres_state_FSM_FFd12_CLKINV_1343,
      SET => GND,
      RST => pres_state_FSM_FFd12_SRINVNOT,
      O => pres_state_FSM_FFd11_491
    );
  pres_state_FSM_FFd12 : X_FF
    generic map(
      LOC => "SLICE_X12Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd12_DXMUX_1354,
      CE => VCC,
      CLK => pres_state_FSM_FFd12_CLKINV_1343,
      SET => GND,
      RST => pres_state_FSM_FFd12_SRINVNOT,
      O => pres_state_FSM_FFd12_547
    );
  pres_state_FSM_FFd13 : X_FF
    generic map(
      LOC => "SLICE_X12Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd14_DYMUX_1370,
      CE => VCC,
      CLK => pres_state_FSM_FFd14_CLKINV_1367,
      SET => GND,
      RST => pres_state_FSM_FFd14_SRINVNOT,
      O => pres_state_FSM_FFd13_521
    );
  pres_state_FSM_FFd14 : X_FF
    generic map(
      LOC => "SLICE_X12Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd14_DXMUX_1378,
      CE => VCC,
      CLK => pres_state_FSM_FFd14_CLKINV_1367,
      SET => GND,
      RST => pres_state_FSM_FFd14_SRINVNOT,
      O => pres_state_FSM_FFd14_490
    );
  pres_state_FSM_FFd21 : X_FF
    generic map(
      LOC => "SLICE_X15Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd22_DYMUX_1394,
      CE => VCC,
      CLK => pres_state_FSM_FFd22_CLKINV_1391,
      SET => GND,
      RST => pres_state_FSM_FFd22_SRINVNOT,
      O => pres_state_FSM_FFd21_542
    );
  pres_state_FSM_FFd22 : X_FF
    generic map(
      LOC => "SLICE_X15Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd22_DXMUX_1402,
      CE => VCC,
      CLK => pres_state_FSM_FFd22_CLKINV_1391,
      SET => GND,
      RST => pres_state_FSM_FFd22_SRINVNOT,
      O => pres_state_FSM_FFd22_517
    );
  pres_state_FSM_FFd15 : X_FF
    generic map(
      LOC => "SLICE_X13Y23",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd16_DYMUX_1418,
      CE => VCC,
      CLK => pres_state_FSM_FFd16_CLKINV_1415,
      SET => GND,
      RST => pres_state_FSM_FFd16_SRINVNOT,
      O => pres_state_FSM_FFd15_548
    );
  pres_state_FSM_FFd16 : X_FF
    generic map(
      LOC => "SLICE_X13Y23",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd16_DXMUX_1426,
      CE => VCC,
      CLK => pres_state_FSM_FFd16_CLKINV_1415,
      SET => GND,
      RST => pres_state_FSM_FFd16_SRINVNOT,
      O => pres_state_FSM_FFd16_520
    );
  pres_state_FSM_FFd23 : X_FF
    generic map(
      LOC => "SLICE_X15Y13",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd24_DYMUX_1442,
      CE => VCC,
      CLK => pres_state_FSM_FFd24_CLKINV_1439,
      SET => GND,
      RST => pres_state_FSM_FFd24_SRINVNOT,
      O => pres_state_FSM_FFd23_492
    );
  pres_state_FSM_FFd24 : X_FF
    generic map(
      LOC => "SLICE_X15Y13",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd24_DXMUX_1450,
      CE => VCC,
      CLK => pres_state_FSM_FFd24_CLKINV_1439,
      SET => GND,
      RST => pres_state_FSM_FFd24_SRINVNOT,
      O => pres_state_FSM_FFd24_549
    );
  pres_state_FSM_FFd31 : X_FF
    generic map(
      LOC => "SLICE_X14Y15",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd32_DYMUX_1466,
      CE => VCC,
      CLK => pres_state_FSM_FFd32_CLKINV_1463,
      SET => GND,
      RST => pres_state_FSM_FFd32_SRINVNOT,
      O => pres_state_FSM_FFd31_511
    );
  pres_state_FSM_FFd32 : X_FF
    generic map(
      LOC => "SLICE_X14Y15",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd32_DXMUX_1474,
      CE => VCC,
      CLK => pres_state_FSM_FFd32_CLKINV_1463,
      SET => GND,
      RST => pres_state_FSM_FFd32_SRINVNOT,
      O => pres_state_FSM_FFd32_501
    );
  pres_state_FSM_FFd17 : X_FF
    generic map(
      LOC => "SLICE_X15Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd18_DYMUX_1490,
      CE => VCC,
      CLK => pres_state_FSM_FFd18_CLKINV_1487,
      SET => GND,
      RST => pres_state_FSM_FFd18_SRINVNOT,
      O => pres_state_FSM_FFd17_489
    );
  pres_state_FSM_FFd18 : X_FF
    generic map(
      LOC => "SLICE_X15Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd18_DXMUX_1498,
      CE => VCC,
      CLK => pres_state_FSM_FFd18_CLKINV_1487,
      SET => GND,
      RST => pres_state_FSM_FFd18_SRINVNOT,
      O => pres_state_FSM_FFd18_551
    );
  pres_state_FSM_FFd25 : X_FF
    generic map(
      LOC => "SLICE_X14Y17",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd26_DYMUX_1514,
      CE => VCC,
      CLK => pres_state_FSM_FFd26_CLKINV_1511,
      SET => GND,
      RST => pres_state_FSM_FFd26_SRINVNOT,
      O => pres_state_FSM_FFd25_515
    );
  pres_state_FSM_FFd26 : X_FF
    generic map(
      LOC => "SLICE_X14Y17",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd26_DXMUX_1522,
      CE => VCC,
      CLK => pres_state_FSM_FFd26_CLKINV_1511,
      SET => GND,
      RST => pres_state_FSM_FFd26_SRINVNOT,
      O => pres_state_FSM_FFd26_506
    );
  pres_state_FSM_FFd33 : X_FF
    generic map(
      LOC => "SLICE_X15Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd34_DYMUX_1538,
      CE => VCC,
      CLK => pres_state_FSM_FFd34_CLKINV_1535,
      SET => GND,
      RST => pres_state_FSM_FFd34_SRINVNOT,
      O => pres_state_FSM_FFd33_550
    );
  pres_state_FSM_FFd34 : X_FF
    generic map(
      LOC => "SLICE_X15Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd34_DXMUX_1546,
      CE => VCC,
      CLK => pres_state_FSM_FFd34_CLKINV_1535,
      SET => GND,
      RST => pres_state_FSM_FFd34_SRINVNOT,
      O => pres_state_FSM_FFd34_509
    );
  pres_state_FSM_FFd41 : X_FF
    generic map(
      LOC => "SLICE_X17Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd42_DYMUX_1562,
      CE => VCC,
      CLK => pres_state_FSM_FFd42_CLKINV_1559,
      SET => GND,
      RST => pres_state_FSM_FFd42_SRINVNOT,
      O => pres_state_FSM_FFd41_504
    );
  pres_state_FSM_FFd42 : X_FF
    generic map(
      LOC => "SLICE_X17Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd42_DXMUX_1570,
      CE => VCC,
      CLK => pres_state_FSM_FFd42_CLKINV_1559,
      SET => GND,
      RST => pres_state_FSM_FFd42_SRINVNOT,
      O => pres_state_FSM_FFd42_552
    );
  pres_state_FSM_FFd19 : X_FF
    generic map(
      LOC => "SLICE_X14Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd20_DYMUX_1586,
      CE => VCC,
      CLK => pres_state_FSM_FFd20_CLKINV_1583,
      SET => GND,
      RST => pres_state_FSM_FFd20_SRINVNOT,
      O => pres_state_FSM_FFd19_519
    );
  pres_state_FSM_FFd20 : X_FF
    generic map(
      LOC => "SLICE_X14Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd20_DXMUX_1594,
      CE => VCC,
      CLK => pres_state_FSM_FFd20_CLKINV_1583,
      SET => GND,
      RST => pres_state_FSM_FFd20_SRINVNOT,
      O => pres_state_FSM_FFd20_488
    );
  pres_state_FSM_FFd27 : X_FF
    generic map(
      LOC => "SLICE_X12Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd28_DYMUX_1610,
      CE => VCC,
      CLK => pres_state_FSM_FFd28_CLKINV_1607,
      SET => GND,
      RST => pres_state_FSM_FFd28_SRINVNOT,
      O => pres_state_FSM_FFd27_543
    );
  pres_state_FSM_FFd28 : X_FF
    generic map(
      LOC => "SLICE_X12Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd28_DXMUX_1618,
      CE => VCC,
      CLK => pres_state_FSM_FFd28_CLKINV_1607,
      SET => GND,
      RST => pres_state_FSM_FFd28_SRINVNOT,
      O => pres_state_FSM_FFd28_514
    );
  pres_state_FSM_FFd35 : X_FF
    generic map(
      LOC => "SLICE_X13Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd36_DYMUX_1634,
      CE => VCC,
      CLK => pres_state_FSM_FFd36_CLKINV_1631,
      SET => GND,
      RST => pres_state_FSM_FFd36_SRINVNOT,
      O => pres_state_FSM_FFd35_507
    );
  pres_state_FSM_FFd36 : X_FF
    generic map(
      LOC => "SLICE_X13Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd36_DXMUX_1642,
      CE => VCC,
      CLK => pres_state_FSM_FFd36_CLKINV_1631,
      SET => GND,
      RST => pres_state_FSM_FFd36_SRINVNOT,
      O => pres_state_FSM_FFd36_553
    );
  pres_state_FSM_FFd43 : X_FF
    generic map(
      LOC => "SLICE_X16Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd44_DYMUX_1658,
      CE => VCC,
      CLK => pres_state_FSM_FFd44_CLKINV_1655,
      SET => GND,
      RST => pres_state_FSM_FFd44_SRINVNOT,
      O => pres_state_FSM_FFd43_516
    );
  pres_state_FSM_FFd44 : X_FF
    generic map(
      LOC => "SLICE_X16Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd44_DXMUX_1666,
      CE => VCC,
      CLK => pres_state_FSM_FFd44_CLKINV_1655,
      SET => GND,
      RST => pres_state_FSM_FFd44_SRINVNOT,
      O => pres_state_FSM_FFd44_502
    );
  pres_state_FSM_FFd51 : X_FF
    generic map(
      LOC => "SLICE_X18Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd52_DYMUX_1682,
      CE => VCC,
      CLK => pres_state_FSM_FFd52_CLKINV_1679,
      SET => GND,
      RST => pres_state_FSM_FFd52_SRINVNOT,
      O => pres_state_FSM_FFd51_545
    );
  pres_state_FSM_FFd52 : X_FF
    generic map(
      LOC => "SLICE_X18Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd52_DXMUX_1690,
      CE => VCC,
      CLK => pres_state_FSM_FFd52_CLKINV_1679,
      SET => GND,
      RST => pres_state_FSM_FFd52_SRINVNOT,
      O => pres_state_FSM_FFd52_530
    );
  pres_state_FSM_FFd29 : X_FF
    generic map(
      LOC => "SLICE_X13Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd30_DYMUX_1706,
      CE => VCC,
      CLK => pres_state_FSM_FFd30_CLKINV_1703,
      SET => GND,
      RST => pres_state_FSM_FFd30_SRINVNOT,
      O => pres_state_FSM_FFd29_497
    );
  pres_state_FSM_FFd30 : X_FF
    generic map(
      LOC => "SLICE_X13Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd30_DXMUX_1714,
      CE => VCC,
      CLK => pres_state_FSM_FFd30_CLKINV_1703,
      SET => GND,
      RST => pres_state_FSM_FFd30_SRINVNOT,
      O => pres_state_FSM_FFd30_555
    );
  pres_state_FSM_FFd37 : X_FF
    generic map(
      LOC => "SLICE_X12Y17",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd38_DYMUX_1730,
      CE => VCC,
      CLK => pres_state_FSM_FFd38_CLKINV_1727,
      SET => GND,
      RST => pres_state_FSM_FFd38_SRINVNOT,
      O => pres_state_FSM_FFd37_510
    );
  pres_state_FSM_FFd38 : X_FF
    generic map(
      LOC => "SLICE_X12Y17",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd38_DXMUX_1738,
      CE => VCC,
      CLK => pres_state_FSM_FFd38_CLKINV_1727,
      SET => GND,
      RST => pres_state_FSM_FFd38_SRINVNOT,
      O => pres_state_FSM_FFd38_505
    );
  pres_state_FSM_FFd45 : X_FF
    generic map(
      LOC => "SLICE_X16Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd46_DYMUX_1754,
      CE => VCC,
      CLK => pres_state_FSM_FFd46_CLKINV_1751,
      SET => GND,
      RST => pres_state_FSM_FFd46_SRINVNOT,
      O => pres_state_FSM_FFd45_554
    );
  pres_state_FSM_FFd46 : X_FF
    generic map(
      LOC => "SLICE_X16Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd46_DXMUX_1762,
      CE => VCC,
      CLK => pres_state_FSM_FFd46_CLKINV_1751,
      SET => GND,
      RST => pres_state_FSM_FFd46_SRINVNOT,
      O => pres_state_FSM_FFd46_522
    );
  pres_state_FSM_FFd53 : X_FF
    generic map(
      LOC => "SLICE_X17Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd54_DYMUX_1778,
      CE => VCC,
      CLK => pres_state_FSM_FFd54_CLKINV_1775,
      SET => GND,
      RST => pres_state_FSM_FFd54_SRINVNOT,
      O => pres_state_FSM_FFd53_495
    );
  pres_state_FSM_FFd54 : X_FF
    generic map(
      LOC => "SLICE_X17Y21",
      INIT => '1'
    )
    port map (
      I => pres_state_FSM_FFd54_DXMUX_1786,
      CE => VCC,
      CLK => pres_state_FSM_FFd54_CLKINV_1775,
      SET => pres_state_FSM_FFd54_SRINVNOT,
      RST => GND,
      O => pres_state_FSM_FFd54_541
    );
  pres_state_FSM_FFd39 : X_FF
    generic map(
      LOC => "SLICE_X14Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd40_DYMUX_1801,
      CE => VCC,
      CLK => pres_state_FSM_FFd40_CLKINV_1798,
      SET => GND,
      RST => pres_state_FSM_FFd40_SRINVNOT,
      O => pres_state_FSM_FFd39_556
    );
  pres_state_FSM_FFd40 : X_FF
    generic map(
      LOC => "SLICE_X14Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd40_DXMUX_1809,
      CE => VCC,
      CLK => pres_state_FSM_FFd40_CLKINV_1798,
      SET => GND,
      RST => pres_state_FSM_FFd40_SRINVNOT,
      O => pres_state_FSM_FFd40_512
    );
  pres_state_FSM_FFd47 : X_FF
    generic map(
      LOC => "SLICE_X16Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd48_DYMUX_1825,
      CE => VCC,
      CLK => pres_state_FSM_FFd48_CLKINV_1822,
      SET => GND,
      RST => pres_state_FSM_FFd48_SRINVNOT,
      O => pres_state_FSM_FFd47_500
    );
  pres_state_FSM_FFd48 : X_FF
    generic map(
      LOC => "SLICE_X16Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd48_DXMUX_1833,
      CE => VCC,
      CLK => pres_state_FSM_FFd48_CLKINV_1822,
      SET => GND,
      RST => pres_state_FSM_FFd48_SRINVNOT,
      O => pres_state_FSM_FFd48_544
    );
  pres_state_FSM_FFd49 : X_FF
    generic map(
      LOC => "SLICE_X16Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd50_DYMUX_1849,
      CE => VCC,
      CLK => pres_state_FSM_FFd50_CLKINV_1846,
      SET => GND,
      RST => pres_state_FSM_FFd50_SRINVNOT,
      O => pres_state_FSM_FFd49_526
    );
  pres_state_FSM_FFd50 : X_FF
    generic map(
      LOC => "SLICE_X16Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd50_DXMUX_1857,
      CE => VCC,
      CLK => pres_state_FSM_FFd50_CLKINV_1846,
      SET => GND,
      RST => pres_state_FSM_FFd50_SRINVNOT,
      O => pres_state_FSM_FFd50_499
    );
  dataLCD_mux0000_2_1 : X_LUT4
    generic map(
      INIT => X"FEFE",
      LOC => "SLICE_X16Y21"
    )
    port map (
      ADR0 => pres_state_FSM_FFd9_546,
      ADR1 => pres_state_FSM_FFd15_548,
      ADR2 => pres_state_FSM_FFd6_557,
      ADR3 => VCC,
      O => dataLCD_mux0000(2)
    );
  pres_state_FSM_FFd1 : X_FF
    generic map(
      LOC => "SLICE_X14Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd1_DYMUX_1909,
      CE => pres_state_FSM_FFd1_CEINV_1905,
      CLK => pres_state_FSM_FFd1_CLKINV_1906,
      SET => GND,
      RST => pres_state_FSM_FFd1_FFY_RSTAND_1915,
      O => pres_state_FSM_FFd1_529
    );
  pres_state_FSM_FFd1_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd1_FFY_RSTAND_1915
    );
  pres_state_FSM_FFd2 : X_FF
    generic map(
      LOC => "SLICE_X14Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd2_DYMUX_1924,
      CE => VCC,
      CLK => pres_state_FSM_FFd2_CLKINV_1921,
      SET => GND,
      RST => pres_state_FSM_FFd2_FFY_RSTAND_1929,
      O => pres_state_FSM_FFd2_498
    );
  pres_state_FSM_FFd2_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd2_FFY_RSTAND_1929
    );
  pres_state_FSM_FFd3 : X_FF
    generic map(
      LOC => "SLICE_X15Y23",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd4_DYMUX_1940,
      CE => VCC,
      CLK => pres_state_FSM_FFd4_CLKINV_1937,
      SET => GND,
      RST => pres_state_FSM_FFd4_SRINVNOT,
      O => pres_state_FSM_FFd3_558
    );
  pres_state_FSM_FFd4 : X_FF
    generic map(
      LOC => "SLICE_X15Y23",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd4_DXMUX_1948,
      CE => VCC,
      CLK => pres_state_FSM_FFd4_CLKINV_1937,
      SET => GND,
      RST => pres_state_FSM_FFd4_SRINVNOT,
      O => pres_state_FSM_FFd4_527
    );
  dataLCD_mux0000_1_Q : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X17Y22"
    )
    port map (
      ADR0 => pres_state_FSM_FFd15_548,
      ADR1 => pres_state_FSM_FFd9_546,
      ADR2 => N2,
      ADR3 => pres_state_FSM_FFd42_552,
      O => dataLCD_mux0000(1)
    );
  pres_state_FSM_FFd5 : X_FF
    generic map(
      LOC => "SLICE_X14Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd6_DYMUX_1988,
      CE => VCC,
      CLK => pres_state_FSM_FFd6_CLKINV_1985,
      SET => GND,
      RST => pres_state_FSM_FFd6_SRINVNOT,
      O => pres_state_FSM_FFd5_496
    );
  pres_state_FSM_FFd6 : X_FF
    generic map(
      LOC => "SLICE_X14Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd6_DXMUX_1996,
      CE => VCC,
      CLK => pres_state_FSM_FFd6_CLKINV_1985,
      SET => GND,
      RST => pres_state_FSM_FFd6_SRINVNOT,
      O => pres_state_FSM_FFd6_557
    );
  pres_state_FSM_FFd7 : X_FF
    generic map(
      LOC => "SLICE_X14Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd8_DYMUX_2012,
      CE => VCC,
      CLK => pres_state_FSM_FFd8_CLKINV_2009,
      SET => GND,
      RST => pres_state_FSM_FFd8_SRINVNOT,
      O => pres_state_FSM_FFd7_524
    );
  pres_state_FSM_FFd8 : X_FF
    generic map(
      LOC => "SLICE_X14Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd8_DXMUX_2020,
      CE => VCC,
      CLK => pres_state_FSM_FFd8_CLKINV_2009,
      SET => GND,
      RST => pres_state_FSM_FFd8_SRINVNOT,
      O => pres_state_FSM_FFd8_493
    );
  clk_s_0_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X19Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => clk_s(1),
      O => clk_s_0_G
    );
  clk_s_2_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X19Y24"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => clk_s(2),
      ADR3 => VCC,
      O => clk_s_2_F
    );
  clk_s_2_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X19Y24"
    )
    port map (
      ADR0 => clk_s(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_2_G
    );
  clk_s_4_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X19Y25"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => clk_s(4),
      O => clk_s_4_F
    );
  clk_s_4_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X19Y25"
    )
    port map (
      ADR0 => VCC,
      ADR1 => clk_s(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_4_G
    );
  clk_s_6_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X19Y26"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => clk_s(6),
      ADR3 => VCC,
      O => clk_s_6_F
    );
  clk_s_6_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X19Y26"
    )
    port map (
      ADR0 => clk_s(7),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_6_G
    );
  clk_s_8_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X19Y27"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => clk_s(8),
      O => clk_s_8_F
    );
  clk_s_8_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X19Y27"
    )
    port map (
      ADR0 => VCC,
      ADR1 => clk_s(9),
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_8_G
    );
  clk_s_10_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X19Y28"
    )
    port map (
      ADR0 => VCC,
      ADR1 => clk_s(10),
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_10_F
    );
  clk_s_10_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X19Y28"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => clk_s(11),
      ADR3 => VCC,
      O => clk_s_10_G
    );
  clk_s_12_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X19Y29"
    )
    port map (
      ADR0 => clk_s(12),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_12_F
    );
  clk_s_12_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X19Y29"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => clk_s(13),
      O => clk_s_12_G
    );
  clk_s_14_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X19Y30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => clk_s(14),
      ADR3 => VCC,
      O => clk_s_14_F
    );
  clk_s_14_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X19Y30"
    )
    port map (
      ADR0 => clk_s(15),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_14_G
    );
  en_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD59",
      PATHPULSE => 592 ps
    )
    port map (
      I => en_OBUF_508,
      O => en_O
    );
  reset_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD91",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_1277,
      O => reset_IBUF_0
    );
  dataLCD_mux0000_0_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FFFF",
      LOC => "SLICE_X16Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => dataLCD_mux0000_0_F
    );
  NlwBlock_LCDTest_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlock_LCDTest_GND : X_ZERO
    port map (
      O => GND
    );
  NlwInverterBlock_rs_CLK : X_INV
    port map (
      I => rs_OUTPUT_OTCLK1INV_1187,
      O => NlwInverterSignal_rs_CLK
    );
  NlwInverterBlock_dataLCD_0_CLK : X_INV
    port map (
      I => dataLCD_0_OUTPUT_OTCLK1INV_1204,
      O => NlwInverterSignal_dataLCD_0_CLK
    );
  NlwInverterBlock_dataLCD_1_CLK : X_INV
    port map (
      I => dataLCD_1_OUTPUT_OTCLK1INV_1221,
      O => NlwInverterSignal_dataLCD_1_CLK
    );
  NlwInverterBlock_dataLCD_2_CLK : X_INV
    port map (
      I => dataLCD_2_OUTPUT_OTCLK1INV_1238,
      O => NlwInverterSignal_dataLCD_2_CLK
    );
  NlwInverterBlock_dataLCD_3_CLK : X_INV
    port map (
      I => dataLCD_3_OUTPUT_OTCLK1INV_1255,
      O => NlwInverterSignal_dataLCD_3_CLK
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

