
################################################################
# This is a generated script based on design: fmc_imageon_gs
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
# source fmc_imageon_gs_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART xilinx.com:zc702:part0:1.2 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name fmc_imageon_gs

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
  set IO_HDMIO_L [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMIO_L ]
  set IO_HDMIO_R [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMIO_R ]
  set IO_VITA_CAM_L [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_VITA_CAM_L ]
  set IO_VITA_CAM_R [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_VITA_CAM_R ]
  set IO_VITA_SPI_L [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:onsemi_vita_spi_rtl:1.0 IO_VITA_SPI_L ]
  set IO_VITA_SPI_R [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:onsemi_vita_spi_rtl:1.0 IO_VITA_SPI_R ]
  set fmc_imageon_iic_l [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_imageon_iic_l ]
  set fmc_imageon_iic_r [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_imageon_iic_r ]

  # Create ports
  set fmc_imageon_iic_l_rst_n [ create_bd_port -dir O -from 0 -to 0 fmc_imageon_iic_l_rst_n ]
  set fmc_imageon_iic_r_rst_n [ create_bd_port -dir O -from 0 -to 0 fmc_imageon_iic_r_rst_n ]
  set fmc_imageon_vclk_L [ create_bd_port -dir I fmc_imageon_vclk_L ]
  set fmc_imageon_vclk_R [ create_bd_port -dir I fmc_imageon_vclk_R ]

  # Create instance: avnet_hdmi_out_0, and set properties
  set avnet_hdmi_out_0 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_out:3.1 avnet_hdmi_out_0 ]
  set_property -dict [ list \
CONFIG.C_DEBUG_PORT {true} \
 ] $avnet_hdmi_out_0

  # Create instance: avnet_hdmi_out_1, and set properties
  set avnet_hdmi_out_1 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_out:3.1 avnet_hdmi_out_1 ]
  set_property -dict [ list \
CONFIG.C_DEBUG_PORT {true} \
 ] $avnet_hdmi_out_1

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {4} \
 ] $axi_mem_intercon

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_m_axi_s2mm_data_width {64} \
CONFIG.c_m_axis_mm2s_tdata_width {16} \
CONFIG.c_mm2s_linebuffer_depth {4096} \
CONFIG.c_mm2s_max_burst_length {256} \
CONFIG.c_s2mm_linebuffer_depth {4096} \
CONFIG.c_s2mm_max_burst_length {256} \
 ] $axi_vdma_0

  # Create instance: axi_vdma_1, and set properties
  set axi_vdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_1 ]
  set_property -dict [ list \
CONFIG.c_m_axi_s2mm_data_width {64} \
CONFIG.c_m_axis_mm2s_tdata_width {16} \
CONFIG.c_mm2s_linebuffer_depth {512} \
CONFIG.c_mm2s_max_burst_length {256} \
CONFIG.c_s2mm_linebuffer_depth {4096} \
CONFIG.c_s2mm_max_burst_length {256} \
 ] $axi_vdma_1

  # Create instance: fmc_imageon_iic_0, and set properties
  set fmc_imageon_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 fmc_imageon_iic_0 ]
  set_property -dict [ list \
CONFIG.IIC_BOARD_INTERFACE {Custom} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $fmc_imageon_iic_0

  # Create instance: fmc_imageon_iic_1, and set properties
  set fmc_imageon_iic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 fmc_imageon_iic_1 ]
  set_property -dict [ list \
CONFIG.IIC_BOARD_INTERFACE {Custom} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $fmc_imageon_iic_1

  # Create instance: onsemi_vita_cam_0, and set properties
  set onsemi_vita_cam_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_cam:3.2 onsemi_vita_cam_0 ]

  # Create instance: onsemi_vita_cam_1, and set properties
  set onsemi_vita_cam_1 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_cam:3.2 onsemi_vita_cam_1 ]

  # Create instance: onsemi_vita_spi_0, and set properties
  set onsemi_vita_spi_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_spi:3.2 onsemi_vita_spi_0 ]

  # Create instance: onsemi_vita_spi_1, and set properties
  set onsemi_vita_spi_1 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_spi:3.2 onsemi_vita_spi_1 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_EN_CLK0_PORT {1} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_RST0_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_EN_RST2_PORT {1} \
