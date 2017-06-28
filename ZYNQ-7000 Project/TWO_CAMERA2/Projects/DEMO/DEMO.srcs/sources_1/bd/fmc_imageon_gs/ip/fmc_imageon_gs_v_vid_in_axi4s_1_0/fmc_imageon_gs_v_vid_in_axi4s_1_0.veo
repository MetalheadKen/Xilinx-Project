// (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
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

// IP VLNV: xilinx.com:ip:v_vid_in_axi4s:4.0
// IP Revision: 1

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
fmc_imageon_gs_v_vid_in_axi4s_1_0 your_instance_name (
  .vid_io_in_clk(vid_io_in_clk),              // input wire vid_io_in_clk
  .vid_io_in_ce(vid_io_in_ce),                // input wire vid_io_in_ce
  .vid_io_in_reset(vid_io_in_reset),          // input wire vid_io_in_reset
  .vid_active_video(vid_active_video),        // input wire vid_active_video
  .vid_vblank(vid_vblank),                    // input wire vid_vblank
  .vid_hblank(vid_hblank),                    // input wire vid_hblank
  .vid_vsync(vid_vsync),                      // input wire vid_vsync
  .vid_hsync(vid_hsync),                      // input wire vid_hsync
  .vid_field_id(vid_field_id),                // input wire vid_field_id
  .vid_data(vid_data),                        // input wire [15 : 0] vid_data
  .aclk(aclk),                                // input wire aclk
  .aclken(aclken),                            // input wire aclken
  .aresetn(aresetn),                          // input wire aresetn
  .m_axis_video_tdata(m_axis_video_tdata),    // output wire [15 : 0] m_axis_video_tdata
  .m_axis_video_tvalid(m_axis_video_tvalid),  // output wire m_axis_video_tvalid
  .m_axis_video_tready(m_axis_video_tready),  // input wire m_axis_video_tready
  .m_axis_video_tuser(m_axis_video_tuser),    // output wire m_axis_video_tuser
  .m_axis_video_tlast(m_axis_video_tlast),    // output wire m_axis_video_tlast
  .fid(fid),                                  // output wire fid
  .vtd_active_video(vtd_active_video),        // output wire vtd_active_video
  .vtd_vblank(vtd_vblank),                    // output wire vtd_vblank
  .vtd_hblank(vtd_hblank),                    // output wire vtd_hblank
  .vtd_vsync(vtd_vsync),                      // output wire vtd_vsync
  .vtd_hsync(vtd_hsync),                      // output wire vtd_hsync
  .vtd_field_id(vtd_field_id),                // output wire vtd_field_id
  .overflow(overflow),                        // output wire overflow
  .underflow(underflow),                      // output wire underflow
  .axis_enable(axis_enable)                  // input wire axis_enable
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file fmc_imageon_gs_v_vid_in_axi4s_1_0.v when simulating
// the core, fmc_imageon_gs_v_vid_in_axi4s_1_0. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

