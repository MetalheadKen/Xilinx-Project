
# This constraints file contains default clock frequencies to be used during out-of-context flows such as
# OOC Synthesis and Hierarchical Designs. For best results the frequencies should be modified# to match the target frequencies. 
# This constraints file is not used in normal top-down synthesis (the default flow of Vivado)
# Create clock commands for top level.  
create_clock -add -name vid_io_out_clk -period 6.666 [get_ports vid_io_out_clk]
create_clock -add -name aclk -period 6.666 [get_ports aclk]
