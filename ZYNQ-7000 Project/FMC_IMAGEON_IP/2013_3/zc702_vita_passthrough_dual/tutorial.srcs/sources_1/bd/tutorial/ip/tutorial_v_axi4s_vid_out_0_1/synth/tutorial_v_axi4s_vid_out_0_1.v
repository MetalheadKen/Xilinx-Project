// (c) Copyright 1995-2014 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:ip:v_axi4s_vid_out:3.0
// IP Revision: 2

(* X_CORE_INFO = "v_axi4s_vid_out_v3_0_axi4s_vid_out_top,Vivado 2013.3" *)
(* CHECK_LICENSE_TYPE = "tutorial_v_axi4s_vid_out_0_1,v_axi4s_vid_out_v3_0_axi4s_vid_out_top,{}" *)
(* CORE_GENERATION_INFO = "tutorial_v_axi4s_vid_out_0_1,v_axi4s_vid_out_v3_0_axi4s_vid_out_top,{x_ipProduct=Vivado 2013.3,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=v_axi4s_vid_out,x_ipVersion=3.0,x_ipCoreRevision=2,x_ipLanguage=VHDL,C_S_AXIS_VIDEO_DATA_WIDTH=8,C_S_AXIS_VIDEO_FORMAT=0,VID_OUT_DATA_WIDTH=16,C_S_AXIS_VIDEO_TDATA_WIDTH=16,RAM_ADDR_BITS=10,HYSTERESIS_LEVEL=12,FILL_GUARDBAND=3,VTG_MASTER_SLAVE=0}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module tutorial_v_axi4s_vid_out_0_1 (
  aclk,
  rst,
  aclken,
  aresetn,
  s_axis_video_tdata,
  s_axis_video_tvalid,
  s_axis_video_tready,
  s_axis_video_tuser,
  s_axis_video_tlast,
  fid,
  vid_io_out_clk,
  vid_io_out_ce,
  vid_active_video,
  vid_vsync,
  vid_hsync,
  vid_vblank,
  vid_hblank,
  vid_field_id,
  vid_data,
  vtg_vsync,
  vtg_hsync,
  vtg_vblank,
  vtg_hblank,
  vtg_active_video,
  vtg_field_id,
  vtg_ce,
  locked,
  wr_error,
  empty
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *)
input aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_intf RST" *)
input rst;
(* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 aclken_intf CE" *)
input aclken;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn_intf RST" *)
input aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_in TDATA" *)
input [15 : 0] s_axis_video_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_in TVALID" *)
input s_axis_video_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_in TREADY" *)
output s_axis_video_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_in TUSER" *)
input s_axis_video_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_in TLAST" *)
input s_axis_video_tlast;
input fid;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_io_out_clk_intf CLK" *)
input vid_io_out_clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 vid_io_out_ce_intf CE" *)
input vid_io_out_ce;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_out ACTIVE_VIDEO" *)
output vid_active_video;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_out VSYNC" *)
output vid_vsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_out HSYNC" *)
output vid_hsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_out VBLANK" *)
output vid_vblank;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_out HBLANK" *)
output vid_hblank;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_out FIELD" *)
output vid_field_id;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_out DATA" *)
output [15 : 0] vid_data;
(* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_in VSYNC" *)
input vtg_vsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_in HSYNC" *)
input vtg_hsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_in VBLANK" *)
input vtg_vblank;
(* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_in HBLANK" *)
input vtg_hblank;
(* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_in ACTIVE_VIDEO" *)
input vtg_active_video;
(* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_in FIELD" *)
input vtg_field_id;
output vtg_ce;
output locked;
output wr_error;
output empty;

  v_axi4s_vid_out_v3_0_axi4s_vid_out_top #(
    .C_S_AXIS_VIDEO_DATA_WIDTH(8),
    .C_S_AXIS_VIDEO_FORMAT(0),
    .VID_OUT_DATA_WIDTH(16),
    .C_S_AXIS_VIDEO_TDATA_WIDTH(16),
    .RAM_ADDR_BITS(10),
    .HYSTERESIS_LEVEL(12),
    .FILL_GUARDBAND(3),
    .VTG_MASTER_SLAVE(0)
  ) inst (
    .aclk(aclk),
    .rst(rst),
    .aclken(aclken),
    .aresetn(aresetn),
    .s_axis_video_tdata(s_axis_video_tdata),
    .s_axis_video_tvalid(s_axis_video_tvalid),
    .s_axis_video_tready(s_axis_video_tready),
    .s_axis_video_tuser(s_axis_video_tuser),
    .s_axis_video_tlast(s_axis_video_tlast),
    .fid(fid),
    .vid_io_out_clk(vid_io_out_clk),
    .vid_io_out_ce(vid_io_out_ce),
    .vid_active_video(vid_active_video),
    .vid_vsync(vid_vsync),
    .vid_hsync(vid_hsync),
    .vid_vblank(vid_vblank),
    .vid_hblank(vid_hblank),
    .vid_field_id(vid_field_id),
    .vid_data(vid_data),
    .vtg_vsync(vtg_vsync),
    .vtg_hsync(vtg_hsync),
    .vtg_vblank(vtg_vblank),
    .vtg_hblank(vtg_hblank),
    .vtg_active_video(vtg_active_video),
    .vtg_field_id(vtg_field_id),
    .vtg_ce(vtg_ce),
    .locked(locked),
    .wr_error(wr_error),
    .empty(empty)
  );
endmodule
