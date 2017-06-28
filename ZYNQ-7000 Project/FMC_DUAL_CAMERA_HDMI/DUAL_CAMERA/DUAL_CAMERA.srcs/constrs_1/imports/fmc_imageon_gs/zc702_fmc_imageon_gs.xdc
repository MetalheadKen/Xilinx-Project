########################
# FMC1 Constraints     #
########################

# I2C Chain on FMC-IMAGEON
set_property PACKAGE_PIN N15 [get_ports {fmc_imageon_iic_l_scl_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_l_scl_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_l_scl_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_l_scl_io}]

set_property PACKAGE_PIN P15 [get_ports {fmc_imageon_iic_l_sda_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_l_sda_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_l_sda_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_l_sda_io}]

set_property PACKAGE_PIN N20 [get_ports {fmc_imageon_iic_l_rst_n}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_l_rst_n}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_l_rst_n}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_l_rst_n}]


# HDMI Output (ADV7511) on FMC-IMAGEON 
set_property PACKAGE_PIN M20 [get_ports IO_HDMIO_L_clk]
set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMIO_L_clk]

set_property PACKAGE_PIN B15 [get_ports {IO_HDMIO_L_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[0]}]

set_property PACKAGE_PIN C15 [get_ports {IO_HDMIO_L_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[1]}]

set_property PACKAGE_PIN F22 [get_ports {IO_HDMIO_L_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[2]}]

set_property PACKAGE_PIN G16 [get_ports {IO_HDMIO_L_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[3]}]

set_property PACKAGE_PIN F21 [get_ports {IO_HDMIO_L_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[4]}]

set_property PACKAGE_PIN F17 [get_ports {IO_HDMIO_L_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[5]}]

set_property PACKAGE_PIN C20 [get_ports {IO_HDMIO_L_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[6]}]

set_property PACKAGE_PIN G15 [get_ports {IO_HDMIO_L_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[7]}]

set_property PACKAGE_PIN G17 [get_ports {IO_HDMIO_L_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[8]}]

set_property PACKAGE_PIN E20 [get_ports {IO_HDMIO_L_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[9]}]

set_property PACKAGE_PIN D20 [get_ports {IO_HDMIO_L_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[10]}]

set_property PACKAGE_PIN B20 [get_ports {IO_HDMIO_L_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[11]}]

set_property PACKAGE_PIN E19 [get_ports {IO_HDMIO_L_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[12]}]

set_property PACKAGE_PIN G21 [get_ports {IO_HDMIO_L_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[13]}]

set_property PACKAGE_PIN B19 [get_ports {IO_HDMIO_L_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[14]}]

set_property PACKAGE_PIN G20 [get_ports {IO_HDMIO_L_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_L_data[15]}]

set_property PACKAGE_PIN A21 [get_ports IO_HDMIO_L_spdif]
set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMIO_L_spdif]

