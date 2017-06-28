# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
		
   set Component_Name [ipgui::add_param $IPINST -parent $IPINST -name Component_Name]
   set canvas_spec [ipgui::get_canvasspec -of $IPINST]
   set_property ip_logo "xgui/logicBricks.png" $canvas_spec

   set C_IP_LICENSE_TYPE [ipgui::add_param $IPINST -parent $IPINST -name C_IP_LICENSE_TYPE]
            
   set Regs_Page [ ipgui::add_page $IPINST  -name "Registers interface" -layout vertical]
      set Regs_Page_Gen_Tab [ipgui::add_group $IPINST -parent $Regs_Page -name {General Settings} -layout vertical]
#         set C_REGS_INTERFACE [ipgui::add_param $IPINST -parent $Regs_Page_Gen_Tab -widget comboBox -name C_REGS_INTERFACE]
         set C_READABLE_REGS [ipgui::add_param $IPINST -parent $Regs_Page_Gen_Tab -widget checkBox -name C_READABLE_REGS]
            set_property tooltip {To save additional resources user can disable the read register interface. In this mode only interrupt status register, double/triple video/CLUT buffer registers, power control register and IP version register are readable.} $C_READABLE_REGS
         set C_REG_BYTE_SWAP [ipgui::add_param $IPINST -parent $Regs_Page_Gen_Tab -widget checkBox -name C_REG_BYTE_SWAP]
            set_property tooltip {If set this will change byte ordering on register interface bus (B0B1B2B3 => B3B2B1B0).} $C_REG_BYTE_SWAP
      set Regs_Page_Addr_Tab [ipgui::add_group $IPINST -parent $Regs_Page -name {Address Space} -layout vertical]
         set C_REGS_BASEADDR [ipgui::add_param $IPINST -parent $Regs_Page_Addr_Tab -name C_REGS_BASEADDR]
         set C_REGS_HIGHADDR [ipgui::add_param $IPINST -parent $Regs_Page_Addr_Tab -name C_REGS_HIGHADDR]
#      set Regs_Page_AXI_Tab [ipgui::add_group $IPINST -parent $Regs_Page -name {AXI4-Lite Interface} -layout vertical]
#         set C_S_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -parent $Regs_Page_AXI_Tab -name C_S_AXI_ADDR_WIDTH]
#            set_property tooltip {AXI4-Lite interface address bus width.} $C_S_AXI_ADDR_WIDTH
#         set C_S_AXI_DATA_WIDTH [ipgui::add_param $IPINST -parent $Regs_Page_AXI_Tab -name C_S_AXI_DATA_WIDTH]
#            set_property tooltip {AXI4-Lite interface data bus width.} $C_S_AXI_DATA_WIDTH

   set Mem_Page [ ipgui::add_page $IPINST  -name "Memory interface" -layout vertical]
      set Mem_Page_Gen_Tab [ipgui::add_group $IPINST -parent $Mem_Page -name {General Settings} -layout vertical]
#         set C_VMEM_INTERFACE [ipgui::add_param $IPINST -parent $Mem_Page_Gen_Tab -widget comboBox -name C_VMEM_INTERFACE]
         set C_M_AXI_DATA_WIDTH [ipgui::add_param $IPINST -parent $Mem_Page_Gen_Tab -widget comboBox -name C_M_AXI_DATA_WIDTH]
            set_property tooltip {Increasing data bus width increases available bandwidth but also increases resource utzilization.} $C_M_AXI_DATA_WIDTH
         set C_MEM_BURST [ipgui::add_param $IPINST -parent $Mem_Page_Gen_Tab -widget comboBox -name C_MEM_BURST]
            set_property tooltip {Number of data transfers per single burst request.} $C_MEM_BURST
         set C_MEM_LITTLE_ENDIAN [ipgui::add_param $IPINST -parent $Mem_Page_Gen_Tab -widget comboBox -name C_MEM_LITTLE_ENDIAN]
            set_property tooltip {Default endianness for logiCVC memory access is little.} $C_MEM_LITTLE_ENDIAN
         set C_MEM_BYTE_SWAP [ipgui::add_param $IPINST -parent $Mem_Page_Gen_Tab -widget checkBox -name C_MEM_BYTE_SWAP]
            set_property tooltip {If set this will change byte ordering on memory interface bus (B0B1B2B3 => B3B2B1B0 for 32-bit memory interface data bus width, B0B1B2B3B4B5B6B7 => B7B6B5B4B3B2B1B0 for 64-bit memory interface data bus width, etc).} $C_MEM_BYTE_SWAP
#      set Mem_Page_AXI_Tab [ipgui::add_group $IPINST -parent $Mem_Page -name {AXI4 Interface} -layout vertical]
#         set C_M_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -parent $Mem_Page_AXI_Tab -name C_M_AXI_ADDR_WIDTH]
#            set_property tooltip {AXI4 interface address bus width.} $C_M_AXI_ADDR_WIDTH
#         set C_M_AXI_THREAD_ID_WIDTH [ipgui::add_param $IPINST -parent $Mem_Page_AXI_Tab -name C_M_AXI_THREAD_ID_WIDTH]
#            set_property tooltip {AXI4 interface thread ID width.} $C_M_AXI_THREAD_ID_WIDTH

   set Ext_Page [ ipgui::add_page $IPINST  -name "External video input" -layout vertical]
      set Ext_Page_Gen_Tab [ipgui::add_group $IPINST -parent $Ext_Page -name {General Settings} -layout vertical]
         set C_USE_E_INPUT [ipgui::add_param $IPINST -parent $Ext_Page_Gen_Tab -widget comboBox -name C_USE_E_INPUT]
            set_property tooltip {Syncronize logiCVC to external input and use data as one of the layers.} $C_USE_E_INPUT
         set C_E_DATA_WIDTH [ipgui::add_param $IPINST -parent $Ext_Page_Gen_Tab -widget comboBox -name C_E_DATA_WIDTH]
            set_property tooltip {External parallel input data width.} $C_E_DATA_WIDTH
         set C_E_LAYER [ipgui::add_param $IPINST -parent $Ext_Page_Gen_Tab -widget comboBox -name C_E_LAYER ]
            set_property tooltip {Which layer should be used as external parallel stream.} $C_E_LAYER
      set Ext_Page_Parallel_Tab [ipgui::add_group $IPINST -parent $Ext_Page -name {Parallel video input} -layout vertical]
         set C_USE_E_VCLK_BUFGMUX [ipgui::add_param $IPINST -parent $Ext_Page_Parallel_Tab -widget checkBox -name C_USE_E_VCLK_BUFGMUX]
            set_property tooltip {Use BUFGMUX component for switching clock for external parallel input synchronization.} $C_USE_E_VCLK_BUFGMUX
      set Ext_Page_AXIS_Tab [ipgui::add_group $IPINST -parent $Ext_Page -name {AXI4-Stream video input} -layout vertical]
