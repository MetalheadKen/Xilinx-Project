set version "2013.2"
set project_name "zvik_camera_${version}"
set project_dir "project"
set ip_dir "srcs/ip"
set hdl_dir "srcs/hdl"
set ui_dir "srcs/ui"
set constrs_dir "constrs"
set scripts_dir "scripts"
set bd_name "system_top"
set part "xc7z020clg484-1"
set board "xilinx.com:zynq:zc702:3.0"

# set up project
create_project $project_name $project_dir -part $part -force
set_property board $board [current_project]

# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild

create_bd_design "design_1"

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.2 processing_system7_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:3.0 v_axi4s_vid_out_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample:4.0 v_cresample_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_ccm:6.0 v_ccm_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_cfa:7.0 v_cfa_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_spc:7.0 v_spc_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_enhance:8.0 v_enhance_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_stats:6.0 v_stats_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:5.0 v_tpg_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:5.0 v_tpg_2
create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:3.0 v_vid_in_axi4s_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_gamma:7.0 v_gamma_1
create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb:7.0 v_rgb2ycrcb_1
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.0 axis_broadcaster_1
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.0 axis_subset_converter_1
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.0 axi_vdma_1

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_1
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_2
create_bd_cell -type ip -vlnv xilinx.com:user:fmc_imageon_vita_receiver:1.0 fmc_imageon_vita_receiver_1
create_bd_cell -type ip -vlnv xilinx.com:user:zc702_hdmi_out:1.3 zc702_hdmi_out_1
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.0 clk_wiz_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.0 xlconstant_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.0 xlconstant_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4
create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.0 v_tc_1
endgroup

set_property name iic_main [ get_bd_cells /axi_iic_1]
set_property -dict [list CONFIG.C_GPO_WIDTH {3}] [get_bd_cells /iic_main]
set_property name fmc_imageon_iic [ get_bd_cells /axi_iic_2]
create_bd_port -dir O -from 0 -to 0 gpo
connect_bd_net [get_bd_pins /fmc_imageon_iic/gpo] [get_bd_ports /gpo]
set_property name iic_rst [ get_bd_ports /gpo]
set_property name gnd [ get_bd_cells /xlconstant_1]
set_property name vcc [ get_bd_cells /xlconstant_2]
set_property name axi4_stream_clk [ get_bd_cells /clk_wiz_1]
set_property name iic_slice_1 [ get_bd_cells /xlslice_3]
set_property name iic_slice_2 [ get_bd_cells /xlslice_2]

