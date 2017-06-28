
################################################################
# This is a generated script based on design: system_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_top_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART xilinx.com:zc702:part0:1.0 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
#    set design_name system_top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: tpg_input
proc create_hier_cell_tpg_input { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_tpg_input() - Empty argument(s)!"
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ctrl
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ctrl1

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 ap_rst_n
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn
  create_bd_pin -dir I -from 0 -to 0 -type clk clk
  create_bd_pin -dir I -type clk m_axi_s2mm_aclk
  create_bd_pin -dir O s2mm_fsync_out
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I -type clk s_axi_aclk

  # Create instance: axi_vdma_3, and set properties
  set axi_vdma_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_3 ]
  set_property -dict [ list \
CONFIG.c_enable_debug_info_11 {1} \
CONFIG.c_enable_debug_info_15 {1} \
CONFIG.c_include_mm2s {0} \
CONFIG.c_include_s2mm_dre {0} \
CONFIG.c_include_s2mm_sf {0} \
CONFIG.c_m_axi_s2mm_data_width {32} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {2} \
CONFIG.c_s2mm_linebuffer_depth {4096} \
CONFIG.c_s2mm_max_burst_length {16} \
CONFIG.c_s2mm_sof_enable {1} \
 ] $axi_vdma_3

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
CONFIG.M_TDATA_NUM_BYTES {2} \
CONFIG.S_TDATA_NUM_BYTES {3} \
CONFIG.TDATA_REMAP {tdata[15:0]} \
 ] $axis_subset_converter_0

  # Create instance: v_tc_1, and set properties
  set v_tc_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_1 ]
  set_property -dict [ list \
CONFIG.VIDEO_MODE {1080p} \
CONFIG.enable_detection {false} \
CONFIG.horizontal_sync_detection {true} \
CONFIG.vertical_blank_generation {true} \
CONFIG.vertical_sync_detection {true} \
 ] $v_tc_1

  # Create instance: v_tpg_1, and set properties
  set v_tpg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:7.0 v_tpg_1 ]
  set_property -dict [ list \
CONFIG.HAS_AXI4S_SLAVE {1} \
CONFIG.MAX_COLS {1920} \
CONFIG.MAX_ROWS {1080} \
 ] $v_tpg_1

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_0 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {5} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {2} \
 ] $v_vid_in_axi4s_0

  # Create instance: zero_24bit, and set properties
  set zero_24bit [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 zero_24bit ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {24} \
 ] $zero_24bit

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_3/S_AXI_LITE]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_vdma_3/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M00_AXI [get_bd_intf_pins ctrl1] [get_bd_intf_pins v_tc_1/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M04_AXI [get_bd_intf_pins ctrl] [get_bd_intf_pins v_tpg_1/s_axi_CTRL]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axi_vdma_3/S_AXIS_S2MM] [get_bd_intf_pins axis_subset_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net v_tpg_1_m_axis_video [get_bd_intf_pins axis_subset_converter_0/S_AXIS] [get_bd_intf_pins v_tpg_1/m_axis_video]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_tpg_1/s_axis_video] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]

  # Create port connections
  connect_bd_net -net ap_rst_n_1 [get_bd_pins ap_rst_n] [get_bd_pins v_tpg_1/ap_rst_n]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_subset_converter_0/aresetn]
  connect_bd_net -net axi_vdma_3_s2mm_fsync_out [get_bd_pins s2mm_fsync_out] [get_bd_pins axi_vdma_3/s2mm_fsync_out]
  connect_bd_net -net axi_vdma_3_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_vdma_3/s2mm_introut]
  connect_bd_net -net clk_50mhz [get_bd_pins s_axi_aclk] [get_bd_pins axi_vdma_3/s_axi_lite_aclk] [get_bd_pins v_tc_1/s_axi_aclk]
  connect_bd_net -net fmc_hdmi_input_clk_out [get_bd_pins clk] [get_bd_pins v_tc_1/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net m_axi_s2mm_aclk_1 [get_bd_pins m_axi_s2mm_aclk] [get_bd_pins axi_vdma_3/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_3/s_axis_s2mm_aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins v_tpg_1/ap_clk] [get_bd_pins v_vid_in_axi4s_0/aclk]
  connect_bd_net -net v_tc_1_active_video_out [get_bd_pins v_tc_1/active_video_out] [get_bd_pins v_vid_in_axi4s_0/vid_active_video]
  connect_bd_net -net v_tc_1_hblank_out [get_bd_pins v_tc_1/hblank_out] [get_bd_pins v_vid_in_axi4s_0/vid_hblank]
  connect_bd_net -net v_tc_1_hsync_out [get_bd_pins v_tc_1/hsync_out] [get_bd_pins v_vid_in_axi4s_0/vid_hsync]
  connect_bd_net -net v_tc_1_vblank_out [get_bd_pins v_tc_1/vblank_out] [get_bd_pins v_vid_in_axi4s_0/vid_vblank]
  connect_bd_net -net v_tc_1_vsync_out [get_bd_pins v_tc_1/vsync_out] [get_bd_pins v_vid_in_axi4s_0/vid_vsync]
  connect_bd_net -net zero_24bit_dout [get_bd_pins v_vid_in_axi4s_0/vid_data] [get_bd_pins zero_24bit/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: si570_clk
proc create_hier_cell_si570_clk { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_si570_clk() - Empty argument(s)!"
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN_D

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 BUFG_O

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0 ]

  # Create instance: util_ds_buf_1, and set properties
  set util_ds_buf_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_1 ]
  set_property -dict [ list \
CONFIG.C_BUF_TYPE {BUFG} \
 ] $util_ds_buf_1

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins CLK_IN_D] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]

  # Create port connections
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins util_ds_buf_1/BUFG_I]
  connect_bd_net -net video_clk_1 [get_bd_pins BUFG_O] [get_bd_pins util_ds_buf_1/BUFG_O]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: processing
