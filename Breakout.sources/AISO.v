`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// By Omar Aquino Pineda
// File Name: AISO.v
// The following moduel stands for Asynchronous In Synchronous Out.
// It provides the reset for the rest of the modules in the top module. 
// rst_s is the reset input for the rest of the modules. 
//////////////////////////////////////////////////////////////////////////////////

module AISO(clk, rst, rst_s);

input rst, clk;
output rst_s;
reg  Q1, Q2;        //flop outputs 
reg rst_s, qmeta;
////////////////////////////////////////
//  continous assignement for ped     //
////////////////////////////////////////
always @(*) begin 
 rst_s = ~Q2;    
 qmeta = Q1;
 end


    always@ (posedge clk, posedge rst)
    if (rst) {Q1,Q2} <= 2'b0;
    else     {Q1,Q2} <=  {1'b1, qmeta}; 
endmodule
