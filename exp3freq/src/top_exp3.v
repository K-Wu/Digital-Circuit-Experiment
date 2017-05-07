module test(
input [1:0] testmode,
input sysclk,
input modecontrol,
output highfreq,
output [7:0]Cathodes,
output[3:0] AN
);
wire sigin;
signalinput signalin(testmode,sysclk,sigin);
frequency freq(sigin,sysclk,modecontrol,highfreq,Cathodes,AN);
endmodule
