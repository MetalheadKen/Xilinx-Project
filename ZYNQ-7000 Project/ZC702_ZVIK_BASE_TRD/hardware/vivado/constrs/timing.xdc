##################
# Primary Clocks #
##################

# Differential input clock from SI570 clock synthesizer
# Constrained to 148.5MHz (1080p60 video resolution)
create_clock -period 6.734 -name si570_clk [get_ports si570_clk_p]

# Single-ended input clock from HDMI input
# Constrained to 148.5MHz (1080p60 video resolution)
create_clock -period 6.734 -name hdmii_clk [get_ports fmc_imageon_hdmii_clk]

####################
# Generated Clocks #
####################

# Rename auto-generated clocks from clk_wiz_1
# Axi-lite clock 50MHz
create_generated_clock -name clk50 [get_pins */clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]
# AXI Stream and MemoryMap clock 150Mhz
create_generated_clock -name clk150 [get_pins */clk_wiz_1/inst/mmcm_adv_inst/CLKOUT1]

################
# Clock Groups #
################

# There is no defined phase relationship, hence they are treated as asynchronous
set_clock_groups -asynchronous -group clk50 \
                               -group clk150 \
                               -group si570_clk \
                               -group hdmii_clk
