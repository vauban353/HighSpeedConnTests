//-------------------------------------------------------------------
//                                                                 
//-------------------------------------------------------------------------
//© 2022 Microchip Technology Inc. and its subsidiaries
//All rights reserved.
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//-------------------------------------------------------------------------
//
//-------------------------------------------------------------------
// Title        : test_pcs
// Created      : June-2017
// Description  : This is the stimulus file for the top level module 
//                
// Revision     : Revision 1.0
// Hierarchy    :
//                test_pcs.v
//                 DUT -- Top_SD.v              <-- This module
//
// Target device: <Family:PolarFire> <Die:MPF300TS_ES> <Pkg:FCG1152>
//------------------------------------------------------------------- 

`timescale 1ns/100ps

module test_pcs;

parameter SYSCLK_PERIOD = 6.4;// 156.25 MHZ

reg SYSCLK;
reg NSYSRESET;
wire start;

wire Loop_P;
wire Loop_N;

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
    //Forcing pattern generator and checker to come out of reset 
    //after transceiver is ready and comman is aligned
    #43000 force top_0.UART_INTERFACE_0.start = 1'b1; 
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 10 )
        NSYSRESET = 1'b1;
end


//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  Top_SD
//////////////////////////////////////////////////////////////////////
top top_0 (
    // Inputs
    .REF_CLK_PAD_P(SYSCLK),
    .REF_CLK_PAD_N(!SYSCLK),
    .LANE0_RXD_P(Loop_P),
    .LANE0_RXD_N(Loop_N),

    // Outputs
    .LANE0_TXD_P(Loop_P),
    .LANE0_TXD_N(Loop_N),
    .RX(1'b1),
    .TX()
    // Inouts

);

endmodule

