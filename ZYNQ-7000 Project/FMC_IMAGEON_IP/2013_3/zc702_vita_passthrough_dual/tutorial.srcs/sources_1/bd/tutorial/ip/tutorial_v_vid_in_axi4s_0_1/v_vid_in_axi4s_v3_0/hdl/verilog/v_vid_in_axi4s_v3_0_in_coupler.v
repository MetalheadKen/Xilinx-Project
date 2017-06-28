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

This module is the Stream Coupler for an input AXI4 Streaming bridge.
It instantiates the asychronous FIFO and corresponding read logic.
The write side is interfaced to the video bus input side and data is written 
by a simple write enable.  The read logic is designed to interface to 
AXI 4 stream.  Whenever the level is above the hysteresis level, the valid 
signal is asserted.  The FIFO is read whenever the ready hanshaking 
signal is asserted in response to the valid.  

A data valid control signal is used to hold all of the AXI4-Stream outputs 
at zero.  This is to prevent bogus data from propogating on the AXI4-Stream
bus.
------------------------------------------------------------------------------
*/

`timescale 1ps/1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_vid_in_axi4s_v3_0_in_coupler
#( 
// Parameter to support different bit widths in the future.
// Bit width is initially fixed at 8/8/8 
  
  parameter DATA_WIDTH = 24,
  parameter RAM_ADDR_BITS = 10,    // default depth = 1024
  parameter HYSTERESIS_LEVEL = 8

 )
( 
// FIFO input interface
  input  wire                   vid_in_clk,// video clock - Pos.
  input  wire                   rst       ,// reset
  input  wire                   vid_ce,      // video clock enable
  input  wire [DATA_WIDTH +2:0] wr_data,   // write data in (includes eol,sof)
  input  wire                   wr_en,     // FIFO write enable
  
// FIFO FLAGS, write domain
  output wire                   wr_error,  // FIFO write error (write when full)
  output wire                   rd_error,  // FIFO read error (read when empty)  
// Output interface
  input                         aclk,       // output clock
  input                         aclken,     // output clock enable
  output reg  [DATA_WIDTH +2:0] rd_data  ,  // video data (includes eol,sof)
  output reg                    valid   ,   // valid handshaking signal
  input wire                    ready,      // input handshaking signal
// Timing Locked flag
  input wire                    locked      // Timing detector locked
);

// Wire and register declarations
  wire                     rd_en;    // FIFO read enable 
  wire [RAM_ADDR_BITS-1:0] level_rd;      // FIFO level, read domain
  wire [DATA_WIDTH + 2:0]   fifo_dout; // FIFO data out (includes eol,sof)
 (*ASYNC_REG = "TRUE"*)reg locked_1 = 0; // syncchronizing register
 (*ASYNC_REG = "TRUE"*)reg locked_2 = 0; // syncchronizing register
  wire                     hysteresis_met; // flag = histeresis levevel is met
  wire                     fifo_full;
  wire                     fifo_empty;
  wire                     fifo_eol;
  wire                     good_sof;	  // SOF when locked and not reset
  reg                      first_sof_reg; // set by first sof received after rst and lock
  wire                     full_frame;	  // full-frames (i.e. starting at SOF) are being output         
   
// Instance Async FIFO
  v_vid_in_axi4s_v3_0_in_bridge_async_fifo_2 
  #(
    .RAM_WIDTH     (DATA_WIDTH + 3),
    .RAM_ADDR_BITS (RAM_ADDR_BITS)
  )
  in_bridge_async_fifo_2_i
  (
   .wr_clk	        (vid_in_clk),
   .rd_clk         (aclk),
   .rst            (rst   ),
   .wr_ce          (vid_ce),
   .rd_ce          (aclken),
   .wr_en          (wr_en ),
   .rd_en          (rd_en ),
   .din            (wr_data   ),

   .dout           (fifo_dout  ),
   .empty          (fifo_empty),
   .rd_error       (rd_error),
   .full           (fifo_full),
   .wr_error       (wr_error ),
   .level_rd       (level_rd    ),
   .level_wr       ()
  );
  
                 
// Logic Section

assign  fifo_eol = fifo_dout[DATA_WIDTH];
assign  hysteresis_met = (level_rd >= HYSTERESIS_LEVEL )|| fifo_full;
assign  rd_en =  full_frame? !(valid && !ready) && ( fifo_eol || !fifo_empty)
                           : hysteresis_met; 
assign  good_sof = locked_2 && fifo_dout[DATA_WIDTH + 1]&& !fifo_dout[DATA_WIDTH + 2] ;
assign  full_frame = good_sof || first_sof_reg;
 
  always @ (posedge aclk ) begin 
    if (rst || !locked_2)
	  first_sof_reg <= 0;
	else if (good_sof)
	  first_sof_reg <= 1;     
  end 
//                           
// FIFO read and handshaking logic
//                                
  always @ (posedge aclk ) begin 
	if(rst) begin
	  locked_1 <= 0;
	  locked_2 <= 0;
	  rd_data  <= 0;
      valid    <= 0;
    end
    else if (aclken) begin 
      locked_1 <= locked;
      locked_2 <= locked_1;

      if (full_frame) begin
        if (rd_en)
           rd_data <= fifo_dout;
        if ((rd_en && !rd_error) || (valid && !ready)) begin 
           valid <= 1;
        end
        else if (ready)begin
           valid <= 0;      // inhibit FIFO read when valid is negated.
        end
      end
      else begin                  //if not locked continue reading
        rd_data <= 0;             // but Force outputs low.
        valid <= 0;            
      end
    end
  end
   
endmodule