# VITA interface
set_property PACKAGE_PIN P16 [get_ports IO_VITA_CAM_L_clk_pll]
set_property PACKAGE_PIN L19 [get_ports IO_VITA_CAM_L_reset_n]
set_property PACKAGE_PIN R16 [get_ports {IO_VITA_CAM_L_trigger[2]}]
set_property PACKAGE_PIN J16 [get_ports {IO_VITA_CAM_L_trigger[1]}]
set_property PACKAGE_PIN J17 [get_ports {IO_VITA_CAM_L_trigger[0]}]
set_property PACKAGE_PIN P20 [get_ports {IO_VITA_CAM_L_monitor[0]}]
set_property PACKAGE_PIN P21 [get_ports {IO_VITA_CAM_L_monitor[1]}]
set_property PACKAGE_PIN N22 [get_ports IO_VITA_SPI_L_spi_sclk]
set_property PACKAGE_PIN P22 [get_ports IO_VITA_SPI_L_spi_ssel_n]
set_property PACKAGE_PIN R20 [get_ports IO_VITA_SPI_L_spi_mosi]
set_property PACKAGE_PIN R21 [get_ports IO_VITA_SPI_L_spi_miso]
set_property PACKAGE_PIN K19 [get_ports IO_VITA_CAM_L_clk_out_p]
set_property PACKAGE_PIN K20 [get_ports IO_VITA_CAM_L_clk_out_n]
set_property PACKAGE_PIN L17 [get_ports IO_VITA_CAM_L_sync_p]
set_property PACKAGE_PIN M17 [get_ports IO_VITA_CAM_L_sync_n]
set_property PACKAGE_PIN M15 [get_ports {IO_VITA_CAM_L_data_p[0]}]
set_property PACKAGE_PIN M16 [get_ports {IO_VITA_CAM_L_data_n[0]}]
set_property PACKAGE_PIN J15 [get_ports {IO_VITA_CAM_L_data_p[1]}]
set_property PACKAGE_PIN K15 [get_ports {IO_VITA_CAM_L_data_n[1]}]
set_property PACKAGE_PIN J21 [get_ports {IO_VITA_CAM_L_data_p[2]}]
set_property PACKAGE_PIN J22 [get_ports {IO_VITA_CAM_L_data_n[2]}]
set_property PACKAGE_PIN N17 [get_ports {IO_VITA_CAM_L_data_p[3]}]
set_property PACKAGE_PIN N18 [get_ports {IO_VITA_CAM_L_data_n[3]}]
#set_property PACKAGE_PIN M21 [get_ports {IO_VITA_CAM_L_data_p[4]}];
#set_property PACKAGE_PIN M22 [get_ports {IO_VITA_CAM_L_data_n[4]}];
#set_property PACKAGE_PIN J18 [get_ports {IO_VITA_CAM_L_data_p[5]}];
#set_property PACKAGE_PIN K18 [get_ports {IO_VITA_CAM_L_data_n[5]}];
#set_property PACKAGE_PIN J20 [get_ports {IO_VITA_CAM_L_data_p[6]}];
#set_property PACKAGE_PIN K21 [get_ports {IO_VITA_CAM_L_data_n[6]}];
#set_property PACKAGE_PIN L21 [get_ports {IO_VITA_CAM_L_data_p[7]}];
#set_property PACKAGE_PIN L22 [get_ports {IO_VITA_CAM_L_data_n[7]}];


set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_L_clk_pll]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_L_reset_n]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_L_trigger*]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_L_monitor*]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_SPI_L_spi_*]

set_property IOSTANDARD LVDS_25 [get_ports IO_VITA_CAM_L_clk_out_*]
set_property IOSTANDARD LVDS_25 [get_ports IO_VITA_CAM_L_sync_*]
set_property IOSTANDARD LVDS_25 [get_ports IO_VITA_CAM_L_data_*]

set_property DIFF_TERM true [get_ports IO_VITA_CAM_L_clk_out_*]
set_property DIFF_TERM true [get_ports IO_VITA_CAM_L_sync_*]
set_property DIFF_TERM true [get_ports IO_VITA_CAM_L_data_*]


# Video Clock Synthesizer
set_property PACKAGE_PIN L18 [get_ports fmc_imageon_vclk_L]
set_property IOSTANDARD LVCMOS25 [get_ports fmc_imageon_vclk_L]

########################
# FMC2 Constraints     #
########################

# I2C Chain on FMC-IMAGEON
set_property PACKAGE_PIN AB14 [get_ports {fmc_imageon_iic_r_scl_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_r_scl_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_r_scl_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_r_scl_io}]

set_property PACKAGE_PIN AB15 [get_ports {fmc_imageon_iic_r_sda_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_r_sda_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_r_sda_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_r_sda_io}]

set_property PACKAGE_PIN Y16 [get_ports {fmc_imageon_iic_r_rst_n}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_r_rst_n}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_r_rst_n}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_r_rst_n}]


# HDMI Output (ADV7511) on FMC-IMAGEON 
set_property PACKAGE_PIN Y5 [get_ports IO_HDMIO_R_clk]
set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMIO_R_clk]

set_property PACKAGE_PIN AB12 [get_ports {IO_HDMIO_R_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[0]}]

set_property PACKAGE_PIN AA12 [get_ports {IO_HDMIO_R_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[1]}]

set_property PACKAGE_PIN V4 [get_ports {IO_HDMIO_R_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[2]}]

set_property PACKAGE_PIN W12 [get_ports {IO_HDMIO_R_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[3]}]

set_property PACKAGE_PIN V5 [get_ports {IO_HDMIO_R_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[4]}]

set_property PACKAGE_PIN U9 [get_ports {IO_HDMIO_R_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[5]}]

