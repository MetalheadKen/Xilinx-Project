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

This is the top level of a bridge from Video (Data, Hsync Vsync Data enable)
to AXI-4 Streaming
------------------------------------------------------------------------------
*/

`timescale 1 ps	/ 1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_vid_in_axi4s_v3_0_vid_in_axi4s_top
#( 
  parameter  C_M_AXIS_VIDEO_DATA_WIDTH = 8,
  parameter  C_M_AXIS_VIDEO_FORMAT = 2,
  parameter  VID_IN_DATA_WIDTH = 24,
  parameter  C_M_AXIS_VIDEO_TDATA_WIDTH = 24,
  parameter  RAM_ADDR_BITS = 11,    // default depth = 1024, min depth 32
  parameter  HYSTERESIS_LEVEL =4   // default = 4
 )
( 

// I/O declarations
  input  wire                  vid_io_in_clk,         // video clock - Pos.
  input  wire                  rst   ,             // reset
  input  wire                  vid_io_in_ce,             // video clock enable
  input  wire                  vid_active_video    ,         // video data enable
  input  wire                  vid_vblank ,        // video vert. blank
  input  wire                  vid_hblank ,        // video horiz. blank
  input  wire                  vid_vsync ,         // video vert. sync
  input  wire                  vid_hsync ,         // video horiz. sync
  input  wire                  vid_field_id,       // video field ID.  
  input  wire [VID_IN_DATA_WIDTH-1:0] vid_data  ,     // video data rate

// AXI4-streaming interface
  input   wire                  aclk,                // axi-4  clock
  input   wire                  aclken,              // axi-4 clock enable
  input   wire                  aresetn,             // axi-4 reset, active low 
  output  wire [C_M_AXIS_VIDEO_TDATA_WIDTH-1:0] m_axis_video_tdata , // axi-4 M data
  output  wire                  m_axis_video_tvalid, // axi-4 M valid 
  input   wire                  m_axis_video_tready, // axi-4 M ready 
  output  wire                  m_axis_video_tuser , // axi-4 M start of field
  output  wire                  m_axis_video_tlast , // axi-4 M end of line
  output  wire                  fid,                 // axi-4 field ID

// Video Timing Detector interface
  output wire                    vtd_active_video, // active video (DE)
  output wire                    vtd_vblank,       // vert. blank
  output wire                    vtd_hblank,       // horiz. blank
  output wire                    vtd_vsync,        // vert. sync
  output wire                    vtd_hsync,        // horiz. sync 
  output wire                    vtd_field_id,     // field ID  
  
// Processor Interface Flags
  output wire                   wr_error,  // FIFO write error (write when full)
  output wire                   empty ,    // FIFO read when empty  

// video timing detector interface
  input   wire                   axis_enable

);

// Register and Wire Declarations
  wire   [VID_IN_DATA_WIDTH+2:0] idf_data;
  wire                           idf_de;  
  wire   [VID_IN_DATA_WIDTH+2:0] rd_data;
  wire                           reset;

  assign  reset = rst || !aresetn;
  assign  m_axis_video_tdata  = rd_data[VID_IN_DATA_WIDTH -1:0];
  assign  m_axis_video_tlast  = rd_data[VID_IN_DATA_WIDTH ];
  assign  m_axis_video_tuser  = rd_data[VID_IN_DATA_WIDTH +1];
  assign  fid                 = rd_data[VID_IN_DATA_WIDTH +2];
  
// Module instances
  v_vid_in_axi4s_v3_0_vid_in_formatter
  #(
    .DATA_WIDTH (VID_IN_DATA_WIDTH)
  )
  vid_in_formatter
  (
    .vid_in_clk   (vid_io_in_clk),
    .rst          (reset),
	.vid_ce       (vid_io_in_ce),
    .vid_de       (vid_active_video),
    .vid_vblank   (vid_vblank),
    .vid_hblank   (vid_hblank),
    .vid_vsync    (vid_vsync ),
    .vid_hsync    (vid_hsync ),
	.vid_field_id (vid_field_id),
    .vid_data     (vid_data ),
    
    .vtd_active_video (vtd_active_video),
    .vtd_vblank       (vtd_vblank      ),
    .vtd_hblank       (vtd_hblank      ),
    .vtd_vsync        (vtd_vsync       ),
    .vtd_hsync        (vtd_hsync       ),
	.vtd_field_id     (vtd_field_id    ),

    .idf_data     (idf_data),
    .idf_de       (idf_de  )
  );

  v_vid_in_axi4s_v3_0_in_coupler 
  #(
   .DATA_WIDTH  (VID_IN_DATA_WIDTH),
   .RAM_ADDR_BITS  (RAM_ADDR_BITS),  
   .HYSTERESIS_LEVEL  (HYSTERESIS_LEVEL)
  )
  in_coupler_i
  ( 
    .vid_in_clk   (vid_io_in_clk),
    .rst          (reset),
	.vid_ce       (vid_io_in_ce),
    .wr_data      (idf_data),
    .wr_en        (idf_de),
    .wr_error     (wr_error ),
    .rd_error     (empty),

    .aclk         (aclk),
    .aclken       (aclken),
    .rd_data      (rd_data),
    .valid        (m_axis_video_tvalid),
    .ready        (m_axis_video_tready),

    .locked       (axis_enable)
  );
  
endmodule
