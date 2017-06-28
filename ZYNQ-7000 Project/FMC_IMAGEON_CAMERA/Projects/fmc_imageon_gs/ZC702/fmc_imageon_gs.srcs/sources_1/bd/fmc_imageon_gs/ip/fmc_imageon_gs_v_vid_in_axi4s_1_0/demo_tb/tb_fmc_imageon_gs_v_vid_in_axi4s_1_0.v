
/*
-- TESTBENCH_TEMPLATE_VERSION = 2.0
*/
// $Revision: 1.1.8.1 $ $Date: 2011/05/27 16:09:31 $
//-----------------------------------------------------------------------------
// (c) Copyright 2011 Xilinx, Inc. All rights reserved.
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
//----------------------------------------------------------
/*
Module Description:

This is the testbench for the video input to AXI4 Streaming bridge core. 
Tests the functionality of the core using several line standards.

*/

`timescale 1ns / 1ps

//
// Global type definitions
//

//
// This is the test bench top module.
//
module tb_fmc_imageon_gs_v_vid_in_axi4s_1_0;


parameter VDATA_WIDTH = 16;
parameter TDATA_WIDTH = 16;
parameter ACW = 8;
parameter NCW = 8;
parameter DLY = 1 ; // Delay to account for global clock routing in post-PAR timing sim
parameter NUM_TESTS = 5;  // The number of line standards to run
parameter INTERLACE = 0;  // Produce interlaced line standards or not 1= interlace
parameter VID_HALFPERIOD  = 3.03;
parameter AXIS_HALFPERIOD = 2.83;

reg                 vid_clk = 0;
reg                 aclk = 0   ;
wire                rst;
wire                ce = 1;
wire                hsync;
wire                vsync;
wire                de;
wire                vtd_locked;
wire                fifo_level;
wire [13:0]        	active_pixels ;
wire [13:0]        	total_pixels  ;	
wire [13:0]        	hsync_start	  ;
wire [13:0]        	hsync_end	  ;
wire [13:0]			active_lines  ;
wire [13:0]			total_lines	  ;
wire [13:0]			vsync_start	  ;
wire [13:0]			vsync_end	  ;

wire [VDATA_WIDTH-1:0]      video_data    ;
wire [TDATA_WIDTH-1:0]      axis_video    ;
wire                axis_tvalid   ;
wire                axis_tready   ;
wire                axis_eol      ;
wire                axis_sof      ;
wire                overflow;
wire                underflow;
wire                error;
wire                frame_complete;
wire                aclken =     1;
wire                aresetn;
reg                 vid_ce  =    1;
reg      [3:0]      clk_count  = 0;
wire                field_id ;
wire                fid;

// clock generators
  initial forever #VID_HALFPERIOD  vid_clk = ~vid_clk;
  initial forever #AXIS_HALFPERIOD aclk = ~aclk;

// clock enable generator
always @ (posedge vid_clk) begin
  if (clk_count >= 2) begin
    clk_count <= 0;
	vid_ce <= 1;
  end
  else begin
    clk_count	<= clk_count + 1;
    vid_ce    <= 0;
  end
end

//
// This module generates the video timing based on the parameters specified
// by the test program.
// 
timing_gen #(
  .DLY                    (DLY),
  .INTERLACE              (INTERLACE),
  .DATA_WIDTH             (VDATA_WIDTH)      
  )
timing_gen_i	(
  .clk			  (vid_clk),
  .rst			  (rst),
  .ce			  (vid_ce),
  .active_lines	  (active_lines	),
  .total_lines	  (total_lines	),
  .vsync_start	  (vsync_start	),
  .vsync_end	  (vsync_end	),
  .active_pixels  (active_pixels),
  .total_pixels	  (total_pixels	),
  .hsync_start	  (hsync_start	),
  .hsync_end	  (hsync_end	),

  .hsync		  (hsync		),
  .vsync		  (vsync		),
  .hblank		  (hblank   	),
  .vblank		  (vblank		),
  .de			  (de			),
  .field_id       (field_id     ),
  .video_data	  (video_data	)
);
  
//------------------------------------------------------------------------------
// Top level DVI in bridge -- DUT
//
fmc_imageon_gs_v_vid_in_axi4s_1_0
dut	(
  .vid_io_in_clk     (vid_clk),
  .vid_io_in_reset   (rst),
  .vid_io_in_ce       (vid_ce),
  .vid_active_video   (de),
  .vid_vblank		  (vblank) ,
  .vid_hblank		  (hblank),
  .vid_vsync          (vsync),
  .vid_hsync          (hsync),
  .vid_field_id       (field_id),
  .vid_data           (video_data),

  .aclk               (aclk),
  .aclken             (aclken ),
  .aresetn            (aresetn),
  .m_axis_video_tdata (axis_video),
  .m_axis_video_tvalid (axis_tvalid),
  .m_axis_video_tready (axis_tready),
  .m_axis_video_tuser  (axis_sof),
  .m_axis_video_tlast  (axis_eol),
  .fid                (fid),

  .vtd_active_video	   (),
  .vtd_vblank     	   (),
  .vtd_hblank     	   (),
  .vtd_vsync      	   (),
  .vtd_hsync 		   (),
  .vtd_field_id            (),
       
  .overflow                (overflow),
  .underflow               (underflow),

  .axis_enable		  (vtd_locked)
);

// 
// Test program : This program controls the operation of the test bench.
//
test_vid_in #(
  .DLY                (DLY),
  .NUM_TESTS          (NUM_TESTS)
  )
test_vid_in_i (
  .clk				 (vid_clk),
  .aclk                          (aclk),
  .error			 (error),
  .frame_complete	 (frame_complete),

  .rst				 (rst),
  .aresetn                       (aresetn),
  .vtd_locked		 (vtd_locked),
  .total_lines		 (total_lines),
  .active_lines		 (active_lines),
  .vsync_start		 (vsync_start	),
  .vsync_end		 (vsync_end	),
  .total_pixels		 (total_pixels	),
  .active_pixels	 (active_pixels),
  .hsync_start		 (hsync_start	),
  .hsync_end		 (hsync_end	)
);

axis_emulation #(
  .DLY                (DLY),
  .DATA_WIDTH         (TDATA_WIDTH)
  )
axis_emulation_i (
  .aclk				 (aclk),
  .rst				 (rst),
  .axis_tready		 (axis_tready),
  .axis_tvalid		 (axis_tvalid),
  .axis_tdata_video	 (axis_video),
  .axis_tlast		 (axis_eol),
  .axis_tuser_sof	 (axis_sof),
  .fid               (fid),
  .total_lines		 (total_lines),
  .error_out		 (error),
  .frame_complete 	 (frame_complete)
);

endmodule
//------------------------------------------------------------------------------
// This is the main test program that runs the simulation
//
module test_vid_in #(
  parameter DLY = 1,
  parameter NUM_TESTS = 1
 )
 (
    input   wire        clk,
    input   wire        aclk,
    input   wire        error,
    input   wire        frame_complete,
    output  reg         rst,
    output  reg         aresetn,
    output  reg         vtd_locked,
    output  reg [13:0]  total_lines,
    output  reg [13:0]  active_lines,
    output  reg [13:0]  vsync_start,
    output  reg [13:0]  vsync_end,
    output  reg [13:0]  total_pixels,
    output  reg [13:0]  active_pixels,
    output  reg [13:0]  hsync_start,
    output  reg [13:0]  hsync_end
 );

integer i;

reg [11:0] h_size   = 103;
reg [11:0] v_size   = 81;
reg [9:0]  h_blank  = 15;
reg [9:0]  v_blank  = 8;
reg [9:0]  h_sync   = 8;
reg	[9:0]  v_sync   = 3;
reg [9:0]  h_fp     = 3;
reg	[9:0]  v_fp     = 2;

///line_std_param params;
///initial params = new();

// Task to test one line standard

  task  test_a_line_std;
    input [11:0]       h_size;
    input [11:0]       v_size; 
  begin
    $display("Frame Size is %d x %d ", h_size, v_size);
    // Hold reset for several cycles,  later, assert locked signal
    @(posedge clk);
    rst <= 1;
    vtd_locked <= 0;

    @(posedge aclk);
    aresetn <= 0;

    repeat (10) @(posedge aclk);
    aresetn <= # DLY 1;

    repeat (10) @(posedge clk);
    rst <= # DLY 0;

    repeat (100) @(posedge clk);
    vtd_locked <= # DLY 1;
    
    wait (frame_complete);
    $display("frame_complete");
  end
  endtask
//
// Stimulus loop
//
// Calls test_a_line_std task for a	certain number of line standards
//
  initial begin

    for (i = 0; i< NUM_TESTS; i= i+1) begin
///	  assert(params.randomize());
	  total_lines   = v_size + v_blank;
	  active_lines  = v_size;
	  vsync_start   = v_size + v_fp -1;
	  vsync_end     = vsync_start  + v_sync;
	  total_pixels  = h_size + h_blank;
	  active_pixels = h_size;
	  hsync_start   = h_size + h_fp -1;
	  hsync_end     = hsync_start  + h_sync;

      test_a_line_std (	 
        h_size,
        v_size	    
      );
	  h_size= h_size + 33;
	  v_size = v_size + 27;
	  h_blank = h_blank + 5;
	end
    $display("Test passed after testing %0d video formats.", NUM_TESTS);
    $display("\n******************************************");
    $display   ("**  Test completed successfully        **");
    $display   ("**  Simulation finished successfully   **");
    $display   ("*****************************************\n");
    
    $stop;
//  	$finish;

  end

endmodule


//****************************************************************************
//------------------------------------------------------------------------------
// This module simulates the generation of the video timing signals. It
// generates the hsync and vsync and blank timing signals. 
//
module timing_gen #(
  parameter DLY = 1,
  parameter INTERLACE = 0,
  parameter DATA_WIDTH = 24
 )
(
    input   wire        clk,
    input   wire        rst,
    input   wire        ce,
    input   wire [13:0]  active_lines,
    input   wire [13:0]  total_lines,
    input   wire [13:0]  vsync_start,
    input   wire [13:0]  vsync_end,
    input   wire [13:0]  active_pixels,
    input   wire [13:0]  total_pixels,
    input   wire [13:0]  hsync_start,
    input   wire [13:0]  hsync_end,
    output  wire        hsync,
    output  wire        vsync,
    output  wire        hblank,
    output  wire        vblank,
	output  wire        de,
	output  reg        field_id,
    output  wire [DATA_WIDTH-1:0]  video_data
 );

parameter ACW = 8;
parameter NCW = 8;

// variable declarations

reg [13:0]   pixel_count;
reg [13:0]    line_count;
integer     frame_count;

//
// pixel counter
//
// Cleared to 0 on reset. Rolls over when it reaches total_pixels-1. Otherwise
// increments every clock cycle.
//  
always @ (posedge clk)
    if (ce)
    begin
        if (rst)
            # DLY pixel_count <= 0;
        else
        begin
            if (pixel_count == total_pixels-1)
                # DLY pixel_count <= 0;
            else
                # DLY pixel_count <= pixel_count + 1;
        end
    end
//
// Line counter
//
// Set to line 0 on reset. Increments coincident with pixel 0.
//
always @ (posedge clk)
    if (ce)
    begin
        if (rst)  begin
            line_count <= # DLY 0;
            frame_count <= # DLY 0;
			 field_id    <= # DLY 0;
	    end
        else if (frame_count >= 7)
            begin
                $display ("Frame counter timed out. Test error.");
                $display("*******************************");
                $display("** ERROR. TEST FAILED  !!!");
                $display("*******************************");
                $stop;
            end
        else if (pixel_count == total_pixels - 1)
		  if (line_count == total_lines - 1) begin
		    line_count <= 0;
			frame_count <= frame_count +1;
			if (INTERLACE)
			  field_id <= ~field_id;
			else
			  field_id <= 0;
		  end
          else
            line_count <= # DLY line_count + 1;
    end

//
// Generate the hasync, vsync and data enable timing signals at the appropriate place on each line
// by examining the pixel counter.
//
assign hsync = pixel_count >= hsync_start && pixel_count <= hsync_end; 
assign vsync = line_count >= vsync_start && line_count <= vsync_end;
assign hblank = !(pixel_count <= (active_pixels-1));
assign vblank =  !(line_count <= (active_lines -1));
assign de =    line_count <= (active_lines -1) && pixel_count <= (active_pixels - 1);

// Generate the video outputs.  The video is generated procedurally
// according to the line and pixel number.  This makes it so the checking
// side can reconstruct the expected data by the same procedure.

     assign video_data = {pixel_count[8-1:0]};

endmodule
//

//****************************************************************************
//------------------------------------------------------------------------------
// This module simulates the AXI-4 streaming interface to the video bridge
// it generates handshaking, and regenerates the x,y  pixel location based on eol and 
// sof.  From the pixel location, it creates an expected data value and compares
// this to the incoming video data.
//
module axis_emulation #(
  parameter DLY = 1,
  parameter DATA_WIDTH = 24
 )
(
    input   wire        aclk,
    input   wire        rst,
    output  wire        axis_tready,
    input   wire        axis_tvalid,
    input   wire [DATA_WIDTH-1:0] axis_tdata_video,
	input   wire        axis_tlast,
	input   wire        axis_tuser_sof,
	input   wire        fid,
    input   wire [13:0] total_lines,
	output  reg         error_out,
	output  reg         frame_complete
 );

parameter ACW = 8;
parameter NCW = 8;

// variable declarations

reg [13:0]   pixel_count;
reg[13:0]   line_count;
reg [DATA_WIDTH-1:0]  tdata_video_1;
wire [DATA_WIDTH-1:0] expected_video_data;
reg         eol_1 = 0;
wire        sof ;
reg         count_valid = 0;
reg [10:0]  cycle_counter;
wire        data_valid;
wire        compare_is_valid;

assign axis_tready =  (cycle_counter[3:1] != 0); //Disable ready occasionally
assign sof = axis_tuser_sof;
assign data_valid = axis_tvalid && axis_tready;

// Delay data and eol to match with pixel and line numbers
always @ (posedge aclk)	begin
  if (data_valid) begin
    tdata_video_1 <= axis_tdata_video;
	eol_1         <= axis_tlast;
  end
end
//
// cycle counter
always @ (posedge aclk) begin
  if (rst)
    cycle_counter <= 0;
  else
    cycle_counter <= cycle_counter + 1;
end


// pixel counter
//
// Cleared to 0 on reset and eol. Rolls over when it reaches total_pixels-1. Otherwise
// increments every clock cycle.
//  
always @ (posedge aclk) begin
    if (rst || eol_1 || sof)
        pixel_count <= 0;
    else if (data_valid)
        pixel_count <= pixel_count + 1;    
end
//
// Line counter
//
// Set to line 0 on reset or sof. Increments coincident with pixel 0.
//
always @ (posedge aclk) begin
    if (rst )begin
      line_count <=  0;
   	  count_valid <=  0;
   	  frame_complete <= 0;
    end
    if (data_valid)    begin
        if (sof ) begin		  // count is valid after 1st sof
          line_count <=  0;
			   count_valid <=  1;
			// if count_valid is already asserted and fid=0, the frame is complete
			if (count_valid && !fid)		  
			  frame_complete <= 1;
	    end
        else if (&line_count)
            begin
                $display ("Line counter reached maximum value. Test error.");
                $display("*******************************");
                $display("** ERROR. TEST FAILED  !!!");
                $display("*******************************");
                $stop;
//  				$finish;
            end
        else if (eol_1)
            line_count <=  line_count + 1;
    end
end

// Generate the video outputs.  The video is gengerated procedurally
// according to the line and pixel number.  This makes it so the checking
// side can reconstruct the expected data by the same procedure.

  assign expected_video_data = {pixel_count[8-1:0]};

assign compare_is_valid = data_valid && count_valid & !frame_complete;

always @ (posedge aclk) begin
   error_out <= 0;
   if (compare_is_valid) begin
	  # DLY if (tdata_video_1 != expected_video_data) begin
        $display ("Data Mismatch. Expected: %h, received: %h. Test error.",
           expected_video_data, tdata_video_1);
		error_out <= 1;
          $display("*******************************");
          $display("** ERROR. TEST FAILED  !!!");
          $display("*******************************");
	     $stop;
//  		$finish;
	  end
	end
end

endmodule

//****************************************************************************

