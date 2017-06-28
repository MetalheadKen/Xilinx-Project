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

# VITA interface
set_property PACKAGE_PIN V22 [get_ports vita_io_clk_pll];
set_property PACKAGE_PIN AA18 [get_ports vita_io_reset_n];
set_property PACKAGE_PIN W22 [get_ports {vita_io_trigger[2]}];
set_property PACKAGE_PIN T22 [get_ports {vita_io_trigger[1]}];
set_property PACKAGE_PIN U22 [get_ports {vita_io_trigger[0]}];
set_property PACKAGE_PIN Y13 [get_ports {vita_io_monitor[0]}];
set_property PACKAGE_PIN AA13 [get_ports {vita_io_monitor[1]}];
set_property PACKAGE_PIN W15 [get_ports vita_io_spi_sclk];
set_property PACKAGE_PIN Y15 [get_ports vita_io_spi_ssel_n];
set_property PACKAGE_PIN Y14 [get_ports vita_io_spi_mosi];
set_property PACKAGE_PIN AA14 [get_ports vita_io_spi_miso];
set_property PACKAGE_PIN Y19 [get_ports vita_io_clk_out_p];
set_property PACKAGE_PIN AA19 [get_ports vita_io_clk_out_n];
set_property PACKAGE_PIN Y20 [get_ports vita_io_sync_p];
set_property PACKAGE_PIN Y21 [get_ports vita_io_sync_n];
set_property PACKAGE_PIN U15 [get_ports {vita_io_data_p[0]}];
set_property PACKAGE_PIN U16 [get_ports {vita_io_data_n[0]}];
set_property PACKAGE_PIN T21 [get_ports {vita_io_data_p[1]}];
set_property PACKAGE_PIN U21 [get_ports {vita_io_data_n[1]}];
set_property PACKAGE_PIN AA17 [get_ports {vita_io_data_p[2]}];
set_property PACKAGE_PIN AB17 [get_ports {vita_io_data_n[2]}];
set_property PACKAGE_PIN AB19 [get_ports {vita_io_data_p[3]}];
set_property PACKAGE_PIN AB20 [get_ports {vita_io_data_n[3]}];
#set_property PACKAGE_PIN V13 [get_ports {vita_io_data_p[4]}];
#set_property PACKAGE_PIN W13 [get_ports {vita_io_data_n[4]}];
#set_property PACKAGE_PIN U17 [get_ports {vita_io_data_p[5]}];
#set_property PACKAGE_PIN V17 [get_ports {vita_io_data_n[5]}];
#set_property PACKAGE_PIN AA16 [get_ports {vita_io_data_p[6]}];
#set_property PACKAGE_PIN AB16 [get_ports {vita_io_data_n[6]}];
#set_property PACKAGE_PIN V14 [get_ports {vita_io_data_p[7]}];
#set_property PACKAGE_PIN V15 [get_ports {vita_io_data_n[7]}];

set_property IOSTANDARD LVCMOS25 [get_ports vita_io_clk_pll]
set_property IOSTANDARD LVCMOS25 [get_ports vita_io_reset_n]
set_property IOSTANDARD LVCMOS25 [get_ports vita_io_trigger*]
set_property IOSTANDARD LVCMOS25 [get_ports vita_io_monitor*]
set_property IOSTANDARD LVCMOS25 [get_ports vita_io_spi_*]

set_property IOSTANDARD LVDS_25 [get_ports vita_io_clk_out_*]
set_property IOSTANDARD LVDS_25 [get_ports vita_io_sync_*]
set_property IOSTANDARD LVDS_25 [get_ports vita_io_data_*]

set_property DIFF_TERM true [get_ports vita_io_clk_out_*]
set_property DIFF_TERM true [get_ports vita_io_sync_*]
set_property DIFF_TERM true [get_ports vita_io_data_*]


# Video Clock Synthesizer
set_property PACKAGE_PIN Y18 [get_ports vita_clk]
set_property IOSTANDARD LVCMOS25 [get_ports vita_clk]

##################
# Primary Clocks #
##################

create_clock -period 20.000 -name clk_fpga_0 [get_nets -hierarchical FCLK_CLK0]
create_clock -period 6.730 -name clk_fpga_1 [get_nets -hierarchical FCLK_CLK1]
create_clock -period 5.000 -name clk_fpga_2 [get_nets -hierarchical FCLK_CLK2]
create_clock -period 6.730 -name vita_clk [get_ports vita_clk]
create_clock -period 2.692 -name vita_ser_clk [get_ports vita_io_clk_out_p]

set_clock_groups -asynchronous -group [get_clocks "clk_fpga_0 clk_fpga_1 clk_fpga_2" ]  -group [get_clocks -include_generated_clocks "vita_clk vita_ser_clk" ]

