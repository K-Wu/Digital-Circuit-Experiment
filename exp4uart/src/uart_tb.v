`timescale 1ns/1ps
module baud_base(baud_base,baud);
input baud;
output reg baud_base;
reg [3:0] s;
initial begin
s<=0;
baud_base<=0;
end
always @(posedge baud)
begin
s<=s+1;
if (s==4'd15)
begin
baud_base<=~baud_base;
end

end
endmodule
module uart_test;
reg [4:0] inverse=5'b10011;
reg clk=0,reset=0,rx=1;
wire tx;
always 
begin
	#5 clk=~clk;
end

initial
begin
	#2000 inverse<=~inverse;
	reset<=1;
	#2400000 reset<=0;
	#1000 rx=0;
	#104166.667 rx=1;
	#104166.667 rx=0;
	#104166.667 rx=0;
	#104166.667 rx=1;
	#104166.667 rx=0;
	#104166.667 rx=1;
	#104166.667 rx=1;
	#104166.667 rx=1;
	#104166.667 rx=1;

	#104166.667 rx=0;
	#104166.667 rx=1;//0
	#104166.667 rx=0;//1
	#104166.667 rx=0;//2
	#104166.667 rx=1;//3
	#104166.667 rx=0;//4
	#104166.667 rx=1;//5
	#104166.667 rx=1;//6
	#104166.667 rx=1;//7
	#104166.667 rx=1;

	#104166.667 rx=0;
	#104166.667 rx=1;//0
	#104166.667 rx=0;//1
	#104166.667 rx=0;//2
	#104166.667 rx=1;//3
	#104166.667 rx=0;//4
	#104166.667 rx=1;//5
	#104166.667 rx=1;//6
	#104166.667 rx=1;//7
	#104166.667 rx=1;

	#2400000
	#104166.667 rx=0;
	#104166.667 rx=1;//0
	#104166.667 rx=0;//1
	#104166.667 rx=0;//2
	#104166.667 rx=1;//3
	#104166.667 rx=0;//4
	#104166.667 rx=1;//5
	#104166.667 rx=1;//6
	#104166.667 rx=1;//7
	#104166.667 rx=1;
	#2400000
	$stop;
end
baud_rate_generation baud_gen(.baud(baud),.sysclk(clk),.reset(reset));

baud_base bd_base(.baud_base(baud_base),.baud(baud));
uart uart
(
  .txd(tx),
  .rxd(rx),
  .sysclk(clk),
  .reset(reset)
);
endmodule