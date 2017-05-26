module uart(txd,rxd,sysclk,reset);
output txd;
input rxd;
input sysclk,reset;
wire [7:0] tx_data,rx_data;
baud_rate_generation baud_gen(.baud(baud),.sysclk(sysclk),.reset(reset));

receiver recv(.rx_data(rx_data),.rx_status(rx_status),.baud(baud),.rxd(rxd),.reset(reset));
controller cont(.tx_data(tx_data),.tx_en(tx_en),.baud(baud),.tx_status(tx_status),.rx_status(rx_status),.rx_data(rx_data),.reset(reset),.sysclk(sysclk));
sender send(.txd(txd),.tx_status(tx_status),.tx_en(tx_en),.tx_data(tx_data),.reset(reset),.baud(baud),.sysclk(sysclk));

endmodule
