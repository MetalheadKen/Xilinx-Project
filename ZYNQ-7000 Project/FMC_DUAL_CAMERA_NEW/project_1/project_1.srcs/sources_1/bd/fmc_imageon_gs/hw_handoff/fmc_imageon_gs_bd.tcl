
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

  # Create instance: avnet_hdmi_out_1, and set properties
  set avnet_hdmi_out_1 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_out:3.1 avnet_hdmi_out_1 ]

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

  # Create instance: onsemi_vita_cam_L_0, and set properties
  set onsemi_vita_cam_L_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_cam_L:3.2 onsemi_vita_cam_L_0 ]

  # Create instance: onsemi_vita_spi_0, and set properties
  set onsemi_vita_spi_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_spi:3.2 onsemi_vita_spi_0 ]

  # Create instance: onsemi_vita_spi_1, and set properties
  set onsemi_vita_spi_1 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_spi:3.2 onsemi_vita_spi_1 ]

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
CONFIG.PCW_EN_RST2_PORT {1} \
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
CONFIG.PCW_USE_S_AXI_HP0 {0} \
CONFIG.PCW_USE_S_AXI_HP1 {0} \
CONFIG.preset {ZC702} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {10} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_149M_L, and set properties
  set rst_processing_system7_0_149M_L [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_149M_L ]

  # Create instance: rst_processing_system7_0_149M_R, and set properties
  set rst_processing_system7_0_149M_R [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_149M_R ]

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
CONFIG.enable_detection {true} \
 ] $v_tc_0

  # Create instance: v_tc_1, and set properties
  set v_tc_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_1 ]
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
CONFIG.enable_detection {true} \
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

  # Create interface connections
  connect_bd_intf_net -intf_net IO_CAM_IN_1 [get_bd_intf_ports IO_VITA_CAM_R] [get_bd_intf_pins onsemi_vita_cam_0/IO_CAM_IN]
  connect_bd_intf_net -intf_net IO_CAM_IN_2 [get_bd_intf_ports IO_VITA_CAM_L] [get_bd_intf_pins onsemi_vita_cam_L_0/IO_CAM_IN]
  connect_bd_intf_net -intf_net avnet_hdmi_out_0_IO_HDMIO [get_bd_intf_ports IO_HDMIO_R] [get_bd_intf_pins avnet_hdmi_out_0/IO_HDMIO]
  connect_bd_intf_net -intf_net avnet_hdmi_out_1_IO_HDMIO [get_bd_intf_ports IO_HDMIO_L] [get_bd_intf_pins avnet_hdmi_out_1/IO_HDMIO]
  connect_bd_intf_net -intf_net fmc_imageon_iic_0_IIC [get_bd_intf_ports fmc_imageon_iic_r] [get_bd_intf_pins fmc_imageon_iic_0/IIC]
  connect_bd_intf_net -intf_net fmc_imageon_iic_1_IIC [get_bd_intf_ports fmc_imageon_iic_l] [get_bd_intf_pins fmc_imageon_iic_1/IIC]
  connect_bd_intf_net -intf_net onsemi_vita_cam_0_VID_IO_OUT [get_bd_intf_pins onsemi_vita_cam_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_0/vid_io_in]
  connect_bd_intf_net -intf_net onsemi_vita_cam_L_0_VID_IO_OUT [get_bd_intf_pins onsemi_vita_cam_L_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_1/vid_io_in]
  connect_bd_intf_net -intf_net onsemi_vita_spi_0_IO_SPI_OUT [get_bd_intf_ports IO_VITA_SPI_R] [get_bd_intf_pins onsemi_vita_spi_0/IO_SPI_OUT]
  connect_bd_intf_net -intf_net onsemi_vita_spi_1_IO_SPI_OUT [get_bd_intf_ports IO_VITA_SPI_L] [get_bd_intf_pins onsemi_vita_spi_1/IO_SPI_OUT]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins fmc_imageon_iic_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins fmc_imageon_iic_1/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins onsemi_vita_cam_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins onsemi_vita_cam_L_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI] [get_bd_intf_pins v_tc_1/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI] [get_bd_intf_pins v_cfa_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M07_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M07_AXI] [get_bd_intf_pins v_cfa_1/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M08_AXI [get_bd_intf_pins onsemi_vita_spi_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M09_AXI [get_bd_intf_pins onsemi_vita_spi_1/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins avnet_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_1_vid_io_out [get_bd_intf_pins avnet_hdmi_out_1/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_1/vid_io_out]
  connect_bd_intf_net -intf_net v_cfa_0_video_out [get_bd_intf_pins v_cfa_0/video_out] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
  connect_bd_intf_net -intf_net v_cfa_1_video_out [get_bd_intf_pins v_cfa_1/video_out] [get_bd_intf_pins v_rgb2ycrcb_1/video_in]
  connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_cresample_0/video_out]
  connect_bd_intf_net -intf_net v_cresample_1_video_out [get_bd_intf_pins v_axi4s_vid_out_1/video_in] [get_bd_intf_pins v_cresample_1/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_1_video_out [get_bd_intf_pins v_cresample_1/video_in] [get_bd_intf_pins v_rgb2ycrcb_1/video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  connect_bd_intf_net -intf_net v_tc_1_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_1/vtiming_in] [get_bd_intf_pins v_tc_1/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_cfa_0/video_in] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_vtiming_out [get_bd_intf_pins v_tc_0/vtiming_in] [get_bd_intf_pins v_vid_in_axi4s_0/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_2_video_out [get_bd_intf_pins v_cfa_1/video_in] [get_bd_intf_pins v_vid_in_axi4s_1/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_2_vtiming_out [get_bd_intf_pins v_tc_1/vtiming_in] [get_bd_intf_pins v_vid_in_axi4s_1/vtiming_out]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins rst_processing_system7_0_149M_L/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_1/aresetn] [get_bd_pins v_cresample_1/aresetn] [get_bd_pins v_rgb2ycrcb_1/aresetn] [get_bd_pins v_tc_1/s_axi_aresetn]
  connect_bd_net -net clk_2 [get_bd_ports fmc_imageon_vclk_l] [get_bd_pins avnet_hdmi_out_1/clk] [get_bd_pins onsemi_vita_cam_L_0/clk] [get_bd_pins rst_processing_system7_0_149M_L/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_1/vid_io_out_clk] [get_bd_pins v_tc_1/clk] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports fmc_imageon_vclk_r] [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins onsemi_vita_cam_0/clk] [get_bd_pins rst_processing_system7_0_149M_R/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net fmc_imageon_iic_0_gpo [get_bd_ports fmc_imageon_iic_r_rst_n] [get_bd_pins fmc_imageon_iic_0/gpo]
  connect_bd_net -net fmc_imageon_iic_1_gpo [get_bd_ports fmc_imageon_iic_l_rst_n] [get_bd_pins fmc_imageon_iic_1/gpo]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins fmc_imageon_iic_0/s_axi_aclk] [get_bd_pins fmc_imageon_iic_1/s_axi_aclk] [get_bd_pins onsemi_vita_cam_0/s00_axi_aclk] [get_bd_pins onsemi_vita_cam_L_0/s00_axi_aclk] [get_bd_pins onsemi_vita_spi_0/s00_axi_aclk] [get_bd_pins onsemi_vita_spi_1/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/M07_ACLK] [get_bd_pins processing_system7_0_axi_periph/M08_ACLK] [get_bd_pins processing_system7_0_axi_periph/M09_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_76M/slowest_sync_clk] [get_bd_pins v_cfa_0/s_axi_aclk] [get_bd_pins v_cfa_1/s_axi_aclk] [get_bd_pins v_tc_0/s_axi_aclk] [get_bd_pins v_tc_1/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_axi4s_vid_out_1/aclk] [get_bd_pins v_cfa_0/aclk] [get_bd_pins v_cfa_1/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_cresample_1/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk] [get_bd_pins v_rgb2ycrcb_1/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins v_vid_in_axi4s_1/aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_vita_cam_0/clk200] [get_bd_pins onsemi_vita_cam_L_0/clk200] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_76M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins rst_processing_system7_0_149M_R/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET2_N [get_bd_pins processing_system7_0/FCLK_RESET2_N] [get_bd_pins rst_processing_system7_0_149M_L/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_149M_L_peripheral_reset [get_bd_pins onsemi_vita_cam_L_0/reset] [get_bd_pins rst_processing_system7_0_149M_L/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_149M_R_peripheral_aresetn [get_bd_pins rst_processing_system7_0_149M_R/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net rst_processing_system7_0_149M_R_peripheral_reset [get_bd_pins onsemi_vita_cam_0/reset] [get_bd_pins rst_processing_system7_0_149M_R/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_76M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_76M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_aresetn [get_bd_pins fmc_imageon_iic_0/s_axi_aresetn] [get_bd_pins fmc_imageon_iic_1/s_axi_aresetn] [get_bd_pins onsemi_vita_cam_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_cam_L_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_spi_0/s00_axi_aresetn] [get_bd_pins onsemi_vita_spi_1/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M07_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M08_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M09_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_76M/peripheral_aresetn] [get_bd_pins v_cfa_0/s_axi_aresetn] [get_bd_pins v_cfa_1/s_axi_aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn] [get_bd_pins v_vid_in_axi4s_1/aresetn]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_axi4s_vid_out_1_vtg_ce [get_bd_pins v_axi4s_vid_out_1/vtg_ce] [get_bd_pins v_tc_1/gen_clken]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins GND/dout] [get_bd_pins avnet_hdmi_out_0/reset] [get_bd_pins avnet_hdmi_out_1/reset] [get_bd_pins onsemi_vita_cam_0/trigger1] [get_bd_pins onsemi_vita_cam_L_0/trigger1] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset] [get_bd_pins v_axi4s_vid_out_1/vid_io_out_reset] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_reset]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins VCC/dout] [get_bd_pins avnet_hdmi_out_0/embed_syncs] [get_bd_pins avnet_hdmi_out_0/oe] [get_bd_pins avnet_hdmi_out_1/embed_syncs] [get_bd_pins avnet_hdmi_out_1/oe] [get_bd_pins onsemi_vita_cam_0/oe] [get_bd_pins onsemi_vita_cam_L_0/oe] [get_bd_pins onsemi_vita_spi_0/oe] [get_bd_pins onsemi_vita_spi_1/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_axi4s_vid_out_1/aclken] [get_bd_pins v_axi4s_vid_out_1/vid_io_out_ce] [get_bd_pins v_cfa_0/aclken] [get_bd_pins v_cfa_0/aresetn] [get_bd_pins v_cfa_0/s_axi_aclken] [get_bd_pins v_cfa_1/aclken] [get_bd_pins v_cfa_1/aresetn] [get_bd_pins v_cfa_1/s_axi_aclken] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_cresample_1/aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_rgb2ycrcb_1/aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/det_clken] [get_bd_pins v_tc_0/resetn] [get_bd_pins v_tc_0/s_axi_aclken] [get_bd_pins v_tc_1/clken] [get_bd_pins v_tc_1/det_clken] [get_bd_pins v_tc_1/resetn] [get_bd_pins v_tc_1/s_axi_aclken] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins v_vid_in_axi4s_1/aclken] [get_bd_pins v_vid_in_axi4s_1/axis_enable] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_ce]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_imageon_iic_0/S_AXI/Reg] SEG_fmc_imageon_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41610000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_imageon_iic_1/S_AXI/Reg] SEG_fmc_imageon_iic_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C60000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_0/S00_AXI/Reg] SEG_onsemi_vita_cam_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C70000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_cam_L_0/S00_AXI/Reg] SEG_onsemi_vita_cam_L_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_spi_0/S00_AXI/Reg] SEG_onsemi_vita_spi_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_vita_spi_1/S00_AXI/Reg] SEG_onsemi_vita_spi_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/ctrl/Reg] SEG_v_cfa_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_1/ctrl/Reg] SEG_v_cfa_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tc_0/ctrl/Reg] SEG_v_tc_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tc_1/ctrl/Reg] SEG_v_tc_1_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   Display-PortTypeClock: "true",
   Display-PortTypeOthers: "true",
   Display-PortTypeReset: "true",
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port IO_VITA_CAM_L -pg 1 -y 980 -defaultsOSRD
preplace port DDR -pg 1 -y 750 -defaultsOSRD
preplace port IO_HDMIO_R -pg 1 -y 590 -defaultsOSRD
preplace port fmc_imageon_iic_r -pg 1 -y 1320 -defaultsOSRD
preplace port fmc_imageon_vclk_l -pg 1 -y 1060 -defaultsOSRD
preplace port IO_VITA_SPI_R -pg 1 -y 830 -defaultsOSRD
preplace port IO_VITA_CAM_R -pg 1 -y 620 -defaultsOSRD
preplace port IO_HDMIO_L -pg 1 -y 1060 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 770 -defaultsOSRD
preplace port fmc_imageon_vclk_r -pg 1 -y 940 -defaultsOSRD
preplace port fmc_imageon_iic_l -pg 1 -y 1200 -defaultsOSRD
preplace port IO_VITA_SPI_L -pg 1 -y 960 -defaultsOSRD
preplace portBus fmc_imageon_iic_r_rst_n -pg 1 -y 1360 -defaultsOSRD
preplace portBus fmc_imageon_iic_l_rst_n -pg 1 -y 1240 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 8 -y 590 -defaultsOSRD
preplace inst rst_processing_system7_0_76M -pg 1 -lvl 1 -y 520 -defaultsOSRD
preplace inst v_axi4s_vid_out_1 -pg 1 -lvl 8 -y 1060 -defaultsOSRD -resize 180 220
preplace inst v_tc_0 -pg 1 -lvl 7 -y 410 -defaultsOSRD
preplace inst v_tc_1 -pg 1 -lvl 7 -y 1040 -defaultsOSRD -resize 160 220
preplace inst fmc_imageon_iic_0 -pg 1 -lvl 9 -y 1390 -defaultsOSRD
preplace inst v_cfa_0 -pg 1 -lvl 5 -y 470 -defaultsOSRD
preplace inst fmc_imageon_iic_1 -pg 1 -lvl 9 -y 1270 -defaultsOSRD
preplace inst v_cfa_1 -pg 1 -lvl 5 -y 760 -defaultsOSRD -resize 160 200
preplace inst GND -pg 1 -lvl 2 -y 870 -defaultsOSRD
preplace inst onsemi_vita_cam_0 -pg 1 -lvl 3 -y 760 -defaultsOSRD
preplace inst v_cresample_0 -pg 1 -lvl 7 -y 640 -defaultsOSRD
preplace inst rst_processing_system7_0_149M_L -pg 1 -lvl 2 -y 1150 -defaultsOSRD -resize 240 140
preplace inst v_cresample_1 -pg 1 -lvl 7 -y 830 -defaultsOSRD -resize 165 104
preplace inst v_vid_in_axi4s_0 -pg 1 -lvl 4 -y 740 -defaultsOSRD
preplace inst v_vid_in_axi4s_1 -pg 1 -lvl 4 -y 1020 -defaultsOSRD -resize 180 220
preplace inst v_rgb2ycrcb_0 -pg 1 -lvl 6 -y 490 -defaultsOSRD
preplace inst onsemi_vita_spi_0 -pg 1 -lvl 9 -y 820 -defaultsOSRD
preplace inst avnet_hdmi_out_0 -pg 1 -lvl 9 -y 590 -defaultsOSRD
preplace inst onsemi_vita_cam_L_0 -pg 1 -lvl 3 -y 1040 -defaultsOSRD
preplace inst v_rgb2ycrcb_1 -pg 1 -lvl 6 -y 670 -defaultsOSRD -resize 160 120
preplace inst VCC -pg 1 -lvl 2 -y 790 -defaultsOSRD
preplace inst onsemi_vita_spi_1 -pg 1 -lvl 9 -y 960 -defaultsOSRD -resize 180 120
preplace inst avnet_hdmi_out_1 -pg 1 -lvl 9 -y 1120 -defaultsOSRD -resize 180 160
preplace inst rst_processing_system7_0_149M_R -pg 1 -lvl 2 -y 620 -defaultsOSRD -resize 240 140
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 2 -y 250 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 1 -y 780 -defaultsOSRD
preplace netloc processing_system7_0_axi_periph_M09_AXI 1 2 7 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 NJ 210 2990
preplace netloc avnet_hdmi_out_1_IO_HDMIO 1 9 1 NJ
preplace netloc IO_CAM_IN_2 1 0 3 NJ 980 NJ 980 NJ
preplace netloc processing_system7_0_DDR 1 1 9 NJ 920 NJ 910 NJ 880 NJ 880 NJ 770 NJ 720 NJ 720 NJ 720 NJ
preplace netloc v_rgb2ycrcb_1_video_out 1 6 1 2280
preplace netloc rst_processing_system7_0_149M_R_peripheral_aresetn 1 2 6 NJ 610 NJ 610 NJ 610 1960 580 2330 560 2650
preplace netloc xlconstant_1_dout 1 2 7 1060 1180 1380 1150 1670 350 1970 570 2310 260 2620 450 2950
preplace netloc v_vid_in_axi4s_0_video_out 1 4 1 1650
preplace netloc rst_processing_system7_0_149M_L_peripheral_reset 1 2 1 1080
preplace netloc processing_system7_0_axi_periph_M08_AXI 1 2 7 NJ 190 NJ 190 NJ 190 NJ 190 NJ 190 NJ 190 3010
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 2 1 1020
preplace netloc v_cresample_1_video_out 1 7 1 2610
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 2 7 N 160 NJ 160 NJ 160 NJ 160 NJ 160 NJ 160 NJ
preplace netloc rst_processing_system7_0_76M_peripheral_aresetn 1 1 8 700 940 1090 1170 1370 870 1720 890 NJ 760 NJ 760 NJ 760 2910
preplace netloc fmc_imageon_iic_0_gpo 1 9 1 NJ
preplace netloc v_axi4s_vid_out_0_vid_io_out 1 8 1 N
preplace netloc onsemi_vita_cam_L_0_VID_IO_OUT 1 3 1 1410
preplace netloc processing_system7_0_axi_periph_M07_AXI 1 2 3 NJ 300 NJ 300 1690
preplace netloc processing_system7_0_M_AXI_GP0 1 1 1 630
preplace netloc v_axi4s_vid_out_1_vid_io_out 1 8 1 2930
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 2 5 NJ 260 NJ 260 NJ 260 NJ 260 2300
preplace netloc v_cfa_1_video_out 1 5 1 1960
preplace netloc v_axi4s_vid_out_1_vtg_ce 1 6 3 2330 740 NJ 740 2900
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 2 10 430 620
preplace netloc v_cresample_0_video_out 1 7 1 2630
preplace netloc processing_system7_0_FCLK_RESET2_N 1 1 1 620
preplace netloc onsemi_vita_spi_1_IO_SPI_OUT 1 9 1 N
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 2 1 1060
preplace netloc processing_system7_0_FCLK_RESET1_N 1 1 1 680
preplace netloc fmc_imageon_iic_0_IIC 1 9 1 NJ
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 2 3 NJ 280 NJ 280 1720
preplace netloc v_cfa_0_video_out 1 5 1 N
preplace netloc v_axi4s_vid_out_0_vtg_ce 1 6 3 2330 220 NJ 220 2900
preplace netloc xlconstant_0_dout 1 2 7 1070 1190 1400 1170 NJ 1170 NJ 1170 NJ 1170 2640 460 2940
preplace netloc onsemi_vita_spi_0_IO_SPI_OUT 1 9 1 3240
preplace netloc fmc_imageon_iic_1_IIC 1 9 1 NJ
preplace netloc processing_system7_0_FIXED_IO 1 1 9 NJ 1240 NJ 1240 NJ 1240 NJ 920 NJ 750 NJ 750 NJ 750 NJ 740 NJ
preplace netloc v_vid_in_axi4s_2_video_out 1 4 1 1690
preplace netloc clk_2 1 0 9 NJ 1060 690 1020 1050 890 1360 890 NJ 900 NJ 900 2260 910 2590 1190 2960
preplace netloc clk_wiz_0_clk_out1 1 0 9 NJ 940 670 720 1070 630 1420 590 NJ 590 NJ 590 2280 240 2680 430 NJ
preplace netloc avnet_hdmi_out_0_IO_HDMIO 1 9 1 NJ
preplace netloc rst_processing_system7_0_76M_interconnect_aresetn 1 1 1 640
preplace netloc onsemi_vita_cam_0_VID_IO_OUT 1 3 1 1370
preplace netloc v_rgb2ycrcb_0_video_out 1 6 1 2320
preplace netloc rst_processing_system7_0_149M_R_peripheral_reset 1 2 1 1010
preplace netloc Net 1 2 6 NJ 1200 NJ 1200 NJ 910 1970 860 2280 900 NJ
preplace netloc processing_system7_0_FCLK_CLK0 1 0 9 20 610 650 730 1000 1210 NJ 1210 1680 340 NJ 340 2270 730 NJ 730 2920
preplace netloc v_tc_1_vtiming_out 1 7 1 2650
preplace netloc v_vid_in_axi4s_0_vtiming_out 1 4 3 NJ 330 NJ 330 N
preplace netloc v_tc_0_vtiming_out 1 7 1 2670
preplace netloc fmc_imageon_iic_1_gpo 1 9 1 NJ
preplace netloc processing_system7_0_FCLK_CLK1 1 1 7 NJ 930 NJ 900 1420 860 1660 620 2000 410 2290 250 2660
preplace netloc IO_CAM_IN_1 1 0 3 NJ 620 NJ 710 NJ
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 2 5 N 240 NJ 240 NJ 240 NJ 240 NJ
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 7 N 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ 180 NJ
preplace netloc v_vid_in_axi4s_2_vtiming_out 1 4 3 1710 960 NJ 960 NJ
preplace netloc processing_system7_0_FCLK_CLK2 1 1 2 NJ 740 1080
levelinfo -pg 1 -10 430 850 1240 1530 1860 2150 2480 2790 3120 3260 -top -40 -bot 1460
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