#         set C_S_AXIS_MAX_SAMPLES_PER_CLOCK [ipgui::add_param $IPINST -parent $Ext_Page_AXIS_Tab -name C_S_AXIS_MAX_SAMPLES_PER_CLOCK]
#            set_property tooltip {Maximum number of samples in the input AXI4-Stream.} $C_S_AXIS_MAX_SAMPLES_PER_CLOCK
         set C_S_AXIS_DATA_WIDTH [ipgui::add_param $IPINST -parent $Ext_Page_AXIS_Tab -name C_S_AXIS_DATA_WIDTH]
            set_property tooltip {AXI4-Stream component width.} $C_S_AXIS_DATA_WIDTH
         set C_S_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -parent $Ext_Page_AXIS_Tab -name C_S_AXIS_TDATA_WIDTH]
            set_property tooltip {AXI4-Stream data width is calculated from component data width and pixels per clock setting.} $C_S_AXIS_TDATA_WIDTH
         set C_S_AXIS_VIDEO_FORMAT [ipgui::add_param $IPINST -parent $Ext_Page_AXIS_Tab -widget comboBox -name C_S_AXIS_VIDEO_FORMAT]
            set_property tooltip {AXI4-Stream video format is determined from layer type setting.} $C_S_AXIS_VIDEO_FORMAT

   set Gen_Page [ ipgui::add_page $IPINST  -name "General settings" -layout horizontal]
      set Gen_Page_Gen_Tab [ipgui::add_group $IPINST -parent $Gen_Page -name {logiCVC General Settings} -layout vertical]
         set C_NUM_OF_LAYERS [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget comboBox -name C_NUM_OF_LAYERS ]
            set_property tooltip {Number of logiCVC layers to be instantiated.} $C_NUM_OF_LAYERS
         set C_ROW_STRIDE [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget comboBox -name C_ROW_STRIDE]
            set_property tooltip {Distance between same column pixels for adjacent rows specified in number of pixels.} $C_ROW_STRIDE
         set C_INCREASE_FIFO [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget comboBox -name C_INCREASE_FIFO]
            set_property tooltip {Increasing the size of layer FIFOs increases BRAM utilization but allows logiCVC to sustain good output picture when large memory bandwidth fluctuations are present in the system.} $C_INCREASE_FIFO
         set C_PIXEL_PER_CLOCK [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget comboBox -name C_PIXEL_PER_CLOCK]
            set_property tooltip {This option enables parallel pixel processing which reduces pixel clock frequency while maintaining the same pixel throughput. This option is only available when using parallel or AXI4-Stream output interface.} $C_PIXEL_PER_CLOCK		
         set C_USE_SIZE_POSITION [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget checkBox -name C_USE_SIZE_POSITION]
            set_property tooltip {Enable functionality of configurable layer size and position.} $C_USE_SIZE_POSITION
         set C_USE_BACKGROUND [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget checkBox -name C_USE_BACKGROUND]
            set_property tooltip {By using background, the last layer is configured as background layer. This means that pixel value is read from logiCVC background color register and not from video memory buffer.} $C_USE_BACKGROUND
         set C_USE_EXT_BUFFERING [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget checkBox -name C_USE_EXT_BUFFERING]
            set_property tooltip {Enables/disables ports used for external control of frame buffering.} $C_USE_EXT_BUFFERING
         set C_USE_XTREME_DSP [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget checkBox -name C_USE_XTREME_DSP]
            set_property tooltip {Enable or disable the use of DSP resources for alpha blending.} $C_USE_XTREME_DSP
         set C_XCOLOR [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget checkBox -name C_XCOLOR]
            set_property tooltip {Enable pixel dithering functionality.} $C_XCOLOR
         set C_USE_GPIO [ipgui::add_param $IPINST -parent $Gen_Page_Gen_Tab -widget checkBox -name C_USE_GPIO]
            set_property tooltip {Use general purpose input and output ports.} $C_USE_GPIO

   set Layer_Page [ ipgui::add_page $IPINST  -name "Layer configuration" -layout vertical]
      set Layer_Page_L0_Tab [ipgui::add_group $IPINST -parent $Layer_Page -name {Layer 0 Configuration} -layout vertical]
         set C_LAYER_0_TYPE [ipgui::add_param $IPINST -parent $Layer_Page_L0_Tab -widget comboBox -name C_LAYER_0_TYPE]
            set_property tooltip {Select between RGB or YCbCr layer.} $C_LAYER_0_TYPE
         set C_LAYER_0_DATA_WIDTH [ipgui::add_param $IPINST -parent $Layer_Page_L0_Tab -widget comboBox -name C_LAYER_0_DATA_WIDTH]
            set_property tooltip {Select between 8, 16, 20, 24 or 30 data bits per pixel. For RGB layer, 30 represents an RGB 101010 format, 24 represents an RGB 888 format, 16 represents RGB 565 format, while 8 can represent either RGB 332 or CLUT format, depending on layer alpha mode selection. For a YCbCr layer, 30 represents a YCbCr 101010 (4:4:4) format, 24 represents a YCbCr 888 (4:4:4) format, 20 represents a YCb YCr 10 10 (4:2:2) format and 16 represents a YCb YCr 88 88 (4:2:2) format.} $C_LAYER_0_DATA_WIDTH
         set C_LAYER_0_ALPHA_MODE [ipgui::add_param $IPINST -parent $Layer_Page_L0_Tab -widget comboBox -name C_LAYER_0_ALPHA_MODE]
            set_property tooltip {Select between layer alpha, pixel alpha or CLUT alpha blending mode.} $C_LAYER_0_ALPHA_MODE
         set C_LAYER_0_ADDR [ipgui::add_param $IPINST -parent $Layer_Page_L0_Tab -name C_LAYER_0_ADDR]
            set_property tooltip {This value can be overridden runtime using layer memory address register. Please consult the logiCVC users manual for proper address assignment.} $C_LAYER_0_ADDR
         set C_BUFFER_0_OFFSET [ipgui::add_param $IPINST -parent $Layer_Page_L0_Tab -name C_BUFFER_0_OFFSET]
            set_property tooltip {Only used with external double/triple buffer switching. Double buffer address offset relative to layer address represented in number of lines where each line can have different size. For example 1KB for 8bpp and C_ROW_STRIDE=1024, 2KB for 16bpp and C_ROW_STRIDE=1024 and 4KB for 24bpp layer and C_ROW_STRIDE=1024 and 8KB for 24bpp layer and C_ROW_STRIDE=2048. Triple buffer address offset is defined as double the double buffer offset.} $C_BUFFER_0_OFFSET
      set Layer_Page_L1_Tab [ipgui::add_group $IPINST -parent $Layer_Page -name {Layer 1 Configuration} -layout vertical]
         set C_LAYER_1_TYPE [ipgui::add_param $IPINST -parent $Layer_Page_L1_Tab -widget comboBox -name C_LAYER_1_TYPE]
            set_property tooltip {Select between RGB, YCbCr or alpha layer.} $C_LAYER_1_TYPE
         set C_LAYER_1_DATA_WIDTH [ipgui::add_param $IPINST -parent $Layer_Page_L1_Tab -widget comboBox -name C_LAYER_1_DATA_WIDTH]
            set_property tooltip {Select between 8, 16, 20, 24 or 30 data bits per pixel. For RGB layer, 30 represents an RGB 101010 format, 24 represents an RGB 888 format, 16 represents RGB 565 format, while 8 can represent either RGB 332 or CLUT format, depending on layer alpha mode selection. For a YCbCr layer, 30 represents a YCbCr 101010 (4:4:4) format, 24 represents a YCbCr 888 (4:4:4) format, 20 represents a YCb YCr 10 10 (4:2:2) format and 16 represents a YCb YCr 88 88 (4:2:2) format.} $C_LAYER_1_DATA_WIDTH
         set C_LAYER_1_ALPHA_MODE [ipgui::add_param $IPINST -parent $Layer_Page_L1_Tab -widget comboBox -name C_LAYER_1_ALPHA_MODE]		
            set_property tooltip {Select between layer alpha, pixel alpha or CLUT alpha blending mode.} $C_LAYER_1_ALPHA_MODE
         set C_LAYER_1_ADDR [ipgui::add_param $IPINST -parent $Layer_Page_L1_Tab -name C_LAYER_1_ADDR]
            set_property tooltip {This value can be overridden runtime using layer memory address register. Please consult the logiCVC users manual for proper address assignment.} $C_LAYER_1_ADDR
         set C_BUFFER_1_OFFSET [ipgui::add_param $IPINST -parent $Layer_Page_L1_Tab -name C_BUFFER_1_OFFSET]
            set_property tooltip {Only used with external double/triple buffer switching. Double buffer address offset relative to layer address represented in number of lines where each line can have different size. For example 1KB for 8bpp and C_ROW_STRIDE=1024, 2KB for 16bpp and C_ROW_STRIDE=1024 and 4KB for 24bpp layer and C_ROW_STRIDE=1024 and 8KB for 24bpp layer and C_ROW_STRIDE=2048. Triple buffer address offset is defined as double the double buffer offset.} $C_BUFFER_1_OFFSET
      set Layer_Page_L2_Tab [ipgui::add_group $IPINST -parent $Layer_Page -name {Layer 2 Configuration} -layout vertical]
         set C_LAYER_2_TYPE [ipgui::add_param $IPINST -parent $Layer_Page_L2_Tab -widget comboBox -name C_LAYER_2_TYPE]
            set_property tooltip {Select between RGB or YCbCr layer.} $C_LAYER_2_TYPE
         set C_LAYER_2_DATA_WIDTH [ipgui::add_param $IPINST -parent $Layer_Page_L2_Tab -widget comboBox -name C_LAYER_2_DATA_WIDTH]
            set_property tooltip {Select between 8, 16, 20, 24 or 30 data bits per pixel. For RGB layer, 30 represents an RGB 101010 format, 24 represents an RGB 888 format, 16 represents RGB 565 format, while 8 can represent either RGB 332 or CLUT format, depending on layer alpha mode selection. For a YCbCr layer, 30 represents a YCbCr 101010 (4:4:4) format, 24 represents a YCbCr 888 (4:4:4) format, 20 represents a YCb YCr 10 10 (4:2:2) format and 16 represents a YCb YCr 88 88 (4:2:2) format.} $C_LAYER_2_DATA_WIDTH
         set C_LAYER_2_ALPHA_MODE [ipgui::add_param $IPINST -parent $Layer_Page_L2_Tab -widget comboBox -name C_LAYER_2_ALPHA_MODE]
            set_property tooltip {Select between layer alpha, pixel alpha or CLUT alpha blending mode.} $C_LAYER_2_ALPHA_MODE
         set C_LAYER_2_ADDR [ipgui::add_param $IPINST -parent $Layer_Page_L2_Tab -name C_LAYER_2_ADDR]
            set_property tooltip {This value can be overridden runtime using layer memory address register. Please consult the logiCVC users manual for proper address assignment.} $C_LAYER_2_ADDR
         set C_BUFFER_2_OFFSET [ipgui::add_param $IPINST -parent $Layer_Page_L2_Tab -name C_BUFFER_2_OFFSET]
            set_property tooltip {Only used with external double/triple buffer switching. Double buffer address offset relative to layer address represented in number of lines where each line can have different size. For example 1KB for 8bpp and C_ROW_STRIDE=1024, 2KB for 16bpp and C_ROW_STRIDE=1024 and 4KB for 24bpp layer and C_ROW_STRIDE=1024 and 8KB for 24bpp layer and C_ROW_STRIDE=2048. Triple buffer address offset is defined as double the double buffer offset.} $C_BUFFER_2_OFFSET
      set Layer_Page_L3_Tab [ipgui::add_group $IPINST -parent $Layer_Page -name {Layer 3 Configuration} -layout vertical]
         set C_LAYER_3_TYPE [ipgui::add_param $IPINST -parent $Layer_Page_L3_Tab -widget comboBox -name C_LAYER_3_TYPE]
            set_property tooltip {Select between RGB, YCbCr or alpha layer.} $C_LAYER_3_TYPE
         set C_LAYER_3_DATA_WIDTH [ipgui::add_param $IPINST -parent $Layer_Page_L3_Tab -widget comboBox -name C_LAYER_3_DATA_WIDTH]
            set_property tooltip {Select between 8, 16, 20, 24 or 30 data bits per pixel. For RGB layer, 30 represents an RGB 101010 format, 24 represents an RGB 888 format, 16 represents RGB 565 format, while 8 can represent either RGB 332 or CLUT format, depending on layer alpha mode selection. For a YCbCr layer, 30 represents a YCbCr 101010 (4:4:4) format, 24 represents a YCbCr 888 (4:4:4) format, 20 represents a YCb YCr 10 10 (4:2:2) format and 16 represents a YCb YCr 88 88 (4:2:2) format.} $C_LAYER_3_DATA_WIDTH
         set C_LAYER_3_ALPHA_MODE [ipgui::add_param $IPINST -parent $Layer_Page_L3_Tab -widget comboBox -name C_LAYER_3_ALPHA_MODE]
            set_property tooltip {Select between layer alpha, pixel alpha or CLUT alpha blending mode.} $C_LAYER_3_ALPHA_MODE
         set C_LAYER_3_ADDR [ipgui::add_param $IPINST -parent $Layer_Page_L3_Tab -name C_LAYER_3_ADDR]
            set_property tooltip {This value can be overridden runtime using layer memory address register. Please consult the logiCVC users manual for proper address assignment.} $C_LAYER_3_ADDR
         set C_BUFFER_3_OFFSET [ipgui::add_param $IPINST -parent $Layer_Page_L3_Tab -name C_BUFFER_3_OFFSET]
            set_property tooltip {Only used with external double/triple buffer switching. Double buffer address offset relative to layer address represented in number of lines where each line can have different size. For example 1KB for 8bpp and C_ROW_STRIDE=1024, 2KB for 16bpp and C_ROW_STRIDE=1024 and 4KB for 24bpp layer and C_ROW_STRIDE=1024 and 8KB for 24bpp layer and C_ROW_STRIDE=2048. Triple buffer address offset is defined as double the double buffer offset.} $C_BUFFER_3_OFFSET
      set Layer_Page_L4_Tab [ipgui::add_group $IPINST -parent $Layer_Page -name {Layer 4 Configuration} -layout vertical]
         set C_LAYER_4_TYPE [ipgui::add_param $IPINST -parent $Layer_Page_L4_Tab -widget comboBox -name C_LAYER_4_TYPE]
            set_property tooltip {Select between RGB or YCbCr layer.} $C_LAYER_4_TYPE
         set C_LAYER_4_DATA_WIDTH [ipgui::add_param $IPINST -parent $Layer_Page_L4_Tab -widget comboBox -name C_LAYER_4_DATA_WIDTH]
            set_property tooltip {Select between 8, 16, 20, 24 or 30 data bits per pixel. For RGB layer, 30 represents an RGB 101010 format, 24 represents an RGB 888 format, 16 represents RGB 565 format, while 8 can represent either RGB 332 or CLUT format, depending on layer alpha mode selection. For a YCbCr layer, 30 represents a YCbCr 101010 (4:4:4) format, 24 represents a YCbCr 888 (4:4:4) format, 20 represents a YCb YCr 10 10 (4:2:2) format and 16 represents a YCb YCr 88 88 (4:2:2) format.} $C_LAYER_4_DATA_WIDTH
         set C_LAYER_4_ALPHA_MODE [ipgui::add_param $IPINST -parent $Layer_Page_L4_Tab -widget comboBox -name C_LAYER_4_ALPHA_MODE]
            set_property tooltip {Select between layer alpha, pixel alpha or CLUT alpha blending mode.} $C_LAYER_4_ALPHA_MODE
         set C_LAYER_4_ADDR [ipgui::add_param $IPINST -parent $Layer_Page_L4_Tab -name C_LAYER_4_ADDR]
            set_property tooltip {This value can be overridden runtime using layer memory address register. Please consult the logiCVC users manual for proper address assignment.} $C_LAYER_4_ADDR
         set C_BUFFER_4_OFFSET [ipgui::add_param $IPINST -parent $Layer_Page_L4_Tab -name C_BUFFER_4_OFFSET]
            set_property tooltip {Only used with external double/triple buffer switching. Double buffer address offset relative to layer address represented in number of lines where each line can have different size. For example 1KB for 8bpp and C_ROW_STRIDE=1024, 2KB for 16bpp and C_ROW_STRIDE=1024 and 4KB for 24bpp layer and C_ROW_STRIDE=1024 and 8KB for 24bpp layer and C_ROW_STRIDE=2048. Triple buffer address offset is defined as double the double buffer offset.} $C_BUFFER_4_OFFSET

   set Output_Page [ ipgui::add_page $IPINST  -name "Output interface" -layout vertical]
      set Output_Page_General [ipgui::add_group $IPINST -parent $Output_Page -name {General Settings} -layout vertical]
         set C_DISPLAY_INTERFACE [ipgui::add_param $IPINST -parent $Output_Page_General -name C_DISPLAY_INTERFACE]
            set_property tooltip {Enable different output types. Independant of this setting the parallel output interface is always active.} $C_DISPLAY_INTERFACE
         set C_DISPLAY_COLOR_SPACE [ipgui::add_param $IPINST -parent $Output_Page_General -widget comboBox -name C_DISPLAY_COLOR_SPACE]
            set_property tooltip {Select output color space and format.} $C_DISPLAY_COLOR_SPACE
      set Output_Page_Parallel_Tab [ipgui::add_group $IPINST -parent $Output_Page -name {Parallel Interface Settings} -layout vertical]
         set C_PIXEL_DATA_WIDTH [ipgui::add_param $IPINST -parent $Output_Page_Parallel_Tab -name C_PIXEL_DATA_WIDTH]
            set_property tooltip {Parallel pixel data width towards the display - bits per pixel (bpp).} $C_PIXEL_DATA_WIDTH
         set C_USE_EMB_SYNC [ipgui::add_param $IPINST -parent $Output_Page_Parallel_Tab -widget checkBox -name C_USE_EMB_SYNC]
            set_property tooltip {Use embedded syncs with parallel output interface.} $C_USE_EMB_SYNC							
         set C_ENABLE_THREE_STATE_CONTROL [ipgui::add_param $IPINST -parent $Output_Page_Parallel_Tab -widget checkBox -name C_ENABLE_THREE_STATE_CONTROL]
            set_property tooltip {Three-state control signals include power sequence control and three-stated parallel video interface.} $C_ENABLE_THREE_STATE_CONTROL
         set C_USE_VCLK2 [ipgui::add_param $IPINST -parent $Output_Page_Parallel_Tab -widget checkBox -name C_USE_VCLK2]
            set_property tooltip {Pixel clock rising edge is set in the middle of the DDR RGB data eye, or if not used, synchronous.} $C_USE_VCLK2
      set Output_Page_LVDS_Tab [ipgui::add_group $IPINST -parent $Output_Page -name {LVDS Interface Settings} -layout vertical]
         set C_LVDS_DATA_WIDTH [ipgui::add_param $IPINST -parent $Output_Page_LVDS_Tab -name C_LVDS_DATA_WIDTH]
            set_property tooltip {Data width of the LVDS display interface type.} $C_LVDS_DATA_WIDTH
      set Output_Page_DVI_Tab [ipgui::add_group $IPINST -parent $Output_Page -name {DVI Interface Settings} -layout vertical]
         set C_VCLK_PERIOD [ipgui::add_param $IPINST -parent $Output_Page_DVI_Tab -name C_VCLK_PERIOD]
            set_property tooltip {VCLK clock period in ps when DVI display interface type is used.} $C_VCLK_PERIOD
         set C_DVI_CLK_MODE [ipgui::add_param $IPINST -parent $Output_Page_DVI_Tab -widget comboBox -name C_DVI_CLK_MODE]
            set_property tooltip {Please consult the logiCVC-ML user's manual for more information on selecting the appropriate mode.} $C_DVI_CLK_MODE
      set Output_Page_ITU_Tab [ipgui::add_group $IPINST -parent $Output_Page -name {ITU656 Interface Settings} -layout vertical]
         set C_ITU656_DATA_WIDTH [ipgui::add_param $IPINST -parent $Output_Page_ITU_Tab -widget comboBox -name C_ITU656_DATA_WIDTH]
      set Output_Page_AXIS_Tab [ipgui::add_group $IPINST -parent $Output_Page -name {AXI4-Stream Interface Settings} -layout vertical]
#         set C_M_AXIS_MAX_SAMPLES_PER_CLOCK [ipgui::add_param $IPINST -parent $Output_Page_AXIS_Tab -name C_M_AXIS_MAX_SAMPLES_PER_CLOCK]
#            set_property tooltip {Maximum number of samples in the output AXI4-Stream.} $C_M_AXIS_MAX_SAMPLES_PER_CLOCK
         set C_M_AXIS_DATA_WIDTH [ipgui::add_param $IPINST -parent $Output_Page_AXIS_Tab -widget comboBox -name C_M_AXIS_DATA_WIDTH]
            set_property tooltip {AXI4-Stream component width.} $C_M_AXIS_DATA_WIDTH
         set C_M_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -parent $Output_Page_AXIS_Tab -name C_M_AXIS_TDATA_WIDTH]
            set_property tooltip {AXI4-Stream data width is calculated from component data width, video format and pixels per clock setting.} $C_M_AXIS_TDATA_WIDTH
         set C_M_AXIS_VIDEO_FORMAT [ipgui::add_param $IPINST -parent $Output_Page_AXIS_Tab -widget comboBox -name C_M_AXIS_VIDEO_FORMAT]
            set_property tooltip {AXI4-Stream video format is determined from display interface color format.} $C_M_AXIS_VIDEO_FORMAT

}

