##################
# Primary Clocks #
##################

# Differential input clock coming from external oscillator
# Constrained to 100
create_clock -period 10.000 -name sys_diff_clock_clk [get_ports sys_diff_clock_clk_p]

# Differential input clock coming from external video source via FMC-IMAGEON
# Constrained to (148.5MHz / 4) * 10
create_clock -period 2.692 -name fmc_imageon_vita_clk [get_ports vita_io_clk_out_p]


########################
# Physical Constraints #
########################

# 100MHz Oscillator on KC705
set_property PACKAGE_PIN AD12 [get_ports sys_diff_clock_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_diff_clock_clk_p]

set_property PACKAGE_PIN AD11 [get_ports sys_diff_clock_clk_n]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_diff_clock_clk_n]

# RESET on KC705
set_property PACKAGE_PIN AB7  [get_ports {reset}]
set_property IOSTANDARD LVCMOS15 [get_ports {reset}]

# UART on KC705
set_property PACKAGE_PIN M19 [get_ports {RS232_Uart_rxd}]
set_property IOSTANDARD LVCMOS25 [get_ports {RS232_Uart_rxd}]

set_property PACKAGE_PIN K24 [get_ports {RS232_Uart_txd}]
set_property IOSTANDARD LVCMOS25 [get_ports {RS232_Uart_txd}]

