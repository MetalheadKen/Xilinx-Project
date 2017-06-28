
  set video_clk   [get_clocks -of [get_ports aclk]]
  set axilite_clk [get_clocks -of [get_ports s_axi_aclk]]

  set_max_delay -from $video_clk -to [get_cells -hierarchical -filter {NAME =~ *U_VIDEO_CTRL*/*SYNC2PROCCLK_I*/data_sync_reg[0]*}] -datapath_only [get_property -min PERIOD $video_clk]
  set_max_delay -from $axilite_clk -to [get_cells -hierarchical -filter {NAME =~ *U_VIDEO_CTRL*/*SYNC2VIDCLK_I*/data_sync_reg[0]*}] -datapath_only [get_property -min PERIOD $axilite_clk]


