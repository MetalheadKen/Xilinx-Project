
################################################################
# This is a generated script based on design: system
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
# source system_script.tcl

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
set design_name system

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
  set ddr [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr ]
  set fixed_io [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 fixed_io ]
  set iic_main [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_main ]

  # Create ports
  set gpio_i [ create_bd_port -dir I -from 63 -to 0 gpio_i ]
  set gpio_o [ create_bd_port -dir O -from 63 -to 0 gpio_o ]
  set gpio_t [ create_bd_port -dir O -from 63 -to 0 gpio_t ]
  set hdmi_data [ create_bd_port -dir O -from 15 -to 0 hdmi_data ]
  set hdmi_data_e [ create_bd_port -dir O hdmi_data_e ]
  set hdmi_hsync [ create_bd_port -dir O hdmi_hsync ]
  set hdmi_out_clk [ create_bd_port -dir O hdmi_out_clk ]
  set hdmi_vsync [ create_bd_port -dir O hdmi_vsync ]
  set ps_intr_00 [ create_bd_port -dir I -type intr ps_intr_00 ]
  set ps_intr_01 [ create_bd_port -dir I -type intr ps_intr_01 ]
  set ps_intr_02 [ create_bd_port -dir I -type intr ps_intr_02 ]
  set ps_intr_03 [ create_bd_port -dir I -type intr ps_intr_03 ]
  set ps_intr_04 [ create_bd_port -dir I -type intr ps_intr_04 ]
  set ps_intr_05 [ create_bd_port -dir I -type intr ps_intr_05 ]
  set ps_intr_06 [ create_bd_port -dir I -type intr ps_intr_06 ]
  set ps_intr_07 [ create_bd_port -dir I -type intr ps_intr_07 ]
  set ps_intr_08 [ create_bd_port -dir I -type intr ps_intr_08 ]
  set ps_intr_09 [ create_bd_port -dir I -type intr ps_intr_09 ]
  set ps_intr_10 [ create_bd_port -dir I -type intr ps_intr_10 ]
  set ps_intr_11 [ create_bd_port -dir I -type intr ps_intr_11 ]
  set ps_intr_12 [ create_bd_port -dir I -type intr ps_intr_12 ]
  set ps_intr_13 [ create_bd_port -dir I -type intr ps_intr_13 ]
  set spdif [ create_bd_port -dir O spdif ]
  set spi0_clk_i [ create_bd_port -dir I spi0_clk_i ]
  set spi0_clk_o [ create_bd_port -dir O spi0_clk_o ]
  set spi0_csn_0_o [ create_bd_port -dir O spi0_csn_0_o ]
  set spi0_csn_1_o [ create_bd_port -dir O spi0_csn_1_o ]
  set spi0_csn_2_o [ create_bd_port -dir O spi0_csn_2_o ]
  set spi0_csn_i [ create_bd_port -dir I spi0_csn_i ]
  set spi0_sdi_i [ create_bd_port -dir I spi0_sdi_i ]
  set spi0_sdo_i [ create_bd_port -dir I spi0_sdo_i ]
  set spi0_sdo_o [ create_bd_port -dir O spi0_sdo_o ]
  set spi1_clk_i [ create_bd_port -dir I spi1_clk_i ]
  set spi1_clk_o [ create_bd_port -dir O spi1_clk_o ]
  set spi1_csn_0_o [ create_bd_port -dir O spi1_csn_0_o ]
  set spi1_csn_1_o [ create_bd_port -dir O spi1_csn_1_o ]
  set spi1_csn_2_o [ create_bd_port -dir O spi1_csn_2_o ]
  set spi1_csn_i [ create_bd_port -dir I spi1_csn_i ]
  set spi1_sdi_i [ create_bd_port -dir I spi1_sdi_i ]
  set spi1_sdo_i [ create_bd_port -dir I spi1_sdo_i ]
  set spi1_sdo_o [ create_bd_port -dir O spi1_sdo_o ]

  # Create instance: axi_cpu_interconnect, and set properties
  set axi_cpu_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_cpu_interconnect ]
  set_property -dict [ list \
CONFIG.NUM_MI {5} \
 ] $axi_cpu_interconnect

  # Create instance: axi_hdmi_clkgen, and set properties
  set axi_hdmi_clkgen [ create_bd_cell -type ip -vlnv analog.com:user:axi_clkgen:1.0 axi_hdmi_clkgen ]

  # Create instance: axi_hdmi_core, and set properties
  set axi_hdmi_core [ create_bd_cell -type ip -vlnv analog.com:user:axi_hdmi_tx:1.0 axi_hdmi_core ]

  # Create instance: axi_hdmi_dma, and set properties
  set axi_hdmi_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_hdmi_dma ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {0} \