proc create_hier_cell_processing { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_processing() - Empty argument(s)!"
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CONTROL_BUS
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst ap_rst_axilite_clk
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn
  create_bd_pin -dir I -from 0 -to 0 fsync_sel
  create_bd_pin -dir I hdmi_rx_fsync
  create_bd_pin -dir O -type intr mm2s_introut
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I -type clk s_axi_lite_aclk
  create_bd_pin -dir I tpg_fsync

  # Create instance: axi_vdma_2, and set properties
  set axi_vdma_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_2 ]
  set_property -dict [ list \
CONFIG.c_enable_debug_info_7 {1} \
CONFIG.c_enable_debug_info_15 {1} \
CONFIG.c_m_axi_mm2s_data_width {32} \
CONFIG.c_m_axi_s2mm_data_width {32} \
CONFIG.c_m_axis_mm2s_tdata_width {16} \
CONFIG.c_mm2s_genlock_mode {3} \
CONFIG.c_mm2s_linebuffer_depth {4096} \
CONFIG.c_mm2s_max_burst_length {16} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {2} \
CONFIG.c_s2mm_linebuffer_depth {4096} \
CONFIG.c_s2mm_max_burst_length {16} \
CONFIG.c_use_mm2s_fsync {1} \
CONFIG.c_use_s2mm_fsync {2} \
 ] $axi_vdma_2

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: axis_register_slice_1, and set properties
  set axis_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_1 ]

  # Create instance: fsync_mux, and set properties
  set fsync_mux [ create_bd_cell -type ip -vlnv xilinx.com:xup:xup_2_to_1_mux:1.0 fsync_mux ]
  set_property -dict [ list \
CONFIG.DELAY {0} \
 ] $fsync_mux

  # Create instance: image_filter_1, and set properties
  set image_filter_1 [ create_bd_cell -type ip -vlnv xilinx.com:hls:image_filter:1.0 image_filter_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_vdma_2/M_AXI_MM2S]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_vdma_2/M_AXI_S2MM]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_2/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M06_AXI [get_bd_intf_pins S_AXI_CONTROL_BUS] [get_bd_intf_pins image_filter_1/s_axi_CONTROL_BUS]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_2/M_AXIS_MM2S] [get_bd_intf_pins axis_register_slice_1/S_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins axi_vdma_2/S_AXIS_S2MM] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_1_M_AXIS [get_bd_intf_pins axis_register_slice_1/M_AXIS] [get_bd_intf_pins image_filter_1/video_in]
  connect_bd_intf_net -intf_net image_filter_1_OUTPUT_STREAM [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins image_filter_1/video_out]

  # Create port connections
  connect_bd_net -net a_1 [get_bd_pins hdmi_rx_fsync] [get_bd_pins fsync_mux/a]
  connect_bd_net -net ap_rst_axilite_clk_1 [get_bd_pins ap_rst_axilite_clk] [get_bd_pins image_filter_1/ap_rst_n_axilite_clk]
  connect_bd_net -net axi_vdma_2_mm2s_introut [get_bd_pins mm2s_introut] [get_bd_pins axi_vdma_2/mm2s_introut]
  connect_bd_net -net axi_vdma_2_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_vdma_2/s2mm_introut]
  connect_bd_net -net clk_150mhz [get_bd_pins aclk] [get_bd_pins axi_vdma_2/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_2/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_2/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_2/s_axis_s2mm_aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins axis_register_slice_1/aclk] [get_bd_pins image_filter_1/ap_clk]
  connect_bd_net -net fsync_mux_y [get_bd_pins axi_vdma_2/mm2s_fsync] [get_bd_pins fsync_mux/y]
  connect_bd_net -net fsync_sel_1 [get_bd_pins fsync_sel] [get_bd_pins fsync_mux/sel]
  connect_bd_net -net mm2s_fsync_1 [get_bd_pins tpg_fsync] [get_bd_pins fsync_mux/b]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins axis_register_slice_1/aresetn] [get_bd_pins image_filter_1/ap_rst_n]
  connect_bd_net -net s_axi_lite_aclk_1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_vdma_2/s_axi_lite_aclk] [get_bd_pins image_filter_1/axilite_clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hdmi_output
proc create_hier_cell_hdmi_output { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_hdmi_output() - Empty argument(s)!"
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 LOGICVC_CTRL
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:vid_io_rtl:1.0 vid_io

  # Create pins
  create_bd_pin -dir I -type clk clk_150mhz
  create_bd_pin -dir I -type clk clk_50mhz
  create_bd_pin -dir O hdmio_clk
  create_bd_pin -dir O -type intr logicvc_int
  create_bd_pin -dir I -from 0 -to 0 logicvc_rst
  create_bd_pin -dir I -from 0 -to 0 video_clk

  # Create instance: logicvc_1, and set properties
  set logicvc_1 [ create_bd_cell -type ip -vlnv logicbricks.com:logicbricks:logicvc:5.0 logicvc_1 ]
  set_property -dict [ list \
CONFIG.C_BUFFER_0_OFFSET {1080} \
CONFIG.C_BUFFER_1_OFFSET {1080} \
CONFIG.C_DISPLAY_COLOR_SPACE {1} \
CONFIG.C_ENABLE_THREE_STATE_CONTROL {0} \
CONFIG.C_INCREASE_FIFO {4} \
CONFIG.C_LAYER_0_ADDR {0x30000000} \
CONFIG.C_LAYER_0_DATA_WIDTH {24} \
CONFIG.C_LAYER_1_ADDR {0x31950000} \
CONFIG.C_LAYER_1_TYPE {1} \
CONFIG.C_LAYER_2_DATA_WIDTH {24} \
CONFIG.C_M_AXI_DATA_WIDTH {64} \
CONFIG.C_NUM_OF_LAYERS {3} \
CONFIG.C_ROW_STRIDE {2048} \
CONFIG.C_USE_BACKGROUND {1} \
CONFIG.C_USE_XTREME_DSP {1} \
 ] $logicvc_1

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins vid_io] [get_bd_intf_pins logicvc_1/vid_io]
  connect_bd_intf_net -intf_net LOGICVC_CTRL_1 [get_bd_intf_pins LOGICVC_CTRL] [get_bd_intf_pins logicvc_1/s_axi]
  connect_bd_intf_net -intf_net logicvc_1_m_axi [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins logicvc_1/m_axi]

  # Create port connections
  connect_bd_net -net clk_150mhz_1 [get_bd_pins clk_150mhz] [get_bd_pins logicvc_1/M_AXI_ACLK]
  connect_bd_net -net clk_75mhz_1 [get_bd_pins clk_50mhz] [get_bd_pins logicvc_1/S_AXI_ACLK]
  connect_bd_net -net logicvc_1_interrupt [get_bd_pins logicvc_int] [get_bd_pins logicvc_1/interrupt]
  connect_bd_net -net logicvc_1_pix_clk_o [get_bd_pins hdmio_clk] [get_bd_pins logicvc_1/pix_clk_o]
  connect_bd_net -net logicvc_rst_1 [get_bd_pins logicvc_rst] [get_bd_pins logicvc_1/rst]
  connect_bd_net -net video_clk_1 [get_bd_pins video_clk] [get_bd_pins logicvc_1/vclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gpio
proc create_hier_cell_gpio { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_gpio() - Empty argument(s)!"
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

  # Create pins
  create_bd_pin -dir I -from 2 -to 0 Din
  create_bd_pin -dir O -from 0 -to 0 Dout
  create_bd_pin -dir O -from 0 -to 0 Dout1
  create_bd_pin -dir O -from 0 -to 0 Dout2

  # Create instance: fsync_sel, and set properties
  set fsync_sel [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 fsync_sel ]
  set_property -dict [ list \
CONFIG.DIN_FROM {1} \
CONFIG.DIN_TO {1} \
CONFIG.DIN_WIDTH {3} \
CONFIG.DOUT_WIDTH {1} \
 ] $fsync_sel

  # Create instance: iic_rst, and set properties
  set iic_rst [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 iic_rst ]
  set_property -dict [ list \
CONFIG.DIN_FROM {0} \
CONFIG.DIN_TO {0} \
CONFIG.DIN_WIDTH {3} \
 ] $iic_rst

  # Create instance: tpg_reset, and set properties
  set tpg_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 tpg_reset ]
  set_property -dict [ list \
CONFIG.DIN_FROM {2} \
CONFIG.DIN_TO {2} \
CONFIG.DIN_WIDTH {3} \
CONFIG.DOUT_WIDTH {1} \
 ] $tpg_reset

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins fsync_sel/Din] [get_bd_pins iic_rst/Din] [get_bd_pins tpg_reset/Din]
  connect_bd_net -net fsync_sel_1 [get_bd_pins Dout] [get_bd_pins fsync_sel/Dout]
  connect_bd_net -net iic_rst_Dout [get_bd_pins Dout1] [get_bd_pins iic_rst/Dout]
  connect_bd_net -net tpg_reset_Dout [get_bd_pins Dout2] [get_bd_pins tpg_reset/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: fmc_hdmi_input
proc create_hier_cell_fmc_hdmi_input { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_fmc_hdmi_input() - Empty argument(s)!"
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
  create_bd_intf_pin -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMII
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  # Create pins
  create_bd_pin -dir I -type clk clk_50mhz
  create_bd_pin -dir I -type clk m_axi_s2mm_aclk
  create_bd_pin -dir O s2mm_fsync_out
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I video_clk_2

  # Create instance: axi_vdma_1, and set properties
  set axi_vdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_1 ]
  set_property -dict [ list \
CONFIG.c_enable_debug_info_11 {1} \
CONFIG.c_enable_debug_info_15 {1} \
CONFIG.c_include_mm2s {0} \
CONFIG.c_include_s2mm_dre {0} \
CONFIG.c_include_s2mm_sf {0} \
CONFIG.c_m_axi_s2mm_data_width {32} \
CONFIG.c_num_fstores {1} \
CONFIG.c_s2mm_genlock_mode {2} \
CONFIG.c_s2mm_linebuffer_depth {4096} \
CONFIG.c_s2mm_max_burst_length {16} \
CONFIG.c_s2mm_sof_enable {1} \
 ] $axi_vdma_1

  # Create instance: fmc_imageon_hdmi_in_1, and set properties
  set fmc_imageon_hdmi_in_1 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_in:3.1 fmc_imageon_hdmi_in_1 ]

  # Create instance: v_vid_in_axi4s_1, and set properties
  set v_vid_in_axi4s_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_1 ]
  set_property -dict [ list \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {0} \
 ] $v_vid_in_axi4s_1

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins IO_HDMII] [get_bd_intf_pins fmc_imageon_hdmi_in_1/IO_HDMII]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_vdma_1/M_AXI_S2MM]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_1/S_AXI_LITE]
  connect_bd_intf_net -intf_net fmc_imageon_hdmi_in_0_VID_IO_OUT [get_bd_intf_pins fmc_imageon_hdmi_in_1/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_1/vid_io_in]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_1_video_out [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM] [get_bd_intf_pins v_vid_in_axi4s_1/video_out]

  # Create port connections
  connect_bd_net -net axi_vdma_1_s2mm_fsync_out [get_bd_pins s2mm_fsync_out] [get_bd_pins axi_vdma_1/s2mm_fsync_out]
  connect_bd_net -net axi_vdma_1_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_vdma_1/s2mm_introut]
  connect_bd_net -net clk_75mhz [get_bd_pins clk_50mhz] [get_bd_pins axi_vdma_1/s_axi_lite_aclk]
  connect_bd_net -net m_axi_s2mm_aclk_1 [get_bd_pins m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins v_vid_in_axi4s_1/aclk]
  connect_bd_net -net vtiming_mux_0_video_clk [get_bd_pins video_clk_2] [get_bd_pins fmc_imageon_hdmi_in_1/clk] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
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


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set fmc_imageon_hdmii [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 fmc_imageon_hdmii ]
  set fmc_imageon_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_imageon_iic ]
  set hdmio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:vid_io_rtl:1.0 hdmio ]
  set si570 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 si570 ]

  # Create ports
  set fmc_imageon_hdmii_clk [ create_bd_port -dir I -type clk fmc_imageon_hdmii_clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {148500000} \
 ] $fmc_imageon_hdmii_clk
  set fmc_imageon_iic_rst_b [ create_bd_port -dir O -from 0 -to 0 -type rst fmc_imageon_iic_rst_b ]
  set hdmio_clk [ create_bd_port -dir O hdmio_clk ]

  # Create instance: axi_iic_1, and set properties
  set axi_iic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_1 ]

  # Create instance: axi_interconnect_gp0, and set properties
  set axi_interconnect_gp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_gp0 ]
  set_property -dict [ list \
CONFIG.M06_HAS_REGSLICE {1} \
CONFIG.NUM_MI {9} \
 ] $axi_interconnect_gp0

  # Create instance: axi_interconnect_hp0, and set properties
  set axi_interconnect_hp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_hp0 ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
