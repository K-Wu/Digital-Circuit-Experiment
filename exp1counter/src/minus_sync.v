module top_minus_sync (leds,but_input,clk,reset);
output [0:6] leds;
input but_input,clk,reset;
reg [3:0] s;

wire [0:6] leds;

initial begin
s<=4'b0000;
end
debounce xdbs(.clk(clk),.key_i(but_input),.key_o(but_input_dbs));
always @(posedge but_input_dbs or posedge reset)
begin
	//if (but_input) 
	if (reset)
	s<=4'b0000;
	else
	s[3:0]<=s[3:0]-1; 
end


//assign leds=~digi;

BCD7 bcd27seg (.din(s),.dout(leds));


endmodule