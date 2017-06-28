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

This module is the output data formatter for the AXI4 Stream to Video Out bridge.
For SDR, the inputs are simply muxed to zero them out when not locked, 
and then registered on the output
Input and output is single data rate with syncs and data enable. 
The syncs are delayed to match the data. This module uses the video clock.
------------------------------------------------------------------------------
*/

`timescale 1ps/1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_axi4s_vid_out_v3_0_vid_out_formatter
#( 
// Parameter to support different bit widths in the future.
// Bit width is initially fixed at 8/8/8 
  
parameter  DATA_WIDTH = 24

 )
( 
// input interface
  input  wire                    video_out_clk, // video clock
  input  wire                    rst   ,        // video reset
  input  wire                    vid_ce,        // video clock enable
  input  wire  [DATA_WIDTH -1:0] odf_data  ,    // video data in from stream coupler
  input  wire                    odf_vsync ,    // inputs from video timing gen
  input  wire                    odf_hsync ,  
  input  wire                    odf_vblank,  
  input  wire                    odf_hblank, 
  input  wire                    odf_act_vid,
  input  wire                    odf_field_id, 
  input  wire                    locked    ,    // locked (output sync. achieved)
  input  wire                    fifo_rd_en,    // Read enable for the FIFO
// Output PHY interface
  output  wire                    video_de    ,  // video data enable
  output  wire                    video_vsync ,  // video vertical sync
  output  wire                    video_hsync ,  // video horizontal sync
  output  wire                    video_vblank,  // video vertical blank
  output  wire                    video_hblank,  // video horizontal blank
  output  wire                    video_field_id,// video field ID
  output  wire [DATA_WIDTH -1:0]  video_data     // video output data 
     
);
// Wire and register declarations
  // input, output, and delay registers-- Pass through - no resets reuired
  reg    [DATA_WIDTH -1:0]   in_data_mux;  // Output disabling mux
  reg                        in_de_mux;  
  reg                        in_vsync_mux;  
  reg                        in_hsync_mux;  
  reg                        in_vblank_mux;  
  reg                        in_hblank_mux; 
  reg                        in_field_id_mux; 
  reg                        first_full_frame = 0;  // activates at start of full frame after reset.
  reg                        odf_vblank_1 = 0;      // delayed vblank 
  reg                        vblank_rising = 0;     //detects rising edge of vblank 
  
  
// Logic Section

  // assign outputs
  assign video_data   = in_data_mux;
  assign video_vsync  = in_vsync_mux;
  assign video_hsync  = in_hsync_mux;
  assign video_vblank = in_vblank_mux;
  assign video_hblank = in_hblank_mux;
  assign video_de     = in_de_mux;
  assign video_field_id = in_field_id_mux;

  // detect rising edge of vblank
  always @ (posedge video_out_clk) begin
    if (vid_ce) begin
      odf_vblank_1      <= odf_vblank;
      vblank_rising <= odf_vblank && !odf_vblank_1;
    end
  end

  //detect start of full frame after reset and locked
  always @ (posedge video_out_clk)begin
    if (rst || !locked) begin
     first_full_frame <= 0;
    end
    else if (vblank_rising & vid_ce) begin
     first_full_frame <= 1;
   end 
  end	 
  
  //  Input Mux.  Zero outputs when not locked and not full frame
  always @ (posedge video_out_clk)begin
    if (!locked || rst || !first_full_frame) begin
      in_de_mux     <= 0;
      in_vsync_mux  <= 0;
      in_hsync_mux  <= 0;    
      in_vblank_mux <= 0;
      in_hblank_mux <= 0;
      in_field_id_mux <= 0;    
      in_data_mux   <= 0;
    end
    else if (vid_ce) begin
      in_de_mux     <= odf_act_vid;
      in_vsync_mux  <= odf_vsync;
      in_hsync_mux  <= odf_hsync;
      in_vblank_mux <= odf_vblank;
      in_hblank_mux <= odf_hblank;
	  in_field_id_mux <= odf_field_id;
      if (fifo_rd_en)
        in_data_mux  <= odf_data;
    end
  end

endmodule