CONFIG.PCW_EN_RST3_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {75} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.preset {ZC702} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {12} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_148_5M, and set properties
  set rst_processing_system7_0_148_5M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_148_5M ]

  # Create instance: rst_processing_system7_0_148_5M1, and set properties
  set rst_processing_system7_0_148_5M1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_148_5M1 ]

  # Create instance: rst_processing_system7_0_149M, and set properties
  set rst_processing_system7_0_149M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_149M ]

  # Create instance: rst_processing_system7_0_76M, and set properties
  set rst_processing_system7_0_76M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_76M ]

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {12} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_axi4s_vid_out_1, and set properties
  set v_axi4s_vid_out_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_1 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {12} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_1

  # Create instance: v_cfa_0, and set properties
  set v_cfa_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cfa:7.0 v_cfa_0 ]
  set_property -dict [ list \
CONFIG.active_cols {1920} \
CONFIG.active_rows {1080} \
CONFIG.has_axi4_lite {true} \
CONFIG.max_cols {1920} \
 ] $v_cfa_0

  # Create instance: v_cfa_1, and set properties
  set v_cfa_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cfa:7.0 v_cfa_1 ]
  set_property -dict [ list \
CONFIG.active_cols {1920} \
CONFIG.active_rows {1080} \
CONFIG.has_axi4_lite {true} \
CONFIG.max_cols {1920} \
 ] $v_cfa_1

  # Create instance: v_cresample_0, and set properties
  set v_cresample_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample:4.0 v_cresample_0 ]
  set_property -dict [ list \
CONFIG.active_cols {1920} \
CONFIG.active_rows {1080} \
CONFIG.m_axis_video_format {2} \
CONFIG.s_axis_video_format {3} \
 ] $v_cresample_0

  # Create instance: v_cresample_1, and set properties
  set v_cresample_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample:4.0 v_cresample_1 ]
  set_property -dict [ list \
CONFIG.active_cols {1920} \
CONFIG.active_rows {1080} \
CONFIG.m_axis_video_format {2} \
CONFIG.s_axis_video_format {3} \
 ] $v_cresample_1

  # Create instance: v_osd_0, and set properties
  set v_osd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_osd:6.0 v_osd_0 ]
  set_property -dict [ list \
CONFIG.LAYER0_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER0_HEIGHT {1080} \
CONFIG.LAYER0_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER0_PRIORITY {0} \
CONFIG.LAYER0_VERTICAL_START_POSITION {0} \
CONFIG.LAYER0_WIDTH {1920} \
CONFIG.LAYER1_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER1_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER1_HEIGHT {1080} \
CONFIG.LAYER1_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER1_PRIORITY {0} \
CONFIG.LAYER1_VERTICAL_START_POSITION {0} \
CONFIG.LAYER1_WIDTH {1920} \
CONFIG.LAYER2_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER2_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER2_HEIGHT {720} \
CONFIG.LAYER2_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER2_PRIORITY {0} \
CONFIG.LAYER2_VERTICAL_START_POSITION {0} \
CONFIG.LAYER2_WIDTH {1280} \
CONFIG.LAYER3_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER3_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER3_HEIGHT {720} \
CONFIG.LAYER3_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER3_PRIORITY {0} \
CONFIG.LAYER3_VERTICAL_START_POSITION {0} \
CONFIG.LAYER3_WIDTH {1280} \
CONFIG.LAYER4_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER4_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER4_HEIGHT {720} \
CONFIG.LAYER4_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER4_PRIORITY {0} \
CONFIG.LAYER4_VERTICAL_START_POSITION {0} \
CONFIG.LAYER4_WIDTH {1280} \
CONFIG.LAYER5_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER5_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER5_HEIGHT {720} \
CONFIG.LAYER5_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER5_PRIORITY {0} \
CONFIG.LAYER5_VERTICAL_START_POSITION {0} \
CONFIG.LAYER5_WIDTH {1280} \
CONFIG.LAYER6_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER6_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER6_HEIGHT {720} \
CONFIG.LAYER6_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER6_PRIORITY {0} \
CONFIG.LAYER6_VERTICAL_START_POSITION {0} \
CONFIG.LAYER6_WIDTH {1280} \
CONFIG.LAYER7_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER7_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER7_HEIGHT {720} \
CONFIG.LAYER7_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER7_PRIORITY {0} \
CONFIG.LAYER7_VERTICAL_START_POSITION {0} \
CONFIG.LAYER7_WIDTH {1280} \
CONFIG.M_AXIS_VIDEO_HEIGHT {1080} \
CONFIG.M_AXIS_VIDEO_WIDTH {1920} \
CONFIG.NUMBER_OF_LAYERS {1} \
CONFIG.SCREEN_WIDTH {1920} \
 ] $v_osd_0

  # Create instance: v_osd_1, and set properties
  set v_osd_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_osd:6.0 v_osd_1 ]
  set_property -dict [ list \
CONFIG.LAYER0_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER0_HEIGHT {1080} \
CONFIG.LAYER0_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER0_PRIORITY {0} \
CONFIG.LAYER0_VERTICAL_START_POSITION {0} \
CONFIG.LAYER0_WIDTH {1920} \
CONFIG.LAYER1_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER1_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER1_HEIGHT {1080} \
CONFIG.LAYER1_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER1_PRIORITY {0} \
CONFIG.LAYER1_VERTICAL_START_POSITION {0} \
CONFIG.LAYER1_WIDTH {1920} \
CONFIG.LAYER2_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER2_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER2_HEIGHT {720} \
CONFIG.LAYER2_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER2_PRIORITY {0} \
CONFIG.LAYER2_VERTICAL_START_POSITION {0} \
CONFIG.LAYER2_WIDTH {1280} \
CONFIG.LAYER3_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER3_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER3_HEIGHT {720} \
CONFIG.LAYER3_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER3_PRIORITY {0} \
CONFIG.LAYER3_VERTICAL_START_POSITION {0} \
CONFIG.LAYER3_WIDTH {1280} \
CONFIG.LAYER4_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER4_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER4_HEIGHT {720} \
CONFIG.LAYER4_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER4_PRIORITY {0} \
CONFIG.LAYER4_VERTICAL_START_POSITION {0} \
CONFIG.LAYER4_WIDTH {1280} \
CONFIG.LAYER5_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER5_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER5_HEIGHT {720} \
CONFIG.LAYER5_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER5_PRIORITY {0} \
CONFIG.LAYER5_VERTICAL_START_POSITION {0} \
CONFIG.LAYER5_WIDTH {1280} \
CONFIG.LAYER6_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER6_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER6_HEIGHT {720} \
CONFIG.LAYER6_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER6_PRIORITY {0} \
CONFIG.LAYER6_VERTICAL_START_POSITION {0} \
CONFIG.LAYER6_WIDTH {1280} \
CONFIG.LAYER7_GLOBAL_ALPHA_ENABLE {false} \
CONFIG.LAYER7_GLOBAL_ALPHA_VALUE {256} \
CONFIG.LAYER7_HEIGHT {720} \
CONFIG.LAYER7_HORIZONTAL_START_POSITION {0} \
CONFIG.LAYER7_PRIORITY {0} \
CONFIG.LAYER7_VERTICAL_START_POSITION {0} \
CONFIG.LAYER7_WIDTH {1280} \
CONFIG.M_AXIS_VIDEO_HEIGHT {1080} \
CONFIG.M_AXIS_VIDEO_WIDTH {1920} \
CONFIG.NUMBER_OF_LAYERS {1} \
CONFIG.SCREEN_WIDTH {1920} \
 ] $v_osd_1

  # Create instance: v_rgb2ycrcb_0, and set properties
  set v_rgb2ycrcb_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb:7.1 v_rgb2ycrcb_0 ]
  set_property -dict [ list \
CONFIG.ACTIVE_COLS {1920} \
CONFIG.ACTIVE_ROWS {1080} \
 ] $v_rgb2ycrcb_0

  # Create instance: v_rgb2ycrcb_1, and set properties
  set v_rgb2ycrcb_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb:7.1 v_rgb2ycrcb_1 ]
  set_property -dict [ list \
CONFIG.ACTIVE_COLS {1920} \
CONFIG.ACTIVE_ROWS {1080} \
 ] $v_rgb2ycrcb_1

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0 ]
  set_property -dict [ list \
CONFIG.HAS_AXI4_LITE {false} \
CONFIG.VIDEO_MODE {1080p} \
CONFIG.enable_detection {false} \
 ] $v_tc_0

  # Create instance: v_tc_1, and set properties
  set v_tc_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_1 ]
  set_property -dict [ list \
CONFIG.HAS_AXI4_LITE {false} \
CONFIG.VIDEO_MODE {1080p} \
CONFIG.enable_detection {false} \
 ] $v_tc_1

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_0 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {12} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {12} \
 ] $v_vid_in_axi4s_0

  # Create instance: v_vid_in_axi4s_1, and set properties
  set v_vid_in_axi4s_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_1 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {12} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {12} \
 ] $v_vid_in_axi4s_1

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net IO_CAM_IN_1 [get_bd_intf_ports IO_VITA_CAM_R] [get_bd_intf_pins onsemi_vita_cam_0/IO_CAM_IN]
  connect_bd_intf_net -intf_net IO_CAM_IN_2 [get_bd_intf_ports IO_VITA_CAM_L] [get_bd_intf_pins onsemi_vita_cam_1/IO_CAM_IN]
  connect_bd_intf_net -intf_net avnet_hdmi_out_0_IO_HDMIO [get_bd_intf_ports IO_HDMIO_R] [get_bd_intf_pins avnet_hdmi_out_0/IO_HDMIO]
  connect_bd_intf_net -intf_net avnet_hdmi_out_1_IO_HDMIO [get_bd_intf_ports IO_HDMIO_L] [get_bd_intf_pins avnet_hdmi_out_1/IO_HDMIO]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins v_osd_0/video_s0_in]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_1/M_AXIS_MM2S] [get_bd_intf_pins v_osd_1/video_s0_in]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S02_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S03_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net fmc_imageon_iic_0_IIC [get_bd_intf_ports fmc_imageon_iic_r] [get_bd_intf_pins fmc_imageon_iic_0/IIC]
  connect_bd_intf_net -intf_net fmc_imageon_iic_1_IIC [get_bd_intf_ports fmc_imageon_iic_l] [get_bd_intf_pins fmc_imageon_iic_1/IIC]
  connect_bd_intf_net -intf_net onsemi_vita_cam_0_VID_IO_OUT [get_bd_intf_pins onsemi_vita_cam_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_0/vid_io_in]
  connect_bd_intf_net -intf_net onsemi_vita_cam_1_VID_IO_OUT [get_bd_intf_pins onsemi_vita_cam_1/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_1/vid_io_in]
  connect_bd_intf_net -intf_net onsemi_vita_spi_0_IO_SPI_OUT [get_bd_intf_ports IO_VITA_SPI_R] [get_bd_intf_pins onsemi_vita_spi_0/IO_SPI_OUT]
  connect_bd_intf_net -intf_net onsemi_vita_spi_1_IO_SPI_OUT [get_bd_intf_ports IO_VITA_SPI_L] [get_bd_intf_pins onsemi_vita_spi_1/IO_SPI_OUT]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins fmc_imageon_iic_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_vdma_1/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI] [get_bd_intf_pins v_osd_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins onsemi_vita_cam_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI] [get_bd_intf_pins v_cfa_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins onsemi_vita_spi_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M07_AXI [get_bd_intf_pins fmc_imageon_iic_1/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M08_AXI [get_bd_intf_pins onsemi_vita_cam_1/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M09_AXI [get_bd_intf_pins onsemi_vita_spi_1/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M10_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M10_AXI] [get_bd_intf_pins v_cfa_1/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M11_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M11_AXI] [get_bd_intf_pins v_osd_1/ctrl]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins avnet_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_1_vid_io_out [get_bd_intf_pins avnet_hdmi_out_1/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_1/vid_io_out]
  connect_bd_intf_net -intf_net v_cfa_0_video_out [get_bd_intf_pins v_cfa_0/video_out] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
  connect_bd_intf_net -intf_net v_cfa_1_video_out [get_bd_intf_pins v_cfa_1/video_out] [get_bd_intf_pins v_rgb2ycrcb_1/video_in]
  connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins v_cresample_0/video_out]
  connect_bd_intf_net -intf_net v_cresample_1_video_out [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM] [get_bd_intf_pins v_cresample_1/video_out]
  connect_bd_intf_net -intf_net v_osd_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_osd_0/video_out]
  connect_bd_intf_net -intf_net v_osd_1_video_out [get_bd_intf_pins v_axi4s_vid_out_1/video_in] [get_bd_intf_pins v_osd_1/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_1_video_out [get_bd_intf_pins v_cresample_1/video_in] [get_bd_intf_pins v_rgb2ycrcb_1/video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  connect_bd_intf_net -intf_net v_tc_1_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_1/vtiming_in] [get_bd_intf_pins v_tc_1/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_cfa_0/video_in] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_1_video_out [get_bd_intf_pins v_cfa_1/video_in] [get_bd_intf_pins v_vid_in_axi4s_1/video_out]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_ports fmc_imageon_vclk_R] [get_bd_pins avnet_hdmi_out_1/clk] [get_bd_pins onsemi_vita_cam_1/clk] [get_bd_pins rst_processing_system7_0_148_5M1/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_1/vid_io_out_clk] [get_bd_pins v_tc_1/clk] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports fmc_imageon_vclk_L] [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins onsemi_vita_cam_0/clk] [get_bd_pins rst_processing_system7_0_148_5M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net fmc_imageon_iic_0_gpo [get_bd_ports fmc_imageon_iic_r_rst_n] [get_bd_pins fmc_imageon_iic_0/gpo]
  connect_bd_net -net fmc_imageon_iic_1_gpo [get_bd_ports fmc_imageon_iic_l_rst_n] [get_bd_pins fmc_imageon_iic_1/gpo]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins fmc_imageon_iic_0/s_axi_aclk] [get_bd_pins fmc_imageon_iic_1/s_axi_aclk] [get_bd_pins onsemi_vita_cam_0/s00_axi_aclk] [get_bd_pins onsemi_vita_cam_1/s00_axi_aclk] [get_bd_pins onsemi_vita_spi_0/s00_axi_aclk] [get_bd_pins onsemi_vita_spi_1/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/M07_ACLK] [get_bd_pins processing_system7_0_axi_periph/M08_ACLK] [get_bd_pins processing_system7_0_axi_periph/M09_ACLK] [get_bd_pins processing_system7_0_axi_periph/M10_ACLK] [get_bd_pins processing_system7_0_axi_periph/M11_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_76M/slowest_sync_clk] [get_bd_pins v_cfa_0/s_axi_aclk] [get_bd_pins v_cfa_1/s_axi_aclk] [get_bd_pins v_osd_0/s_axi_aclk] [get_bd_pins v_osd_1/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_mem_intercon/S02_ACLK] [get_bd_pins axi_mem_intercon/S03_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins rst_processing_system7_0_149M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_axi4s_vid_out_1/aclk] [get_bd_pins v_cfa_0/aclk] [get_bd_pins v_cfa_1/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_cresample_1/aclk] [get_bd_pins v_osd_0/aclk] [get_bd_pins v_osd_1/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk] [get_bd_pins v_rgb2ycrcb_1/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins v_vid_in_axi4s_1/aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_vita_cam_0/clk200] [get_bd_pins onsemi_vita_cam_1/clk200] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_76M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins rst_processing_system7_0_148_5M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET2_N [get_bd_pins processing_system7_0/FCLK_RESET2_N] [get_bd_pins rst_processing_system7_0_148_5M1/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET3_N [get_bd_pins processing_system7_0/FCLK_RESET3_N] [get_bd_pins rst_processing_system7_0_149M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_148_5M1_peripheral_aresetn [get_bd_pins rst_processing_system7_0_148_5M1/peripheral_aresetn] [get_bd_pins v_tc_1/resetn]
  connect_bd_net -net rst_processing_system7_0_148_5M1_peripheral_reset [get_bd_pins onsemi_vita_cam_1/reset] [get_bd_pins rst_processing_system7_0_148_5M1/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_aresetn [get_bd_pins rst_processing_system7_0_148_5M/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_reset [get_bd_pins onsemi_vita_cam_0/reset] [get_bd_pins rst_processing_system7_0_148_5M/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_149M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_149M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_149M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_mem_intercon/S02_ARESETN] [get_bd_pins axi_mem_intercon/S03_ARESETN] [get_bd_pins rst_processing_system7_0_149M/peripheral_aresetn] [get_bd_pins v_cfa_0/aresetn] [get_bd_pins v_cfa_1/aresetn] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_cresample_1/aresetn] [get_bd_pins v_osd_0/aresetn] [get_bd_pins v_osd_1/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn] [get_bd_pins v_rgb2ycrcb_1/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_76M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_aresetn [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins fmc_imageon_iic_0/s_axi_aresetn] [get_bd_pins fmc_imageon_iic_1/s_axi_aresetn] [get_bd_pins onsemi_vita_cam_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_cam_1/s00_axi_aresetn] [get_bd_pins onsemi_vita_spi_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_spi_1/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M07_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M08_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M09_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M10_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M11_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_76M/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_axi4s_vid_out_1/aresetn] [get_bd_pins v_cfa_0/s_axi_aresetn] [get_bd_pins v_cfa_1/s_axi_aresetn] [get_bd_pins v_osd_0/s_axi_aresetn] [get_bd_pins v_osd_1/s_axi_aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn] [get_bd_pins v_vid_in_axi4s_1/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_reset [get_bd_pins avnet_hdmi_out_0/reset] [get_bd_pins avnet_hdmi_out_1/reset] [get_bd_pins rst_processing_system7_0_76M/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset] [get_bd_pins v_axi4s_vid_out_1/vid_io_out_reset] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_reset]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins onsemi_vita_cam_0/trigger1] [get_bd_pins onsemi_vita_cam_1/trigger1] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins avnet_hdmi_out_0/embed_syncs] [get_bd_pins avnet_hdmi_out_0/oe] [get_bd_pins avnet_hdmi_out_1/embed_syncs] [get_bd_pins avnet_hdmi_out_1/oe] [get_bd_pins onsemi_vita_cam_0/oe] [get_bd_pins onsemi_vita_cam_1/oe] [get_bd_pins onsemi_vita_spi_0/oe] [get_bd_pins onsemi_vita_spi_1/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_axi4s_vid_out_1/aclken] [get_bd_pins v_axi4s_vid_out_1/vid_io_out_ce] [get_bd_pins v_cfa_0/aclken] [get_bd_pins v_cfa_0/s_axi_aclken] [get_bd_pins v_cfa_1/aclken] [get_bd_pins v_cfa_1/s_axi_aclken] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_cresample_1/aclken] [get_bd_pins v_osd_0/aclken] [get_bd_pins v_osd_0/s_axi_aclken] [get_bd_pins v_osd_1/aclken] [get_bd_pins v_osd_1/s_axi_aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_rgb2ycrcb_1/aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/gen_clken] [get_bd_pins v_tc_1/clken] [get_bd_pins v_tc_1/gen_clken] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins v_vid_in_axi4s_1/aclken] [get_bd_pins v_vid_in_axi4s_1/axis_enable] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_ce] [get_bd_pins xlconstant_1/dout]

  # Create address segments
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_imageon_iic_0/S_AXI/Reg] SEG_fmc_imageon_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41610000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_imageon_iic_1/S_AXI/Reg] SEG_fmc_imageon_iic_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_0/S00_AXI/Reg] SEG_onsemi_vita_cam_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_1/S00_AXI/Reg] SEG_onsemi_vita_cam_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_spi_0/S00_AXI/Reg] SEG_onsemi_vita_spi_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_spi_1/S00_AXI/Reg] SEG_onsemi_vita_spi_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/ctrl/Reg] SEG_v_cfa_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C60000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_1/ctrl/Reg] SEG_v_cfa_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_osd_0/ctrl/Reg] SEG_v_osd_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C70000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_osd_1/ctrl/Reg] SEG_v_osd_1_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port IO_VITA_CAM_L -pg 1 -y 1270 -defaultsOSRD
preplace port DDR -pg 1 -y 770 -defaultsOSRD
preplace port IO_HDMIO_R -pg 1 -y 910 -defaultsOSRD
preplace port fmc_imageon_iic_r -pg 1 -y 90 -defaultsOSRD
preplace port fmc_imageon_vclk_R -pg 1 -y 1250 -defaultsOSRD
preplace port IO_VITA_SPI_R -pg 1 -y 400 -defaultsOSRD
preplace port IO_VITA_CAM_R -pg 1 -y 890 -defaultsOSRD
preplace port IO_HDMIO_L -pg 1 -y 1180 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 790 -defaultsOSRD
preplace port fmc_imageon_iic_l -pg 1 -y 510 -defaultsOSRD
preplace port fmc_imageon_vclk_L -pg 1 -y 910 -defaultsOSRD
preplace port IO_VITA_SPI_L -pg 1 -y 250 -defaultsOSRD
preplace portBus fmc_imageon_iic_r_rst_n -pg 1 -y 130 -defaultsOSRD
preplace portBus fmc_imageon_iic_l_rst_n -pg 1 -y 570 -defaultsOSRD
preplace inst rst_processing_system7_0_148_5M1 -pg 1 -lvl 11 -y 1170 -defaultsOSRD -resize 258 158
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 19 -y 920 -defaultsOSRD
preplace inst rst_processing_system7_0_76M -pg 1 -lvl 1 -y 770 -defaultsOSRD
preplace inst v_axi4s_vid_out_1 -pg 1 -lvl 19 -y 1190 -defaultsOSRD -resize 180 220
preplace inst axi_vdma_0 -pg 1 -lvl 7 -y 1110 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 18 -y 1300 -defaultsOSRD
preplace inst v_tc_1 -pg 1 -lvl 18 -y 1140 -defaultsOSRD -resize 160 120
preplace inst xlconstant_0 -pg 1 -lvl 1 -y 1200 -defaultsOSRD
preplace inst fmc_imageon_iic_0 -pg 1 -lvl 20 -y 50 -defaultsOSRD -resize 196 132
preplace inst axi_vdma_1 -pg 1 -lvl 17 -y 970 -defaultsOSRD
preplace inst v_cfa_0 -pg 1 -lvl 4 -y 1040 -defaultsOSRD
preplace inst v_cfa_1 -pg 1 -lvl 14 -y 980 -defaultsOSRD -resize 180 200
preplace inst fmc_imageon_iic_1 -pg 1 -lvl 20 -y 560 -defaultsOSRD -resize 180 120
preplace inst xlconstant_1 -pg 1 -lvl 1 -y 1120 -defaultsOSRD
preplace inst rst_processing_system7_0_148_5M -pg 1 -lvl 1 -y 1000 -defaultsOSRD
preplace inst onsemi_vita_cam_0 -pg 1 -lvl 2 -y 950 -defaultsOSRD
preplace inst v_osd_0 -pg 1 -lvl 18 -y 630 -defaultsOSRD
preplace inst v_cresample_0 -pg 1 -lvl 6 -y 1090 -defaultsOSRD
preplace inst rst_processing_system7_0_149M -pg 1 -lvl 3 -y 770 -defaultsOSRD -resize 258 158
preplace inst v_osd_1 -pg 1 -lvl 18 -y 930 -defaultsOSRD -resize 200 220
preplace inst v_cresample_1 -pg 1 -lvl 16 -y 920 -defaultsOSRD -resize 160 120
preplace inst onsemi_vita_cam_1 -pg 1 -lvl 12 -y 1260 -defaultsOSRD -resize 204 218
preplace inst v_vid_in_axi4s_0 -pg 1 -lvl 3 -y 1040 -defaultsOSRD
preplace inst v_vid_in_axi4s_1 -pg 1 -lvl 13 -y 1280 -defaultsOSRD -resize 192 240
preplace inst v_rgb2ycrcb_0 -pg 1 -lvl 5 -y 1060 -defaultsOSRD
preplace inst v_rgb2ycrcb_1 -pg 1 -lvl 15 -y 930 -defaultsOSRD -resize 174 124
preplace inst onsemi_vita_spi_0 -pg 1 -lvl 20 -y 390 -defaultsOSRD -resize 244 164
preplace inst axi_mem_intercon -pg 1 -lvl 8 -y 940 -defaultsOSRD
preplace inst avnet_hdmi_out_0 -pg 1 -lvl 20 -y 920 -defaultsOSRD
preplace inst util_ds_buf_0 -pg 1 -lvl 10 -y 1050 -defaultsOSRD
preplace inst onsemi_vita_spi_1 -pg 1 -lvl 20 -y 210 -defaultsOSRD -resize 240 140
preplace inst avnet_hdmi_out_1 -pg 1 -lvl 20 -y 1190 -defaultsOSRD -resize 176 150
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 11 -y 330 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 9 -y 900 -defaultsOSRD
preplace netloc v_axi4s_vid_out_1_vid_io_out 1 19 1 N
preplace netloc axi_vdma_0_M_AXI_MM2S 1 7 11 2160 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 NJ 1420 5400
preplace netloc axi_vdma_1_M_AXI_S2MM 1 7 1 2120
preplace netloc processing_system7_0_axi_periph_M08_AXI 1 11 1 3660
preplace netloc processing_system7_0_FIXED_IO 1 9 12 NJ 780 NJ 780 NJ 780 NJ 780 NJ 780 NJ 780 NJ 780 NJ 780 NJ 780 NJ 780 NJ 780 NJ
preplace netloc v_rgb2ycrcb_1_video_out 1 15 1 4840
preplace netloc rst_processing_system7_0_149M_interconnect_aresetn 1 3 5 NJ 790 NJ 790 NJ 790 NJ 790 2130
preplace netloc axi_vdma_0_M_AXI_S2MM 1 7 11 2150 710 NJ 710 NJ 710 NJ 710 NJ 710 NJ 710 NJ 710 NJ 710 NJ 710 NJ 710 5410
preplace netloc fmc_imageon_iic_1_gpo 1 20 1 NJ
preplace netloc v_vid_in_axi4s_0_video_out 1 3 1 1040
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 7 11 2090 680 NJ 680 NJ 680 NJ 680 NJ 580 NJ 580 NJ 580 NJ 580 NJ 580 NJ 580 NJ
preplace netloc v_osd_1_video_out 1 18 1 5750
preplace netloc onsemi_vita_spi_1_IO_SPI_OUT 1 20 1 NJ
preplace netloc v_osd_0_video_out 1 18 1 5790
preplace netloc fmc_imageon_iic_1_IIC 1 20 1 NJ
preplace netloc v_tc_0_vtiming_out 1 18 1 5730
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 11 9 N 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ
preplace netloc processing_system7_0_FCLK_RESET1_N 1 0 10 0 1290 NJ 1290 NJ 1290 NJ 1290 NJ 1290 NJ 1290 NJ 1290 NJ 1290 NJ 1290 2930
preplace netloc onsemi_vita_cam_1_VID_IO_OUT 1 12 1 4010
preplace netloc processing_system7_0_DDR 1 9 12 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ
preplace netloc v_cfa_1_video_out 1 14 1 4590
preplace netloc processing_system7_0_FCLK_RESET3_N 1 2 8 690 1300 NJ 1300 NJ 1300 NJ 1300 NJ 1300 NJ 1300 NJ 1300 2920
preplace netloc avnet_hdmi_out_1_IO_HDMIO 1 20 1 NJ
preplace netloc xlconstant_1_dout 1 1 19 300 780 650 920 1010 920 1280 960 1530 1170 NJ 1330 NJ 1330 NJ 1330 NJ 1330 N 1330 3680 1410 4000 1030 4350 850 4600 850 4850 840 NJ 840 5430 750 5770 750 6020
preplace netloc rst_processing_system7_0_76M_interconnect_aresetn 1 1 10 290 90 NJ 90 NJ 90 NJ 90 NJ 90 NJ 90 NJ 90 NJ 90 NJ 90 NJ
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 6 6 1770 -10 NJ -10 NJ -10 NJ -10 N -10 3630
preplace netloc axi_vdma_1_M_AXIS_MM2S 1 17 1 5420
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 10 -10 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 NJ 1280 2940
preplace netloc rst_processing_system7_0_76M_peripheral_aresetn 1 1 19 310 810 620 1160 1030 1160 NJ 1160 NJ 1180 1770 1240 NJ 1240 NJ 1240 N 1240 3250 1340 3640 1390 3990 1050 4330 810 NJ 810 NJ 810 5070 810 5450 510 5780 510 6050
preplace netloc rst_processing_system7_0_148_5M1_peripheral_aresetn 1 11 7 3640 1130 NJ 1140 NJ 1140 NJ 1140 NJ 1140 NJ 1140 NJ
preplace netloc processing_system7_0_axi_periph_M10_AXI 1 11 3 N 420 NJ 420 NJ
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 11 7 N 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 1 11 350 670 NJ 670 NJ 670 NJ 670 NJ 670 NJ 670 NJ 670 NJ 670 NJ 670 N 670 3620
preplace netloc processing_system7_0_axi_periph_M07_AXI 1 11 9 N 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ 360 NJ
preplace netloc processing_system7_0_axi_periph_M09_AXI 1 11 9 3650 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ
preplace netloc processing_system7_0_axi_periph_M11_AXI 1 11 7 N 440 NJ 440 NJ 440 NJ 440 NJ 440 NJ 440 NJ
preplace netloc rst_processing_system7_0_149M_peripheral_aresetn 1 3 15 1020 900 1290 1140 1520 1230 NJ 1230 2150 1150 NJ 1150 NJ 990 NJ 990 NJ 990 NJ 990 4300 840 4610 840 4830 820 NJ 820 5480
preplace netloc axi_vdma_1_M_AXI_MM2S 1 7 1 2100
preplace netloc fmc_imageon_iic_0_gpo 1 20 1 NJ
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 11 6 N 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ
preplace netloc v_cresample_1_video_out 1 16 1 N
preplace netloc processing_system7_0_FCLK_CLK0 1 0 20 -20 860 330 800 NJ 890 1030 890 NJ 890 NJ 890 1760 720 NJ 720 2490 720 2930 720 3220 720 3630 800 NJ 800 4320 800 NJ 800 NJ 800 5090 800 5440 500 NJ 500 6040
preplace netloc v_tc_1_vtiming_out 1 18 1 N
preplace netloc rst_processing_system7_0_148_5M_peripheral_aresetn 1 1 17 290 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1400 NJ 1130 NJ 1130 NJ 1130 NJ 1130 NJ 1130 NJ
preplace netloc processing_system7_0_FCLK_CLK1 1 2 17 680 910 1050 910 1300 980 1510 990 1750 990 2140 730 2470 1080 2970 980 NJ 980 NJ 980 4030 950 4340 860 4580 1010 4860 1000 5100 850 5460 800 5760
preplace netloc processing_system7_0_FCLK_CLK2 1 1 11 350 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 2950 1250 NJ 1290 3670
preplace netloc v_rgb2ycrcb_0_video_out 1 5 1 N
preplace netloc rst_processing_system7_0_148_5M_peripheral_reset 1 1 1 320
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 11 9 3640 20 NJ 20 NJ 20 NJ 20 NJ 20 NJ 20 NJ 20 NJ 20 NJ
preplace netloc processing_system7_0_FCLK_CLK3 1 9 1 2960
preplace netloc fmc_imageon_iic_0_IIC 1 20 1 NJ
preplace netloc v_cresample_0_video_out 1 6 1 1740
preplace netloc onsemi_vita_spi_0_IO_SPI_OUT 1 20 1 NJ
preplace netloc onsemi_vita_cam_0_VID_IO_OUT 1 2 1 630
preplace netloc avnet_hdmi_out_0_IO_HDMIO 1 20 1 NJ
preplace netloc clk_wiz_0_clk_out1 1 0 20 -20 910 340 820 640 870 NJ 860 NJ 860 NJ 860 NJ 860 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1430 NJ 1270 NJ 1270 NJ 1270 NJ 1270 5450 1060 5740 1050 NJ
preplace netloc rst_processing_system7_0_76M_peripheral_reset 1 1 19 NJ 770 660 880 NJ 870 NJ 870 NJ 870 NJ 870 NJ 1440 NJ 1440 NJ 1440 NJ 1440 NJ 1440 4050 1440 NJ 1440 NJ 1440 NJ 1440 NJ 1440 NJ 1440 5790 1060 6050
preplace netloc processing_system7_0_M_AXI_GP0 1 9 2 2980 50 N
preplace netloc xlconstant_0_dout 1 1 11 340 1200 NJ 1200 NJ 1200 NJ 1200 NJ 1200 NJ 1320 NJ 1320 NJ 1320 NJ 1320 NJ 1320 NJ
preplace netloc axi_mem_intercon_M00_AXI 1 8 1 2480
preplace netloc IO_CAM_IN_1 1 0 2 NJ 890 NJ
preplace netloc v_vid_in_axi4s_1_video_out 1 13 1 4310
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 3 9 1060 1310 NJ 1310 NJ 1310 NJ 1310 NJ 1310 NJ 1310 NJ 1300 N 1300 3610
preplace netloc rst_processing_system7_0_148_5M1_peripheral_reset 1 11 1 3620
preplace netloc IO_CAM_IN_2 1 0 12 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1260 NJ 1270 NJ
preplace netloc v_cfa_0_video_out 1 4 1 N
preplace netloc clk_1 1 0 20 NJ 1250 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1240 NJ 1270 NJ 1270 NJ 1270 N 1270 3220 1280 3650 1120 4020 1120 NJ 1120 NJ 1120 NJ 1120 NJ 1120 5470 1220 5720 1320 NJ
preplace netloc processing_system7_0_FCLK_RESET2_N 1 9 2 2980 1000 3260
preplace netloc v_axi4s_vid_out_0_vid_io_out 1 19 1 N
levelinfo -pg 1 -40 150 500 860 1180 1410 1640 1940 2330 2710 3120 3460 3867 4177 4470 4720 4970 5260 5600 5900 6200 6380 -top -30 -bot 1450
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


