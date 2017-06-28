
/*
-- TESTBENCH_TEMPLATE_VERSION = 2.0
*/
// $Revision: 1.1.8.1 $ $Date: 2012/07/23 16:09:31 $
//-----------------------------------------------------------------------------
// (c) Copyright 2012 Xilinx, Inc. All rights reserved.
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

This is the testbench for the Video Output bridge core. Test the 
functionality of the core using several line standards.

*/

`timescale 1ns / 1ps

//
// This is the test bench top module.
//
module tb_fmc_imageon_gs_v_axi4s_vid_out_0_0;

parameter VDATA_WIDTH = 16;
parameter TDATA_WIDTH = 16;
parameter ACW = 8;
parameter NCW = 8;
parameter DLY = 1 ; // Delay to account for global clock routing in post-PAR timing sim
parameter NUM_TESTS = 3;  // The number of line standards to run
parameter INTERLACE = 0;  // Produce interlaced line standards or not 1= interlace
parameter VID_HALFPERIOD  = 3.33;	   // nom 3.03
parameter AXIS_HALFPERIOD =	3.03;	   // nom 3.33

reg                 video_clk = 0;
reg                 aclk = 0     ;
wire                rst;
wire                ce;
wire                de;
wire                vtg_locked;
wire [13:0]         active_pixels ;
wire [13:0]         total_pixels  ;	
wire [13:0]         hsync_start	  ;
wire [13:0]         hsync_end	  ;
wire [13:0] 		active_lines  ;
wire [13:0] 		total_lines	  ;
wire [13:0] 		vsync_start	  ;
wire [13:0] 		vsync_end	  ;

wire [VDATA_WIDTH-1:0]         video_data    ;
wire [TDATA_WIDTH-1:0]         axis_video    ;
wire                axis_tvalid   ;
wire                axis_tready   ;
wire                axis_eol      ;
wire                axis_sof      ;
wire                overflow;
wire                underflow;
wire [31:0]         status;
wire                error;
wire                frame_complete;
wire                aclken =     1;
wire                aresetn;
wire                vsync; 
wire                hsync; 
wire                vblank;
wire                hblank;
wire 				vtg_vsync;  
wire 				vtg_hsync;	
wire 				vtg_vblank;	
wire 				vtg_hblank;	
wire 				vtg_act_vid;
wire                fid;
wire                vid_field_id;
wire	            vtg_field_id;
reg                 vid_ce = 1;
reg   [3:0]         clk_count = 0;



//  clock generators 
//
  initial forever #VID_HALFPERIOD  video_clk = ~video_clk;
  initial forever #AXIS_HALFPERIOD aclk = ~aclk;

  assign ce = 1;

// clock enable generator
always @ (posedge video_clk) begin
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
axis_gen #(
  .DLY                (DLY),
  .INTERLACE          (INTERLACE),
  .DATA_WIDTH         (TDATA_WIDTH)
)
axis_gen_i (
  .aclk				  (aclk ),
  .rst				  (rst	),
  .axis_tready		  (axis_tready ),
  .axis_tvalid		  (axis_tvalid),
  .axis_tdata_video	  (axis_video),
  .axis_tlast		  (axis_eol   ),
  .axis_tuser_sof	  (axis_sof   ),
  .fid                (fid),
  .active_pixels	  (active_pixels),
  .active_lines		  (active_lines )
);


timing_gen #(
  .DLY                (DLY),
  .INTERLACE          (INTERLACE),
  .DATA_WIDTH         (VDATA_WIDTH)
  )
timing_gen_i	(
  .clk			  (video_clk),
  .rst			  (rst),
  .ce			  (ce),
  .active_lines	  (active_lines	),
  .total_lines	  (total_lines	),
  .vsync_start	  (vsync_start	),
  .vsync_end	  (vsync_end	),
  .active_pixels  (active_pixels),
  .total_pixels	  (total_pixels	),
  .hsync_start	  (hsync_start	),
  .hsync_end	  (hsync_end	),

  .hsync		  (vtg_hsync		),
  .vsync		  (vtg_vsync		),
  .hblank         (vtg_hblank       ),
  .vblank         (vtg_vblank       ),
  .de			  (vtg_act_vid		),
  .field_id       (vtg_field_id     ),
  .video_data	  ()
);
     
//------------------------------------------------------------------------------
// Top level Video output bridge -- DUT
//
fmc_imageon_gs_v_axi4s_vid_out_0_0
dut	(
  .aclk               (aclk),
  .aclken             (aclken ),
  .aresetn            (aresetn),
  .s_axis_video_tdata (axis_video ),
  .s_axis_video_tvalid (axis_tvalid),
  .s_axis_video_tready (axis_tready),
  .s_axis_video_tuser  (axis_sof   ),
  .s_axis_video_tlast  (axis_eol   ),
  .fid                 (fid),

  .vid_io_out_clk     (video_clk),
  .vid_io_out_reset   (rst),
  .vid_io_out_ce      (vid_ce),
  .vid_active_video   (de),
  .vid_vsync          (vsync),
  .vid_hsync          (hsync),
  .vid_vblank 	      (hblank),
  .vid_hblank 	      (vblank),
  .vid_field_id       (vid_field_id),
  .vid_data           (video_data),

  .vtg_vsync  		  (vtg_vsync ),
  .vtg_hsync		  (vtg_hsync ),
  .vtg_vblank		  (vtg_vblank),
  .vtg_hblank		  (vtg_hblank),
  .vtg_active_video       (vtg_act_vid),
  .vtg_field_id       (vtg_field_id),
  .vtg_ce			  (ce),

  .locked    		  (vtg_locked),	      
  .overflow               (overflow),       
  .underflow              (underflow),
  .status                 (status)	   
);

// 
// Test program : This program controls the operation of the test bench.
//
test_vid_out #(
  .DLY                (DLY),
  .NUM_TESTS          (NUM_TESTS)
  )
test_vid_out_i (
  .clk				 (video_clk),
  .aclk                          (aclk),
  .error			 (error),
  .frame_complete	 (frame_complete),
  .rst				 (rst),
  .aresetn                       (aresetn),
  .total_lines		 (total_lines),
  .active_lines		 (active_lines),
  .vsync_start		 (vsync_start ),
  .vsync_end		 (vsync_end	  ),
  .total_pixels		 (total_pixels ),
  .active_pixels	 (active_pixels),
  .hsync_start		 (hsync_start	),
  .hsync_end		 (hsync_end	 )
);

phy_emulation #(
  .DLY                (DLY),
  .INTERLACE          (INTERLACE),
  .DATA_WIDTH         (VDATA_WIDTH)
  )
phy_emulation_i (
  .clk               (video_clk),
  .rst               (rst),
  .vid_ce            (vid_ce),
  .hsync             (hsync),
  .vsync             (vsync),
  .de                (de),
  .vid_field_id      (vid_field_id),
  .video_data        (video_data),
  .error_out		 (error),
  .frame_complete 	 (frame_complete)
);

endmodule
//****************************************************************************
//------------------------------------------------------------------------------
// This module simulates the AXI-4 streaming interface to the video bridge
// it generates handshaking, and regenerates the x,y  pixel location based on eol and 
// sof.  
//

module axis_gen #(
  parameter DLY = 1,
  parameter INTERLACE = 0,
  parameter DATA_WIDTH = 24
 )
(
    input   wire        aclk,
    input   wire        rst,
    input   wire        axis_tready,
    output  wire        axis_tvalid,
    output  reg  [DATA_WIDTH-1:0] axis_tdata_video,
    output  reg         axis_tlast,
    output  reg         fid,
    output  reg         axis_tuser_sof,
    input   wire [13:0] active_pixels,
    input   wire [13:0] active_lines
 );

parameter ACW = 8;
parameter NCW = 8;

// variable declarations
reg [13:0]  pixel_count = 0;
reg [13:0]  line_count = 0;
wire        eol;
wire        sof;        
reg         eol_1;
wire        set_axis_tvalid;
real        duty_cycle_phase_accum;

assign eol = pixel_count == active_pixels - 1;
assign sof = line_count == 0 && pixel_count == 0;
assign axis_tvalid = 1;


// delay eol
always @ (posedge aclk) 
  eol_1 <= eol;

//
// pixel counter
//
// Cleared to 0 on reset and at active pixels - 1.  Otherwise
// increments every clock cycle.
//  
always @ (posedge aclk) begin
    if (axis_tready & axis_tvalid)
    begin
        if (rst || eol)
             pixel_count <= 0;
        else
             pixel_count <= pixel_count + 1;
    end
end
//
// Line counter
//
// Set to line 0 on reset or max lines. Increments coincident with pixel 0.
//
always @ (posedge aclk)
    if (axis_tready)
    begin
        if (rst || ((line_count >= active_lines - 1) && eol) )begin
            line_count <=  0;
	    end
        else if (eol)
            line_count <=  line_count + 1;
    end


// Generate the video outputs.  The video is gengerated procedurally
// according to the line and pixel number.  This makes it so the checking
// side can reconstruct the expected data by the same procedure.

always @ (posedge aclk)	 begin
  if (rst) begin
    axis_tlast     <= 0;
    axis_tuser_sof <= 0;
    if (INTERLACE)
      fid <= 1;
    else 
      fid <= 0;
  end
  else if (axis_tready) begin
    axis_tdata_video <= INTERLACE && ((!fid && sof) || (fid && !sof))? {~pixel_count[8-1:0]} : {pixel_count[8-1:0]};

    axis_tlast <= eol;
    axis_tuser_sof <= sof;
    // set field ID bit
    if (INTERLACE) begin
      if (sof)
        fid <= ~fid;	    
    end else begin
      fid <= 0;	  // always field 0 if not interlaced
    end
  end
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
	output  reg       field_id = 0,
	output  wire        de,
    output  wire [DATA_WIDTH-1:0]  video_data
 );


// variable declarations

reg [13:0]   pixel_count = 0;
reg [13:0]    line_count = 0;
reg [8:0]     frame_count = 0;

//
// pixel counter
//
// Cleared to 0 on reset. Rolls over when it reaches total_pixels-1. Otherwise
// increments every clock cycle.
//  
always @ (posedge clk) begin
    if (rst)
          # DLY pixel_count <= 0;
     else if (ce) begin
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
always @ (posedge clk) begin
    if (rst)  begin
          line_count <= # DLY 0;
          frame_count <= # DLY 0;
  	  field_id    <= # DLY 0;
    end
    else if (ce) begin
        if (frame_count >= 13)
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
			  field_id <= 0;   // for non interlace, always field 0
		  end
          else
            line_count <= # DLY line_count + 1;
    end
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

assign video_data = {line_count , pixel_count[11:0]};

endmodule

//****************************************************************************
//------------------------------------------------------------------------------
// This is the main test program that runs the simulation
//

module test_vid_out #(
  parameter DLY = 1,
  parameter NUM_TESTS = 2
 )
 (
    input   wire        clk,
    input   wire        aclk,
    input   wire        error,
    input   wire        frame_complete,
    output  reg         rst,
    output  reg         aresetn,
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

// Task to test one line standard

  task  test_a_line_std;
    input [11:0]       h_size;
    input [11:0]       v_size; 
    begin

     $display("Frame Size is %d x %d ", h_size, v_size);
    // Hold reset for several cycles, 
    @(posedge clk);
    rst <= 1;

    @(posedge aclk);
    aresetn <= 0;

    repeat (10) @(posedge clk);
    rst <= # DLY 0;

    repeat (10) @(posedge aclk);
    aresetn <= # DLY 1;

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
	  total_lines   = v_size + v_blank;
	  active_lines  = v_size;
	  vsync_start   = v_size + v_fp -1;
	  vsync_end     = vsync_start  + v_sync;
	  total_pixels  = h_size + h_blank;
	  active_pixels = h_size;
	  hsync_start   = h_size + h_fp -1;
	  hsync_end     = hsync_start  + h_sync;
      $display("Format # %0d", i);
	  
      test_a_line_std (	 
        h_size,
        v_size    
      );
	  h_size= h_size +33;
	  v_size = v_size + 27;
	end
    $display("Test passed after testing %0d video formats.", NUM_TESTS);
                $display("***************************************");
                $display("** Test completed successfully       **");
                $display("** Simulation finished successfully  **");
                $display("***************************************");

    $stop;
  end

endmodule

//****************************************************************************
//------------------------------------------------------------------------------
// This module simulates the PHY interface from the video bridge
// it regenerates the x,y  pixel location based on syncs and blanks.  
// From the pixel location, it creates an expected data value and compares
// this to the incoming video data.
//

`timescale 1ns / 1ps