proc update_PARAM_VALUE.C_ITU656_DATA_WIDTH { PARAM_VALUE.C_ITU656_DATA_WIDTH } {
	# Procedure called to update C_ITU656_DATA_WIDTH when any of the dependent parameters in the arguments change
    
}

proc validate_PARAM_VALUE.C_ITU656_DATA_WIDTH { PARAM_VALUE.C_ITU656_DATA_WIDTH } {
	# Procedure called to validate C_ITU656_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_IP_LICENSE_TYPE { PARAM_VALUE.C_IP_LICENSE_TYPE } {
        # Procedure called to update C_IP_LICENSE_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_LICENSE_TYPE { PARAM_VALUE.C_IP_LICENSE_TYPE } {
        # Procedure called to validate C_IP_LICENSE_TYPE
        return true
}

proc update_PARAM_VALUE.C_IP_LICENSE_CHECK { PARAM_VALUE.C_IP_LICENSE_CHECK } {
        # Procedure called to update C_IP_LICENSE_CHECK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_LICENSE_CHECK { PARAM_VALUE.C_IP_LICENSE_CHECK } {
        # Procedure called to validate C_IP_LICENSE_CHECK
        return true
}

proc update_PARAM_VALUE.C_IP_TIME_BEFORE_BREAK { PARAM_VALUE.C_IP_TIME_BEFORE_BREAK } {
        # Procedure called to update C_IP_TIME_BEFORE_BREAK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_TIME_BEFORE_BREAK { PARAM_VALUE.C_IP_TIME_BEFORE_BREAK } {
        # Procedure called to validate C_IP_TIME_BEFORE_BREAK
        return true
}

proc update_PARAM_VALUE.C_IP_MAJOR_REVISION { PARAM_VALUE.C_IP_MAJOR_REVISION } {
        # Procedure called to update C_IP_MAJOR_REVISION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_MAJOR_REVISION { PARAM_VALUE.C_IP_MAJOR_REVISION } {
        # Procedure called to validate C_IP_MAJOR_REVISION
        return true
}

proc update_PARAM_VALUE.C_IP_MINOR_REVISION { PARAM_VALUE.C_IP_MINOR_REVISION } {
        # Procedure called to update C_IP_MINOR_REVISION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_MINOR_REVISION { PARAM_VALUE.C_IP_MINOR_REVISION } {
        # Procedure called to validate C_IP_MINOR_REVISION
        return true
}

proc update_PARAM_VALUE.C_IP_PATCH_LEVEL { PARAM_VALUE.C_IP_PATCH_LEVEL } {
        # Procedure called to update C_IP_PATCH_LEVEL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IP_PATCH_LEVEL { PARAM_VALUE.C_IP_PATCH_LEVEL } {
        # Procedure called to validate C_IP_PATCH_LEVEL
        return true
}

proc update_PARAM_VALUE.C_INCREASE_FIFO { PARAM_VALUE.C_INCREASE_FIFO } {
        # Procedure called to update C_INCREASE_FIFO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_INCREASE_FIFO { PARAM_VALUE.C_INCREASE_FIFO } {
        # Procedure called to validate C_INCREASE_FIFO
        return true
}

proc update_PARAM_VALUE.C_USE_XTREME_DSP { PARAM_VALUE.C_USE_XTREME_DSP } {
        # Procedure called to update C_USE_XTREME_DSP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_XTREME_DSP { PARAM_VALUE.C_USE_XTREME_DSP } {
        # Procedure called to validate C_USE_XTREME_DSP
        return true
}

proc update_PARAM_VALUE.C_DVI_CLK_MODE { PARAM_VALUE.C_DVI_CLK_MODE } {
        # Procedure called to update C_DVI_CLK_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DVI_CLK_MODE { PARAM_VALUE.C_DVI_CLK_MODE } {
        # Procedure called to validate C_DVI_CLK_MODE
        return true
}

proc update_PARAM_VALUE.C_USE_VCLK2 { PARAM_VALUE.C_USE_VCLK2 } {
        # Procedure called to update C_USE_VCLK2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_VCLK2 { PARAM_VALUE.C_USE_VCLK2 } {
        # Procedure called to validate C_USE_VCLK2
        return true
}

proc update_PARAM_VALUE.C_DISPLAY_INTERFACE { PARAM_VALUE.C_DISPLAY_INTERFACE } {
        # Procedure called to update C_DISPLAY_INTERFACE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DISPLAY_INTERFACE { PARAM_VALUE.C_DISPLAY_INTERFACE } {
        # Procedure called to validate C_DISPLAY_INTERFACE
        return true
}

proc update_PARAM_VALUE.C_PIXEL_PER_CLOCK { PARAM_VALUE.C_PIXEL_PER_CLOCK } {
	# Procedure called to update C_PIXEL_PER_CLOCK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_PIXEL_PER_CLOCK { PARAM_VALUE.C_PIXEL_PER_CLOCK } {
	# Procedure called to validate C_PIXEL_PER_CLOCK
	return true
}

proc update_PARAM_VALUE.C_USE_EMB_SYNC { PARAM_VALUE.C_USE_EMB_SYNC } {
	# Procedure called to update C_USE_EMB_SYNC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_EMB_SYNC { PARAM_VALUE.C_USE_EMB_SYNC } {
	# Procedure called to validate C_USE_EMB_SYNC
	return true
}


proc update_PARAM_VALUE.C_DISPLAY_COLOR_SPACE { PARAM_VALUE.C_DISPLAY_COLOR_SPACE } {
        # Procedure called to update C_DISPLAY_COLOR_SPACE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DISPLAY_COLOR_SPACE { PARAM_VALUE.C_DISPLAY_COLOR_SPACE PARAM_VALUE.C_DISPLAY_INTERFACE } {
        # Procedure called to validate C_DISPLAY_COLOR_SPACE

        set display_interface [get_property value ${PARAM_VALUE.C_DISPLAY_INTERFACE}]
        set display_color_space [get_property value ${PARAM_VALUE.C_DISPLAY_COLOR_SPACE}]

        if {($display_interface == 1 && $display_color_space != 1)} {
            set_property errmsg "When ITU656 output is used YCbCr 4:2:2 color space must be selected!" ${PARAM_VALUE.C_DISPLAY_COLOR_SPACE}
            return false
        } elseif {($display_color_space == 1)} {
            if {($display_interface != 0 && $display_interface != 1 && $display_interface != 6)} {
                set_property errmsg "YCbCr 4:2:2 color space output can only be used with parallel, ITU656 or AXI4-Stream output interfaces!" ${PARAM_VALUE.C_DISPLAY_COLOR_SPACE}
                return false
            }
        }
        return true
}

proc update_PARAM_VALUE.C_PIXEL_DATA_WIDTH { PARAM_VALUE.C_PIXEL_DATA_WIDTH } {
        # Procedure called to update C_PIXEL_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_PIXEL_DATA_WIDTH { PARAM_VALUE.C_PIXEL_DATA_WIDTH  PARAM_VALUE.C_DISPLAY_INTERFACE PARAM_VALUE.C_DISPLAY_COLOR_SPACE} {
        # Procedure called to validate C_PIXEL_DATA_WIDTH

        set pixel_data_width [get_property value ${PARAM_VALUE.C_PIXEL_DATA_WIDTH}]
        set display_interface [get_property value ${PARAM_VALUE.C_DISPLAY_INTERFACE}]
        set display_color_space [get_property value ${PARAM_VALUE.C_DISPLAY_COLOR_SPACE}]

        if {$display_interface == 0} {
            if {($display_color_space == 2 && $pixel_data_width != 12 && $pixel_data_width != 24 && $pixel_data_width != 30)} {
                set_property errmsg "When YCbCr 4:4:4 output color space is used, output pixel data width value must be 12x2, 24 or 30!" ${PARAM_VALUE.C_PIXEL_DATA_WIDTH}
                return false
				} elseif {($display_color_space == 1 && $pixel_data_width != 16 && $pixel_data_width != 20)} {
                set_property errmsg "When YCbCr 4:2:2 output color space is used, output pixel data width value must be 16 or 20!" ${PARAM_VALUE.C_PIXEL_DATA_WIDTH}
                return false
            }
        }
        
        return true
}

proc update_PARAM_VALUE.C_LVDS_DATA_WIDTH { PARAM_VALUE.C_LVDS_DATA_WIDTH PARAM_VALUE.C_DISPLAY_INTERFACE } {
        # Procedure called to update C_LVDS_DATA_WIDTH when any of the dependent parameters in the arguments change
        set display_interface [get_property value ${PARAM_VALUE.C_DISPLAY_INTERFACE}]

        if {$display_interface == 2 || $display_interface == 3} {
            set width 4
        } elseif {$display_interface == 4} {
            set width 3
        } else {
            set width 4
        }

        set_property value $width ${PARAM_VALUE.C_LVDS_DATA_WIDTH}
}

proc validate_PARAM_VALUE.C_LVDS_DATA_WIDTH { PARAM_VALUE.C_LVDS_DATA_WIDTH } {
        # Procedure called to validate C_LVDS_DATA_WIDTH
        return true
}

proc update_PARAM_VALUE.C_XCOLOR { PARAM_VALUE.C_XCOLOR } {
        # Procedure called to update C_XCOLOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_XCOLOR { PARAM_VALUE.C_XCOLOR PARAM_VALUE.C_PIXEL_DATA_WIDTH PARAM_VALUE.C_DISPLAY_INTERFACE} {
        # Procedure called to validate C_XCOLOR

        set pixel_data_width [get_property value ${PARAM_VALUE.C_PIXEL_DATA_WIDTH}]
        set display_interface [get_property value ${PARAM_VALUE.C_DISPLAY_INTERFACE}]
        set xcolor [get_property value ${PARAM_VALUE.C_XCOLOR}]

        if {($xcolor == 1)} {
            if {($display_interface != 4 && $pixel_data_width != 18)} {
                set_property errmsg "Error setting dithering function. Dithering is supported only for 18 bits pixel data width or 3-bit LVDS!" ${PARAM_VALUE.C_XCOLOR}
                return false   
            }
        }

        return true
}

proc update_PARAM_VALUE.C_VCLK_PERIOD { PARAM_VALUE.C_VCLK_PERIOD } {
        # Procedure called to update C_VCLK_PERIOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_VCLK_PERIOD { PARAM_VALUE.C_VCLK_PERIOD } {
        # Procedure called to validate C_VCLK_PERIOD
        return true
}

proc update_PARAM_VALUE.C_NUM_OF_LAYERS { PARAM_VALUE.C_NUM_OF_LAYERS } {
        # Procedure called to update C_NUM_OF_LAYERS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_NUM_OF_LAYERS { PARAM_VALUE.C_NUM_OF_LAYERS } {
        # Procedure called to validate C_NUM_OF_LAYERS
        return true
}

proc update_PARAM_VALUE.C_LAYER_0_TYPE { PARAM_VALUE.C_LAYER_0_TYPE } {
        # Procedure called to update C_LAYER_0_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_0_TYPE { PARAM_VALUE.C_LAYER_0_TYPE } {
        # Procedure called to validate C_LAYER_0_TYPE
        return true
}

