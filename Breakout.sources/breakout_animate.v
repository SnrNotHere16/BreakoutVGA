`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// By Omar Aquino Pineda
// File Name: breakout_animate.v
// The following module animates the breakout game. 
//////////////////////////////////////////////////////////////////////////////////


module breakout_animate(  clk,
                          reset,
                          btn,
                          h_video,
                          v_video,
                          tick60hz,
                          pix_x,
                          pix_y,
                          graph_rgb,
                          gameover,
                          brickstaken,
                          status,
                          brickstakenled
                          );
input wire clk, reset, tick60hz, h_video, v_video;
input wire [1:0] btn;
input wire [9:0] pix_x, pix_y;
output wire gameover, status;
output reg [2:0] graph_rgb;
wire [9:0] bar_x_l, bar_x_r, ball_y_t;
wire bar_on, rd_ball_on, brick_on, brick_on1, brick_on2, brick_on3, brick_on4, brick_on5, brick_on6;
wire [2:0] bar_rgb, ball_rgb, brick_rgb, brick_rgb1, brick_rgb2, brick_rgb3, brick_rgb4, brick_rgb5, brick_rgb6;
wire [2:0] direction, direction1,  direction2, direction3, direction4, direction5, direction6;
output wire [3:0] brickstaken, brickstakenled;
wire letter_on, l_rgb;
wire brick_p, brick_p1,brick_p2, brick_p3, brick_p4, brick_p5, brick_p6;


bar_animate zero(.clk(clk), .reset(reset),.h_video(h_video), .v_video(v_video),
                    .btn (btn), .pix_x(pix_x), .tick60hz(tick60hz),.pix_y(pix_y), 
                    .bar_x_l(bar_x_l), .bar_x_r(bar_x_r), .bar_rgb(bar_rgb), .bar_on(bar_on));

 ball_animate one ( .clk(clk), .reset(reset),.h_video(h_video), .direction({direction,direction1,direction2, direction3, direction4, direction5}),
                     .v_video(v_video),.tick60hz(tick60hz),
                     .pix_x(pix_x),.pix_y(pix_y), .bar_x_l(bar_x_l),
                     .bar_x_r(bar_x_r),.ball_rgb(ball_rgb),.rd_ball_on(rd_ball_on),
                     .ball_y_t(ball_y_t), .gameover(gameover) );

  bricktest two(  .clk(clk),
                   .reset(reset),
                   .h_video(h_video),
                   .v_video(v_video),
                   .tick60hz(tick60hz),
                   .pix_x(pix_x),
                   .pix_y(pix_y),
                   .ball_y_t(ball_y_t),
                   .brick_on(brick_on),
                   .brick_rgb(brick_rgb),
                   .brick_rgbin(3'b101),
                   .direction(direction),
                   .BRICK_Y_T(0),
                   .brick_p(brick_p));
  bricktest three(  .clk(clk),
                   .reset(reset),
                   .h_video(h_video),
                   .v_video(v_video),
                   .tick60hz(tick60hz),
                   .pix_x(pix_x),
                   .pix_y(pix_y),
                   .ball_y_t(ball_y_t),
                   .brick_on(brick_on1),
                   .brick_rgb(brick_rgb1),
                   .brick_rgbin(3'b111),
                   .direction(direction1),
                   .BRICK_Y_T(21),
                   .brick_p(brick_p1));
    bricktest four (  .clk(clk),
                   .reset(reset),
                   .h_video(h_video),
                   .v_video(v_video),
                   .tick60hz(tick60hz),
                   .pix_x(pix_x),
                   .pix_y(pix_y),
                   .ball_y_t(ball_y_t),
                   .brick_on(brick_on2),
                   .brick_rgb(brick_rgb2),
                   .brick_rgbin(3'b010),
                   .direction(direction2),
                   .BRICK_Y_T(42),
                   .brick_p(brick_p2));
    bricktest five (  .clk(clk),
                   .reset(reset),
                   .h_video(h_video),
                   .v_video(v_video),
                   .tick60hz(tick60hz),
                   .pix_x(pix_x),
                   .pix_y(pix_y),
                   .ball_y_t(ball_y_t),
                   .brick_on(brick_on3),
                   .brick_rgb(brick_rgb3),
                   .brick_rgbin(3'b001),
                   .direction(direction3),
                   .BRICK_Y_T(63),
                    .brick_p(brick_p3));
      bricktest six (  .clk(clk),
                   .reset(reset),
                   .h_video(h_video),
                   .v_video(v_video),
                   .tick60hz(tick60hz),
                   .pix_x(pix_x),
                   .pix_y(pix_y),
                   .ball_y_t(ball_y_t),
                   .brick_on(brick_on4),
                   .brick_rgb(brick_rgb4),
                   .brick_rgbin(3'b011),
                   .direction(direction4),
                   .BRICK_Y_T(84),
                   .brick_p(brick_p4));
           bricktest seven (  .clk(clk),
                   .reset(reset),
                   .h_video(h_video),
                   .v_video(v_video),
                   .tick60hz(tick60hz),
                   .pix_x(pix_x),
                   .pix_y(pix_y),
                   .ball_y_t(ball_y_t),
                   .brick_on(brick_on5),
                   .brick_rgb(brick_rgb5),
                   .brick_rgbin(3'b100),
                   .direction(direction5),
                   .BRICK_Y_T(84),
                   .brick_p(brick_p5));
           bricktest eight (  .clk(clk),
                   .reset(reset),
                   .h_video(h_video),
                   .v_video(v_video),
                   .tick60hz(tick60hz),
                   .pix_x(pix_x),
                   .pix_y(pix_y),
                   .ball_y_t(ball_y_t),
                   .brick_on(brick_on6),
                   .brick_rgb(brick_rgb6),
                   .brick_rgbin(3'b000),
                   .direction(direction6),
                   .BRICK_Y_T(105),
                   .brick_p(brick_p6));

                   
  gameover ten( .clk(clk), .reset(reset),.h_video(h_video),
                     .v_video(v_video),.tick60hz(tick60hz),
                     .pix_x(pix_x),.pix_y(pix_y),
                     .letter_on(letter_on), .l_rgb(l_rgb));

   always @*
      if (~(h_video&&v_video)) begin 
         graph_rgb = 3'b000; // blank
      end 
      else begin 
          if (bar_on & !gameover)
            graph_rgb = bar_rgb;
         else if (rd_ball_on & !gameover)
            graph_rgb = ball_rgb;
         else if (brick_on & !gameover) 
            graph_rgb = brick_rgb;
         else if (brick_on1 & !gameover) 
            graph_rgb = brick_rgb1;
         else if (brick_on2 & !gameover) 
            graph_rgb = brick_rgb2;
         else if (brick_on3 & !gameover) 
            graph_rgb = brick_rgb3;
         else if (brick_on4 & !gameover) 
            graph_rgb = brick_rgb4;
         else if (brick_on5 & !gameover) 
            graph_rgb = brick_rgb5;
         else if (brick_on6 & !gameover) 
            graph_rgb = brick_rgb6;
         else if (gameover) begin 
            if (letter_on)
                graph_rgb = l_rgb;
            else 
                graph_rgb = 3'b101;
         end
         else 
            graph_rgb = 3'b110; 
      end
            assign brickstaken = (gameover)? !brick_p+!brick_p1+!brick_p2+!brick_p3+!brick_p4+!brick_p5+!brick_p6:
                                                3'b0;
            assign status = gameover;
            assign brickstakenled = (gameover)? !brick_p+!brick_p1+!brick_p2+!brick_p3+!brick_p4+!brick_p5+!brick_p6:
                                                3'b0;
endmodule

