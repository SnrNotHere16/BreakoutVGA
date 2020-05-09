`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// By Omar Aquino Pineda
// File Name: V_Sync.v
// The following module is for the vertical synchronization. The count
// is from 0 to 525. The count increments when it receives a horizontal 
// synchronization (h_tick). Vertical synchronization is postive between
// 490 and 491. Vertical video is positive from 0 to 479. 
//The value of charV determines which object is displayed. 
//////////////////////////////////////////////////////////////////////////////////



module V_Sync(clk, reset, twf_tick,h_tick, v_tick,  v_sync, v_video, q );
input clk, reset, h_tick, twf_tick;
output reg v_tick, v_sync, v_video;
output q;
reg [9:0] q,nq; 


////////////////////////////////////////
//  combonational logic block         //
////////////////////////////////////////
always @(*) begin
v_tick = q == 524;
v_sync = ~((q >= 490) && (q <= 491));
v_video = q <= 479;
case({h_tick, twf_tick})
    2'b0_0:  nq = q;
    2'b0_1:  nq = q;
    2'b1_0:  nq = q;
    2'b1_1:  nq = q+1'b1;
    default: q = 10'b0;
 endcase
    
end 

////////////////////////////////////////
//  sequential logic block            // 
////////////////////////////////////////
always @ (posedge clk, posedge reset)
    if (reset)   q <= 10'b0;
   
    else begin  
    if (v_tick&&h_tick&& twf_tick) 
        q <= 10'b0;
    else 
        q = nq;
    end 
endmodule
