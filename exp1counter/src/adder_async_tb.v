`timescale 1ns/1ns

module adder_async_tb;
reg clk,reset,but_input;
wire [6:0] leds;
top_adder_async tas(leds,but_input,clk,reset);

initial begin
clk<=0;
reset<=0;
but_input<=1;
end
initial fork
forever #50 but_input<=~but_input;
forever #5 clk<=~clk;
#910 reset<=~reset; #920 reset<=0;
//#100clk_input<=~clk_input;
join

endmodule