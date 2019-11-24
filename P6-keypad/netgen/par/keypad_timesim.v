////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.49d
//  \   \         Application: netgen
//  /   /         Filename: keypad_timesim.v
// /___/   /\     Timestamp: Fri Feb  1 20:34:41 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -s 4 -pcf keypad.pcf -sdf_anno true -sdf_path netgen/par -insert_glbl true -insert_pp_buffers true -w -dir netgen/par -ofmt verilog -sim keypad.ncd keypad_timesim.v 
// Device	: 3s250ecp132-4 (PRODUCTION 1.27 2012-12-04)
// Input file	: keypad.ncd
// Output file	: /home/hendri/Documents/workspaceXilinx/P6-keypad/netgen/par/keypad_timesim.v
// # of Modules	: 1
// Design Name	: keypad
// Xilinx        : /opt/Xilinx/14.4/ISE_DS/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module keypad (
  clk, reset, pulse, keyOut, dataout, keyIn
);
  input clk;
  input reset;
  output pulse;
  output [3 : 0] keyOut;
  output [7 : 0] dataout;
  input [3 : 0] keyIn;
  wire dataout_0_200;
  wire dataout_1_201;
  wire dataout_2_203;
  wire keyIn_0_IBUF_204;
  wire keyIn_1_IBUF_206;
  wire keyIn_2_IBUF_207;
  wire keyIn_3_IBUF_208;
  wire pulseSig_209;
  wire keyOut_0_210;
  wire keyOut_1_211;
  wire keyOut_2_212;
  wire keyOut_3_213;
  wire reset_IBUF_214;
  wire PSCout_215;
  wire PSCClk;
  wire clk_BUFGP;
  wire counter_FSM_FFd3_219;
  wire counter_FSM_FFd5_220;
  wire counter_FSM_FFd7_221;
  wire \keyOut_mux0000<0>_SW0/O ;
  wire counter_FSM_FFd9_223;
  wire \keyOut_mux0000<1>_SW0/O ;
  wire N5;
  wire \dataout_mux0000<0>372_0 ;
  wire N11;
  wire \dataout_mux0000<0>34_0 ;
  wire counter_FSM_FFd4_229;
  wire counter_FSM_FFd2_230;
  wire counter_FSM_FFd8_231;
  wire counter_FSM_FFd6_232;
  wire N02_0;
  wire N21_0;
  wire N23_0;
  wire N19_0;
  wire \dataout<0>/O ;
  wire \dataout<1>/O ;
  wire \clk/INBUF ;
  wire \dataout<2>/O ;
  wire \keyIn<0>/INBUF ;
  wire \dataout<3>/O ;
  wire \keyIn<1>/INBUF ;
  wire \dataout<4>/O ;
  wire \keyIn<2>/INBUF ;
  wire \dataout<5>/O ;
  wire \keyIn<3>/INBUF ;
  wire \dataout<6>/O ;
  wire \dataout<7>/O ;
  wire \pulse/O ;
  wire \keyOut<0>/O ;
  wire \keyOut<1>/O ;
  wire \keyOut<2>/O ;
  wire \keyOut<3>/O ;
  wire \reset/INBUF ;
  wire \BUFG_inst/S_INVNOT ;
  wire \BUFG_inst/I0_INV ;
  wire \clk_BUFGP/BUFG/S_INVNOT ;
  wire \clk_BUFGP/BUFG/I0_INV ;
  wire \keyOut_3/DXMUX_415 ;
  wire \keyOut_mux0000<0>_SW0/O_pack_2 ;
  wire \keyOut_3/CLKINV_398 ;
  wire \keyOut_3/CEINV_397 ;
  wire \keyOut_2/DXMUX_448 ;
  wire \keyOut_mux0000<1>_SW0/O_pack_2 ;
  wire \keyOut_2/CLKINV_431 ;
  wire \keyOut_2/CEINV_430 ;
  wire \keyOut_1/DXMUX_481 ;
  wire N5_pack_2;
  wire \keyOut_1/CLKINV_464 ;
  wire \keyOut_1/CEINV_463 ;
  wire N02;
  wire N11_pack_1;
  wire \dataout_1/DXMUX_545 ;
  wire \dataout_1/DYMUX_531 ;
  wire \dataout_1/SRINVNOT ;
  wire \dataout_1/CLKINV_522 ;
  wire \dataout_2/DYMUX_568 ;
  wire \dataout_2/CLKINV_559 ;
  wire \counter_FSM_FFd8/DXMUX_610 ;
  wire \counter_FSM_FFd8/DYMUX_604 ;
  wire Mshreg_counter_FSM_FFd9_601;
  wire \counter_FSM_FFd8/DIG_MUX_593 ;
  wire \counter_FSM_FFd8/CLKINV_591 ;
  wire \counter_FSM_FFd8/CEINV_590 ;
  wire \counter_FSM_FFd8/WSG ;
  wire \dataout_mux0000<0>34_645 ;
  wire \keyOut_0/DYMUX_636 ;
  wire \keyOut_0/CLKINV_628 ;
  wire \keyOut_0/CEINV_627 ;
  wire N21;
  wire N23;
  wire \dataout_mux0000<0>372_693 ;
  wire N19;
  wire \counter_FSM_FFd3/DXMUX_711 ;
  wire \counter_FSM_FFd3/DYMUX_705 ;
  wire \counter_FSM_FFd3/CLKINV_703 ;
  wire \counter_FSM_FFd3/CEINV_702 ;
  wire \counter_FSM_FFd5/DXMUX_731 ;
  wire \counter_FSM_FFd5/DYMUX_725 ;
  wire \counter_FSM_FFd5/CLKINV_723 ;
  wire \counter_FSM_FFd5/CEINV_722 ;
  wire \counter_FSM_FFd7/DXMUX_751 ;
  wire \counter_FSM_FFd7/DYMUX_745 ;
  wire \counter_FSM_FFd7/CLKINV_743 ;
  wire \counter_FSM_FFd7/CEINV_742 ;
  wire \PSCout/DYMUX_761 ;
  wire \PSCout/CLKINV_759 ;
  wire \pulseSig/DYMUX_772 ;
  wire \pulseSig/CLKINV_770 ;
  wire \pulseSig/CEINV_769 ;
  wire \dataout_2/FFY/RSTAND_573 ;
  wire \dataout<3>/OUTPUT/OFF/O1INV_280 ;
  wire \dataout<4>/OUTPUT/OFF/O1INV_294 ;
  wire \dataout<5>/OUTPUT/OFF/O1INV_308 ;
  wire \dataout<6>/OUTPUT/OFF/O1INV_322 ;
  wire \dataout<7>/OUTPUT/OFF/O1INV_330 ;
  wire GND;
  wire VCC;
  wire NLW_Mshreg_counter_FSM_FFd9_Q15_UNCONNECTED;
  wire [3 : 0] keyOut_mux0000;
  wire [2 : 0] dataout_mux0000;
  initial $sdf_annotate("netgen/par/keypad_timesim.sdf");
  X_OPAD #(
    .LOC ( "PAD153" ))
  \dataout<0>/PAD  (
    .PAD(dataout[0])
  );
  X_OBUF #(
    .LOC ( "PAD153" ))
  dataout_0_OBUF (
    .I(\dataout<0>/O ),
    .O(dataout[0])
  );
  X_OPAD #(
    .LOC ( "PAD150" ))
  \dataout<1>/PAD  (
    .PAD(dataout[1])
  );
  X_OBUF #(
    .LOC ( "PAD150" ))
  dataout_1_OBUF (
    .I(\dataout<1>/O ),
    .O(dataout[1])
  );
  X_IPAD #(
    .LOC ( "IPAD21" ))
  \clk/PAD  (
    .PAD(clk)
  );
  X_BUF #(
    .LOC ( "IPAD21" ))
  \clk_BUFGP/IBUFG  (
    .I(clk),
    .O(\clk/INBUF )
  );
  X_OPAD #(
    .LOC ( "PAD149" ))
  \dataout<2>/PAD  (
    .PAD(dataout[2])
  );
  X_OBUF #(
    .LOC ( "PAD149" ))
  dataout_2_OBUF (
    .I(\dataout<2>/O ),
    .O(dataout[2])
  );
  X_IPAD #(
    .LOC ( "PAD171" ))
  \keyIn<0>/PAD  (
    .PAD(keyIn[0])
  );
  X_BUF #(
    .LOC ( "PAD171" ))
  keyIn_0_IBUF (
    .I(keyIn[0]),
    .O(\keyIn<0>/INBUF )
  );
  X_BUF #(
    .LOC ( "PAD171" ))
  \keyIn<0>/IFF/IMUX  (
    .I(\keyIn<0>/INBUF ),
    .O(keyIn_0_IBUF_204)
  );
  X_OPAD #(
    .LOC ( "PAD148" ))
  \dataout<3>/PAD  (
    .PAD(dataout[3])
  );
  X_OBUF #(
    .LOC ( "PAD148" ))
  dataout_3_OBUF (
    .I(\dataout<3>/O ),
    .O(dataout[3])
  );
  X_IPAD #(
    .LOC ( "PAD166" ))
  \keyIn<1>/PAD  (
    .PAD(keyIn[1])
  );
  X_BUF #(
    .LOC ( "PAD166" ))
  keyIn_1_IBUF (
    .I(keyIn[1]),
    .O(\keyIn<1>/INBUF )
  );
  X_BUF #(
    .LOC ( "PAD166" ))
  \keyIn<1>/IFF/IMUX  (
    .I(\keyIn<1>/INBUF ),
    .O(keyIn_1_IBUF_206)
  );
  X_OPAD #(
    .LOC ( "PAD140" ))
  \dataout<4>/PAD  (
    .PAD(dataout[4])
  );
  X_OBUF #(
    .LOC ( "PAD140" ))
  dataout_4_OBUF (
    .I(\dataout<4>/O ),
    .O(dataout[4])
  );
  X_IPAD #(
    .LOC ( "PAD165" ))
  \keyIn<2>/PAD  (
    .PAD(keyIn[2])
  );
  X_BUF #(
    .LOC ( "PAD165" ))
  keyIn_2_IBUF (
    .I(keyIn[2]),
    .O(\keyIn<2>/INBUF )
  );
  X_BUF #(
    .LOC ( "PAD165" ))
  \keyIn<2>/IFF/IMUX  (
    .I(\keyIn<2>/INBUF ),
    .O(keyIn_2_IBUF_207)
  );
  X_OPAD #(
    .LOC ( "PAD136" ))
  \dataout<5>/PAD  (
    .PAD(dataout[5])
  );
  X_OBUF #(
    .LOC ( "PAD136" ))
  dataout_5_OBUF (
    .I(\dataout<5>/O ),
    .O(dataout[5])
  );
  X_IPAD #(
    .LOC ( "PAD161" ))
  \keyIn<3>/PAD  (
    .PAD(keyIn[3])
  );
  X_BUF #(
    .LOC ( "PAD161" ))
  keyIn_3_IBUF (
    .I(keyIn[3]),
    .O(\keyIn<3>/INBUF )
  );
  X_BUF #(
    .LOC ( "PAD161" ))
  \keyIn<3>/IFF/IMUX  (
    .I(\keyIn<3>/INBUF ),
    .O(keyIn_3_IBUF_208)
  );
  X_OPAD #(
    .LOC ( "PAD135" ))
  \dataout<6>/PAD  (
    .PAD(dataout[6])
  );
  X_OBUF #(
    .LOC ( "PAD135" ))
  dataout_6_OBUF (
    .I(\dataout<6>/O ),
    .O(dataout[6])
  );
  X_OPAD #(
    .LOC ( "PAD134" ))
  \dataout<7>/PAD  (
    .PAD(dataout[7])
  );
  X_OBUF #(
    .LOC ( "PAD134" ))
  dataout_7_OBUF (
    .I(\dataout<7>/O ),
    .O(dataout[7])
  );
  X_OPAD #(
    .LOC ( "PAD172" ))
  \pulse/PAD  (
    .PAD(pulse)
  );
  X_OBUF #(
    .LOC ( "PAD172" ))
  pulse_OBUF (
    .I(\pulse/O ),
    .O(pulse)
  );
  X_OPAD #(
    .LOC ( "PAD156" ))
  \keyOut<0>/PAD  (
    .PAD(keyOut[0])
  );
  X_OBUF #(
    .LOC ( "PAD156" ))
  keyOut_0_OBUF (
    .I(\keyOut<0>/O ),
    .O(keyOut[0])
  );
  X_OPAD #(
    .LOC ( "PAD155" ))
  \keyOut<1>/PAD  (
    .PAD(keyOut[1])
  );
  X_OBUF #(
    .LOC ( "PAD155" ))
  keyOut_1_OBUF (
    .I(\keyOut<1>/O ),
    .O(keyOut[1])
  );
  X_OPAD #(
    .LOC ( "PAD11" ))
  \keyOut<2>/PAD  (
    .PAD(keyOut[2])
  );
  X_OBUF #(
    .LOC ( "PAD11" ))
  keyOut_2_OBUF (
    .I(\keyOut<2>/O ),
    .O(keyOut[2])
  );
  X_OPAD #(
    .LOC ( "PAD160" ))
  \keyOut<3>/PAD  (
    .PAD(keyOut[3])
  );
  X_OBUF #(
    .LOC ( "PAD160" ))
  keyOut_3_OBUF (
    .I(\keyOut<3>/O ),
    .O(keyOut[3])
  );
  X_IPAD #(
    .LOC ( "IPAD157" ))
  \reset/PAD  (
    .PAD(reset)
  );
  X_BUF #(
    .LOC ( "IPAD157" ))
  reset_IBUF (
    .I(reset),
    .O(\reset/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD157" ))
  \reset/IFF/IMUX  (
    .I(\reset/INBUF ),
    .O(reset_IBUF_214)
  );
  X_BUFGMUX #(
    .LOC ( "BUFGMUX_X1Y10" ))
  BUFG_inst (
    .I0(\BUFG_inst/I0_INV ),
    .I1(GND),
    .S(\BUFG_inst/S_INVNOT ),
    .O(PSCClk)
  );
  X_INV #(
    .LOC ( "BUFGMUX_X1Y10" ))
  \BUFG_inst/SINV  (
    .I(1'b1),
    .O(\BUFG_inst/S_INVNOT )
  );
  X_BUF #(
    .LOC ( "BUFGMUX_X1Y10" ))
  \BUFG_inst/I0_USED  (
    .I(PSCout_215),
    .O(\BUFG_inst/I0_INV )
  );
  X_BUFGMUX #(
    .LOC ( "BUFGMUX_X2Y10" ))
  \clk_BUFGP/BUFG  (
    .I0(\clk_BUFGP/BUFG/I0_INV ),
    .I1(GND),
    .S(\clk_BUFGP/BUFG/S_INVNOT ),
    .O(clk_BUFGP)
  );
  X_INV #(
    .LOC ( "BUFGMUX_X2Y10" ))
  \clk_BUFGP/BUFG/SINV  (
    .I(1'b1),
    .O(\clk_BUFGP/BUFG/S_INVNOT )
  );
  X_BUF #(
    .LOC ( "BUFGMUX_X2Y10" ))
  \clk_BUFGP/BUFG/I0_USED  (
    .I(\clk/INBUF ),
    .O(\clk_BUFGP/BUFG/I0_INV )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y47" ))
  \keyOut_3/DXMUX  (
    .I(keyOut_mux0000[0]),
    .O(\keyOut_3/DXMUX_415 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y47" ))
  \keyOut_3/YUSED  (
    .I(\keyOut_mux0000<0>_SW0/O_pack_2 ),
    .O(\keyOut_mux0000<0>_SW0/O )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y47" ))
  \keyOut_3/CLKINV  (
    .I(PSCClk),
    .O(\keyOut_3/CLKINV_398 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y47" ))
  \keyOut_3/CEINV  (
    .I(reset_IBUF_214),
    .O(\keyOut_3/CEINV_397 )
  );
  X_LUT4 #(
    .INIT ( 16'h4444 ),
    .LOC ( "SLICE_X12Y47" ))
  \keyOut_mux0000<0>_SW0  (
    .ADR0(counter_FSM_FFd9_223),
    .ADR1(keyOut_3_213),
    .ADR2(VCC),
    .ADR3(VCC),
    .O(\keyOut_mux0000<0>_SW0/O_pack_2 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y47" ))
  \keyOut_2/DXMUX  (
    .I(keyOut_mux0000[1]),
    .O(\keyOut_2/DXMUX_448 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y47" ))
  \keyOut_2/YUSED  (
    .I(\keyOut_mux0000<1>_SW0/O_pack_2 ),
    .O(\keyOut_mux0000<1>_SW0/O )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y47" ))
  \keyOut_2/CLKINV  (
    .I(PSCClk),
    .O(\keyOut_2/CLKINV_431 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y47" ))
  \keyOut_2/CEINV  (
    .I(reset_IBUF_214),
    .O(\keyOut_2/CEINV_430 )
  );
  X_LUT4 #(
    .INIT ( 16'h00F0 ),
    .LOC ( "SLICE_X13Y47" ))
  \keyOut_mux0000<1>_SW0  (
    .ADR0(VCC),
    .ADR1(VCC),
    .ADR2(keyOut_2_212),
    .ADR3(counter_FSM_FFd7_221),
    .O(\keyOut_mux0000<1>_SW0/O_pack_2 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y45" ))
  \keyOut_1/DXMUX  (
    .I(keyOut_mux0000[2]),
    .O(\keyOut_1/DXMUX_481 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y45" ))
  \keyOut_1/YUSED  (
    .I(N5_pack_2),
    .O(N5)
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y45" ))
  \keyOut_1/CLKINV  (
    .I(PSCClk),
    .O(\keyOut_1/CLKINV_464 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y45" ))
  \keyOut_1/CEINV  (
    .I(reset_IBUF_214),
    .O(\keyOut_1/CEINV_463 )
  );
  X_LUT4 #(
    .INIT ( 16'hFFCC ),
    .LOC ( "SLICE_X13Y45" ))
  \keyOut_mux0000<3>_SW0  (
    .ADR0(VCC),
    .ADR1(counter_FSM_FFd9_223),
    .ADR2(VCC),
    .ADR3(counter_FSM_FFd7_221),
    .O(N5_pack_2)
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y44" ))
  \N02/XUSED  (
    .I(N02),
    .O(N02_0)
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y44" ))
  \N02/YUSED  (
    .I(N11_pack_1),
    .O(N11)
  );
  X_LUT4 #(
    .INIT ( 16'hFFFE ),
    .LOC ( "SLICE_X13Y44" ))
  \dataout_mux0000<0>21  (
    .ADR0(counter_FSM_FFd6_232),
    .ADR1(counter_FSM_FFd4_229),
    .ADR2(counter_FSM_FFd8_231),
    .ADR3(counter_FSM_FFd2_230),
    .O(N11_pack_1)
  );
  X_BUF #(
    .LOC ( "SLICE_X2Y44" ))
  \dataout_1/DXMUX  (
    .I(dataout_mux0000[1]),
    .O(\dataout_1/DXMUX_545 )
  );
  X_BUF #(
    .LOC ( "SLICE_X2Y44" ))
  \dataout_1/DYMUX  (
    .I(dataout_mux0000[0]),
    .O(\dataout_1/DYMUX_531 )
  );
  X_INV #(
    .LOC ( "SLICE_X2Y44" ))
  \dataout_1/SRINV  (
    .I(reset_IBUF_214),
    .O(\dataout_1/SRINVNOT )
  );
  X_BUF #(
    .LOC ( "SLICE_X2Y44" ))
  \dataout_1/CLKINV  (
    .I(PSCClk),
    .O(\dataout_1/CLKINV_522 )
  );
  X_LUT4 #(
    .INIT ( 16'hB3A0 ),
    .LOC ( "SLICE_X2Y44" ))
  \dataout_mux0000<0>  (
    .ADR0(dataout_0_200),
    .ADR1(N23_0),
    .ADR2(N02_0),
    .ADR3(N11),
    .O(dataout_mux0000[0])
  );
  X_BUF #(
    .LOC ( "SLICE_X2Y45" ))
  \dataout_2/DYMUX  (
    .I(dataout_mux0000[2]),
    .O(\dataout_2/DYMUX_568 )
  );
  X_BUF #(
    .LOC ( "SLICE_X2Y45" ))
  \dataout_2/CLKINV  (
    .I(PSCClk),
    .O(\dataout_2/CLKINV_559 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y43" ))
  \counter_FSM_FFd8/DXMUX  (
    .I(counter_FSM_FFd9_223),
    .O(\counter_FSM_FFd8/DXMUX_610 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y43" ))
  \counter_FSM_FFd8/DYMUX  (
    .I(Mshreg_counter_FSM_FFd9_601),
    .O(\counter_FSM_FFd8/DYMUX_604 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y43" ))
  \counter_FSM_FFd8/DIG_MUX  (
    .I(counter_FSM_FFd2_230),
    .O(\counter_FSM_FFd8/DIG_MUX_593 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y43" ))
  \counter_FSM_FFd8/CLKINV  (
    .I(PSCClk),
    .O(\counter_FSM_FFd8/CLKINV_591 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y43" ))
  \counter_FSM_FFd8/CEINV  (
    .I(reset_IBUF_214),
    .O(\counter_FSM_FFd8/CEINV_590 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y44" ))
  \keyOut_0/XUSED  (
    .I(\dataout_mux0000<0>34_645 ),
    .O(\dataout_mux0000<0>34_0 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y44" ))
  \keyOut_0/DYMUX  (
    .I(keyOut_mux0000[3]),
    .O(\keyOut_0/DYMUX_636 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y44" ))
  \keyOut_0/CLKINV  (
    .I(PSCClk),
    .O(\keyOut_0/CLKINV_628 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y44" ))
  \keyOut_0/CEINV  (
    .I(reset_IBUF_214),
    .O(\keyOut_0/CEINV_627 )
  );
  X_LUT4 #(
    .INIT ( 16'hEEFE ),
    .LOC ( "SLICE_X12Y44" ))
  \keyOut_mux0000<3>  (
    .ADR0(N5),
    .ADR1(counter_FSM_FFd5_220),
    .ADR2(keyOut_0_210),
    .ADR3(counter_FSM_FFd3_219),
    .O(keyOut_mux0000[3])
  );
  X_BUF #(
    .LOC ( "SLICE_X0Y53" ))
  \N21/XUSED  (
    .I(N21),
    .O(N21_0)
  );
  X_BUF #(
    .LOC ( "SLICE_X0Y53" ))
  \N21/YUSED  (
    .I(N23),
    .O(N23_0)
  );
  X_LUT4 #(
    .INIT ( 16'hF77F ),
    .LOC ( "SLICE_X0Y53" ))
  \dataout_mux0000<0>_SW0_SW0  (
    .ADR0(keyIn_2_IBUF_207),
    .ADR1(keyIn_0_IBUF_204),
    .ADR2(keyIn_1_IBUF_206),
    .ADR3(keyIn_3_IBUF_208),
    .O(N23)
  );
  X_BUF #(
    .LOC ( "SLICE_X1Y53" ))
  \dataout_mux0000<0>372/XUSED  (
    .I(\dataout_mux0000<0>372_693 ),
    .O(\dataout_mux0000<0>372_0 )
  );
  X_BUF #(
    .LOC ( "SLICE_X1Y53" ))
  \dataout_mux0000<0>372/YUSED  (
    .I(N19),
    .O(N19_0)
  );
  X_LUT4 #(
    .INIT ( 16'hF7FF ),
    .LOC ( "SLICE_X1Y53" ))
  \dataout_mux0000<2>_SW0_SW0  (
    .ADR0(keyIn_3_IBUF_208),
    .ADR1(keyIn_1_IBUF_206),
    .ADR2(keyIn_0_IBUF_204),
    .ADR3(keyIn_2_IBUF_207),
    .O(N19)
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y45" ))
  \counter_FSM_FFd3/DXMUX  (
    .I(counter_FSM_FFd4_229),
    .O(\counter_FSM_FFd3/DXMUX_711 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y45" ))
  \counter_FSM_FFd3/DYMUX  (
    .I(counter_FSM_FFd3_219),
    .O(\counter_FSM_FFd3/DYMUX_705 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y45" ))
  \counter_FSM_FFd3/CLKINV  (
    .I(PSCClk),
    .O(\counter_FSM_FFd3/CLKINV_703 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y45" ))
  \counter_FSM_FFd3/CEINV  (
    .I(reset_IBUF_214),
    .O(\counter_FSM_FFd3/CEINV_702 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y46" ))
  \counter_FSM_FFd5/DXMUX  (
    .I(counter_FSM_FFd6_232),
    .O(\counter_FSM_FFd5/DXMUX_731 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y46" ))
  \counter_FSM_FFd5/DYMUX  (
    .I(counter_FSM_FFd5_220),
    .O(\counter_FSM_FFd5/DYMUX_725 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y46" ))
  \counter_FSM_FFd5/CLKINV  (
    .I(PSCClk),
    .O(\counter_FSM_FFd5/CLKINV_723 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y46" ))
  \counter_FSM_FFd5/CEINV  (
    .I(reset_IBUF_214),
    .O(\counter_FSM_FFd5/CEINV_722 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y46" ))
  \counter_FSM_FFd7/DXMUX  (
    .I(counter_FSM_FFd8_231),
    .O(\counter_FSM_FFd7/DXMUX_751 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y46" ))
  \counter_FSM_FFd7/DYMUX  (
    .I(counter_FSM_FFd7_221),
    .O(\counter_FSM_FFd7/DYMUX_745 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y46" ))
  \counter_FSM_FFd7/CLKINV  (
    .I(PSCClk),
    .O(\counter_FSM_FFd7/CLKINV_743 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y46" ))
  \counter_FSM_FFd7/CEINV  (
    .I(reset_IBUF_214),
    .O(\counter_FSM_FFd7/CEINV_742 )
  );
  X_INV #(
    .LOC ( "SLICE_X42Y67" ))
  \PSCout/DYMUX  (
    .I(PSCout_215),
    .O(\PSCout/DYMUX_761 )
  );
  X_BUF #(
    .LOC ( "SLICE_X42Y67" ))
  \PSCout/CLKINV  (
    .I(clk_BUFGP),
    .O(\PSCout/CLKINV_759 )
  );
  X_INV #(
    .LOC ( "SLICE_X3Y66" ))
  \pulseSig/DYMUX  (
    .I(pulseSig_209),
    .O(\pulseSig/DYMUX_772 )
  );
  X_BUF #(
    .LOC ( "SLICE_X3Y66" ))
  \pulseSig/CLKINV  (
    .I(PSCClk),
    .O(\pulseSig/CLKINV_770 )
  );
  X_BUF #(
    .LOC ( "SLICE_X3Y66" ))
  \pulseSig/CEINV  (
    .I(reset_IBUF_214),
    .O(\pulseSig/CEINV_769 )
  );
  X_LUT4 #(
    .INIT ( 16'hFFFE ),
    .LOC ( "SLICE_X12Y47" ))
  \keyOut_mux0000<0>  (
    .ADR0(counter_FSM_FFd7_221),
    .ADR1(counter_FSM_FFd3_219),
    .ADR2(\keyOut_mux0000<0>_SW0/O ),
    .ADR3(counter_FSM_FFd5_220),
    .O(keyOut_mux0000[0])
  );
  X_FF #(
    .LOC ( "SLICE_X12Y47" ),
    .INIT ( 1'b0 ))
  keyOut_3 (
    .I(\keyOut_3/DXMUX_415 ),
    .CE(\keyOut_3/CEINV_397 ),
    .CLK(\keyOut_3/CLKINV_398 ),
    .SET(GND),
    .RST(GND),
    .O(keyOut_3_213)
  );
  X_LUT4 #(
    .INIT ( 16'hFFFE ),
    .LOC ( "SLICE_X13Y47" ))
  \keyOut_mux0000<1>  (
    .ADR0(counter_FSM_FFd5_220),
    .ADR1(counter_FSM_FFd3_219),
    .ADR2(counter_FSM_FFd9_223),
    .ADR3(\keyOut_mux0000<1>_SW0/O ),
    .O(keyOut_mux0000[1])
  );
  X_FF #(
    .LOC ( "SLICE_X13Y47" ),
    .INIT ( 1'b0 ))
  keyOut_2 (
    .I(\keyOut_2/DXMUX_448 ),
    .CE(\keyOut_2/CEINV_430 ),
    .CLK(\keyOut_2/CLKINV_431 ),
    .SET(GND),
    .RST(GND),
    .O(keyOut_2_212)
  );
  X_LUT4 #(
    .INIT ( 16'hFFAE ),
    .LOC ( "SLICE_X13Y45" ))
  \keyOut_mux0000<2>  (
    .ADR0(counter_FSM_FFd3_219),
    .ADR1(keyOut_1_211),
    .ADR2(counter_FSM_FFd5_220),
    .ADR3(N5),
    .O(keyOut_mux0000[2])
  );
  X_FF #(
    .LOC ( "SLICE_X13Y45" ),
    .INIT ( 1'b0 ))
  keyOut_1 (
    .I(\keyOut_1/DXMUX_481 ),
    .CE(\keyOut_1/CEINV_463 ),
    .CLK(\keyOut_1/CLKINV_464 ),
    .SET(GND),
    .RST(GND),
    .O(keyOut_1_211)
  );
  X_LUT4 #(
    .INIT ( 16'hFFA0 ),
    .LOC ( "SLICE_X13Y44" ))
  \dataout_mux0000<0>389  (
    .ADR0(\dataout_mux0000<0>372_0 ),
    .ADR1(VCC),
    .ADR2(N11),
    .ADR3(\dataout_mux0000<0>34_0 ),
    .O(N02)
  );
  X_FF #(
    .LOC ( "SLICE_X2Y44" ),
    .INIT ( 1'b0 ))
  dataout_0 (
    .I(\dataout_1/DYMUX_531 ),
    .CE(VCC),
    .CLK(\dataout_1/CLKINV_522 ),
    .SET(GND),
    .RST(\dataout_1/SRINVNOT ),
    .O(dataout_0_200)
  );
  X_LUT4 #(
    .INIT ( 16'hB3A0 ),
    .LOC ( "SLICE_X2Y44" ))
  \dataout_mux0000<1>  (
    .ADR0(dataout_1_201),
    .ADR1(N21_0),
    .ADR2(N02_0),
    .ADR3(N11),
    .O(dataout_mux0000[1])
  );
  X_FF #(
    .LOC ( "SLICE_X2Y44" ),
    .INIT ( 1'b0 ))
  dataout_1 (
    .I(\dataout_1/DXMUX_545 ),
    .CE(VCC),
    .CLK(\dataout_1/CLKINV_522 ),
    .SET(GND),
    .RST(\dataout_1/SRINVNOT ),
    .O(dataout_1_201)
  );
  X_LUT4 #(
    .INIT ( 16'hD5C0 ),
    .LOC ( "SLICE_X2Y45" ))
  \dataout_mux0000<2>  (
    .ADR0(N19_0),
    .ADR1(dataout_2_203),
    .ADR2(N02_0),
    .ADR3(N11),
    .O(dataout_mux0000[2])
  );
  X_FF #(
    .LOC ( "SLICE_X2Y45" ),
    .INIT ( 1'b0 ))
  dataout_2 (
    .I(\dataout_2/DYMUX_568 ),
    .CE(VCC),
    .CLK(\dataout_2/CLKINV_559 ),
    .SET(GND),
    .RST(\dataout_2/FFY/RSTAND_573 ),
    .O(dataout_2_203)
  );
  X_INV #(
    .LOC ( "SLICE_X2Y45" ))
  \dataout_2/FFY/RSTAND  (
    .I(reset_IBUF_214),
    .O(\dataout_2/FFY/RSTAND_573 )
  );
  X_SRLC16E #(
    .INIT ( 16'h0000 ),
    .LOC ( "SLICE_X12Y43" ))
  Mshreg_counter_FSM_FFd9 (
    .A0(GND),
    .A1(GND),
    .A2(GND),
    .A3(GND),
    .D(\counter_FSM_FFd8/DIG_MUX_593 ),
    .CE(\counter_FSM_FFd8/WSG ),
    .CLK(\counter_FSM_FFd8/CLKINV_591 ),
    .Q(Mshreg_counter_FSM_FFd9_601),
    .Q15(NLW_Mshreg_counter_FSM_FFd9_Q15_UNCONNECTED)
  );
  X_FF #(
    .LOC ( "SLICE_X12Y43" ),
    .INIT ( 1'b1 ))
  counter_FSM_FFd9 (
    .I(\counter_FSM_FFd8/DYMUX_604 ),
    .CE(\counter_FSM_FFd8/CEINV_590 ),
    .CLK(\counter_FSM_FFd8/CLKINV_591 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd9_223)
  );
  X_FF #(
    .LOC ( "SLICE_X12Y43" ),
    .INIT ( 1'b0 ))
  counter_FSM_FFd8 (
    .I(\counter_FSM_FFd8/DXMUX_610 ),
    .CE(\counter_FSM_FFd8/CEINV_590 ),
    .CLK(\counter_FSM_FFd8/CLKINV_591 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd8_231)
  );
  X_FF #(
    .LOC ( "SLICE_X12Y44" ),
    .INIT ( 1'b0 ))
  keyOut_0 (
    .I(\keyOut_0/DYMUX_636 ),
    .CE(\keyOut_0/CEINV_627 ),
    .CLK(\keyOut_0/CLKINV_628 ),
    .SET(GND),
    .RST(GND),
    .O(keyOut_0_210)
  );
  X_LUT4 #(
    .INIT ( 16'hFFFE ),
    .LOC ( "SLICE_X12Y44" ))
  \dataout_mux0000<0>34  (
    .ADR0(counter_FSM_FFd7_221),
    .ADR1(counter_FSM_FFd5_220),
    .ADR2(counter_FSM_FFd9_223),
    .ADR3(counter_FSM_FFd3_219),
    .O(\dataout_mux0000<0>34_645 )
  );
  X_LUT4 #(
    .INIT ( 16'hB7FF ),
    .LOC ( "SLICE_X0Y53" ))
  \dataout_mux0000<1>_SW0_SW0  (
    .ADR0(keyIn_2_IBUF_207),
    .ADR1(keyIn_0_IBUF_204),
    .ADR2(keyIn_1_IBUF_206),
    .ADR3(keyIn_3_IBUF_208),
    .O(N21)
  );
  X_LUT4 #(
    .INIT ( 16'h977F ),
    .LOC ( "SLICE_X1Y53" ))
  \dataout_mux0000<0>372  (
    .ADR0(keyIn_3_IBUF_208),
    .ADR1(keyIn_1_IBUF_206),
    .ADR2(keyIn_0_IBUF_204),
    .ADR3(keyIn_2_IBUF_207),
    .O(\dataout_mux0000<0>372_693 )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y45" ),
    .INIT ( 1'b0 ))
  counter_FSM_FFd2 (
    .I(\counter_FSM_FFd3/DYMUX_705 ),
    .CE(\counter_FSM_FFd3/CEINV_702 ),
    .CLK(\counter_FSM_FFd3/CLKINV_703 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd2_230)
  );
  X_FF #(
    .LOC ( "SLICE_X12Y45" ),
    .INIT ( 1'b0 ))
  counter_FSM_FFd3 (
    .I(\counter_FSM_FFd3/DXMUX_711 ),
    .CE(\counter_FSM_FFd3/CEINV_702 ),
    .CLK(\counter_FSM_FFd3/CLKINV_703 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd3_219)
  );
  X_FF #(
    .LOC ( "SLICE_X13Y46" ),
    .INIT ( 1'b0 ))
  counter_FSM_FFd4 (
    .I(\counter_FSM_FFd5/DYMUX_725 ),
    .CE(\counter_FSM_FFd5/CEINV_722 ),
    .CLK(\counter_FSM_FFd5/CLKINV_723 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd4_229)
  );
  X_FF #(
    .LOC ( "SLICE_X13Y46" ),
    .INIT ( 1'b0 ))
  counter_FSM_FFd5 (
    .I(\counter_FSM_FFd5/DXMUX_731 ),
    .CE(\counter_FSM_FFd5/CEINV_722 ),
    .CLK(\counter_FSM_FFd5/CLKINV_723 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd5_220)
  );
  X_FF #(
    .LOC ( "SLICE_X12Y46" ),
    .INIT ( 1'b0 ))
  counter_FSM_FFd6 (
    .I(\counter_FSM_FFd7/DYMUX_745 ),
    .CE(\counter_FSM_FFd7/CEINV_742 ),
    .CLK(\counter_FSM_FFd7/CLKINV_743 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd6_232)
  );
  X_FF #(
    .LOC ( "SLICE_X12Y46" ),
    .INIT ( 1'b0 ))
  counter_FSM_FFd7 (
    .I(\counter_FSM_FFd7/DXMUX_751 ),
    .CE(\counter_FSM_FFd7/CEINV_742 ),
    .CLK(\counter_FSM_FFd7/CLKINV_743 ),
    .SET(GND),
    .RST(GND),
    .O(counter_FSM_FFd7_221)
  );
  X_FF #(
    .LOC ( "SLICE_X42Y67" ),
    .INIT ( 1'b0 ))
  PSCout (
    .I(\PSCout/DYMUX_761 ),
    .CE(VCC),
    .CLK(\PSCout/CLKINV_759 ),
    .SET(GND),
    .RST(GND),
    .O(PSCout_215)
  );
  X_FF #(
    .LOC ( "SLICE_X3Y66" ),
    .INIT ( 1'b0 ))
  pulseSig (
    .I(\pulseSig/DYMUX_772 ),
    .CE(\pulseSig/CEINV_769 ),
    .CLK(\pulseSig/CLKINV_770 ),
    .SET(GND),
    .RST(GND),
    .O(pulseSig_209)
  );
  X_BUF #(
    .LOC ( "PAD153" ))
  \dataout<0>/OUTPUT/OFF/OMUX  (
    .I(dataout_0_200),
    .O(\dataout<0>/O )
  );
  X_BUF #(
    .LOC ( "PAD150" ))
  \dataout<1>/OUTPUT/OFF/OMUX  (
    .I(dataout_1_201),
    .O(\dataout<1>/O )
  );
  X_BUF #(
    .LOC ( "PAD149" ))
  \dataout<2>/OUTPUT/OFF/OMUX  (
    .I(dataout_2_203),
    .O(\dataout<2>/O )
  );
  X_BUF #(
    .LOC ( "PAD148" ))
  \dataout<3>/OUTPUT/OFF/OMUX  (
    .I(\dataout<3>/OUTPUT/OFF/O1INV_280 ),
    .O(\dataout<3>/O )
  );
  X_BUF #(
    .LOC ( "PAD148" ))
  \dataout<3>/OUTPUT/OFF/O1INV  (
    .I(1'b0),
    .O(\dataout<3>/OUTPUT/OFF/O1INV_280 )
  );
  X_BUF #(
    .LOC ( "PAD140" ))
  \dataout<4>/OUTPUT/OFF/OMUX  (
    .I(\dataout<4>/OUTPUT/OFF/O1INV_294 ),
    .O(\dataout<4>/O )
  );
  X_BUF #(
    .LOC ( "PAD140" ))
  \dataout<4>/OUTPUT/OFF/O1INV  (
    .I(1'b0),
    .O(\dataout<4>/OUTPUT/OFF/O1INV_294 )
  );
  X_BUF #(
    .LOC ( "PAD136" ))
  \dataout<5>/OUTPUT/OFF/OMUX  (
    .I(\dataout<5>/OUTPUT/OFF/O1INV_308 ),
    .O(\dataout<5>/O )
  );
  X_BUF #(
    .LOC ( "PAD136" ))
  \dataout<5>/OUTPUT/OFF/O1INV  (
    .I(1'b0),
    .O(\dataout<5>/OUTPUT/OFF/O1INV_308 )
  );
  X_BUF #(
    .LOC ( "PAD135" ))
  \dataout<6>/OUTPUT/OFF/OMUX  (
    .I(\dataout<6>/OUTPUT/OFF/O1INV_322 ),
    .O(\dataout<6>/O )
  );
  X_BUF #(
    .LOC ( "PAD135" ))
  \dataout<6>/OUTPUT/OFF/O1INV  (
    .I(1'b0),
    .O(\dataout<6>/OUTPUT/OFF/O1INV_322 )
  );
  X_BUF #(
    .LOC ( "PAD134" ))
  \dataout<7>/OUTPUT/OFF/OMUX  (
    .I(\dataout<7>/OUTPUT/OFF/O1INV_330 ),
    .O(\dataout<7>/O )
  );
  X_BUF #(
    .LOC ( "PAD134" ))
  \dataout<7>/OUTPUT/OFF/O1INV  (
    .I(1'b0),
    .O(\dataout<7>/OUTPUT/OFF/O1INV_330 )
  );
  X_BUF #(
    .LOC ( "PAD172" ))
  \pulse/OUTPUT/OFF/OMUX  (
    .I(pulseSig_209),
    .O(\pulse/O )
  );
  X_BUF #(
    .LOC ( "PAD156" ))
  \keyOut<0>/OUTPUT/OFF/OMUX  (
    .I(keyOut_0_210),
    .O(\keyOut<0>/O )
  );
  X_BUF #(
    .LOC ( "PAD155" ))
  \keyOut<1>/OUTPUT/OFF/OMUX  (
    .I(keyOut_1_211),
    .O(\keyOut<1>/O )
  );
  X_BUF #(
    .LOC ( "PAD11" ))
  \keyOut<2>/OUTPUT/OFF/OMUX  (
    .I(keyOut_2_212),
    .O(\keyOut<2>/O )
  );
  X_BUF #(
    .LOC ( "PAD160" ))
  \keyOut<3>/OUTPUT/OFF/OMUX  (
    .I(keyOut_3_213),
    .O(\keyOut<3>/O )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y43" ))
  \Mshreg_counter_FSM_FFd9.CE/WSGAND  (
    .I(reset_IBUF_214),
    .O(\counter_FSM_FFd8/WSG )
  );
  X_ZERO   NlwBlock_keypad_GND (
    .O(GND)
  );
  X_ONE   NlwBlock_keypad_VCC (
    .O(VCC)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

