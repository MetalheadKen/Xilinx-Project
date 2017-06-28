// $Revision: $ $Date:  $
//-----------------------------------------------------------------------------
//  (c) Copyright 2011 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES. 
//
//----------------------------------------------------------
/*
Module Description:

This is the top level of a bridge from AXI4-Streaming to Video Out
(Data, Hsync, Vsync, Data Enable)
------------------------------------------------------------------------------
*/

`timescale 1ps/1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_axi4s_vid_out_v3_0_axi4s_vid_out_top
#( 
  parameter  C_S_AXIS_VIDEO_DATA_WIDTH = 8,
  parameter  C_S_AXIS_VIDEO_FORMAT = 2,
  parameter  VID_OUT_DATA_WIDTH = 24, 
                                      
  parameter  C_S_AXIS_VIDEO_TDATA_WIDTH = 24, 
  parameter  RAM_ADDR_BITS = 10,    // default depth = 1024(10) min = 32 (5)
  parameter  HYSTERESIS_LEVEL = 12,    // min 12
  parameter  FILL_GUARDBAND = 3,
  parameter  VTG_MASTER_SLAVE = 0 //timing mode, 1= VTG master,0 = VTG is slave
 )
( 
// AXI4-streaming interface
  input   wire                  aclk,                // axi-4 S clock
  input   wire                  rst,                 // general reset
  input   wire                  aclken,              // axi-4 clock enable
  input   wire                  aresetn,             // axi-4 reset active low
  input   wire [C_S_AXIS_VIDEO_TDATA_WIDTH-1:0] s_axis_video_tdata , // axi-4 S data
  input   wire                  s_axis_video_tvalid, // axi-4 S valid 
  output  wire                  s_axis_video_tready, // axi-4 S ready 
  input   wire                  s_axis_video_tuser , // axi-4 S start of field
  input   wire                  s_axis_video_tlast , // axi-4 S end of line
  input   wire                  fid,                 // Field ID, sampled on SOF
  
// video output interface
  input   wire                  vid_io_out_clk ,        // clock for video output
  input   wire                  vid_io_out_ce,              // video clock enable
  output  wire                  vid_active_video   , // video data enable
  output  wire                  vid_vsync      ,     // video vertical sync
  output  wire                  vid_hsync      ,     // video horizontal sync
  output  wire                  vid_vblank      ,    // video vertical blank
  output  wire                  vid_hblank      ,    // video horizontal blank
  output  wire                  vid_field_id    ,    // video field ID
  output  wire [VID_OUT_DATA_WIDTH-1:0] vid_data,    // video data at DDR rate
  
// Register/VTG Interface
  input   wire                  vtg_vsync,       // vsync from the video timing generator
  input   wire                  vtg_hsync,
  input   wire                  vtg_vblank,
  input   wire                  vtg_hblank,
  input   wire                  vtg_active_video,
  input   wire                  vtg_field_id,
  output  wire                  vtg_ce,
  // output status bits
  output  wire                  locked,
  output  wire                  wr_error,
  output  wire                  empty  
);

// Signal declarations 
  wire [VID_OUT_DATA_WIDTH -1:0]        fifo_data;
  wire                          fifo_eol;
  wire                          fifo_sof;
  wire                          fifo_fid;
  wire [RAM_ADDR_BITS -1:0]     fifo_level_rd;
  wire                          fifo_empty;
  wire                          fifo_rd_en;



// Module instances
  v_axi4s_vid_out_v3_0_out_coupler #(
    .DATA_WIDTH     (VID_OUT_DATA_WIDTH),
    .RAM_ADDR_BITS  (RAM_ADDR_BITS),
    .FILL_GUARDBAND (FILL_GUARDBAND)
  )
  out_coupler_i (
    .video_out_clk   (vid_io_out_clk),
    .rst           (rst),
	.vid_ce        (vid_io_out_ce),
    .fifo_rst      (fifo_rst),

    .aclk          (aclk),
    .aclken        (aclken),
    .aresetn       (aresetn),
    .wr_data       ({fid,s_axis_video_tuser,s_axis_video_tlast,
                     s_axis_video_tdata[VID_OUT_DATA_WIDTH-1:0]}),
    .valid         (s_axis_video_tvalid),
    .ready         (s_axis_video_tready),
                 
    .rd_data       (fifo_data),
    .eol           (fifo_eol),
    .sof           (fifo_sof),
	.fid           (fifo_fid),
    .rd_en         (fifo_rd_en),
    .level_wr      (),
    .level_rd      (fifo_level_rd),

    .wr_error      (wr_error),
    .rd_error      (empty),
    .empty         (fifo_empty),

    .locked        (locked)
  );

  v_axi4s_vid_out_v3_0_out_sync #(
    .RAM_ADDR_BITS    (RAM_ADDR_BITS),  
    .HYSTERESIS_LEVEL (HYSTERESIS_LEVEL),
    .VTG_MASTER_SLAVE (VTG_MASTER_SLAVE)
  )
  out_sync_i
  (
    .video_out_clk (vid_io_out_clk),
    .rst         (rst        ),
    .vid_ce      (vid_io_out_ce), 

    .fifo_sof    (fifo_sof),
    .fifo_eol    (fifo_eol),
	.fifo_fid    (fifo_fid),
    .fifo_level  (fifo_level_rd),
    .empty       (fifo_empty),
    .rd_error    (empty),
    .wr_error    (wr_error),
    .read_en     (fifo_rd_en),
    .fifo_rst    (fifo_rst),

    .vsync       (vtg_vsync ),
    .hsync       (vtg_hsync ),
	.field_id    (vtg_field_id),
    .act_vid     (vtg_active_video),
    .clock_en    (vtg_ce),

    .locked      (locked)
  );

v_axi4s_vid_out_v3_0_vid_out_formatter #(
  .DATA_WIDTH (VID_OUT_DATA_WIDTH)
)
vid_out_formatter_i
(
  .video_out_clk  (vid_io_out_clk),
  .rst            (fifo_rst),
  .vid_ce         (vid_io_out_ce),
  .odf_data       (fifo_data),
  .odf_vsync      (vtg_vsync ),
  .odf_hsync      (vtg_hsync ),
  .odf_vblank     (vtg_vblank),
  .odf_hblank     (vtg_hblank),
  .odf_act_vid    (vtg_active_video),
  .odf_field_id   (vtg_field_id),
  .locked         (locked),
  .fifo_rd_en     (fifo_rd_en),

  .video_de       (vid_active_video   ),
  .video_vsync    (vid_vsync),
  .video_hsync    (vid_hsync),
  .video_vblank   (vid_vblank),
  .video_hblank   (vid_hblank),	
  .video_field_id (vid_field_id),
  .video_data     (vid_data )
);

endmodule
