module frequency (sigin,sysclk,modecontrol,highfreq,cathodes,AN);
input sigin,sysclk,modecontrol;
output [7:0] cathodes;
output [3:0] AN;
output reg highfreq;
always @*
begin
highfreq<=modecontrol;
end

wire [3:0] s3;
wire [3:0] s2;
wire [3:0] s1;
wire [3:0] s0;
wire [3:0] saved_s3;
wire [3:0] saved_s2;
wire [3:0] saved_s1;
wire [3:0] saved_s0;
hertz_clk_generation hz_clk_gn(.hz_clk(hz_clk),.system_clk(sysclk));
thousand_hertz_clk_generation th_hz_clk_gn(.hz_clk(th_hz_clk),.system_clk(sysclk));
range_switch rg_sw(.otput(otput),.iput(sigin),.modecontrol(modecontrol));
control_signal ct_sg(.save(save),.enable(enable),.reset(reset),.hz_clk(hz_clk));
decimal_counter dcm_ct(.s3(s3),.s2(s2),.s1(s1),.s0(s0),.iput(otput),.enable(enable),.reset(reset));
saver svr(.saved_s3(saved_s3),.saved_s2(saved_s2),.saved_s1(saved_s1),.saved_s0(saved_s0),.save(save),.s3(s3),.s2(s2),.s1(s1),.s0(s0));
show sh(.dout(cathodes),.an3(AN[3]),.an2(AN[2]),.an1(AN[1]),.an0(AN[0]),.th_hz_clk(th_hz_clk),.s3(saved_s3),.s2(saved_s2),.s1(saved_s1),.s0(saved_s0));



endmodule