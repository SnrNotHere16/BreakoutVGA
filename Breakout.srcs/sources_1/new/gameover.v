`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2020 09:39:36 PM
// Design Name: 
// Module Name: gameover
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


module gameover(clk, 
                reset, 
                h_video, 
                v_video, 
                tick60hz,
                pix_x, 
                pix_y,
                letter_on,
                l_rgb);
            
input  clk, reset, tick60hz, h_video, v_video;
input wire [9:0] pix_x, pix_y;
output wire [2:0] l_rgb;
wire g_l_on, a_l_on, m_l_on, e_l_on;
wire o_l_on, v_l_on, e1_l_on, r_l_on;
output wire letter_on; 
localparam L_SIZE = 8;
   reg [9:0] g_x_reg, g_y_reg, a_x_reg, a_y_reg, m_x_reg, m_y_reg, e_x_reg, e_y_reg;
   reg [9:0] o_x_reg, o_y_reg, v_x_reg, v_y_reg, e1_x_reg, e1_y_reg, r_x_reg, r_y_reg;
   wire [2:0] rom_addrG, rom_colG, rom_addrA, rom_colA, rom_addrM, rom_colM, rom_addrE, rom_colE;
   wire [2:0] rom_addrO, rom_colO, rom_addrV, rom_colV, rom_addrE1, rom_colE1, rom_addrR, rom_colR;
   reg [7:0] rom_dataG,rom_dataA, rom_dataM,rom_dataE;
   reg [7:0] rom_dataO,rom_dataV, rom_dataE1,rom_dataR;
   wire rom_bitG, rom_bitA, rom_bitM, rom_bitE;
   wire rom_bitO, rom_bitV, rom_bitE1, rom_bitR;
    // g letter left, right boundary
   wire [9:0] g_x_l, g_x_r,a_x_l, a_x_r, m_x_l, m_x_r, e_x_l, e_x_r;
   wire [9:0] o_x_l, o_x_r,v_x_l, v_x_r, e1_x_l, e1_x_r, r_x_l, r_x_r;
 // g letter top, bottom boundary
   wire [9:0]  g_y_b, a_y_b, m_y_b, e_y_b;
   wire [9:0]  g_y_t,a_y_t, m_y_t, e_y_t;
   wire [9:0]  o_y_b, v_y_b, e1_y_b, r_y_b;
   wire [9:0]  o_y_t,v_y_t, e1_y_t,r_y_t;
    // object output signals
 //--------------------------------------------
   wire  g_on, a_on, m_on, e_on;
   wire  o_on, v_on, e1_on, r_on;

   always @*
case(rom_addrG)
    3'h0: rom_dataG = 8'b11111100;//   ******  
    3'h1: rom_dataG = 8'b00001110;// ***    
    3'h2: rom_dataG = 8'b00000111;//***  
    3'h3: rom_dataG = 8'b00000111;//*** 
    3'h4: rom_dataG = 8'b11101111;//***  ****
    3'h5: rom_dataG = 8'b11101111;//***  ****
    3'h6: rom_dataG = 8'b11001110;// ***   **
    3'h7: rom_dataG = 8'b11111100;//  *******
endcase
always @*
case(rom_addrA)
    3'h0: rom_dataA = 8'b00011000;//   **   
    3'h1: rom_dataA = 8'b00100100;//  *  *  
    3'h2: rom_dataA = 8'b01100110;// **  ** 
    3'h3: rom_dataA = 8'b01100110;// **  ** 
    3'h4: rom_dataA = 8'b01111110;// ****** 
    3'h5: rom_dataA = 8'b01100110;// **  **
    3'h6: rom_dataA = 8'b01100110;// **  **
    3'h7: rom_dataA = 8'b01100110;// **  **
endcase
always @*
case(rom_addrM)
    3'h0: rom_dataM = 8'b11000111;//***      ***
    3'h1: rom_dataM = 8'b10100101;//** *    * **
    3'h2: rom_dataM = 8'b10011001;//**  *  *  **
    3'h3: rom_dataM = 8'b10011001;//**   **   **
    3'h4: rom_dataM = 8'b10000001;//**   **   **
    3'h5: rom_dataM = 8'b10000001;//**        **
    3'h6: rom_dataM = 8'b10000001;//**        **
    3'h7: rom_dataM = 8'b10000001;//**        **
endcase

always @*
case(rom_addrE)
    3'h0: rom_dataE = 8'b11111110;// *******  
    3'h1: rom_dataE = 8'b00000110;// **  
    3'h2: rom_dataE = 8'b00000110;// **  
    3'h3: rom_dataE = 8'b11111110;// ****** 
    3'h4: rom_dataE = 8'b11111110;// ****** 
    3'h5: rom_dataE = 8'b00000110;// **  
    3'h6: rom_dataE = 8'b00000110;// **  
    3'h7: rom_dataE = 8'b11111110;// *******
endcase

always @*
case(rom_addrO)
    3'h0: rom_dataO = 8'b00111100;//  *****   
    3'h1: rom_dataO = 8'b11000011;// **   ** 
    3'h2: rom_dataO = 8'b10000001;// *     *
    3'h3: rom_dataO = 8'b10000001;// *     * 
    3'h4: rom_dataO = 8'b10000001;// *     * 
    3'h5: rom_dataO = 8'b10000001;// *     *
    3'h6: rom_dataO = 8'b01000011;// **   **
    3'h7: rom_dataO = 8'b00111100;//  *****
endcase

always @*
case(rom_addrV)
    3'h0: rom_dataV = 8'b10000001;// *      *
    3'h1: rom_dataV = 8'b10000001;// *      *  
    3'h2: rom_dataV = 8'b10000001;// *      *
    3'h3: rom_dataV = 8'b10000001;// *      * 
    3'h4: rom_dataV = 8'b10000001;// *      * 
    3'h5: rom_dataV = 8'b11000011;// **    **
    3'h6: rom_dataV = 8'b01100110;//  **  **
    3'h7: rom_dataV = 8'b00011000;//    **
endcase

always @*
case(rom_addrE1)
    3'h0: rom_dataE1 = 8'b01111111;// *******  
    3'h1: rom_dataE1 = 8'b01100000;// **  
    3'h2: rom_dataE1 = 8'b01100000;// **  
    3'h3: rom_dataE1 = 8'b01111111;// ****** 
    3'h4: rom_dataE1 = 8'b01111111;// ****** 
    3'h5: rom_dataE1 = 8'b01100000;// **  
    3'h6: rom_dataE1 = 8'b01100000;// **  
    3'h7: rom_dataE1 = 8'b01111111;// *******
endcase

always @*
case(rom_addrR)
    3'h0: rom_dataR = 8'b00111111;// ******   
    3'h1: rom_dataR = 8'b11000011;// **    ** 
    3'h2: rom_dataR = 8'b10000011;// **     *
    3'h3: rom_dataR = 8'b11000011;// **    ** 
    3'h4: rom_dataR = 8'b00111111;// ******     
    3'h5: rom_dataR = 8'b00100001;// *    *
    3'h6: rom_dataR = 8'b01000011;// **    *
    3'h7: rom_dataR = 8'b10000011;// **     *
endcase


   always @(posedge clk, posedge reset)begin 
      if (reset)
         begin
            g_x_reg <= 240;
            g_y_reg <= 320;
            a_x_reg <= 260;
            a_y_reg <= 320;
            m_x_reg <= 280;
            m_y_reg <= 320;
            e_x_reg <= 300;
            e_y_reg <= 320;
            
            o_x_reg <= 360;
            o_y_reg <= 320;
            v_x_reg <= 380;
            v_y_reg <= 320;
            e1_x_reg <= 400;
            e1_y_reg <= 320;
            r_x_reg <= 420;
            r_y_reg <= 320;
         end
      else begin 
        g_x_reg <= 240;
        g_y_reg <= 320;
        a_x_reg <= 260;
        a_y_reg <= 320;
        m_x_reg <= 280;
        m_y_reg <= 320;
        e_x_reg <= 300;
        e_y_reg <= 320;
        
        o_x_reg <= 360;
        o_y_reg <= 320;
        v_x_reg <= 380;
        v_y_reg <= 320;
        e1_x_reg <= 400;
        e1_y_reg <= 320;
        r_x_reg <= 420;
        r_y_reg <= 320;
      end 
   end 
  //--------------------------------------------
   //  letter 
   //--------------------------------------------
   // boundary
   assign g_x_l = g_x_reg;
   assign g_y_t = g_y_reg;
   assign g_x_r = g_x_l + L_SIZE - 1;
   assign g_y_b = g_y_t + L_SIZE - 1;
   
   assign a_x_l = a_x_reg;
   assign a_y_t = a_y_reg;
   assign a_x_r = a_x_l + L_SIZE - 1;
   assign a_y_b = a_y_t + L_SIZE - 1;
   
   assign m_x_l = m_x_reg;
   assign m_y_t = m_y_reg;
   assign m_x_r = m_x_l + L_SIZE - 1;
   assign m_y_b = m_y_t + L_SIZE - 1;
   
   assign e_x_l = e_x_reg;
   assign e_y_t = e_y_reg;
   assign e_x_r = e_x_l + L_SIZE - 1;
   assign e_y_b = e_y_t + L_SIZE - 1;
   
   assign o_x_l = o_x_reg;
   assign o_y_t = o_y_reg;
   assign o_x_r = o_x_l + L_SIZE - 1;
   assign o_y_b = o_y_t + L_SIZE - 1;
   
   assign v_x_l = v_x_reg;
   assign v_y_t = v_y_reg;
   assign v_x_r = v_x_l + L_SIZE - 1;
   assign v_y_b = v_y_t + L_SIZE - 1;
   
   assign e1_x_l = e1_x_reg;
   assign e1_y_t = e1_y_reg;
   assign e1_x_r = e1_x_l + L_SIZE - 1;
   assign e1_y_b = e1_y_t + L_SIZE - 1;
   
   assign r_x_l = r_x_reg;
   assign r_y_t = r_y_reg;
   assign r_x_r = r_x_l + L_SIZE - 1;
   assign r_y_b = r_y_t + L_SIZE - 1;
   // pixel within letter
   assign g_on =
            (g_x_l<=pix_x) && (pix_x<=g_x_r) &&
            (g_y_t<=pix_y) && (pix_y<=g_y_b);
      assign a_on =
            (a_x_l<=pix_x) && (pix_x<=a_x_r) &&
            (a_y_t<=pix_y) && (pix_y<=a_y_b);
      assign m_on =
            (m_x_l<=pix_x) && (pix_x<=m_x_r) &&
            (m_y_t<=pix_y) && (pix_y<=m_y_b);
      assign e_on =
            (e_x_l<=pix_x) && (pix_x<=e_x_r) &&
            (e_y_t<=pix_y) && (pix_y<=e_y_b);
   assign o_on =
            (o_x_l<=pix_x) && (pix_x<=o_x_r) &&
            (o_y_t<=pix_y) && (pix_y<=o_y_b);
   assign v_on =
            (v_x_l<=pix_x) && (pix_x<=v_x_r) &&
            (v_y_t<=pix_y) && (pix_y<=v_y_b);
   assign e1_on =
            (e1_x_l<=pix_x) && (pix_x<=e1_x_r) &&
            (e1_y_t<=pix_y) && (pix_y<=e1_y_b);
   assign r_on =
            (r_x_l<=pix_x) && (pix_x<=r_x_r) &&
            (r_y_t<=pix_y) && (pix_y<=r_y_b);
   // map current pixel location to ROM addr/col
   assign rom_addrG = pix_y[2:0] - g_y_t[2:0];
   assign rom_colG = pix_x[2:0] - g_x_l[2:0];
   assign rom_bitG = rom_dataG[rom_colG];
   
   assign rom_addrA = pix_y[2:0] - a_y_t[2:0];
   assign rom_colA = pix_x[2:0] - a_x_l[2:0];
   assign rom_bitA = rom_dataA[rom_colA];
   
   assign rom_addrM = pix_y[2:0] - m_y_t[2:0];
   assign rom_colM = pix_x[2:0] - m_x_l[2:0];
   assign rom_bitM = rom_dataM[rom_colM];
   
   assign rom_addrE = pix_y[2:0] - e_y_t[2:0];
   assign rom_colE = pix_x[2:0] - e_x_l[2:0];
   assign rom_bitE = rom_dataE[rom_colE];
   
   assign rom_addrO = pix_y[2:0] - o_y_t[2:0];
   assign rom_colO = pix_x[2:0] - o_x_l[2:0];
   assign rom_bitO = rom_dataO[rom_colO];
   
   assign rom_addrV = pix_y[2:0] - v_y_t[2:0];
   assign rom_colV = pix_x[2:0] - v_x_l[2:0];
   assign rom_bitV = rom_dataV[rom_colV];
   
   assign rom_addrE1 = pix_y[2:0] - e_y_t[2:0];
   assign rom_colE1 = pix_x[2:0] - e_x_l[2:0];
   assign rom_bitE1 = rom_dataE1[rom_colE1];
   
   assign rom_addrR = pix_y[2:0] - r_y_t[2:0];
   assign rom_colR = pix_x[2:0] - r_x_l[2:0];
   assign rom_bitR = rom_dataR[rom_colR];
      // pixel within letter
   assign g_l_on = g_on & rom_bitG;
   assign a_l_on = a_on & rom_bitA;
   assign m_l_on = m_on & rom_bitM;
   assign e_l_on = e_on & rom_bitE;
   
   assign o_l_on = o_on & rom_bitO;
   assign v_l_on = v_on & rom_bitV;
   assign e1_l_on = e1_on & rom_bitE1;
   assign r_l_on = r_on & rom_bitR;
   assign l_rgb = 3'b000;
   assign letter_on = g_l_on || a_l_on || m_l_on || e_l_on || o_l_on || v_l_on || e1_l_on || r_l_on;
endmodule