set_property PACKAGE_PIN AA8 [get_ports {IO_HDMIO_R_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[6]}]

set_property PACKAGE_PIN V12 [get_ports {IO_HDMIO_R_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[7]}]

set_property PACKAGE_PIN U10 [get_ports {IO_HDMIO_R_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[8]}]

set_property PACKAGE_PIN T6 [get_ports {IO_HDMIO_R_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[9]}]

set_property PACKAGE_PIN AA9 [get_ports {IO_HDMIO_R_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[10]}]

set_property PACKAGE_PIN AA6 [get_ports {IO_HDMIO_R_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[11]}]

set_property PACKAGE_PIN R6 [get_ports {IO_HDMIO_R_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[12]}]

set_property PACKAGE_PIN U4 [get_ports {IO_HDMIO_R_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[13]}]

set_property PACKAGE_PIN AA7 [get_ports {IO_HDMIO_R_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[14]}]

set_property PACKAGE_PIN T4 [get_ports {IO_HDMIO_R_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMIO_R_data[15]}]

set_property PACKAGE_PIN U6 [get_ports IO_HDMIO_R_spdif]
set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMIO_R_spdif]

# VITA interface
set_property PACKAGE_PIN V22 [get_ports IO_VITA_CAM_R_clk_pll]
set_property PACKAGE_PIN AA18 [get_ports IO_VITA_CAM_R_reset_n]
set_property PACKAGE_PIN W22 [get_ports {IO_VITA_CAM_R_trigger[2]}]
set_property PACKAGE_PIN T22 [get_ports {IO_VITA_CAM_R_trigger[1]}]
set_property PACKAGE_PIN U22 [get_ports {IO_VITA_CAM_R_trigger[0]}]
set_property PACKAGE_PIN Y13 [get_ports {IO_VITA_CAM_R_monitor[0]}]
set_property PACKAGE_PIN AA13 [get_ports {IO_VITA_CAM_R_monitor[1]}]
set_property PACKAGE_PIN W15 [get_ports IO_VITA_SPI_R_spi_sclk]
set_property PACKAGE_PIN Y15 [get_ports IO_VITA_SPI_R_spi_ssel_n]
set_property PACKAGE_PIN Y14 [get_ports IO_VITA_SPI_R_spi_mosi]
set_property PACKAGE_PIN AA14 [get_ports IO_VITA_SPI_R_spi_miso]
set_property PACKAGE_PIN Y19 [get_ports IO_VITA_CAM_R_clk_out_p]
set_property PACKAGE_PIN AA19 [get_ports IO_VITA_CAM_R_clk_out_n]
set_property PACKAGE_PIN Y20 [get_ports IO_VITA_CAM_R_sync_p]
set_property PACKAGE_PIN Y21 [get_ports IO_VITA_CAM_R_sync_n]
set_property PACKAGE_PIN U15 [get_ports {IO_VITA_CAM_R_data_p[0]}]
set_property PACKAGE_PIN U16 [get_ports {IO_VITA_CAM_R_data_n[0]}]
set_property PACKAGE_PIN T21 [get_ports {IO_VITA_CAM_R_data_p[1]}]
set_property PACKAGE_PIN U21 [get_ports {IO_VITA_CAM_R_data_n[1]}]
set_property PACKAGE_PIN AA17 [get_ports {IO_VITA_CAM_R_data_p[2]}]
set_property PACKAGE_PIN AB17 [get_ports {IO_VITA_CAM_R_data_n[2]}]
set_property PACKAGE_PIN AB19 [get_ports {IO_VITA_CAM_R_data_p[3]}]
set_property PACKAGE_PIN AB20 [get_ports {IO_VITA_CAM_R_data_n[3]}]
#set_property PACKAGE_PIN V13 [get_ports {IO_VITA_CAM_R_data_p[4]}];
#set_property PACKAGE_PIN W13 [get_ports {IO_VITA_CAM_R_data_n[4]}];
#set_property PACKAGE_PIN U17 [get_ports {IO_VITA_CAM_R_data_p[5]}];
#set_property PACKAGE_PIN V17 [get_ports {IO_VITA_CAM_R_data_n[5]}];
#set_property PACKAGE_PIN AA16 [get_ports {IO_VITA_CAM_R_data_p[6]}];
#set_property PACKAGE_PIN AB16 [get_ports {IO_VITA_CAM_R_data_n[6]}];
#set_property PACKAGE_PIN V14 [get_ports {IO_VITA_CAM_R_data_p[7]}];
#set_property PACKAGE_PIN V15 [get_ports {IO_VITA_CAM_R_data_n[7]}];