module phy_emulation #(
  parameter DLY = 1,
  parameter INTERLACE = 0,
  parameter DATA_WIDTH = 24
 )
(
    input   wire        clk,
    input   wire        rst,
    input   wire        vid_ce,
    input   wire        hsync,
    input   wire        vsync,
    input   wire        de,
    input   wire        vid_field_id,
    input   wire  [DATA_WIDTH-1:0] video_data,
	output  reg         error_out,
	output  reg         frame_complete
 );

parameter ACW = 8;
parameter NCW = 8;

// variable declarations
reg [13:0]   pixel_count;
reg [13:0]    line_count;
reg  [DATA_WIDTH-1:0]  video_data_1;
reg         de_1;
reg         de_2;
reg         hsync_1;
reg         vsync_1;
wire[DATA_WIDTH-1:0]  expected_video_data;
reg         count_valid = 0;
wire        vsync_rising;
reg         vblank;
wire        compare_valid;

assign vsync_rising = vsync & !vsync_1;
assign compare_valid = de & count_valid & !frame_complete;

// Delay data and eol to match with pixel and line numbers
always @ (posedge clk)	begin
  if (vid_ce) begin
    video_data_1 <= video_data;
    de_1         <= de;
    de_2         <= de_1;
    hsync_1      <= hsync;
    vsync_1      <= vsync;
  end