proc update_PARAM_VALUE.C_LAYER_0_DATA_WIDTH { PARAM_VALUE.C_LAYER_0_DATA_WIDTH } {
        # Procedure called to update C_LAYER_0_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_0_DATA_WIDTH { PARAM_VALUE.C_LAYER_0_DATA_WIDTH PARAM_VALUE.C_LAYER_0_TYPE } {
        # Procedure called to validate C_LAYER_0_DATA_WIDTH

        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_0_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_0_DATA_WIDTH}]

        # Check if RGB Layer is not 20 bit
        if {($layer_type == 0 && $layer_data_width == 20)} {
            set_property errmsg "Error configuring Layer 0. RGB layers can not be 20 bit wide!" ${PARAM_VALUE.C_LAYER_0_DATA_WIDTH}
            return false
        }
        
        return true
}

proc update_PARAM_VALUE.C_LAYER_0_ALPHA_MODE { PARAM_VALUE.C_LAYER_0_ALPHA_MODE } {
        # Procedure called to update C_LAYER_0_ALPHA_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_0_ALPHA_MODE { PARAM_VALUE.C_LAYER_0_ALPHA_MODE PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_LAYER_0_TYPE PARAM_VALUE.C_LAYER_0_DATA_WIDTH} {
        # Procedure called to validate C_LAYER_0_ALPHA_MODE

        set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}]
        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_0_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_0_DATA_WIDTH}]

        # Check if CLUT alpha blending layer is configured as 8 bit wide
        if {($layer_alpha_mode == 2 || $layer_alpha_mode == 3) && ($layer_data_width != 8)} {
            set_property errmsg "Error configuring Layer 0. CLUT alpha blending mode is only possible with 8 bit layer data width!" ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }

        # Check if YCbCr layers are 16, 24 or 30 bit wide or in the case of 8 bit if it is 24 bit CLUT (4:4:4)
        if {($layer_type == 1  && $layer_data_width == 8 && $layer_alpha_mode != 3)} {
            set_property errmsg "Error configuring Layer 0. YCbCr layers can be 16, 20, 24 or 30 bit wide. In the case of 8 bit wide YCbCr layer, layer alpha mode has to be 24 bit CLUT!" ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }

        # Check if 16 bit YCbCr layers are using layer alpha mode
        if {($layer_type == 1  && ($layer_data_width == 16 || $layer_data_width == 20) && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 0. 16 or 20 bit YCbCr layers (4:2:2) can not use pixel alpha blending mode. In case you want to use pixel alpha blending with YCbCr layers you must use 24bit width (4:4:4)!" ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }
		  
		  #Check if 30 bit RGB or YCbCr 4:4:4 use pixel or 16-bit, 24-bit CLUT alpha 
		  if {($layer_data_width == 30 && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 0. 30 bit RGB or YCbCr layers (4:4:4) can use layer alpha blending mode only." ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }

        return true
}

proc update_PARAM_VALUE.C_LAYER_0_ADDR { PARAM_VALUE.C_LAYER_0_ADDR } {
        # Procedure called to update C_LAYER_0_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_0_ADDR { PARAM_VALUE.C_LAYER_0_ADDR } {
        # Procedure called to validate C_LAYER_0_ADDR
        return true
}

proc update_PARAM_VALUE.C_BUFFER_0_OFFSET { PARAM_VALUE.C_BUFFER_0_OFFSET } {
        # Procedure called to update C_BUFFER_0_OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_BUFFER_0_OFFSET { PARAM_VALUE.C_BUFFER_0_OFFSET } {
        # Procedure called to validate C_BUFFER_0_OFFSET
        return true
}

proc update_PARAM_VALUE.C_LAYER_1_TYPE { PARAM_VALUE.C_LAYER_1_TYPE } {
        # Procedure called to update C_LAYER_1_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_1_TYPE { PARAM_VALUE.C_LAYER_1_TYPE } {
        # Procedure called to validate C_LAYER_1_TYPE
        return true
}

proc update_PARAM_VALUE.C_LAYER_1_DATA_WIDTH { PARAM_VALUE.C_LAYER_1_DATA_WIDTH } {
        # Procedure called to update C_LAYER_1_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_1_DATA_WIDTH { PARAM_VALUE.C_LAYER_1_DATA_WIDTH PARAM_VALUE.C_LAYER_1_TYPE } {
        # Procedure called to validate C_LAYER_1_DATA_WIDTH

        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_1_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_1_DATA_WIDTH}]

        # Check if RGB Layer is not 20 bit
        if {($layer_type == 0 && $layer_data_width == 20)} {
            set_property errmsg "Error configuring Layer 1. RGB layers can not be 20 bit wide!" ${PARAM_VALUE.C_LAYER_1_DATA_WIDTH}
            return false
        }
        
        return true
}

proc update_PARAM_VALUE.C_LAYER_1_ALPHA_MODE { PARAM_VALUE.C_LAYER_1_ALPHA_MODE } {
        # Procedure called to update C_LAYER_1_ALPHA_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_1_ALPHA_MODE { PARAM_VALUE.C_LAYER_1_ALPHA_MODE PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_LAYER_1_TYPE PARAM_VALUE.C_LAYER_1_DATA_WIDTH} {
        # Procedure called to validate C_LAYER_1_ALPHA_MODE

        set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}]
        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_1_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_1_DATA_WIDTH}]

        # Check if CLUT alpha blending layer is configured as 8 bit wide
        if {($layer_alpha_mode == 2 || $layer_alpha_mode == 3) && ($layer_data_width != 8)} {
            set_property errmsg "Error configuring Layer 1. CLUT alpha blending mode is only possible with 8 bit layer data width!" ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}
            return false
        }

        # Check if YCbCr layers are 16 or 24 bit wide or in the case of 8 bit if it is 24 bit CLUT (4:4:4)
        if {($layer_type == 1  && $layer_data_width == 8 && $layer_alpha_mode != 3)} {
            set_property errmsg "Error configuring Layer 1. YCbCr layers can be 16 or 24 bit wide. In the case of 8 bit wide YCbCr layer, layer alpha mode has to be 24 bit CLUT!" ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}
            return false
        }

        # Check if 16 bit YCbCr layers are using layer alpha mode
        if {($layer_type == 1  && ($layer_data_width == 16 || $layer_data_width == 20) && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 1. 16 bit YCbCr layers (4:2:2) can not use pixel alpha blending mode. In case you want to use pixel alpha blending with YCbCr layers you must use 24bit width (4:4:4)!" ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}
            return false
        }

        # Check if last layer in the configuration is not an alpha layer. Only RGB or YCbCr are possible
        if {($num_of_layers == 2 && $layer_type == 2)} {
            set_property errmsg "Last layer cannot be alpha layer, only data layer (RGB or YCbCr)!" ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}
            return false
        }

        # Check if alpha layer is set up to 8 bit
        if {($layer_type == 2 && $layer_data_width != 8)} {
            set_property errmsg "Error configuring Layer 1. Alpha layer can only be 8 bit wide!" ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}
            return false
        }
		  
		  #Check if 30 bit RGB or YCbCr 4:4:4 use pixel or 16 -bit, 24-bit CLUT alpha 
		  if {($layer_data_width == 30 && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 1. 30 bit RGB or YCbCr layers (4:4:4) can use layer alpha blending mode only." ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }

       
        return true
}

proc update_PARAM_VALUE.C_LAYER_1_ADDR { PARAM_VALUE.C_LAYER_1_ADDR } {
        # Procedure called to update C_LAYER_1_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_1_ADDR { PARAM_VALUE.C_LAYER_1_ADDR } {
        # Procedure called to validate C_LAYER_1_ADDR
        return true
}

proc update_PARAM_VALUE.C_BUFFER_1_OFFSET { PARAM_VALUE.C_BUFFER_1_OFFSET } {
        # Procedure called to update C_BUFFER_1_OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_BUFFER_1_OFFSET { PARAM_VALUE.C_BUFFER_1_OFFSET } {
        # Procedure called to validate C_BUFFER_1_OFFSET
        return true
}

proc update_PARAM_VALUE.C_LAYER_2_TYPE { PARAM_VALUE.C_LAYER_2_TYPE } {
        # Procedure called to update C_LAYER_2_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_2_TYPE { PARAM_VALUE.C_LAYER_2_TYPE } {
        # Procedure called to validate C_LAYER_2_TYPE
        return true
}

proc update_PARAM_VALUE.C_LAYER_2_DATA_WIDTH { PARAM_VALUE.C_LAYER_2_DATA_WIDTH } {
        # Procedure called to update C_LAYER_2_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_2_DATA_WIDTH { PARAM_VALUE.C_LAYER_2_DATA_WIDTH PARAM_VALUE.C_LAYER_2_TYPE } {
        # Procedure called to validate C_LAYER_2_DATA_WIDTH

        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_2_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_2_DATA_WIDTH}]

        # Check if RGB Layer is not 20 bit
        if {($layer_type == 0 && $layer_data_width == 20)} {
            set_property errmsg "Error configuring Layer 2. RGB layers can not be 20 bit wide!" ${PARAM_VALUE.C_LAYER_2_DATA_WIDTH}
            return false
        }
        
        return true
}

proc update_PARAM_VALUE.C_LAYER_2_ALPHA_MODE { PARAM_VALUE.C_LAYER_2_ALPHA_MODE } {
        # Procedure called to update C_LAYER_2_ALPHA_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_2_ALPHA_MODE { PARAM_VALUE.C_LAYER_2_ALPHA_MODE PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_LAYER_2_TYPE PARAM_VALUE.C_LAYER_2_DATA_WIDTH} {
        # Procedure called to validate C_LAYER_2_ALPHA_MODE

        set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_2_ALPHA_MODE}]
        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_2_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_2_DATA_WIDTH}]

        # Check if CLUT alpha blending layer is configured as 8 bit wide
        if {($layer_alpha_mode == 2 || $layer_alpha_mode == 3) && ($layer_data_width != 8)} {
            set_property errmsg "Error configuring Layer 2. CLUT alpha blending mode is only possible with 8 bit layer data width!" ${PARAM_VALUE.C_LAYER_2_ALPHA_MODE}
            return false
        }

        # Check if YCbCr layers are 16 or 24 bit wide or in the case of 8 bit if it is 24 bit CLUT (4:4:4)
        if {($layer_type == 1  && $layer_data_width == 8 && $layer_alpha_mode != 3)} {
            set_property errmsg "Error configuring Layer 2. YCbCr layers can be 16 or 24 bit wide. In the case of 8 bit wide YCbCr layer, layer alpha mode has to be 24 bit CLUT!" ${PARAM_VALUE.C_LAYER_2_ALPHA_MODE}
            return false
        }

        # Check if 16 bit YCbCr layers are using layer alpha mode
        if {($layer_type == 1  && ($layer_data_width == 16 || $layer_data_width == 20) && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 2. 16 bit YCbCr layers (4:2:2) can not use pixel alpha blending mode. In case you want to use pixel alpha blending with YCbCr layers you must use 24bit width (4:4:4)!" ${PARAM_VALUE.C_LAYER_2_ALPHA_MODE}
            return false
        }
		  
		  #Check if 30 bit RGB or YCbCr 4:4:4 use pixel or 16 -bit, 24-bit CLUT alpha 
		  if {($layer_data_width == 30 && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 2. 30 bit RGB or YCbCr layers (4:4:4) can use layer alpha blending mode only." ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }


        return true
}

proc update_PARAM_VALUE.C_LAYER_2_ADDR { PARAM_VALUE.C_LAYER_2_ADDR } {
        # Procedure called to update C_LAYER_2_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_2_ADDR { PARAM_VALUE.C_LAYER_2_ADDR } {
        # Procedure called to validate C_LAYER_2_ADDR
        return true
}

proc update_PARAM_VALUE.C_BUFFER_2_OFFSET { PARAM_VALUE.C_BUFFER_2_OFFSET } {
        # Procedure called to update C_BUFFER_2_OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_BUFFER_2_OFFSET { PARAM_VALUE.C_BUFFER_2_OFFSET } {
        # Procedure called to validate C_BUFFER_2_OFFSET
        return true
}

proc update_PARAM_VALUE.C_LAYER_3_TYPE { PARAM_VALUE.C_LAYER_3_TYPE } {
        # Procedure called to update C_LAYER_3_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_3_TYPE { PARAM_VALUE.C_LAYER_3_TYPE } {
        # Procedure called to validate C_LAYER_3_TYPE
        return true
}

proc update_PARAM_VALUE.C_LAYER_3_DATA_WIDTH { PARAM_VALUE.C_LAYER_3_DATA_WIDTH } {
        # Procedure called to update C_LAYER_3_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_3_DATA_WIDTH { PARAM_VALUE.C_LAYER_3_DATA_WIDTH PARAM_VALUE.C_LAYER_3_TYPE } {
        # Procedure called to validate C_LAYER_3_DATA_WIDTH

        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_3_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_3_DATA_WIDTH}]

        # Check if RGB Layer is not 20 bit
        if {($layer_type == 0 && $layer_data_width == 20)} {
            set_property errmsg "Error configuring Layer 3. RGB layers can not be 20 bit wide!" ${PARAM_VALUE.C_LAYER_3_DATA_WIDTH}
            return false
        }
        
        return true
}

