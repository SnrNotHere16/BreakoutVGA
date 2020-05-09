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


module ball_animate( clk, 
                     reset, 
                     direction,
                     h_video, 
                     v_video, 
                     tick60hz,
                     pix_x, 
                     pix_y,
                     bar_x_l,
                     bar_x_r,
                     ball_rgb, 
                     rd_ball_on, 
                     ball_y_t,
                     gameover
                     );
                     
input  clk, reset, tick60hz, h_video, v_video;
input [9:0] pix_x, pix_y, bar_x_l, bar_x_r;
input [17:0] direction; 
output wire rd_ball_on, gameover;
output wire [2:0] ball_rgb; 
output wire [9:0]  ball_y_t;
 reg [2:0] lives; 

 // constant and signal declaration
 // x, y coordinates (0,0) to (639,479)
   localparam MIN_X = 0;
   localparam MAX_X = 640;
   localparam MAX_Y = 480;
  //--------------------------------------------
  // square ball
  //--------------------------------------------
   localparam BALL_SIZE = 8;
 // ball left, right boundary
   wire [9:0] ball_x_l, ball_x_r;
 // ball top, bottom boundary
   wire [9:0]  ball_y_b;
 // reg to track left, top position
   reg [9:0] ball_x_reg, ball_y_reg;
   wire [9:0] ball_x_next, ball_y_next;
 // reg to track ball speed
   reg [9:0] x_delta_reg, x_delta_next;
   reg [9:0] y_delta_reg, y_delta_next;
 // ball velocity can be pos or neg)
   localparam BALL_V_P = 8;
   localparam BALL_V_N = -8;
   localparam BALL_V_P_R = 3;
   localparam BALL_V_N_R = -3;
// bar top, bottom boundary. 
   localparam BAR_Y_T = 429;
   localparam BAR_Y_B = 449;
 //--------------------------------------------
 // round ball
 //--------------------------------------------
   wire [2:0] rom_addr, rom_col;
   reg [7:0] rom_data;
   wire rom_bit;
 // object output signals
 //--------------------------------------------
   wire  sq_ball_on;

 // body
 //--------------------------------------------
 // round ball image ROM
 //--------------------------------------------
   always @*
   case (rom_addr)
      3'h0: rom_data = 8'b00111100; //   ****
      3'h1: rom_data = 8'b01111110; //  ******
      3'h2: rom_data = 8'b11111111; // ********
      3'h3: rom_data = 8'b11111111; // ********
      3'h4: rom_data = 8'b11111111; // ********
      3'h5: rom_data = 8'b11111111; // ********
      3'h6: rom_data = 8'b01111110; //  ******
      3'h7: rom_data = 8'b00111100; //   ****
   endcase

  // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin

            ball_x_reg <= 60;
            ball_y_reg <= 170;
            x_delta_reg <= -1 ;
            y_delta_reg <= 1 ;
            lives <= 5;

         end
      else
         begin
//            bar_x_reg <= bar_x_next;
            ball_x_reg <= ball_x_next;
            ball_y_reg <= ball_y_next;
            x_delta_reg <= x_delta_next;
            y_delta_reg <= y_delta_next;

            if (ball_y_b > MAX_Y-1) begin 
                       ball_x_reg <= 329;
                       ball_y_reg <= 240;
                       x_delta_reg <= -1 ;
                       y_delta_reg <= 1 ;
                       lives <= lives - 1;
            end 
            
            if (gameover) begin 
                x_delta_reg <= 0 ;
                y_delta_reg <= 0 ;
            end

         end

  //--------------------------------------------
   // square ball
   //--------------------------------------------
   // boundary
   assign ball_x_l = ball_x_reg;
   assign ball_y_t = ball_y_reg;
   assign ball_x_r = ball_x_l + BALL_SIZE - 1;
   assign ball_y_b = ball_y_t + BALL_SIZE - 1;
   // pixel within ball
   assign sq_ball_on =
            (ball_x_l<=pix_x) && (pix_x<=ball_x_r) &&
            (ball_y_t<=pix_y) && (pix_y<=ball_y_b);
   // map current pixel location to ROM addr/col
   assign rom_addr = pix_y[2:0] - ball_y_t[2:0];
   assign rom_col = pix_x[2:0] - ball_x_l[2:0];
   assign rom_bit = rom_data[rom_col];
   // pixel within ball
   assign rd_ball_on = sq_ball_on & rom_bit;
   // ball rgb output
   assign ball_rgb = (lives >= 2)? 3'b101 : 3'b001;   
   // new ball position
   assign ball_x_next = (tick60hz) ? ball_x_reg+x_delta_reg :
                        ball_x_reg ; 
   assign ball_y_next = (tick60hz)  ? ball_y_reg+y_delta_reg :
                        ball_y_reg ;
   always @*
   begin
      x_delta_next = x_delta_reg;
      y_delta_next = y_delta_reg;
      if (ball_y_t  <= 2+BALL_V_P) // reach top
         y_delta_next = BALL_V_P;
       if ((BAR_Y_T-1<=ball_y_b) && (BAR_Y_B - 1 >= ball_y_b) &&
               (bar_x_l<=ball_x_l) && (ball_x_r<=bar_x_r))
           y_delta_next = BALL_V_N;   

      else if (ball_x_r > MAX_X-1) begin 
        x_delta_next = BALL_V_N;
      end
      else if (ball_x_l   <= 1) begin 
        x_delta_next = BALL_V_P;
      end
      else if ( direction[2:0] > 3'b000) begin 
                y_delta_next = BALL_V_P;
       end
      else if (direction [5:3] > 3'b000)begin 
                y_delta_next = BALL_V_P;
      end 
      else if (direction [8:6] > 3'b000)begin 
                y_delta_next = BALL_V_P;
      end 
      else if (direction [11:9] > 3'b000)begin 
                y_delta_next = BALL_V_P;
      end 
      else if (direction [14:12] > 3'b000)begin 
                y_delta_next = BALL_V_P;
      end 
      else if (direction [17:15] > 3'b000)begin 
                y_delta_next = BALL_V_P;
      end 

   end
assign gameover = lives <= 0;
//assign brickhit = direction > 0;
endmodule