CONFIG.c_m_axis_mm2s_tdata_width {64} \
CONFIG.c_use_mm2s_fsync {1} \
 ] $axi_hdmi_dma

  # Create instance: axi_hp0_interconnect, and set properties
  set axi_hp0_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_hp0_interconnect ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {1} \
 ] $axi_hp0_interconnect

  # Create instance: axi_iic_main, and set properties
  set axi_iic_main [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_main ]
  set_property -dict [ list \
CONFIG.IIC_BOARD_INTERFACE {iic_main} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_iic_main

  # Create instance: axi_spdif_tx_core, and set properties
  set axi_spdif_tx_core [ create_bd_cell -type ip -vlnv analog.com:user:axi_spdif_tx:1.0 axi_spdif_tx_core ]
  set_property -dict [ list \
CONFIG.DMA_TYPE {1} \
CONFIG.S_AXI_ADDRESS_WIDTH {16} \
 ] $axi_spdif_tx_core

  # Create instance: sys_audio_clkgen, and set properties
  set sys_audio_clkgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 sys_audio_clkgen ]
  set_property -dict [ list \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {12.288} \
CONFIG.PRIM_IN_FREQ {200.000} \
CONFIG.RESET_TYPE {ACTIVE_LOW} \
CONFIG.USE_LOCKED {false} \
CONFIG.USE_RESET {true} \
 ] $sys_audio_clkgen

  # Create instance: sys_concat_intc, and set properties
  set sys_concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 sys_concat_intc ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {16} \
 ] $sys_concat_intc

  # Create instance: sys_ps7, and set properties
  set sys_ps7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 sys_ps7 ]
  set_property -dict [ list \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.0} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_EMIO_GPIO_IO {64} \