set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] [get_bd_cells /processing_system7_1]
set_property -dict [list CONFIG.HAS_AXI4_LITE {true}] [get_bd_cells /v_spc_1]
set_property -dict [list CONFIG.HAS_AXI4_LITE {true}] [get_bd_cells /v_cfa_1]
set_property -dict [list CONFIG.HAS_AXI4_LITE {true}] [get_bd_cells /v_ccm_1]
set_property -dict [list CONFIG.HAS_AXI4_LITE {true}] [get_bd_cells /v_rgb2ycrcb_1]
set_property -dict [list CONFIG.HAS_AXI4_LITE {true}] [get_bd_cells /v_gamma_1]
set_property -dict [list CONFIG.HAS_AXI4_LITE {true}] [get_bd_cells /v_enhance_1]
set_property -dict [list CONFIG.HAS_AXI4_LITE {true}] [get_bd_cells /v_cresample_1]
set_property -dict [list CONFIG.pattern_control {0} CONFIG.s_video_format {12}] [get_bd_cells /v_tpg_1]
set_property -dict [list CONFIG.pattern_control {0} CONFIG.s_video_format {2}] [get_bd_cells /v_tpg_2]
set_property -dict [list CONFIG.has_rgb_hist {true} CONFIG.has_cc_hist {true} CONFIG.has_y_hist {true}] [get_bd_cells /v_stats_1]
set_property -dict [list CONFIG.M_TDATA_NUM_BYTES {3} CONFIG.S_TDATA_NUM_BYTES {3} CONFIG.M_TUSER_WIDTH {1} CONFIG.S_TUSER_WIDTH {1} CONFIG.HAS_TLAST {1}] [get_bd_cells /axis_broadcaster_1]
set_property -dict [list CONFIG.M_TDATA_NUM_BYTES {4} CONFIG.S_TDATA_NUM_BYTES {3} CONFIG.M_TUSER_WIDTH {1} CONFIG.S_TUSER_WIDTH {1} CONFIG.M_HAS_TLAST {1} CONFIG.S_HAS_TLAST {1} CONFIG.M_HAS_TREADY {0} CONFIG.TDATA_REMAP {8'b00000000, tdata[23:16],tdata[7:0],tdata[15:8]}] [get_bd_cells /axis_subset_converter_1]
set_property -dict [list CONFIG.c_include_mm2s {0} CONFIG.c_include_s2mm_dre {1}] [get_bd_cells /axi_vdma_1]

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" }  [get_bd_cells /processing_system7_1]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_spc_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_cfa_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_tpg_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_tpg_2/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_stats_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_ccm_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_gamma_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_rgb2ycrcb_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_enhance_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_cresample_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /iic_main/s_axi]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /fmc_imageon_iic/s_axi]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /v_tc_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /fmc_imageon_vita_receiver_1/ctrl]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_1/M_AXI_GP0" }  [get_bd_intf_pins /axi_vdma_1/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:board -config {Board_Interface "iic_main" }  [get_bd_intf_pins /iic_main/iic]

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic
connect_bd_intf_net [get_bd_intf_pins /fmc_imageon_iic/iic] [get_bd_intf_ports /iic]
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells /gnd]

set_property -dict [list CONFIG.HAS_INTC_IF {true} CONFIG.enable_detection {true} CONFIG.VIDEO_MODE {1080p}] [get_bd_cells /v_tc_1]

connect_bd_net [get_bd_pins /vcc/const] [get_bd_pins /v_cresample_1/aclken]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_ccm_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_ccm_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_ccm_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_cfa_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_cfa_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_cfa_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_enhance_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_enhance_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_enhance_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_gamma_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_gamma_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_gamma_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_spc_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_spc_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_spc_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_axi4s_vid_out_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_cresample_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_cresample_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_vid_in_axi4s_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_vid_in_axi4s_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_rgb2ycrcb_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_rgb2ycrcb_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_rgb2ycrcb_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_stats_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_stats_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_stats_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tpg_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tpg_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tpg_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tpg_2/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tpg_2/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tpg_2/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /axis_broadcaster_1/aresetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /axis_subset_converter_1/aresetn] [get_bd_pins /vcc/const]

connect_bd_intf_net [get_bd_intf_pins /v_tpg_1/video_out] [get_bd_intf_pins /v_spc_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_spc_1/video_out] [get_bd_intf_pins /v_cfa_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_cfa_1/video_out] [get_bd_intf_pins /v_tpg_2/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_tpg_2/video_out] [get_bd_intf_pins /axis_broadcaster_1/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins /axis_broadcaster_1/M00_AXIS] [get_bd_intf_pins /axis_subset_converter_1/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins /axis_subset_converter_1/M_AXIS] [get_bd_intf_pins /axi_vdma_1/S_AXIS_S2MM]
connect_bd_intf_net [get_bd_intf_pins /axis_broadcaster_1/M01_AXIS] [get_bd_intf_pins /v_stats_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_stats_1/video_out] [get_bd_intf_pins /v_ccm_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_ccm_1/video_out] [get_bd_intf_pins /v_gamma_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_gamma_1/video_out] [get_bd_intf_pins /v_rgb2ycrcb_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_rgb2ycrcb_1/video_out] [get_bd_intf_pins /v_enhance_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_enhance_1/video_out] [get_bd_intf_pins /v_cresample_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_vid_in_axi4s_1/video_out] [get_bd_intf_pins /v_tpg_1/video_in]

