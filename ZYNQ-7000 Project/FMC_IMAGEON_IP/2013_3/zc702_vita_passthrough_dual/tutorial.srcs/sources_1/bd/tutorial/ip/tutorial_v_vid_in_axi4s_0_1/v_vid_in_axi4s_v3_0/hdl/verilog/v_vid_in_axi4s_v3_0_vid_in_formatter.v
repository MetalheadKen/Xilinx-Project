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

This module is the data formatter for the Video to AXI4 Streaming bridge.
The input is the format of parallel data with syncs and data enable. 
The output in the format of a AXI4 Streaming with end of line (eol) and start
of field (sof) bits.  It also outputs a FIFO enable for the input FIFO.
------------------------------------------------------------------------------
*/

`timescale 1ps/1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_vid_in_axi4s_v3_0_vid_in_formatter
#( 
parameter  DATA_WIDTH = 24
 )
( 
// Video input interface
  input  wire                    vid_in_clk,  // video clock - Pos.
  input  wire                    rst   ,      // reset
  input  wire                    vid_ce,             // video clock enable
  input  wire                    vid_de    ,  // video data enable
  input  wire                    vid_vblank , // video vert. blank
  input  wire                    vid_hblank , // video horiz. blank
  input  wire                    vid_vsync ,  // video vert. sync
  input  wire                    vid_hsync ,  // video horiz. sync
  input  wire                    vid_field_id,// video field ID.  
  input  wire [DATA_WIDTH -1:0]  vid_data,    // video data 
  
// Video Timing Detector interface
  output wire                    vtd_active_video, // active video (DE)
  output wire                    vtd_vblank,       // vert. blank
  output wire                    vtd_hblank,       // horiz. blank
  output wire                    vtd_vsync,        // vert. sync
  output wire                    vtd_hsync,        // horiz. sync   
  output wire                    vtd_field_id,     // field ID  
  
// AXI4-streaming interface
  output wire  [DATA_WIDTH +2:0]  idf_data  ,  // video data. includes sof,eol
  output wire                     idf_de      // data enable out

);
// Wire and register declarations
  // input, output, and delay registers-- Pass through - no resets reuired
  reg                          de_1 = 0;         
  reg                      vblank_1 = 0;
  reg                      hblank_1 = 0;
  reg                       vsync_1 = 0;  
  reg                       hsync_1 = 0;
  reg  [DATA_WIDTH -1:0]     data_1 = 0;  
  reg                          de_2 = 0;  
  reg                v_blank_sync_2 = 0;  
  reg  [DATA_WIDTH -1:0]     data_2 = 0;  
  reg                          de_3 = 0;  // DE output register
  reg  [DATA_WIDTH -1:0]     data_3 = 0;  // data output register
  reg           vert_blanking_intvl = 0; // SR, reset by DE rising
  reg                    field_id_1 = 0;
  reg                    field_id_2 = 0;
  reg                    field_id_3 = 0;
  
  wire                     v_blank_sync_1;  // vblank or vsync
  wire                     de_rising;                   
  wire                     de_falling;      
  wire                     vsync_rising;
  reg                      sof;
  reg                      sof_1;
  reg                      eol;   
  
// Logic Section
  // output assignments
  assign idf_data = {field_id_3,sof_1,eol,data_3};
  assign idf_de   = de_3;
  assign vtd_active_video =      de_1;
  assign vtd_vblank       =  vblank_1;
  assign vtd_hblank       =  hblank_1;
  assign vtd_vsync        =   vsync_1;
  assign vtd_hsync        =   hsync_1;
  assign vtd_field_id     =   field_id_1;
  // edge detectors
  assign v_blank_sync_1 = vblank_1 || vsync_1;
  assign de_rising  = de_1  && !de_2;  
  assign de_falling = !de_1 && de_2;  
  assign vsync_rising = v_blank_sync_1 && !v_blank_sync_2;    

  // input, output, and delay registers
  always @ (posedge vid_in_clk) begin
    if (vid_ce) begin 
      de_1    <= vid_de;
      vblank_1<= vid_vblank;
      hblank_1<= vid_hblank;
      vsync_1 <= vid_vsync;
      hsync_1 <= vid_hsync;
      data_1  <= vid_data; 
      de_2    <= de_1;    
      v_blank_sync_2 <= v_blank_sync_1; 
      data_2  <= data_1;
      de_3    <= de_2;    
      data_3  <= data_2;
      eol     <= de_falling;
      sof     <= de_rising && vert_blanking_intvl;
      sof_1   <= sof;
	  field_id_1 <= vid_field_id;
	  field_id_2 <= field_id_1;
	  field_id_3 <= field_id_2;
    end      
  end 
  
  // Vertical back porch SR register
  always @ (posedge vid_in_clk) begin
	if (vid_ce) begin
      if (vsync_rising)   // falling edge of vsync
        vert_blanking_intvl <= 1;
      else if (de_rising)        // rising edge of data enable
        vert_blanking_intvl <= 0;
	end
  end
  
endmodule
