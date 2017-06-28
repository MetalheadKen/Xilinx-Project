

// (c) Copyright 2013 Xilinx, Inc. All rights reserved.
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
// 
//------------------------------------------------------------------------------



//******************************************************************
// Filename    : timing_generator.v
// Description :  Video Timing Signal Generator for XSVI.
//---------------------------------------------------------------------------------------------
// Version		Date		Modified by		Modification
//---------------------------------------------------------------------------------------------
// 1.0          20/05/11    Reinald Cruz	Initial release.
// 1.1          24/05/11    Reinald Cruz	Changed module interface names to *_in/*_out.
// 											Added v_blank_width_min_in & h_blank_width_min_in
// 1.2          05/07/11    Reinald Cruz    active_chroma_in generation to be active every other line
//                                          if ACTIVE_CHROMA_GEN define macro is set to '1'.
//                                          Added support for interlaced video timing 
//                                          & field_id generation
//---------------------------------------------------------------------------------------------
`timescale  1 ns / 1 ns

  `ifndef ACTIVE_CHROMA_IN_GEN
  	`define ACTIVE_CHROMA_IN_GEN 0 //1: Fixed period of active chroma every other line, 0: active_chroma_in will be generated based on "INACTIVE" data value = 0xFFFFFF
  `endif	
  //`include "./src/core_specific/xi_config.v"
 `define INACTIVE_LEFT 0
 `define INACTIVE_RIGHT 0
  module timing_gen
  	#(
		parameter module_id = "Video Timing Generator"
	)
	(
		input clk_in,
		input sclr_in,
		input ce_in,
		
		input [31:0] field_in,
		input [31:0] frame_total_in,
		input [31:0] active_rows_in,
		input [31:0] active_cols_in,		
		input [31:0] hblank_width_in,
		input [31:0] vblank_width_in,
		
		input [31:0] hblank_width_max,
		input [31:0] vblank_width_max,
		input [31:0] hblank_width_min,
		input [31:0] vblank_width_min,
				
		output reg hblank_out,
		output reg vblank_out,
		output reg active_video_out,

		output reg vsync_out,
		output reg hsync_out,
		output reg field_id_out,
		output reg active_chroma_out
	);

	event done;
	
	// Controls
	integer total_cols;
	integer total_rows;
	integer total_frames;
	
	integer inactive_left  = `INACTIVE_LEFT;
	integer inactive_right = `INACTIVE_RIGHT;

	integer hblank_width;
	integer vblank_width;
	integer hval  = 0;
	integer vval  = 0;
	integer frame = 0;

	reg enable = 0;
	reg random_blanking = 0; 	// 1'b0   : blanking widths are fixed
	reg ce_in_d;
								// 1'b1   : blanking widths are random bound from *blank_width_min to *blank_width_max
		
	task start;
	begin
	    total_cols   = active_cols_in;
		total_rows   = active_rows_in;
		total_frames = frame_total_in;
		if(field_in != 0)
		begin
			//total_rows   = total_rows/2;
			total_rows   = total_rows;
			total_frames = total_frames*1; // Fix by Jude
			//total_frames = total_frames*2;
		end
		hblank_width = hblank_width_in;
		vblank_width = vblank_width_in;
		hval 		 = 0;
		vval 		 = 0;
		frame 		 = 0;
		enable 		 = 1;
		$display("@%10t : [%s] STARTED", $time, module_id);
	end
	endtask
	
	task start_random_blanking;
	begin
	    total_cols   = active_cols_in;
		total_rows   = active_rows_in;
		total_frames = frame_total_in;
		if(field_in != 0)
		begin
			total_rows   = total_rows/2;
			total_frames = total_frames*2;
		end
		hblank_width = ($random % hblank_width_max ) + 1;
		vblank_width = ($random % vblank_width_max ) + 1;
		
		if (hblank_width < hblank_width_min) hblank_width = hblank_width_min;
		if (vblank_width < vblank_width_min) vblank_width = vblank_width_min;
				
		$display("@ %10t : TIMING GEN STARTED", $time);
		$display("RANDOMIZED HBLANK WIDTH TO : %d", hblank_width);
		$display("RANDOMIZED VBLANK WIDTH TO : %d", vblank_width);
		hval   = 0;
		vval   = 0;
		frame  = 0;
		enable = 1;
	end
	endtask

	task stop;
	begin
		enable = 0;
	end
	endtask

	//always @ (negedge clk_in)
	//begin
	//	if (sclr_in)
	//		ce_in_d <= 1'b0;
	//	else
	//		ce_in_d <= ce_in;
	//end
		
	//always @ (posedge clk_in)
	always @ (negedge clk_in)
	begin
		#1;
		if (sclr_in) 
		begin
			hval	 			<= 0;
			vval 				<= 0;
			frame 				<= 0;
			enable 				<= 0;			
			vblank_out			<= 0;
			hblank_out		        <= 0;
			active_video_out	        <= 0;
			vsync_out			<= 0;
			hsync_out			<= 0;
			field_id_out	        	<= 0;
			active_chroma_out	        <= 0;
		end
	 
		else if (enable && ce_in && (frame < total_frames))
		begin
			if(field_in == 0)
			begin 
				field_id_out <= 0;
			end
			else begin
				if((hval == 0)&&(vval == 0))
				begin
					if(frame == 0)
					begin
						if(field_in == 1) field_id_out <= 0;
						if(field_in == 2) field_id_out <= 1;
					end
					else
					begin
						field_id_out <= ~field_id_out;
					end
				end
			end
			
	            	//Vertical Blanking Period
		    	if (vval < vblank_width)
		    	begin
				active_video_out		<= 0;
				active_chroma_out		<= 0;
				vblank_out			<= 1;
				if (hval < hblank_width)
				begin
					hblank_out		<= 1;
					hval 			<= hval+1;
				end
				else if ((hval >= hblank_width)&&(hval < total_cols + inactive_left + hblank_width + inactive_right - 1))
				begin
					hblank_out				<= 0;
					hval 					<= hval+1;
				end
				else // if (hval >= total_cols + inactive_video + hblank_width)
				begin
					hblank_out				<= 0;
					hval					<= 0;
					vval					<= vval+1;
				end
			end

	     		//Normal line until Last line
			else if (vval >= vblank_width)// && (vval <= (total_rows + vblank_width)))
			begin
				vblank_out				<= 0;
				if (hval < hblank_width)
				begin
					hblank_out			<= 1;
					active_video_out		<= 0;
					active_chroma_out		<= 0;
					hval				<= hval+1;
				end
				else if ((hval >= hblank_width)&&(hval < hblank_width + inactive_left))
				begin
					hblank_out		<= 0;
					active_video_out        <= 0;
					active_chroma_out       <= 0;
					hval <= hval + 1;
				end
				else if ((hval >= hblank_width + inactive_left)&&(hval < (total_cols + hblank_width + inactive_left)))
				begin
					hblank_out		<= 0;
					active_video_out	<= 1;
					if(`ACTIVE_CHROMA_IN_GEN)
					begin
						if((vval % 2)!=0)
						active_chroma_out   <= 1;
						else
						active_chroma_out   <= 0;
					end
					else begin
						active_chroma_out   <= 1;
					end
					hval <= hval+1;
				end

				else if ((hval >= total_cols + hblank_width + inactive_left)&&(hval < total_cols + hblank_width + inactive_left + inactive_right - 1))
				begin
					hblank_out		<= 0;
					active_video_out	<= 0;
					active_chroma_out   	<= 0;
                                        hval <= hval+1;
				end
				else 
				begin
					hval			<= 0;
					//if (vval == total_cols + vblank_width)
					if (vval == total_cols +  vblank_width - 1)
					begin 
						vval <= 0;
						frame = frame+1;
					end 
					else
					begin 
						vval <= vval+1;
					end
				end
			end
        end 
		else if  ((!enable) || (frame >= total_frames))
		begin
			if (frame >= total_frames)
			begin					
				-> done;
				$display("@%10t : [%s] FINISHED", $time, module_id);
			end
			hval	            <= 0;
			vval                <= 0;
			frame 	            <= 0;
			vblank_out	    <= 0;
			hblank_out	    <= 0;
			active_video_out    <= 0;
			active_chroma_out   <= 0;
			vsync_out	    <= 0;
			hsync_out	    <= 0;
			field_id_out	    <= 0;
			active_chroma_out   <= 0;
			enable              <= 0;
		end
    end
endmodule
 

/*
-- TESTBENCH_TEMPLATE_VERSION = 2.0
*/
`define IPV_TEST
//******************************************************************************
// Filename    : tb_main.v
// Description : 
//
//------------------------------------------------------------------------------
// Version   Date	Modified by	Modification
//------------------------------------------------------------------------------
// 1.0 	     17/11/11 	Reinald Cruz    Initial release.
// 1.1       13/12/11   Reinald Cruz    removed m_EOF_w assignment to endofcheck
// 1.2       14/12/11   Reinald Cruz    removed s_endofcheck_w.
//                                      added aclken to mst & slv instances.
// 1.3       21/12/11   Reinald Cruz    added tb_reg_utils.v using `include
// 1.4       03/01/12   Reinald Cruz    added tb_conf_mngr.v using `include
//------------------------------------------------------------------------------

`timescale  1 ns / 1 ns

`define C_DUT_LATENCY           0
`define C_AXI4LITE_DWIDTH      32 
`define C_AXI4LITE_AWIDTH       9
`define C_AXIS_MST_TDATA_WIDTH  8
`define C_AXIS_SLV_TDATA_WIDTH  8
`define TB_ACTIVE_EDGE     "rise"
`define TB_DRIVE_DELAY     2
`define TB_OUTPUT_FILE     0

// DEFINES FOR TOP LEVEL TB 
`define C_CLOCK_PERIOD         40
`define C_CLOCK_PERIOD_AXI     20
`define C_RAND_SEED             0 

`define C_TESTNAME "VTC TEST"
`define T_TESTNUM  008
`define T_NUM_REG_CHECKS 0 // set to 0 if detect_en = 0

`define C_HAS_AXI4_LITE 0
`define C_DETECT_EN 0
`define C_DET_ACHROMA_EN 0
`define C_DET_AVIDEO_EN 1
`define C_DET_HBLANK_EN 1
`define C_DET_HSYNC_EN 1
`define C_DET_VBLANK_EN 1
`define C_DET_VSYNC_EN 1
`define C_GENERATE_EN 1
`define C_GEN_ACHROMA_EN 0
`define C_GEN_AVIDEO_EN 1
`define C_GEN_HBLANK_EN 1
`define C_GEN_HSYNC_EN 1
`define C_GEN_VBLANK_EN 1
`define C_GEN_VSYNC_EN 1
`define C_MAX_LINES 4096
`define C_MAX_PIXELS 4096
`define C_NUM_FSYNCS 1

`define C_GEN_HACTIVE_SIZE    1920
`define C_GEN_VACTIVE_SIZE    1080
`define C_GEN_CPARITY         0
`define C_GEN_VBLANK_POLARITY 1
`define C_GEN_HBLANK_POLARITY 1
`define C_GEN_VSYNC_POLARITY  1
`define C_GEN_HSYNC_POLARITY  1
`define C_GEN_AVIDEO_POLARITY 1
`define C_GEN_ACHROMA_POLARITY 1
`define C_GEN_VIDEO_FORMAT    2
`define C_GEN_HFRAME_SIZE     2200
`define C_GEN_F0_VFRAME_SIZE  1125
`define C_GEN_HSYNC_START     2008
`define C_GEN_HSYNC_END       2052
`define C_GEN_F0_VBLANK_HSTART 1920
`define C_GEN_F0_VBLANK_HEND  1920
`define C_GEN_F0_VSYNC_VSTART 1083
`define C_GEN_F0_VSYNC_VEND   1088
`define C_GEN_F0_VSYNC_HSTART 1920
`define C_GEN_F0_VSYNC_HEND   1920
`define C_FSYNC_HSTART0       0
`define C_FSYNC_VSTART0       0
`define C_FSYNC_HSTART1       0
`define C_FSYNC_VSTART1       0
`define C_FSYNC_HSTART2       0
`define C_FSYNC_VSTART2       0
`define C_FSYNC_HSTART3       0
`define C_FSYNC_VSTART3       0
`define C_FSYNC_HSTART4       0
`define C_FSYNC_VSTART4       0
`define C_FSYNC_HSTART5       0
`define C_FSYNC_VSTART5       0
`define C_FSYNC_HSTART6       0
`define C_FSYNC_VSTART6       0
`define C_FSYNC_HSTART7       0
`define C_FSYNC_VSTART7       0
`define C_FSYNC_HSTART8       0
`define C_FSYNC_VSTART8       0
`define C_FSYNC_HSTART9       0
`define C_FSYNC_VSTART9       0
`define C_FSYNC_HSTART10      0
`define C_FSYNC_VSTART10      0
`define C_FSYNC_HSTART11      0
`define C_FSYNC_VSTART11      0
`define C_FSYNC_HSTART12      0
`define C_FSYNC_VSTART12      0
`define C_FSYNC_HSTART13      0
`define C_FSYNC_VSTART13      0
`define C_FSYNC_HSTART14      0
`define C_FSYNC_VSTART14      0
`define C_FSYNC_HSTART15      0
`define C_FSYNC_VSTART15      0
`define C_GEN_AUTO_SWITCH     0
`define C_SYNC_EN             0


module tb_fmc_imageon_gs_v_tc_0_0;

parameter TESTNAME = `C_TESTNAME;

//REG & DRIVERS
reg  tb_clk;
reg  tb_sclr;
wire tb_sclr_n;
wire tb_ce;


reg  tb_clk_axi;
reg  tb_sclr_axi;
wire tb_sclr_n_axi;
wire tb_ce_axi;

reg  EOS;
reg  EOS_VIDEO;
reg  EOS_AXI;

integer clock_period   = `C_CLOCK_PERIOD;
integer clock_period_axi = `C_CLOCK_PERIOD_AXI;

integer dut_latency    = `C_DUT_LATENCY;
integer rseed          = `C_RAND_SEED;
integer total_errors   = 0;

//AXI4-STREAM VIDEO MASTER WIRES
wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m_video_data_w;
wire m_ready_w;
wire m_valid_w;
wire m_sof_w;
wire m_eol_w;
wire m_EOF_w;
wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m_tstrb_w;
wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m_tkeep_w;
wire m_tdest_w;
wire m_tid_w;
//AXI4-STREAM VIDEO SLAVE WIRES
wire [`C_AXIS_SLV_TDATA_WIDTH-1:0] s_video_data_w;
wire s_ready_w;
wire s_valid_w;
wire s_sof_w;
wire s_eol_w;
wire s_EOF_w;
wire [31:0] s_error_count_w;
//AXI4-LITE MASTER WIRES 
wire m_awready_w;
wire m_awvalid_w;
wire [`C_AXI4LITE_AWIDTH-1:0] m_awaddr_w;
wire [2:0] m_awprot_w;
wire m_wready_w;
wire m_wvalid_w;
wire [`C_AXI4LITE_DWIDTH-1:0] m_wdata_w;
wire [(`C_AXI4LITE_DWIDTH/8)-1:0] m_wstrb_w;
wire m_bvalid_w;
wire [1:0] m_bresp_w;
wire m_bready_w;
wire m_arready_w;
wire m_arvalid_w;
wire [`C_AXI4LITE_AWIDTH-1:0] m_araddr_w;
wire [2:0] m_arprot_w;
wire m_rvalid_w;
wire [`C_AXI4LITE_DWIDTH-1:0] m_rdata_w;
wire [1:0] m_rresp_w;
wire m_rready_w;
reg [`C_AXI4LITE_DWIDTH-1:0] reg_data;
//INTERRUPT WIRE
wire irq_w;
wire [31:0] intc_if_w; 


//DUT INSTANCE & REGISTER FILE INCLUSION
// GENR=5, TIME=32, Reserved=24, CORE=16 -> 102
`define REG_NO 47

reg [50*8+100:0]  reg_mem  [1:`REG_NO];

initial
begin
  //reg_mem[1] = { REG_NAME, ADDR, DEFAULT_VALUE,  MASK,      DEFAULT_TEST, READ_ONLY, R/W_TEST };
  //----------------------------------------------------------------------------------------------
  // CONTROL Register R/W
  reg_mem[1]  = {"R_CONTROL_00", 32'h00,  32'h00000000, 32'hc000000f,    1'h1 ,     1'h0 ,   1'h0   };
  // STATUS Register R/w                                                        
  reg_mem[2]  = {"R_CONTROL_04", 32'h04,  32'h00000000, 32'hffff3f00,    1'h1 ,     1'h0 ,   1'h0   };
  // ERROR Register R                                                             
  reg_mem[3]  = {"R_CONTROL_08", 32'h08,  32'h00000000, 32'h00000000,    1'h1 ,     1'h0 ,   1'h0   };
  // IRQ_ENABLE Register R/W                                                      
  reg_mem[4]  = {"R_CONTROL_0c", 32'h0C,  32'h00000000, 32'hffff3f00,    1'h1 ,     1'h0 ,   1'h0   };
  // VERSION Register R                                                           
  reg_mem[5]  = {"R_CONTROL_10", 32'h10,  32'h06010001, 32'h00000000,    1'h0 ,     1'h0 ,   1'h0   };


  // ACTIVE_SIZE Register R/W                                                     
  reg_mem[6]  = {"R_TIME1_20", 32'h20,  32'h00000001, 32'h00000000,   1'h0 ,     1'h0 ,   1'h0   };
  // TIMING_STATUS Register R                                                     
  reg_mem[ 7] = {"R_TIME1_24", 32'h24,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  // ENCODING Register R/W                                                        
  reg_mem[ 8] = {"R_TIME1_28", 32'h28,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };

  reg_mem[ 9] = {"R_TIME1_2c", 32'h2c,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[10] = {"R_TIME1_30", 32'h30,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[11] = {"R_TIME1_34", 32'h34,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[12] = {"R_TIME1_38", 32'h38,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[13] = {"R_TIME1_3c", 32'h3c,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[14] = {"R_TIME1_40", 32'h40,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[15] = {"R_TIME1_44", 32'h44,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[16] = {"R_TIME1_48", 32'h48,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[17] = {"R_TIME1_4c", 32'h4c,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  reg_mem[18] = {"R_TIME1_50", 32'h50,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };
  //Second set of timing
  reg_mem[19] = {"R_TIME2_60", 32'h60,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[20] = {"R_TIME2_64", 32'h64,  32'h00000000, 32'h00000000,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[21] = {"R_TIME2_68", 32'h68,  32'h00000000, 32'h0000034f,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[22] = {"R_TIME2_6c", 32'h6c,  32'h0000003f, 32'h0000003f,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[23] = {"R_TIME2_70", 32'h70,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[24] = {"R_TIME2_74", 32'h74,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[25] = {"R_TIME2_78", 32'h78,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[26] = {"R_TIME2_7c", 32'h7c,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[27] = {"R_TIME2_80", 32'h80,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[28] = {"R_TIME2_84", 32'h84,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[29] = {"R_TIME2_88", 32'h88,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[30] = {"R_TIME2_8c", 32'h8c,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[31] = {"R_TIME2_90", 32'h90,  32'h00000000, 32'h1fff1fff,   1'h0 ,     1'h0 ,   1'h0   };
  //Reserved set
  // Core - Frame Sync
  reg_mem[32] = {"R_CORE_100", 32'h100,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[33] = {"R_CORE_104", 32'h104,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[34] = {"R_CORE_108", 32'h108,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[35] = {"R_CORE_10c", 32'h10c,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[36] = {"R_CORE_110", 32'h110,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[37] = {"R_CORE_114", 32'h114,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[38] = {"R_CORE_118", 32'h118,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[39] = {"R_CORE_11c", 32'h11c,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[40] = {"R_CORE_120", 32'h120,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[41] = {"R_CORE_124", 32'h124,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[42] = {"R_CORE_128", 32'h128,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[43] = {"R_CORE_12c", 32'h12c,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[44] = {"R_CORE_130", 32'h130,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[45] = {"R_CORE_134", 32'h134,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[46] = {"R_CORE_138", 32'h138,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
  reg_mem[47] = {"R_CORE_13c", 32'h13c,  32'h00000000, ((`C_MAX_LINES-1)<<16)|(`C_MAX_PIXELS-1),   1'h0 ,     1'h0 ,   1'h0   };
end
//============================================
// CORE & OTHER TB COMPONENTS - INSTANTIATIONS
//============================================

wire xsvi_vblank_in;
wire xsvi_hblank_in;
wire xsvi_active_video_in;
wire xsvi_vsync_in;
wire xsvi_hsync_in;
wire xsvi_field_id_in;
wire xsvi_active_chroma_in;

wire xsvi_vblank_out;
wire xsvi_hblank_out;
wire xsvi_active_video_out;
wire xsvi_vsync_out;
wire xsvi_hsync_out;
wire xsvi_field_id_out;
wire xsvi_active_chroma_out;


reg xsvi_vblank_int;
reg xsvi_hblank_int;
reg xsvi_active_video_int;
reg xsvi_vsync_int;
reg xsvi_hsync_int;
reg xsvi_field_id_int;
reg xsvi_active_chroma_int;

always @(xsvi_vblank_out or xsvi_hblank_out or xsvi_active_video_out or xsvi_vsync_out or xsvi_hsync_out or xsvi_field_id_out or xsvi_active_chroma_out)
begin

  xsvi_vblank_int <= #1 (`C_GEN_VBLANK_EN)?xsvi_vblank_out:1'b0;
  xsvi_hblank_int <= #1 (`C_GEN_HBLANK_EN)?xsvi_hblank_out:1'b0;
  xsvi_active_video_int <= #1 (`C_GEN_AVIDEO_EN)?xsvi_active_video_out:1'b0;
  xsvi_vsync_int <= #1 (`C_GEN_VSYNC_EN)?xsvi_vsync_out:1'b0;
  xsvi_hsync_int <= #1 (`C_GEN_HSYNC_EN)?xsvi_hsync_out:1'b0;
  xsvi_field_id_int <= #1 1'b0;
  xsvi_active_chroma_int <= #1 (`C_GEN_ACHROMA_EN)?xsvi_active_chroma_out:1'b0;