CONFIG.M00_HAS_DATA_FIFO {2} \
CONFIG.M00_HAS_REGSLICE {1} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {3} \
CONFIG.S00_HAS_REGSLICE {1} \
CONFIG.S01_HAS_REGSLICE {1} \
CONFIG.S02_HAS_DATA_FIFO {2} \
CONFIG.STRATEGY {2} \
 ] $axi_interconnect_hp0

  # Create instance: axi_interconnect_hp2, and set properties
  set axi_interconnect_hp2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_hp2 ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
CONFIG.ENABLE_PROTOCOL_CHECKERS {0} \
CONFIG.M00_HAS_DATA_FIFO {2} \
CONFIG.M00_HAS_REGSLICE {1} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
CONFIG.S00_HAS_REGSLICE {1} \
CONFIG.S01_HAS_REGSLICE {1} \
CONFIG.STRATEGY {2} \
CONFIG.XBAR_DATA_WIDTH {64} \
 ] $axi_interconnect_hp2

  # Create instance: axi_perf_mon_1, and set properties
  set axi_perf_mon_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_perf_mon:5.0 axi_perf_mon_1 ]
  set_property -dict [ list \
CONFIG.C_ENABLE_PROFILE {1} \
CONFIG.C_NUM_MONITOR_SLOTS {2} \
CONFIG.C_NUM_OF_COUNTERS {4} \
CONFIG.C_SLOT_0_AXI_PROTOCOL {AXI3} \
CONFIG.C_SLOT_1_AXI_PROTOCOL {AXI3} \
CONFIG.C_SLOT_2_AXI_PROTOCOL {AXI3} \
CONFIG.C_SLOT_3_AXI_PROTOCOL {AXI3} \
CONFIG.ENABLE_EXT_TRIGGERS {0} \
 ] $axi_perf_mon_1

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_1 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {145.943} \
CONFIG.CLKOUT1_PHASE_ERROR {94.994} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50.000} \
CONFIG.CLKOUT2_JITTER {116.798} \
CONFIG.CLKOUT2_PHASE_ERROR {94.994} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {150.000} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.PRIM_SOURCE {No_buffer} \
CONFIG.USE_INCLK_SWITCHOVER {false} \
CONFIG.USE_RESET {false} \
 ] $clk_wiz_1

  # Create instance: const_1, and set properties
  set const_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_1 ]

  # Create instance: fmc_hdmi_input
  create_hier_cell_fmc_hdmi_input [current_bd_instance .] fmc_hdmi_input

  # Create instance: gpio
  create_hier_cell_gpio [current_bd_instance .] gpio

  # Create instance: hdmi_output
  create_hier_cell_hdmi_output [current_bd_instance .] hdmi_output

  # Create instance: interrupts, and set properties
  set interrupts [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 interrupts ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {8} \
 ] $interrupts

  # Create instance: proc_sys_reset_clk50, and set properties
  set proc_sys_reset_clk50 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_clk50 ]
  set_property -dict [ list \
CONFIG.C_AUX_RESET_HIGH {0} \
 ] $proc_sys_reset_clk50

  # Create instance: proc_sys_reset_clk150, and set properties
  set proc_sys_reset_clk150 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_clk150 ]
  set_property -dict [ list \
CONFIG.C_AUX_RESET_HIGH {0} \
 ] $proc_sys_reset_clk150

  # Create instance: processing
  create_hier_cell_processing [current_bd_instance .] processing

  # Create instance: processing_system7_1, and set properties
  set processing_system7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_1 ]
  set_property -dict [ apply_preset $processing_system7_1 ] $processing_system7_1

  # Create instance: si570_clk
  create_hier_cell_si570_clk [current_bd_instance .] si570_clk

  # Create instance: tpg_input
  create_hier_cell_tpg_input [current_bd_instance .] tpg_input

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_1 [get_bd_intf_ports si570] [get_bd_intf_pins si570_clk/CLK_IN_D]
  connect_bd_intf_net -intf_net IO_HDMII_1 [get_bd_intf_ports fmc_imageon_hdmii] [get_bd_intf_pins fmc_hdmi_input/IO_HDMII]
  connect_bd_intf_net -intf_net LOGICVC_CTRL_1 [get_bd_intf_pins axi_interconnect_gp0/M03_AXI] [get_bd_intf_pins hdmi_output/LOGICVC_CTRL]
  connect_bd_intf_net -intf_net S00_AXI1_1 [get_bd_intf_pins axi_interconnect_hp2/S00_AXI] [get_bd_intf_pins processing/M_AXI_MM2S]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_hp0/S00_AXI] [get_bd_intf_pins fmc_hdmi_input/M_AXI_S2MM]
  connect_bd_intf_net -intf_net S01_AXI1_1 [get_bd_intf_pins axi_interconnect_hp2/S01_AXI] [get_bd_intf_pins processing/M_AXI_S2MM]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins axi_interconnect_gp0/M05_AXI] [get_bd_intf_pins tpg_input/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_ports fmc_imageon_iic] [get_bd_intf_pins axi_iic_1/IIC]
  connect_bd_intf_net -intf_net axi_interconnect_1_m00_axi [get_bd_intf_pins axi_interconnect_hp0/M00_AXI] [get_bd_intf_pins processing_system7_1/S_AXI_HP0]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_interconnect_1_m00_axi] [get_bd_intf_pins axi_interconnect_hp0/M00_AXI] [get_bd_intf_pins axi_perf_mon_1/SLOT_0_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_3_m00_axi [get_bd_intf_pins axi_interconnect_hp2/M00_AXI] [get_bd_intf_pins processing_system7_1/S_AXI_HP2]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_interconnect_3_m00_axi] [get_bd_intf_pins axi_interconnect_hp2/M00_AXI] [get_bd_intf_pins axi_perf_mon_1/SLOT_1_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M00_AXI [get_bd_intf_pins axi_interconnect_gp0/M00_AXI] [get_bd_intf_pins tpg_input/ctrl1]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M01_AXI [get_bd_intf_pins axi_interconnect_gp0/M01_AXI] [get_bd_intf_pins fmc_hdmi_input/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M02_AXI [get_bd_intf_pins axi_iic_1/S_AXI] [get_bd_intf_pins axi_interconnect_gp0/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M04_AXI [get_bd_intf_pins axi_interconnect_gp0/M04_AXI] [get_bd_intf_pins tpg_input/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M06_AXI [get_bd_intf_pins axi_interconnect_gp0/M06_AXI] [get_bd_intf_pins axi_perf_mon_1/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M07_AXI [get_bd_intf_pins axi_interconnect_gp0/M07_AXI] [get_bd_intf_pins processing/S_AXI_CONTROL_BUS]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M08_AXI [get_bd_intf_pins axi_interconnect_gp0/M08_AXI] [get_bd_intf_pins processing/S_AXI_LITE]
  connect_bd_intf_net -intf_net hdmi_output_vid_io [get_bd_intf_ports hdmio] [get_bd_intf_pins hdmi_output/vid_io]
  connect_bd_intf_net -intf_net processing_system7_1_ddr [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_1/DDR]
  connect_bd_intf_net -intf_net processing_system7_1_fixed_io [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_1/FIXED_IO]
  connect_bd_intf_net -intf_net s00_axi_1 [get_bd_intf_pins axi_interconnect_gp0/S00_AXI] [get_bd_intf_pins processing_system7_1/M_AXI_GP0]
  connect_bd_intf_net -intf_net s01_axi_1 [get_bd_intf_pins axi_interconnect_hp0/S01_AXI] [get_bd_intf_pins hdmi_output/M_AXI_MM2S]
  connect_bd_intf_net -intf_net tpg_input_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_hp0/S02_AXI] [get_bd_intf_pins tpg_input/M_AXI_S2MM]

  # Create port connections
  connect_bd_net -net M06_ARESETN_1 [get_bd_pins axi_interconnect_gp0/M04_ARESETN] [get_bd_pins axi_interconnect_hp0/M00_ARESETN] [get_bd_pins axi_interconnect_hp0/S00_ARESETN] [get_bd_pins axi_interconnect_hp0/S01_ARESETN] [get_bd_pins axi_interconnect_hp0/S02_ARESETN] [get_bd_pins axi_interconnect_hp2/M00_ARESETN] [get_bd_pins axi_interconnect_hp2/S00_ARESETN] [get_bd_pins axi_interconnect_hp2/S01_ARESETN] [get_bd_pins axi_perf_mon_1/core_aresetn] [get_bd_pins proc_sys_reset_clk150/peripheral_aresetn] [get_bd_pins processing/aresetn] [get_bd_pins tpg_input/aresetn]
  connect_bd_net -net ap_rst_n_1 [get_bd_pins gpio/Dout2] [get_bd_pins tpg_input/ap_rst_n]
  connect_bd_net -net axi_iic_1_iic2intc_irpt [get_bd_pins axi_iic_1/iic2intc_irpt] [get_bd_pins interrupts/In1]
  connect_bd_net -net axi_perf_mon_1_interrupt [get_bd_pins axi_perf_mon_1/interrupt] [get_bd_pins interrupts/In5]
  connect_bd_net -net clk_150mhz [get_bd_pins axi_interconnect_gp0/M04_ACLK] [get_bd_pins axi_interconnect_hp0/ACLK] [get_bd_pins axi_interconnect_hp0/M00_ACLK] [get_bd_pins axi_interconnect_hp0/S00_ACLK] [get_bd_pins axi_interconnect_hp0/S01_ACLK] [get_bd_pins axi_interconnect_hp0/S02_ACLK] [get_bd_pins axi_interconnect_hp2/ACLK] [get_bd_pins axi_interconnect_hp2/M00_ACLK] [get_bd_pins axi_interconnect_hp2/S00_ACLK] [get_bd_pins axi_interconnect_hp2/S01_ACLK] [get_bd_pins axi_perf_mon_1/core_aclk] [get_bd_pins axi_perf_mon_1/slot_0_axi_aclk] [get_bd_pins axi_perf_mon_1/slot_1_axi_aclk] [get_bd_pins clk_wiz_1/clk_out2] [get_bd_pins fmc_hdmi_input/m_axi_s2mm_aclk] [get_bd_pins hdmi_output/clk_150mhz] [get_bd_pins proc_sys_reset_clk150/slowest_sync_clk] [get_bd_pins processing/aclk] [get_bd_pins processing_system7_1/S_AXI_HP0_ACLK] [get_bd_pins processing_system7_1/S_AXI_HP2_ACLK] [get_bd_pins tpg_input/m_axi_s2mm_aclk]
  connect_bd_net -net clk_50mhz [get_bd_pins axi_iic_1/s_axi_aclk] [get_bd_pins axi_interconnect_gp0/ACLK] [get_bd_pins axi_interconnect_gp0/M00_ACLK] [get_bd_pins axi_interconnect_gp0/M01_ACLK] [get_bd_pins axi_interconnect_gp0/M02_ACLK] [get_bd_pins axi_interconnect_gp0/M03_ACLK] [get_bd_pins axi_interconnect_gp0/M05_ACLK] [get_bd_pins axi_interconnect_gp0/M06_ACLK] [get_bd_pins axi_interconnect_gp0/M07_ACLK] [get_bd_pins axi_interconnect_gp0/M08_ACLK] [get_bd_pins axi_interconnect_gp0/S00_ACLK] [get_bd_pins axi_perf_mon_1/s_axi_aclk] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins fmc_hdmi_input/clk_50mhz] [get_bd_pins hdmi_output/clk_50mhz] [get_bd_pins proc_sys_reset_clk50/slowest_sync_clk] [get_bd_pins processing/s_axi_lite_aclk] [get_bd_pins processing_system7_1/M_AXI_GP0_ACLK] [get_bd_pins tpg_input/s_axi_aclk]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins proc_sys_reset_clk150/dcm_locked] [get_bd_pins proc_sys_reset_clk50/dcm_locked]
  connect_bd_net -net fmc_hdmi_input_s2mm_fsync_out [get_bd_pins processing/tpg_fsync] [get_bd_pins tpg_input/s2mm_fsync_out]
  connect_bd_net -net fmc_hdmi_input_s2mm_fsync_out1 [get_bd_pins fmc_hdmi_input/s2mm_fsync_out] [get_bd_pins processing/hdmi_rx_fsync]
  connect_bd_net -net fmc_hdmi_input_s2mm_introut [get_bd_pins fmc_hdmi_input/s2mm_introut] [get_bd_pins interrupts/In3]
  connect_bd_net -net fmc_imageon_hdmii_clk_1 [get_bd_ports fmc_imageon_hdmii_clk] [get_bd_pins fmc_hdmi_input/video_clk_2]
  connect_bd_net -net fsync_sel_1 [get_bd_pins gpio/Dout] [get_bd_pins processing/fsync_sel]
  connect_bd_net -net hdmi_output_logicvc_int [get_bd_pins hdmi_output/logicvc_int] [get_bd_pins interrupts/In2]
  connect_bd_net -net iic_rst_Dout [get_bd_ports fmc_imageon_iic_rst_b] [get_bd_pins gpio/Dout1]
  connect_bd_net -net logicvc_1_pix_clk_o [get_bd_ports hdmio_clk] [get_bd_pins hdmi_output/hdmio_clk]
  connect_bd_net -net proc_sys_reset_clk150_interconnect_aresetn [get_bd_pins axi_interconnect_hp0/ARESETN] [get_bd_pins axi_interconnect_hp2/ARESETN] [get_bd_pins proc_sys_reset_clk150/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_clk150_peripheral_reset [get_bd_pins hdmi_output/logicvc_rst] [get_bd_pins proc_sys_reset_clk150/peripheral_reset]
  connect_bd_net -net proc_sys_reset_clk50_interconnect_aresetn [get_bd_pins axi_interconnect_gp0/ARESETN] [get_bd_pins proc_sys_reset_clk50/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_clk50_peripheral_aresetn [get_bd_pins axi_iic_1/s_axi_aresetn] [get_bd_pins axi_interconnect_gp0/M00_ARESETN] [get_bd_pins axi_interconnect_gp0/M01_ARESETN] [get_bd_pins axi_interconnect_gp0/M02_ARESETN] [get_bd_pins axi_interconnect_gp0/M03_ARESETN] [get_bd_pins axi_interconnect_gp0/M05_ARESETN] [get_bd_pins axi_interconnect_gp0/M06_ARESETN] [get_bd_pins axi_interconnect_gp0/M07_ARESETN] [get_bd_pins axi_interconnect_gp0/M08_ARESETN] [get_bd_pins axi_interconnect_gp0/S00_ARESETN] [get_bd_pins axi_perf_mon_1/s_axi_aresetn] [get_bd_pins proc_sys_reset_clk50/peripheral_aresetn] [get_bd_pins processing/ap_rst_axilite_clk]
  connect_bd_net -net processing_mm2s_introut [get_bd_pins interrupts/In6] [get_bd_pins processing/mm2s_introut]
  connect_bd_net -net processing_s2mm_introut [get_bd_pins interrupts/In7] [get_bd_pins processing/s2mm_introut]
  connect_bd_net -net processing_system7_1_GPIO_O [get_bd_pins gpio/Din] [get_bd_pins processing_system7_1/GPIO_O]
  connect_bd_net -net processing_system7_1_fclk_clk0 [get_bd_pins clk_wiz_1/clk_in1] [get_bd_pins processing_system7_1/FCLK_CLK0]
  connect_bd_net -net reset_rtl_1 [get_bd_pins proc_sys_reset_clk150/ext_reset_in] [get_bd_pins proc_sys_reset_clk50/ext_reset_in] [get_bd_pins processing_system7_1/FCLK_RESET0_N]
  connect_bd_net -net tpg_input_s2mm_introut [get_bd_pins interrupts/In4] [get_bd_pins tpg_input/s2mm_introut]
  connect_bd_net -net video_clk_1 [get_bd_pins hdmi_output/video_clk] [get_bd_pins si570_clk/BUFG_O] [get_bd_pins tpg_input/clk]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins interrupts/dout] [get_bd_pins processing_system7_1/IRQ_F2P]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins const_1/dout] [get_bd_pins interrupts/In0]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x40090000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs fmc_hdmi_input/axi_vdma_1/S_AXI_LITE/Reg] SEG2
  create_bd_addr_seg -range 0x10000 -offset 0x40070000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs tpg_input/v_tc_1/ctrl/Reg] SEG4
  create_bd_addr_seg -range 0x10000 -offset 0x40040000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs axi_iic_1/S_AXI/Reg] SEG_axi_iic_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x400F0000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs axi_perf_mon_1/S_AXI/Reg] SEG_axi_perf_mon_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x400B0000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs processing/axi_vdma_2/S_AXI_LITE/Reg] SEG_axi_vdma_2_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40020000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs tpg_input/axi_vdma_3/S_AXI_LITE/Reg] SEG_axi_vdma_3_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x400D0000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs processing/image_filter_1/s_axi_CONTROL_BUS/Reg] SEG_image_filter_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40030000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs hdmi_output/logicvc_1/s_axi/reg0] SEG_logicvc_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x40080000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs tpg_input/v_tpg_1/s_axi_CTRL/Reg] SEG_v_tpg_1_Reg
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces fmc_hdmi_input/axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_1_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces hdmi_output/logicvc_1/videoData] [get_bd_addr_segs processing_system7_1/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_1_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces processing/axi_vdma_2/Data_MM2S] [get_bd_addr_segs processing_system7_1/S_AXI_HP2/HP2_DDR_LOWOCM] SEG1
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces processing/axi_vdma_2/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_HP2/HP2_DDR_LOWOCM] SEG2
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces tpg_input/axi_vdma_3/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_1_HP0_DDR_LOWOCM

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


