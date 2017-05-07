module hertz_clk_generation(hz_clk,system_clk);
input system_clk;
output reg hz_clk;
reg [25:0] s;
initial begin
s<=1;
hz_clk<=0;
end
always @(posedge system_clk)
begin
s<=s+1;
if(s==26'd50000000)
begin
hz_clk<=~hz_clk;
s<=1;
end

end
endmodule

module thousand_hertz_clk_generation(hz_clk,system_clk);
input system_clk;
output reg hz_clk;
reg [15:0] s;
initial begin
s<=1;
hz_clk<=0;
end
always @(posedge system_clk)
begin
s<=s+1;
if(s==16'd50000)
begin
hz_clk<=~hz_clk;
s<=1;
end
end
endmodule


module ten_frequency_divider(otput,iput);
output reg otput;
input iput;
reg [4:0] s;
initial begin
s<=4'd0;
otput<=0;
end
always @(posedge iput)
begin
s<=s+1;
if (s==4'd4)
begin
s<=4'd0;
otput<=~otput;
end
end
endmodule


module range_switch(otput,iput,modecontrol);
ten_frequency_divider tn_freq_div(.otput(ten_otput),.iput(iput));
output reg otput;
input iput,modecontrol;

always @*
begin
if (modecontrol)
otput<=ten_otput;
else
otput<=iput;
end

endmodule


module control_signal(save,enable,reset,hz_clk);
input hz_clk;
output reg save,enable,reset;
initial begin
save<=0;
enable<=1;
reset<=0;
end
always @(posedge hz_clk)
begin
save<=~save;
enable<=~enable;
reset<=~reset;
end
endmodule

module decimal_counter(s3,s2,s1,s0,iput,enable,reset);
output reg [3:0] s3;
output reg [3:0] s2;
output reg [3:0] s1;
output reg [3:0] s0;
reg [15:0] s;
input iput,enable,reset;
initial begin
s<=0;
end
always @*
begin
s3[3:0]<=(s/1000)%10;
s2[3:0]<=(s/100)%10;
s1[3:0]<=(s/10)%10;
s0[3:0]<=s%10;
end
always @(posedge iput or posedge reset)
begin
if (reset)
s<=0;
else if(enable)
s<=s+1;
end
endmodule

module saver(saved_s3,saved_s2,saved_s1,saved_s0,save,s3,s2,s1,s0);
input save;
input [3:0] s3;
input [3:0] s2;
input [3:0] s1;
input [3:0] s0;
output reg [3:0] saved_s3;
output reg [3:0] saved_s2;
output reg [3:0] saved_s1;
output reg [3:0] saved_s0;

always @*
begin
if(~save)
begin
saved_s3<=s3;
saved_s2<=s2;
saved_s1<=s1;
saved_s0<=s0;
end
end
endmodule


module show(dout,an3,an2,an1,an0,th_hz_clk,s3,s2,s1,s0);
input [3:0] s3;
input [3:0] s2;
input [3:0] s1;
input [3:0] s0;
input th_hz_clk;
output reg [7:0] dout;
output reg an3,an2,an1,an0;
wire [6:0] d0;
wire [6:0] d1;
wire [6:0] d2;
wire [6:0] d3;
BCD7 bcd1(.din(s0),.dout(d0));
BCD7 bcd2(.din(s1),.dout(d1));
BCD7 bcd3(.din(s2),.dout(d2));
BCD7 bcd4(.din(s3),.dout(d3));
reg [1:0] choice;
initial begin
choice<=0;
dout[7]<=1;
end
always@ (posedge th_hz_clk)
begin
choice<=choice+1;
if(choice==0)
begin
an0<=0;
an1<=1;
an2<=1;
an3<=1;
dout[6:0]<=d0;
end
else if (choice==1)
begin
an0<=1;
an1<=0;
an2<=1;
an3<=1;
dout[6:0]<=d1;
end
else if (choice==2)
begin
an0<=1;
an1<=1;
an2<=0;
an3<=1;
dout[6:0]<=d2;
end
else if (choice==3)
begin
an0<=1;
an1<=1;
an2<=1;
an3<=0;
dout[6:0]<=d3;
end
end
endmodule
