set_property IOSTANDARD LVCMOS33 [get_ports sysclk]
set_property IOSTANDARD LVCMOS33 [get_ports {txd}]
set_property IOSTANDARD LVCMOS33 [get_ports {rxd}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

set_property PACKAGE_PIN W5 [get_ports sysclk]
set_property PACKAGE_PIN B18 [get_ports {rxd}]
set_property PACKAGE_PIN A18 [get_ports {txd}]
set_property PACKAGE_PIN V17 [get_ports {reset}]

create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports sysclk]