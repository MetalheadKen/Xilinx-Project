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

This module is the Stream Coupler for an output AXI4 Streaming bridge.
It instantiates the asychronous FIFO and corresponding write logic.
The read side is interfaced to the video bus output side and data is read 
by a simple read enable.  The write logic is designed to interface to 
AXI 4 stream.  A guardband  is used when the FIFO is almost full to 
disable the ready signal so that the FIFO cannot be overfilled. 
Whenever the FIFO is not full and the valid 
signal is asserted the FIFO is written.    

------------------------------------------------------------------------------
*/

`timescale 1ps/1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_axi4s_vid_out_v3_0_out_coupler
#( 
// Parameter to support different bit widths in the future.
// Bit width is initially fixed at 8/8/8  
  parameter DATA_WIDTH = 24,
  parameter RAM_ADDR_BITS = 10,    // default depth = 1024
  parameter FILL_GUARDBAND = 2
 )
( 
  input  wire                      video_out_clk,  // video clock - Pos.
  input  wire                      rst        ,  // reset
  input  wire                      vid_ce,       // video clock enable
  input  wire                      fifo_rst,     // FIFO specific reset
// Input interface
  input                            aclk,         // output clock
  input                            aclken,       // output clock enable
  input                            aresetn,      // axi reset, active low
  input  wire  [DATA_WIDTH +2:0]   wr_data  ,    // video data (includes eol,sof.fid)
  input                            valid   ,     // valid handshaking signal
  output  reg                      ready,        // input handshaking signal
// FIFO output interface  
  output wire [DATA_WIDTH -1:0]    rd_data,      // read data out
  output wire                      eol,          // end of line FIFO output
  output wire                      sof,          // start of frame FIFO output
  output wire                      fid,          // field ID FIFO output
  input  wire                      rd_en,        // FIFO read enable
  output wire [RAM_ADDR_BITS -1:0] level_wr,     // FIFO fill level write domain
  output wire [RAM_ADDR_BITS -1:0] level_rd,     // FIFO fill level read domain
  
// FIFO FLAGS, 
  output wire                      wr_error,   // FIFO flag, write error
  output wire                      rd_error  ,  // FIFO flag, read error
  output wire                      empty,  
// Timing Locked flag
  input wire                       locked        // Timing detector locked
);

// Wire and register declarations
  reg   [DATA_WIDTH +2:0]  fifo_wr_data;  // FIFO data in delayed to match wr_en
  wire  [DATA_WIDTH +2:0]  fifo_dout;      // FIFO data out (includes eol,sof,fid)
  reg                      locked_1;       // syncchronizing register
  reg                      locked_2;       // syncchronizing register
  wire                     hysteresis_met; // flag = histeresis levevel is met
  wire                     full;           // FIFO full flag
  reg                      wr_en;          // FIFO write enable
  wire                     reset;
  wire [RAM_ADDR_BITS-1:0] remaining;      // # of FIFO locations left (+1)
  wire                     ready_comb;     // combinatorial version of ready
  
  assign reset = rst || !aresetn || fifo_rst;
  
// Instance Async FIFO
  v_axi4s_vid_out_v3_0_bridge_async_fifo_2 
  #(
    .RAM_WIDTH     (DATA_WIDTH + 3),
    .RAM_ADDR_BITS (RAM_ADDR_BITS)
  )
  bridge_async_fifo_2_i
  (
   .wr_clk	        (aclk),
   .rd_clk         (video_out_clk),
   .rst            (reset),
   .wr_ce          (aclken ),
   .rd_ce          (vid_ce ),
   .wr_en          (wr_en ),
   .rd_en          (rd_en ),
   .din            (fifo_wr_data   ),

   .dout           (fifo_dout  ),
   .empty          (empty),
   .rd_error       (rd_error),
   .full           (full        ),
   .wr_error       (wr_error),
   .level_rd       (level_rd),
   .level_wr       (level_wr)
  );
  
                 
// Logic Section

assign rd_data = fifo_dout[DATA_WIDTH-1:0];
assign eol     = fifo_dout[DATA_WIDTH];
assign sof     = fifo_dout[DATA_WIDTH+1];
assign fid     = fifo_dout[DATA_WIDTH+2];

assign remaining = ~level_wr;
assign ready_comb = !(full || (remaining <= FILL_GUARDBAND));

//
// Write enable and ready logic
//
  always @ (posedge aclk ) begin 
    if (rst) begin
	  ready <= 0;
	  wr_en <= 0;
	  fifo_wr_data <= 0;
	end
	else begin
        // exert backpressure when the FIFO is almost full
        ready   <= ready_comb;
      if (aclken) begin
        wr_en <= valid && ready;
        fifo_wr_data<= wr_data;
      end
    end  
  end
   
endmodule
