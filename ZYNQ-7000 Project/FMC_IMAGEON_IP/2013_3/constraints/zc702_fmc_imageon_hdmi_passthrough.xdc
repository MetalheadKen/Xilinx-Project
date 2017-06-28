
########################
# Physical Constraints #
########################

# I2C Chain on FMC-IMAGEON
set_property PACKAGE_PIN AB14 [get_ports {fmc_imageon_iic_scl_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_scl_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_scl_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_scl_io}]

set_property PACKAGE_PIN AB15 [get_ports {fmc_imageon_iic_sda_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_sda_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_sda_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_sda_io}]

set_property PACKAGE_PIN Y16 [get_ports {fmc_imageon_iic_rst_n}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_rst_n}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_rst_n}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_rst_n}]


# HDMI Output (ADV7511) on FMC-IMAGEON 
set_property PACKAGE_PIN Y5 [get_ports hdmio_io_clk]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_io_clk]

set_property PACKAGE_PIN AB12 [get_ports {hdmio_io_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[0]}]

set_property PACKAGE_PIN AA12 [get_ports {hdmio_io_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[1]}]

set_property PACKAGE_PIN V4 [get_ports {hdmio_io_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[2]}]

set_property PACKAGE_PIN W12 [get_ports {hdmio_io_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[3]}]

set_property PACKAGE_PIN V5 [get_ports {hdmio_io_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[4]}]

set_property PACKAGE_PIN U9 [get_ports {hdmio_io_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[5]}]

set_property PACKAGE_PIN AA8 [get_ports {hdmio_io_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[6]}]

set_property PACKAGE_PIN V12 [get_ports {hdmio_io_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[7]}]

set_property PACKAGE_PIN U10 [get_ports {hdmio_io_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[8]}]

set_property PACKAGE_PIN T6 [get_ports {hdmio_io_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[9]}]

set_property PACKAGE_PIN AA9 [get_ports {hdmio_io_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[10]}]

set_property PACKAGE_PIN AA6 [get_ports {hdmio_io_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[11]}]

set_property PACKAGE_PIN R6 [get_ports {hdmio_io_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[12]}]

set_property PACKAGE_PIN U4 [get_ports {hdmio_io_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[13]}]

set_property PACKAGE_PIN AA7 [get_ports {hdmio_io_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[14]}]

set_property PACKAGE_PIN T4 [get_ports {hdmio_io_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[15]}]

set_property PACKAGE_PIN U6 [get_ports hdmio_io_spdif]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_io_spdif]

# HDMI Input (ADV7611) on FMC-IMAGEON
set_property PACKAGE_PIN Y6 [get_ports hdmii_clk]
set_property IOSTANDARD LVCMOS25 [get_ports hdmii_clk]

set_property PACKAGE_PIN AB4  [get_ports {hdmii_io_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[0]}]

set_property PACKAGE_PIN AB5  [get_ports {hdmii_io_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[1]}]

set_property PACKAGE_PIN AB11 [get_ports {hdmii_io_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[2]}]

set_property PACKAGE_PIN AB1  [get_ports {hdmii_io_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[3]}]

set_property PACKAGE_PIN U11  [get_ports {hdmii_io_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[4]}]

set_property PACKAGE_PIN AA11 [get_ports {hdmii_io_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[5]}]

set_property PACKAGE_PIN AB2  [get_ports {hdmii_io_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[6]}]

set_property PACKAGE_PIN U12  [get_ports {hdmii_io_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[7]}]

set_property PACKAGE_PIN AA4  [get_ports {hdmii_io_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[8]}]

set_property PACKAGE_PIN Y4   [get_ports {hdmii_io_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[9]}]

set_property PACKAGE_PIN Y10  [get_ports {hdmii_io_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[10]}]

set_property PACKAGE_PIN Y11  [get_ports {hdmii_io_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[11]}]

set_property PACKAGE_PIN AB6  [get_ports {hdmii_io_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[12]}]

set_property PACKAGE_PIN AB7  [get_ports {hdmii_io_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[13]}]

set_property PACKAGE_PIN AB9  [get_ports {hdmii_io_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[14]}]

set_property PACKAGE_PIN AB10 [get_ports {hdmii_io_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_data[15]}]

set_property PACKAGE_PIN U5  [get_ports {hdmii_io_spdif}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmii_io_spdif}]

##################
# Primary Clocks #
##################

create_clock -period 20.000 -name clk_fpga_0 [get_nets -hierarchical FCLK_CLK0]
create_clock -period 6.730 -name clk_fpga_1 [get_nets -hierarchical FCLK_CLK1]
create_clock -period 6.730 -name hdmii_clk [get_ports hdmii_clk]

set_clock_groups -asynchronous -group [get_clocks "clk_fpga_0 clk_fpga_1" ]  -group [get_clocks -include_generated_clocks "hdmii_clk" ]