# LEDs on KC705
set_property PACKAGE_PIN AB8  [get_ports {LED_8Bits_tri_o[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {LED_8Bits_tri_o[0]}]

set_property PACKAGE_PIN AA8  [get_ports {LED_8Bits_tri_o[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {LED_8Bits_tri_o[1]}]

set_property PACKAGE_PIN AC9  [get_ports {LED_8Bits_tri_o[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {LED_8Bits_tri_o[2]}]

set_property PACKAGE_PIN AB9  [get_ports {LED_8Bits_tri_o[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {LED_8Bits_tri_o[3]}]

set_property PACKAGE_PIN AE26  [get_ports {LED_8Bits_tri_o[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED_8Bits_tri_o[4]}]

set_property PACKAGE_PIN G19  [get_ports {LED_8Bits_tri_o[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED_8Bits_tri_o[5]}]

set_property PACKAGE_PIN E18  [get_ports {LED_8Bits_tri_o[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED_8Bits_tri_o[6]}]

set_property PACKAGE_PIN F16  [get_ports {LED_8Bits_tri_o[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED_8Bits_tri_o[7]}]


# I2C Chain on KC705
#set_property PACKAGE_PIN K21 [get_ports {IIC_MAIN_scl_io}]
#set_property IOSTANDARD LVCMOS25 [get_ports {IIC_MAIN_scl_io}]
#set_property SLEW SLOW [get_ports {IIC_MAIN_scl_io}]
#set_property DRIVE 8 [get_ports {IIC_MAIN_scl_io}]
#
#set_property PACKAGE_PIN L21 [get_ports {IIC_MAIN_sda_io}]
#set_property IOSTANDARD LVCMOS25 [get_ports {IIC_MAIN_sda_io}]
#set_property SLEW SLOW [get_ports {IIC_MAIN_sda_io}]
#set_property DRIVE 8 [get_ports {IIC_MAIN_sda_io}]

# I2C Chain on FMC-IMAGEON
set_property PACKAGE_PIN AC22 [get_ports {fmc_imageon_iic_scl_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_scl_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_scl_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_scl_io}]

set_property PACKAGE_PIN AD22 [get_ports {fmc_imageon_iic_sda_io}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_sda_io}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_sda_io}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_sda_io}]

set_property PACKAGE_PIN AF23 [get_ports {fmc_imageon_iic_rst_n}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_imageon_iic_rst_n}]
set_property SLEW SLOW [get_ports {fmc_imageon_iic_rst_n}]
set_property DRIVE 8 [get_ports {fmc_imageon_iic_rst_n}]

# HDMI output (ADV7511) on FMC-IMAGEON
set_property PACKAGE_PIN AH29 [get_ports hdmio_io_clk]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_io_clk]

set_property PACKAGE_PIN AD26  [get_ports {hdmio_io_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[0]}]

set_property PACKAGE_PIN AC26  [get_ports {hdmio_io_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[1]}]

set_property PACKAGE_PIN AG28 [get_ports {hdmio_io_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[2]}]

set_property PACKAGE_PIN AH27  [get_ports {hdmio_io_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[3]}]

set_property PACKAGE_PIN AG27  [get_ports {hdmio_io_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[4]}]

set_property PACKAGE_PIN AK28 [get_ports {hdmio_io_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[5]}]

set_property PACKAGE_PIN AD28  [get_ports {hdmio_io_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[6]}]

set_property PACKAGE_PIN AH26  [get_ports {hdmio_io_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[7]}]

set_property PACKAGE_PIN AJ27  [get_ports {hdmio_io_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[8]}]

set_property PACKAGE_PIN AK26   [get_ports {hdmio_io_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[9]}]

set_property PACKAGE_PIN AD27  [get_ports {hdmio_io_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[10]}]

set_property PACKAGE_PIN AC27  [get_ports {hdmio_io_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[11]}]

set_property PACKAGE_PIN AJ26  [get_ports {hdmio_io_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[12]}]

set_property PACKAGE_PIN AF27  [get_ports {hdmio_io_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[13]}]

set_property PACKAGE_PIN AB27  [get_ports {hdmio_io_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[14]}]

set_property PACKAGE_PIN AF26 [get_ports {hdmio_io_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_io_data[15]}]

set_property PACKAGE_PIN AG30 [get_ports hdmio_io_spdif]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_io_spdif]

# VITA interface
set_property PACKAGE_PIN AB24 [get_ports vita_io_clk_pll];
set_property PACKAGE_PIN AG23 [get_ports vita_io_reset_n];
set_property PACKAGE_PIN AC25 [get_ports {vita_io_trigger[2]}];
set_property PACKAGE_PIN AD21 [get_ports {vita_io_trigger[1]}];
set_property PACKAGE_PIN AE21 [get_ports {vita_io_trigger[0]}];
set_property PACKAGE_PIN AC24 [get_ports {vita_io_monitor[0]}];
set_property PACKAGE_PIN AD24 [get_ports {vita_io_monitor[1]}];
set_property PACKAGE_PIN AA20 [get_ports vita_io_spi_sclk];
set_property PACKAGE_PIN AB20 [get_ports vita_io_spi_ssel_n];
set_property PACKAGE_PIN AE25 [get_ports vita_io_spi_mosi];
set_property PACKAGE_PIN AF25 [get_ports vita_io_spi_miso];
set_property PACKAGE_PIN AD23 [get_ports vita_io_clk_out_p];
set_property PACKAGE_PIN AE24 [get_ports vita_io_clk_out_n];
set_property PACKAGE_PIN AJ24 [get_ports vita_io_sync_p];
set_property PACKAGE_PIN AK25 [get_ports vita_io_sync_n];
set_property PACKAGE_PIN AK23 [get_ports {vita_io_data_p[0]}];
set_property PACKAGE_PIN AK24 [get_ports {vita_io_data_n[0]}];
set_property PACKAGE_PIN AG25 [get_ports {vita_io_data_p[1]}];
set_property PACKAGE_PIN AH25 [get_ports {vita_io_data_n[1]}];
set_property PACKAGE_PIN AJ22 [get_ports {vita_io_data_p[2]}];
set_property PACKAGE_PIN AJ23 [get_ports {vita_io_data_n[2]}];
set_property PACKAGE_PIN AG22 [get_ports {vita_io_data_p[3]}];
set_property PACKAGE_PIN AH22 [get_ports {vita_io_data_n[3]}];
#set_property PACKAGE_PIN AH21 [get_ports {vita_io_data_p[4]}];
#set_property PACKAGE_PIN AJ21 [get_ports {vita_io_data_n[4]}];
#set_property PACKAGE_PIN AK20 [get_ports {vita_io_data_p[5]}];
#set_property PACKAGE_PIN AK21 [get_ports {vita_io_data_n[5]}];
#set_property PACKAGE_PIN AG20 [get_ports {vita_io_data_p[6]}];
#set_property PACKAGE_PIN AH20 [get_ports {vita_io_data_n[6]}];
#set_property PACKAGE_PIN AF20 [get_ports {vita_io_data_p[7]}];
#set_property PACKAGE_PIN AF21 [get_ports {vita_io_data_n[7]}];

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
set_property PACKAGE_PIN AF22 [get_ports vita_clk]
set_property IOSTANDARD LVCMOS25 [get_ports vita_clk]