#connect_bd_intf_net [get_bd_intf_pins /v_tpg_1/video_out] [get_bd_intf_pins /v_stats_1/video_in]
#connect_bd_intf_net [get_bd_intf_pins /v_stats_1/video_out] [get_bd_intf_pins /v_rgb2ycrcb_1/video_in]
#connect_bd_intf_net [get_bd_intf_pins /v_rgb2ycrcb_1/video_out] [get_bd_intf_pins /v_cresample_1/video_in]
#connect_bd_intf_net [get_bd_intf_pins /v_vid_in_axi4s_1/video_out] [get_bd_intf_pins /v_cfa_1/video_in]

set_property -dict [list CONFIG.DIN_WIDTH {10} CONFIG.DIN_TO {2} CONFIG.DIN_FROM {9}] [get_bd_cells /xlslice_1]
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/xsvi_video_data_o] [get_bd_pins /xlslice_1/Din]
set_property -dict [list CONFIG.DIN_TO {8} CONFIG.DIN_FROM {8}] [get_bd_cells /xlslice_4]
connect_bd_net [get_bd_pins /xlslice_4/Dout] [get_bd_pins /v_vid_in_axi4s_1/axis_enable]
connect_bd_net [get_bd_pins /v_tc_1/intc_if] [get_bd_pins /xlslice_4/Din]

set_property -dict [list CONFIG.C_M_AXIS_VIDEO_FORMAT {12}] [get_bd_cells /v_vid_in_axi4s_1]
connect_bd_net [get_bd_pins /xlslice_1/Dout] [get_bd_pins /v_vid_in_axi4s_1/vid_data]
connect_bd_net [get_bd_pins /gnd/const] [get_bd_pins /v_vid_in_axi4s_1/rst]
connect_bd_net -net [get_bd_net /gnd_const] [get_bd_pins /fmc_imageon_vita_receiver_1/trigger1] [get_bd_pins /gnd/const]
connect_bd_net -net [get_bd_net /gnd_const] [get_bd_pins /fmc_imageon_vita_receiver_1/reset] [get_bd_pins /gnd/const]
connect_bd_net -net [get_bd_net /gnd_const] [get_bd_pins /zc702_hdmi_out_1/reset] [get_bd_pins /gnd/const]
connect_bd_net -net [get_bd_net /gnd_const] [get_bd_pins /zc702_hdmi_out_1/audio_spdif] [get_bd_pins /gnd/const]

create_bd_port -dir O io_hdmio_spdif
connect_bd_net [get_bd_pins /zc702_hdmi_out_1/io_hdmio_spdif] [get_bd_ports /io_hdmio_spdif]
create_bd_port -dir O -from 15 -to 0 io_hdmio_video
connect_bd_net [get_bd_pins /zc702_hdmi_out_1/io_hdmio_video] [get_bd_ports /io_hdmio_video]
create_bd_port -dir O io_hdmio_vsync
connect_bd_net [get_bd_pins /zc702_hdmi_out_1/io_hdmio_vsync] [get_bd_ports /io_hdmio_vsync]
create_bd_port -dir O io_hdmio_hsync
connect_bd_net [get_bd_pins /zc702_hdmi_out_1/io_hdmio_hsync] [get_bd_ports /io_hdmio_hsync]
create_bd_port -dir O io_hdmio_de
connect_bd_net [get_bd_pins /zc702_hdmi_out_1/io_hdmio_de] [get_bd_ports /io_hdmio_de]
create_bd_port -dir O io_hdmio_clk
connect_bd_net [get_bd_pins /zc702_hdmi_out_1/io_hdmio_clk] [get_bd_ports /io_hdmio_clk]
create_bd_port -dir I -type clk clk_in1
connect_bd_net [get_bd_pins /axi4_stream_clk/clk_in1] [get_bd_ports /clk_in1]
set_property -dict [list CONFIG.PRIM_IN_FREQ {148.5} CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {148.5} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {37.125}] [get_bd_cells /axi4_stream_clk]

