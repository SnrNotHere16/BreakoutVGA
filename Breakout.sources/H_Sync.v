`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// By Omar Aquino Pineda
// File Name: H_Sync.v
// The following module uses a 100Mhz clock as its clk value. However, it runs at 
// 25Mhz frequency (tick). The horizontal tick is positive when the count (q) 
// reaches 799 then the count resets to 0. Horizontal sync is positive during the 
//charH determines which object should be outputted.
//////////////////////////////////////////////////////////////////////////////////
module H_Sync( clk,
               reset,
               tick,
               h_tick,
               h_sync,
               h_video,
                q
              );
 input clk, reset, tick;   //100Mhz clock
 output h_tick,h_sync, h_video;    //h_tick is sent when the count is complete
                          //h_sync is positie when the range of the count ranges 656 - 751

 output q;
 reg h_tick, h_sync, h_video;
 reg [9:0] q,nq;          // The value to be incremented and compared. Range 0-799.
 reg  [1:0] charH;
 
////////////////////////////////////////
//  combonational logic block         //
////////////////////////////////////////
always @(*) begin
h_tick = q == 799;
h_sync = ~((q >= 656) && (q <= 751));
h_video = q <= 639;
case({tick,h_tick})
    2'b0_0:  nq = q;
    2'b0_1:  nq = q; 
    2'b1_0:  nq = q+1;
    2'b1_1:  nq = 10'b0;
    default: nq = 10'b0;
 endcase
    
end  

////////////////////////////////////////
//  sequential logic block            // 
////////////////////////////////////////
always @ (posedge clk, posedge reset)
    if (reset)  q <= 10'b0;

    else q = nq;
endmodule