end

wire [`C_NUM_FSYNCS-1:0] fsync_o;

assign m_ready_w             = tb_sclr_n;
//Uncomment the xsvi_ lines to connect to the AXI4S MST
//assign xsvi_hsync_in         = m_video_data_w[0];
//assign xsvi_hblank_in        = m_video_data_w[1];
//assign xsvi_vsync_in         = m_video_data_w[2];
//assign xsvi_vblank_in        = m_video_data_w[3];
//assign xsvi_field_id_in      = m_video_data_w[4];
//assign xsvi_active_video_in  = m_video_data_w[5];
//assign xsvi_active_chroma_in = m_video_data_w[6];


assign s_video_data_w[0] = xsvi_hsync_int;
assign s_video_data_w[1] = xsvi_hblank_int;
assign s_video_data_w[2] = xsvi_vsync_int;
assign s_video_data_w[3] = xsvi_vblank_int;
assign s_video_data_w[4] = xsvi_field_id_int;
assign s_video_data_w[5] = xsvi_active_video_int;
assign s_video_data_w[6] = xsvi_active_chroma_int;
assign s_video_data_w[7] = 1'b0;

assign s_sof_w = 1'b0; // need to generate
assign s_eol_w = 1'b0; // need to generate




//===============================================================================
//===============================================================================
reg  fsync_o_d;
reg s_valid_w_int;
assign s_valid_w = s_valid_w_int;

always @ (posedge tb_clk)
begin
  if(tb_sclr_n == 0)
  begin
    s_valid_w_int <= #1 0;
    fsync_o_d     <= #1 1;
  end
  else if(tb_ce == 1) 
  begin
    fsync_o_d <= #1 fsync_o[0];
    // Enable after first fsync
    if((fsync_o[0] == 1) && (fsync_o_d == 0)) 
    begin
      s_valid_w_int <= #1 1;
    end
  end
end

//===============================================================================
// DUT INSTANCE
//===============================================================================
//
`ifdef IPV_TEST
  wire  clk;
  wire  resetn;
  wire  clken;  

  wire  s_axi_aclk;
  wire  s_axi_aresetn;
  wire  s_axi_aclken;  

  wire  gen_clken;  
  wire  det_clken;  
  wire  fsync_in;

  wire  vblank_in;
  wire  hblank_in;
  wire  active_video_in;
  wire  vsync_in;
  wire  hsync_in;
  wire  field_id_in;
  wire  active_chroma_in;

  wire  vblank_outnetlist;
  wire  hblank_outnetlist;
  wire  active_video_outnetlist;
  wire  vsync_outnetlist;
  wire  hsync_outnetlist;
  wire  field_id_outnetlist;
  wire  active_chroma_outnetlist;

  wire  [`C_NUM_FSYNCS-1:0]  fsync_outnetlist;

  wire  s_axi_awreadynetlist; 
  wire  s_axi_awvalid; 
  wire  [`C_AXI4LITE_AWIDTH-1:0] s_axi_awaddr; 
  wire  s_axi_wreadynetlist;  
  wire  s_axi_wvalid;  
  wire  [`C_AXI4LITE_DWIDTH-1:0] s_axi_wdata;   
  wire  [(`C_AXI4LITE_DWIDTH/8)-1:0] s_axi_wstrb;   
  wire  s_axi_bvalidnetlist;  
  wire  [1:0] s_axi_brespnetlist;   
  wire  s_axi_bready;  
  wire  s_axi_arreadynetlist; 
  wire  s_axi_arvalid; 
  wire  [`C_AXI4LITE_AWIDTH-1:0] s_axi_araddr;  
  wire  s_axi_rvalidnetlist;  
  wire  [`C_AXI4LITE_DWIDTH-1:0] s_axi_rdatanetlist;  
  wire  [1:0] s_axi_rrespnetlist;   
  wire  s_axi_rready;  
  wire  irqnetlist;
  wire  [31:0] intc_ifnetlist;

  assign clk    = tb_clk;
  assign resetn = tb_sclr_n;
  assign clken  = tb_ce;

  assign s_axi_aclk    = tb_clk_axi;
  assign s_axi_aresetn = tb_sclr_n_axi;
  assign s_axi_aclken  = tb_ce_axi;

  assign det_clken  = tb_ce;
  assign gen_clken  = tb_ce;

  assign fsync_in            = 1'b0;

  //XSVI in
  assign vblank_in           = xsvi_vblank_in;
  assign hblank_in           = xsvi_hblank_in;
  assign active_video_in     = xsvi_active_video_in;
  assign vsync_in            = xsvi_vsync_in;
  assign hsync_in            = xsvi_hsync_in;
  assign field_id_in         = xsvi_field_id_in;
  assign active_chroma_in    = xsvi_active_chroma_in;
  //XSVI out
  assign xsvi_vblank_out = vblank_outnetlist;
  assign xsvi_hblank_out = hblank_outnetlist;
  assign xsvi_active_video_out = active_video_outnetlist;
  assign xsvi_vsync_out = vsync_outnetlist;
  assign xsvi_hsync_out = hsync_outnetlist;
  assign xsvi_field_id_out = field_id_outnetlist;
  assign xsvi_active_chroma_out = active_chroma_outnetlist;

  assign fsync_o = fsync_outnetlist; 


  // AXI4-Lite 
  assign m_awready_w    = s_axi_awreadynetlist;
  assign s_axi_awvalid  = m_awvalid_w;
  assign s_axi_awaddr   = m_awaddr_w;
  assign m_wready_w     = s_axi_wreadynetlist;   
  assign s_axi_wvalid   = m_wvalid_w;
  assign s_axi_wdata    = m_wdata_w;
  assign s_axi_wstrb    = m_wstrb_w;
  assign m_bvalid_w     = s_axi_bvalidnetlist; 
  assign m_bresp_w      = s_axi_brespnetlist;
  assign s_axi_bready   = m_bready_w;
  assign m_arready_w    = s_axi_arreadynetlist;
  assign s_axi_arvalid  = m_arvalid_w;
  assign s_axi_araddr   = m_araddr_w;
  assign m_rvalid_w     = s_axi_rvalidnetlist;
  assign m_rdata_w      = s_axi_rdatanetlist;
  assign m_rresp_w      = s_axi_rrespnetlist;
  assign s_axi_rready   = m_rready_w;
  assign irq_w          = irqnetlist;

  //-------------------------------------------------
  //-- Component (UUT) Instantiation
  //-------------------------------------------------
  fmc_imageon_gs_v_tc_0_0 uut
  (


        .gen_clken           (tb_ce),
        .vblank_out          (vblank_outnetlist),
        .hblank_out          (hblank_outnetlist),
        .active_video_out    (active_video_outnetlist),
        .vsync_out           (vsync_outnetlist),
        .hsync_out           (hsync_outnetlist),
        //.field_id_out        (field_id_outnetlist),
        .fsync_out           (fsync_outnetlist),

        .clk                (tb_clk),
        .resetn             (tb_sclr_n),
        .clken              (tb_ce)
  );



                                `else
                                  //-----------
                                  //-- RTL TEST
                                  //-----------

                                  v_tc 
                                  #(

                                    .C_HAS_AXI4_LITE    (`C_HAS_AXI4_LITE),
                                    .C_HAS_INTC_IF      (`C_HAS_INTC_IF),
                                    .C_HAS_EXT_FSYNC    (`C_HAS_EXT_FSYNC),
                                    .C_MAX_PIXELS       (`C_MAX_PIXELS),
                                    .C_MAX_LINES        (`C_MAX_LINES),
                                    .C_NUM_FSYNCS       (`C_NUM_FSYNCS),
                                    .C_GEN_AUTO_SWITCH  (`C_GEN_AUTO_SWITCH),

                                    .C_DETECT_EN        (`C_DETECT_EN),
                                    .C_GENERATE_EN      (`C_GENERATE_EN),
                                    .C_GEN_USE_EXT_FSYNC(`C_GEN_USE_EXT_FSYNC),

                                    .C_DET_HSYNC_EN     (`C_DET_HSYNC_EN),
                                    .C_DET_VSYNC_EN     (`C_DET_VSYNC_EN),
                                    .C_DET_HBLANK_EN    (`C_DET_HBLANK_EN),
                                    .C_DET_VBLANK_EN    (`C_DET_VBLANK_EN),
                                    .C_DET_AVIDEO_EN    (`C_DET_AVIDEO_EN),
                                    .C_DET_ACHROMA_EN   (`C_DET_ACHROMA_EN),

                                    .C_GEN_HSYNC_EN     (`C_GEN_HSYNC_EN),
                                    .C_GEN_VSYNC_EN     (`C_GEN_VSYNC_EN),
                                    .C_GEN_HBLANK_EN    (`C_GEN_HBLANK_EN),
                                    .C_GEN_VBLANK_EN    (`C_GEN_VBLANK_EN),
                                    .C_GEN_AVIDEO_EN    (`C_GEN_AVIDEO_EN),
                                    .C_GEN_ACHROMA_EN   (`C_GEN_ACHROMA_EN)
                                  ) DUT (
                                    .clk                (tb_clk),
                                    .resetn             (tb_sclr_n),
                                    .clken              (tb_ce),

                                    .s_axi_aclk          (tb_clk),
                                    .s_axi_aresetn       (tb_sclr_n),
                                    .s_axi_aclken        (tb_ce),
                                    .fsync_in            (1'b0),

                                    .vblank_in           (xsvi_vblank_in),
                                    .hblank_in           (xsvi_hblank_in),
                                    .active_video_in     (xsvi_active_video_in),
                                    .vsync_in            (xsvi_vsync_in),
                                    .hsync_in            (xsvi_hsync_in),
                                    .field_id_in         (xsvi_field_id_in),
                                    .active_chroma_in    (xsvi_active_chroma_in),

                                    .vblank_out          (xsvi_vblank_out),
                                    .hblank_out          (xsvi_hblank_out),
                                    .active_video_out    (xsvi_active_video_out),
                                    .vsync_out           (xsvi_vsync_out),
                                    .hsync_out           (xsvi_hsync_out),
                                    .field_id_out        (xsvi_field_id_out),
                                    .active_chroma_out   (xsvi_active_chroma_out),

                                    .fsync_out           (fsync_o),
                                    // AXI4-Lite
                                    .s_axi_awready  (m_awready_w),
                                      .s_axi_awvalid  (m_awvalid_w),
                                      .s_axi_awaddr   (m_awaddr_w),
                                      //.s_axi_awprot   (m_awprot_w),
                                      .s_axi_wready   (m_wready_w),
                                      .s_axi_wvalid   (m_wvalid_w),
                                      .s_axi_wdata    (m_wdata_w),
                                      .s_axi_wstrb    (m_wstrb_w),
                                      .s_axi_bvalid   (m_bvalid_w),
                                      .s_axi_bresp    (m_bresp_w),
                                      .s_axi_bready   (m_bready_w),
                                      .s_axi_arready  (m_arready_w),
                                      .s_axi_arvalid  (m_arvalid_w),
                                      .s_axi_araddr   (m_araddr_w),
                                      //.s_axi_arprot   (m_arprot_w),
                                      .s_axi_rvalid   (m_rvalid_w),
                                      .s_axi_rdata    (m_rdata_w),
                                      .s_axi_rresp    (m_rresp_w),
                                      .s_axi_rready   (m_rready_w),
                                      //IRQ
                                      .irq      (irq_w)
                                      );
                                    `endif

                                    //===============================================================================

                                    //CE GENERATOR INSTANCE
                                    ce_gen CE_GEN
                                    (
                                      .clk_in         (tb_clk),
                                      .sclr_in        (tb_sclr),
                                      .ce_out         (tb_ce)
                                    );
                                    //CE GENERATOR INSTANCE FOR AXI4LITE
                                    ce_gen CE_GEN_AXI
                                    (
                                      .clk_in         (tb_clk_axi),
                                      .sclr_in        (tb_sclr_axi),
                                      //.ce_out         (tb_ce_axi)
                                      .ce_out         ()
                                      );
                                      assign tb_ce_axi     = 1;

                                      //AXI4-LITE MASTER INSTANCE
                                      axi4lite_mst
                                      #(
                                        .module_id    ("AXI4-LITE MASTER 1"),
                                        .drive_edge   (`TB_ACTIVE_EDGE),
                                        .datawidth    (`C_AXI4LITE_DWIDTH),
                                        .addrwidth    (`C_AXI4LITE_AWIDTH),
                                        .drive_dly    (`TB_DRIVE_DELAY)
                                      ) AXI4LITE_MST (
                                        .aclk     (tb_clk_axi),
                                        .aclken   (tb_ce_axi),
                                        .aresetn  (tb_sclr_n_axi),
                                        .awready  (m_awready_w),
                                        .awvalid  (m_awvalid_w),
                                        .awaddr   (m_awaddr_w),
                                        .awprot   (m_awprot_w),
                                        .wready   (m_wready_w),
                                        .wvalid   (m_wvalid_w),
                                        .wdata    (m_wdata_w),
                                        .wstrb    (m_wstrb_w),
                                        .bvalid   (m_bvalid_w),
                                        .bresp    (m_bresp_w),
                                        .bready   (m_bready_w),
                                        .arready  (m_arready_w),
                                        .arvalid  (m_arvalid_w),
                                        .araddr   (m_araddr_w),
                                        .arprot   (m_arprot_w),
                                        .rvalid   (m_rvalid_w),
                                        .rdata    (m_rdata_w),
                                        .rresp    (m_rresp_w),
                                        .rready   (m_rready_w)
                                      );

                                      
                                      timing_gen TIMING_IN (
                                        .clk_in   (tb_clk),
                                        .ce_in    (tb_ce),
                                        .sclr_in  (tb_sclr),

                                        .field_in  (0),
                                        .frame_total_in (6),
                                        .active_rows_in (`C_GEN_VACTIVE_SIZE),
                                        .active_cols_in (`C_GEN_HACTIVE_SIZE),		
                                        .hblank_width_in(`C_GEN_HFRAME_SIZE-`C_GEN_HACTIVE_SIZE),
                                        .vblank_width_in(`C_GEN_F0_VFRAME_SIZE-`C_GEN_VACTIVE_SIZE),
		
                                        .hblank_width_max(`C_GEN_HFRAME_SIZE-`C_GEN_HACTIVE_SIZE),
                                        .vblank_width_max(`C_GEN_F0_VFRAME_SIZE-`C_GEN_VACTIVE_SIZE),
                                        .hblank_width_min(1),
                                        .vblank_width_min(1),

                                        .hblank_out (xsvi_hblank_in),
                                        .vblank_out (xsvi_vblank_in), 
                                        .active_video_out (xsvi_active_video_in), 
                                        .vsync_out (xsvi_vsync_in),
                                        .hsync_out (xsvi_hsync_in),
                                        .field_id_out   (xsvi_field_id_in),
                                        .active_chroma_out (xsvi_active_chroma_in)

                                      );
                                      //AXI4-STREAM VIDEO MASTER INSTANCE
                                      axi4s_video_mst 
                                      #(
                                        .module_id     ("AXI-S Video Master 1"),
                                        .drive_edge    (`TB_ACTIVE_EDGE),
                                        .datawidth     (`C_AXIS_MST_TDATA_WIDTH),
                                        .drive_dly     (`TB_DRIVE_DELAY)
                                      ) MST (
                                        .aclk           (tb_clk),
                                        .aclken         (tb_ce),
                                        .aresetn        (tb_sclr_n),
                                        .tready         (m_ready_w),
                                        .tdata          (m_video_data_w),
                                        .tvalid         (m_valid_w),
                                        .tstrb          (m_tstrb_w),
                                        .tkeep          (m_tkeep_w),
                                        .tdest          (m_tdest_w),
                                        .tid            (m_tid_w),
                                        .sof            (m_sof_w),
                                        .eol            (m_eol_w),
                                        .EOF            (m_EOF_w)
                                      );

                                      //AXI4-STREAM VIDEO SLAVE INSTANCE
                                      axi4s_video_slv
                                      #(
                                        .module_id     ("AXI-S Video Slave  1"),
                                        .drive_edge    (`TB_ACTIVE_EDGE),
                                        .datawidth     (`C_AXIS_SLV_TDATA_WIDTH),
                                        .output_file   (`TB_OUTPUT_FILE),
                                        .drive_dly     (`TB_DRIVE_DELAY)
                                      ) SLV  (
                                        .aclk           (tb_clk),
                                        .aclken         (tb_ce),
                                        .aresetn        (tb_sclr_n),
                                        .tready         (s_ready_w),
                                        .tdata          (s_video_data_w),
                                        .tvalid         (s_valid_w),
                                        .sof            (s_sof_w),
                                        .eol            (s_eol_w),
                                        .error_count    (s_error_count_w),
                                        .EOF            (s_EOF_w)
                                      );

                                      assign tb_sclr_n = ~tb_sclr;
                                      assign tb_sclr_n_axi = ~tb_sclr_axi;


                                      //================================================
                                      // TESTBENCH TASK TO WAIT for "clk_period" CYCLES
                                      //================================================
                                      task wait_cycle;
                                        input integer wait_length;
                                        begin
                                          #(clock_period * wait_length);
                                        end
                                      endtask

                                      //======================
                                      // TESTBENCH RESET TASK
                                      //======================
                                      task reset;
                                        input integer reset_length;
                                        begin
                                          tb_sclr     = 1'b1;
                                          tb_sclr_axi = 1'b1;
                                          $display("@%10t : TB_TOP : SYSTEM RESET  ASSERTED!", $time);
                                          wait_cycle(reset_length);
                                          tb_sclr     = 1'b0;
                                          tb_sclr_axi = 1'b0;
                                          $display("@%10t : TB_TOP : SYSTEM RESET  DEASSERTED!", $time);
                                          wait_cycle(1);
                                        end
                                      endtask

                                      //==========================
                                      // TESTBENCH CLK GENERATION
                                      //==========================
                                      // initial 
                                      // begin
                                      //      tb_clk    = 0;
                                      //      tb_sclr	= 0;	
                                      //      EOS	= 0;
                                      //      while (!EOS)
                                      //      begin
                                      //         #(clock_period/2);
                                      //	 tb_clk = ~tb_clk;
                                      //      end
                                      // end
                                      initial 
                                      begin
                                        tb_clk        = 0;
                                        tb_sclr	    = 0;
                                        EOS           = 0;
                                        EOS_VIDEO     = 0;
                                        while (1)
                                      begin
                                        #(clock_period/2);
                                        if((!EOS)&&(!EOS_VIDEO)) tb_clk = ~tb_clk;
                                      end
                                  end

                                  initial
                                  begin
                                    tb_clk_axi    = 0;
                                    tb_sclr_axi   = 0;	
                                    EOS_AXI       = 0;
                                    while (1)
                                  begin
                                    #(clock_period_axi/2);
                                    if((!EOS)&&(!EOS_AXI)) tb_clk_axi = ~tb_clk_axi;
                                  end
                              end

                              task test_summary;
                                begin
                                  total_errors = total_errors + s_error_count_w;

                                  if(total_errors > 0)
                                  begin
                                    $display("*******************************");
                                    $display("** TEST FAILED !!!");
                                    $display("** TOTAL ERRORS = %d", total_errors);
                                    $display("*******************************");
                                  end
                                  else
                                  begin
                                    $display("\n*********************************");
                                    $display(  "** TEST PASSED                 **");
                                    $display(  "** Test Completed Successfully **");
                                    $display(  "**********************************\n");
                                  end
                                  EOS = 1;
                                  $finish; 
                                end
                              endtask


                              //=================================================
                              // TASK TO CHECK THE READ/WRITE FEATURE OF REGISTER
                              //=================================================
                              task write_read_check;
                                input integer addr;
                                input integer write_data;
                                input integer exp_read_data;
                                input integer mask;

                                integer read_data;
                                begin
                                  AXI4LITE_MST.wr(addr, write_data );
                                  AXI4LITE_MST.rd(addr, read_data);

                                  if((read_data & mask)== (exp_read_data & mask))
                                  begin
                                    $display("@%10t : [TB_TOP write_read_check] : Data Match Read data= %0h expected data = %0h for Addr =%0d",$time,(read_data & mask),(exp_read_data & mask),addr );
                                    total_errors <= total_errors;
                                end
                                else
                                begin
                                  $display("@%10t : [TB_TOP write_read_check] : ERROR: Data Mismatch Read data= %0h expected data = %0h for Addr =%0d",$time,(read_data & mask),(exp_read_data & mask),addr );
                                  total_errors <= total_errors+ 1;
                              end
                            end

                          endtask

                          //=================================================
                          // TASK TO CHECK THE DEFAULT DATA OF REGISTER
                          //=================================================
                          task default_check;
                            input integer addr;
                            input integer default_data;
                            input integer mask;

                            integer read_data;
                            begin
                              AXI4LITE_MST.rd(addr, read_data);

                              if((read_data & mask)== default_data)
                              begin
                                $display("@%10t : [TB_TOP default_check] : Data Match Read data= %0h default data = %0h for Addr =%0d",$time,read_data,default_data,addr );
                                total_errors <= total_errors;
                            end
                            else
                            begin
                              $display("@%10t : [TB_TOP default_check] : ERROR: Data Mismatch Read data= %0h default data = %0h for Addr =%0d",$time,read_data,default_data,addr );
                              total_errors <= total_errors+ 1;
                          end
                        end

                      endtask

                      //=============================================================
                      // TASK TO CHECK THE DATA READ FROM REGISTER WITH EXPECTED DATA
                      //=============================================================
                      task reg_read_check;
                        input integer addr;
                        input integer exp_data;
                        input integer mask;

                        integer read_data;
                        begin
                          AXI4LITE_MST.rd(addr, read_data);

                          if((read_data & mask)== exp_data)
                          begin
                            $display("@%10t : [TB_TOP reg_read_check] : Data Match Read data= %0h Exp data = %0h for Addr =%0d",$time,read_data,exp_data,addr );
                            total_errors <= total_errors;
                        end
                        else
                        begin
                          $display("@%10t : [TB_TOP reg_read_check] : ERROR: Data Mismatch Read data= %0h Exp data = %0h for Addr =%0d",$time,read_data,exp_data,addr );
                          total_errors <= total_errors+ 1;
                      end
                    end
                  endtask

                  task default_check_all;
                    reg [31:0] REG_ADDR;
                    reg [31:0] DEFAULT_VALUE;
                    reg [31:0] MASK;
                    reg  DEFAULT_FLAG;
                    reg  RD_ONLY_FLAG;
                    reg  RD_WR_FLAG;
                    reg [31:0] temp_data;
                    integer reg_cnt;

                    begin
                      for ( reg_cnt = 1;reg_cnt<=`REG_NO ;reg_cnt=reg_cnt+1)
                      begin
                        REG_ADDR      = reg_mem[reg_cnt][98:67];
                        DEFAULT_VALUE = reg_mem[reg_cnt][66:35];
                        MASK          = reg_mem[reg_cnt][34:3];
                        DEFAULT_FLAG  = reg_mem[reg_cnt][2];
                        RD_ONLY_FLAG  = reg_mem[reg_cnt][1];
                        RD_WR_FLAG  = reg_mem[reg_cnt][0];
                        if(DEFAULT_FLAG == 1'h1)   //Check for the default flag
                          default_check(REG_ADDR,DEFAULT_VALUE,MASK );
                        end
                      end    
                    endtask

                    task read_only_check_all;
                      reg [31:0] REG_ADDR;
                      reg [31:0] DEFAULT_VALUE;
                      reg [31:0] MASK;
                      reg  DEFAULT_FLAG;
                      reg  RD_ONLY_FLAG;
                      reg  RD_WR_FLAG;
                      reg [31:0] temp_data;
                      integer reg_cnt;
                      begin
                        for ( reg_cnt = 1;reg_cnt<=`REG_NO ;reg_cnt=reg_cnt+1)
                        begin
                          REG_ADDR      = reg_mem[reg_cnt][98:67];
                          DEFAULT_VALUE = reg_mem[reg_cnt][66:35];
                          MASK          = reg_mem[reg_cnt][34:3];
                          DEFAULT_FLAG  = reg_mem[reg_cnt][2];
                          RD_ONLY_FLAG  = reg_mem[reg_cnt][1];
                          RD_WR_FLAG  = reg_mem[reg_cnt][0];
                          if(RD_ONLY_FLAG == 1'h1)
                            write_read_check(REG_ADDR,32'hFFFFFFFF,DEFAULT_VALUE,MASK );
                        end
                      end
                    endtask

                    task write_read_check_all;
                      reg [31:0] REG_ADDR;
                      reg [31:0] DEFAULT_VALUE;
                      reg [31:0] MASK;
                      reg  DEFAULT_FLAG;
                      reg  RD_ONLY_FLAG;
                      reg  RD_WR_FLAG;
                      reg [31:0] temp_data;
                      integer reg_cnt;
                      begin
                        for ( reg_cnt = 1;reg_cnt<=`REG_NO ;reg_cnt=reg_cnt+1)
                        begin
                          REG_ADDR      = reg_mem[reg_cnt][98:67];
                          DEFAULT_VALUE = reg_mem[reg_cnt][66:35];
                          MASK          = reg_mem[reg_cnt][34:3];
                          DEFAULT_FLAG  = reg_mem[reg_cnt][2];
                          RD_ONLY_FLAG  = reg_mem[reg_cnt][1];
                          RD_WR_FLAG  = reg_mem[reg_cnt][0];
                          if(RD_WR_FLAG == 1'h1)
                          begin
                            write_read_check(REG_ADDR,32'hAAAAAAAA,32'hAAAAAAAA,MASK );
                            write_read_check(REG_ADDR,32'h55555555,32'h55555555,MASK );
                            write_read_check(REG_ADDR,32'h00000000,32'h00000000,MASK );
                            write_read_check(REG_ADDR,32'hFFFFFFFF,32'hFFFFFFFF,MASK );
                          end
                        end
                      end
                    endtask

                    task write_all_reg;
                      input [31:0] data;
                      reg [31:0] REG_ADDR;
                      reg [31:0] DEFAULT_VALUE;
                      reg [31:0] MASK;
                      reg  DEFAULT_FLAG;
                      reg  RD_ONLY_FLAG;
                      reg  RD_WR_FLAG;
                      reg [31:0] temp_data;
                      integer reg_cnt;
                      begin
                        for ( reg_cnt = 1;reg_cnt<=`REG_NO ;reg_cnt=reg_cnt+1)
                        begin
                          REG_ADDR      = reg_mem[reg_cnt][98:67];
                          DEFAULT_VALUE = reg_mem[reg_cnt][66:35];
                          MASK          = reg_mem[reg_cnt][34:3];
                          DEFAULT_FLAG  = reg_mem[reg_cnt][2];
                          RD_ONLY_FLAG  = reg_mem[reg_cnt][1];
                          RD_WR_FLAG  = reg_mem[reg_cnt][0];
                          AXI4LITE_MST.wr(REG_ADDR, data);
                        end
                      end
                    endtask

                    function integer get_index;
                      input [50*8:0] var_name;
                      integer index_cnt;
                      reg match;
                      begin
                        index_cnt = 0;
                        match = 0;
                        while((match==0)&&(index_cnt <= `REG_NO))
                      begin
                        index_cnt = index_cnt + 1;
                        if(reg_mem[index_cnt][50*8+100 : 99] == var_name) match = 1;
                        else match = 0;
                      end
                    if (match) get_index = index_cnt;
                    else get_index = 0;
                  end
              endfunction

              task reg_wr;
                input [50*8:0] var_name;
                input [31:0] data;
                integer temp_index;
                begin
                  temp_index = get_index(var_name);
                  if(temp_index == 0)
                  begin
                    $display("ERROR : %10s is not a valid register name", var_name);
                    total_errors = total_errors + 1;
                  end
                  else
                  begin
                    $display("\tWriting to %10s", var_name);
                    AXI4LITE_MST.wr(reg_mem[temp_index][98:67], data);
                  end
                end
              endtask

              task reg_rd;
                input [50*8:0] var_name;
                output [31:0] data;
                integer temp_index;
                begin
                  temp_index = get_index(var_name);
                  if(temp_index == 0)
                  begin
                    $display("ERROR : %10s is not a valid register name", var_name);
                    total_errors = total_errors + 1;
                  end
                  else
                  begin
                    $display("\tReading from %10s", var_name);
                    AXI4LITE_MST.rd(reg_mem[temp_index][98:67], data);
                  end
                end
              endtask

              event   wait_for_irq_non_block_trigger_evt;
              event   wait_for_irq_non_block_end_evt;
              reg     wait_for_irq_ok = 0;
              reg     wait_for_irq_non_block_en = 0;
              integer wait_for_irq_non_block_timeout = 100000;

              task automatic wait_for_irq;
                input [31:0] timeout_value;
                integer timeout_ctr;
                begin
                  $display("@%10t : Wait for IRQ_W started ...",$time);
                  timeout_ctr = timeout_value;
                wait_for_irq_ok = 0;
                fork
                  begin : wait_for_irq_to_assert
                    wait(irq_w == 1);
                    $display("@%10t : Wait for IRQ_W done. IRQ_W asserted!",$time);
                    wait_for_irq_ok = 1;
                  disable  wait_for_irq_timer;
                end
                begin : wait_for_irq_timer
                  while(timeout_ctr > 0)
                begin
                  wait_cycle(1);
                  timeout_ctr = timeout_ctr - 1;
                end
                $display("@%10t : ERROR! Wait for IRQ_W timed out!",$time);
                wait_for_irq_ok = 0;
              total_errors = total_errors + 1;
              disable wait_for_irq_to_assert;
            end
          join
        end
      endtask

      always @(wait_for_irq_non_block_trigger_evt)
      begin
        wait_for_irq(wait_for_irq_non_block_timeout);
        -> wait_for_irq_non_block_end_evt;
      end

      task wait_for_irq_non_block;
        input [31:0] timeout_value;
        begin
          wait_for_irq_non_block_timeout = timeout_value;
          -> wait_for_irq_non_block_trigger_evt;
        end
      endtask

      task all_clock_off;
        begin
          EOS = 1;
          EOS_AXI = 1;
          EOS_VIDEO = 1;
        end
      endtask

      task all_clock_on;
        begin
          EOS = 0;
          EOS_AXI = 0;
          EOS_VIDEO = 0;
        end
      endtask

      task video_clock_off;
        begin		             
        EOS_VIDEO = 1;
      end		
    endtask

    task video_clock_on;
      begin		             
      EOS_VIDEO = 0;
    end		
  endtask

  task axi_clock_off;
    begin		             
    EOS_AXI = 1;
  end		
endtask

task axi_clock_on;
  begin		             
  EOS_AXI = 0;
end		
  endtask

  task reset_axi;
    input integer reset_length;
    begin
      tb_sclr_axi = 1'b1;
      $display("@%10t : TB_TOP : AXI4LITE RESET  ASSERTED!", $time);
      wait_cycle(reset_length);
      tb_sclr_axi = 1'b0;
      $display("@%10t : TB_TOP : AXI4LITE RESET  DEASSERTED!", $time);
      wait_cycle(1);
    end
  endtask

  task reset_video;
    input integer reset_length;
    begin
      tb_sclr     = 1'b1;
      $display("@%10t : TB_TOP : AXI-STREAM RESET  ASSERTED!", $time);
      wait_cycle(reset_length);
      tb_sclr     = 1'b0;
      $display("@%10t : TB_TOP : AXI-STREAM RESET  DEASSERTED!", $time);
      wait_cycle(1);
    end
  endtask


  task reg_wr_check_resp;
    input [50*8:0] var_name;
    input [31:0] data;
    input [1:0] resp;
    integer temp_index;
    integer temp_resp;
    begin
      temp_index = get_index(var_name);
      if(temp_index == 0)
      begin
        $display("ERROR : %10s is not a valid register name", var_name);
        total_errors = total_errors + 1;
      end
      else
      begin
        $display("\tWriting to %10s", var_name);
        AXI4LITE_MST.wr_get_resp(reg_mem[temp_index][98:67], data, temp_resp);
        if(temp_resp != resp)
        begin
          $display("ERROR : Unexpected Write Response [EXPECTED : %2d , ACTUAL : %2d]", resp, temp_resp);
          total_errors = total_errors + 1;
        end
      end
    end
  endtask

  task reg_rd_check_resp;
    input [50*8:0] var_name;
    output [31:0] data;
    input [1:0] resp;
    integer temp_index;
    integer temp_resp;
    begin
      temp_index = get_index(var_name);
      if(temp_index == 0)
      begin
        $display("ERROR : %10s is not a valid register name", var_name);
        total_errors = total_errors + 1;
      end
      else
      begin
        $display("\tReading from %10s", var_name);
        AXI4LITE_MST.rd_get_resp(reg_mem[temp_index][98:67], data, temp_resp);
        if(temp_resp != resp)
        begin
          $display("ERROR : Unexpected Read Response [EXPECTED : %2d , ACTUAL : %2d]", resp, temp_resp);
          total_errors = total_errors + 1;
        end
      end
    end
  endtask


  //=================================================
  // TASK TO CHECK THE READ/WRITE FEATURE OF REGISTER
  //=================================================
  // variables for file handle operations
  integer cm_file_handler;
  integer cm_file_eof;
  integer cm_isim_eof;
  integer cm_filedata;
  reg [50*8:0] cm_temp;
  reg [50*8:0] cm_regname;
  reg [50*8:0] cm_file = "./testcfg/test_config.cfg";
  reg [50*8:0] cm_stimuli;
  reg [50*8:0] cm_golden;


  task run_conf_mngr;
    begin
      cm_isim_eof = 0;
      cm_file_handler =  $fopen(cm_file, "r");

      if(cm_file_handler == 0)
      begin
        $display("ERROR : %s cannot be opened.... Simulation Stopped", cm_file);
        $finish;
      end

      while(cm_isim_eof == 0)
    begin
      parse_params;     
    end

  end
endtask


task parse_params;
  integer myloop;
  begin
    myloop = 0;
    while(myloop == 0)
  begin
    cm_isim_eof = $feof(cm_file_handler);
    cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
    if(cm_isim_eof != 0) myloop = -1;
    if(cm_temp == "PARAM_BEGIN") myloop = 1;
  end

if(myloop == 1)
begin
  myloop = 0;
  while(myloop == 0)
begin
  cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);

  //-- CHECK FOR COMMENT LINE 
  while (cm_temp[399:392] == "") cm_temp = cm_temp << 8;
  if(cm_temp[399:392] == "#") 
  begin
    while(cm_temp != "\n")
    cm_file_eof = $fscanf(cm_file_handler,"%c", cm_temp);
  end

  else
  begin
    //-- NON-COMMENT LINE... SHIFT BACK CHARACTERS
    while (cm_temp[7:0] == "") cm_temp = cm_temp >> 8;
    case(cm_temp)
      "STIMULI_FILE_NAME" :
      begin
        cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
        if(cm_temp != "=")
        begin
          $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
          $finish;
        end
        cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli);
        while (cm_stimuli[399:392] == "") cm_stimuli = cm_stimuli << 8;
        cm_stimuli = cm_stimuli >> 80;
        cm_stimuli = {"./stimuli/", cm_stimuli[319:0]};
      end
      "GOLDEN_FILE_NAME" :
      begin
        cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
        if(cm_temp != "=")
        begin
          $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
          $finish;
        end
        cm_file_eof = $fscanf(cm_file_handler,"%s", cm_golden);
        while (cm_golden[399:392] == "") cm_golden = cm_golden << 8;
        cm_golden = cm_golden >> 88;
        cm_golden = {"./expected/", cm_golden[311:0]};
      end
      "PARAM_END" :
      begin
        myloop = 1;
      end
      "FRAME_COUNT" :
      begin
        cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
        if(cm_temp != "=")
        begin
          $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
          $finish;
        end
        cm_file_eof = $fscanf(cm_file_handler,"%h", cm_filedata);
      end
      default : 
      begin
        cm_regname = cm_temp;
        cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
        if(cm_temp != "=")
        begin
          $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
          $finish;
        end
        cm_file_eof = $fscanf(cm_file_handler,"%h", cm_filedata);
        reg_wr(cm_regname, cm_filedata);
      end
    endcase
  end
