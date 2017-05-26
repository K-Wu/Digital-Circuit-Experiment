module baud_rate_generation(baud,sysclk,reset);//16*9600
input sysclk,reset;
output reg baud;
reg [17:0] s;
initial begin 
s<=1;
baud<=0;
end
always @(posedge sysclk)
begin
if (reset)
begin
s<=1;
baud<=0;
end
s<=s+1;
if(s==18'd326)
baud<=~baud;
else if(s==18'd651)
baud<=~baud;
else if(s==18'd977)
baud<=~baud;
else if(s==18'd1302)
baud<=~baud;
else if(s==18'd1628)
baud<=~baud;
else if (s==18'd1953)
baud<=~baud;
else if(s==18'd2279)
baud<=~baud;
else if (s==18'd2604)
begin
baud<=~baud;
s<=1;
end
end
endmodule

module receiver(rx_data,rx_status,baud,rxd,reset);
output reg [7:0] rx_data;
reg [7:0] new_rx_data;
output reg rx_status;
input baud,rxd,reset;
reg started;
reg [7:0] count;

initial begin
started<=0;
rx_data<=8'b0;
new_rx_data<=8'b0;
rx_status<=0;
count<=0;
end


always @(posedge baud)
begin
if (reset)
begin
started<=0;
rx_data<=8'b0;
new_rx_data<=8'b0;
rx_status<=0;
count<=0;
end
else if (~rxd && ~started)
started<=1;
if (started)
count<=count+1;
if (count==8'd160)
begin
count<=0;
started<=0;
end
//if (count==8'b8)//0 start bit
if (count==8'd24)//1
new_rx_data[0]<=rxd;
else if (count==8'd40)//2
new_rx_data[1]<=rxd;
else if (count==8'd56)//3
new_rx_data[2]<=rxd;
else if (count==8'd72)//4
new_rx_data[3]<=rxd;
else if (count==8'd88)//5
new_rx_data[4]<=rxd;
else if (count==8'd104)//6
new_rx_data[5]<=rxd;
else if (count==8'd120)//7
new_rx_data[6]<=rxd;
else if (count==8'd136)//8
new_rx_data[7]<=rxd;
else if (count==8'd152)//stop bit
begin
rx_data<=new_rx_data;
rx_status<=1;
end
else if (count==8'd154)
rx_status<=0;
end
endmodule

module controller(tx_data,tx_en,baud,tx_status,rx_status,rx_data,reset,sysclk);
input [7:0] rx_data;
reg [7:0] data;
reg ready,ready2,rx_high,rx_negedge,rx_negedge2;
input rx_status,tx_status,baud,sysclk;
input reset;
output reg tx_en;
output reg [7:0] tx_data;
initial begin
tx_en<=0;
tx_data<=8'b0;
data<=8'b0;
ready<=0;
ready2<=0;
rx_high<=0;
rx_negedge2<=0;
rx_negedge<=0;
end

always @(posedge baud)
begin
if (rx_status)
rx_high<=1;
else if(rx_negedge2)
begin
rx_negedge2<=0;
rx_negedge<=0;
end
else if(rx_negedge)
begin
rx_negedge2<=1;
end
else if(~rx_status && rx_high)
begin
rx_negedge<=1;
rx_high<=0;
end

end
always @(posedge sysclk)
begin
if (rx_negedge)
begin
if (rx_data[7]==1)
data<=~rx_data;
else
data<=rx_data;
end
end

always @(posedge baud)
begin
if (reset)
begin
tx_en<=0;
tx_data<=8'b0;
end
if (ready && tx_status)
begin
tx_en<=1;
ready2<=1;
end
else if (ready2)
begin
ready2<=0;
ready<=0;
end
else if (~ready)
begin
tx_en<=0;
end
if (rx_negedge)
begin
ready<=1;
tx_data<=data;
  
end
end
endmodule

module sender(txd,tx_status,tx_en,tx_data,reset,baud,sysclk);
output reg txd;
output reg tx_status;
input tx_en,reset,baud,sysclk;
input [7:0] tx_data;
reg [7:0] data;
reg [7:0] count;
reg enabled,stop,started;
initial begin
txd<=1;
tx_status<=1;
enabled<=0;
stop<=0;
started<=0;
data<=8'b0;
count<=0;
end

always @(posedge sysclk)//tx_en or posedge stop)
begin
if (reset)
tx_status<=1;
else if (stop)
begin
tx_status<=1;
end
else if (tx_en)
begin
tx_status<=0;
end
end


always @(posedge baud)//sysclk ?baud???????baud?????
begin
if (reset)
begin
started<=0;
data<=8'b0;//tx_data;
end
else if (tx_en)
enabled<=1;
else if (~tx_en && enabled)
begin
enabled<=0;
started<=1;
data<=tx_data;
end
if (baud)
begin
if (started)
begin
count<=count+1;
if (count==8'd160)
begin
stop<=1;
end
else if (count==8'd161)
begin
count<=0;
stop<=0;
started<=0;
end
if (count==8'd0)//0 start bit
txd<=0;
else if (count==8'd16)//1
txd<=data[0];
else if (count==8'd32)//2
txd<=data[1];
else if (count==8'd48)//3
txd<=data[2];
else if (count==8'd64)//4
txd<=data[3];
else if (count==8'd80)//5
txd<=data[4];
else if (count==8'd96)//6
txd<=data[5];
else if (count==8'd112)//7
txd<=data[6];
else if (count==8'd128)//8
txd<=data[7];
else if (count==8'd144)//stop bit
begin
txd<=1;
end
//else if (count==8'd159)
//stop<=1;
//else if (count==8'b153)
//rx_status<=0;
end
end
end


endmodule