proc update_PARAM_VALUE.C_LAYER_3_ALPHA_MODE { PARAM_VALUE.C_LAYER_3_ALPHA_MODE } {
        # Procedure called to update C_LAYER_3_ALPHA_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_3_ALPHA_MODE { PARAM_VALUE.C_LAYER_3_ALPHA_MODE PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_LAYER_3_TYPE PARAM_VALUE.C_LAYER_3_DATA_WIDTH } {
        # Procedure called to validate C_LAYER_3_ALPHA_MODE

        set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}]
        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_3_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_3_DATA_WIDTH}]

        # Check if CLUT alpha blending layer is configured as 8 bit wide
        if {($layer_alpha_mode == 2 || $layer_alpha_mode == 3) && ($layer_data_width != 8)} {
            set_property errmsg "Error configuring Layer 3. CLUT alpha blending mode is only possible with 8 bit layer data width!" ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}
            return false
        }

        # Check if YCbCr layers are 16 or 24 bit wide or in the case of 8 bit if it is 24 bit CLUT (4:4:4)
        if {($layer_type == 1  && $layer_data_width == 8 && $layer_alpha_mode != 3)} {
            set_property errmsg "Error configuring Layer 3. YCbCr layers can be 16 or 24 bit wide. In the case of 8 bit wide YCbCr layer, layer alpha mode has to be 24 bit CLUT!" ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}
            return false
        }

        # Check if 16 bit YCbCr layers are using layer alpha mode
        if {($layer_type == 1  && ($layer_data_width == 16 || $layer_data_width == 20) && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 3. 16 bit YCbCr layers (4:2:2) can not use pixel alpha blending mode. In case you want to use pixel alpha blending with YCbCr layers you must use 24bit width (4:4:4)!" ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}
            return false
        }

        # Check if last layer in the configuration is not an alpha layer. Only RGB or YCbCr are possible
        if {($num_of_layers == 4 && $layer_type == 2)} {
            set_property errmsg "Last layer cannot be alpha layer, only data layer (RGB or YCbCr)!" ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}
            return false
        }

        # Check if alpha layer is set up to 8 bit
        if {($layer_type == 2 && $layer_data_width != 8)} {
            set_property errmsg "Error configuring Layer 3. Alpha layer can only be 8 bit wide!" ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}
            return false
        }
		  
		  #Check if 30 bit RGB or YCbCr 4:4:4 use pixel or 16 -bit, 24-bit CLUT alpha 
		  if {($layer_data_width == 30 && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 3. 30 bit RGB or YCbCr layers (4:4:4) can use layer alpha blending mode only." ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }


        return true
}

proc update_PARAM_VALUE.C_LAYER_3_ADDR { PARAM_VALUE.C_LAYER_3_ADDR } {
        # Procedure called to update C_LAYER_3_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_3_ADDR { PARAM_VALUE.C_LAYER_3_ADDR } {
        # Procedure called to validate C_LAYER_3_ADDR
        return true
}

proc update_PARAM_VALUE.C_BUFFER_3_OFFSET { PARAM_VALUE.C_BUFFER_3_OFFSET } {
        # Procedure called to update C_BUFFER_3_OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_BUFFER_3_OFFSET { PARAM_VALUE.C_BUFFER_3_OFFSET } {
        # Procedure called to validate C_BUFFER_3_OFFSET
        return true
}

proc update_PARAM_VALUE.C_LAYER_4_TYPE { PARAM_VALUE.C_LAYER_4_TYPE } {
        # Procedure called to update C_LAYER_4_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_4_TYPE { PARAM_VALUE.C_LAYER_4_TYPE } {
        # Procedure called to validate C_LAYER_4_TYPE
        return true
}

proc update_PARAM_VALUE.C_LAYER_4_DATA_WIDTH { PARAM_VALUE.C_LAYER_4_DATA_WIDTH } {
        # Procedure called to update C_LAYER_4_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_4_DATA_WIDTH { PARAM_VALUE.C_LAYER_4_DATA_WIDTH PARAM_VALUE.C_LAYER_4_TYPE } {
        # Procedure called to validate C_LAYER_4_DATA_WIDTH

        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_4_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_4_DATA_WIDTH}]

        # Check if RGB Layer is not 20 bit
        if {($layer_type == 0 && $layer_data_width == 20)} {
            set_property errmsg "Error configuring Layer 4. RGB layers can not be 20 bit wide!" ${PARAM_VALUE.C_LAYER_4_DATA_WIDTH}
            return false
        }
        
        return true
}

proc update_PARAM_VALUE.C_LAYER_4_ALPHA_MODE { PARAM_VALUE.C_LAYER_4_ALPHA_MODE } {
        # Procedure called to update C_LAYER_4_ALPHA_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_4_ALPHA_MODE { PARAM_VALUE.C_LAYER_4_ALPHA_MODE PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_LAYER_4_TYPE PARAM_VALUE.C_LAYER_4_DATA_WIDTH } {
        # Procedure called to validate C_LAYER_4_ALPHA_MODE

        set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_4_ALPHA_MODE}]
        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set layer_type [get_property value ${PARAM_VALUE.C_LAYER_4_TYPE}]
        set layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_4_DATA_WIDTH}]

        # Check if CLUT alpha blending layer is configured as 8 bit wide
        if {($layer_alpha_mode == 2 || $layer_alpha_mode == 3) && ($layer_data_width != 8)} {
            set_property errmsg "Error configuring Layer 4. CLUT alpha blending mode is only possible with 8 bit layer data width!" ${PARAM_VALUE.C_LAYER_4_ALPHA_MODE}
            return false
        }

        # Check if YCbCr layers are 16 or 24 bit wide or in the case of 8 bit if it is 24 bit CLUT (4:4:4)
        if {($layer_type == 1  && $layer_data_width == 8 && $layer_alpha_mode != 3)} {
            set_property errmsg "Error configuring Layer 4. YCbCr layers can be 16 or 24 bit wide. In the case of 8 bit wide YCbCr layer, layer alpha mode has to be 24 bit CLUT!" ${PARAM_VALUE.C_LAYER_4_ALPHA_MODE}
            return false
        }

        # Check if 16 bit YCbCr layers are using layer alpha mode
        if {($layer_type == 1  && ($layer_data_width == 16 || $layer_data_width == 20) && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 4. 16 bit YCbCr layers (4:2:2) can not use pixel alpha blending mode. In case you want to use pixel alpha blending with YCbCr layers you must use 24bit width (4:4:4)!" ${PARAM_VALUE.C_LAYER_4_ALPHA_MODE}
            return false
        }
		  
		  #Check if 30 bit RGB or YCbCr 4:4:4 use pixel or 16 -bit, 24-bit CLUT alpha 
		  if {($layer_data_width == 30 && $layer_alpha_mode != 0)} {
            set_property errmsg "Error configuring Layer 4. 30 bit RGB or YCbCr layers (4:4:4) can use layer alpha blending mode only." ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}
            return false
        }


        return true
}

proc update_PARAM_VALUE.C_LAYER_4_ADDR { PARAM_VALUE.C_LAYER_4_ADDR } {
        # Procedure called to update C_LAYER_4_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LAYER_4_ADDR { PARAM_VALUE.C_LAYER_4_ADDR } {
        # Procedure called to validate C_LAYER_4_ADDR
        return true
}

proc update_PARAM_VALUE.C_BUFFER_4_OFFSET { PARAM_VALUE.C_BUFFER_4_OFFSET } {
        # Procedure called to update C_BUFFER_4_OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_BUFFER_4_OFFSET { PARAM_VALUE.C_BUFFER_4_OFFSET } {
        # Procedure called to validate C_BUFFER_4_OFFSET
        return true
}

proc update_PARAM_VALUE.C_REGS_INTERFACE { PARAM_VALUE.C_REGS_INTERFACE } {
        # Procedure called to update C_REGS_INTERFACE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REGS_INTERFACE { PARAM_VALUE.C_REGS_INTERFACE } {
        # Procedure called to validate C_REGS_INTERFACE
        return true
}

proc update_PARAM_VALUE.C_READABLE_REGS { PARAM_VALUE.C_READABLE_REGS } {
        # Procedure called to update C_READABLE_REGS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_READABLE_REGS { PARAM_VALUE.C_READABLE_REGS } {
        # Procedure called to validate C_READABLE_REGS
        return true
}

proc update_PARAM_VALUE.C_REG_BYTE_SWAP { PARAM_VALUE.C_REG_BYTE_SWAP } {
        # Procedure called to update C_REG_BYTE_SWAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REG_BYTE_SWAP { PARAM_VALUE.C_REG_BYTE_SWAP } {
        # Procedure called to validate C_REG_BYTE_SWAP
        return true
}

proc update_PARAM_VALUE.C_REGS_BASEADDR { PARAM_VALUE.C_REGS_BASEADDR } {
        # Procedure called to update C_REGS_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REGS_BASEADDR { PARAM_VALUE.C_REGS_BASEADDR } {
        # Procedure called to validate C_REGS_BASEADDR
        return true
}

proc update_PARAM_VALUE.C_REGS_HIGHADDR { PARAM_VALUE.C_REGS_HIGHADDR } {
        # Procedure called to update C_REGS_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REGS_HIGHADDR { PARAM_VALUE.C_REGS_HIGHADDR } {
        # Procedure called to validate C_REGS_HIGHADDR
        return true
}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
        # Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
        # Procedure called to validate C_S_AXI_ADDR_WIDTH
        return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
   # Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
        # Procedure called to validate C_S_AXI_DATA_WIDTH
        return true
}

proc update_PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK { PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK PARAM_VALUE.C_PIXEL_PER_CLOCK } {
	# Procedure called to update C_S_AXIS_MAX_SAMPLES_PER_CLOCK when any of the dependent parameters in the arguments change
   set pix_per_clk [get_property value ${PARAM_VALUE.C_PIXEL_PER_CLOCK}]
   
   set_property value $pix_per_clk ${PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK}
}

proc validate_PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK { PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK } {
	# Procedure called to validate C_S_AXIS_MAX_SAMPLES_PER_CLOCK
	return true
}

proc update_PARAM_VALUE.C_S_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_AXIS_TDATA_WIDTH PARAM_VALUE.C_E_DATA_WIDTH PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK } {
	# Procedure called to update C_S_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
   set pix_data_width [get_property value ${PARAM_VALUE.C_E_DATA_WIDTH}]
   set pix_per_clk [get_property value ${PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK}]

   set temp [expr {$pix_data_width*$pix_per_clk}]
   
   set_property value $temp ${PARAM_VALUE.C_S_AXIS_TDATA_WIDTH}
}

proc validate_PARAM_VALUE.C_S_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_AXIS_TDATA_WIDTH PARAM_VALUE.C_USE_E_INPUT PARAM_VALUE.C_E_DATA_WIDTH } {
	# Procedure called to validate C_S_AXIS_TDATA_WIDTH
   set pix_data_width [get_property value ${PARAM_VALUE.C_E_DATA_WIDTH}]
   set use_ext_input [get_property value ${PARAM_VALUE.C_USE_E_INPUT}]

   if {($use_ext_input == 2)} {
      if {($pix_data_width != 16 && $pix_data_width != 24 && $pix_data_width != 20 && $pix_data_width != 30)} {
          set_property errmsg "When AXI4-Stream input is used (C_USE_E_INPUT = 2), output pixel data width (C_S_AXIS_TDATA_WIDTH) value must be x10, x16, x24 or x30!" ${PARAM_VALUE.C_S_AXIS_TDATA_WIDTH}
          return false
      }
   }

	return true
}

proc update_PARAM_VALUE.C_S_AXIS_VIDEO_FORMAT { PARAM_VALUE.C_S_AXIS_VIDEO_FORMAT PARAM_VALUE.C_E_LAYER PARAM_VALUE.C_LAYER_0_TYPE PARAM_VALUE.C_LAYER_1_TYPE PARAM_VALUE.C_LAYER_2_TYPE PARAM_VALUE.C_LAYER_3_TYPE PARAM_VALUE.C_LAYER_4_TYPE PARAM_VALUE.C_E_DATA_WIDTH } {
	# Procedure called to update C_S_AXIS_VIDEO_FORMAT when any of the dependent parameters in the arguments change
   set ext_layer [get_property value ${PARAM_VALUE.C_E_LAYER}]
   set layer_0_type [get_property value ${PARAM_VALUE.C_LAYER_0_TYPE}]
   set layer_1_type [get_property value ${PARAM_VALUE.C_LAYER_1_TYPE}]
   set layer_2_type [get_property value ${PARAM_VALUE.C_LAYER_2_TYPE}]
   set layer_3_type [get_property value ${PARAM_VALUE.C_LAYER_3_TYPE}]
   set layer_4_type [get_property value ${PARAM_VALUE.C_LAYER_4_TYPE}]
   set ext_data_width [get_property value ${PARAM_VALUE.C_E_DATA_WIDTH}]

   if {$ext_layer == 0} {
      set ext_layer_type $layer_0_type
   } elseif {$ext_layer == 1} {
      set ext_layer_type $layer_1_type
   } elseif {$ext_layer == 2} {
      set ext_layer_type $layer_2_type
   } elseif {$ext_layer == 3} {
      set ext_layer_type $layer_3_type
   } else { #$ext_layer == 4
      set ext_layer_type $layer_4_type
   }

   if {$ext_layer_type == 0} { # RGB
      set format 2
   } elseif {$ext_layer_type == 1} { # YUV
      if {$ext_data_width == 16 || $ext_data_width == 20} {
         set format 0
      } else {
         set format 1 
      }
   }

   set_property value $format ${PARAM_VALUE.C_S_AXIS_VIDEO_FORMAT}
}