set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_R_clk_pll]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_R_reset_n]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_R_trigger*]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_CAM_R_monitor*]
set_property IOSTANDARD LVCMOS25 [get_ports IO_VITA_SPI_R_spi_*]

set_property IOSTANDARD LVDS_25 [get_ports IO_VITA_CAM_R_clk_out_*]
set_property IOSTANDARD LVDS_25 [get_ports IO_VITA_CAM_R_sync_*]
set_property IOSTANDARD LVDS_25 [get_ports IO_VITA_CAM_R_data_*]

set_property DIFF_TERM true [get_ports IO_VITA_CAM_R_clk_out_*]
set_property DIFF_TERM true [get_ports IO_VITA_CAM_R_sync_*]
set_property DIFF_TERM true [get_ports IO_VITA_CAM_R_data_*]

# Video Clock Synthesizer
set_property PACKAGE_PIN Y18 [get_ports fmc_imageon_vclk_R]
set_property IOSTANDARD LVCMOS25 [get_ports fmc_imageon_vclk_R]

##################
# IDELAYCTRL     #
##################
set_property LOC IDELAYCTRL_X1Y1 [get_cells {fmc_imageon_gs_i/onsemi_vita_cam_0/U0/onsemi_vita_cam_v3_1_S00_AXI_inst/onsemi_vita_cam_core_inst/vita_iserdes_v5.vita_iserdes/generate_idelay.serdesidelayrefclk/IDELAYCTRL_INST[0].u_idelayctrl}]
set_property LOC IDELAYCTRL_X1Y0 [get_cells {fmc_imageon_gs_i/onsemi_vita_cam_1/U0/onsemi_vita_cam_v3_1_S00_AXI_inst/onsemi_vita_cam_core_inst/vita_iserdes_v5.vita_iserdes/generate_idelay.serdesidelayrefclk/IDELAYCTRL_INST[0].u_idelayctrl}]

##################
# Primary Clocks #
##################
create_clock -period 22.000 -name clk_fpga_0 [get_nets -hierarchical FCLK_CLK0]
create_clock -period 7.730 -name clk_fpga_1 [get_nets -hierarchical FCLK_CLK1]
create_clock -period 5.000 -name clk_fpga_2 [get_nets -hierarchical FCLK_CLK2]
create_clock -period 7.730 -name fmc_imageon_vclk_L [get_ports fmc_imageon_vclk_L]
create_clock -period 3.692 -name fmc_vita_ser_clk_L [get_ports IO_VITA_CAM_L_clk_out_p]
create_clock -period 7.730 -name fmc_imageon_vclk_R [get_ports fmc_imageon_vclk_R]
create_clock -period 3.692 -name fmc_vita_ser_clk_R [get_ports IO_VITA_CAM_R_clk_out_p]

#create_clock -period 26.000 -name clk_fpga_0 [get_nets -hierarchical FCLK_CLK0]
#create_clock -period 12.730 -name clk_fpga_1 [get_nets -hierarchical FCLK_CLK1]
#create_clock -period 5.000 -name clk_fpga_2 [get_nets -hierarchical FCLK_CLK2]
#create_clock -period 15.730 -name fmc_imageon_vclk_L [get_ports fmc_imageon_vclk_L]
#create_clock -period 8.692 -name fmc_vita_ser_clk_L [get_ports IO_VITA_CAM_L_clk_out_p]
#create_clock -period 15.730 -name fmc_imageon_vclk_R [get_ports fmc_imageon_vclk_R]
#create_clock -period 8.692 -name fmc_vita_ser_clk_R [get_ports IO_VITA_CAM_R_clk_out_p]

set_clock_groups -asynchronous -group [get_clocks "clk_fpga_0 clk_fpga_1 clk_fpga_2" ]  -group [get_clocks -include_generated_clocks "fmc_imageon_vclk_L fmc_vita_ser_clk_L" ] -group [get_clocks -include_generated_clocks "fmc_imageon_vclk_R fmc_vita_ser_clk_R" ]

