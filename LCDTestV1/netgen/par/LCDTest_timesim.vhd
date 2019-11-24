--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.40xd
--  \   \         Application: netgen
--  /   /         Filename: LCDTest_timesim.vhd
-- /___/   /\     Timestamp: Wed Jan  9 07:05:54 2013
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -s 4 -pcf LCDTest.pcf -rpw 100 -tpw 0 -ar Structure -tm LCDTest -insert_pp_buffers true -w -dir netgen/par -ofmt vhdl -sim LCDTest.ncd LCDTest_timesim.vhd 
-- Device	: 3s50avq100-4 (PRODUCTION 1.42 2012-10-12)
-- Input file	: LCDTest.ncd
-- Output file	: /home/hendri/Documents/workspaceXilinx/LCDTestV1/netgen/par/LCDTest_timesim.vhd
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
  signal pres_state_FSM_FFd32_448 : STD_LOGIC; 
  signal pres_state_FSM_FFd31_449 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_450 : STD_LOGIC; 
  signal pres_state_FSM_FFd29_451 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_452 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_453 : STD_LOGIC; 
  signal pres_state_FSM_FFd35_454 : STD_LOGIC; 
  signal pres_state_FSM_FFd25_455 : STD_LOGIC; 
  signal pres_state_FSM_FFd23_457 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_458 : STD_LOGIC; 
  signal pres_state_FSM_FFd37_459 : STD_LOGIC; 
  signal pres_state_FSM_FFd20_460 : STD_LOGIC; 
  signal pres_state_FSM_FFd19_461 : STD_LOGIC; 
  signal pres_state_FSM_FFd17_462 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_463 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_464 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_466 : STD_LOGIC; 
  signal pres_state_FSM_FFd13_467 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_468 : STD_LOGIC; 
  signal pres_state_FSM_FFd11_469 : STD_LOGIC; 
  signal pres_state_FSM_FFd10_470 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_471 : STD_LOGIC; 
  signal pres_state_FSM_FFd41_472 : STD_LOGIC; 
  signal pres_state_FSM_FFd7_473 : STD_LOGIC; 
  signal pres_state_FSM_FFd5_475 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_476 : STD_LOGIC; 
  signal pres_state_FSM_FFd43_477 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_478 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_479 : STD_LOGIC; 
  signal pres_state_FSM_FFd47_480 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_481 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_482 : STD_LOGIC; 
  signal dataLCD_or0000 : STD_LOGIC; 
  signal reset_IBUF_0 : STD_LOGIC; 
  signal clock_o : STD_LOGIC; 
  signal pres_state_FSM_FFd9_494 : STD_LOGIC; 
  signal pres_state_FSM_Out489_0 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_496 : STD_LOGIC; 
  signal pres_state_FSM_FFd15_497 : STD_LOGIC; 
  signal pres_state_FSM_FFd21_498 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_499 : STD_LOGIC; 
  signal pres_state_FSM_FFd33_500 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_501 : STD_LOGIC; 
  signal pres_state_FSM_FFd27_502 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_503 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_504 : STD_LOGIC; 
  signal pres_state_FSM_FFd45_505 : STD_LOGIC; 
  signal pres_state_FSM_Out4821_0 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_507 : STD_LOGIC; 
  signal pres_state_FSM_FFd39_508 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_509 : STD_LOGIC; 
  signal pres_state_FSM_Out484_0 : STD_LOGIC; 
  signal pres_state_FSM_Out4826_511 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_512 : STD_LOGIC; 
  signal pres_state_FSM_FFd3_513 : STD_LOGIC; 
  signal N01 : STD_LOGIC; 
  signal clk_s_0_DXMUX_557 : STD_LOGIC; 
  signal clk_s_0_XORF_555 : STD_LOGIC; 
  signal clk_s_0_LOGIC_ONE_554 : STD_LOGIC; 
  signal clk_s_0_CYINIT_553 : STD_LOGIC; 
  signal clk_s_0_CYSELF_544 : STD_LOGIC; 
  signal clk_s_0_BXINV_542 : STD_LOGIC; 
  signal clk_s_0_DYMUX_538 : STD_LOGIC; 
  signal clk_s_0_XORG_536 : STD_LOGIC; 
  signal clk_s_0_CYMUXG_535 : STD_LOGIC; 
  signal clk_s_0_LOGIC_ZERO_533 : STD_LOGIC; 
  signal clk_s_0_CYSELG_524 : STD_LOGIC; 
  signal clk_s_0_G : STD_LOGIC; 
  signal clk_s_0_CLKINV_522 : STD_LOGIC; 
  signal clk_s_2_DXMUX_605 : STD_LOGIC; 
  signal clk_s_2_XORF_603 : STD_LOGIC; 
  signal clk_s_2_CYINIT_602 : STD_LOGIC; 
  signal clk_s_2_F : STD_LOGIC; 
  signal clk_s_2_DYMUX_589 : STD_LOGIC; 
  signal clk_s_2_XORG_587 : STD_LOGIC; 
  signal clk_s_2_CYSELF_585 : STD_LOGIC; 
  signal clk_s_2_CYMUXFAST_584 : STD_LOGIC; 
  signal clk_s_2_CYAND_583 : STD_LOGIC; 
  signal clk_s_2_FASTCARRY_582 : STD_LOGIC; 
  signal clk_s_2_CYMUXG2_581 : STD_LOGIC; 
  signal clk_s_2_CYMUXF2_580 : STD_LOGIC; 
  signal clk_s_2_LOGIC_ZERO_579 : STD_LOGIC; 
  signal clk_s_2_CYSELG_570 : STD_LOGIC; 
  signal clk_s_2_G : STD_LOGIC; 
  signal clk_s_2_CLKINV_568 : STD_LOGIC; 
  signal clk_s_4_DXMUX_653 : STD_LOGIC; 
  signal clk_s_4_XORF_651 : STD_LOGIC; 
  signal clk_s_4_CYINIT_650 : STD_LOGIC; 
  signal clk_s_4_F : STD_LOGIC; 
  signal clk_s_4_DYMUX_637 : STD_LOGIC; 
  signal clk_s_4_XORG_635 : STD_LOGIC; 
  signal clk_s_4_CYSELF_633 : STD_LOGIC; 
  signal clk_s_4_CYMUXFAST_632 : STD_LOGIC; 
  signal clk_s_4_CYAND_631 : STD_LOGIC; 
  signal clk_s_4_FASTCARRY_630 : STD_LOGIC; 
  signal clk_s_4_CYMUXG2_629 : STD_LOGIC; 
  signal clk_s_4_CYMUXF2_628 : STD_LOGIC; 
  signal clk_s_4_LOGIC_ZERO_627 : STD_LOGIC; 
  signal clk_s_4_CYSELG_618 : STD_LOGIC; 
  signal clk_s_4_G : STD_LOGIC; 
  signal clk_s_4_CLKINV_616 : STD_LOGIC; 
  signal clk_s_6_DXMUX_701 : STD_LOGIC; 
  signal clk_s_6_XORF_699 : STD_LOGIC; 
  signal clk_s_6_CYINIT_698 : STD_LOGIC; 
  signal clk_s_6_F : STD_LOGIC; 
  signal clk_s_6_DYMUX_685 : STD_LOGIC; 
  signal clk_s_6_XORG_683 : STD_LOGIC; 
  signal clk_s_6_CYSELF_681 : STD_LOGIC; 
  signal clk_s_6_CYMUXFAST_680 : STD_LOGIC; 
  signal clk_s_6_CYAND_679 : STD_LOGIC; 
  signal clk_s_6_FASTCARRY_678 : STD_LOGIC; 
  signal clk_s_6_CYMUXG2_677 : STD_LOGIC; 
  signal clk_s_6_CYMUXF2_676 : STD_LOGIC; 
  signal clk_s_6_LOGIC_ZERO_675 : STD_LOGIC; 
  signal clk_s_6_CYSELG_666 : STD_LOGIC; 
  signal clk_s_6_G : STD_LOGIC; 
  signal clk_s_6_CLKINV_664 : STD_LOGIC; 
  signal clk_s_8_DXMUX_749 : STD_LOGIC; 
  signal clk_s_8_XORF_747 : STD_LOGIC; 
  signal clk_s_8_CYINIT_746 : STD_LOGIC; 
  signal clk_s_8_F : STD_LOGIC; 
  signal clk_s_8_DYMUX_733 : STD_LOGIC; 
  signal clk_s_8_XORG_731 : STD_LOGIC; 
  signal clk_s_8_CYSELF_729 : STD_LOGIC; 
  signal clk_s_8_CYMUXFAST_728 : STD_LOGIC; 
  signal clk_s_8_CYAND_727 : STD_LOGIC; 
  signal clk_s_8_FASTCARRY_726 : STD_LOGIC; 
  signal clk_s_8_CYMUXG2_725 : STD_LOGIC; 
  signal clk_s_8_CYMUXF2_724 : STD_LOGIC; 
  signal clk_s_8_LOGIC_ZERO_723 : STD_LOGIC; 
  signal clk_s_8_CYSELG_714 : STD_LOGIC; 
  signal clk_s_8_G : STD_LOGIC; 
  signal clk_s_8_CLKINV_712 : STD_LOGIC; 
  signal clk_s_10_DXMUX_797 : STD_LOGIC; 
  signal clk_s_10_XORF_795 : STD_LOGIC; 
  signal clk_s_10_CYINIT_794 : STD_LOGIC; 
  signal clk_s_10_F : STD_LOGIC; 
  signal clk_s_10_DYMUX_781 : STD_LOGIC; 
  signal clk_s_10_XORG_779 : STD_LOGIC; 
  signal clk_s_10_CYSELF_777 : STD_LOGIC; 
  signal clk_s_10_CYMUXFAST_776 : STD_LOGIC; 
  signal clk_s_10_CYAND_775 : STD_LOGIC; 
  signal clk_s_10_FASTCARRY_774 : STD_LOGIC; 
  signal clk_s_10_CYMUXG2_773 : STD_LOGIC; 
  signal clk_s_10_CYMUXF2_772 : STD_LOGIC; 
  signal clk_s_10_LOGIC_ZERO_771 : STD_LOGIC; 
  signal clk_s_10_CYSELG_762 : STD_LOGIC; 
  signal clk_s_10_G : STD_LOGIC; 
  signal clk_s_10_CLKINV_760 : STD_LOGIC; 
  signal clk_s_12_DXMUX_845 : STD_LOGIC; 
  signal clk_s_12_XORF_843 : STD_LOGIC; 
  signal clk_s_12_CYINIT_842 : STD_LOGIC; 
  signal clk_s_12_F : STD_LOGIC; 
  signal clk_s_12_DYMUX_829 : STD_LOGIC; 
  signal clk_s_12_XORG_827 : STD_LOGIC; 
  signal clk_s_12_CYSELF_825 : STD_LOGIC; 
  signal clk_s_12_CYMUXFAST_824 : STD_LOGIC; 
  signal clk_s_12_CYAND_823 : STD_LOGIC; 
  signal clk_s_12_FASTCARRY_822 : STD_LOGIC; 
  signal clk_s_12_CYMUXG2_821 : STD_LOGIC; 
  signal clk_s_12_CYMUXF2_820 : STD_LOGIC; 
  signal clk_s_12_LOGIC_ZERO_819 : STD_LOGIC; 
  signal clk_s_12_CYSELG_810 : STD_LOGIC; 
  signal clk_s_12_G : STD_LOGIC; 
  signal clk_s_12_CLKINV_808 : STD_LOGIC; 
  signal clk_s_14_DXMUX_893 : STD_LOGIC; 
  signal clk_s_14_XORF_891 : STD_LOGIC; 
  signal clk_s_14_CYINIT_890 : STD_LOGIC; 
  signal clk_s_14_F : STD_LOGIC; 
  signal clk_s_14_DYMUX_877 : STD_LOGIC; 
  signal clk_s_14_XORG_875 : STD_LOGIC; 
  signal clk_s_14_CYSELF_873 : STD_LOGIC; 
  signal clk_s_14_CYMUXFAST_872 : STD_LOGIC; 
  signal clk_s_14_CYAND_871 : STD_LOGIC; 
  signal clk_s_14_FASTCARRY_870 : STD_LOGIC; 
  signal clk_s_14_CYMUXG2_869 : STD_LOGIC; 
  signal clk_s_14_CYMUXF2_868 : STD_LOGIC; 
  signal clk_s_14_LOGIC_ZERO_867 : STD_LOGIC; 
  signal clk_s_14_CYSELG_858 : STD_LOGIC; 
  signal clk_s_14_G : STD_LOGIC; 
  signal clk_s_14_CLKINV_856 : STD_LOGIC; 
  signal clk_s_16_DXMUX_914 : STD_LOGIC; 
  signal clk_s_16_XORF_912 : STD_LOGIC; 
  signal clk_s_16_CYINIT_911 : STD_LOGIC; 
  signal clk_s_16_rt_909 : STD_LOGIC; 
  signal clk_s_16_CLKINV_901 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYINIT_946 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYSELF_940 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_BXINV_938 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYMUXG_937 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_LOGIC_ONE_935 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_1_CYSELG_929 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYSELF_970 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYMUXFAST_969 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYAND_968 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_FASTCARRY_967 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYMUXG2_966 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYMUXF2_965 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_LOGIC_ONE_964 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_3_CYSELG_958 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYSELF_1000 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYMUXFAST_999 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYAND_998 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_FASTCARRY_997 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYMUXG2_996 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYMUXF2_995 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_LOGIC_ONE_994 : STD_LOGIC; 
  signal dataLCD_or0000_wg_cy_5_CYSELG_988 : STD_LOGIC; 
  signal dataLCD_or0000_CYSELF_1030 : STD_LOGIC; 
  signal dataLCD_or0000_CYMUXFAST_1029 : STD_LOGIC; 
  signal dataLCD_or0000_CYAND_1028 : STD_LOGIC; 
  signal dataLCD_or0000_FASTCARRY_1027 : STD_LOGIC; 
  signal dataLCD_or0000_CYMUXG2_1026 : STD_LOGIC; 
  signal dataLCD_or0000_CYMUXF2_1025 : STD_LOGIC; 
  signal dataLCD_or0000_LOGIC_ONE_1024 : STD_LOGIC; 
  signal dataLCD_or0000_CYSELG_1018 : STD_LOGIC; 
  signal en_O : STD_LOGIC; 
  signal rs_O : STD_LOGIC; 
  signal rs_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal rs_OBUF_1059 : STD_LOGIC; 
  signal rs_OUTPUT_OTCLK1INV_1053 : STD_LOGIC; 
  signal dataLCD_0_O : STD_LOGIC; 
  signal dataLCD_0_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_0_1076 : STD_LOGIC; 
  signal dataLCD_0_OUTPUT_OTCLK1INV_1070 : STD_LOGIC; 
  signal dataLCD_1_O : STD_LOGIC; 
  signal dataLCD_1_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_1_1093 : STD_LOGIC; 
  signal dataLCD_1_OUTPUT_OTCLK1INV_1087 : STD_LOGIC; 
  signal dataLCD_2_O : STD_LOGIC; 
  signal dataLCD_2_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_2_1110 : STD_LOGIC; 
  signal dataLCD_2_OUTPUT_OTCLK1INV_1104 : STD_LOGIC; 
  signal dataLCD_3_O : STD_LOGIC; 
  signal dataLCD_3_OUTPUT_OFF_ODDRIN1_MUX : STD_LOGIC; 
  signal dataLCD_3_1127 : STD_LOGIC; 
  signal dataLCD_3_OUTPUT_OTCLK1INV_1121 : STD_LOGIC; 
  signal clock_BUFGP_IBUFG_1136 : STD_LOGIC; 
  signal reset_IBUF_1143 : STD_LOGIC; 
  signal BUFG_inst_S_INVNOT : STD_LOGIC; 
  signal BUFG_inst_I0_INV : STD_LOGIC; 
  signal clock_BUFGP_BUFG_S_INVNOT : STD_LOGIC; 
  signal clock_BUFGP_BUFG_I0_INV : STD_LOGIC; 
  signal pres_state_FSM_FFd10_DXMUX_1171 : STD_LOGIC; 
  signal pres_state_FSM_FFd10_DYMUX_1163 : STD_LOGIC; 
  signal pres_state_FSM_FFd10_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd10_CLKINV_1160 : STD_LOGIC; 
  signal pres_state_FSM_Out489_1187 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_DXMUX_1207 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_DYMUX_1199 : STD_LOGIC; 
  signal pres_state_FSM_FFd12_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd12_CLKINV_1196 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_DXMUX_1231 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_DYMUX_1223 : STD_LOGIC; 
  signal pres_state_FSM_FFd14_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd14_CLKINV_1220 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_DXMUX_1255 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_DYMUX_1247 : STD_LOGIC; 
  signal pres_state_FSM_FFd22_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd22_CLKINV_1244 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_DXMUX_1279 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_DYMUX_1271 : STD_LOGIC; 
  signal pres_state_FSM_FFd16_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd16_CLKINV_1268 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_DXMUX_1303 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_DYMUX_1295 : STD_LOGIC; 
  signal pres_state_FSM_FFd24_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd24_CLKINV_1292 : STD_LOGIC; 
  signal pres_state_FSM_FFd32_DXMUX_1327 : STD_LOGIC; 
  signal pres_state_FSM_FFd32_DYMUX_1319 : STD_LOGIC; 
  signal pres_state_FSM_FFd32_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd32_CLKINV_1316 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_DXMUX_1351 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_DYMUX_1343 : STD_LOGIC; 
  signal pres_state_FSM_FFd18_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd18_CLKINV_1340 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_DXMUX_1375 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_DYMUX_1367 : STD_LOGIC; 
  signal pres_state_FSM_FFd26_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd26_CLKINV_1364 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_DXMUX_1399 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_DYMUX_1391 : STD_LOGIC; 
  signal pres_state_FSM_FFd34_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd34_CLKINV_1388 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_DXMUX_1423 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_DYMUX_1415 : STD_LOGIC; 
  signal pres_state_FSM_FFd42_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd42_CLKINV_1412 : STD_LOGIC; 
  signal pres_state_FSM_FFd20_DXMUX_1447 : STD_LOGIC; 
  signal pres_state_FSM_FFd20_DYMUX_1439 : STD_LOGIC; 
  signal pres_state_FSM_FFd20_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd20_CLKINV_1436 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_DXMUX_1471 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_DYMUX_1463 : STD_LOGIC; 
  signal pres_state_FSM_FFd28_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd28_CLKINV_1460 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_DXMUX_1495 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_DYMUX_1487 : STD_LOGIC; 
  signal pres_state_FSM_FFd36_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd36_CLKINV_1484 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_DXMUX_1519 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_DYMUX_1511 : STD_LOGIC; 
  signal pres_state_FSM_FFd44_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd44_CLKINV_1508 : STD_LOGIC; 
  signal pres_state_FSM_Out4821_1535 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_DXMUX_1555 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_DYMUX_1547 : STD_LOGIC; 
  signal pres_state_FSM_FFd30_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd30_CLKINV_1544 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_DXMUX_1579 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_DYMUX_1571 : STD_LOGIC; 
  signal pres_state_FSM_FFd38_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd38_CLKINV_1568 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_DXMUX_1603 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_DYMUX_1595 : STD_LOGIC; 
  signal pres_state_FSM_FFd46_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd46_CLKINV_1592 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_DXMUX_1627 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_DYMUX_1619 : STD_LOGIC; 
  signal pres_state_FSM_FFd40_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd40_CLKINV_1616 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_DXMUX_1651 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_BXINV_1650 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_DYMUX_1643 : STD_LOGIC; 
  signal pres_state_FSM_FFd48_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd48_CLKINV_1640 : STD_LOGIC; 
  signal en_OBUF_1678 : STD_LOGIC; 
  signal pres_state_FSM_Out4826_pack_1 : STD_LOGIC; 
  signal rs_mux0000 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_DYMUX_1738 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_BYINV_1737 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_CLKINV_1735 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_CEINV_1734 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_DYMUX_1753 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_CLKINV_1750 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_DXMUX_1777 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_DYMUX_1769 : STD_LOGIC; 
  signal pres_state_FSM_FFd4_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd4_CLKINV_1766 : STD_LOGIC; 
  signal N01_pack_1 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_DXMUX_1825 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_DYMUX_1817 : STD_LOGIC; 
  signal pres_state_FSM_FFd6_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd6_CLKINV_1814 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_DXMUX_1849 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_DYMUX_1841 : STD_LOGIC; 
  signal pres_state_FSM_FFd8_SRINVNOT : STD_LOGIC; 
  signal pres_state_FSM_FFd8_CLKINV_1838 : STD_LOGIC; 
  signal pres_state_FSM_Out484_1865 : STD_LOGIC; 
  signal pres_state_FSM_FFd1_FFY_RSTAND_1744 : STD_LOGIC; 
  signal pres_state_FSM_FFd2_FFY_RSTAND_1758 : STD_LOGIC; 
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
  signal dataLCD_or0000_wg_lut : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal dataLCD_or0000_wg_cy : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal dataLCD_mux0000 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
