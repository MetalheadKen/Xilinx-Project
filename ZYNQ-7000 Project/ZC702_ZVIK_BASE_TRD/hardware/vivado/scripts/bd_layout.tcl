{
   Display-IntfAXI4Lite: "false",
   Display-PortTypeClock: "false",
   Display-PortTypeInterrupt: "false",
   Display-PortTypeOthers: "true",
   Display-PortTypeReset: "false",
   DisplayPinAutomationMissing: "1",
   DisplayTieOff: "1",
   comment_0: "Zynq Base TRD 2015.4",
   comment_1: "Interrupts
--------
29: -
30: AXI IIC
31: logiCVC
32: HDMI VDMA Tx
33: TPG VDMA Tx
34: APM
35: HLS VDMA Rx
36: HLS VDMA Tx",
   comment_2: "GPIOs
-----
54: FMC IIC-MUX reset
55: Fsync select
56: TPG reset",
   commentid: "comment_0|comment_1|comment_2|",
   fillcolor_comment_0: "",
   fillcolor_comment_1: "",
   fillcolor_comment_2: "",
   font_comment_0: "54",
   font_comment_1: "15",
   font_comment_2: "15",
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port hdmio -pg 1 -y 730 -defaultsOSRD
preplace port DDR -pg 1 -y 270 -defaultsOSRD
preplace port hdmio_clk -pg 1 -y 750 -defaultsOSRD
preplace port fmc_imageon_iic -pg 1 -y 660 -defaultsOSRD
preplace port fmc_imageon_hdmii_clk -pg 1 -y 20 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 420 -defaultsOSRD
preplace port fmc_imageon_hdmii -pg 1 -y 350 -defaultsOSRD
preplace port si570 -pg 1 -y 200 -defaultsOSRD
preplace portBus fmc_imageon_iic_rst_b -pg 1 -y 350 -defaultsOSRD
preplace inst processing_system7_1 -pg 1 -lvl 3 -y 410 -defaultsOSRD -resize 312 214
preplace inst axi_perf_mon_1 -pg 1 -lvl 3 -y 620 -defaultsOSRD
preplace inst axi_interconnect_hp2 -pg 1 -lvl 2 -y 600 -defaultsOSRD
preplace inst hdmi_output -pg 1 -lvl 1 -y 730 -defaultsOSRD -resize 207 120
preplace inst axi_iic_1 -pg 1 -lvl 4 -y 670 -defaultsOSRD
preplace inst gpio -pg 1 -lvl 4 -y 350 -defaultsOSRD
preplace inst tpg_input -pg 1 -lvl 1 -y 470 -defaultsOSRD -resize 207 103
preplace inst processing -pg 1 -lvl 1 -y 600 -defaultsOSRD -resize 209 118
preplace inst axi_interconnect_gp0 -pg 1 -lvl 4 -y 520 -defaultsOSRD -resize 227 168
preplace inst proc_sys_reset_clk50 -pg 1 -lvl 3 -y 180 -defaultsOSRD
preplace inst interrupts -pg 1 -lvl 2 -y 330 -defaultsOSRD
preplace inst si570_clk -pg 1 -lvl 1 -y 200 -defaultsOSRD
preplace inst proc_sys_reset_clk150 -pg 1 -lvl 3 -y 60 -defaultsOSRD
preplace inst fmc_hdmi_input -pg 1 -lvl 1 -y 350 -defaultsOSRD -resize 209 111
preplace inst const_1 -pg 1 -lvl 2 -y 200 -defaultsOSRD
preplace inst clk_wiz_1 -pg 1 -lvl 2 -y 80 -defaultsOSRD -resize 109 78
preplace inst axi_interconnect_hp0 -pg 1 -lvl 2 -y 440 -defaultsOSRD
preplace netloc processing_system7_1_ddr 1 3 2 NJ 270 NJ
preplace netloc fsync_sel_1 1 0 5 40 260 NJ 260 NJ 260 NJ 260 1250
preplace netloc fmc_hdmi_input_s2mm_fsync_out 1 0 2 50 800 310
preplace netloc processing_system7_1_fclk_clk0 1 1 3 420 30n NJ 30n 1180
preplace netloc axi_interconnect_3_m00_axi 1 2 1 600
preplace netloc axi_perf_mon_1_interrupt 1 1 3 410 970n NJ 970n 1180
preplace netloc ap_rst_n_1 1 0 5 30 250 NJ 250 NJ 250 NJ 250 1260
preplace netloc processing_mm2s_introut 1 1 1 330
preplace netloc proc_sys_reset_clk50_peripheral_aresetn 1 2 2 820 530n 1220
preplace netloc CLK_IN_D_1 1 0 1 NJ
preplace netloc xlconcat_1_dout 1 2 1 NJ
preplace netloc fmc_hdmi_input_s2mm_fsync_out1 1 0 2 50 280 310
preplace netloc processing_system7_1_fixed_io 1 3 2 NJ 420 NJ
preplace netloc processing_system7_1_GPIO_O 1 3 1 970
preplace netloc iic_rst_Dout 1 4 1 NJ
preplace netloc s00_axi_1 1 3 1 NJ
preplace netloc xlconstant_0_dout 1 1 2 320 150 580
preplace netloc proc_sys_reset_clk150_interconnect_aresetn 1 1 4 400 -10n NJ -10n NJ -10n 1630
preplace netloc logicvc_1_pix_clk_o 1 1 4 NJ 750 NJ 750 NJ 750 NJ
preplace netloc tpg_input_s2mm_introut 1 1 1 300
preplace netloc clk_wiz_1_locked 1 2 1 600
preplace netloc clk_50mhz 1 0 4 -50 10n NJ 10n 790 260n 1230
preplace netloc axi_iic_1_iic2intc_irpt 1 1 4 420 650n NJ 550n NJ 760n 1620
preplace netloc tpg_input_M_AXI_S2MM 1 1 1 N
preplace netloc axi_iic_0_IIC 1 4 1 NJ
preplace netloc S00_AXI_2 1 1 1 320
preplace netloc video_clk_1 1 0 2 20 270 310
preplace netloc fmc_hdmi_input_s2mm_introut 1 1 1 310
preplace netloc M06_ARESETN_1 1 0 5 10 150n 370 160n 780 50n 1270 210n 1620
preplace netloc axi_interconnect_1_m00_axi 1 2 1 590
preplace netloc S01_AXI1_1 1 1 1 N
preplace netloc clk_150mhz 1 0 4 -30 130n 380 40n 750 250n 1210
preplace netloc s01_axi_1 1 1 1 320
preplace netloc hdmi_output_vid_io 1 1 4 NJ 730 NJ 730 NJ 730 NJ
preplace netloc S00_AXI1_1 1 1 1 N
preplace netloc IO_HDMII_1 1 0 1 NJ
preplace netloc processing_s2mm_introut 1 1 1 390
preplace netloc proc_sys_reset_clk50_interconnect_aresetn 1 3 1 1260
preplace netloc reset_rtl_1 1 2 2 820 70n 1200
preplace netloc proc_sys_reset_clk150_peripheral_reset 1 0 5 -40 20n NJ 20n NJ 20n NJ 20n 1620
preplace netloc hdmi_output_logicvc_int 1 1 1 340
preplace cgraphic comment_2 place abs 1043 126 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_1 place abs -177 539 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_0 place abs 295 -101 textcolor 4 linecolor 3 linewidth 0
levelinfo -pg 1 0 180 450 780 1110 1280 -top 0 -bot 810
",
   linecolor_comment_0: "",
   linecolor_comment_1: "",
   linecolor_comment_2: "",
   textcolor_comment_0: "",
   textcolor_comment_1: "",
   textcolor_comment_2: "",
}
0