end
//
// pixel counter
//
// Cleared to 0 on reset and hsync. Rolls over when it reaches total_pixels-1. Otherwise
// increments every data enable.
//  
always @ (posedge clk) begin
  if (vid_ce) begin
        if (rst || hsync)
             pixel_count <= 0;
        else if (de_1)
             pixel_count <= pixel_count + 1;
  end
end
//
// Line counter
//
// Set to line 0 on reset or vsync. Increments coincident with rising edge
// of de.
//
always @ (posedge clk) begin
   if (rst)begin
     line_count <=  0;
   	    count_valid <=  0;
  	   frame_complete <= 0;
   end
   else if (vid_ce) begin
     if (vsync_rising) begin		  // count is valid after 1st vsync
        vblank <= 1;	 // set flag to indicate this is during vert. blank
        line_count <= 0;
   	 if ( !INTERLACE || vid_field_id)	// for interlace start with field 1	  
     	  count_valid <=  1;
     	  // if count_valid is already asserted, the frame is complete
		  // For interlace, additionally, wait for field 2
     	  if ( count_valid && (!INTERLACE || vid_field_id))		  
     	    frame_complete <= 1;
     end
     else if (&line_count)
       begin
         $display ("Line counter reached maximum value. Test error.");
         $stop;
       end
     else if (de & !de_1)	begin// increment on every rising de after vblank
       if (!vblank)
         line_count <=  line_count + 1;
   	 vblank <= 0;
     end
   end
end


// Generate the video outputs.  The video is generated procedurally
// according to the line and pixel number.  This makes it so the checking
// side can reconstruct the expected data by the same procedure.

  assign expected_video_data = vid_field_id ? {~pixel_count[8-1:0]} : {pixel_count[8-1:0]};

always @ (posedge clk) begin
  if (vid_ce) begin
    error_out <= 0;
    if (compare_valid) begin
      # DLY #DLY if (video_data_1 != expected_video_data) begin
         $display ("Data Mismatch. Expected: %h, received: %h. Test error.",
         expected_video_data, video_data_1);
         error_out <= 1;
         $display("*******************************");
         $display("** ERROR. TEST FAILED  !!!");
         $display("*******************************");
    	 $stop;
      end
    end
  end
end

endmodule