begin
  clk_s_0_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      O => clk_s_0_LOGIC_ZERO_533
    );
  clk_s_0_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      O => clk_s_0_LOGIC_ONE_554
    );
  clk_s_0_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_XORF_555,
      O => clk_s_0_DXMUX_557
    );
  clk_s_0_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      I0 => clk_s_0_CYINIT_553,
      I1 => Mcount_clk_s_lut(0),
      O => clk_s_0_XORF_555
    );
  clk_s_0_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      IA => clk_s_0_LOGIC_ONE_554,
      IB => clk_s_0_CYINIT_553,
      SEL => clk_s_0_CYSELF_544,
      O => Mcount_clk_s_cy(0)
    );
  clk_s_0_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_BXINV_542,
      O => clk_s_0_CYINIT_553
    );
  clk_s_0_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_lut(0),
      O => clk_s_0_CYSELF_544
    );
  clk_s_0_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => '0',
      O => clk_s_0_BXINV_542
    );
  clk_s_0_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_XORG_536,
      O => clk_s_0_DYMUX_538
    );
  clk_s_0_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      I0 => Mcount_clk_s_cy(0),
      I1 => clk_s_0_G,
      O => clk_s_0_XORG_536
    );
  clk_s_0_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_CYMUXG_535,
      O => Mcount_clk_s_cy(1)
    );
  clk_s_0_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X19Y23"
    )
    port map (
      IA => clk_s_0_LOGIC_ZERO_533,
      IB => Mcount_clk_s_cy(0),
      SEL => clk_s_0_CYSELG_524,
      O => clk_s_0_CYMUXG_535
    );
  clk_s_0_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_0_G,
      O => clk_s_0_CYSELG_524
    );
  clk_s_0_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_0_CLKINV_522
    );
  clk_s_1 : X_FF
    generic map(
      LOC => "SLICE_X19Y23",
      INIT => '0'
    )
    port map (
      I => clk_s_0_DYMUX_538,
      CE => VCC,
      CLK => clk_s_0_CLKINV_522,
      SET => GND,
      RST => GND,
      O => clk_s(1)
    );
  clk_s_2_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      O => clk_s_2_LOGIC_ZERO_579
    );
  clk_s_2_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_XORF_603,
      O => clk_s_2_DXMUX_605
    );
  clk_s_2_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      I0 => clk_s_2_CYINIT_602,
      I1 => clk_s_2_F,
      O => clk_s_2_XORF_603
    );
  clk_s_2_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_LOGIC_ZERO_579,
      IB => clk_s_2_CYINIT_602,
      SEL => clk_s_2_CYSELF_585,
      O => Mcount_clk_s_cy(2)
    );
  clk_s_2_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_LOGIC_ZERO_579,
      IB => clk_s_2_LOGIC_ZERO_579,
      SEL => clk_s_2_CYSELF_585,
      O => clk_s_2_CYMUXF2_580
    );
  clk_s_2_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(1),
      O => clk_s_2_CYINIT_602
    );
  clk_s_2_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_F,
      O => clk_s_2_CYSELF_585
    );
  clk_s_2_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_XORG_587,
      O => clk_s_2_DYMUX_589
    );
  clk_s_2_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      I0 => Mcount_clk_s_cy(2),
      I1 => clk_s_2_G,
      O => clk_s_2_XORG_587
    );
  clk_s_2_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_CYMUXFAST_584,
      O => Mcount_clk_s_cy(3)
    );
  clk_s_2_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(1),
      O => clk_s_2_FASTCARRY_582
    );
  clk_s_2_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      I0 => clk_s_2_CYSELG_570,
      I1 => clk_s_2_CYSELF_585,
      O => clk_s_2_CYAND_583
    );
  clk_s_2_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_CYMUXG2_581,
      IB => clk_s_2_FASTCARRY_582,
      SEL => clk_s_2_CYAND_583,
      O => clk_s_2_CYMUXFAST_584
    );
  clk_s_2_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y24"
    )
    port map (
      IA => clk_s_2_LOGIC_ZERO_579,
      IB => clk_s_2_CYMUXF2_580,
      SEL => clk_s_2_CYSELG_570,
      O => clk_s_2_CYMUXG2_581
    );
  clk_s_2_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_2_G,
      O => clk_s_2_CYSELG_570
    );
  clk_s_2_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y24",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_2_CLKINV_568
    );
  clk_s_4_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      O => clk_s_4_LOGIC_ZERO_627
    );
  clk_s_4_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_XORF_651,
      O => clk_s_4_DXMUX_653
    );
  clk_s_4_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      I0 => clk_s_4_CYINIT_650,
      I1 => clk_s_4_F,
      O => clk_s_4_XORF_651
    );
  clk_s_4_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_LOGIC_ZERO_627,
      IB => clk_s_4_CYINIT_650,
      SEL => clk_s_4_CYSELF_633,
      O => Mcount_clk_s_cy(4)
    );
  clk_s_4_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_LOGIC_ZERO_627,
      IB => clk_s_4_LOGIC_ZERO_627,
      SEL => clk_s_4_CYSELF_633,
      O => clk_s_4_CYMUXF2_628
    );
  clk_s_4_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(3),
      O => clk_s_4_CYINIT_650
    );
  clk_s_4_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_F,
      O => clk_s_4_CYSELF_633
    );
  clk_s_4_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_XORG_635,
      O => clk_s_4_DYMUX_637
    );
  clk_s_4_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      I0 => Mcount_clk_s_cy(4),
      I1 => clk_s_4_G,
      O => clk_s_4_XORG_635
    );
  clk_s_4_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_CYMUXFAST_632,
      O => Mcount_clk_s_cy(5)
    );
  clk_s_4_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(3),
      O => clk_s_4_FASTCARRY_630
    );
  clk_s_4_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      I0 => clk_s_4_CYSELG_618,
      I1 => clk_s_4_CYSELF_633,
      O => clk_s_4_CYAND_631
    );
  clk_s_4_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_CYMUXG2_629,
      IB => clk_s_4_FASTCARRY_630,
      SEL => clk_s_4_CYAND_631,
      O => clk_s_4_CYMUXFAST_632
    );
  clk_s_4_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y25"
    )
    port map (
      IA => clk_s_4_LOGIC_ZERO_627,
      IB => clk_s_4_CYMUXF2_628,
      SEL => clk_s_4_CYSELG_618,
      O => clk_s_4_CYMUXG2_629
    );
  clk_s_4_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_4_G,
      O => clk_s_4_CYSELG_618
    );
  clk_s_4_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y25",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_4_CLKINV_616
    );
  clk_s_6_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      O => clk_s_6_LOGIC_ZERO_675
    );
  clk_s_6_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_XORF_699,
      O => clk_s_6_DXMUX_701
    );
  clk_s_6_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      I0 => clk_s_6_CYINIT_698,
      I1 => clk_s_6_F,
      O => clk_s_6_XORF_699
    );
  clk_s_6_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_LOGIC_ZERO_675,
      IB => clk_s_6_CYINIT_698,
      SEL => clk_s_6_CYSELF_681,
      O => Mcount_clk_s_cy(6)
    );
  clk_s_6_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_LOGIC_ZERO_675,
      IB => clk_s_6_LOGIC_ZERO_675,
      SEL => clk_s_6_CYSELF_681,
      O => clk_s_6_CYMUXF2_676
    );
  clk_s_6_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(5),
      O => clk_s_6_CYINIT_698
    );
  clk_s_6_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_F,
      O => clk_s_6_CYSELF_681
    );
  clk_s_6_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_XORG_683,
      O => clk_s_6_DYMUX_685
    );
  clk_s_6_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      I0 => Mcount_clk_s_cy(6),
      I1 => clk_s_6_G,
      O => clk_s_6_XORG_683
    );
  clk_s_6_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_CYMUXFAST_680,
      O => Mcount_clk_s_cy(7)
    );
  clk_s_6_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(5),
      O => clk_s_6_FASTCARRY_678
    );
  clk_s_6_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      I0 => clk_s_6_CYSELG_666,
      I1 => clk_s_6_CYSELF_681,
      O => clk_s_6_CYAND_679
    );
  clk_s_6_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_CYMUXG2_677,
      IB => clk_s_6_FASTCARRY_678,
      SEL => clk_s_6_CYAND_679,
      O => clk_s_6_CYMUXFAST_680
    );
  clk_s_6_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y26"
    )
    port map (
      IA => clk_s_6_LOGIC_ZERO_675,
      IB => clk_s_6_CYMUXF2_676,
      SEL => clk_s_6_CYSELG_666,
      O => clk_s_6_CYMUXG2_677
    );
  clk_s_6_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_6_G,
      O => clk_s_6_CYSELG_666
    );
  clk_s_6_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y26",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_6_CLKINV_664
    );
  clk_s_8_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      O => clk_s_8_LOGIC_ZERO_723
    );
  clk_s_8_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_XORF_747,
      O => clk_s_8_DXMUX_749
    );
  clk_s_8_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      I0 => clk_s_8_CYINIT_746,
      I1 => clk_s_8_F,
      O => clk_s_8_XORF_747
    );
  clk_s_8_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_LOGIC_ZERO_723,
      IB => clk_s_8_CYINIT_746,
      SEL => clk_s_8_CYSELF_729,
      O => Mcount_clk_s_cy(8)
    );
  clk_s_8_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_LOGIC_ZERO_723,
      IB => clk_s_8_LOGIC_ZERO_723,
      SEL => clk_s_8_CYSELF_729,
      O => clk_s_8_CYMUXF2_724
    );
  clk_s_8_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(7),
      O => clk_s_8_CYINIT_746
    );
  clk_s_8_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_F,
      O => clk_s_8_CYSELF_729
    );
  clk_s_8_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_XORG_731,
      O => clk_s_8_DYMUX_733
    );
  clk_s_8_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      I0 => Mcount_clk_s_cy(8),
      I1 => clk_s_8_G,
      O => clk_s_8_XORG_731
    );
  clk_s_8_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_CYMUXFAST_728,
      O => Mcount_clk_s_cy(9)
    );
  clk_s_8_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(7),
      O => clk_s_8_FASTCARRY_726
    );
  clk_s_8_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      I0 => clk_s_8_CYSELG_714,
      I1 => clk_s_8_CYSELF_729,
      O => clk_s_8_CYAND_727
    );
  clk_s_8_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_CYMUXG2_725,
      IB => clk_s_8_FASTCARRY_726,
      SEL => clk_s_8_CYAND_727,
      O => clk_s_8_CYMUXFAST_728
    );
  clk_s_8_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y27"
    )
    port map (
      IA => clk_s_8_LOGIC_ZERO_723,
      IB => clk_s_8_CYMUXF2_724,
      SEL => clk_s_8_CYSELG_714,
      O => clk_s_8_CYMUXG2_725
    );
  clk_s_8_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_8_G,
      O => clk_s_8_CYSELG_714
    );
  clk_s_8_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y27",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_8_CLKINV_712
    );
  clk_s_10_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      O => clk_s_10_LOGIC_ZERO_771
    );
  clk_s_10_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_XORF_795,
      O => clk_s_10_DXMUX_797
    );
  clk_s_10_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      I0 => clk_s_10_CYINIT_794,
      I1 => clk_s_10_F,
      O => clk_s_10_XORF_795
    );
  clk_s_10_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_LOGIC_ZERO_771,
      IB => clk_s_10_CYINIT_794,
      SEL => clk_s_10_CYSELF_777,
      O => Mcount_clk_s_cy(10)
    );
  clk_s_10_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_LOGIC_ZERO_771,
      IB => clk_s_10_LOGIC_ZERO_771,
      SEL => clk_s_10_CYSELF_777,
      O => clk_s_10_CYMUXF2_772
    );
  clk_s_10_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(9),
      O => clk_s_10_CYINIT_794
    );
  clk_s_10_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_F,
      O => clk_s_10_CYSELF_777
    );
  clk_s_10_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_XORG_779,
      O => clk_s_10_DYMUX_781
    );
  clk_s_10_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      I0 => Mcount_clk_s_cy(10),
      I1 => clk_s_10_G,
      O => clk_s_10_XORG_779
    );
  clk_s_10_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_CYMUXFAST_776,
      O => Mcount_clk_s_cy(11)
    );
  clk_s_10_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(9),
      O => clk_s_10_FASTCARRY_774
    );
  clk_s_10_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      I0 => clk_s_10_CYSELG_762,
      I1 => clk_s_10_CYSELF_777,
      O => clk_s_10_CYAND_775
    );
  clk_s_10_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_CYMUXG2_773,
      IB => clk_s_10_FASTCARRY_774,
      SEL => clk_s_10_CYAND_775,
      O => clk_s_10_CYMUXFAST_776
    );
  clk_s_10_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y28"
    )
    port map (
      IA => clk_s_10_LOGIC_ZERO_771,
      IB => clk_s_10_CYMUXF2_772,
      SEL => clk_s_10_CYSELG_762,
      O => clk_s_10_CYMUXG2_773
    );
  clk_s_10_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_10_G,
      O => clk_s_10_CYSELG_762
    );
  clk_s_10_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y28",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_10_CLKINV_760
    );
  clk_s_12_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      O => clk_s_12_LOGIC_ZERO_819
    );
  clk_s_12_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_XORF_843,
      O => clk_s_12_DXMUX_845
    );
  clk_s_12_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      I0 => clk_s_12_CYINIT_842,
      I1 => clk_s_12_F,
      O => clk_s_12_XORF_843
    );
  clk_s_12_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_LOGIC_ZERO_819,
      IB => clk_s_12_CYINIT_842,
      SEL => clk_s_12_CYSELF_825,
      O => Mcount_clk_s_cy(12)
    );
  clk_s_12_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_LOGIC_ZERO_819,
      IB => clk_s_12_LOGIC_ZERO_819,
      SEL => clk_s_12_CYSELF_825,
      O => clk_s_12_CYMUXF2_820
    );
  clk_s_12_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(11),
      O => clk_s_12_CYINIT_842
    );
  clk_s_12_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_F,
      O => clk_s_12_CYSELF_825
    );
  clk_s_12_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_XORG_827,
      O => clk_s_12_DYMUX_829
    );
  clk_s_12_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      I0 => Mcount_clk_s_cy(12),
      I1 => clk_s_12_G,
      O => clk_s_12_XORG_827
    );
  clk_s_12_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_CYMUXFAST_824,
      O => Mcount_clk_s_cy(13)
    );
  clk_s_12_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(11),
      O => clk_s_12_FASTCARRY_822
    );
  clk_s_12_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      I0 => clk_s_12_CYSELG_810,
      I1 => clk_s_12_CYSELF_825,
      O => clk_s_12_CYAND_823
    );
  clk_s_12_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_CYMUXG2_821,
      IB => clk_s_12_FASTCARRY_822,
      SEL => clk_s_12_CYAND_823,
      O => clk_s_12_CYMUXFAST_824
    );
  clk_s_12_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y29"
    )
    port map (
      IA => clk_s_12_LOGIC_ZERO_819,
      IB => clk_s_12_CYMUXF2_820,
      SEL => clk_s_12_CYSELG_810,
      O => clk_s_12_CYMUXG2_821
    );
  clk_s_12_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_12_G,
      O => clk_s_12_CYSELG_810
    );
  clk_s_12_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y29",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_12_CLKINV_808
    );
  clk_s_14_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      O => clk_s_14_LOGIC_ZERO_867
    );
  clk_s_14_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_XORF_891,
      O => clk_s_14_DXMUX_893
    );
  clk_s_14_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      I0 => clk_s_14_CYINIT_890,
      I1 => clk_s_14_F,
      O => clk_s_14_XORF_891
    );
  clk_s_14_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_LOGIC_ZERO_867,
      IB => clk_s_14_CYINIT_890,
      SEL => clk_s_14_CYSELF_873,
      O => Mcount_clk_s_cy(14)
    );
  clk_s_14_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_LOGIC_ZERO_867,
      IB => clk_s_14_LOGIC_ZERO_867,
      SEL => clk_s_14_CYSELF_873,
      O => clk_s_14_CYMUXF2_868
    );
  clk_s_14_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(13),
      O => clk_s_14_CYINIT_890
    );
  clk_s_14_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_F,
      O => clk_s_14_CYSELF_873
    );
  clk_s_14_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_XORG_875,
      O => clk_s_14_DYMUX_877
    );
  clk_s_14_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      I0 => Mcount_clk_s_cy(14),
      I1 => clk_s_14_G,
      O => clk_s_14_XORG_875
    );
  clk_s_14_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => Mcount_clk_s_cy(13),
      O => clk_s_14_FASTCARRY_870
    );
  clk_s_14_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      I0 => clk_s_14_CYSELG_858,
      I1 => clk_s_14_CYSELF_873,
      O => clk_s_14_CYAND_871
    );
  clk_s_14_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_CYMUXG2_869,
      IB => clk_s_14_FASTCARRY_870,
      SEL => clk_s_14_CYAND_871,
      O => clk_s_14_CYMUXFAST_872
    );
  clk_s_14_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X19Y30"
    )
    port map (
      IA => clk_s_14_LOGIC_ZERO_867,
      IB => clk_s_14_CYMUXF2_868,
      SEL => clk_s_14_CYSELG_858,
      O => clk_s_14_CYMUXG2_869
    );
  clk_s_14_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_G,
      O => clk_s_14_CYSELG_858
    );
  clk_s_14_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y30",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_14_CLKINV_856
    );
  clk_s_16_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y31",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_16_XORF_912,
      O => clk_s_16_DXMUX_914
    );
  clk_s_16_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X19Y31"
    )
    port map (
      I0 => clk_s_16_CYINIT_911,
      I1 => clk_s_16_rt_909,
      O => clk_s_16_XORF_912
    );
  clk_s_16_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X19Y31",
      PATHPULSE => 592 ps
    )
    port map (
      I => clk_s_14_CYMUXFAST_872,
      O => clk_s_16_CYINIT_911
    );
  clk_s_16_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y31",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_BUFGP,
      O => clk_s_16_CLKINV_901
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
      O => clk_s_16_rt_909
    );
  dataLCD_or0000_wg_cy_1_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      O => dataLCD_or0000_wg_cy_1_LOGIC_ONE_935
    );
  dataLCD_or0000_wg_cy_1_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_1_LOGIC_ONE_935,
      IB => dataLCD_or0000_wg_cy_1_CYINIT_946,
      SEL => dataLCD_or0000_wg_cy_1_CYSELF_940,
      O => dataLCD_or0000_wg_cy(0)
    );
  dataLCD_or0000_wg_cy_1_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X15Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_1_BXINV_938,
      O => dataLCD_or0000_wg_cy_1_CYINIT_946
    );
  dataLCD_or0000_wg_cy_1_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(0),
      O => dataLCD_or0000_wg_cy_1_CYSELF_940
    );
  dataLCD_or0000_wg_cy_1_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => '0',
      O => dataLCD_or0000_wg_cy_1_BXINV_938
    );
  dataLCD_or0000_wg_cy_1_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X15Y17"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_1_LOGIC_ONE_935,
      IB => dataLCD_or0000_wg_cy(0),
      SEL => dataLCD_or0000_wg_cy_1_CYSELG_929,
      O => dataLCD_or0000_wg_cy_1_CYMUXG_937
    );
  dataLCD_or0000_wg_cy_1_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(1),
      O => dataLCD_or0000_wg_cy_1_CYSELG_929
    );
  dataLCD_or0000_wg_lut_1_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y17"
    )
    port map (
      ADR0 => pres_state_FSM_FFd35_454,
      ADR1 => pres_state_FSM_FFd28_452,
      ADR2 => pres_state_FSM_FFd25_455,
      ADR3 => pres_state_FSM_FFd26_453,
      O => dataLCD_or0000_wg_lut(1)
    );
  dataLCD_or0000_wg_cy_3_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      O => dataLCD_or0000_wg_cy_3_LOGIC_ONE_964
    );
  dataLCD_or0000_wg_cy_3_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_3_LOGIC_ONE_964,
      IB => dataLCD_or0000_wg_cy_3_LOGIC_ONE_964,
      SEL => dataLCD_or0000_wg_cy_3_CYSELF_970,
      O => dataLCD_or0000_wg_cy_3_CYMUXF2_965
    );
  dataLCD_or0000_wg_cy_3_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(2),
      O => dataLCD_or0000_wg_cy_3_CYSELF_970
    );
  dataLCD_or0000_wg_cy_3_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_1_CYMUXG_937,
      O => dataLCD_or0000_wg_cy_3_FASTCARRY_967
    );
  dataLCD_or0000_wg_cy_3_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      I0 => dataLCD_or0000_wg_cy_3_CYSELG_958,
      I1 => dataLCD_or0000_wg_cy_3_CYSELF_970,
      O => dataLCD_or0000_wg_cy_3_CYAND_968
    );
  dataLCD_or0000_wg_cy_3_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_3_CYMUXG2_966,
      IB => dataLCD_or0000_wg_cy_3_FASTCARRY_967,
      SEL => dataLCD_or0000_wg_cy_3_CYAND_968,
      O => dataLCD_or0000_wg_cy_3_CYMUXFAST_969
    );
  dataLCD_or0000_wg_cy_3_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y18"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_3_LOGIC_ONE_964,
      IB => dataLCD_or0000_wg_cy_3_CYMUXF2_965,
      SEL => dataLCD_or0000_wg_cy_3_CYSELG_958,
      O => dataLCD_or0000_wg_cy_3_CYMUXG2_966
    );
  dataLCD_or0000_wg_cy_3_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(3),
      O => dataLCD_or0000_wg_cy_3_CYSELG_958
    );
  dataLCD_or0000_wg_lut_3_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y18"
    )
    port map (
      ADR0 => pres_state_FSM_FFd19_461,
      ADR1 => pres_state_FSM_FFd38_463,
      ADR2 => pres_state_FSM_FFd17_462,
      ADR3 => pres_state_FSM_FFd16_464,
      O => dataLCD_or0000_wg_lut(3)
    );
  dataLCD_or0000_wg_cy_5_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      O => dataLCD_or0000_wg_cy_5_LOGIC_ONE_994
    );
  dataLCD_or0000_wg_cy_5_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_5_LOGIC_ONE_994,
      IB => dataLCD_or0000_wg_cy_5_LOGIC_ONE_994,
      SEL => dataLCD_or0000_wg_cy_5_CYSELF_1000,
      O => dataLCD_or0000_wg_cy_5_CYMUXF2_995
    );
  dataLCD_or0000_wg_cy_5_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(4),
      O => dataLCD_or0000_wg_cy_5_CYSELF_1000
    );
  dataLCD_or0000_wg_cy_5_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_3_CYMUXFAST_969,
      O => dataLCD_or0000_wg_cy_5_FASTCARRY_997
    );
  dataLCD_or0000_wg_cy_5_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      I0 => dataLCD_or0000_wg_cy_5_CYSELG_988,
      I1 => dataLCD_or0000_wg_cy_5_CYSELF_1000,
      O => dataLCD_or0000_wg_cy_5_CYAND_998
    );
  dataLCD_or0000_wg_cy_5_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_5_CYMUXG2_996,
      IB => dataLCD_or0000_wg_cy_5_FASTCARRY_997,
      SEL => dataLCD_or0000_wg_cy_5_CYAND_998,
      O => dataLCD_or0000_wg_cy_5_CYMUXFAST_999
    );
  dataLCD_or0000_wg_cy_5_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      IA => dataLCD_or0000_wg_cy_5_LOGIC_ONE_994,
      IB => dataLCD_or0000_wg_cy_5_CYMUXF2_995,
      SEL => dataLCD_or0000_wg_cy_5_CYSELG_988,
      O => dataLCD_or0000_wg_cy_5_CYMUXG2_996
    );
  dataLCD_or0000_wg_cy_5_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(5),
      O => dataLCD_or0000_wg_cy_5_CYSELG_988
    );
  dataLCD_or0000_wg_lut_5_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y19"
    )
    port map (
      ADR0 => pres_state_FSM_FFd7_473,
      ADR1 => pres_state_FSM_FFd10_470,
      ADR2 => pres_state_FSM_FFd8_471,
      ADR3 => pres_state_FSM_FFd41_472,
      O => dataLCD_or0000_wg_lut(5)
    );
  dataLCD_or0000_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X15Y20"
    )
    port map (
      O => dataLCD_or0000_LOGIC_ONE_1024
    );
  dataLCD_or0000_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y20"
    )
    port map (
      IA => dataLCD_or0000_LOGIC_ONE_1024,
      IB => dataLCD_or0000_LOGIC_ONE_1024,
      SEL => dataLCD_or0000_CYSELF_1030,
      O => dataLCD_or0000_CYMUXF2_1025
    );
  dataLCD_or0000_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X15Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(6),
      O => dataLCD_or0000_CYSELF_1030
    );
  dataLCD_or0000_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X15Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_CYMUXFAST_1029,
      O => dataLCD_or0000
    );
  dataLCD_or0000_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X15Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_cy_5_CYMUXFAST_999,
      O => dataLCD_or0000_FASTCARRY_1027
    );
  dataLCD_or0000_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X15Y20"
    )
    port map (
      I0 => dataLCD_or0000_CYSELG_1018,
      I1 => dataLCD_or0000_CYSELF_1030,
      O => dataLCD_or0000_CYAND_1028
    );
  dataLCD_or0000_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X15Y20"
    )
    port map (
      IA => dataLCD_or0000_CYMUXG2_1026,
      IB => dataLCD_or0000_FASTCARRY_1027,
      SEL => dataLCD_or0000_CYAND_1028,
      O => dataLCD_or0000_CYMUXFAST_1029
    );
  dataLCD_or0000_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X15Y20"
    )
    port map (
      IA => dataLCD_or0000_LOGIC_ONE_1024,
      IB => dataLCD_or0000_CYMUXF2_1025,
      SEL => dataLCD_or0000_CYSELG_1018,
      O => dataLCD_or0000_CYMUXG2_1026
    );
  dataLCD_or0000_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X15Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000_wg_lut(7),
      O => dataLCD_or0000_CYSELG_1018
    );
  dataLCD_or0000_wg_lut_7_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y20"
    )
    port map (
      ADR0 => pres_state_FSM_FFd44_481,
      ADR1 => pres_state_FSM_FFd47_480,
      ADR2 => pres_state_FSM_FFd1_479,
      ADR3 => pres_state_FSM_FFd46_482,
      O => dataLCD_or0000_wg_lut(7)
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
      I => rs_OBUF_1059,
      O => rs_O
    );
  rs_525 : X_LATCHE
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
      O => rs_OBUF_1059
    );
  rs_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD60",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => rs_OUTPUT_OTCLK1INV_1053
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
      I => dataLCD_mux0000(0),
      O => dataLCD_0_OUTPUT_OFF_ODDRIN1_MUX
    );
  dataLCD_0_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD44",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_0_1076,
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
      O => dataLCD_0_1076
    );
  dataLCD_0_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD44",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_0_OUTPUT_OTCLK1INV_1070
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
      I => dataLCD_1_1093,
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
      O => dataLCD_1_1093
    );
  dataLCD_1_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD43",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_1_OUTPUT_OTCLK1INV_1087
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
      I => dataLCD_2_1110,
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
      O => dataLCD_2_1110
    );
  dataLCD_2_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD25",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_2_OUTPUT_OTCLK1INV_1104
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
      I => dataLCD_3_1127,
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
      O => dataLCD_3_1127
    );
  dataLCD_3_OUTPUT_OTCLK1INV : X_BUF
    generic map(
      LOC => "PAD24",
      PATHPULSE => 592 ps
    )
    port map (
      I => dataLCD_or0000,
      O => dataLCD_3_OUTPUT_OTCLK1INV_1121
    );
  clock_BUFGP_IBUFG : X_BUF
    generic map(
      LOC => "PAD92",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock,
      O => clock_BUFGP_IBUFG_1136
    );
  reset_IBUF : X_BUF
    generic map(
      LOC => "PAD91",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset,
      O => reset_IBUF_1143
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
      I => clock_BUFGP_IBUFG_1136,
      O => clock_BUFGP_BUFG_I0_INV
    );
  pres_state_FSM_FFd10_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd11_469,
      O => pres_state_FSM_FFd10_DXMUX_1171
    );
  pres_state_FSM_FFd10_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd10_470,
      O => pres_state_FSM_FFd10_DYMUX_1163
    );
  pres_state_FSM_FFd10_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd10_SRINVNOT
    );
  pres_state_FSM_FFd10_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd10_CLKINV_1160
    );
  pres_state_FSM_Out489_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X16Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out489_1187,
      O => pres_state_FSM_Out489_0
    );
  pres_state_FSM_Out489 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X16Y19"
    )
    port map (
      ADR0 => pres_state_FSM_FFd11_469,
      ADR1 => pres_state_FSM_FFd8_471,
      ADR2 => pres_state_FSM_FFd5_475,
      ADR3 => pres_state_FSM_FFd14_466,
      O => pres_state_FSM_Out489_1187
    );
  pres_state_FSM_FFd12_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd13_467,
      O => pres_state_FSM_FFd12_DXMUX_1207
    );
  pres_state_FSM_FFd12_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd12_496,
      O => pres_state_FSM_FFd12_DYMUX_1199
    );
  pres_state_FSM_FFd12_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd12_SRINVNOT
    );
  pres_state_FSM_FFd12_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd12_CLKINV_1196
    );
  pres_state_FSM_FFd14_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd15_497,
      O => pres_state_FSM_FFd14_DXMUX_1231
    );
  pres_state_FSM_FFd14_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd14_466,
      O => pres_state_FSM_FFd14_DYMUX_1223
    );
  pres_state_FSM_FFd14_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd14_SRINVNOT
    );
  pres_state_FSM_FFd14_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd14_CLKINV_1220
    );
  pres_state_FSM_FFd22_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd23_457,
      O => pres_state_FSM_FFd22_DXMUX_1255
    );
  pres_state_FSM_FFd22_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd22_458,
      O => pres_state_FSM_FFd22_DYMUX_1247
    );
  pres_state_FSM_FFd22_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd22_SRINVNOT
    );
  pres_state_FSM_FFd22_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd22_CLKINV_1244
    );
  pres_state_FSM_FFd16_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd17_462,
      O => pres_state_FSM_FFd16_DXMUX_1279
    );
  pres_state_FSM_FFd16_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd16_464,
      O => pres_state_FSM_FFd16_DYMUX_1271
    );
  pres_state_FSM_FFd16_SRINV : X_INV
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd16_SRINVNOT
    );
  pres_state_FSM_FFd16_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd16_CLKINV_1268
    );
  pres_state_FSM_FFd24_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd25_455,
      O => pres_state_FSM_FFd24_DXMUX_1303
    );
  pres_state_FSM_FFd24_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd24_499,
      O => pres_state_FSM_FFd24_DYMUX_1295
    );
  pres_state_FSM_FFd24_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd24_SRINVNOT
    );
  pres_state_FSM_FFd24_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd24_CLKINV_1292
    );
  pres_state_FSM_FFd32_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd33_500,
      O => pres_state_FSM_FFd32_DXMUX_1327
    );
  pres_state_FSM_FFd32_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd32_448,
      O => pres_state_FSM_FFd32_DYMUX_1319
    );
  pres_state_FSM_FFd32_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd32_SRINVNOT
    );
  pres_state_FSM_FFd32_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd32_CLKINV_1316
    );
  pres_state_FSM_FFd18_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd19_461,
      O => pres_state_FSM_FFd18_DXMUX_1351
    );
  pres_state_FSM_FFd18_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd18_501,
      O => pres_state_FSM_FFd18_DYMUX_1343
    );
  pres_state_FSM_FFd18_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd18_SRINVNOT
    );
  pres_state_FSM_FFd18_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y17",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd18_CLKINV_1340
    );
  pres_state_FSM_FFd26_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd27_502,
      O => pres_state_FSM_FFd26_DXMUX_1375
    );
  pres_state_FSM_FFd26_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd26_453,
      O => pres_state_FSM_FFd26_DYMUX_1367
    );
  pres_state_FSM_FFd26_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd26_SRINVNOT
    );
  pres_state_FSM_FFd26_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y14",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd26_CLKINV_1364
    );
  pres_state_FSM_FFd34_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd35_454,
      O => pres_state_FSM_FFd34_DXMUX_1399
    );
  pres_state_FSM_FFd34_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd34_450,
      O => pres_state_FSM_FFd34_DYMUX_1391
    );
  pres_state_FSM_FFd34_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd34_SRINVNOT
    );
  pres_state_FSM_FFd34_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd34_CLKINV_1388
    );
  pres_state_FSM_FFd42_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd43_477,
      O => pres_state_FSM_FFd42_DXMUX_1423
    );
  pres_state_FSM_FFd42_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd42_503,
      O => pres_state_FSM_FFd42_DYMUX_1415
    );
  pres_state_FSM_FFd42_SRINV : X_INV
    generic map(
      LOC => "SLICE_X17Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd42_SRINVNOT
    );
  pres_state_FSM_FFd42_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X17Y20",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd42_CLKINV_1412
    );
  pres_state_FSM_FFd20_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd21_498,
      O => pres_state_FSM_FFd20_DXMUX_1447
    );
  pres_state_FSM_FFd20_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd20_460,
      O => pres_state_FSM_FFd20_DYMUX_1439
    );
  pres_state_FSM_FFd20_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd20_SRINVNOT
    );
  pres_state_FSM_FFd20_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd20_CLKINV_1436
    );
  pres_state_FSM_FFd28_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd29_451,
      O => pres_state_FSM_FFd28_DXMUX_1471
    );
  pres_state_FSM_FFd28_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd28_452,
      O => pres_state_FSM_FFd28_DYMUX_1463
    );
  pres_state_FSM_FFd28_SRINV : X_INV
    generic map(
      LOC => "SLICE_X13Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd28_SRINVNOT
    );
  pres_state_FSM_FFd28_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y15",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd28_CLKINV_1460
    );
  pres_state_FSM_FFd36_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd37_459,
      O => pres_state_FSM_FFd36_DXMUX_1495
    );
  pres_state_FSM_FFd36_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd36_504,
      O => pres_state_FSM_FFd36_DYMUX_1487
    );
  pres_state_FSM_FFd36_SRINV : X_INV
    generic map(
      LOC => "SLICE_X16Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd36_SRINVNOT
    );
  pres_state_FSM_FFd36_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd36_CLKINV_1484
    );
  pres_state_FSM_FFd44_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd45_505,
      O => pres_state_FSM_FFd44_DXMUX_1519
    );
  pres_state_FSM_FFd44_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd44_481,
      O => pres_state_FSM_FFd44_DYMUX_1511
    );
  pres_state_FSM_FFd44_SRINV : X_INV
    generic map(
      LOC => "SLICE_X17Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd44_SRINVNOT
    );
  pres_state_FSM_FFd44_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X17Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd44_CLKINV_1508
    );
  pres_state_FSM_Out4821_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X17Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out4821_1535,
      O => pres_state_FSM_Out4821_0
    );
  pres_state_FSM_Out4821 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X17Y21"
    )
    port map (
      ADR0 => pres_state_FSM_FFd44_481,
      ADR1 => pres_state_FSM_FFd47_480,
      ADR2 => pres_state_FSM_FFd2_478,
      ADR3 => pres_state_FSM_FFd41_472,
      O => pres_state_FSM_Out4821_1535
    );
  pres_state_FSM_FFd30_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd31_449,
      O => pres_state_FSM_FFd30_DXMUX_1555
    );
  pres_state_FSM_FFd30_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd30_507,
      O => pres_state_FSM_FFd30_DYMUX_1547
    );
  pres_state_FSM_FFd30_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd30_SRINVNOT
    );
  pres_state_FSM_FFd30_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd30_CLKINV_1544
    );
  pres_state_FSM_FFd38_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd39_508,
      O => pres_state_FSM_FFd38_DXMUX_1579
    );
  pres_state_FSM_FFd38_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X17Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd38_463,
      O => pres_state_FSM_FFd38_DYMUX_1571
    );
  pres_state_FSM_FFd38_SRINV : X_INV
    generic map(
      LOC => "SLICE_X17Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd38_SRINVNOT
    );
  pres_state_FSM_FFd38_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X17Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd38_CLKINV_1568
    );
  pres_state_FSM_FFd46_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd47_480,
      O => pres_state_FSM_FFd46_DXMUX_1603
    );
  pres_state_FSM_FFd46_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd46_482,
      O => pres_state_FSM_FFd46_DYMUX_1595
    );
  pres_state_FSM_FFd46_SRINV : X_INV
    generic map(
      LOC => "SLICE_X16Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd46_SRINVNOT
    );
  pres_state_FSM_FFd46_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd46_CLKINV_1592
    );
  pres_state_FSM_FFd40_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd41_472,
      O => pres_state_FSM_FFd40_DXMUX_1627
    );
  pres_state_FSM_FFd40_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd40_468,
      O => pres_state_FSM_FFd40_DYMUX_1619
    );
  pres_state_FSM_FFd40_SRINV : X_INV
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd40_SRINVNOT
    );
  pres_state_FSM_FFd40_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd40_CLKINV_1616
    );
  pres_state_FSM_FFd48_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd48_BXINV_1650,
      O => pres_state_FSM_FFd48_DXMUX_1651
    );
  pres_state_FSM_FFd48_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => '0',
      O => pres_state_FSM_FFd48_BXINV_1650
    );
  pres_state_FSM_FFd48_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd48_509,
      O => pres_state_FSM_FFd48_DYMUX_1643
    );
  pres_state_FSM_FFd48_SRINV : X_INV
    generic map(
      LOC => "SLICE_X18Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd48_SRINVNOT
    );
  pres_state_FSM_FFd48_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y22",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd48_CLKINV_1640
    );
  en_OBUF_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X16Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out4826_pack_1,
      O => pres_state_FSM_Out4826_511
    );
  pres_state_FSM_Out4826 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X16Y16"
    )
    port map (
      ADR0 => pres_state_FSM_FFd29_451,
      ADR1 => pres_state_FSM_FFd32_448,
      ADR2 => pres_state_FSM_FFd38_463,
      ADR3 => pres_state_FSM_FFd35_454,
      O => pres_state_FSM_Out4826_pack_1
    );
  dataLCD_mux0000_0_1 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X16Y23"
    )
    port map (
      ADR0 => pres_state_FSM_FFd48_509,
      ADR1 => pres_state_FSM_FFd45_505,
      ADR2 => pres_state_FSM_FFd42_503,
      ADR3 => pres_state_FSM_FFd21_498,
      O => dataLCD_mux0000(0)
    );
  rs_mux00001 : X_LUT4
    generic map(
      INIT => X"FFCC",
      LOC => "SLICE_X16Y21"
    )
    port map (
      ADR0 => VCC,
      ADR1 => pres_state_FSM_FFd3_513,
      ADR2 => VCC,
      ADR3 => pres_state_FSM_FFd6_512,
      O => rs_mux0000
    );
  dataLCD_mux0000_3_1 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X15Y15"
    )
    port map (
      ADR0 => pres_state_FSM_FFd9_494,
      ADR1 => pres_state_FSM_FFd33_500,
      ADR2 => pres_state_FSM_FFd3_513,
      ADR3 => pres_state_FSM_FFd27_502,
      O => dataLCD_mux0000(3)
    );
  pres_state_FSM_FFd1_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd1_BYINV_1737,
      O => pres_state_FSM_FFd1_DYMUX_1738
    );
  pres_state_FSM_FFd1_BYINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => '1',
      O => pres_state_FSM_FFd1_BYINV_1737
    );
  pres_state_FSM_FFd1_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd1_CLKINV_1735
    );
  pres_state_FSM_FFd1_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd2_478,
      O => pres_state_FSM_FFd1_CEINV_1734
    );
  pres_state_FSM_FFd2_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd3_513,
      O => pres_state_FSM_FFd2_DYMUX_1753
    );
  pres_state_FSM_FFd2_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd2_CLKINV_1750
    );
  pres_state_FSM_FFd4_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd5_475,
      O => pres_state_FSM_FFd4_DXMUX_1777
    );
  pres_state_FSM_FFd4_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd4_476,
      O => pres_state_FSM_FFd4_DYMUX_1769
    );
  pres_state_FSM_FFd4_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd4_SRINVNOT
    );
  pres_state_FSM_FFd4_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd4_CLKINV_1766
    );
  dataLCD_mux0000_1_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X17Y23",
      PATHPULSE => 592 ps
    )
    port map (
      I => N01_pack_1,
      O => N01
    );
  dataLCD_mux0000_1_SW0 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X17Y23"
    )
    port map (
      ADR0 => pres_state_FSM_FFd39_508,
      ADR1 => pres_state_FSM_FFd42_503,
      ADR2 => pres_state_FSM_FFd45_505,
      ADR3 => pres_state_FSM_FFd48_509,
      O => N01_pack_1
    );
  pres_state_FSM_FFd6_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd7_473,
      O => pres_state_FSM_FFd6_DXMUX_1825
    );
  pres_state_FSM_FFd6_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd6_512,
      O => pres_state_FSM_FFd6_DYMUX_1817
    );
  pres_state_FSM_FFd6_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd6_SRINVNOT
    );
  pres_state_FSM_FFd6_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd6_CLKINV_1814
    );
  pres_state_FSM_FFd8_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd9_494,
      O => pres_state_FSM_FFd8_DXMUX_1849
    );
  pres_state_FSM_FFd8_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_FFd8_471,
      O => pres_state_FSM_FFd8_DYMUX_1841
    );
  pres_state_FSM_FFd8_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd8_SRINVNOT
    );
  pres_state_FSM_FFd8_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y21",
      PATHPULSE => 592 ps
    )
    port map (
      I => clock_o,
      O => pres_state_FSM_FFd8_CLKINV_1838
    );
  pres_state_FSM_Out484_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X14Y16",
      PATHPULSE => 592 ps
    )
    port map (
      I => pres_state_FSM_Out484_1865,
      O => pres_state_FSM_Out484_0
    );
  pres_state_FSM_Out484 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X14Y16"
    )
    port map (
      ADR0 => pres_state_FSM_FFd26_453,
      ADR1 => pres_state_FSM_FFd20_460,
      ADR2 => pres_state_FSM_FFd17_462,
      ADR3 => pres_state_FSM_FFd23_457,
      O => pres_state_FSM_Out484_1865
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
      I => clk_s_0_DXMUX_557,
      CE => VCC,
      CLK => clk_s_0_CLKINV_522,
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
      I => clk_s_2_DYMUX_589,
      CE => VCC,
      CLK => clk_s_2_CLKINV_568,
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
      I => clk_s_2_DXMUX_605,
      CE => VCC,
      CLK => clk_s_2_CLKINV_568,
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
      I => clk_s_4_DYMUX_637,
      CE => VCC,
      CLK => clk_s_4_CLKINV_616,
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
      I => clk_s_4_DXMUX_653,
      CE => VCC,
      CLK => clk_s_4_CLKINV_616,
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
      I => clk_s_6_DYMUX_685,
      CE => VCC,
      CLK => clk_s_6_CLKINV_664,
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
      I => clk_s_6_DXMUX_701,
      CE => VCC,
      CLK => clk_s_6_CLKINV_664,
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
      I => clk_s_8_DYMUX_733,
      CE => VCC,
      CLK => clk_s_8_CLKINV_712,
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
      I => clk_s_8_DXMUX_749,
      CE => VCC,
      CLK => clk_s_8_CLKINV_712,
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
      I => clk_s_10_DYMUX_781,
      CE => VCC,
      CLK => clk_s_10_CLKINV_760,
      SET => GND,
      RST => GND,
      O => clk_s(11)
    );
  pres_state_FSM_FFd6 : X_FF
    generic map(
      LOC => "SLICE_X14Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd6_DXMUX_1825,
      CE => VCC,
      CLK => pres_state_FSM_FFd6_CLKINV_1814,
      SET => GND,
      RST => pres_state_FSM_FFd6_SRINVNOT,
      O => pres_state_FSM_FFd6_512
    );
  pres_state_FSM_FFd7 : X_FF
    generic map(
      LOC => "SLICE_X14Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd8_DYMUX_1841,
      CE => VCC,
      CLK => pres_state_FSM_FFd8_CLKINV_1838,
      SET => GND,
      RST => pres_state_FSM_FFd8_SRINVNOT,
      O => pres_state_FSM_FFd7_473
    );
  pres_state_FSM_FFd8 : X_FF
    generic map(
      LOC => "SLICE_X14Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd8_DXMUX_1849,
      CE => VCC,
      CLK => pres_state_FSM_FFd8_CLKINV_1838,
      SET => GND,
      RST => pres_state_FSM_FFd8_SRINVNOT,
      O => pres_state_FSM_FFd8_471
    );
  dataLCD_or0000_wg_lut_6_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y20"
    )
    port map (
      ADR0 => pres_state_FSM_FFd4_476,
      ADR1 => pres_state_FSM_FFd43_477,
      ADR2 => pres_state_FSM_FFd2_478,
      ADR3 => pres_state_FSM_FFd5_475,
      O => dataLCD_or0000_wg_lut(6)
    );
  pres_state_FSM_FFd9 : X_FF
    generic map(
      LOC => "SLICE_X14Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd10_DYMUX_1163,
      CE => VCC,
      CLK => pres_state_FSM_FFd10_CLKINV_1160,
      SET => GND,
      RST => pres_state_FSM_FFd10_SRINVNOT,
      O => pres_state_FSM_FFd9_494
    );
  pres_state_FSM_FFd10 : X_FF
    generic map(
      LOC => "SLICE_X14Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd10_DXMUX_1171,
      CE => VCC,
      CLK => pres_state_FSM_FFd10_CLKINV_1160,
      SET => GND,
      RST => pres_state_FSM_FFd10_SRINVNOT,
      O => pres_state_FSM_FFd10_470
    );
  pres_state_FSM_FFd11 : X_FF
    generic map(
      LOC => "SLICE_X14Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd12_DYMUX_1199,
      CE => VCC,
      CLK => pres_state_FSM_FFd12_CLKINV_1196,
      SET => GND,
      RST => pres_state_FSM_FFd12_SRINVNOT,
      O => pres_state_FSM_FFd11_469
    );
  clk_s_10 : X_FF
    generic map(
      LOC => "SLICE_X19Y28",
      INIT => '0'
    )
    port map (
      I => clk_s_10_DXMUX_797,
      CE => VCC,
      CLK => clk_s_10_CLKINV_760,
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
      I => clk_s_12_DYMUX_829,
      CE => VCC,
      CLK => clk_s_12_CLKINV_808,
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
      I => clk_s_12_DXMUX_845,
      CE => VCC,
      CLK => clk_s_12_CLKINV_808,
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
      I => clk_s_14_DYMUX_877,
      CE => VCC,
      CLK => clk_s_14_CLKINV_856,
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
      I => clk_s_14_DXMUX_893,
      CE => VCC,
      CLK => clk_s_14_CLKINV_856,
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
      I => clk_s_16_DXMUX_914,
      CE => VCC,
      CLK => clk_s_16_CLKINV_901,
      SET => GND,
      RST => GND,
      O => clk_s(16)
    );
  dataLCD_or0000_wg_lut_0_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y17"
    )
    port map (
      ADR0 => pres_state_FSM_FFd31_449,
      ADR1 => pres_state_FSM_FFd34_450,
      ADR2 => pres_state_FSM_FFd32_448,
      ADR3 => pres_state_FSM_FFd29_451,
      O => dataLCD_or0000_wg_lut(0)
    );
  dataLCD_or0000_wg_lut_2_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y18"
    )
    port map (
      ADR0 => pres_state_FSM_FFd37_459,
      ADR1 => pres_state_FSM_FFd23_457,
      ADR2 => pres_state_FSM_FFd20_460,
      ADR3 => pres_state_FSM_FFd22_458,
      O => dataLCD_or0000_wg_lut(2)
    );
  dataLCD_or0000_wg_lut_4_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X15Y19"
    )
    port map (
      ADR0 => pres_state_FSM_FFd11_469,
      ADR1 => pres_state_FSM_FFd13_467,
      ADR2 => pres_state_FSM_FFd40_468,
      ADR3 => pres_state_FSM_FFd14_466,
      O => dataLCD_or0000_wg_lut(4)
    );
  pres_state_FSM_FFd12 : X_FF
    generic map(
      LOC => "SLICE_X14Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd12_DXMUX_1207,
      CE => VCC,
      CLK => pres_state_FSM_FFd12_CLKINV_1196,
      SET => GND,
      RST => pres_state_FSM_FFd12_SRINVNOT,
      O => pres_state_FSM_FFd12_496
    );
  pres_state_FSM_FFd13 : X_FF
    generic map(
      LOC => "SLICE_X15Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd14_DYMUX_1223,
      CE => VCC,
      CLK => pres_state_FSM_FFd14_CLKINV_1220,
      SET => GND,
      RST => pres_state_FSM_FFd14_SRINVNOT,
      O => pres_state_FSM_FFd13_467
    );
  pres_state_FSM_FFd14 : X_FF
    generic map(
      LOC => "SLICE_X15Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd14_DXMUX_1231,
      CE => VCC,
      CLK => pres_state_FSM_FFd14_CLKINV_1220,
      SET => GND,
      RST => pres_state_FSM_FFd14_SRINVNOT,
      O => pres_state_FSM_FFd14_466
    );
  pres_state_FSM_FFd21 : X_FF
    generic map(
      LOC => "SLICE_X15Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd22_DYMUX_1247,
      CE => VCC,
      CLK => pres_state_FSM_FFd22_CLKINV_1244,
      SET => GND,
      RST => pres_state_FSM_FFd22_SRINVNOT,
      O => pres_state_FSM_FFd21_498
    );
  pres_state_FSM_FFd22 : X_FF
    generic map(
      LOC => "SLICE_X15Y16",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd22_DXMUX_1255,
      CE => VCC,
      CLK => pres_state_FSM_FFd22_CLKINV_1244,
      SET => GND,
      RST => pres_state_FSM_FFd22_SRINVNOT,
      O => pres_state_FSM_FFd22_458
    );
  pres_state_FSM_FFd15 : X_FF
    generic map(
      LOC => "SLICE_X13Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd16_DYMUX_1271,
      CE => VCC,
      CLK => pres_state_FSM_FFd16_CLKINV_1268,
      SET => GND,
      RST => pres_state_FSM_FFd16_SRINVNOT,
      O => pres_state_FSM_FFd15_497
    );
  pres_state_FSM_FFd16 : X_FF
    generic map(
      LOC => "SLICE_X13Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd16_DXMUX_1279,
      CE => VCC,
      CLK => pres_state_FSM_FFd16_CLKINV_1268,
      SET => GND,
      RST => pres_state_FSM_FFd16_SRINVNOT,
      O => pres_state_FSM_FFd16_464
    );
  pres_state_FSM_FFd23 : X_FF
    generic map(
      LOC => "SLICE_X14Y15",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd24_DYMUX_1295,
      CE => VCC,
      CLK => pres_state_FSM_FFd24_CLKINV_1292,
      SET => GND,
      RST => pres_state_FSM_FFd24_SRINVNOT,
      O => pres_state_FSM_FFd23_457
    );
  pres_state_FSM_FFd24 : X_FF
    generic map(
      LOC => "SLICE_X14Y15",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd24_DXMUX_1303,
      CE => VCC,
      CLK => pres_state_FSM_FFd24_CLKINV_1292,
      SET => GND,
      RST => pres_state_FSM_FFd24_SRINVNOT,
      O => pres_state_FSM_FFd24_499
    );
  pres_state_FSM_FFd31 : X_FF
    generic map(
      LOC => "SLICE_X14Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd32_DYMUX_1319,
      CE => VCC,
      CLK => pres_state_FSM_FFd32_CLKINV_1316,
      SET => GND,
      RST => pres_state_FSM_FFd32_SRINVNOT,
      O => pres_state_FSM_FFd31_449
    );
  pres_state_FSM_FFd32 : X_FF
    generic map(
      LOC => "SLICE_X14Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd32_DXMUX_1327,
      CE => VCC,
      CLK => pres_state_FSM_FFd32_CLKINV_1316,
      SET => GND,
      RST => pres_state_FSM_FFd32_SRINVNOT,
      O => pres_state_FSM_FFd32_448
    );
  pres_state_FSM_FFd17 : X_FF
    generic map(
      LOC => "SLICE_X14Y17",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd18_DYMUX_1343,
      CE => VCC,
      CLK => pres_state_FSM_FFd18_CLKINV_1340,
      SET => GND,
      RST => pres_state_FSM_FFd18_SRINVNOT,
      O => pres_state_FSM_FFd17_462
    );
  pres_state_FSM_FFd18 : X_FF
    generic map(
      LOC => "SLICE_X14Y17",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd18_DXMUX_1351,
      CE => VCC,
      CLK => pres_state_FSM_FFd18_CLKINV_1340,
      SET => GND,
      RST => pres_state_FSM_FFd18_SRINVNOT,
      O => pres_state_FSM_FFd18_501
    );
  pres_state_FSM_FFd25 : X_FF
    generic map(
      LOC => "SLICE_X12Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd26_DYMUX_1367,
      CE => VCC,
      CLK => pres_state_FSM_FFd26_CLKINV_1364,
      SET => GND,
      RST => pres_state_FSM_FFd26_SRINVNOT,
      O => pres_state_FSM_FFd25_455
    );
  pres_state_FSM_FFd26 : X_FF
    generic map(
      LOC => "SLICE_X12Y14",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd26_DXMUX_1375,
      CE => VCC,
      CLK => pres_state_FSM_FFd26_CLKINV_1364,
      SET => GND,
      RST => pres_state_FSM_FFd26_SRINVNOT,
      O => pres_state_FSM_FFd26_453
    );
  pres_state_FSM_FFd33 : X_FF
    generic map(
      LOC => "SLICE_X15Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd34_DYMUX_1391,
      CE => VCC,
      CLK => pres_state_FSM_FFd34_CLKINV_1388,
      SET => GND,
      RST => pres_state_FSM_FFd34_SRINVNOT,
      O => pres_state_FSM_FFd33_500
    );
  pres_state_FSM_FFd34 : X_FF
    generic map(
      LOC => "SLICE_X15Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd34_DXMUX_1399,
      CE => VCC,
      CLK => pres_state_FSM_FFd34_CLKINV_1388,
      SET => GND,
      RST => pres_state_FSM_FFd34_SRINVNOT,
      O => pres_state_FSM_FFd34_450
    );
  pres_state_FSM_FFd41 : X_FF
    generic map(
      LOC => "SLICE_X17Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd42_DYMUX_1415,
      CE => VCC,
      CLK => pres_state_FSM_FFd42_CLKINV_1412,
      SET => GND,
      RST => pres_state_FSM_FFd42_SRINVNOT,
      O => pres_state_FSM_FFd41_472
    );
  pres_state_FSM_FFd42 : X_FF
    generic map(
      LOC => "SLICE_X17Y20",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd42_DXMUX_1423,
      CE => VCC,
      CLK => pres_state_FSM_FFd42_CLKINV_1412,
      SET => GND,
      RST => pres_state_FSM_FFd42_SRINVNOT,
      O => pres_state_FSM_FFd42_503
    );
  pres_state_FSM_FFd19 : X_FF
    generic map(
      LOC => "SLICE_X12Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd20_DYMUX_1439,
      CE => VCC,
      CLK => pres_state_FSM_FFd20_CLKINV_1436,
      SET => GND,
      RST => pres_state_FSM_FFd20_SRINVNOT,
      O => pres_state_FSM_FFd19_461
    );
  pres_state_FSM_FFd20 : X_FF
    generic map(
      LOC => "SLICE_X12Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd20_DXMUX_1447,
      CE => VCC,
      CLK => pres_state_FSM_FFd20_CLKINV_1436,
      SET => GND,
      RST => pres_state_FSM_FFd20_SRINVNOT,
      O => pres_state_FSM_FFd20_460
    );
  pres_state_FSM_FFd27 : X_FF
    generic map(
      LOC => "SLICE_X13Y15",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd28_DYMUX_1463,
      CE => VCC,
      CLK => pres_state_FSM_FFd28_CLKINV_1460,
      SET => GND,
      RST => pres_state_FSM_FFd28_SRINVNOT,
      O => pres_state_FSM_FFd27_502
    );
  pres_state_FSM_FFd28 : X_FF
    generic map(
      LOC => "SLICE_X13Y15",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd28_DXMUX_1471,
      CE => VCC,
      CLK => pres_state_FSM_FFd28_CLKINV_1460,
      SET => GND,
      RST => pres_state_FSM_FFd28_SRINVNOT,
      O => pres_state_FSM_FFd28_452
    );
  pres_state_FSM_FFd35 : X_FF
    generic map(
      LOC => "SLICE_X16Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd36_DYMUX_1487,
      CE => VCC,
      CLK => pres_state_FSM_FFd36_CLKINV_1484,
      SET => GND,
      RST => pres_state_FSM_FFd36_SRINVNOT,
      O => pres_state_FSM_FFd35_454
    );
  pres_state_FSM_FFd36 : X_FF
    generic map(
      LOC => "SLICE_X16Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd36_DXMUX_1495,
      CE => VCC,
      CLK => pres_state_FSM_FFd36_CLKINV_1484,
      SET => GND,
      RST => pres_state_FSM_FFd36_SRINVNOT,
      O => pres_state_FSM_FFd36_504
    );
  pres_state_FSM_FFd43 : X_FF
    generic map(
      LOC => "SLICE_X17Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd44_DYMUX_1511,
      CE => VCC,
      CLK => pres_state_FSM_FFd44_CLKINV_1508,
      SET => GND,
      RST => pres_state_FSM_FFd44_SRINVNOT,
      O => pres_state_FSM_FFd43_477
    );
  pres_state_FSM_FFd44 : X_FF
    generic map(
      LOC => "SLICE_X17Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd44_DXMUX_1519,
      CE => VCC,
      CLK => pres_state_FSM_FFd44_CLKINV_1508,
      SET => GND,
      RST => pres_state_FSM_FFd44_SRINVNOT,
      O => pres_state_FSM_FFd44_481
    );
  pres_state_FSM_FFd29 : X_FF
    generic map(
      LOC => "SLICE_X14Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd30_DYMUX_1547,
      CE => VCC,
      CLK => pres_state_FSM_FFd30_CLKINV_1544,
      SET => GND,
      RST => pres_state_FSM_FFd30_SRINVNOT,
      O => pres_state_FSM_FFd29_451
    );
  pres_state_FSM_FFd30 : X_FF
    generic map(
      LOC => "SLICE_X14Y12",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd30_DXMUX_1555,
      CE => VCC,
      CLK => pres_state_FSM_FFd30_CLKINV_1544,
      SET => GND,
      RST => pres_state_FSM_FFd30_SRINVNOT,
      O => pres_state_FSM_FFd30_507
    );
  pres_state_FSM_FFd37 : X_FF
    generic map(
      LOC => "SLICE_X17Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd38_DYMUX_1571,
      CE => VCC,
      CLK => pres_state_FSM_FFd38_CLKINV_1568,
      SET => GND,
      RST => pres_state_FSM_FFd38_SRINVNOT,
      O => pres_state_FSM_FFd37_459
    );
  pres_state_FSM_FFd38 : X_FF
    generic map(
      LOC => "SLICE_X17Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd38_DXMUX_1579,
      CE => VCC,
      CLK => pres_state_FSM_FFd38_CLKINV_1568,
      SET => GND,
      RST => pres_state_FSM_FFd38_SRINVNOT,
      O => pres_state_FSM_FFd38_463
    );
  pres_state_FSM_FFd45 : X_FF
    generic map(
      LOC => "SLICE_X16Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd46_DYMUX_1595,
      CE => VCC,
      CLK => pres_state_FSM_FFd46_CLKINV_1592,
      SET => GND,
      RST => pres_state_FSM_FFd46_SRINVNOT,
      O => pres_state_FSM_FFd45_505
    );
  pres_state_FSM_FFd46 : X_FF
    generic map(
      LOC => "SLICE_X16Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd46_DXMUX_1603,
      CE => VCC,
      CLK => pres_state_FSM_FFd46_CLKINV_1592,
      SET => GND,
      RST => pres_state_FSM_FFd46_SRINVNOT,
      O => pres_state_FSM_FFd46_482
    );
  pres_state_FSM_FFd39 : X_FF
    generic map(
      LOC => "SLICE_X18Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd40_DYMUX_1619,
      CE => VCC,
      CLK => pres_state_FSM_FFd40_CLKINV_1616,
      SET => GND,
      RST => pres_state_FSM_FFd40_SRINVNOT,
      O => pres_state_FSM_FFd39_508
    );
  pres_state_FSM_FFd40 : X_FF
    generic map(
      LOC => "SLICE_X18Y21",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd40_DXMUX_1627,
      CE => VCC,
      CLK => pres_state_FSM_FFd40_CLKINV_1616,
      SET => GND,
      RST => pres_state_FSM_FFd40_SRINVNOT,
      O => pres_state_FSM_FFd40_468
    );
  pres_state_FSM_FFd47 : X_FF
    generic map(
      LOC => "SLICE_X18Y22",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd48_DYMUX_1643,
      CE => VCC,
      CLK => pres_state_FSM_FFd48_CLKINV_1640,
      SET => GND,
      RST => pres_state_FSM_FFd48_SRINVNOT,
      O => pres_state_FSM_FFd47_480
    );
  pres_state_FSM_FFd48 : X_FF
    generic map(
      LOC => "SLICE_X18Y22",
      INIT => '1'
    )
    port map (
      I => pres_state_FSM_FFd48_DXMUX_1651,
      CE => VCC,
      CLK => pres_state_FSM_FFd48_CLKINV_1640,
      SET => pres_state_FSM_FFd48_SRINVNOT,
      RST => GND,
      O => pres_state_FSM_FFd48_509
    );
  pres_state_FSM_Out4836 : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X16Y16"
    )
    port map (
      ADR0 => pres_state_FSM_Out484_0,
      ADR1 => pres_state_FSM_Out489_0,
      ADR2 => pres_state_FSM_Out4821_0,
      ADR3 => pres_state_FSM_Out4826_511,
      O => en_OBUF_1678
    );
  dataLCD_mux0000_2_1 : X_LUT4
    generic map(
      INIT => X"FEFE",
      LOC => "SLICE_X16Y21"
    )
    port map (
      ADR0 => pres_state_FSM_FFd15_497,
      ADR1 => pres_state_FSM_FFd6_512,
      ADR2 => pres_state_FSM_FFd9_494,
      ADR3 => VCC,
      O => dataLCD_mux0000(2)
    );
  pres_state_FSM_FFd1 : X_FF
    generic map(
      LOC => "SLICE_X18Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd1_DYMUX_1738,
      CE => pres_state_FSM_FFd1_CEINV_1734,
      CLK => pres_state_FSM_FFd1_CLKINV_1735,
      SET => GND,
      RST => pres_state_FSM_FFd1_FFY_RSTAND_1744,
      O => pres_state_FSM_FFd1_479
    );
  pres_state_FSM_FFd1_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X18Y19",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd1_FFY_RSTAND_1744
    );
  pres_state_FSM_FFd2 : X_FF
    generic map(
      LOC => "SLICE_X16Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd2_DYMUX_1753,
      CE => VCC,
      CLK => pres_state_FSM_FFd2_CLKINV_1750,
      SET => GND,
      RST => pres_state_FSM_FFd2_FFY_RSTAND_1758,
      O => pres_state_FSM_FFd2_478
    );
  pres_state_FSM_FFd2_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X16Y18",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_0,
      O => pres_state_FSM_FFd2_FFY_RSTAND_1758
    );
  pres_state_FSM_FFd3 : X_FF
    generic map(
      LOC => "SLICE_X14Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd4_DYMUX_1769,
      CE => VCC,
      CLK => pres_state_FSM_FFd4_CLKINV_1766,
      SET => GND,
      RST => pres_state_FSM_FFd4_SRINVNOT,
      O => pres_state_FSM_FFd3_513
    );
  pres_state_FSM_FFd4 : X_FF
    generic map(
      LOC => "SLICE_X14Y18",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd4_DXMUX_1777,
      CE => VCC,
      CLK => pres_state_FSM_FFd4_CLKINV_1766,
      SET => GND,
      RST => pres_state_FSM_FFd4_SRINVNOT,
      O => pres_state_FSM_FFd4_476
    );
  dataLCD_mux0000_1_Q : X_LUT4
    generic map(
      INIT => X"FFFE",
      LOC => "SLICE_X17Y23"
    )
    port map (
      ADR0 => pres_state_FSM_FFd36_504,
      ADR1 => pres_state_FSM_FFd9_494,
      ADR2 => pres_state_FSM_FFd15_497,
      ADR3 => N01,
      O => dataLCD_mux0000(1)
    );
  pres_state_FSM_FFd5 : X_FF
    generic map(
      LOC => "SLICE_X14Y19",
      INIT => '0'
    )
    port map (
      I => pres_state_FSM_FFd6_DYMUX_1817,
      CE => VCC,
      CLK => pres_state_FSM_FFd6_CLKINV_1814,
      SET => GND,
      RST => pres_state_FSM_FFd6_SRINVNOT,
      O => pres_state_FSM_FFd5_475
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
      INIT => X"CCCC",
      LOC => "SLICE_X19Y24"
    )
    port map (
      ADR0 => VCC,
      ADR1 => clk_s(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_2_G
    );
  clk_s_4_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X19Y25"
    )
    port map (
      ADR0 => clk_s(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_4_F
    );
  clk_s_4_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X19Y25"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => clk_s(5),
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
      INIT => X"CCCC",
      LOC => "SLICE_X19Y26"
    )
    port map (
      ADR0 => VCC,
      ADR1 => clk_s(7),
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
      INIT => X"AAAA",
      LOC => "SLICE_X19Y27"
    )
    port map (
      ADR0 => clk_s(9),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_8_G
    );
  clk_s_10_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X19Y28"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => clk_s(10),
      ADR3 => VCC,
      O => clk_s_10_F
    );
  clk_s_10_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X19Y28"
    )
    port map (
      ADR0 => VCC,
      ADR1 => clk_s(11),
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_10_G
    );
  clk_s_12_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X19Y29"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => clk_s(12),
      O => clk_s_12_F
    );
  clk_s_12_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X19Y29"
    )
    port map (
      ADR0 => clk_s(13),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_12_G
    );
  clk_s_14_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X19Y30"
    )
    port map (
      ADR0 => clk_s(14),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => clk_s_14_F
    );
  clk_s_14_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X19Y30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => clk_s(15),
      ADR3 => VCC,
      O => clk_s_14_G
    );
  en_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD59",
      PATHPULSE => 592 ps
    )
    port map (
      I => en_OBUF_1678,
      O => en_O
    );
  reset_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD91",
      PATHPULSE => 592 ps
    )
    port map (
      I => reset_IBUF_1143,
      O => reset_IBUF_0
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
      I => rs_OUTPUT_OTCLK1INV_1053,
      O => NlwInverterSignal_rs_CLK
    );
  NlwInverterBlock_dataLCD_0_CLK : X_INV
    port map (
      I => dataLCD_0_OUTPUT_OTCLK1INV_1070,
      O => NlwInverterSignal_dataLCD_0_CLK
    );
  NlwInverterBlock_dataLCD_1_CLK : X_INV
    port map (
      I => dataLCD_1_OUTPUT_OTCLK1INV_1087,
      O => NlwInverterSignal_dataLCD_1_CLK
    );
  NlwInverterBlock_dataLCD_2_CLK : X_INV
    port map (
      I => dataLCD_2_OUTPUT_OTCLK1INV_1104,
      O => NlwInverterSignal_dataLCD_2_CLK
    );
  NlwInverterBlock_dataLCD_3_CLK : X_INV
    port map (
      I => dataLCD_3_OUTPUT_OTCLK1INV_1121,
      O => NlwInverterSignal_dataLCD_3_CLK
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