CONFIG.PCW_IMPORT_BOARD_PRESET {ZC702} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SPI0_SPI0_IO {EMIO} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SPI1_SPI1_IO {EMIO} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USE_DMA0 {1} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
 ] $sys_ps7

  # Create instance: sys_rstgen, and set properties
  set sys_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rstgen ]
  set_property -dict [ list \
CONFIG.C_EXT_RST_WIDTH {1} \
 ] $sys_rstgen

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_cpu_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP0]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_hdmi_dma/M_AXI_MM2S] [get_bd_intf_pins axi_hp0_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M00_AXI [get_bd_intf_pins axi_cpu_interconnect/M00_AXI] [get_bd_intf_pins axi_iic_main/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M01_AXI [get_bd_intf_pins axi_cpu_interconnect/M01_AXI] [get_bd_intf_pins axi_hdmi_clkgen/s_axi]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M02_AXI [get_bd_intf_pins axi_cpu_interconnect/M02_AXI] [get_bd_intf_pins axi_hdmi_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M03_AXI [get_bd_intf_pins axi_cpu_interconnect/M03_AXI] [get_bd_intf_pins axi_hdmi_core/s_axi]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M04_AXI [get_bd_intf_pins axi_cpu_interconnect/M04_AXI] [get_bd_intf_pins axi_spdif_tx_core/s_axi]
  connect_bd_intf_net -intf_net axi_hp0_interconnect_M00_AXI [get_bd_intf_pins axi_hp0_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_iic_main_IIC [get_bd_intf_ports iic_main] [get_bd_intf_pins axi_iic_main/IIC]
  connect_bd_intf_net -intf_net axi_spdif_tx_core_DMA_REQ [get_bd_intf_pins axi_spdif_tx_core/DMA_REQ] [get_bd_intf_pins sys_ps7/DMA0_REQ]
  connect_bd_intf_net -intf_net sys_ps7_DDR [get_bd_intf_ports ddr] [get_bd_intf_pins sys_ps7/DDR]
  connect_bd_intf_net -intf_net sys_ps7_DMA0_ACK [get_bd_intf_pins axi_spdif_tx_core/DMA_ACK] [get_bd_intf_pins sys_ps7/DMA0_ACK]
  connect_bd_intf_net -intf_net sys_ps7_FIXED_IO [get_bd_intf_ports fixed_io] [get_bd_intf_pins sys_ps7/FIXED_IO]

  # Create port connections
  connect_bd_net -net axi_hdmi_clkgen_clk_0 [get_bd_pins axi_hdmi_clkgen/clk_0] [get_bd_pins axi_hdmi_core/hdmi_clk]
  connect_bd_net -net axi_hdmi_core_hdmi_16_data [get_bd_ports hdmi_data] [get_bd_pins axi_hdmi_core/hdmi_16_data]
  connect_bd_net -net axi_hdmi_core_hdmi_16_data_e [get_bd_ports hdmi_data_e] [get_bd_pins axi_hdmi_core/hdmi_16_data_e]
  connect_bd_net -net axi_hdmi_core_hdmi_16_hsync [get_bd_ports hdmi_hsync] [get_bd_pins axi_hdmi_core/hdmi_16_hsync]
  connect_bd_net -net axi_hdmi_core_hdmi_16_vsync [get_bd_ports hdmi_vsync] [get_bd_pins axi_hdmi_core/hdmi_16_vsync]
  connect_bd_net -net axi_hdmi_core_hdmi_out_clk [get_bd_ports hdmi_out_clk] [get_bd_pins axi_hdmi_core/hdmi_out_clk]
  connect_bd_net -net axi_hdmi_core_vdma_fs [get_bd_pins axi_hdmi_core/vdma_fs] [get_bd_pins axi_hdmi_core/vdma_fs_ret] [get_bd_pins axi_hdmi_dma/mm2s_fsync]
  connect_bd_net -net axi_hdmi_core_vdma_ready [get_bd_pins axi_hdmi_core/vdma_ready] [get_bd_pins axi_hdmi_dma/m_axis_mm2s_tready]
  connect_bd_net -net axi_hdmi_dma_m_axis_mm2s_tdata [get_bd_pins axi_hdmi_core/vdma_data] [get_bd_pins axi_hdmi_dma/m_axis_mm2s_tdata]
  connect_bd_net -net axi_hdmi_dma_m_axis_mm2s_tvalid [get_bd_pins axi_hdmi_core/vdma_valid] [get_bd_pins axi_hdmi_dma/m_axis_mm2s_tvalid]
  connect_bd_net -net axi_hdmi_dma_mm2s_introut [get_bd_pins axi_hdmi_dma/mm2s_introut] [get_bd_pins sys_concat_intc/In15]
  connect_bd_net -net axi_iic_main_iic2intc_irpt [get_bd_pins axi_iic_main/iic2intc_irpt] [get_bd_pins sys_concat_intc/In14]
  connect_bd_net -net axi_spdif_tx_core_spdif_tx_o [get_bd_ports spdif] [get_bd_pins axi_spdif_tx_core/spdif_tx_o]
  connect_bd_net -net gpio_i_1 [get_bd_ports gpio_i] [get_bd_pins sys_ps7/GPIO_I]
  connect_bd_net -net ps_intr_00_1 [get_bd_ports ps_intr_00] [get_bd_pins sys_concat_intc/In0]
  connect_bd_net -net ps_intr_01_1 [get_bd_ports ps_intr_01] [get_bd_pins sys_concat_intc/In1]
  connect_bd_net -net ps_intr_02_1 [get_bd_ports ps_intr_02] [get_bd_pins sys_concat_intc/In2]
  connect_bd_net -net ps_intr_03_1 [get_bd_ports ps_intr_03] [get_bd_pins sys_concat_intc/In3]
  connect_bd_net -net ps_intr_04_1 [get_bd_ports ps_intr_04] [get_bd_pins sys_concat_intc/In4]
  connect_bd_net -net ps_intr_05_1 [get_bd_ports ps_intr_05] [get_bd_pins sys_concat_intc/In5]
  connect_bd_net -net ps_intr_06_1 [get_bd_ports ps_intr_06] [get_bd_pins sys_concat_intc/In6]
  connect_bd_net -net ps_intr_07_1 [get_bd_ports ps_intr_07] [get_bd_pins sys_concat_intc/In7]
  connect_bd_net -net ps_intr_08_1 [get_bd_ports ps_intr_08] [get_bd_pins sys_concat_intc/In8]
  connect_bd_net -net ps_intr_09_1 [get_bd_ports ps_intr_09] [get_bd_pins sys_concat_intc/In9]
  connect_bd_net -net ps_intr_10_1 [get_bd_ports ps_intr_10] [get_bd_pins sys_concat_intc/In10]
  connect_bd_net -net ps_intr_11_1 [get_bd_ports ps_intr_11] [get_bd_pins sys_concat_intc/In11]
  connect_bd_net -net ps_intr_12_1 [get_bd_ports ps_intr_12] [get_bd_pins sys_concat_intc/In12]
  connect_bd_net -net ps_intr_13_1 [get_bd_ports ps_intr_13] [get_bd_pins sys_concat_intc/In13]
  connect_bd_net -net spi0_clk_i_1 [get_bd_ports spi0_clk_i] [get_bd_pins sys_ps7/SPI0_SCLK_I]
  connect_bd_net -net spi0_csn_i_1 [get_bd_ports spi0_csn_i] [get_bd_pins sys_ps7/SPI0_SS_I]
  connect_bd_net -net spi0_sdi_i_1 [get_bd_ports spi0_sdi_i] [get_bd_pins sys_ps7/SPI0_MISO_I]
  connect_bd_net -net spi0_sdo_i_1 [get_bd_ports spi0_sdo_i] [get_bd_pins sys_ps7/SPI0_MOSI_I]
  connect_bd_net -net spi1_clk_i_1 [get_bd_ports spi1_clk_i] [get_bd_pins sys_ps7/SPI1_SCLK_I]
  connect_bd_net -net spi1_csn_i_1 [get_bd_ports spi1_csn_i] [get_bd_pins sys_ps7/SPI1_SS_I]
  connect_bd_net -net spi1_sdi_i_1 [get_bd_ports spi1_sdi_i] [get_bd_pins sys_ps7/SPI1_MISO_I]
  connect_bd_net -net spi1_sdo_i_1 [get_bd_ports spi1_sdo_i] [get_bd_pins sys_ps7/SPI1_MOSI_I]
  connect_bd_net -net sys_200m_clk [get_bd_pins axi_hdmi_clkgen/clk] [get_bd_pins sys_audio_clkgen/clk_in1] [get_bd_pins sys_ps7/FCLK_CLK1]
  connect_bd_net -net sys_audio_clkgen_clk_out1 [get_bd_pins axi_spdif_tx_core/spdif_data_clk] [get_bd_pins sys_audio_clkgen/clk_out1]
  connect_bd_net -net sys_concat_intc_dout [get_bd_pins sys_concat_intc/dout] [get_bd_pins sys_ps7/IRQ_F2P]
  connect_bd_net -net sys_cpu_clk [get_bd_pins axi_cpu_interconnect/ACLK] [get_bd_pins axi_cpu_interconnect/M00_ACLK] [get_bd_pins axi_cpu_interconnect/M01_ACLK] [get_bd_pins axi_cpu_interconnect/M02_ACLK] [get_bd_pins axi_cpu_interconnect/M03_ACLK] [get_bd_pins axi_cpu_interconnect/M04_ACLK] [get_bd_pins axi_cpu_interconnect/S00_ACLK] [get_bd_pins axi_hdmi_clkgen/s_axi_aclk] [get_bd_pins axi_hdmi_core/s_axi_aclk] [get_bd_pins axi_hdmi_core/vdma_clk] [get_bd_pins axi_hdmi_dma/m_axi_mm2s_aclk] [get_bd_pins axi_hdmi_dma/m_axis_mm2s_aclk] [get_bd_pins axi_hdmi_dma/s_axi_lite_aclk] [get_bd_pins axi_hp0_interconnect/ACLK] [get_bd_pins axi_hp0_interconnect/M00_ACLK] [get_bd_pins axi_hp0_interconnect/S00_ACLK] [get_bd_pins axi_iic_main/s_axi_aclk] [get_bd_pins axi_spdif_tx_core/DMA_REQ_ACLK] [get_bd_pins axi_spdif_tx_core/S_AXI_ACLK] [get_bd_pins sys_ps7/DMA0_ACLK] [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins sys_ps7/M_AXI_GP0_ACLK] [get_bd_pins sys_ps7/S_AXI_HP0_ACLK] [get_bd_pins sys_rstgen/slowest_sync_clk]
  connect_bd_net -net sys_cpu_reset [get_bd_pins sys_rstgen/peripheral_reset]
  connect_bd_net -net sys_cpu_resetn [get_bd_pins axi_cpu_interconnect/ARESETN] [get_bd_pins axi_cpu_interconnect/M00_ARESETN] [get_bd_pins axi_cpu_interconnect/M01_ARESETN] [get_bd_pins axi_cpu_interconnect/M02_ARESETN] [get_bd_pins axi_cpu_interconnect/M03_ARESETN] [get_bd_pins axi_cpu_interconnect/M04_ARESETN] [get_bd_pins axi_cpu_interconnect/S00_ARESETN] [get_bd_pins axi_hdmi_clkgen/s_axi_aresetn] [get_bd_pins axi_hdmi_core/s_axi_aresetn] [get_bd_pins axi_hdmi_dma/axi_resetn] [get_bd_pins axi_hp0_interconnect/ARESETN] [get_bd_pins axi_hp0_interconnect/M00_ARESETN] [get_bd_pins axi_hp0_interconnect/S00_ARESETN] [get_bd_pins axi_iic_main/s_axi_aresetn] [get_bd_pins axi_spdif_tx_core/DMA_REQ_RSTN] [get_bd_pins axi_spdif_tx_core/S_AXI_ARESETN] [get_bd_pins sys_audio_clkgen/resetn] [get_bd_pins sys_rstgen/peripheral_aresetn]
  connect_bd_net -net sys_ps7_FCLK_RESET0_N [get_bd_pins sys_ps7/FCLK_RESET0_N] [get_bd_pins sys_rstgen/ext_reset_in]
  connect_bd_net -net sys_ps7_GPIO_O [get_bd_ports gpio_o] [get_bd_pins sys_ps7/GPIO_O]
  connect_bd_net -net sys_ps7_GPIO_T [get_bd_ports gpio_t] [get_bd_pins sys_ps7/GPIO_T]
  connect_bd_net -net sys_ps7_SPI0_MOSI_O [get_bd_ports spi0_sdo_o] [get_bd_pins sys_ps7/SPI0_MOSI_O]
  connect_bd_net -net sys_ps7_SPI0_SCLK_O [get_bd_ports spi0_clk_o] [get_bd_pins sys_ps7/SPI0_SCLK_O]
  connect_bd_net -net sys_ps7_SPI0_SS1_O [get_bd_ports spi0_csn_1_o] [get_bd_pins sys_ps7/SPI0_SS1_O]
  connect_bd_net -net sys_ps7_SPI0_SS2_O [get_bd_ports spi0_csn_2_o] [get_bd_pins sys_ps7/SPI0_SS2_O]
  connect_bd_net -net sys_ps7_SPI0_SS_O [get_bd_ports spi0_csn_0_o] [get_bd_pins sys_ps7/SPI0_SS_O]
  connect_bd_net -net sys_ps7_SPI1_MOSI_O [get_bd_ports spi1_sdo_o] [get_bd_pins sys_ps7/SPI1_MOSI_O]
  connect_bd_net -net sys_ps7_SPI1_SCLK_O [get_bd_ports spi1_clk_o] [get_bd_pins sys_ps7/SPI1_SCLK_O]
  connect_bd_net -net sys_ps7_SPI1_SS1_O [get_bd_ports spi1_csn_1_o] [get_bd_pins sys_ps7/SPI1_SS1_O]
  connect_bd_net -net sys_ps7_SPI1_SS2_O [get_bd_ports spi1_csn_2_o] [get_bd_pins sys_ps7/SPI1_SS2_O]
  connect_bd_net -net sys_ps7_SPI1_SS_O [get_bd_ports spi1_csn_0_o] [get_bd_pins sys_ps7/SPI1_SS_O]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_hdmi_dma/Data_MM2S] [get_bd_addr_segs sys_ps7/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_sys_ps7_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x79000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_hdmi_clkgen/s_axi/axi_lite] SEG_data_axi_hdmi_clkgen
  create_bd_addr_seg -range 0x10000 -offset 0x70E00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_hdmi_core/s_axi/axi_lite] SEG_data_axi_hdmi_core
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_hdmi_dma/S_AXI_LITE/Reg] SEG_data_axi_hdmi_dma
  create_bd_addr_seg -range 0x1000 -offset 0x41600000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_iic_main/S_AXI/Reg] SEG_data_axi_iic_main
  create_bd_addr_seg -range 0x10000 -offset 0x75C00000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_spdif_tx_core/s_axi/axi_lite] SEG_data_axi_spdif_tx_core

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port ps_intr_10 -pg 1 -y 240 -defaultsOSRD
preplace port spi0_sdi_i -pg 1 -y 1010 -defaultsOSRD
preplace port ps_intr_11 -pg 1 -y 260 -defaultsOSRD
preplace port spi1_csn_1_o -pg 1 -y 1550 -defaultsOSRD
preplace port spi0_csn_2_o -pg 1 -y 1370 -defaultsOSRD
preplace port fixed_io -pg 1 -y 1170 -defaultsOSRD
preplace port ps_intr_12 -pg 1 -y 280 -defaultsOSRD
preplace port ps_intr_00 -pg 1 -y 40 -defaultsOSRD
preplace port spdif -pg 1 -y 870 -defaultsOSRD
preplace port hdmi_vsync -pg 1 -y 100 -defaultsOSRD
preplace port hdmi_hsync -pg 1 -y 80 -defaultsOSRD
preplace port ps_intr_13 -pg 1 -y 300 -defaultsOSRD
preplace port ps_intr_01 -pg 1 -y 60 -defaultsOSRD
preplace port spi1_sdi_i -pg 1 -y 1790 -defaultsOSRD
preplace port spi1_csn_i -pg 1 -y 1810 -defaultsOSRD
preplace port ps_intr_02 -pg 1 -y 80 -defaultsOSRD
preplace port spi0_clk_o -pg 1 -y 1230 -defaultsOSRD
preplace port spi0_csn_i -pg 1 -y 1030 -defaultsOSRD
preplace port ps_intr_03 -pg 1 -y 100 -defaultsOSRD
preplace port spi1_sdo_i -pg 1 -y 1770 -defaultsOSRD
preplace port ps_intr_04 -pg 1 -y 120 -defaultsOSRD
preplace port spi1_clk_i -pg 1 -y 1750 -defaultsOSRD
preplace port spi0_sdo_i -pg 1 -y 990 -defaultsOSRD
preplace port ps_intr_05 -pg 1 -y 140 -defaultsOSRD
preplace port iic_main -pg 1 -y 480 -defaultsOSRD
preplace port ddr -pg 1 -y 1150 -defaultsOSRD
preplace port ps_intr_06 -pg 1 -y 160 -defaultsOSRD
preplace port spi0_csn_1_o -pg 1 -y 1350 -defaultsOSRD
preplace port ps_intr_07 -pg 1 -y 180 -defaultsOSRD
preplace port spi1_csn_0_o -pg 1 -y 1530 -defaultsOSRD
preplace port spi0_csn_0_o -pg 1 -y 1330 -defaultsOSRD
preplace port ps_intr_08 -pg 1 -y 200 -defaultsOSRD
preplace port hdmi_data_e -pg 1 -y 120 -defaultsOSRD
preplace port hdmi_out_clk -pg 1 -y 60 -defaultsOSRD
preplace port ps_intr_09 -pg 1 -y 220 -defaultsOSRD
preplace port spi1_sdo_o -pg 1 -y 1470 -defaultsOSRD
preplace port spi0_clk_i -pg 1 -y 970 -defaultsOSRD
preplace port spi1_clk_o -pg 1 -y 1430 -defaultsOSRD
preplace port spi1_csn_2_o -pg 1 -y 1570 -defaultsOSRD
preplace port spi0_sdo_o -pg 1 -y 1270 -defaultsOSRD
preplace portBus gpio_o -pg 1 -y 1110 -defaultsOSRD
preplace portBus hdmi_data -pg 1 -y 140 -defaultsOSRD
preplace portBus gpio_t -pg 1 -y 1130 -defaultsOSRD
preplace portBus gpio_i -pg 1 -y 950 -defaultsOSRD
preplace inst axi_hdmi_clkgen -pg 1 -lvl 3 -y 660 -defaultsOSRD
preplace inst axi_hp0_interconnect -pg 1 -lvl 4 -y 620 -defaultsOSRD
preplace inst axi_hdmi_core -pg 1 -lvl 5 -y 210 -defaultsOSRD
preplace inst axi_iic_main -pg 1 -lvl 5 -y 500 -defaultsOSRD
preplace inst sys_concat_intc -pg 1 -lvl 4 -y 190 -defaultsOSRD
preplace inst sys_audio_clkgen -pg 1 -lvl 3 -y 840 -defaultsOSRD
preplace inst axi_hdmi_dma -pg 1 -lvl 3 -y 420 -defaultsOSRD
preplace inst sys_rstgen -pg 1 -lvl 1 -y 880 -defaultsOSRD
preplace inst axi_cpu_interconnect -pg 1 -lvl 2 -y 730 -defaultsOSRD
preplace inst axi_spdif_tx_core -pg 1 -lvl 4 -y 860 -defaultsOSRD
preplace inst sys_ps7 -pg 1 -lvl 5 -y 1390 -defaultsOSRD
preplace netloc S00_AXI_2 1 3 1 1010
preplace netloc axi_hdmi_core_hdmi_out_clk 1 5 1 NJ
preplace netloc sys_ps7_SPI1_MOSI_O 1 5 1 NJ
preplace netloc ps_intr_06_1 1 0 4 NJ 160 NJ 160 NJ 160 NJ
preplace netloc sys_ps7_GPIO_O 1 5 1 NJ
preplace netloc ps_intr_02_1 1 0 4 NJ 80 NJ 80 NJ 80 NJ
preplace netloc axi_hdmi_core_hdmi_16_data 1 5 1 NJ
preplace netloc ps_intr_01_1 1 0 4 NJ 60 NJ 60 NJ 60 NJ
preplace netloc sys_audio_clkgen_clk_out1 1 3 1 N
preplace netloc axi_hdmi_core_vdma_fs 1 2 4 650 310 NJ 390 1350 410 1830
preplace netloc ps_intr_09_1 1 0 4 NJ 220 NJ 220 NJ 220 NJ
preplace netloc ps_intr_13_1 1 0 4 NJ 300 NJ 300 NJ 300 NJ
preplace netloc sys_ps7_GPIO_T 1 5 1 NJ
preplace netloc axi_hdmi_clkgen_clk_0 1 3 2 NJ 500 1300
preplace netloc ps_intr_05_1 1 0 4 NJ 140 NJ 140 NJ 140 NJ
preplace netloc sys_ps7_FCLK_RESET0_N 1 0 6 40 1830 NJ 1830 NJ 1830 NJ 1830 NJ 1830 1770
preplace netloc ps_intr_12_1 1 0 4 NJ 280 NJ 280 NJ 280 NJ
preplace netloc axi_cpu_interconnect_M04_AXI 1 2 2 NJ 770 990
preplace netloc ps_intr_07_1 1 0 4 NJ 180 NJ 180 NJ 180 NJ
preplace netloc spi0_sdi_i_1 1 0 6 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 1790
preplace netloc ps_intr_00_1 1 0 4 NJ 40 NJ 40 NJ 40 NJ
preplace netloc sys_ps7_SPI1_SS2_O 1 5 1 NJ
preplace netloc axi_cpu_interconnect_M01_AXI 1 2 1 640
preplace netloc sys_ps7_SPI0_SS1_O 1 5 1 NJ
preplace netloc axi_spdif_tx_core_DMA_REQ 1 4 1 1290
preplace netloc axi_hdmi_core_hdmi_16_data_e 1 5 1 NJ
preplace netloc spi1_clk_i_1 1 0 6 NJ 1750 NJ 1750 NJ 1750 NJ 1750 NJ 1770 1830
preplace netloc spi0_csn_i_1 1 0 6 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 1770
preplace netloc sys_ps7_DDR 1 5 1 NJ
preplace netloc axi_hp0_interconnect_M00_AXI 1 4 1 1300
preplace netloc ps_intr_08_1 1 0 4 NJ 200 NJ 200 NJ 200 NJ
preplace netloc axi_iic_main_IIC 1 5 1 NJ
preplace netloc sys_ps7_SPI0_MOSI_O 1 5 1 NJ
preplace netloc sys_ps7_SPI1_SS_O 1 5 1 NJ
preplace netloc gpio_i_1 1 0 6 NJ 970 NJ 970 NJ 970 NJ 970 NJ 970 1830
preplace netloc sys_ps7_SPI1_SCLK_O 1 5 1 NJ
preplace netloc ps_intr_04_1 1 0 4 NJ 120 NJ 120 NJ 120 NJ
preplace netloc ps_intr_10_1 1 0 4 NJ 240 NJ 240 NJ 240 NJ
preplace netloc axi_cpu_interconnect_M03_AXI 1 2 3 NJ 750 NJ 750 1290
preplace netloc axi_hdmi_core_vdma_ready 1 3 3 NJ 420 NJ 420 1760
preplace netloc axi_cpu_interconnect_M00_AXI 1 2 3 620 530 NJ 480 NJ
preplace netloc axi_hdmi_core_hdmi_16_vsync 1 5 1 NJ
preplace netloc ps_intr_03_1 1 0 4 NJ 100 NJ 100 NJ 100 NJ
preplace netloc axi_hdmi_dma_m_axis_mm2s_tdata 1 3 2 NJ 400 1320
preplace netloc sys_200m_clk 1 2 4 650 1820 NJ 1820 NJ 1820 1780
preplace netloc ps_intr_11_1 1 0 4 NJ 260 NJ 260 NJ 260 NJ
preplace netloc sys_concat_intc_dout 1 4 1 1330
preplace netloc axi_iic_main_iic2intc_irpt 1 3 3 1030 440 NJ 430 1760
preplace netloc spi1_sdi_i_1 1 0 6 NJ 1790 NJ 1790 NJ 1790 NJ 1790 NJ 1790 1810
preplace netloc sys_ps7_FIXED_IO 1 5 1 NJ
preplace netloc axi_hdmi_dma_m_axis_mm2s_tvalid 1 3 2 NJ 430 1310
preplace netloc spi0_clk_i_1 1 0 6 NJ 980 NJ 980 NJ 980 NJ 980 NJ 980 1820
preplace netloc axi_cpu_interconnect_M02_AXI 1 2 1 600
preplace netloc spi0_sdo_i_1 1 0 6 NJ 990 NJ 990 NJ 990 NJ 990 NJ 990 1810
preplace netloc axi_hdmi_core_hdmi_16_hsync 1 5 1 NJ
preplace netloc sys_ps7_DMA0_ACK 1 3 3 1030 1810 NJ 1810 1790
preplace netloc sys_cpu_reset 1 1 1 N
preplace netloc spi1_csn_i_1 1 0 6 NJ 1810 NJ 1810 NJ 1800 NJ 1800 NJ 1800 1800
preplace netloc sys_ps7_SPI0_SS2_O 1 5 1 NJ
preplace netloc axi_spdif_tx_core_spdif_tx_o 1 4 2 NJ 870 NJ
preplace netloc sys_cpu_clk 1 0 6 40 790 320 530 610 560 1000 740 1340 1760 1760
preplace netloc sys_cpu_resetn 1 1 4 330 930 630 570 1020 490 1360
preplace netloc sys_ps7_SPI0_SS_O 1 5 1 NJ
preplace netloc sys_ps7_SPI0_SCLK_O 1 5 1 NJ
preplace netloc spi1_sdo_i_1 1 0 6 NJ 1770 NJ 1770 NJ 1770 NJ 1770 NJ 1780 1820
preplace netloc axi_hdmi_dma_mm2s_introut 1 3 1 990
preplace netloc S00_AXI_1 1 1 5 340 1020 NJ 1020 NJ 1020 NJ 1020 1760
preplace netloc sys_ps7_SPI1_SS1_O 1 5 1 NJ
levelinfo -pg 1 0 180 470 820 1160 1560 1850 -top 0 -bot 1840
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


