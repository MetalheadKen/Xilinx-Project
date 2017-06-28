
  set video_clk   [get_clocks -of [get_ports clk]]
  set axilite_clk [get_clocks -of [get_ports s_axi_aclk]]


  set_max_delay -from $video_clk -to [all_registers -clock $axilite_clk] -datapath_only [expr min([join [get_property PERIOD $video_clk] ,])]
  set_max_delay -from $axilite_clk -to [all_registers -clock $video_clk] -datapath_only [expr min([join [get_property PERIOD $axilite_clk] ,])]


