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

This module is the output data synchronizer for AXI4 Streaming 
output bridge.
The module takes stream coupler FIFO level and output flags (eol, sof),
and compares the flags with the state of control signals from the 
Video Timing Generator (VTG).  The timing from the Stream Coupler acts as the 
master, and the VTG acts as the slave.  This module outputs a clock_enable to
halt the VTG when required. 

The algorithm for locking is this:

1) VTG reaches start of frame (sof).  The FIFO sof is not present, 
so the VTG state machines wait for FIFO first pixel.  During this 
period, the FIFO is continuously read, but is not allowed to underflow.  
Therefore the FIFO is basically always empty, and data passes 
directly from the input to the output.

2) FIFO sof occurs.  VTG state machines start, the FIFO is reset, 
and the “initialize” flag is set.

3) When the initialize flag is set, reading of the FIFO is held off 
until a minimum FIFO level is met.  This is the hysteresis level, and 
insures that slight variances in read vs write timing will not cause 
an underflow.

4) Since reading of the FIFO has been delayed, the VTG will reach 
the end-of-line (eol) first.   The state machines of the TG are held
 until the FIFO eol is received.  At this point, the TG is in sync 
 with the output of the FIFO.  
During the initialization field, There may be some more pauses in 
reading the FIFO depending on the exact timing of the reads, writes 
and updating of the level.  Whenever this occurs, the TG state 
machines will pause at eol until the FIFO output catches up.

5) At the next sof, the TG will be synchronized with the FIFO 
output, so the “initialize” flag will be cleared.  

The input and output are synchronized to the sof level with a 
small FIFO delay cushion to absorb small timing variations.  
The FIFO will be read at the TG rate. It has a small cushion due 
to the hysteresis level so it will not underflow or overflow.
------------------------------------------------------------------------------
*/

