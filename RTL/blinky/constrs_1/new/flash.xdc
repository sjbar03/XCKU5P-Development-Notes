
set_property PACKAGE_PIN T25 [get_ports clk_p]
set_property PACKAGE_PIN U25 [get_ports clk_n]
set_property IOSTANDARD LVDS [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_n]
create_clock -period 10.000 -name sys_clk [get_ports clk_p]
create_generated_clock -name clk_200 -source [get_ports clk_p] -multiply_by 2 [get_pins mmcm_inst/CLKOUT0]

set_property PACKAGE_PIN A10 [get_ports led_a10]
set_property IOSTANDARD LVCMOS33 [get_ports led_a10]
set_property DRIVE 12 [get_ports led_a10]

set_property PACKAGE_PIN B10 [get_ports led_b10]
set_property IOSTANDARD LVCMOS33 [get_ports led_b10]
set_property DRIVE 12 [get_ports led_b10]