connect_bd_net [get_bd_pins /axi4_stream_clk/clk_out1] [get_bd_pins /fmc_imageon_vita_receiver_1/clk4x]
connect_bd_net [get_bd_pins /axi4_stream_clk/clk_out2] [get_bd_pins /fmc_imageon_vita_receiver_1/clk]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_vid_in_axi4s_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_vid_in_axi4s_1/vid_io_in_clk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_axi4s_vid_out_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_axi4s_vid_out_1/vid_io_out_clk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_spc_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_cfa_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_tpg_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_tpg_2/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_stats_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_ccm_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_gamma_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_rgb2ycrcb_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_enhance_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_cresample_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /axis_broadcaster_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /axis_subset_converter_1/aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins /axi4_stream_clk/clk_out1]

apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_vdma_1/M_AXI_S2MM" }  [get_bd_intf_pins /processing_system7_1/S_AXI_HP0]

set_property -dict [list CONFIG.PCW_EN_CLK1_PORT {1}] [get_bd_cells /processing_system7_1]
set_property -dict [list CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200}] [get_bd_cells /processing_system7_1]
create_bd_port -dir I io_vita_clk_out_p
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_clk_out_p] [get_bd_ports /io_vita_clk_out_p]
create_bd_port -dir I -from 7 -to 0 io_vita_data_p
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_data_p] [get_bd_ports /io_vita_data_p]
create_bd_port -dir I io_vita_clk_out_n
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_clk_out_n] [get_bd_ports /io_vita_clk_out_n]
create_bd_port -dir I io_vita_sync_p
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_sync_p] [get_bd_ports /io_vita_sync_p]
create_bd_port -dir I io_vita_sync_n
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_sync_n] [get_bd_ports /io_vita_sync_n]
create_bd_port -dir I -from 1 -to 0 io_vita_monitor
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_monitor] [get_bd_ports /io_vita_monitor]
create_bd_port -dir I io_vita_spi_miso
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_spi_miso] [get_bd_ports /io_vita_spi_miso]
create_bd_port -dir I -from 7 -to 0 io_vita_data_n
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_data_n] [get_bd_ports /io_vita_data_n]

connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/xsvi_active_video_o] [get_bd_pins /v_vid_in_axi4s_1/vid_active_video]
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/xsvi_hblank_o] [get_bd_pins /v_vid_in_axi4s_1/vid_hblank]
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/xsvi_vblank_o] [get_bd_pins /v_vid_in_axi4s_1/vid_vblank]
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/xsvi_hsync_o] [get_bd_pins /v_vid_in_axi4s_1/vid_hsync]
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/xsvi_vsync_o] [get_bd_pins /v_vid_in_axi4s_1/vid_vsync]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_vid_in_axi4s_1/vid_io_in_ce] [get_bd_pins /vcc/const]
#connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_vid_in_axi4s_1/axis_enable] [get_bd_pins /vcc/const]

create_bd_port -dir O io_vita_clk_pll
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_clk_pll] [get_bd_ports /io_vita_clk_pll]
create_bd_port -dir O io_vita_reset_n
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_reset_n] [get_bd_ports /io_vita_reset_n]
create_bd_port -dir O io_vita_spi_sclk
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_spi_sclk] [get_bd_ports /io_vita_spi_sclk]
create_bd_port -dir O io_vita_spi_ssel_n
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_spi_ssel_n] [get_bd_ports /io_vita_spi_ssel_n]
create_bd_port -dir O io_vita_spi_mosi
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_spi_mosi] [get_bd_ports /io_vita_spi_mosi]
create_bd_port -dir O -from 2 -to 0 io_vita_trigger
connect_bd_net [get_bd_pins /fmc_imageon_vita_receiver_1/io_vita_trigger] [get_bd_ports /io_vita_trigger]

set_property -dict [list CONFIG.DIN_WIDTH {3}] [get_bd_cells /iic_slice_2]
connect_bd_net [get_bd_pins /iic_slice_2/Dout] [get_bd_pins /fmc_imageon_vita_receiver_1/oe]

