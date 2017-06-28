
set_property LOC F7 [get_cells design_1_i/processing_system7_1/inst/PS_CLK_BIBUF]
#set_property PACKAGE_PIN F7 [get_ports {ps7_1_ps_clk[0]}]
set_property LOC B5 [get_cells design_1_i/processing_system7_1/inst/PS_PORB_BIBUF]
#set_property PACKAGE_PIN B5 [get_ports {ps7_1_ps_porb[0]}]
set_property LOC C9 [get_cells design_1_i/processing_system7_1/inst/PS_SRSTB_BIBUF]
#set_property PACKAGE_PIN C9 [get_ports {ps7_1_ps_srstb[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports ps7_1_ps_*]

#set_property PACKAGE_PIN W5 [get_ports ps7_1_mio[7]]
#set_property IOSTANDARD LVCMOS25 [get_ports ps7_1_mio[7]]

#
# ZC702 I2C Controller
#
#set_property PACKAGE_PIN W8 [get_ports iic_main_sda_io]
#set_property PACKAGE_PIN W11 [get_ports iic_main_scl_io]
#set_property IOSTANDARD LVCMOS25 [get_ports iic_main_*]


#
# ZC702 HDMI Output
#

set_property PACKAGE_PIN L16 [get_ports io_hdmio_clk]
set_property PACKAGE_PIN T18 [get_ports io_hdmio_de]
set_property PACKAGE_PIN R18 [get_ports io_hdmio_hsync]
set_property PACKAGE_PIN H15 [get_ports io_hdmio_vsync]
set_property PACKAGE_PIN R15 [get_ports io_hdmio_spdif]

## ADV7511 video input mode YCbCr 422, separate syncs, 16 bpp (ID = 1 / style 1)
# luma (Y) pins
set_property PACKAGE_PIN AB21 [get_ports {io_hdmio_video[0]}]
set_property PACKAGE_PIN AA21 [get_ports {io_hdmio_video[1]}]
set_property PACKAGE_PIN AB22 [get_ports {io_hdmio_video[2]}]
set_property PACKAGE_PIN AA22 [get_ports {io_hdmio_video[3]}]
set_property PACKAGE_PIN V19 [get_ports {io_hdmio_video[4]}]
set_property PACKAGE_PIN V18 [get_ports {io_hdmio_video[5]}]
set_property PACKAGE_PIN V20 [get_ports {io_hdmio_video[6]}]
set_property PACKAGE_PIN U20 [get_ports {io_hdmio_video[7]}]

# multiplexed chroma pins (Cr / Cb)
set_property PACKAGE_PIN W21 [get_ports {io_hdmio_video[8]}]
set_property PACKAGE_PIN W20 [get_ports {io_hdmio_video[9]}]
set_property PACKAGE_PIN W18 [get_ports {io_hdmio_video[10]}]
set_property PACKAGE_PIN T19 [get_ports {io_hdmio_video[11]}]
set_property PACKAGE_PIN U19 [get_ports {io_hdmio_video[12]}]
set_property PACKAGE_PIN R19 [get_ports {io_hdmio_video[13]}]
set_property PACKAGE_PIN T17 [get_ports {io_hdmio_video[14]}]
set_property PACKAGE_PIN T16 [get_ports {io_hdmio_video[15]}]
set_property IOB TRUE [get_cells -hierarchical {U0/hdmio_video_o_reg*}]
set_property IOSTANDARD LVCMOS25 [get_ports io_hdmio_*]

#
# FMC-IMAGEON I/O constraints - FMC Slot 2
#

# Peripheral I2C chain
set_property PACKAGE_PIN AB14 [get_ports iic_scl_io];
set_property PACKAGE_PIN AB15 [get_ports iic_sda_io];
set_property PACKAGE_PIN Y16 [get_ports iic_rst];
set_property IOSTANDARD LVCMOS25 [get_ports iic_*]

