
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
  set IO_HDMIO [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMIO ]
  set IO_VITA_CAM_L [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_VITA_CAM_L ]
  set IO_VITA_CAM_R [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_VITA_CAM_R ]
  set IO_VITA_SPI [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:onsemi_vita_spi_rtl:1.0 IO_VITA_SPI ]
  set fmc_imageon_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_imageon_iic ]

  # Create ports
  set fmc_imageon_iic_rst_n [ create_bd_port -dir O -from 0 -to 0 fmc_imageon_iic_rst_n ]
  set fmc_imageon_vclk_l [ create_bd_port -dir I fmc_imageon_vclk_l ]
  set fmc_imageon_vclk_r [ create_bd_port -dir I fmc_imageon_vclk_r ]

  # Create instance: GND, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $GND

  # Create instance: VCC, and set properties
  set VCC [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 VCC ]

  # Create instance: avnet_hdmi_out_0, and set properties
  set avnet_hdmi_out_0 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_out:3.1 avnet_hdmi_out_0 ]
  set_property -dict [ list \
CONFIG.C_DEBUG_PORT {true} \
 ] $avnet_hdmi_out_0

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
CONFIG.c_mm2s_linebuffer_depth {4096} \
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

  # Create instance: onsemi_vita_cam_0, and set properties
  set onsemi_vita_cam_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_cam:3.2 onsemi_vita_cam_0 ]

  # Create instance: onsemi_vita_cam_L_0, and set properties
  set onsemi_vita_cam_L_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_cam_L:3.2 onsemi_vita_cam_L_0 ]

  # Create instance: onsemi_vita_spi_0, and set properties
  set onsemi_vita_spi_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_spi:3.2 onsemi_vita_spi_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_EN_CLK0_PORT {1} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_CLK3_PORT {0} \
