
########################
# Physical Constraints #
########################

# I2C Chain on FMC-IMAGEON
set_property PACKAGE_PIN J20 [get_ports {fmc_imageon_iic_scl_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_scl_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_scl_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_scl_io}]

set_property PACKAGE_PIN K21 [get_ports {fmc_imageon_iic_sda_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_sda_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_sda_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_sda_io}]

set_property PACKAGE_PIN N20 [get_ports {fmc_imageon_iic_rst_n}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_rst_n}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_rst_n}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_rst_n}]


# HDMI Output (ADV7511) on FMC-IMAGEON 
set_property PACKAGE_PIN C19 [get_ports hdmio_io_clk]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_io_clk]

set_property PACKAGE_PIN C22 [get_ports {hdmio_io_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[0]}]

set_property PACKAGE_PIN D22 [get_ports {hdmio_io_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[1]}]

set_property PACKAGE_PIN E20 [get_ports {hdmio_io_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[2]}]

set_property PACKAGE_PIN D15 [get_ports {hdmio_io_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[3]}]

set_property PACKAGE_PIN E19 [get_ports {hdmio_io_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[4]}]

set_property PACKAGE_PIN F19 [get_ports {hdmio_io_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[5]}]

set_property PACKAGE_PIN C20 [get_ports {hdmio_io_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[6]}]

set_property PACKAGE_PIN E15 [get_ports {hdmio_io_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[7]}]

set_property PACKAGE_PIN G19 [get_ports {hdmio_io_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[8]}]

set_property PACKAGE_PIN G16 [get_ports {hdmio_io_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[9]}]

set_property PACKAGE_PIN D20 [get_ports {hdmio_io_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[10]}]

set_property PACKAGE_PIN B20 [get_ports {hdmio_io_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[11]}]

set_property PACKAGE_PIN G15 [get_ports {hdmio_io_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[12]}]

set_property PACKAGE_PIN G21 [get_ports {hdmio_io_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[13]}]

set_property PACKAGE_PIN B19 [get_ports {hdmio_io_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[14]}]

set_property PACKAGE_PIN G20 [get_ports {hdmio_io_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[15]}]

set_property PACKAGE_PIN A18 [get_ports hdmio_io_spdif]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_io_spdif]

# HDMI Input (ADV7611) on FMC-IMAGEON
set_property PACKAGE_PIN D18 [get_ports hdmii_clk]
set_property IOSTANDARD LVCMOS25 [get_ports hdmii_clk]

set_property PACKAGE_PIN A17  [get_ports {hdmii_io_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[0]}]

set_property PACKAGE_PIN A16  [get_ports {hdmii_io_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[1]}]

set_property PACKAGE_PIN C18 [get_ports {hdmii_io_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[2]}]

set_property PACKAGE_PIN D21  [get_ports {hdmii_io_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[3]}]

set_property PACKAGE_PIN E18  [get_ports {hdmii_io_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[4]}]

set_property PACKAGE_PIN C17 [get_ports {hdmii_io_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[5]}]

set_property PACKAGE_PIN E21  [get_ports {hdmii_io_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[6]}]

set_property PACKAGE_PIN F18  [get_ports {hdmii_io_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[7]}]

set_property PACKAGE_PIN A22  [get_ports {hdmii_io_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[8]}]

set_property PACKAGE_PIN A21   [get_ports {hdmii_io_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[9]}]

set_property PACKAGE_PIN B22  [get_ports {hdmii_io_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[10]}]

set_property PACKAGE_PIN B21  [get_ports {hdmii_io_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[11]}]

set_property PACKAGE_PIN B15  [get_ports {hdmii_io_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[12]}]

set_property PACKAGE_PIN C15  [get_ports {hdmii_io_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[13]}]

set_property PACKAGE_PIN B17  [get_ports {hdmii_io_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[14]}]

set_property PACKAGE_PIN B16 [get_ports {hdmii_io_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[15]}]

set_property PACKAGE_PIN A19  [get_ports {hdmii_io_spdif}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_spdif}]

##################
# Primary Clocks #
##################

create_clock -period 20.000 -name clk_fpga_0 [get_nets -hierarchical FCLK_CLK0]
create_clock -period 6.730 -name clk_fpga_1 [get_nets -hierarchical FCLK_CLK1]
create_clock -period 6.730 -name hdmii_clk [get_ports hdmii_clk]

set_clock_groups -asynchronous -group [get_clocks "clk_fpga_0 clk_fpga_1" ]  -group [get_clocks -include_generated_clocks "hdmii_clk" ]
