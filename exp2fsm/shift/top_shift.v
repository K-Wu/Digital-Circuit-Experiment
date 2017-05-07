module top_shift(found,s,clk_i,reset_i,din,system_clk);
output found;
output reg [5:0] s;
input clk_i,reset_i,din,system_clk;
debounce xdb(.clk(system_clk),.key_i(clk_i),.key_o(clk));
debounce xdb2(.clk(system_clk),.key_i(reset_i),.key_o(reset));
initial begin
s<=6'b000000;
end
always @(posedge clk or posedge reset)
begin
if (reset)
	s<=6'b000000;
else
begin
	s[5]<=s[4];
	s[4]<=s[3];
	s[3]<=s[2];
	s[2]<=s[1];
	s[1]<=s[0];
	s[0]<=din;
end
end
assign found=(s==6'b101011)?1:0;

endmodule
