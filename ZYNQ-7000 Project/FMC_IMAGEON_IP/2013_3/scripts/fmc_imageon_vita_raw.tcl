# Hierarchical cell: fmc_imageon_vita_raw
proc create_hier_cell_fmc_imageon_vita_raw { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_fmc_imageon_vita_raw() - Empty argument(s)!"
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 vita_axi4s_video
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 vita_ctrl
  create_bd_intf_pin -mode Slave -vlnv avnet.com:interface:avnet_vita_rtl:1.0 vita_io
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:video_timing_rtl:2.0 vita_vtiming

  # Create pins
  create_bd_pin -dir I -type rst axi4lite_aresetn
  create_bd_pin -dir I -type clk axi4lite_clk
  create_bd_pin -dir I -type clk axi4s_clk
  create_bd_pin -dir I clk200
  create_bd_pin -dir I vita_clk

  # Create instance: fmc_imageon_vita_receiver_0, and set properties
  set fmc_imageon_vita_receiver_0 [ create_bd_cell -type ip -vlnv avnet:fmc_imageon:fmc_imageon_vita_receiver:2.2 fmc_imageon_vita_receiver_0 ]
  set_property -dict [ list CONFIG.C_DEBUG_PORT {false} CONFIG.C_VIDEO_DATA_WIDTH {8}  ] $fmc_imageon_vita_receiver_0

  # Create instance: gnd, and set properties
  set gnd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.0 gnd ]
  set_property -dict [ list CONFIG.CONST_VAL {0}  ] $gnd

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:3.0 v_vid_in_axi4s_0 ]
  set_property -dict [ list CONFIG.C_M_AXIS_VIDEO_FORMAT {12}  ] $v_vid_in_axi4s_0

  # Create instance: vcc, and set properties
  set vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.0 vcc ]

  # Create interface connections
  connect_bd_intf_net -intf_net fmc_imageon_vita_receiver_0_vid_io_out [get_bd_intf_pins fmc_imageon_vita_receiver_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_0/vid_io_in]
  connect_bd_intf_net -intf_net io_vita_1 [get_bd_intf_pins vita_io] [get_bd_intf_pins fmc_imageon_vita_receiver_0/IO_VITA]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_m01_axi [get_bd_intf_pins vita_ctrl] [get_bd_intf_pins fmc_imageon_vita_receiver_0/S00_AXI]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins vita_axi4s_video] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_vtiming_out [get_bd_intf_pins vita_vtiming] [get_bd_intf_pins v_vid_in_axi4s_0/vtiming_out]

  # Create port connections
  connect_bd_net -net clk_fpga_0 [get_bd_pins axi4lite_clk] [get_bd_pins fmc_imageon_vita_receiver_0/s00_axi_aclk]
  connect_bd_net -net clk_fpga_1 [get_bd_pins clk200] [get_bd_pins fmc_imageon_vita_receiver_0/clk200]
  connect_bd_net -net clk_fpga_2 [get_bd_pins axi4s_clk] [get_bd_pins v_vid_in_axi4s_0/aclk]
  connect_bd_net -net gnd_const [get_bd_pins fmc_imageon_vita_receiver_0/reset] [get_bd_pins fmc_imageon_vita_receiver_0/trigger1] [get_bd_pins gnd/const] [get_bd_pins v_vid_in_axi4s_0/rst]
  connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins axi4lite_aresetn] [get_bd_pins fmc_imageon_vita_receiver_0/s00_axi_aresetn]
  connect_bd_net -net vcc_const [get_bd_pins fmc_imageon_vita_receiver_0/oe] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/aresetn] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins vcc/const]
  connect_bd_net -net video_clk_div4 [get_bd_pins vita_clk] [get_bd_pins fmc_imageon_vita_receiver_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


#####################################################
# Main Flow
#####################################################

# Create instance: fmc_imageon_vita_raw
create_hier_cell_fmc_imageon_vita_raw [current_bd_instance .] fmc_imageon_vita_raw