`timescale 1ps/1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_axi4s_vid_out_v3_0_out_sync #( 
  
  parameter RAM_ADDR_BITS = 10,    // default depth = 1024
  parameter HYSTERESIS_LEVEL = 16,
  parameter VTG_MASTER_SLAVE = 0  //timing mode, 1= VTG master,0= VTG is slave
 )
( 
  input  wire                      video_out_clk, // video clock - Pos.
  input  wire                      rst   ,      // video reset
  input  wire                      vid_ce,      // video clock enable

// FIFO Interface 
  input  wire                      fifo_sof,    // start of frame from FIFO 
  input  wire                      fifo_eol,    // end of line from FIFO
  input  wire                      fifo_fid,    // field ID from FIFO
  input  wire [RAM_ADDR_BITS -1:0] fifo_level,  // FIFO Level
  input  wire                      empty,       // FIFO empty flag
  input  wire                      rd_error ,   // FIFO read error flag
  input  wire                      wr_error,    // FIFO write error flag
  output reg                       read_en,     // FIFO read enable control
  output reg                       fifo_rst,    // FIFO reset(synced at FIFO)
  
// VTG Interface
  input  wire                      vsync,  
  input  wire                      hsync,
  input  wire                      field_id,
  input  wire                      act_vid,
  output reg                       clock_en,
 
// Locked flag
  output reg                       locked 
);
// Wire and register declarations
  reg         [4:0]                state;
  reg         [4:0]                next_state;
  reg                              initialize;
  // inferred AXIS signals from VTG timing signals
  wire           vtg_de;    // inferred DE from VTG
  reg            vtg_sof_2; // inferred Start of Frame from VTG w/2 clk ltncy
  reg            vtg_eol_2; // inferred End of Line from VTG w/2 clk ltncy
  
  // input, output, and delay registers-- Pass through - no resets reuired
  reg                          de_1;  // DE input register               |
  reg                    field_id_1;  // field_id input register
  reg                       vsync_1;  // vsync input register
  reg                          de_2;  // DE output register
  reg                       vsync_2;  // vsync delay register
  reg                       vert_bp;  // SR, reset by DE rising
  reg                    fifo_eol_1;  // eol input register
  reg                    fifo_eol_2;  // eol delay register
  reg                    fifo_sof_1;  // sof input register
  reg                    fifo_sof_2;  // sof delay register
  reg                    fifo_fid_1;  // Field ID sample register
  
  wire                      de_rising;                   
  reg                       de_rising_1;                   
  wire                      de_falling;      
  wire                      vsync_falling;
  reg                       read_ok;     // allow FIFO reads
  reg                       force_read;  // force FIFO reads
  wire                      hysteresis_timeout;
  wire                      half_full;
  reg                       fifo_eol_2_rising;
  
  reg  [RAM_ADDR_BITS -1:0] hyster_count;   // Hysteresis counter
  reg                       count_reset;    // Hysteresis counter reset
  wire                      vid_data_invalid;  // vid data output is invalid
  reg                       pre_clock_en;   // state machine output to halt VTC gen.
  
  
// Logic Section
  assign vtg_de = act_vid;
  assign vid_data_invalid = rd_error;
  
  // edge detectors
  assign de_rising  = de_1  && !de_2;  
  assign de_falling = !vtg_de && de_1; // falling is 1 state earlier for eol
  assign vsync_falling = !vsync_1 && vsync_2;
  assign hysteresis_timeout = hyster_count >= HYSTERESIS_LEVEL;
  assign hysteresis_met = fifo_level >= HYSTERESIS_LEVEL;
  assign half_full = fifo_level[RAM_ADDR_BITS-1];       
  // input, output, and delay registers
  always @ (posedge video_out_clk) begin 
    if (vid_ce) begin
      de_1       <= vtg_de;
      vsync_1    <= vsync;
	  field_id_1 <= field_id;
      if (read_en) begin
        fifo_sof_1 <= fifo_sof;
        fifo_sof_2 <= fifo_sof_1 && !fifo_fid_1;
        fifo_eol_1 <= fifo_eol;
        fifo_eol_2 <= fifo_eol_1;
		fifo_fid_1 <= fifo_fid;
      end
      
      fifo_eol_2_rising <= read_en && fifo_eol_1 && !fifo_eol_2;
      de_2            <= de_1;    
      vsync_2         <= vsync_1; 
      vtg_eol_2       <= de_falling;
      vtg_sof_2       <= de_rising && vert_bp && !field_id_1;      
      de_rising_1     <= de_rising;
    end
  end 
  
  // Vertical back porch SR register
  always @ (posedge video_out_clk) begin
    if (vid_ce) begin
      if (vsync_falling)   // falling edge of vsync
        vert_bp <= 1;
      else if (de_rising)        // rising edge of data enable
        vert_bp <= 0;
    end
  end
  
  // FIFO read enable logic
  always @ (posedge video_out_clk) begin
    if (rst) begin
      read_en <= 0;
    end
    else begin
    if (vid_ce) begin
        if ((read_ok && vtg_de)                  // normal read
          ||(vid_data_invalid && fifo_level > 3) // bubble swallowing
          ||(force_read)       // state machine force read
           )
          read_en <= 1;
        else
          read_en <= 0;
      end
	end
  end
  // Clock Enable Logic.  This accounts for the video clock enable
  // for the Video Timimg Controller (generator).  Clock enables are
  // used for SD-SDI and 3G-SDI timing standards. The clock_en timing 
  // is delayed one clock from vid_ce.  This is OK because all of 
  // the timing paths involved are sinble-cycle paths.
  always @ (posedge video_out_clk) begin
    clock_en <= pre_clock_en && vid_ce;
  end

  // Hysteresis counter
  always @ (posedge video_out_clk) begin
    if (vid_ce) begin
      if (count_reset)
        hyster_count <= 0;
      else 
        hyster_count <= hyster_count + 1;
    end
  end

  // next state logic
  always @ * begin
    if (VTG_MASTER_SLAVE == 0) begin  //Slave mode
      if(rst)
        next_state = 0;
      else 
        case (state) 
          0:
            if (vtg_sof_2)
              next_state = 1;
            else
              next_state = 0;  
          1:
            if (fifo_sof_2)
              next_state = 2;
            else
              next_state = 1;   
          2:
            if (hysteresis_timeout)
              next_state = 3;
            else
              next_state = 2;
          3:
            if (vtg_sof_2 && !fifo_sof_2)
               next_state = 0;
            else if (vsync_falling)
              next_state = 8;
            else if (fifo_eol_2_rising & !vtg_eol_2 ) // FIFO leads
               next_state = 4;
            else if (vtg_eol_2 & !fifo_eol_2_rising ) // VTG leads
               next_state = 9;
            else
              next_state = 3;
           4:
             if (vtg_sof_2 && fifo_sof_2)
               next_state = 8;
             else if (vtg_sof_2)
               next_state = 0;
             else if (de_rising_1)
               next_state = 5;
             else
               next_state = 4; 
           5:
             if (vtg_sof_2)
               next_state = 0;
             else
               next_state = 3;
           6:
            if ((vtg_sof_2 && !fifo_sof_2)
             || (vtg_eol_2 && !fifo_eol_2_rising))       
              next_state = 0;
            else
              next_state = 6;
           8:
            if ((vtg_sof_2 && !fifo_sof_2)
             || (vtg_eol_2 && !fifo_eol_2_rising))       
              next_state = 0;
            else if (vtg_sof_2 && fifo_sof_2)
              next_state = 6;
            else
              next_state = 8;
            
           9:
             if (vtg_sof_2 && fifo_sof_2)
               next_state = 8;
             else if (vtg_sof_2) 
               next_state = 0;
             else if (fifo_eol_2_rising) 
               next_state = 10;
             else
               next_state = 9;
            10:
             if (vtg_sof_2 && !fifo_sof_2)
               next_state = 0;
             else
              next_state = 3;
           default:
              next_state = 0;
        endcase 
    end
    else    begin       //  Master Mode
      if(rst)
        next_state = 20;
      else 
        case (state) 
          20:
              next_state = 27;
          21:
            if (vtg_sof_2)
              next_state = 23;
            else
              next_state = 21;   
          23:
            if (vtg_sof_2 && !fifo_sof_2)
               next_state = 20;
            else if (vsync_falling)
              next_state = 28;
            else if (fifo_eol_2_rising & !vtg_eol_2 ) // FIFO leads
               next_state = 24;
            else if (vtg_eol_2 & !fifo_eol_2_rising ) // VTG leads
               next_state = 30;
            else
              next_state = 23;
           24:
             if (vtg_sof_2 && fifo_sof_2)
               next_state = 28;
             else if (vtg_sof_2)
               next_state = 20;
             else if (de_rising_1)
               next_state = 25;
             else
               next_state = 24; 
           25:
             if (vtg_sof_2)
               next_state = 20;
             else
               next_state = 23;
           26:
            if ((vtg_sof_2 && !fifo_sof_2)
             || (vtg_eol_2 && !fifo_eol_2_rising))       
              next_state = 20;
            else
              next_state = 26;
           27:    
            if (fifo_sof_2)
              next_state = 21;
            else
              next_state = 27;  
           28:
            if ((vtg_sof_2 && !fifo_sof_2)
             || (vtg_eol_2 && !fifo_eol_2_rising))       
              next_state = 20;
            else if (vtg_sof_2 && fifo_sof_2)
              next_state = 26;
            else
              next_state = 28;
            
           29:
             if (vtg_sof_2 && fifo_sof_2)
               next_state = 28;
             else if (vtg_sof_2) 
               next_state = 20;
             else if (fifo_eol_2_rising) 
               next_state = 23;
             else
               next_state = 29;
            30:
             if (vtg_sof_2 && !fifo_sof_2)
               next_state = 20;
             else
              next_state = 29;
           default:
              next_state = 20;
        endcase 
    end  
  end
  
//  Control Logic

  always @ (posedge video_out_clk) begin
    if (vid_ce) begin
      read_ok  <= 1;     // default values
      force_read <= 0;
      pre_clock_en <= 1;
      fifo_rst <= 0;
      initialize <= 0;
      locked    <= 0;
      count_reset <= 1;
      case (next_state)
                     // Free run uses defaults
        0: begin
           fifo_rst <= 1;
          end
        1:  begin
          pre_clock_en <= 0;
           force_read <= 1;
          initialize <= 1;
          end 
        2:  begin
          pre_clock_en <= 0;
          initialize <= 1;
          count_reset <= 0;
          end 
        3:  begin
          initialize <= 1;
          end 
        4:  begin
          initialize <= 1;
          end 
        5: begin
          initialize <= 1;
          read_ok <= 0;
           end
        6:  begin
          locked <= 1;
          end 
        8:  begin
          initialize <= 1;      
          end 
        9:  begin
          initialize <= 1;      
          end 
        10:  begin
          initialize <= 1; 
          pre_clock_en <= 0;     
          end 
        20: begin
           fifo_rst <= 1;
          end
        21:  begin
          read_ok <= 0;
          initialize <= 1;
          end 
        23:  begin
          initialize <= 1;
          end 
        24:  begin
          initialize <= 1;
          end 
        25: begin
          initialize <= 1;
          read_ok <= 0;
           end
        26:  begin
          locked <= 1;
          end
        27:  begin
          force_read <= 1;
          end 
        28:  begin
          initialize <= 1;      
          end 
        29:  begin
          initialize <= 1;      
          end 
        30:  begin
          initialize <= 1; 
           force_read <= 1;
          end 
        default:  
          locked <= 0;     
      endcase
	end
  end

  // state register
  always @ (posedge video_out_clk)
    if (vid_ce) begin
      state <= next_state;
	end


endmodule