proc validate_PARAM_VALUE.C_S_AXIS_VIDEO_FORMAT { PARAM_VALUE.C_S_AXIS_VIDEO_FORMAT } {
	# Procedure called to validate C_S_AXIS_VIDEO_FORMAT
	return true
}

proc update_PARAM_VALUE.C_S_AXIS_DATA_WIDTH { PARAM_VALUE.C_S_AXIS_DATA_WIDTH PARAM_VALUE.C_E_DATA_WIDTH } {
	# Procedure called to update C_S_AXIS_DATA_WIDTH when any of the dependent parameters in the arguments change
   set pix_data_width [get_property value ${PARAM_VALUE.C_E_DATA_WIDTH}]

   if {$pix_data_width == 20 || $pix_data_width == 30} {
      set axis_data_width 10
   } else {
      set axis_data_width 8
   }
   
   set_property value $axis_data_width ${PARAM_VALUE.C_S_AXIS_DATA_WIDTH}
}

proc validate_PARAM_VALUE.C_S_AXIS_DATA_WIDTH { PARAM_VALUE.C_S_AXIS_DATA_WIDTH } {
	# Procedure called to validate C_S_AXIS_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK { PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK PARAM_VALUE.C_PIXEL_PER_CLOCK } {
	# Procedure called to update C_M_AXIS_MAX_SAMPLES_PER_CLOCK when any of the dependent parameters in the arguments change
   set pix_per_clk [get_property value ${PARAM_VALUE.C_PIXEL_PER_CLOCK}]
   
   set_property value $pix_per_clk ${PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK}
}

proc validate_PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK { PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK } {
	# Procedure called to validate C_M_AXIS_MAX_SAMPLES_PER_CLOCK
	return true
}

proc update_PARAM_VALUE.C_M_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_AXIS_TDATA_WIDTH PARAM_VALUE.C_M_AXIS_DATA_WIDTH PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK } {
	# Procedure called to update C_M_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
   set pix_data_width [get_property value ${PARAM_VALUE.C_M_AXIS_DATA_WIDTH}]
   set video_format [get_property value ${PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT}]
   set pix_per_clk [get_property value ${PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK}]
 
   if {$video_format == 0} {
      set temp [expr {2*$pix_data_width*$pix_per_clk}]
   } else { #$video_format == 2 or 1
      set temp [expr {3*$pix_data_width*$pix_per_clk}]
   }
 
   set_property value $temp ${PARAM_VALUE.C_M_AXIS_TDATA_WIDTH}
}

proc validate_PARAM_VALUE.C_M_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_AXIS_TDATA_WIDTH PARAM_VALUE.C_DISPLAY_INTERFACE } {
	# Procedure called to validate C_M_AXIS_TDATA_WIDTH
   return true
}

proc update_PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT { PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT PARAM_VALUE.C_DISPLAY_COLOR_SPACE } {
	# Procedure called to update C_M_AXIS_VIDEO_FORMAT when any of the dependent parameters in the arguments change
   set display_col_space [get_property value ${PARAM_VALUE.C_DISPLAY_COLOR_SPACE}]

   if {$display_col_space == 0} {
      set format 2
   } elseif {$display_col_space == 1} {
      set format 0
   } else { #$display_col_space == 2
      set format 1
   }

   set_property value $format ${PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT}
}

proc validate_PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT { PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT } {
	# Procedure called to validate C_M_AXIS_VIDEO_FORMAT
	return true
}

proc update_PARAM_VALUE.C_M_AXIS_DATA_WIDTH { PARAM_VALUE.C_M_AXIS_DATA_WIDTH } {
	# Procedure called to update C_M_AXIS_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXIS_DATA_WIDTH { PARAM_VALUE.C_M_AXIS_DATA_WIDTH } {
	# Procedure called to validate C_M_AXIS_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_VMEM_INTERFACE { PARAM_VALUE.C_VMEM_INTERFACE } {
        # Procedure called to update C_VMEM_INTERFACE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_VMEM_INTERFACE { PARAM_VALUE.C_VMEM_INTERFACE } {
        # Procedure called to validate C_VMEM_INTERFACE
        return true
}

proc update_PARAM_VALUE.C_MEM_BURST { PARAM_VALUE.C_MEM_BURST } {
        # Procedure called to update C_MEM_BURST when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_MEM_BURST { PARAM_VALUE.C_MEM_BURST } {
        # Procedure called to validate C_MEM_BURST
        return true
}

proc update_PARAM_VALUE.C_MEM_BYTE_SWAP { PARAM_VALUE.C_MEM_BYTE_SWAP } {
        # Procedure called to update C_MEM_BYTE_SWAP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_MEM_BYTE_SWAP { PARAM_VALUE.C_MEM_BYTE_SWAP } {
        # Procedure called to validate C_MEM_BYTE_SWAP
        return true
}

proc update_PARAM_VALUE.C_MEM_LITTLE_ENDIAN { PARAM_VALUE.C_MEM_LITTLE_ENDIAN } {
        # Procedure called to update C_MEM_LITTLE_ENDIAN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_MEM_LITTLE_ENDIAN { PARAM_VALUE.C_MEM_LITTLE_ENDIAN } {
        # Procedure called to validate C_MEM_LITTLE_ENDIAN
        return true
}

proc update_PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH { PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH } {
        # Procedure called to update C_M_AXI_THREAD_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH { PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH } {
        # Procedure called to validate C_M_AXI_THREAD_ID_WIDTH
        return true
}

proc update_PARAM_VALUE.C_M_AXI_DATA_WIDTH { PARAM_VALUE.C_M_AXI_DATA_WIDTH } {
        # Procedure called to update C_M_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_DATA_WIDTH { PARAM_VALUE.C_M_AXI_DATA_WIDTH } {
        # Procedure called to validate C_M_AXI_DATA_WIDTH
        return true
}

proc update_PARAM_VALUE.C_M_AXI_ADDR_WIDTH { PARAM_VALUE.C_M_AXI_ADDR_WIDTH } {
        # Procedure called to update C_M_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_ADDR_WIDTH { PARAM_VALUE.C_M_AXI_ADDR_WIDTH } {
        # Procedure called to validate C_M_AXI_ADDR_WIDTH
        return true
}

proc update_PARAM_VALUE.C_USE_E_INPUT { PARAM_VALUE.C_USE_E_INPUT } {
        # Procedure called to update C_USE_E_INPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_E_INPUT { PARAM_VALUE.C_USE_E_INPUT } {
        # Procedure called to validate C_USE_E_INPUT
        return true
}

proc update_PARAM_VALUE.C_USE_E_VCLK_BUFGMUX { PARAM_VALUE.C_USE_E_VCLK_BUFGMUX } {
        # Procedure called to update C_USE_E_VCLK_BUFGMUX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_E_VCLK_BUFGMUX { PARAM_VALUE.C_USE_E_VCLK_BUFGMUX } {
        # Procedure called to validate C_USE_E_VCLK_BUFGMUX
        return true
}

proc update_PARAM_VALUE.C_ROW_STRIDE { PARAM_VALUE.C_ROW_STRIDE } {
        # Procedure called to update C_ROW_STRIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_ROW_STRIDE { PARAM_VALUE.C_ROW_STRIDE } {
        # Procedure called to validate C_ROW_STRIDE
        return true
}

proc update_PARAM_VALUE.C_USE_SIZE_POSITION { PARAM_VALUE.C_USE_SIZE_POSITION } {
        # Procedure called to update C_USE_SIZE_POSITION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_SIZE_POSITION { PARAM_VALUE.C_USE_SIZE_POSITION } {
        # Procedure called to validate C_USE_SIZE_POSITION
        return true
}

proc update_PARAM_VALUE.C_USE_BACKGROUND { PARAM_VALUE.C_USE_BACKGROUND } {
        # Procedure called to update C_USE_BACKGROUND when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_BACKGROUND { PARAM_VALUE.C_USE_BACKGROUND PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_LAYER_0_TYPE PARAM_VALUE.C_LAYER_1_TYPE PARAM_VALUE.C_LAYER_2_TYPE PARAM_VALUE.C_LAYER_3_TYPE PARAM_VALUE.C_LAYER_4_TYPE PARAM_VALUE.C_LAYER_0_DATA_WIDTH PARAM_VALUE.C_LAYER_1_DATA_WIDTH PARAM_VALUE.C_LAYER_2_DATA_WIDTH PARAM_VALUE.C_LAYER_3_DATA_WIDTH PARAM_VALUE.C_LAYER_4_DATA_WIDTH} {
        # Procedure called to validate C_USE_BACKGROUND

        set use_background [get_property value ${PARAM_VALUE.C_USE_BACKGROUND}]
        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        
        set last_layer [expr $num_of_layers - 1]

        if {($last_layer == 1)} {
            set last_layer_type [get_property value ${PARAM_VALUE.C_LAYER_1_TYPE}]
            set last_layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_1_DATA_WIDTH}]
        } elseif {($last_layer == 2)} {
            set last_layer_type [get_property value ${PARAM_VALUE.C_LAYER_2_TYPE}]
            set last_layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_2_DATA_WIDTH}]
        } elseif {($last_layer == 3)} {
            set last_layer_type [get_property value ${PARAM_VALUE.C_LAYER_3_TYPE}]
            set last_layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_3_DATA_WIDTH}]
        } elseif {($last_layer == 4)} {
            set last_layer_type [get_property value ${PARAM_VALUE.C_LAYER_4_TYPE}]
            set last_layer_data_width [get_property value ${PARAM_VALUE.C_LAYER_4_DATA_WIDTH}]
        }

        # Check if background layer is enabled while only one layer is implemented
        if {($num_of_layers == 1 && $use_background == 1)} {
            set_property errmsg "If only 1 layer is implemented, it cannot be configured as background!" ${PARAM_VALUE.C_USE_BACKGROUND}
            return false
        }

        # Check if background layer is not YCbCr 8 or 16 bit
        if {($use_background == 1)} {
            if {($last_layer_type == 1 && $last_layer_data_width != 24)} {
                set_property errmsg "Background layer can only be RGB 8, 16 or 24 bit, or YCbCr 24 bit (4:4:4)!" ${PARAM_VALUE.C_USE_BACKGROUND}
                return false
            }
        }

        return true
}

proc update_PARAM_VALUE.C_USE_E_INPUT { PARAM_VALUE.C_USE_E_INPUT } {
        # Procedure called to update C_USE_E_INPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_E_INPUT { PARAM_VALUE.C_USE_E_INPUT PARAM_VALUE.C_NUM_OF_LAYERS } {
        # Procedure called to validate C_USE_E_INPUT

        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set use_ext_input [get_property value ${PARAM_VALUE.C_USE_E_INPUT}]

        if {($num_of_layers == 1 && $use_ext_input != 0)} {
            set_property errmsg "If only 1 layer is implemented, external parallel video input cannot be used!" ${PARAM_VALUE.C_USE_E_INPUT}
            return false
        }
        return true
}

proc update_PARAM_VALUE.C_E_LAYER { PARAM_VALUE.C_E_LAYER PARAM_VALUE.C_NUM_OF_LAYERS } {
        # Procedure called to update C_E_LAYER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_E_LAYER { PARAM_VALUE.C_E_LAYER PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_USE_E_INPUT PARAM_VALUE.C_LAYER_0_TYPE PARAM_VALUE.C_LAYER_0_ALPHA_MODE PARAM_VALUE.C_LAYER_1_TYPE PARAM_VALUE.C_LAYER_1_ALPHA_MODE PARAM_VALUE.C_LAYER_2_TYPE PARAM_VALUE.C_LAYER_2_ALPHA_MODE PARAM_VALUE.C_LAYER_3_TYPE PARAM_VALUE.C_LAYER_3_ALPHA_MODE PARAM_VALUE.C_LAYER_4_TYPE PARAM_VALUE.C_LAYER_4_ALPHA_MODE} {
        # Procedure called to validate C_E_LAYER
        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set use_ext_input [get_property value ${PARAM_VALUE.C_USE_E_INPUT}]
        set ext_layer [get_property value ${PARAM_VALUE.C_E_LAYER}]

        if {($use_ext_input != 0) && ($ext_layer > ($num_of_layers - 1))} {
            set_property errmsg "External video input cannot be routed to non-existing layer." ${PARAM_VALUE.C_E_LAYER}
            return false
        }

        if {($use_ext_input != 0)} {
            if {($ext_layer == 0)} {
                set layer_type [get_property value ${PARAM_VALUE.C_LAYER_0_TYPE}]
                set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}]
            } elseif {($ext_layer == 1)} {
                set layer_type [get_property value ${PARAM_VALUE.C_LAYER_1_TYPE}]
                set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}]
            } elseif {($ext_layer == 2)} {
                set layer_type [get_property value ${PARAM_VALUE.C_LAYER_2_TYPE}]
                set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_2_ALPHA_MODE}]
            } elseif {($ext_layer == 3)} {
                set layer_type [get_property value ${PARAM_VALUE.C_LAYER_3_TYPE}]
                set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}]
            } elseif {($ext_layer == 4)} {
                set layer_type [get_property value ${PARAM_VALUE.C_LAYER_4_TYPE}]
                set layer_alpha_mode [get_property value ${PARAM_VALUE.C_LAYER_4_ALPHA_MODE}]
            }

            # Check if external parallel input is not set to alpha plane (layer)
            if {($layer_type == 2)} {
                set_property errmsg "Error configuring layer. External parallel input can only be routed to RGB or YCbCr and not alpha layer!" ${PARAM_VALUE.C_E_LAYER}
                return false
            }

            # Check if external parallel input is using layer alpha mode
            if {($layer_alpha_mode != 0)} {
                set_property errmsg "Error configuring layer. External parallel input can only be routed to layer configured with layer alpha mode!" ${PARAM_VALUE.C_E_LAYER}
                return false
            }
        }

        return true
}

