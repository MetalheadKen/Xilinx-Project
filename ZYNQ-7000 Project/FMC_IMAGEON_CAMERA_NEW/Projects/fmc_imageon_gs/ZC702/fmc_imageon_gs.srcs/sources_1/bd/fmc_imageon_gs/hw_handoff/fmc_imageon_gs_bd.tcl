
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
CONFIG.PCW_EN_CLK0_PORT {1} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_CLK3_PORT {1} \
CONFIG.PCW_EN_RST0_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_EN_RST2_PORT {1} \
CONFIG.PCW_EN_RST3_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {75} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.preset {ZC702} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {9} \
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
CONFIG.HAS_AXI4_LITE {false} \
CONFIG.VIDEO_MODE {1080p} \
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

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

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
  connect_bd_net -net clk_2 [get_bd_ports fmc_imageon_vclk_l] [get_bd_pins onsemi_vita_cam_L_0/clk] [get_bd_pins rst_processing_system7_0_148_5M1/slowest_sync_clk] [get_bd_pins v_vid_in_axi4s_2/vid_io_in_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports fmc_imageon_vclk_r] [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins onsemi_vita_cam_0/clk] [get_bd_pins rst_processing_system7_0_148_5M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net fmc_imageon_iic_0_gpo [get_bd_ports fmc_imageon_iic_rst_n] [get_bd_pins fmc_imageon_iic_0/gpo]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins fmc_imageon_iic_0/s_axi_aclk] [get_bd_pins onsemi_vita_cam_0/s00_axi_aclk] [get_bd_pins onsemi_vita_cam_L_0/s00_axi_aclk] [get_bd_pins onsemi_vita_spi_0/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/M07_ACLK] [get_bd_pins processing_system7_0_axi_periph/M08_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_76M/slowest_sync_clk] [get_bd_pins v_cfa_0/s_axi_aclk] [get_bd_pins v_cfa_1/s_axi_aclk] [get_bd_pins v_osd_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_mem_intercon/S02_ACLK] [get_bd_pins axi_mem_intercon/S03_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins rst_processing_system7_0_149M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_cfa_0/aclk] [get_bd_pins v_cfa_1/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_cresample_1/aclk] [get_bd_pins v_osd_0/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk] [get_bd_pins v_rgb2ycrcb_1/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins v_vid_in_axi4s_2/aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_vita_cam_0/clk200] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net processing_system7_0_FCLK_CLK3 [get_bd_pins onsemi_vita_cam_L_0/clk200] [get_bd_pins processing_system7_0/FCLK_CLK3]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_76M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins rst_processing_system7_0_149M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET2_N [get_bd_pins processing_system7_0/FCLK_RESET2_N] [get_bd_pins rst_processing_system7_0_148_5M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET3_N [get_bd_pins processing_system7_0/FCLK_RESET3_N] [get_bd_pins rst_processing_system7_0_148_5M1/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_148_5M1_peripheral_reset [get_bd_pins onsemi_vita_cam_L_0/reset] [get_bd_pins rst_processing_system7_0_148_5M1/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_aresetn [get_bd_pins rst_processing_system7_0_148_5M/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_reset [get_bd_pins onsemi_vita_cam_0/reset] [get_bd_pins rst_processing_system7_0_148_5M/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_149M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_149M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_149M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_mem_intercon/S02_ARESETN] [get_bd_pins axi_mem_intercon/S03_ARESETN] [get_bd_pins rst_processing_system7_0_149M/peripheral_aresetn] [get_bd_pins v_cfa_0/aresetn] [get_bd_pins v_cfa_1/aresetn] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_cresample_1/aresetn] [get_bd_pins v_osd_0/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn] [get_bd_pins v_rgb2ycrcb_1/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_76M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_aresetn [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins fmc_imageon_iic_0/s_axi_aresetn] [get_bd_pins onsemi_vita_cam_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_cam_L_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_spi_0/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M07_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M08_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_76M/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_cfa_0/s_axi_aresetn] [get_bd_pins v_cfa_1/s_axi_aresetn] [get_bd_pins v_osd_0/s_axi_aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn] [get_bd_pins v_vid_in_axi4s_2/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_reset [get_bd_pins avnet_hdmi_out_0/reset] [get_bd_pins rst_processing_system7_0_76M/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset] [get_bd_pins v_vid_in_axi4s_2/vid_io_in_reset]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins onsemi_vita_cam_0/trigger1] [get_bd_pins onsemi_vita_cam_L_0/trigger1] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins avnet_hdmi_out_0/embed_syncs] [get_bd_pins avnet_hdmi_out_0/oe] [get_bd_pins onsemi_vita_cam_0/oe] [get_bd_pins onsemi_vita_cam_L_0/oe] [get_bd_pins onsemi_vita_spi_0/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_cfa_0/aclken] [get_bd_pins v_cfa_0/s_axi_aclken] [get_bd_pins v_cfa_1/aclken] [get_bd_pins v_cfa_1/s_axi_aclken] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_cresample_1/aclken] [get_bd_pins v_osd_0/aclken] [get_bd_pins v_osd_0/s_axi_aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_rgb2ycrcb_1/aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/gen_clken] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins v_vid_in_axi4s_2/aclken] [get_bd_pins v_vid_in_axi4s_2/axis_enable] [get_bd_pins v_vid_in_axi4s_2/vid_io_in_ce] [get_bd_pins xlconstant_1/dout]

  # Create address segments
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_imageon_iic_0/S_AXI/Reg] SEG_fmc_imageon_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_0/S00_AXI/Reg] SEG_onsemi_vita_cam_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_L_0/S00_AXI/Reg] SEG_onsemi_vita_cam_L_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_spi_0/S00_AXI/Reg] SEG_onsemi_vita_spi_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/ctrl/Reg] SEG_v_cfa_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_1/ctrl/Reg] SEG_v_cfa_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_osd_0/ctrl/Reg] SEG_v_osd_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   Display-PortTypeClock: "true",
   Display-PortTypeOthers: "true",
   Display-PortTypeReset: "true",
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port IO_VITA_CAM_L -pg 1 -y 1030 -defaultsOSRD
preplace port DDR -pg 1 -y 590 -defaultsOSRD
preplace port fmc_imageon_iic -pg 1 -y 980 -defaultsOSRD
preplace port IO_HDMIO -pg 1 -y 700 -defaultsOSRD
preplace port fmc_imageon_vclk_l -pg 1 -y 1050 -defaultsOSRD
preplace port IO_VITA_SPI -pg 1 -y 870 -defaultsOSRD
preplace port IO_VITA_CAM_R -pg 1 -y 540 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 610 -defaultsOSRD
preplace port fmc_imageon_vclk_r -pg 1 -y 680 -defaultsOSRD
preplace portBus fmc_imageon_iic_rst_n -pg 1 -y 1020 -defaultsOSRD
preplace inst rst_processing_system7_0_148_5M1 -pg 1 -lvl 10 -y 890 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 18 -y 900 -defaultsOSRD
preplace inst rst_processing_system7_0_76M -pg 1 -lvl 1 -y 370 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 16 -y 1060 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 17 -y 1060 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 1 -y 980 -defaultsOSRD
preplace inst fmc_imageon_iic_0 -pg 1 -lvl 19 -y 1000 -defaultsOSRD
preplace inst axi_vdma_1 -pg 1 -lvl 7 -y 670 -defaultsOSRD
preplace inst v_cfa_0 -pg 1 -lvl 4 -y 670 -defaultsOSRD
preplace inst v_cfa_1 -pg 1 -lvl 13 -y 1110 -defaultsOSRD -resize 160 200
preplace inst xlconstant_1 -pg 1 -lvl 1 -y 900 -defaultsOSRD
preplace inst rst_processing_system7_0_148_5M -pg 1 -lvl 1 -y 780 -defaultsOSRD
preplace inst onsemi_vita_cam_0 -pg 1 -lvl 2 -y 600 -defaultsOSRD
preplace inst v_osd_0 -pg 1 -lvl 17 -y 830 -defaultsOSRD
preplace inst v_cresample_0 -pg 1 -lvl 6 -y 720 -defaultsOSRD
preplace inst v_cresample_1 -pg 1 -lvl 15 -y 1310 -defaultsOSRD -resize 165 104
preplace inst rst_processing_system7_0_149M -pg 1 -lvl 3 -y 420 -defaultsOSRD
preplace inst onsemi_vita_cam_L -pg 1 -lvl 11 -y 1090 -defaultsOSRD
preplace inst v_vid_in_axi4s_0 -pg 1 -lvl 3 -y 660 -defaultsOSRD
preplace inst v_vid_in_axi4s_2 -pg 1 -lvl 12 -y 1110 -defaultsOSRD -resize 180 220
preplace inst v_rgb2ycrcb_0 -pg 1 -lvl 5 -y 690 -defaultsOSRD
preplace inst v_rgb2ycrcb_1 -pg 1 -lvl 14 -y 1200 -defaultsOSRD -resize 160 120
preplace inst onsemi_vita_spi_0 -pg 1 -lvl 19 -y 870 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 8 -y 710 -defaultsOSRD
preplace inst avnet_hdmi_out_0 -pg 1 -lvl 19 -y 710 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 10 -y 290 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 9 -y 730 -defaultsOSRD
preplace netloc IO_VITA_CAM_L_1 1 0 11 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ
preplace netloc processing_system7_0_DDR 1 9 11 NJ 590 NJ 590 NJ 590 NJ 590 NJ 590 NJ 590 NJ 590 NJ 590 NJ 590 NJ 590 NJ
preplace netloc v_rgb2ycrcb_1_video_out 1 14 1 4270
preplace netloc processing_system7_0_FCLK_CLK3 1 9 2 2840 800 NJ
preplace netloc xlconstant_1_dout 1 1 18 320 450 640 540 970 790 1230 780 1460 800 NJ 800 NJ 1010 NJ 1010 NJ 1010 3230 1230 3560 1260 3820 1260 4060 1290 4290 1180 NJ 1180 4880 700 5140 720 5450
preplace netloc rst_processing_system7_0_149M_peripheral_aresetn 1 3 14 990 550 1220 770 1450 840 NJ 840 2030 990 NJ 990 NJ 990 NJ 950 NJ 950 3780 1230 4040 1280 4260 850 NJ 850 N
preplace netloc rst_processing_system7_0_149M_interconnect_aresetn 1 3 5 NJ 440 NJ 440 NJ 440 NJ 440 1980
preplace netloc v_vid_in_axi4s_0_video_out 1 3 1 N
preplace netloc axi_vdma_1_M_AXI_S2MM 1 7 1 2030
preplace netloc processing_system7_0_axi_periph_M08_AXI 1 10 1 3280
preplace netloc v_cresample_1_video_out 1 15 1 4560
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 1 10 370 330 NJ 330 NJ 330 NJ 330 NJ 330 NJ 330 NJ 330 NJ 330 NJ 580 3270
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 10 9 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 5430
preplace netloc rst_processing_system7_0_76M_peripheral_aresetn 1 1 18 330 430 650 780 1000 800 NJ 800 NJ 810 1670 810 NJ 930 NJ 930 2920 1020 3210 1240 3520 1250 3830 1250 NJ 1120 NJ 1120 4540 910 4900 980 5130 750 5410
preplace netloc fmc_imageon_iic_0_gpo 1 19 1 NJ
preplace netloc onsemi_vita_cam_L_0_VID_IO_OUT 1 11 1 3520
preplace netloc processing_system7_0_axi_periph_M07_AXI 1 10 3 NJ 350 NJ 350 3800
preplace netloc v_axi4s_vid_out_0_vid_io_out 1 18 1 5420
preplace netloc processing_system7_0_M_AXI_GP0 1 9 1 2840
preplace netloc axi_vdma_1_M_AXI_MM2S 1 7 1 2030
preplace netloc axi_vdma_0_M_AXI_MM2S 1 7 10 2060 500 NJ 520 NJ 640 NJ 640 NJ 640 NJ 640 NJ 640 NJ 640 NJ 640 4840
preplace netloc v_cfa_1_video_out 1 13 1 4040
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 6 5 1690 480 NJ 480 NJ 480 NJ 600 3260
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 16 1 4890
preplace netloc processing_system7_0_FCLK_RESET3_N 1 9 1 N
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 10 20 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 2820
preplace netloc v_osd_0_video_out 1 17 1 N
preplace netloc v_cresample_0_video_out 1 6 1 1660
preplace netloc axi_mem_intercon_M00_AXI 1 8 1 2350
preplace netloc processing_system7_0_FCLK_RESET2_N 1 0 10 30 690 NJ 730 NJ 830 NJ 830 NJ 830 NJ 830 NJ 830 NJ 940 NJ 940 2800
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 10 7 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 4920
preplace netloc processing_system7_0_FCLK_RESET1_N 1 2 8 680 310 NJ 310 NJ 310 NJ 310 NJ 310 NJ 310 NJ 310 2810
preplace netloc fmc_imageon_iic_0_IIC 1 19 1 NJ
preplace netloc v_cfa_0_video_out 1 4 1 N
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 10 9 NJ 330 NJ 330 NJ 330 NJ 330 NJ 330 NJ 330 NJ 330 NJ 330 5440
preplace netloc axi_vdma_1_M_AXIS_MM2S 1 7 10 2010 430 NJ 430 NJ 660 NJ 660 NJ 660 NJ 660 NJ 660 NJ 660 NJ 660 NJ
preplace netloc xlconstant_0_dout 1 1 10 360 980 NJ 980 NJ 980 NJ 980 NJ 980 NJ 980 NJ 1000 NJ 1000 NJ 1000 NJ
preplace netloc onsemi_vita_spi_0_IO_SPI_OUT 1 19 1 NJ
preplace netloc processing_system7_0_FIXED_IO 1 9 11 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ 610 NJ
preplace netloc v_vid_in_axi4s_2_video_out 1 12 1 N
preplace netloc rst_processing_system7_0_148_5M1_peripheral_reset 1 10 1 3250
preplace netloc clk_2 1 0 12 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 NJ 1050 2930 1050 3220 1220 3540
preplace netloc rst_processing_system7_0_76M_peripheral_reset 1 1 18 N 370 670 510 NJ 430 NJ 430 NJ 430 NJ 430 NJ 440 NJ 440 NJ 680 NJ 680 3550 690 NJ 690 NJ 690 NJ 690 NJ 690 NJ 690 5150 700 N
preplace netloc clk_wiz_0_clk_out1 1 0 19 20 580 340 470 660 520 NJ 520 NJ 520 NJ 520 NJ 520 NJ 470 NJ 530 NJ 670 NJ 670 NJ 670 NJ 670 NJ 670 NJ 670 NJ 670 4870 680 5170 680 N
preplace netloc avnet_hdmi_out_0_IO_HDMIO 1 19 1 NJ
preplace netloc rst_processing_system7_0_76M_interconnect_aresetn 1 1 9 320 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ 110 NJ
preplace netloc v_rgb2ycrcb_0_video_out 1 5 1 N
preplace netloc onsemi_vita_cam_0_VID_IO_OUT 1 2 1 N
preplace netloc processing_system7_0_FCLK_CLK0 1 0 19 30 280 350 320 NJ 320 1000 530 NJ 530 NJ 530 1670 530 NJ 450 2370 470 2870 730 3260 940 NJ 940 3810 940 NJ 940 NJ 940 4510 900 4920 960 NJ 770 5400
preplace netloc v_tc_0_vtiming_out 1 17 1 5180
preplace netloc axi_vdma_0_M_AXI_S2MM 1 7 10 2050 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 10 4850
preplace netloc rst_processing_system7_0_148_5M_peripheral_reset 1 1 1 340
preplace netloc rst_processing_system7_0_148_5M_peripheral_aresetn 1 1 16 N 820 NJ 820 NJ 820 NJ 820 NJ 820 NJ 820 NJ 980 NJ 980 NJ 980 NJ 960 NJ 960 NJ 950 NJ 950 NJ 950 NJ 940 NJ
preplace netloc processing_system7_0_FCLK_CLK1 1 2 16 690 530 980 540 1230 610 1460 610 1680 550 2040 920 2370 920 2900 790 NJ 790 3530 1240 3790 1240 4030 1110 4280 1110 4550 920 4910 970 NJ
preplace netloc IO_CAM_IN_1 1 0 2 NJ 540 NJ
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 3 8 1010 490 NJ 490 NJ 490 NJ 490 NJ 490 NJ 540 NJ 570 3250
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 10 6 NJ 230 NJ 230 NJ 230 NJ 230 NJ 230 4530
preplace netloc processing_system7_0_FCLK_CLK2 1 1 9 360 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 2800
levelinfo -pg 1 0 170 510 830 1120 1340 1560 1840 2210 2590 3070 3400 3670 3930 4160 4400 4700 5020 5290 5560 5690 -top 0 -bot 1380
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


