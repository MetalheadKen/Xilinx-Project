# Hierarchical cell: fmc_imageon_hdmio_yuv422
proc create_hier_cell_fmc_imageon_hdmio_yuv422 { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_fmc_imageon_hdmio_yuv422() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 hdmio_axi4s_video
  create_bd_intf_pin -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 hdmio_io
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:video_timing_rtl:2.0 video_vtiming
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 vtc_ctrl

  # Create pins
  create_bd_pin -dir I axi4lite_aresetn
  create_bd_pin -dir I axi4lite_clk
  create_bd_pin -dir I -type clk axi4s_clk
  create_bd_pin -dir I hdmio_audio_spdif
  create_bd_pin -dir I hdmio_clk

  # Create instance: fmc_imageon_hdmi_out_0, and set properties
  set fmc_imageon_hdmi_out_0 [ create_bd_cell -type ip -vlnv avnet:fmc_imageon:fmc_imageon_hdmi_out:2.0 fmc_imageon_hdmi_out_0 ]

  # Create instance: gnd, and set properties
  set gnd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.0 gnd ]
  set_property -dict [ list CONFIG.CONST_VAL {0}  ] $gnd

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:3.0 v_axi4s_vid_out_0 ]

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.0 v_tc_0 ]
  set_property -dict [ list CONFIG.VIDEO_MODE {1080p} CONFIG.auto_generation_mode {true} CONFIG.horizontal_sync_detection {false} CONFIG.vertical_sync_detection {false}  ] $v_tc_0

  # Create instance: vcc, and set properties
  set vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.0 vcc ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins vtc_ctrl] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net fmc_imageon_hdmi_out_0_io_hdmio [get_bd_intf_pins hdmio_io] [get_bd_intf_pins fmc_imageon_hdmi_out_0/IO_HDMIO]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins fmc_imageon_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins hdmio_axi4s_video] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
  connect_bd_intf_net -intf_net video_vtiming_1 [get_bd_intf_pins video_vtiming] [get_bd_intf_pins v_tc_0/vtiming_in]

  # Create port connections
  connect_bd_net -net axi4lite_aresetn_1 [get_bd_pins axi4lite_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net axi4lite_clk_1 [get_bd_pins axi4lite_clk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net axi4s_clk_1 [get_bd_pins axi4s_clk] [get_bd_pins v_axi4s_vid_out_0/aclk]
  connect_bd_net -net gnd_const [get_bd_pins fmc_imageon_hdmi_out_0/reset] [get_bd_pins gnd/const] [get_bd_pins v_axi4s_vid_out_0/rst]
  connect_bd_net -net hdmio_audio_spdif_1 [get_bd_pins hdmio_audio_spdif] [get_bd_pins fmc_imageon_hdmi_out_0/audio_spdif]
  connect_bd_net -net hdmio_clk_1 [get_bd_pins hdmio_clk] [get_bd_pins fmc_imageon_hdmi_out_0/clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net vcc_const [get_bd_pins fmc_imageon_hdmi_out_0/embed_syncs] [get_bd_pins fmc_imageon_hdmi_out_0/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/det_clken] [get_bd_pins v_tc_0/resetn] [get_bd_pins v_tc_0/s_axi_aclken] [get_bd_pins vcc/const]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

#####################################################
# Main Flow
#####################################################

# Create instance: fmc_imageon_hdmio_yuv422
create_hier_cell_fmc_imageon_hdmio_yuv422 [current_bd_instance .] fmc_imageon_hdmio_yuv422