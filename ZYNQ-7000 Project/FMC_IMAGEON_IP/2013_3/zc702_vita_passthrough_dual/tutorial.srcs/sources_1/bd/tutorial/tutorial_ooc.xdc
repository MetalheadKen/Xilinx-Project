################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
#create_clock -name clock_name -period 10 [get_ports clock_name]
################################################################################
create_clock -name fmc1_vita_io_clk_out_n -period 10 [get_ports fmc1_vita_io_clk_out_n]
create_clock -name fmc1_vita_io_clk_out_p -period 10 [get_ports fmc1_vita_io_clk_out_p]
create_clock -name fmc2_vita_io_clk_out_n -period 10 [get_ports fmc2_vita_io_clk_out_n]
create_clock -name fmc2_vita_io_clk_out_p -period 10 [get_ports fmc2_vita_io_clk_out_p]
create_clock -name FCLK_CLK0 -period 20 [get_ports FCLK_CLK0]
create_clock -name FCLK_CLK1 -period 7 [get_ports FCLK_CLK1]
create_clock -name FCLK_CLK2 -period 5 [get_ports FCLK_CLK2]

################################################################################