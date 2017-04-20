
`timescale 1ns/1ns
module adder_sync_tb;
reg clk,reset,clk_input;
top_minus_sync tas(leds,clk_input,clk,reset);

initial begin
clk<=0;
reset<=0;
clk_input<=1;
end
initial fork
forever #50clk_input<=~clk_input;
forever #5 clk<=~clk;
#910 reset<=1;
#930 reset<=0;
//#100clk_input<=~clk_input;
join

endmodule