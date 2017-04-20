module top_adder_async (leds,but_input,clk,reset);
output [0:6] leds;
input but_input,clk,reset;
reg [3:0] s;

wire [0:6] leds;

initial begin
s<=4'b0000;
end
//debounce xdb(.clk(clk),.key_i(but_input),.key_o(but_input_dbs));
always @(posedge but_input or posedge reset)
    if(reset)
        s[0]<=0;
    else
	s[0]<=~s[0]; 
always @(negedge s[0] or posedge reset)
       if(reset)
           s[1]<=0;
       else
	s[1]<=~s[1];
always @(negedge s[1] or posedge reset)
       if(reset)
           s[2]<=0;
       else
	s[2]<=~s[2];
always @(negedge s[2] or posedge reset)
       if(reset)
           s[3]<=0;
       else
	s[3]<=~s[3];

//assign leds=~digi;

BCD7 bcd27seg (s,leds);


endmodule