# VITA interface
set_property PACKAGE_PIN V22 [get_ports io_vita_clk_pll];
set_property PACKAGE_PIN AA18 [get_ports io_vita_reset_n];
set_property PACKAGE_PIN W22 [get_ports io_vita_trigger[2]];
set_property PACKAGE_PIN T22 [get_ports io_vita_trigger[1]];
set_property PACKAGE_PIN U22 [get_ports io_vita_trigger[0]];
set_property PACKAGE_PIN Y13 [get_ports io_vita_monitor[0]];
set_property PACKAGE_PIN AA13 [get_ports io_vita_monitor[1]];
set_property PACKAGE_PIN W15 [get_ports io_vita_spi_sclk];
set_property PACKAGE_PIN Y15 [get_ports io_vita_spi_ssel_n];
set_property PACKAGE_PIN Y14 [get_ports io_vita_spi_mosi];
set_property PACKAGE_PIN AA14 [get_ports io_vita_spi_miso];
set_property PACKAGE_PIN Y19 [get_ports io_vita_clk_out_p];
set_property PACKAGE_PIN AA19 [get_ports io_vita_clk_out_n];
set_property PACKAGE_PIN Y20 [get_ports io_vita_sync_p];
set_property PACKAGE_PIN Y21 [get_ports io_vita_sync_n];
set_property PACKAGE_PIN U15 [get_ports io_vita_data_p[0]];
set_property PACKAGE_PIN U16 [get_ports io_vita_data_n[0]];
set_property PACKAGE_PIN T21 [get_ports io_vita_data_p[1]];
set_property PACKAGE_PIN U21 [get_ports io_vita_data_n[1]];
set_property PACKAGE_PIN AA17 [get_ports io_vita_data_p[2]];
set_property PACKAGE_PIN AB17 [get_ports io_vita_data_n[2]];
set_property PACKAGE_PIN AB19 [get_ports io_vita_data_p[3]];
set_property PACKAGE_PIN AB20 [get_ports io_vita_data_n[3]];
set_property PACKAGE_PIN V13 [get_ports io_vita_data_p[4]];
set_property PACKAGE_PIN W13 [get_ports io_vita_data_n[4]];
set_property PACKAGE_PIN U17 [get_ports io_vita_data_p[5]];
set_property PACKAGE_PIN V17 [get_ports io_vita_data_n[5]];
set_property PACKAGE_PIN AA16 [get_ports io_vita_data_p[6]];
set_property PACKAGE_PIN AB16 [get_ports io_vita_data_n[6]];
set_property PACKAGE_PIN V14 [get_ports io_vita_data_p[7]];
set_property PACKAGE_PIN V15 [get_ports io_vita_data_n[7]];

set_property IOSTANDARD LVCMOS25 [get_ports io_vita_clk_pll]
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_reset_n]
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_trigger*]
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_monitor*]
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_spi_*]

set_property IOSTANDARD LVDS_25 [get_ports io_vita_clk_out_*]
set_property IOSTANDARD LVDS_25 [get_ports io_vita_sync_*]
set_property IOSTANDARD LVDS_25 [get_ports io_vita_data_*]
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_p[4]];
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_n[4]];
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_p[5]];
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_n[5]];
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_p[6]];
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_n[6]];
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_p[7]];
set_property IOSTANDARD LVCMOS25 [get_ports io_vita_data_n[7]];

set_property DIFF_TERM true [get_ports io_vita_clk_out_*]
set_property DIFF_TERM true [get_ports io_vita_sync_*]
set_property DIFF_TERM true [get_ports io_vita_data_*]

# Video Clock Synthesizer
set_property PACKAGE_PIN Y18 [get_ports clk_in1];
set_property IOSTANDARD LVCMOS25 [get_ports clk_in1]

#
# Clock Constraints
#

create_clock -period 20.000 -name clk_50MHz [get_nets -hierarchical clk_50MHz]
create_clock -period 5.000 -name clk_200MHz [get_nets -hierarchical clk_200MHz]
create_clock -period 6.730 -name fmc_imageon_video_clk1 [get_ports clk_in1]
create_clock -period 2.692 -name vita_ser_clk [get_ports io_vita_clk_out_p]

set_clock_groups -asynchronous -group [get_clocks "clk_50MHz clk_200MHz" ]  -group [get_clocks -include_generated_clocks "vita_ser_clk fmc_imageon_video_clk1" ]
