`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2020 05:02:38 PM
// Design Name: 
// Module Name: bricktest
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bricktest(  clk,
                   reset,
                   h_video,
                   v_video,
                   tick60hz,
                   pix_x,
                   pix_y,
                   ball_y_t,
                   brick_on,
                   brick_rgb,
                   direction,
                   BRICK_Y_T,
                   brick_rgbin,
                   brick_p);
                   
input  clk, reset, tick60hz, h_video, v_video;
input [2:0] brick_rgbin;
input [9:0] pix_x, pix_y, ball_y_t;
output brick_on;
output [2:0] brick_rgb;
output reg brick_p;
output reg [2:0] direction; 
input [9:0] BRICK_Y_T;
wire [9:0] BRICK_Y_B;


   
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            brick_p <= 1'b1;
            direction <= 3'b000; 
         end
      else
         begin
            if ((ball_y_t  < BRICK_Y_B+6) && (brick_p > 1'b0)) begin 
               brick_p <= 1'b0;
               direction <= 3'b100;
            end
          else 
          direction <= 3'b000;
         end    
         
   assign brick_on = (brick_p)? (BRICK_Y_T<=pix_y) && (pix_y<=BRICK_Y_B): 1'b0;
   // brick rgb output
    assign brick_rgb = brick_rgbin;
    assign BRICK_Y_B =  BRICK_Y_T +20;

endmodule