proc update_PARAM_VALUE.C_E_DATA_WIDTH { PARAM_VALUE.C_E_DATA_WIDTH } {
        # Procedure called to update C_E_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_E_DATA_WIDTH { PARAM_VALUE.C_E_DATA_WIDTH PARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_USE_E_INPUT PARAM_VALUE.C_E_LAYER PARAM_VALUE.C_LAYER_0_DATA_WIDTH PARAM_VALUE.C_LAYER_1_DATA_WIDTH PARAM_VALUE.C_LAYER_2_DATA_WIDTH PARAM_VALUE.C_LAYER_3_DATA_WIDTH PARAM_VALUE.C_LAYER_4_DATA_WIDTH} {
        # Procedure called to validate C_E_DATA_WIDTH

        set num_of_layers [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}]
        set use_ext_input [get_property value ${PARAM_VALUE.C_USE_E_INPUT}]
        set ext_layer [get_property value ${PARAM_VALUE.C_E_LAYER}]
        set ext_data_width [get_property value ${PARAM_VALUE.C_E_DATA_WIDTH}]

        if {($use_ext_input != 0)} {
            if {($ext_layer == 0)} {
                set layer_width [get_property value ${PARAM_VALUE.C_LAYER_0_DATA_WIDTH}]
            } elseif {($ext_layer == 1)} {
                set layer_width [get_property value ${PARAM_VALUE.C_LAYER_1_DATA_WIDTH}]
            } elseif {($ext_layer == 2)} {
                set layer_width [get_property value ${PARAM_VALUE.C_LAYER_2_DATA_WIDTH}]
            } elseif {($ext_layer == 3)} {
                set layer_width [get_property value ${PARAM_VALUE.C_LAYER_3_DATA_WIDTH}]
            } elseif {($ext_layer == 4)} {
                set layer_width [get_property value ${PARAM_VALUE.C_LAYER_4_DATA_WIDTH}]
            }

            # Check if external input data width is the same as layer data width to which it is routed
            if {($ext_data_width != $layer_width)} {
                set_property errmsg "Error configuring layer. External input data width does not match data width of the layer to which it routed!" ${PARAM_VALUE.C_E_DATA_WIDTH}
                return false
            }
        }

        return true
}

proc update_PARAM_VALUE.C_USE_EXT_BUFFERING { PARAM_VALUE.C_USE_EXT_BUFFERING } {
        # Procedure called to update C_USE_EXT_BUFFERING when any of the dependent parameters in the argument change
}

proc validate_PARAM_VALUE.C_USE_EXT_BUFFERING { PARAM_VALUE.C_USE_EXT_BUFFERING } {
        # Procedure called to validate C_USE_EXT_BUFFERING
        return true
}

proc update_PARAM_VALUE.C_USE_GPIO { PARAM_VALUE.C_USE_GPIO } {
        # Procedure called to update C_USE_GPIO when any of the dependent parameters in the argument change
}

proc validate_PARAM_VALUE.C_USE_GPIO { PARAM_VALUE.C_USE_GPIO } {
        # Procedure called to validate C_USE_GPIO
        return true
}

proc update_PARAM_VALUE.C_ENABLE_THREE_STATE_CONTROL { PARAM_VALUE.C_ENABLE_THREE_STATE_CONTROL } {
        # Procedure called to update C_ENABLE_THREE_STATE_CONTROL when any of the dependent parameters in the argument change
}

proc validate_PARAM_VALUE.C_ENABLE_THREE_STATE_CONTROL { PARAM_VALUE.C_ENABLE_THREE_STATE_CONTROL } {
        # Procedure called to validate C_ENABLE_THREE_STATE_CONTROL
        return true
}

proc update_PARAM_VALUE.C_VMEM_BASEADDR { PARAM_VALUE.C_VMEM_BASEADDR } {
        # Procedure called to update C_VMEM_BASEADDR when any of the dependent parameters in the argument change
}

proc validate_PARAM_VALUE.C_VMEM_BASEADDR { PARAM_VALUE.C_VMEM_BASEADDR } {
        # Procedure called to validate C_VMEM_BASEADDR
        return true
}

proc update_PARAM_VALUE.C_VMEM_HIGHADDR { PARAM_VALUE.C_VMEM_HIGHADDR } {
        # Procedure called to update C_VMEM_BASEADDR when any of the dependent parameters in the argument change
}

proc validate_PARAM_VALUE.C_VMEM_HIGHADDR { PARAM_VALUE.C_VMEM_HIGHADDR } {
        # Procedure called to validate C_VMEM_HIGHADDR
        return true
}

proc update_MODELPARAM_VALUE.C_IP_LICENSE_TYPE { MODELPARAM_VALUE.C_IP_LICENSE_TYPE PARAM_VALUE.C_IP_LICENSE_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_LICENSE_TYPE}] ${MODELPARAM_VALUE.C_IP_LICENSE_TYPE}
}

proc update_MODELPARAM_VALUE.C_IP_MAJOR_REVISION { MODELPARAM_VALUE.C_IP_MAJOR_REVISION PARAM_VALUE.C_IP_MAJOR_REVISION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_MAJOR_REVISION}] ${MODELPARAM_VALUE.C_IP_MAJOR_REVISION}
}

proc update_MODELPARAM_VALUE.C_IP_MINOR_REVISION { MODELPARAM_VALUE.C_IP_MINOR_REVISION PARAM_VALUE.C_IP_MINOR_REVISION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_MINOR_REVISION}] ${MODELPARAM_VALUE.C_IP_MINOR_REVISION}
}

proc update_MODELPARAM_VALUE.C_IP_PATCH_LEVEL { MODELPARAM_VALUE.C_IP_PATCH_LEVEL PARAM_VALUE.C_IP_PATCH_LEVEL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_PATCH_LEVEL}] ${MODELPARAM_VALUE.C_IP_PATCH_LEVEL}
}

proc update_MODELPARAM_VALUE.C_IP_LICENSE_CHECK { MODELPARAM_VALUE.C_IP_LICENSE_CHECK PARAM_VALUE.C_IP_LICENSE_CHECK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_LICENSE_CHECK}] ${MODELPARAM_VALUE.C_IP_LICENSE_CHECK}
}

proc update_MODELPARAM_VALUE.C_IP_TIME_BEFORE_BREAK { MODELPARAM_VALUE.C_IP_TIME_BEFORE_BREAK PARAM_VALUE.C_IP_TIME_BEFORE_BREAK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IP_TIME_BEFORE_BREAK}] ${MODELPARAM_VALUE.C_IP_TIME_BEFORE_BREAK}
}

proc update_MODELPARAM_VALUE.C_VMEM_INTERFACE { MODELPARAM_VALUE.C_VMEM_INTERFACE PARAM_VALUE.C_VMEM_INTERFACE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_VMEM_INTERFACE}] ${MODELPARAM_VALUE.C_VMEM_INTERFACE}
}

proc update_MODELPARAM_VALUE.C_MEM_BURST { MODELPARAM_VALUE.C_MEM_BURST PARAM_VALUE.C_MEM_BURST } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_MEM_BURST}] ${MODELPARAM_VALUE.C_MEM_BURST}
}

proc update_MODELPARAM_VALUE.C_MEM_BYTE_SWAP { MODELPARAM_VALUE.C_MEM_BYTE_SWAP PARAM_VALUE.C_MEM_BYTE_SWAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_MEM_BYTE_SWAP}] ${MODELPARAM_VALUE.C_MEM_BYTE_SWAP}
}

proc update_MODELPARAM_VALUE.C_MEM_LITTLE_ENDIAN { MODELPARAM_VALUE.C_MEM_LITTLE_ENDIAN PARAM_VALUE.C_MEM_LITTLE_ENDIAN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_MEM_LITTLE_ENDIAN}] ${MODELPARAM_VALUE.C_MEM_LITTLE_ENDIAN}
}

proc update_MODELPARAM_VALUE.C_INCREASE_FIFO { MODELPARAM_VALUE.C_INCREASE_FIFO PARAM_VALUE.C_INCREASE_FIFO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_INCREASE_FIFO}] ${MODELPARAM_VALUE.C_INCREASE_FIFO}
}

proc update_MODELPARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH { MODELPARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH PARAM_VALUE.C_M_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH PARAM_VALUE.C_M_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_REGS_INTERFACE { MODELPARAM_VALUE.C_REGS_INTERFACE PARAM_VALUE.C_REGS_INTERFACE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REGS_INTERFACE}] ${MODELPARAM_VALUE.C_REGS_INTERFACE}
}

proc update_MODELPARAM_VALUE.C_READABLE_REGS { MODELPARAM_VALUE.C_READABLE_REGS PARAM_VALUE.C_READABLE_REGS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_READABLE_REGS}] ${MODELPARAM_VALUE.C_READABLE_REGS}
}

proc update_MODELPARAM_VALUE.C_REG_BYTE_SWAP { MODELPARAM_VALUE.C_REG_BYTE_SWAP PARAM_VALUE.C_REG_BYTE_SWAP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REG_BYTE_SWAP}] ${MODELPARAM_VALUE.C_REG_BYTE_SWAP}
}

proc update_MODELPARAM_VALUE.C_REGS_BASEADDR { MODELPARAM_VALUE.C_REGS_BASEADDR PARAM_VALUE.C_REGS_BASEADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REGS_BASEADDR}] ${MODELPARAM_VALUE.C_REGS_BASEADDR}
}

proc update_MODELPARAM_VALUE.C_REGS_HIGHADDR { MODELPARAM_VALUE.C_REGS_HIGHADDR PARAM_VALUE.C_REGS_HIGHADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REGS_HIGHADDR}] ${MODELPARAM_VALUE.C_REGS_HIGHADDR}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_DATA_WIDTH { MODELPARAM_VALUE.C_M_AXIS_DATA_WIDTH PARAM_VALUE.C_M_AXIS_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXIS_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_VIDEO_FORMAT { MODELPARAM_VALUE.C_M_AXIS_VIDEO_FORMAT PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_VIDEO_FORMAT}] ${MODELPARAM_VALUE.C_M_AXIS_VIDEO_FORMAT}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH PARAM_VALUE.C_M_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK { MODELPARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK}] ${MODELPARAM_VALUE.C_M_AXIS_MAX_SAMPLES_PER_CLOCK}
}

proc update_MODELPARAM_VALUE.C_S_AXIS_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXIS_DATA_WIDTH PARAM_VALUE.C_S_AXIS_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXIS_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXIS_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXIS_VIDEO_FORMAT { MODELPARAM_VALUE.C_S_AXIS_VIDEO_FORMAT PARAM_VALUE.C_S_AXIS_VIDEO_FORMAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXIS_VIDEO_FORMAT}] ${MODELPARAM_VALUE.C_S_AXIS_VIDEO_FORMAT}
}

proc update_MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH PARAM_VALUE.C_S_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK { MODELPARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK}] ${MODELPARAM_VALUE.C_S_AXIS_MAX_SAMPLES_PER_CLOCK}
}

proc update_MODELPARAM_VALUE.C_PIXEL_DATA_WIDTH { MODELPARAM_VALUE.C_PIXEL_DATA_WIDTH PARAM_VALUE.C_PIXEL_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_PIXEL_DATA_WIDTH}] ${MODELPARAM_VALUE.C_PIXEL_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_USE_VCLK2 { MODELPARAM_VALUE.C_USE_VCLK2 PARAM_VALUE.C_USE_VCLK2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_VCLK2}] ${MODELPARAM_VALUE.C_USE_VCLK2}
}

proc update_MODELPARAM_VALUE.C_ROW_STRIDE { MODELPARAM_VALUE.C_ROW_STRIDE PARAM_VALUE.C_ROW_STRIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_ROW_STRIDE}] ${MODELPARAM_VALUE.C_ROW_STRIDE}
}

proc update_MODELPARAM_VALUE.C_XCOLOR { MODELPARAM_VALUE.C_XCOLOR PARAM_VALUE.C_XCOLOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_XCOLOR}] ${MODELPARAM_VALUE.C_XCOLOR}
}

proc update_MODELPARAM_VALUE.C_USE_SIZE_POSITION { MODELPARAM_VALUE.C_USE_SIZE_POSITION PARAM_VALUE.C_USE_SIZE_POSITION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_SIZE_POSITION}] ${MODELPARAM_VALUE.C_USE_SIZE_POSITION}
}