CONFIG.PCW_EN_RST0_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_EN_RST2_PORT {0} \
CONFIG.PCW_EN_RST3_PORT {0} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {142} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_M_AXI_GP1 {0} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {0} \
CONFIG.preset {ZC702} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {10} \
 ] $processing_system7_0_axi_periph

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
CONFIG.LAYER0_HEIGHT {1080} \
CONFIG.LAYER0_WIDTH {1920} \
CONFIG.LAYER1_HEIGHT {1080} \
CONFIG.LAYER1_WIDTH {1920} \
CONFIG.M_AXIS_VIDEO_HEIGHT {1080} \
CONFIG.M_AXIS_VIDEO_WIDTH {1920} \
CONFIG.NUMBER_OF_LAYERS {2} \
CONFIG.SCREEN_WIDTH {1920} \
 ] $v_osd_0

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
CONFIG.GEN_F0_VBLANK_HEND {1280} \
CONFIG.GEN_F0_VBLANK_HSTART {1280} \
CONFIG.GEN_F0_VFRAME_SIZE {750} \
CONFIG.GEN_F0_VSYNC_HEND {1280} \
CONFIG.GEN_F0_VSYNC_HSTART {1280} \
CONFIG.GEN_F0_VSYNC_VEND {729} \
CONFIG.GEN_F0_VSYNC_VSTART {724} \
CONFIG.GEN_F1_VBLANK_HEND {1280} \
CONFIG.GEN_F1_VBLANK_HSTART {1280} \
CONFIG.GEN_F1_VFRAME_SIZE {750} \
CONFIG.GEN_F1_VSYNC_HEND {1280} \
CONFIG.GEN_F1_VSYNC_HSTART {1280} \
CONFIG.GEN_F1_VSYNC_VEND {729} \
CONFIG.GEN_F1_VSYNC_VSTART {724} \
CONFIG.GEN_HACTIVE_SIZE {1280} \
CONFIG.GEN_HFRAME_SIZE {1650} \
CONFIG.GEN_HSYNC_END {1430} \
CONFIG.GEN_HSYNC_START {1390} \
CONFIG.GEN_VACTIVE_SIZE {720} \
CONFIG.HAS_AXI4_LITE {true} \
CONFIG.HAS_INTC_IF {false} \
CONFIG.INTERLACE_EN {false} \
CONFIG.VIDEO_MODE {720p} \
CONFIG.enable_detection {false} \
 ] $v_tc_0

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_0 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {12} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {12} \
 ] $v_vid_in_axi4s_0

  # Create instance: v_vid_in_axi4s_2, and set properties
  set v_vid_in_axi4s_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_2 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {12} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {12} \
 ] $v_vid_in_axi4s_2

  # Create interface connections
  connect_bd_intf_net -intf_net IO_CAM_IN_1 [get_bd_intf_ports IO_VITA_CAM_R] [get_bd_intf_pins onsemi_vita_cam_0/IO_CAM_IN]
  connect_bd_intf_net -intf_net IO_VITA_CAM_L_1 [get_bd_intf_ports IO_VITA_CAM_L] [get_bd_intf_pins onsemi_vita_cam_L_0/IO_CAM_IN]
  connect_bd_intf_net -intf_net avnet_hdmi_out_0_IO_HDMIO [get_bd_intf_ports IO_HDMIO] [get_bd_intf_pins avnet_hdmi_out_0/IO_HDMIO]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins v_osd_0/video_s0_in]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_1/M_AXIS_MM2S] [get_bd_intf_pins v_osd_0/video_s1_in]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S02_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S03_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_S2MM]
  connect_bd_intf_net -intf_net fmc_imageon_iic_0_IIC [get_bd_intf_ports fmc_imageon_iic] [get_bd_intf_pins fmc_imageon_iic_0/IIC]
  connect_bd_intf_net -intf_net onsemi_vita_cam_0_VID_IO_OUT [get_bd_intf_pins onsemi_vita_cam_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_0/vid_io_in]
  connect_bd_intf_net -intf_net onsemi_vita_cam_L_0_VID_IO_OUT [get_bd_intf_pins onsemi_vita_cam_L_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_2/vid_io_in]
  connect_bd_intf_net -intf_net onsemi_vita_spi_0_IO_SPI_OUT [get_bd_intf_ports IO_VITA_SPI] [get_bd_intf_pins onsemi_vita_spi_0/IO_SPI_OUT]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins fmc_imageon_iic_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI] [get_bd_intf_pins v_osd_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins onsemi_vita_cam_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI] [get_bd_intf_pins v_cfa_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_vdma_1/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins onsemi_vita_spi_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M07_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M07_AXI] [get_bd_intf_pins v_cfa_1/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M08_AXI [get_bd_intf_pins onsemi_vita_cam_L_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M09_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M09_AXI] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins avnet_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_cfa_0_video_out [get_bd_intf_pins v_cfa_0/video_out] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
  connect_bd_intf_net -intf_net v_cfa_1_video_out [get_bd_intf_pins v_cfa_1/video_out] [get_bd_intf_pins v_rgb2ycrcb_1/video_in]
  connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM] [get_bd_intf_pins v_cresample_0/video_out]
  connect_bd_intf_net -intf_net v_cresample_1_video_out [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins v_cresample_1/video_out]
  connect_bd_intf_net -intf_net v_osd_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_osd_0/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_1_video_out [get_bd_intf_pins v_cresample_1/video_in] [get_bd_intf_pins v_rgb2ycrcb_1/video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_cfa_0/video_in] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_2_video_out [get_bd_intf_pins v_cfa_1/video_in] [get_bd_intf_pins v_vid_in_axi4s_2/video_out]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_mem_intercon/S02_ARESETN] [get_bd_pins axi_mem_intercon/S03_ARESETN] [get_bd_pins rst_processing_system7_0_149M/peripheral_aresetn] [get_bd_pins v_cfa_0/aresetn] [get_bd_pins v_cfa_1/aresetn] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_cresample_1/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn] [get_bd_pins v_rgb2ycrcb_1/aresetn]
  connect_bd_net -net clk_2 [get_bd_ports fmc_imageon_vclk_l] [get_bd_pins onsemi_vita_cam_L_0/clk] [get_bd_pins v_vid_in_axi4s_2/vid_io_in_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports fmc_imageon_vclk_r] [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins onsemi_vita_cam_0/clk] [get_bd_pins rst_processing_system7_0_149M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net fmc_imageon_iic_0_gpo [get_bd_ports fmc_imageon_iic_rst_n] [get_bd_pins fmc_imageon_iic_0/gpo]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins fmc_imageon_iic_0/s_axi_aclk] [get_bd_pins onsemi_vita_cam_0/s00_axi_aclk] [get_bd_pins onsemi_vita_cam_L_0/s00_axi_aclk] [get_bd_pins onsemi_vita_spi_0/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/M07_ACLK] [get_bd_pins processing_system7_0_axi_periph/M08_ACLK] [get_bd_pins processing_system7_0_axi_periph/M09_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_76M/slowest_sync_clk] [get_bd_pins v_cfa_0/s_axi_aclk] [get_bd_pins v_cfa_1/s_axi_aclk] [get_bd_pins v_osd_0/s_axi_aclk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_mem_intercon/S02_ACLK] [get_bd_pins axi_mem_intercon/S03_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_cfa_0/aclk] [get_bd_pins v_cfa_1/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_cresample_1/aclk] [get_bd_pins v_osd_0/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk] [get_bd_pins v_rgb2ycrcb_1/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins v_vid_in_axi4s_2/aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_vita_cam_0/clk200] [get_bd_pins onsemi_vita_cam_L_0/clk200] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_76M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins rst_processing_system7_0_149M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_149M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_149M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_76M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_aresetn [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins fmc_imageon_iic_0/s_axi_aresetn] [get_bd_pins onsemi_vita_cam_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_cam_L_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_spi_0/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M07_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M08_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M09_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_76M/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_cfa_0/s_axi_aresetn] [get_bd_pins v_cfa_1/s_axi_aresetn] [get_bd_pins v_osd_0/s_axi_aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn] [get_bd_pins v_vid_in_axi4s_2/aresetn]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins GND/dout] [get_bd_pins onsemi_vita_cam_0/reset] [get_bd_pins onsemi_vita_cam_0/trigger1] [get_bd_pins onsemi_vita_cam_L_0/reset] [get_bd_pins onsemi_vita_cam_L_0/trigger1] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset] [get_bd_pins v_vid_in_axi4s_2/vid_io_in_reset]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins VCC/dout] [get_bd_pins avnet_hdmi_out_0/embed_syncs] [get_bd_pins avnet_hdmi_out_0/oe] [get_bd_pins onsemi_vita_cam_0/oe] [get_bd_pins onsemi_vita_cam_L_0/oe] [get_bd_pins onsemi_vita_spi_0/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_cfa_0/aclken] [get_bd_pins v_cfa_0/s_axi_aclken] [get_bd_pins v_cfa_1/aclken] [get_bd_pins v_cfa_1/s_axi_aclken] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_cresample_1/aclken] [get_bd_pins v_osd_0/aclken] [get_bd_pins v_osd_0/aresetn] [get_bd_pins v_osd_0/s_axi_aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_rgb2ycrcb_1/aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/gen_clken] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins v_vid_in_axi4s_2/aclken] [get_bd_pins v_vid_in_axi4s_2/axis_enable] [get_bd_pins v_vid_in_axi4s_2/vid_io_in_ce]

  # Create address segments
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_imageon_iic_0/S_AXI/Reg] SEG_fmc_imageon_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_0/S00_AXI/Reg] SEG_onsemi_vita_cam_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_L_0/S00_AXI/Reg] SEG_onsemi_vita_cam_L_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_spi_0/S00_AXI/Reg] SEG_onsemi_vita_spi_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/ctrl/Reg] SEG_v_cfa_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_1/ctrl/Reg] SEG_v_cfa_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_osd_0/ctrl/Reg] SEG_v_osd_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C60000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tc_0/ctrl/Reg] SEG_v_tc_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   Display-PortTypeClock: "true",
   Display-PortTypeOthers: "true",
   Display-PortTypeReset: "true",
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port IO_VITA_CAM_L -pg 1 -y 800 -defaultsOSRD
preplace port DDR -pg 1 -y 620 -defaultsOSRD
preplace port fmc_imageon_iic -pg 1 -y 680 -defaultsOSRD
preplace port IO_HDMIO -pg 1 -y 1050 -defaultsOSRD
preplace port fmc_imageon_vclk_l -pg 1 -y 840 -defaultsOSRD
preplace port IO_VITA_SPI -pg 1 -y 830 -defaultsOSRD
preplace port IO_VITA_CAM_R -pg 1 -y 480 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 640 -defaultsOSRD
preplace port fmc_imageon_vclk_r -pg 1 -y 500 -defaultsOSRD
preplace portBus fmc_imageon_iic_rst_n -pg 1 -y 720 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 18 -y 1060 -defaultsOSRD
preplace inst rst_processing_system7_0_76M -pg 1 -lvl 1 -y 320 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 16 -y 850 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 17 -y 1020 -defaultsOSRD
preplace inst fmc_imageon_iic_0 -pg 1 -lvl 19 -y 700 -defaultsOSRD
preplace inst axi_vdma_1 -pg 1 -lvl 7 -y 550 -defaultsOSRD
preplace inst v_cfa_0 -pg 1 -lvl 4 -y 640 -defaultsOSRD
preplace inst v_cfa_1 -pg 1 -lvl 13 -y 850 -defaultsOSRD -resize 160 200
preplace inst GND -pg 1 -lvl 1 -y 550 -defaultsOSRD
preplace inst onsemi_vita_cam_0 -pg 1 -lvl 2 -y 540 -defaultsOSRD
preplace inst v_osd_0 -pg 1 -lvl 17 -y 760 -defaultsOSRD
preplace inst v_cresample_0 -pg 1 -lvl 6 -y 690 -defaultsOSRD
preplace inst rst_processing_system7_0_149M -pg 1 -lvl 3 -y 320 -defaultsOSRD
preplace inst v_cresample_1 -pg 1 -lvl 15 -y 900 -defaultsOSRD -resize 165 104
preplace inst v_vid_in_axi4s_0 -pg 1 -lvl 3 -y 600 -defaultsOSRD
preplace inst v_vid_in_axi4s_2 -pg 1 -lvl 12 -y 900 -defaultsOSRD -resize 180 220
preplace inst v_rgb2ycrcb_0 -pg 1 -lvl 5 -y 660 -defaultsOSRD
preplace inst onsemi_vita_cam_L_0 -pg 1 -lvl 11 -y 860 -defaultsOSRD
preplace inst v_rgb2ycrcb_1 -pg 1 -lvl 14 -y 870 -defaultsOSRD -resize 160 120
preplace inst VCC -pg 1 -lvl 1 -y 630 -defaultsOSRD
preplace inst onsemi_vita_spi_0 -pg 1 -lvl 19 -y 830 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 8 -y 430 -defaultsOSRD
preplace inst avnet_hdmi_out_0 -pg 1 -lvl 19 -y 1060 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 10 -y 310 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 9 -y 480 -defaultsOSRD
preplace netloc processing_system7_0_axi_periph_M09_AXI 1 10 7 NJ 400 NJ 400 NJ 400 NJ 400 NJ 400 NJ 400 4760
preplace netloc IO_VITA_CAM_L_1 1 0 11 NJ 790 NJ 790 NJ 790 NJ 790 NJ 790 NJ 790 NJ 790 NJ 790 NJ 790 NJ 790 NJ
preplace netloc processing_system7_0_DDR 1 9 11 NJ 620 NJ 620 NJ 620 NJ 620 NJ 620 NJ 620 NJ 620 NJ 620 NJ 620 NJ 620 NJ
preplace netloc v_rgb2ycrcb_1_video_out 1 14 1 N
preplace netloc rst_processing_system7_0_149M_interconnect_aresetn 1 3 5 NJ 340 NJ 340 NJ 340 NJ 340 1950
preplace netloc xlconstant_1_dout 1 1 18 330 400 620 740 950 810 1190 780 1410 780 NJ 780 NJ 780 NJ 780 NJ 780 3180 730 3460 730 3700 730 3950 730 4170 730 NJ 730 4710 1170 5000 920 5270
preplace netloc v_vid_in_axi4s_0_video_out 1 3 1 940
preplace netloc axi_vdma_1_M_AXI_S2MM 1 7 1 1960
preplace netloc processing_system7_0_axi_periph_M08_AXI 1 10 1 3190
preplace netloc v_cresample_1_video_out 1 15 1 4390
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 1 10 370 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 NJ 770 3120
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 10 9 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 5270
preplace netloc rst_processing_system7_0_76M_peripheral_aresetn 1 1 18 310 670 610 730 960 820 NJ 820 NJ 820 1640 700 NJ 700 NJ 700 2760 710 3130 990 3470 1030 3710 970 NJ 970 NJ 970 4400 970 4770 1180 5020 1190 5250
preplace netloc fmc_imageon_iic_0_gpo 1 19 1 NJ
preplace netloc onsemi_vita_cam_L_0_VID_IO_OUT 1 11 1 3440
preplace netloc processing_system7_0_axi_periph_M07_AXI 1 10 3 NJ 360 NJ 360 3710
preplace netloc v_axi4s_vid_out_0_vid_io_out 1 18 1 N
preplace netloc processing_system7_0_M_AXI_GP0 1 9 1 2790
preplace netloc axi_vdma_1_M_AXI_MM2S 1 7 1 1940
preplace netloc axi_vdma_0_M_AXI_MM2S 1 7 10 1990 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 4700
preplace netloc v_cfa_1_video_out 1 13 1 N
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 6 5 1650 670 NJ 670 NJ 670 NJ 670 3100
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 16 1 4730
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 10 20 190 NJ 190 NJ 190 NJ 190 NJ 190 NJ 190 NJ 190 NJ 190 NJ 190 2720
preplace netloc v_osd_0_video_out 1 17 1 5020
preplace netloc v_cresample_0_video_out 1 6 1 1620
preplace netloc axi_mem_intercon_M00_AXI 1 8 1 2280
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 10 7 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 4790
preplace netloc processing_system7_0_FCLK_RESET1_N 1 2 8 650 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 NJ 200 2710
preplace netloc fmc_imageon_iic_0_IIC 1 19 1 NJ
preplace netloc v_cfa_0_video_out 1 4 1 N
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 10 9 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 NJ 340 5260
preplace netloc axi_vdma_1_M_AXIS_MM2S 1 7 10 1930 160 NJ 160 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ
preplace netloc xlconstant_0_dout 1 1 11 350 390 640 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 720 3160 720 NJ
preplace netloc onsemi_vita_spi_0_IO_SPI_OUT 1 19 1 NJ
preplace netloc processing_system7_0_FIXED_IO 1 9 11 NJ 630 NJ 630 NJ 630 NJ 630 NJ 630 NJ 630 NJ 630 NJ 610 NJ 610 NJ 610 NJ
preplace netloc v_vid_in_axi4s_2_video_out 1 12 1 3710
preplace netloc clk_2 1 0 12 NJ 840 NJ 840 NJ 840 NJ 840 NJ 840 NJ 840 NJ 840 NJ 840 NJ 840 NJ 840 3150 710 NJ
preplace netloc clk_wiz_0_clk_out1 1 0 19 NJ 500 340 380 630 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 1040 NJ 1040 NJ 1040 NJ 1040 NJ 1040 NJ 1040 NJ 1040 4690 1150 4990 930 NJ
preplace netloc avnet_hdmi_out_0_IO_HDMIO 1 19 1 NJ
preplace netloc rst_processing_system7_0_76M_interconnect_aresetn 1 1 9 310 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ
preplace netloc v_rgb2ycrcb_0_video_out 1 5 1 N
preplace netloc onsemi_vita_cam_0_VID_IO_OUT 1 2 1 N
preplace netloc Net 1 3 12 930 760 1180 740 1400 610 NJ 680 1980 680 NJ 680 NJ 680 NJ 680 NJ 680 3690 700 3930 770 NJ
preplace netloc processing_system7_0_FCLK_CLK0 1 0 19 30 410 320 410 NJ 410 960 410 NJ 410 NJ 410 1640 140 NJ 140 2290 220 2810 690 3170 690 NJ 690 3720 680 NJ 680 NJ 680 4400 680 4780 630 NJ 630 5240
preplace netloc v_tc_0_vtiming_out 1 17 1 N
preplace netloc axi_vdma_0_M_AXI_S2MM 1 7 10 1990 640 NJ 640 NJ 640 NJ 640 NJ 640 NJ 640 NJ 640 NJ 640 NJ 640 4690
preplace netloc processing_system7_0_FCLK_CLK1 1 2 16 650 720 940 780 1170 750 1390 600 1630 430 1970 220 2270 330 2780 700 NJ 700 3450 720 3730 720 3940 790 4160 790 4410 720 4720 1160 NJ
preplace netloc IO_CAM_IN_1 1 0 2 NJ 480 NJ
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 3 8 970 800 NJ 800 NJ 800 NJ 800 NJ 800 NJ 800 NJ 800 3110
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 10 6 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 4390
preplace netloc processing_system7_0_FCLK_CLK2 1 1 10 360 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 2740 820 N
levelinfo -pg 1 0 170 490 790 1070 1290 1510 1790 2130 2500 2960 3310 3580 3830 4050 4280 4550 4890 5130 5380 5510 -top 0 -bot 1220
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


