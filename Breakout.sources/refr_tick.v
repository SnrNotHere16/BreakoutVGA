`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// CECS 361 - Fall 2019
// Professor John Tramel
// Lab5
// By Omar Aquino Pineda
// File Name: refr_tick.v
// The following module sends a postivie signal (refr_tick.v) every 60Hz assuming 
// that the clock's (clk) frequency runs at 100Mhz. The desired count value is 
// gathered by dividing 100Mhz/60hz = 1666666. When the q equals 3, a postive signal
// is sent. During every clock tick, q increments by one. 
//////////////////////////////////////////////////////////////////////////////////


module refr_tick(   clk,
                    reset,
                    tick60hz
                    );
 input clk, reset; //clk has a 100Mhz frequency
 output tick60hz;
 reg tick60hz; //A postive signal sent every 40 nanoseconds
 reg [20:0] q;  // The value to be compared to 1666666.
 
////////////////////////////////////////
//  combonational logic block         //
////////////////////////////////////////
 always @(*) 
 tick60hz = (q == 1666666);
 
////////////////////////////////////////
//  sequential logic block            //
////////////////////////////////////////
 always @(posedge clk, posedge reset) begin 
    if (reset) q <= 21'b0;
    else q <= q+1;

 end 
endmodule