end
cm_isim_eof = $feof(cm_file_handler);

MST.use_file(cm_stimuli);
SLV.use_file(cm_golden);

MST.start;
SLV.start;
wait(s_EOF_w == 1);
MST.stop;
SLV.stop;
wait_cycle(10);

     end
   end
 endtask

 task test_sequence;
   //***************************************************************
   // PLACE YOUR TEST SEQUENCE HERE
   // INCLUDING REGISTER CONFIGURATION, TB COMPONENT CONFIGURATION
   // AND ALL OTHER CONTROLS YOU WANT TO SET 
   // FOR THE WHOLE DURATION OF THE TEST
   //***************************************************************
   `define T_NUM_CHECK_REGS 14 
   `ifdef T_NUM_REG_CHECKS
   `else
     `define T_NUM_REG_CHECKS 0
   `endif



   reg [`C_AXI4LITE_DWIDTH-1:0] irq_stat_data;
   reg [`C_AXI4LITE_DWIDTH-1:0] rd_data;
   reg [`C_AXI4LITE_DWIDTH-1:0] reg_expected_data;
   reg [`C_AXI4LITE_AWIDTH-1:0] reg_addr;
   reg [`C_AXI4LITE_DWIDTH + `C_AXI4LITE_AWIDTH-1:0] reg_mem_data [0:`T_NUM_CHECK_REGS - 1];

   reg [48*8:0] reg_filename;

   integer i;
   integer reg_index;
   begin



       CE_GEN.start;
       reset(100);
       MST.debug_off;
       SLV.debug_off;
       SLV.eol_check_off;
       SLV.sof_check_off;
       SLV.stop_on_error; 

       fork
         begin
           ////////////////////////////////////////////////////////////////////
           // Uncomment the following line to feed the TB .cfg files generated
           ////////////////////////////////////////////////////////////////////
           //run_conf_mngr;




           ////////////////////////////////////////////////////////////////////
           // Example Fixed setup
           ////////////////////////////////////////////////////////////////////
           MST.is_ramp_gen(`C_GEN_F0_VFRAME_SIZE, `C_GEN_HFRAME_SIZE, 2); // Change to is_time_gen
           SLV.is_passive;


             if(`C_DETECT_EN != 0)
             begin
               MST.start;
             end
             if(`C_GENERATE_EN != 0)
             begin
               SLV.start;
             end
             if(`C_DETECT_EN != 0)
             begin  
               wait(m_EOF_w == 1);
               MST.stop;
             end
             else
             begin // Wait for 3 frames of of generated timing
               wait_cycle(`C_GEN_F0_VFRAME_SIZE * `C_GEN_HFRAME_SIZE * 3);
             end

             wait_cycle(100);
             SLV.stop;
             wait_cycle(10);
           end
           begin
             // DO OTHER STUFF HERE
             wait_cycle(1);
             if(`C_DETECT_EN == 0)
             begin
               MST.stop;
             end
             if(`C_GENERATE_EN == 0)
             begin
               SLV.data_check_off;
               SLV.stop;
             end

             //wait (fsync_o[0] == 1'b1);
             //Temp: turn on all IRQs now (Remove this later)
             //AXI4LITE_MST.wr(32'h00c, 32'hffffffff);


             // poll a register
             //AXI4LITE_MST.rd(reg_addr, rd_data);
             //while(rd_data == 0)
             //begin
             //  AXI4LITE_MST.rd(reg_addr, rd_data);
             //end 

           end
         join


       end

     endtask

     //=========================
     // TEST FLOW
     //=========================
     initial 
     begin
       $display("TEST BEGIN :");
       $display("%s", TESTNAME);

       test_sequence; 

       $display("TEST END :");
       $display("%s", TESTNAME);

       test_summary;     

     end 
     endmodule  //END OF TESTBENCH
