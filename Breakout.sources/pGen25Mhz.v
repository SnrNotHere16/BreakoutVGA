`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// By Omar Aquino Pineda
// File Name: pGen25Mhz.v
// The following module sends a postivie signal (tick25Mhz) every 25Mhz assuming 
// that the clock's (clk) frequency runs at 100Mhz. The desired count value is 
// gathered by dividing 100Mhz/25Mhz = 4. When the q equals 3, a postive signal
// is sent. During every clock tick, q increments by one. 
//////////////////////////////////////////////////////////////////////////////////


module pGen25Mhz(   clk,
                    reset,
                    tick25Mhz
                    );
 input clk, reset; //clk has a 100Mhz frequency
 output tick25Mhz;
 reg tick25Mhz; //A postive signal sent every 40 nanoseconds
 reg [1:0] q;  // The value to be compared to 3.
 
////////////////////////////////////////
//  combonational logic block         //
////////////////////////////////////////
 always @(*) 
 tick25Mhz = (q == 2'b11);
 
////////////////////////////////////////
//  sequential logic block            //
////////////////////////////////////////
 always @(posedge clk, posedge reset) begin 
    if (reset) q <= 2'b0;
    else q <= q+1;

 end 
endmodule
