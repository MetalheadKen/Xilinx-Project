
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
  set IO_HDMII [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMII ]
  set IO_HDMIO [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:1.0 IO_HDMIO ]
  set IO_VITA_CAM [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_VITA_CAM ]
  set IO_VITA_SPI [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:onsemi_vita_spi_rtl:1.0 IO_VITA_SPI ]
  set fmc_imageon_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_imageon_iic ]

  # Create ports
  set IO_HDMII_clk [ create_bd_port -dir I -type clk IO_HDMII_clk ]
  set fmc_imageon_iic_rst_n [ create_bd_port -dir O -from 0 -to 0 fmc_imageon_iic_rst_n ]
  set fmc_imageon_vclk [ create_bd_port -dir I fmc_imageon_vclk ]

  # Create instance: avnet_hdmi_in_0, and set properties
  set avnet_hdmi_in_0 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_in:3.1 avnet_hdmi_in_0 ]

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
CONFIG.c_mm2s_linebuffer_depth {512} \
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

  # Create instance: onsemi_vita_spi_0, and set properties
  set onsemi_vita_spi_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_spi:3.2 onsemi_vita_spi_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_EN_CLK0_PORT {1} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_RST0_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_EN_RST2_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {75} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.preset {ZC702} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {7} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_148_5M, and set properties
  set rst_processing_system7_0_148_5M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_148_5M ]

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

  # Create instance: v_cresample_0, and set properties
  set v_cresample_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample:4.0 v_cresample_0 ]
  set_property -dict [ list \
CONFIG.active_cols {1920} \
CONFIG.active_rows {1080} \
CONFIG.m_axis_video_format {2} \
CONFIG.s_axis_video_format {3} \
 ] $v_cresample_0

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

  # Create instance: v_vid_in_axi4s_1, and set properties
  set v_vid_in_axi4s_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_1 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {11} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {0} \
 ] $v_vid_in_axi4s_1

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net IO_CAM_IN_1 [get_bd_intf_ports IO_VITA_CAM] [get_bd_intf_pins onsemi_vita_cam_0/IO_CAM_IN]
  connect_bd_intf_net -intf_net IO_HDMII_1 [get_bd_intf_ports IO_HDMII] [get_bd_intf_pins avnet_hdmi_in_0/IO_HDMII]
  connect_bd_intf_net -intf_net avnet_hdmi_in_0_VID_IO_OUT [get_bd_intf_pins avnet_hdmi_in_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_1/vid_io_in]
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
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins avnet_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_cfa_0_video_out [get_bd_intf_pins v_cfa_0/video_out] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
  connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM] [get_bd_intf_pins v_cresample_0/video_out]
  connect_bd_intf_net -intf_net v_osd_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_osd_0/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_cfa_0/video_in] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_1_video_out [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins v_vid_in_axi4s_1/video_out]

  # Create port connections
  connect_bd_net -net avnet_hdmi_in_0_audio_spdif [get_bd_pins avnet_hdmi_in_0/audio_spdif] [get_bd_pins avnet_hdmi_out_0/audio_spdif]
  connect_bd_net -net clk_1 [get_bd_ports IO_HDMII_clk] [get_bd_pins avnet_hdmi_in_0/clk] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports fmc_imageon_vclk] [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins onsemi_vita_cam_0/clk] [get_bd_pins rst_processing_system7_0_148_5M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net fmc_imageon_iic_0_gpo [get_bd_ports fmc_imageon_iic_rst_n] [get_bd_pins fmc_imageon_iic_0/gpo]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins fmc_imageon_iic_0/s_axi_aclk] [get_bd_pins onsemi_vita_cam_0/s00_axi_aclk] [get_bd_pins onsemi_vita_spi_0/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_76M/slowest_sync_clk] [get_bd_pins v_cfa_0/s_axi_aclk] [get_bd_pins v_osd_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_mem_intercon/S02_ACLK] [get_bd_pins axi_mem_intercon/S03_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins rst_processing_system7_0_149M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_cfa_0/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_osd_0/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins v_vid_in_axi4s_1/aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_vita_cam_0/clk200] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_76M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins rst_processing_system7_0_149M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET2_N [get_bd_pins processing_system7_0/FCLK_RESET2_N] [get_bd_pins rst_processing_system7_0_148_5M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_aresetn [get_bd_pins rst_processing_system7_0_148_5M/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_reset [get_bd_pins onsemi_vita_cam_0/reset] [get_bd_pins rst_processing_system7_0_148_5M/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_149M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_149M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_149M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_mem_intercon/S02_ARESETN] [get_bd_pins axi_mem_intercon/S03_ARESETN] [get_bd_pins rst_processing_system7_0_149M/peripheral_aresetn] [get_bd_pins v_cfa_0/aresetn] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_osd_0/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_76M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_aresetn [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins fmc_imageon_iic_0/s_axi_aresetn] [get_bd_pins onsemi_vita_cam_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_spi_0/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_76M/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_cfa_0/s_axi_aresetn] [get_bd_pins v_osd_0/s_axi_aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_reset [get_bd_pins avnet_hdmi_out_0/reset] [get_bd_pins rst_processing_system7_0_76M/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins onsemi_vita_cam_0/trigger1] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_reset] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins avnet_hdmi_out_0/embed_syncs] [get_bd_pins avnet_hdmi_out_0/oe] [get_bd_pins onsemi_vita_cam_0/oe] [get_bd_pins onsemi_vita_spi_0/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_cfa_0/aclken] [get_bd_pins v_cfa_0/s_axi_aclken] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_osd_0/aclken] [get_bd_pins v_osd_0/s_axi_aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/gen_clken] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins v_vid_in_axi4s_1/aclken] [get_bd_pins v_vid_in_axi4s_1/aresetn] [get_bd_pins v_vid_in_axi4s_1/axis_enable] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_ce] [get_bd_pins xlconstant_1/dout]

  # Create address segments
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_imageon_iic_0/S_AXI/Reg] SEG_fmc_imageon_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_0/S00_AXI/Reg] SEG_onsemi_vita_cam_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_spi_0/S00_AXI/Reg] SEG_onsemi_vita_spi_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/ctrl/Reg] SEG_v_cfa_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_osd_0/ctrl/Reg] SEG_v_osd_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 490 -defaultsOSRD
preplace port fmc_imageon_iic -pg 1 -y 560 -defaultsOSRD
preplace port IO_HDMIO -pg 1 -y 1100 -defaultsOSRD
preplace port fmc_imageon_vclk -pg 1 -y 1130 -defaultsOSRD
preplace port IO_VITA_SPI -pg 1 -y 950 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 510 -defaultsOSRD
preplace port IO_HDMII_clk -pg 1 -y 900 -defaultsOSRD
preplace port IO_VITA_CAM -pg 1 -y 830 -defaultsOSRD
preplace port IO_HDMII -pg 1 -y 880 -defaultsOSRD
preplace portBus fmc_imageon_iic_rst_n -pg 1 -y 600 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 14 -y 1050 -defaultsOSRD
preplace inst rst_processing_system7_0_76M -pg 1 -lvl 2 -y 450 -defaultsOSRD
preplace inst avnet_hdmi_in_0 -pg 1 -lvl 1 -y 890 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 3 -y 480 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 13 -y 1010 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 1 -y 1080 -defaultsOSRD
preplace inst fmc_imageon_iic_0 -pg 1 -lvl 15 -y 580 -defaultsOSRD
preplace inst axi_vdma_1 -pg 1 -lvl 12 -y 660 -defaultsOSRD
preplace inst v_cfa_0 -pg 1 -lvl 9 -y 880 -defaultsOSRD
preplace inst xlconstant_1 -pg 1 -lvl 1 -y 1000 -defaultsOSRD
preplace inst rst_processing_system7_0_148_5M -pg 1 -lvl 6 -y 1160 -defaultsOSRD
preplace inst onsemi_vita_cam_0 -pg 1 -lvl 7 -y 890 -defaultsOSRD
preplace inst v_osd_0 -pg 1 -lvl 13 -y 680 -defaultsOSRD
preplace inst v_cresample_0 -pg 1 -lvl 11 -y 810 -defaultsOSRD
preplace inst rst_processing_system7_0_149M -pg 1 -lvl 3 -y 670 -defaultsOSRD
preplace inst v_vid_in_axi4s_0 -pg 1 -lvl 8 -y 910 -defaultsOSRD
preplace inst v_vid_in_axi4s_1 -pg 1 -lvl 2 -y 950 -defaultsOSRD
preplace inst v_rgb2ycrcb_0 -pg 1 -lvl 10 -y 810 -defaultsOSRD
preplace inst onsemi_vita_spi_0 -pg 1 -lvl 15 -y 950 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 4 -y 580 -defaultsOSRD
preplace inst avnet_hdmi_out_0 -pg 1 -lvl 15 -y 1110 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 6 -y 230 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 5 -y 610 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 5 11 NJ 500 NJ 500 NJ 500 NJ 500 NJ 500 NJ 500 NJ 500 NJ 480 NJ 480 NJ 480 NJ
preplace netloc xlconstant_1_dout 1 1 14 260 790 NJ 790 NJ 810 NJ 790 NJ 790 2090 760 2370 760 2610 760 2860 910 3120 910 NJ 910 3670 1100 3940 1200 4200
preplace netloc rst_processing_system7_0_149M_peripheral_aresetn 1 3 10 930 850 NJ 850 NJ 750 NJ 750 NJ 750 2630 750 2870 900 3130 900 NJ 900 3680
preplace netloc rst_processing_system7_0_149M_interconnect_aresetn 1 3 1 910
preplace netloc v_vid_in_axi4s_0_video_out 1 8 1 2600
preplace netloc axi_vdma_1_M_AXI_S2MM 1 3 10 970 350 NJ 350 NJ 490 NJ 490 NJ 490 NJ 490 NJ 490 NJ 490 NJ 490 3670
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 6 1 2100
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 6 9 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 NJ 170 4220
preplace netloc rst_processing_system7_0_76M_peripheral_aresetn 1 2 13 580 300 NJ 300 NJ 300 1750 540 2050 1020 2380 1030 2640 730 NJ 730 NJ 730 3360 790 3700 850 3950 850 4220
preplace netloc fmc_imageon_iic_0_gpo 1 15 1 NJ
preplace netloc v_axi4s_vid_out_0_vid_io_out 1 14 1 4170
preplace netloc processing_system7_0_M_AXI_GP0 1 5 1 1680
preplace netloc axi_vdma_1_M_AXI_MM2S 1 3 10 960 340 NJ 340 NJ 510 NJ 510 NJ 510 NJ 510 NJ 510 NJ 510 NJ 510 3660
preplace netloc axi_vdma_0_M_AXI_MM2S 1 3 1 950
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 6 6 NJ 270 NJ 270 NJ 270 NJ 270 NJ 270 3380
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 3 10 NJ 320 NJ 320 NJ 470 NJ 470 NJ 470 NJ 470 NJ 470 NJ 470 NJ 470 3700
preplace netloc processing_system7_0_FCLK_RESET0_N 1 1 5 240 780 NJ 780 NJ 830 NJ 830 1700
preplace netloc v_vid_in_axi4s_1_video_out 1 2 1 600
preplace netloc v_osd_0_video_out 1 13 1 3940
preplace netloc v_cresample_0_video_out 1 11 1 3350
preplace netloc axi_mem_intercon_M00_AXI 1 4 1 1250
preplace netloc processing_system7_0_FCLK_RESET2_N 1 5 1 1740
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 6 7 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 3710
preplace netloc processing_system7_0_FCLK_RESET1_N 1 2 4 620 840 NJ 840 NJ 840 1680
preplace netloc v_cfa_0_video_out 1 9 1 2890
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 6 9 N 290 NJ 290 NJ 290 NJ 290 NJ 290 NJ 290 NJ 290 NJ 290 NJ
preplace netloc fmc_imageon_iic_0_IIC 1 15 1 NJ
preplace netloc axi_vdma_1_M_AXIS_MM2S 1 12 1 N
preplace netloc xlconstant_0_dout 1 1 6 270 830 NJ 830 NJ 930 NJ 930 NJ 930 N
preplace netloc clk_1 1 0 2 20 830 250
preplace netloc onsemi_vita_spi_0_IO_SPI_OUT 1 15 1 NJ
preplace netloc processing_system7_0_FIXED_IO 1 5 11 NJ 520 NJ 520 NJ 520 NJ 520 NJ 520 NJ 520 NJ 520 NJ 510 NJ 510 NJ 510 NJ
preplace netloc rst_processing_system7_0_76M_peripheral_reset 1 2 13 570 330 NJ 330 NJ 330 NJ 530 NJ 530 2380 720 NJ 720 NJ 920 NJ 920 NJ 920 NJ 920 3910 1190 NJ
preplace netloc clk_wiz_0_clk_out1 1 0 15 NJ 1130 NJ 1120 NJ 1120 NJ 1120 NJ 1120 1760 870 2080 740 2350 710 NJ 710 NJ 710 NJ 710 NJ 800 3660 1090 3920 1180 NJ
preplace netloc avnet_hdmi_out_0_IO_HDMIO 1 15 1 NJ
preplace netloc avnet_hdmi_in_0_VID_IO_OUT 1 1 1 N
preplace netloc rst_processing_system7_0_76M_interconnect_aresetn 1 2 4 560 320 NJ 90 NJ 90 NJ
preplace netloc v_rgb2ycrcb_0_video_out 1 10 1 3100
preplace netloc onsemi_vita_cam_0_VID_IO_OUT 1 7 1 2340
preplace netloc processing_system7_0_FCLK_CLK0 1 1 14 280 360 610 340 NJ 370 1260 370 1710 630 2040 690 NJ 690 2650 680 NJ 680 NJ 680 3380 780 3710 810 NJ 810 4210
preplace netloc v_tc_0_vtiming_out 1 13 1 3920
preplace netloc axi_vdma_0_M_AXI_S2MM 1 3 1 930
preplace netloc IO_HDMII_1 1 0 1 NJ
preplace netloc rst_processing_system7_0_148_5M_peripheral_reset 1 6 1 2070
preplace netloc rst_processing_system7_0_148_5M_peripheral_aresetn 1 6 7 NJ 1040 NJ 1040 NJ 1040 NJ 1040 NJ 1040 NJ 1040 N
preplace netloc processing_system7_0_FCLK_CLK1 1 1 13 280 630 590 350 940 790 1250 780 1720 720 NJ 720 2360 740 2660 740 2900 890 3110 890 3370 810 3690 830 NJ
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 6 3 N 250 NJ 250 NJ
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 5 620 360 NJ 360 NJ 360 NJ 480 2040
preplace netloc IO_CAM_IN_1 1 0 7 NJ 820 NJ 820 NJ 820 NJ 820 NJ 820 NJ 820 NJ
preplace netloc processing_system7_0_FCLK_CLK2 1 5 2 N 670 NJ
preplace netloc avnet_hdmi_in_0_audio_spdif 1 1 14 240 800 NJ 800 NJ 800 NJ 800 NJ 700 NJ 700 NJ 700 NJ 700 NJ 700 NJ 700 NJ 820 NJ 820 NJ 820 NJ
levelinfo -pg 1 -10 130 420 770 1110 1470 1900 2220 2490 2760 3000 3230 3520 3810 4060 4330 4460 -top 0 -bot 1260
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


