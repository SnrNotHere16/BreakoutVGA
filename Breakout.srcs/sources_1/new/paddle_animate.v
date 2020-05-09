`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2020 03:29:52 PM
// Design Name: 
// Module Name: ball_animate
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


module bar_animate(clk,
                   reset,
                   btn,
                   h_video,
                   v_video,
                   tick60hz,
                   pix_x,
                   pix_y,
                   bar_x_l,
                   bar_x_r,
                   bar_rgb,
                   bar_on);

input  clk, reset, tick60hz, h_video, v_video;
input  [1:0] btn;
input [9:0] pix_x, pix_y;
output wire bar_on;
output wire [2:0] bar_rgb; 
output wire [9:0] bar_x_l, bar_x_r;

// constant and signal declaration
// x, y coordinates (0,0) to (639,479)
   localparam MIN_X = 0;
   localparam MAX_X = 640;
   localparam MAX_Y = 480;
//--------------------------------------------
// right vertical bar
//--------------------------------------------
// bar top, bottom boundary. 
   localparam BAR_Y_T = 429;
   localparam BAR_Y_B = 449;
// bar top length
   localparam BAR_X_SIZE = 72;
// register to track left boundary  (y position is fixed)
   reg [9:0] bar_x_reg, bar_x_next;
   
 // bar moving velocity when a button is pressed
   localparam BAR_V = 15;
   
   // boundary
   assign bar_x_l = bar_x_reg;
   assign bar_x_r = bar_x_l + BAR_X_SIZE - 1;
   // pixel within bar
   assign bar_on = (bar_x_l<=pix_x) && (pix_x<=bar_x_r) &&
                   (BAR_Y_T<=pix_y) && (pix_y<=BAR_Y_B);
   // bar rgb output
   assign bar_rgb = 3'b011; 
   // new bar x-position
   always @(posedge clk, posedge reset) begin 
        if (reset) begin  
            bar_x_next <= 240;
        end 
       else begin 
        bar_x_reg <= bar_x_next; // no move
         if (tick60hz) begin 
            if (btn[1] & (bar_x_r <= MAX_X))
                bar_x_next = bar_x_reg + BAR_V; // move right
            else if (btn[0] & (bar_x_l > MIN_X))
                bar_x_next = bar_x_reg - BAR_V; // move left
        end 
      end 
    end  
endmodule
