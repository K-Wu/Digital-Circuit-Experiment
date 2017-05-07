module fsm(found,s,clk_i,din,reset_i,system_clk);
input din,clk_i,reset_i,system_clk;
output reg [2:0] s;
output found;
debounce xdb(.clk(system_clk),.key_i(reset_i),.key_o(reset));
debounce xdb2(.clk(system_clk),.key_i(clk_i),.key_o(clk));
initial begin
s<=3'b000;
end
always @(posedge clk or posedge reset)
begin
if (reset)
	begin
	s<=3'b000;
	end
else if(din)
	begin
	case(s)
	3'b000:s<=3'b001;
	3'b001:s<=3'b001;
	3'b010:s<=3'b011;
	3'b011:s<=3'b001;
	3'b100:s<=3'b101;
	3'b101:s<=3'b110;
	3'b110:s<=3'b001;
	3'b111:s<=3'b000;
	endcase
	end
else
	begin
	case(s)
	3'b000:s<=3'b000;
	3'b001:s<=3'b010;
	3'b010:s<=3'b000;
	3'b011:s<=3'b100;
	3'b100:s<=3'b000;
	3'b101:s<=3'b100;
	3'b110:s<=3'b010;
	3'b111:s<=3'b000;
	endcase
	end
end
assign found=(s==3'b110)?1:0;

endmodule