`timescale 1ns/1ns
module exp3_tb;
reg [1:0] testmode;
reg sysclk,modecontrol;
wire highfreq;
wire [7:0] Cathodes;
wire [3:0] AN;
test tst(testmode,sysclk,modecontrol,highfreq,Cathodes,AN);
initial fork
sysclk<=0;
testmode<=1;
modecontrol<=0;
forever #2 sysclk<=~sysclk;
join


endmodule