proc update_MODELPARAM_VALUE.C_DISPLAY_INTERFACE { MODELPARAM_VALUE.C_DISPLAY_INTERFACE PARAM_VALUE.C_DISPLAY_INTERFACE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DISPLAY_INTERFACE}] ${MODELPARAM_VALUE.C_DISPLAY_INTERFACE}
}

proc update_MODELPARAM_VALUE.C_PIXEL_PER_CLOCK { MODELPARAM_VALUE.C_PIXEL_PER_CLOCK PARAM_VALUE.C_PIXEL_PER_CLOCK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_PIXEL_PER_CLOCK}] ${MODELPARAM_VALUE.C_PIXEL_PER_CLOCK}
}

proc update_MODELPARAM_VALUE.C_USE_EMB_SYNC { MODELPARAM_VALUE.C_USE_EMB_SYNC PARAM_VALUE.C_USE_EMB_SYNC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_EMB_SYNC}] ${MODELPARAM_VALUE.C_USE_EMB_SYNC}
}

proc update_MODELPARAM_VALUE.C_DISPLAY_COLOR_SPACE { MODELPARAM_VALUE.C_DISPLAY_COLOR_SPACE PARAM_VALUE.C_DISPLAY_COLOR_SPACE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DISPLAY_COLOR_SPACE}] ${MODELPARAM_VALUE.C_DISPLAY_COLOR_SPACE}
}

proc update_MODELPARAM_VALUE.C_LVDS_DATA_WIDTH { MODELPARAM_VALUE.C_LVDS_DATA_WIDTH PARAM_VALUE.C_LVDS_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LVDS_DATA_WIDTH}] ${MODELPARAM_VALUE.C_LVDS_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_VCLK_PERIOD { MODELPARAM_VALUE.C_VCLK_PERIOD PARAM_VALUE.C_VCLK_PERIOD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_VCLK_PERIOD}] ${MODELPARAM_VALUE.C_VCLK_PERIOD}
}

proc update_MODELPARAM_VALUE.C_NUM_OF_LAYERS { MODELPARAM_VALUE.C_NUM_OF_LAYERS PARAM_VALUE.C_NUM_OF_LAYERS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_NUM_OF_LAYERS}] ${MODELPARAM_VALUE.C_NUM_OF_LAYERS}
}

proc update_MODELPARAM_VALUE.C_LAYER_0_TYPE { MODELPARAM_VALUE.C_LAYER_0_TYPE PARAM_VALUE.C_LAYER_0_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_0_TYPE}] ${MODELPARAM_VALUE.C_LAYER_0_TYPE}
}

proc update_MODELPARAM_VALUE.C_LAYER_1_TYPE { MODELPARAM_VALUE.C_LAYER_1_TYPE PARAM_VALUE.C_LAYER_1_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_1_TYPE}] ${MODELPARAM_VALUE.C_LAYER_1_TYPE}
}

proc update_MODELPARAM_VALUE.C_LAYER_2_TYPE { MODELPARAM_VALUE.C_LAYER_2_TYPE PARAM_VALUE.C_LAYER_2_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_2_TYPE}] ${MODELPARAM_VALUE.C_LAYER_2_TYPE}
}

proc update_MODELPARAM_VALUE.C_LAYER_3_TYPE { MODELPARAM_VALUE.C_LAYER_3_TYPE PARAM_VALUE.C_LAYER_3_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_3_TYPE}] ${MODELPARAM_VALUE.C_LAYER_3_TYPE}
}

proc update_MODELPARAM_VALUE.C_LAYER_4_TYPE { MODELPARAM_VALUE.C_LAYER_4_TYPE PARAM_VALUE.C_LAYER_4_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_4_TYPE}] ${MODELPARAM_VALUE.C_LAYER_4_TYPE}
}

proc update_MODELPARAM_VALUE.C_LAYER_0_DATA_WIDTH { MODELPARAM_VALUE.C_LAYER_0_DATA_WIDTH PARAM_VALUE.C_LAYER_0_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_0_DATA_WIDTH}] ${MODELPARAM_VALUE.C_LAYER_0_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_LAYER_1_DATA_WIDTH { MODELPARAM_VALUE.C_LAYER_1_DATA_WIDTH PARAM_VALUE.C_LAYER_1_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_1_DATA_WIDTH}] ${MODELPARAM_VALUE.C_LAYER_1_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_LAYER_2_DATA_WIDTH { MODELPARAM_VALUE.C_LAYER_2_DATA_WIDTH PARAM_VALUE.C_LAYER_2_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_2_DATA_WIDTH}] ${MODELPARAM_VALUE.C_LAYER_2_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_LAYER_3_DATA_WIDTH { MODELPARAM_VALUE.C_LAYER_3_DATA_WIDTH PARAM_VALUE.C_LAYER_3_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_3_DATA_WIDTH}] ${MODELPARAM_VALUE.C_LAYER_3_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_LAYER_4_DATA_WIDTH { MODELPARAM_VALUE.C_LAYER_4_DATA_WIDTH PARAM_VALUE.C_LAYER_4_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_4_DATA_WIDTH}] ${MODELPARAM_VALUE.C_LAYER_4_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_LAYER_0_ALPHA_MODE { MODELPARAM_VALUE.C_LAYER_0_ALPHA_MODE PARAM_VALUE.C_LAYER_0_ALPHA_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_0_ALPHA_MODE}] ${MODELPARAM_VALUE.C_LAYER_0_ALPHA_MODE}
}

proc update_MODELPARAM_VALUE.C_LAYER_1_ALPHA_MODE { MODELPARAM_VALUE.C_LAYER_1_ALPHA_MODE PARAM_VALUE.C_LAYER_1_ALPHA_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_1_ALPHA_MODE}] ${MODELPARAM_VALUE.C_LAYER_1_ALPHA_MODE}
}

proc update_MODELPARAM_VALUE.C_LAYER_2_ALPHA_MODE { MODELPARAM_VALUE.C_LAYER_2_ALPHA_MODE PARAM_VALUE.C_LAYER_2_ALPHA_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_2_ALPHA_MODE}] ${MODELPARAM_VALUE.C_LAYER_2_ALPHA_MODE}
}

proc update_MODELPARAM_VALUE.C_LAYER_3_ALPHA_MODE { MODELPARAM_VALUE.C_LAYER_3_ALPHA_MODE PARAM_VALUE.C_LAYER_3_ALPHA_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_3_ALPHA_MODE}] ${MODELPARAM_VALUE.C_LAYER_3_ALPHA_MODE}
}

proc update_MODELPARAM_VALUE.C_LAYER_4_ALPHA_MODE { MODELPARAM_VALUE.C_LAYER_4_ALPHA_MODE PARAM_VALUE.C_LAYER_4_ALPHA_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_4_ALPHA_MODE}] ${MODELPARAM_VALUE.C_LAYER_4_ALPHA_MODE}
}

proc update_MODELPARAM_VALUE.C_USE_BACKGROUND { MODELPARAM_VALUE.C_USE_BACKGROUND PARAM_VALUE.C_USE_BACKGROUND } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_BACKGROUND}] ${MODELPARAM_VALUE.C_USE_BACKGROUND}
}

proc update_MODELPARAM_VALUE.C_USE_XTREME_DSP { MODELPARAM_VALUE.C_USE_XTREME_DSP PARAM_VALUE.C_USE_XTREME_DSP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_XTREME_DSP}] ${MODELPARAM_VALUE.C_USE_XTREME_DSP}
}

proc update_MODELPARAM_VALUE.C_LAYER_0_ADDR { MODELPARAM_VALUE.C_LAYER_0_ADDR PARAM_VALUE.C_LAYER_0_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_0_ADDR}] ${MODELPARAM_VALUE.C_LAYER_0_ADDR}
}

proc update_MODELPARAM_VALUE.C_LAYER_1_ADDR { MODELPARAM_VALUE.C_LAYER_1_ADDR PARAM_VALUE.C_LAYER_1_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_1_ADDR}] ${MODELPARAM_VALUE.C_LAYER_1_ADDR}
}

proc update_MODELPARAM_VALUE.C_LAYER_2_ADDR { MODELPARAM_VALUE.C_LAYER_2_ADDR PARAM_VALUE.C_LAYER_2_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_2_ADDR}] ${MODELPARAM_VALUE.C_LAYER_2_ADDR}
}

proc update_MODELPARAM_VALUE.C_LAYER_3_ADDR { MODELPARAM_VALUE.C_LAYER_3_ADDR PARAM_VALUE.C_LAYER_3_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_3_ADDR}] ${MODELPARAM_VALUE.C_LAYER_3_ADDR}
}

proc update_MODELPARAM_VALUE.C_LAYER_4_ADDR { MODELPARAM_VALUE.C_LAYER_4_ADDR PARAM_VALUE.C_LAYER_4_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LAYER_4_ADDR}] ${MODELPARAM_VALUE.C_LAYER_4_ADDR}
}

proc update_MODELPARAM_VALUE.C_BUFFER_0_OFFSET { MODELPARAM_VALUE.C_BUFFER_0_OFFSET PARAM_VALUE.C_BUFFER_0_OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_BUFFER_0_OFFSET}] ${MODELPARAM_VALUE.C_BUFFER_0_OFFSET}
}

proc update_MODELPARAM_VALUE.C_BUFFER_1_OFFSET { MODELPARAM_VALUE.C_BUFFER_1_OFFSET PARAM_VALUE.C_BUFFER_1_OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_BUFFER_1_OFFSET}] ${MODELPARAM_VALUE.C_BUFFER_1_OFFSET}
}

proc update_MODELPARAM_VALUE.C_BUFFER_2_OFFSET { MODELPARAM_VALUE.C_BUFFER_2_OFFSET PARAM_VALUE.C_BUFFER_2_OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_BUFFER_2_OFFSET}] ${MODELPARAM_VALUE.C_BUFFER_2_OFFSET}
}

proc update_MODELPARAM_VALUE.C_BUFFER_3_OFFSET { MODELPARAM_VALUE.C_BUFFER_3_OFFSET PARAM_VALUE.C_BUFFER_3_OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_BUFFER_3_OFFSET}] ${MODELPARAM_VALUE.C_BUFFER_3_OFFSET}
}

proc update_MODELPARAM_VALUE.C_BUFFER_4_OFFSET { MODELPARAM_VALUE.C_BUFFER_4_OFFSET PARAM_VALUE.C_BUFFER_4_OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_BUFFER_4_OFFSET}] ${MODELPARAM_VALUE.C_BUFFER_4_OFFSET}
}

proc update_MODELPARAM_VALUE.C_USE_E_INPUT { MODELPARAM_VALUE.C_USE_E_INPUT PARAM_VALUE.C_USE_E_INPUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_E_INPUT}] ${MODELPARAM_VALUE.C_USE_E_INPUT}
}

proc update_MODELPARAM_VALUE.C_USE_E_VCLK_BUFGMUX { MODELPARAM_VALUE.C_USE_E_VCLK_BUFGMUX PARAM_VALUE.C_USE_E_VCLK_BUFGMUX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_E_VCLK_BUFGMUX}] ${MODELPARAM_VALUE.C_USE_E_VCLK_BUFGMUX}
}

proc update_MODELPARAM_VALUE.C_E_LAYER { MODELPARAM_VALUE.C_E_LAYER PARAM_VALUE.C_E_LAYER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_E_LAYER}] ${MODELPARAM_VALUE.C_E_LAYER}
}

proc update_MODELPARAM_VALUE.C_E_DATA_WIDTH { MODELPARAM_VALUE.C_E_DATA_WIDTH PARAM_VALUE.C_E_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_E_DATA_WIDTH}] ${MODELPARAM_VALUE.C_E_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_DVI_CLK_MODE { MODELPARAM_VALUE.C_DVI_CLK_MODE PARAM_VALUE.C_DVI_CLK_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DVI_CLK_MODE}] ${MODELPARAM_VALUE.C_DVI_CLK_MODE}
}

proc update_MODELPARAM_VALUE.C_DVI_CLK_MODE { MODELPARAM_VALUE.C_DVI_CLK_MODE PARAM_VALUE.C_DVI_CLK_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DVI_CLK_MODE}] ${MODELPARAM_VALUE.C_DVI_CLK_MODE}
}

proc update_MODELPARAM_VALUE.C_ITU656_DATA_WIDTH { MODELPARAM_VALUE.C_ITU656_DATA_WIDTH PARAM_VALUE.C_ITU656_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_ITU656_DATA_WIDTH}] ${MODELPARAM_VALUE.C_ITU656_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_VMEM_BASEADDR { MODELPARAM_VALUE.C_VMEM_BASEADDR PARAM_VALUE.C_VMEM_BASEADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_VMEM_BASEADDR}] ${MODELPARAM_VALUE.C_VMEM_BASEADDR}
}

proc update_MODELPARAM_VALUE.C_VMEM_HIGHADDR { MODELPARAM_VALUE.C_VMEM_HIGHADDR PARAM_VALUE.C_VMEM_HIGHADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_VMEM_HIGHADDR}] ${MODELPARAM_VALUE.C_VMEM_HIGHADDR}
}