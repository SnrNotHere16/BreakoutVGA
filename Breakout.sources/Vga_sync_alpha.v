`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// By Omar Aquino Pineda
// File Name: Vga_sync_alpha.v
// The following module is the vga synchronization which consists of an
// AISO, Pulse generator and Horizontal Sync, vertical sync, and an rgb output.
//////////////////////////////////////////////////////////////////////////////////
module Vga_sync_alpha(clk, reset, LR, h_tick, h_sync, v_sync, v_tick, red, green, blue, gameover, brickstaken, status, brickstakenled);
input clk, reset;
input wire [1:0] LR;  //direction
output wire [3:0] red, green, blue;
output h_sync, v_sync, v_tick, h_tick, gameover, status;
output wire [2:0] brickstaken, brickstakenled;
wire h_tick,  tick, tick_sixty, gameover;
wire h_video, v_video, rst_s;
wire [1:0] btn;
wire [9:0] pixel_x, pixel_y;
reg [2:0] rgb_reg;
wire [2:0] rgb_next;


AISO zero(.clk(clk), .rst(reset), .rst_s(rst_s));
pGen25Mhz one (.clk(clk), .reset(rst_s),.tick25Mhz(tick));
refr_tick two (.clk(clk), .reset(rst_s), .tick60hz(tick_sixty));
H_Sync three (.clk(clk), .reset(rst_s), .tick(tick), 
            .h_tick(h_tick), .h_sync(h_sync), 
            .h_video(h_video), .q(pixel_x));
            
V_Sync four (.clk(clk), .reset(rst_s), .twf_tick(tick), .h_tick(h_tick),
               .v_tick(v_tick), .v_sync(v_sync), 
               .v_video(v_video),.q(pixel_y));
breakout_animate five (.clk(clk), .reset(rst_s),.btn(LR), .tick60hz(tick_sixty),
                          .h_video(h_video), .v_video(v_video),.pix_x(pixel_x),.pix_y(pixel_y),
                           .graph_rgb(rgb_next), .gameover(gameover), .brickstaken(brickstaken), .status(status),
                           .brickstakenled(brickstakenled));

  // rgb buffer
   always @(posedge clk)
      if (tick)
         rgb_reg <= rgb_next;
   // output
   assign red = ((h_video&&v_video) && rgb_reg[0] == 1'b1) ? 4'b1111 : 4'b0000;
   assign green = ((h_video&&v_video)  && rgb_reg[1] == 1'b1) ? 4'b1111 : 4'b0000;
   assign blue = ((h_video&&v_video) && rgb_reg[2] == 1'b1) ? 4'b1111 : 4'b0000;
endmodule