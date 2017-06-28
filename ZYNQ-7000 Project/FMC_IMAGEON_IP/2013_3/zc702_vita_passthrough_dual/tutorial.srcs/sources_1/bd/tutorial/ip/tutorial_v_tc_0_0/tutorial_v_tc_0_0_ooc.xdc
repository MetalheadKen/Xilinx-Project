
# This constraints file contains default clock frequencies to be used during out-of-context flows such as
# OOC Synthesis and Hierarchical Designs. For best results the frequencies should be modified
# to match the target frequencies. 
# This constraints file is not used in normal top-down synthesis (the default flow of Vivado)
create_clock -name clk -period 13.468 [get_ports clk] 

create_clock -name s_axi_aclk -period 10 [get_ports s_axi_aclk] 