connect_bd_net [get_bd_pins /iic_main/gpo] [get_bd_pins /iic_slice_2/Din]
set_property location {1.5 498 1688} [get_bd_cells /iic_slice_1]
connect_bd_net [get_bd_pins /iic_slice_1/Dout] [get_bd_pins /axi4_stream_clk/reset]
set_property -dict [list CONFIG.DIN_WIDTH {3} CONFIG.DIN_TO {2} CONFIG.DIN_FROM {2}] [get_bd_cells /iic_slice_1]
connect_bd_net -net [get_bd_net /iic_main_gpo] [get_bd_pins /iic_slice_1/Din] [get_bd_pins /iic_main/gpo]
connect_bd_intf_net [get_bd_intf_pins /v_cresample_1/video_out] [get_bd_intf_pins /v_axi4s_vid_out_1/video_in]
connect_bd_intf_net [get_bd_intf_pins /v_tc_1/vtiming_out] [get_bd_intf_pins /v_axi4s_vid_out_1/vtiming_in]
set_property -dict [list CONFIG.s_axis_video_format {3} CONFIG.m_axis_video_format {2}] [get_bd_cells /v_cresample_1]
set_property -dict [list CONFIG.C_S_AXIS_VIDEO_FORMAT.VALUE_SRC USER] [get_bd_cells /v_axi4s_vid_out_1]
set_property -dict [list CONFIG.C_S_AXIS_VIDEO_FORMAT {0}] [get_bd_cells /v_axi4s_vid_out_1]
set_property CONFIG.FREQ_HZ 148500000 [ get_bd_ports /clk_in1]

connect_bd_net [get_bd_pins /processing_system7_1/FCLK_CLK1] [get_bd_pins /fmc_imageon_vita_receiver_1/clk200]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /v_tc_1/clk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net [get_bd_pins /v_axi4s_vid_out_1/vid_data] [get_bd_pins /zc702_hdmi_out_1/xsvi_video_data_i]
connect_bd_net [get_bd_pins /v_axi4s_vid_out_1/vid_hsync] [get_bd_pins /zc702_hdmi_out_1/xsvi_hsync_i]
connect_bd_net [get_bd_pins /v_axi4s_vid_out_1/vid_active_video] [get_bd_pins /zc702_hdmi_out_1/xsvi_active_video_i]
connect_bd_net [get_bd_pins /v_axi4s_vid_out_1/vid_vsync] [get_bd_pins /zc702_hdmi_out_1/xsvi_vsync_i]
connect_bd_net [get_bd_pins /v_axi4s_vid_out_1/vid_hblank] [get_bd_pins /zc702_hdmi_out_1/xsvi_hblank_i]
connect_bd_net [get_bd_pins /v_axi4s_vid_out_1/vid_vblank] [get_bd_pins /zc702_hdmi_out_1/xsvi_vblank_i]
connect_bd_net -net [get_bd_net /axi4_stream_clk_clk_out1] [get_bd_pins /zc702_hdmi_out_1/clk] [get_bd_pins /axi4_stream_clk/clk_out1]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_axi4s_vid_out_1/aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tc_1/clken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tc_1/s_axi_aclken] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tc_1/det_clken] [get_bd_pins /vcc/const]
connect_bd_net [get_bd_pins /v_axi4s_vid_out_1/vtg_ce] [get_bd_pins /v_tc_1/gen_clken]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_tc_1/resetn] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /vcc_const] [get_bd_pins /v_axi4s_vid_out_1/vid_io_out_ce] [get_bd_pins /vcc/const]
connect_bd_net -net [get_bd_net /gnd_const] [get_bd_pins /v_axi4s_vid_out_1/rst] [get_bd_pins /gnd/const]
connect_bd_intf_net [get_bd_intf_pins /v_vid_in_axi4s_1/vtiming_out] [get_bd_intf_pins /v_tc_1/vtiming_in]
set_property name clk_200MHz [ get_bd_nets /processing_system7_1_fclk_clk1]
set_property name clk_50MHz [ get_bd_nets /processing_system7_1_fclk_clk0]
regenerate_bd_layout


# add hdl sources and xdc constraints to project
add_files -fileset sources_1 -norecurse $hdl_dir/design_1_wrapper.v
add_files -fileset constrs_1 -norecurse $constrs_dir/top_orig.xdc
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property strategy Area_Explore [get_runs impl_1]

launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream
