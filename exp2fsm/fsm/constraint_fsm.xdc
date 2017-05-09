set_property IOSTANDARD LVCMOS33 [get_ports found]
set_property IOSTANDARD LVCMOS33 [get_ports system_clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports reset_i]
set_property IOSTANDARD LVCMOS33 [get_ports din]
set_property IOSTANDARD LVCMOS33 [get_ports {s[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {s[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {s[2]}]


set_property PACKAGE_PIN U16 [get_ports found]
set_property PACKAGE_PIN W5 [get_ports system_clk]
set_property PACKAGE_PIN U17 [get_ports clk_i]
set_property PACKAGE_PIN T18 [get_ports reset_i]
set_property PACKAGE_PIN V16 [get_ports din]
set_property PACKAGE_PIN U15 [get_ports {s[0]}]
set_property PACKAGE_PIN U14 [get_ports {s[1]}]
set_property PACKAGE_PIN V14 [get_ports {s[2]}]

create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports system_clk]