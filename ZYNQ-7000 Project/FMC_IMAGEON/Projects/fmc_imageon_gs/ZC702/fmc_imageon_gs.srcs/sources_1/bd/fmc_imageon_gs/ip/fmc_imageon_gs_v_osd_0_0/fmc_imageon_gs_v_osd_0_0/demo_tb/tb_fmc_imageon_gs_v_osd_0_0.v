
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


//******************************************************************************
// Filename    : tb_main.v
// Description : 
//******************************************************************************


`timescale  1 ns / 1 ns

// DEFINES FOR TB COMPONENTS 
`define STIMULI_FILE_1 "./stimuli/video_in0.txt"
`define STIMULI_FILE_2 "./stimuli/video_in1.txt"
`define STIMULI_FILE_3 "./stimuli/video_in2.txt"
`define STIMULI_FILE_4 "./stimuli/video_in3.txt"
`define STIMULI_FILE_5 "./stimuli/video_in4.txt"
`define STIMULI_FILE_6 "./stimuli/video_in5.txt"
`define STIMULI_FILE_7 "./stimuli/video_in6.txt"
`define STIMULI_FILE_8 "./stimuli/video_in7.txt"
`define GOLDEN_FILE_1  "./expected/video_out.txt"

`define C_DUT_LATENCY           0
`define C_AXI4LITE_DWIDTH      32
`define C_AXI4LITE_AWIDTH       9

// DEFINES FOR TOP LEVEL TB 
`define C_CLOCK_PERIOD        100
`define C_RAND_SEED             0 

`define C_TESTNAME "OSD Basic AXI4-Lite Register R/W and AXI4-Stream Bringup Test"
// Core default Defines
`define C_HAS_AXI4_LITE 1

  //`define C_NUM_LAYERS 2
  //`define C_S_AXIS_VIDEO_DATA_WIDTH 8
  //`define C_S_AXIS_VIDEO_FORMAT 0
  //`define C_LAYER0_TYPE 2
  //`define C_LAYER1_TYPE 2
  //`define C_LAYER2_TYPE 0
  //`define C_LAYER3_TYPE 0
  //`define C_LAYER4_TYPE 0
  //`define C_LAYER5_TYPE 0
  //`define C_LAYER6_TYPE 0
  //`define C_LAYER7_TYPE 0

  `define C_HAS_INTC_IF 0

  `define C_SCREEN_WIDTH 1920
  `define C_M_AXIS_VIDEO_WIDTH 1920
  `define C_M_AXIS_VIDEO_HEIGHT 1080

  // Test specific overrides
  `define C_S_AXIS_VIDEO_DATA_WIDTH 8
    `define C_NUM_LAYERS 2
    `define C_LAYER0_TYPE 2
    `define C_LAYER0_IMEM_SIZE 48
    `define C_LAYER0_INS_BOX_EN 1
    `define C_LAYER0_INS_TEXT_EN 1
    `define C_LAYER0_CLUT_SIZE 16
    `define C_LAYER0_CLUT_MEMTYPE 2
    `define C_LAYER0_FONT_NUM_CHARS 96
    `define C_LAYER0_FONT_WIDTH 8
    `define C_LAYER0_FONT_HEIGHT 8
    `define C_LAYER0_FONT_BPP 1
    `define C_LAYER0_FONT_ASCII_OFFSET 32
    `define C_LAYER0_TEXT_NUM_STRINGS 8
    `define C_LAYER0_TEXT_MAX_STRING_LENGTH 32
    `define C_S_AXIS_VIDEO_FORMAT 0
    // Updated TDATA_WIDTHS
    `define C_S_AXIS_VIDEO_TDATA_WIDTH 16
      `define C_M_AXIS_VIDEO_TDATA_WIDTH 16
      `define C_AXIS_MST_TDATA_WIDTH 16
      `define C_AXIS_SLV_TDATA_WIDTH 16
      `define C_LAYER1_TYPE 2
      `define C_LAYER1_IMEM_SIZE 48
      `define C_LAYER1_INS_BOX_EN 1
      `define C_LAYER1_INS_TEXT_EN 1
      `define C_LAYER1_CLUT_SIZE 16
      `define C_LAYER1_CLUT_MEMTYPE 2
      `define C_LAYER1_FONT_NUM_CHARS 96
      `define C_LAYER1_FONT_WIDTH 8
      `define C_LAYER1_FONT_HEIGHT 8
      `define C_LAYER1_FONT_BPP 1
      `define C_LAYER1_FONT_ASCII_OFFSET 32
      `define C_LAYER1_TEXT_NUM_STRINGS 8
      `define C_LAYER1_TEXT_MAX_STRING_LENGTH 32
      `define C_LAYER2_TYPE 0
      `define C_LAYER2_IMEM_SIZE 48
      `define C_LAYER2_INS_BOX_EN 1
      `define C_LAYER2_INS_TEXT_EN 1
      `define C_LAYER2_CLUT_SIZE 16
      `define C_LAYER2_CLUT_MEMTYPE 2
      `define C_LAYER2_FONT_NUM_CHARS 96
      `define C_LAYER2_FONT_WIDTH 8
      `define C_LAYER2_FONT_HEIGHT 8
      `define C_LAYER2_FONT_BPP 1
      `define C_LAYER2_FONT_ASCII_OFFSET 32
      `define C_LAYER2_TEXT_NUM_STRINGS 8
      `define C_LAYER2_TEXT_MAX_STRING_LENGTH 32
      `define C_LAYER3_TYPE 0
      `define C_LAYER3_IMEM_SIZE 48
      `define C_LAYER3_INS_BOX_EN 1
      `define C_LAYER3_INS_TEXT_EN 1
      `define C_LAYER3_CLUT_SIZE 16
      `define C_LAYER3_CLUT_MEMTYPE 2
      `define C_LAYER3_FONT_NUM_CHARS 96
      `define C_LAYER3_FONT_WIDTH 8
      `define C_LAYER3_FONT_HEIGHT 8
      `define C_LAYER3_FONT_BPP 1
      `define C_LAYER3_FONT_ASCII_OFFSET 32
      `define C_LAYER3_TEXT_NUM_STRINGS 8
      `define C_LAYER3_TEXT_MAX_STRING_LENGTH 32
      `define C_LAYER4_TYPE 0
      `define C_LAYER4_IMEM_SIZE 48
      `define C_LAYER4_INS_BOX_EN 1
      `define C_LAYER4_INS_TEXT_EN 1
      `define C_LAYER4_CLUT_SIZE 16
      `define C_LAYER4_CLUT_MEMTYPE 2
      `define C_LAYER4_FONT_NUM_CHARS 96
      `define C_LAYER4_FONT_WIDTH 8
      `define C_LAYER4_FONT_HEIGHT 8
      `define C_LAYER4_FONT_BPP 1
      `define C_LAYER4_FONT_ASCII_OFFSET 32
      `define C_LAYER4_TEXT_NUM_STRINGS 8
      `define C_LAYER4_TEXT_MAX_STRING_LENGTH 32
      `define C_LAYER5_TYPE 0
      `define C_LAYER5_IMEM_SIZE 48
      `define C_LAYER5_INS_BOX_EN 1
      `define C_LAYER5_INS_TEXT_EN 1
      `define C_LAYER5_CLUT_SIZE 16
      `define C_LAYER5_CLUT_MEMTYPE 2
      `define C_LAYER5_FONT_NUM_CHARS 96
      `define C_LAYER5_FONT_WIDTH 8
      `define C_LAYER5_FONT_HEIGHT 8
      `define C_LAYER5_FONT_BPP 1
      `define C_LAYER5_FONT_ASCII_OFFSET 32
      `define C_LAYER5_TEXT_NUM_STRINGS 8
      `define C_LAYER5_TEXT_MAX_STRING_LENGTH 32
      `define C_LAYER6_TYPE 0
      `define C_LAYER6_IMEM_SIZE 48
      `define C_LAYER6_INS_BOX_EN 1
      `define C_LAYER6_INS_TEXT_EN 1
      `define C_LAYER6_CLUT_SIZE 16
      `define C_LAYER6_CLUT_MEMTYPE 2
      `define C_LAYER6_FONT_NUM_CHARS 96
      `define C_LAYER6_FONT_WIDTH 8
      `define C_LAYER6_FONT_HEIGHT 8
      `define C_LAYER6_FONT_BPP 1
      `define C_LAYER6_FONT_ASCII_OFFSET 32
      `define C_LAYER6_TEXT_NUM_STRINGS 8
      `define C_LAYER6_TEXT_MAX_STRING_LENGTH 32
      `define C_LAYER7_TYPE 0
      `define C_LAYER7_IMEM_SIZE 48
      `define C_LAYER7_INS_BOX_EN 1
      `define C_LAYER7_INS_TEXT_EN 1
      `define C_LAYER7_CLUT_SIZE 16
      `define C_LAYER7_CLUT_MEMTYPE 2
      `define C_LAYER7_FONT_NUM_CHARS 96
      `define C_LAYER7_FONT_WIDTH 8
      `define C_LAYER7_FONT_HEIGHT 8
      `define C_LAYER7_FONT_BPP 1
      `define C_LAYER7_FONT_ASCII_OFFSET 32
      `define C_LAYER7_TEXT_NUM_STRINGS 8
      `define C_LAYER7_TEXT_MAX_STRING_LENGTH 32

      module tb_fmc_imageon_gs_v_osd_0_0;

      parameter TESTNAME = `C_TESTNAME;

      //REG & DRIVERS
      reg  tb_clk;
      reg  tb_sclr;
      reg  tb_sclr_axi;
      wire tb_sclr_n;
      wire tb_ce;
      reg  EOS;
      reg  EOS_AXI;
      reg  EOS_VIDEO;
      integer clock_period   = `C_CLOCK_PERIOD;
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


      //DUT INSTANCE & REGISTER FILE INCLUSION
      // GENR=8, TIME=32, Reserved=24, CORE=38 -> 102
`define REG_NO 38
`define DATA_MASK ((1<<`C_S_AXIS_VIDEO_DATA_WIDTH)-1)
`define ALPHA_MASK ((1<<(1+`C_S_AXIS_VIDEO_DATA_WIDTH))-1)
reg [50*8+100:0]  reg_mem  [1:`REG_NO];



function ltype2mask;
    input l0, l1, l2, l3, l4, l5, l6, l7;
    reg [31:0] result;
  begin
    result = 32'h00000000;
    if(l0 == 1) begin
      result = result | 32'h01010101;
    end
    if(l1 == 1) begin
      result = result | 32'h02020202;
    end
    if(l2 == 1) begin
      result = result | 32'h04040404;
    end
    if(l3 == 1) begin
      result = result | 32'h08080808;
    end
    if(l4 == 1) begin
      result = result | 32'h10101010;
    end
    if(l5 == 1) begin
      result = result | 32'h20202020;
    end
    if(l6 == 1) begin
      result = result | 32'h40404040;
    end
    if(l7 == 1) begin
      result = result | 32'h80808080;
    end

    ltype2mask = result;
  end 
endfunction

initial
begin
  //reg_mem[1] = { REG_NAME, ADDR, DEFAULT_VALUE,  MASK,      DEFAULT_TEST, READ_ONLY, R/W_TEST };
  //----------------------------------------------------------------------------------------------
  // CONTROL Register R/W
  reg_mem[1]  = {"R_CONTROL_00", 32'h00,  32'h00000000, 32'hc0000003,    1'h1 ,     1'h0 ,   1'h0   };
  // STATUS Register R/w                                                        
  reg_mem[2]  = {"R_CONTROL_04", 32'h04,  32'h00000000, 32'hFFFFFFFF,    1'h1 ,     1'h0 ,   1'h0   };
  // ERROR Register R                                                             
  reg_mem[3]  = {"R_CONTROL_08", 32'h08,  32'h00000000, 32'h00000000,    1'h1 ,     1'h0 ,   1'h0   };
  // IRQ_ENABLE Register R/W                                                      
  reg_mem[4]  = {"R_CONTROL_0C", 32'h0C,  32'h00000000, 32'hFFFFFFFF,    1'h1 ,     1'h0 ,   1'h1   };
  // VERSION Register R                                                           
  reg_mem[5]  = {"R_CONTROL_10", 32'h10,  32'h06000001, 32'h00000000,    1'h0 ,     1'h1 ,   1'h0   };


  // ACTIVE_SIZE Register R/W                                                     
  reg_mem[6]  = {"R_TIME1_20", 32'h20,  32'h00000000, 32'h0FFF0FFF,   1'h0 ,     1'h0 ,   1'h1   };
  // TIMING_STATUS Register R                                                     
  reg_mem[7 ] = {"R_TIME1_24", 32'h24,  32'h00000000, 32'hFFFFFFFF,   1'h0 ,     1'h1 ,   1'h0   };
  // ENCODING Register R/W                                                        
  reg_mem[8 ] = {"R_TIME1_28", 32'h28,  32'h00000000, 32'h00000000,   1'h0 ,     1'h1 ,   1'h0   };

// Core - BG COLOR
  reg_mem[9 ] = {"R_CORE_100", 32'h100,  32'h00000200, `DATA_MASK,   1'h0 ,     1'h0 ,   1'h1   };
  reg_mem[10] = {"R_CORE_104", 32'h104,  32'h00000200, `DATA_MASK,   1'h0 ,     1'h0 ,   1'h1   };
  reg_mem[11] = {"R_CORE_108", 32'h108,  32'h00000200, `DATA_MASK,   1'h0 ,     1'h0 ,   1'h1   };
// CORE - LAYER 0 cfg
  reg_mem[12] = {"R_CORE_110", 32'h110,  32'h03ff0002, (`ALPHA_MASK<<16)|32'h00000703, 1'b0 ,     1'h0 , (`C_NUM_LAYERS>0)?1'b1:1'b0};
  reg_mem[13] = {"R_CORE_114", 32'h114,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 , (`C_NUM_LAYERS>0)?1'b1:1'b0};
  reg_mem[14] = {"R_CORE_118", 32'h118,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 , (`C_NUM_LAYERS>0)?1'b1:1'b0};
// CORE - LAYER 1 cfg
  reg_mem[15] = {"R_CORE_120", 32'h120,  32'h03ff0102, (`ALPHA_MASK<<16)|32'h00000703,   1'b0,     1'h0 , (`C_NUM_LAYERS>1)?1'b1:1'b0};
  reg_mem[16] = {"R_CORE_124", 32'h124,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 , (`C_NUM_LAYERS>1)?1'b1:1'b0};
  reg_mem[17] = {"R_CORE_128", 32'h128,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 , (`C_NUM_LAYERS>1)?1'b1:1'b0 };
// CORE - LAYER 2 cfg
  reg_mem[18] = {"R_CORE_130", 32'h130,  32'h00000000, (`ALPHA_MASK<<16)|32'h00000703,   1'b0,     1'h0 ,(`C_NUM_LAYERS>2)?1'b1:1'b0};
  reg_mem[19] = {"R_CORE_134", 32'h134,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>2)?1'b1:1'b0};
  reg_mem[20] = {"R_CORE_138", 32'h138,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>2)?1'b1:1'b0};
// CORE - LAYER 3 cfg
  reg_mem[21] = {"R_CORE_140", 32'h140,  32'h00000000, (`ALPHA_MASK<<16)|32'h00000703,   1'b0,     1'h0 ,(`C_NUM_LAYERS>3)?1'b1:1'b0};
  reg_mem[22] = {"R_CORE_144", 32'h144,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>3)?1'b1:1'b0};
  reg_mem[23] = {"R_CORE_148", 32'h148,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>3)?1'b1:1'b0};
// CORE - LAYER 4 cfg
  reg_mem[24] = {"R_CORE_150", 32'h150,  32'h00000000, (`ALPHA_MASK<<16)|32'h00000703,   1'b0,     1'h0 ,(`C_NUM_LAYERS>4)?1'b1:1'b0};
  reg_mem[25] = {"R_CORE_154", 32'h154,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>4)?1'b1:1'b0};
  reg_mem[26] = {"R_CORE_158", 32'h158,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>4)?1'b1:1'b0};
// CORE - LAYER 5 cfg
  reg_mem[27] = {"R_CORE_160", 32'h160,  32'h00000000, (`ALPHA_MASK<<16)|32'h00000703,   1'b0,     1'h0 ,(`C_NUM_LAYERS>5)?1'b1:1'b0};
  reg_mem[28] = {"R_CORE_164", 32'h164,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>5)?1'b1:1'b0};
  reg_mem[29] = {"R_CORE_168", 32'h168,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>5)?1'b1:1'b0};
// CORE - LAYER 6 cfg
  reg_mem[30] = {"R_CORE_170", 32'h170,  32'h00000000, (`ALPHA_MASK<<16)|32'h00000703,   1'b0,     1'h0 ,(`C_NUM_LAYERS>6)?1'b1:1'b0};
  reg_mem[31] = {"R_CORE_174", 32'h174,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>6)?1'b1:1'b0};
  reg_mem[32] = {"R_CORE_178", 32'h178,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>6)?1'b1:1'b0};
// CORE - LAYER 7 cfg
  reg_mem[33] = {"R_CORE_180", 32'h180,  32'h00000000, (`ALPHA_MASK<<16)|32'h00000703,   1'b0,     1'h0 ,(`C_NUM_LAYERS>7)?1'b1:1'b0};
  reg_mem[34] = {"R_CORE_184", 32'h184,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>7)?1'b1:1'b0};
  reg_mem[35] = {"R_CORE_188", 32'h188,  32'h00000000, 32'h0FFF0FFF,   1'b0,     1'h0 ,(`C_NUM_LAYERS>7)?1'b1:1'b0};
// CORE - GC controller
  reg_mem[36]= {"R_CORE_190", 32'h190,  32'h00000000, 32'h00000707,   1'h1 ,     1'h0 ,   1'h1   };
  reg_mem[37]= {"R_CORE_194", 32'h194,  32'h00000000, 32'h0|ltype2mask(`C_LAYER0_TYPE, `C_LAYER1_TYPE, `C_LAYER2_TYPE, `C_LAYER3_TYPE, `C_LAYER4_TYPE, `C_LAYER5_TYPE, `C_LAYER6_TYPE, `C_LAYER7_TYPE),   1'h1 ,     1'h0 ,   1'h1   };
  reg_mem[38]= {"R_CORE_198", 32'h198,  32'h00000000, 32'hFFFFFFFF,   1'h1 ,     1'h0 ,   1'h1   };
end

      //===============================================================================
      // `include "./src/core_specific/dut_instance.v"
      //===============================================================================

      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m0_video_data_w;
      wire m0_ready_w;
      wire m0_valid_w;
      wire m0_sof_w;
      wire m0_eol_w;
      wire m0_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m0_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m0_tkeep_w;
      wire m0_tdest_w;
      wire m0_tid_w;

      assign m0_video_data_w = m_video_data_w;
      assign m_ready_w       = m0_ready_w;
      assign m0_valid_w      = m_valid_w;
      assign m0_sof_w        = m_sof_w;
      assign m0_eol_w        = m_eol_w;
      assign m0_EOF_w        = m_EOF_w;
      assign m0_tstrb_w      = m_tstrb_w;
      assign m0_tkeep_w      = m_tkeep_w;
      assign m0_tdest_w      = m_tdest_w;
      assign m0_tid_w        = m_tid_w;
      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m1_video_data_w;
      wire m1_ready_w;
      wire m1_valid_w;
      wire m1_sof_w;
      wire m1_eol_w;
      wire m1_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m1_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m1_tkeep_w;
      wire m1_tdest_w;
      wire m1_tid_w;

      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m2_video_data_w;
      wire m2_ready_w;
      wire m2_valid_w;
      wire m2_sof_w;
      wire m2_eol_w;
      wire m2_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m2_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m2_tkeep_w;
      wire m2_tdest_w;
      wire m2_tid_w;
      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m3_video_data_w;
      wire m3_ready_w;
      wire m3_valid_w;
      wire m3_sof_w;
      wire m3_eol_w;
      wire m3_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m3_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m3_tkeep_w;
      wire m3_tdest_w;
      wire m3_tid_w;
      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m4_video_data_w;
      wire m4_ready_w;
      wire m4_valid_w;
      wire m4_sof_w;
      wire m4_eol_w;
      wire m4_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m4_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m4_tkeep_w;
      wire m4_tdest_w;
      wire m4_tid_w;
      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m5_video_data_w;
      wire m5_ready_w;
      wire m5_valid_w;
      wire m5_sof_w;
      wire m5_eol_w;
      wire m5_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m5_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m5_tkeep_w;
      wire m5_tdest_w;
      wire m5_tid_w;
      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m6_video_data_w;
      wire m6_ready_w;
      wire m6_valid_w;
      wire m6_sof_w;
      wire m6_eol_w;
      wire m6_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m6_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m6_tkeep_w;
      wire m6_tdest_w;
      wire m6_tid_w;
      //AXI4-STREAM VIDEO MASTER WIRES
      wire [`C_AXIS_MST_TDATA_WIDTH-1:0] m7_video_data_w;
      wire m7_ready_w;
      wire m7_valid_w;
      wire m7_sof_w;
      wire m7_eol_w;
      wire m7_EOF_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m7_tstrb_w;
      wire [`C_AXIS_MST_TDATA_WIDTH/8-1:0] m7_tkeep_w;
      wire m7_tdest_w;
      wire m7_tid_w;
      //AXI4-STREAM VIDEO MASTER INSTANCE
      axi4s_video_mst 
      #(
        .module_id     ("AXI4-S Video Master 2"),
        .drive_edge    ("fall"),
        .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
      ) MST1 (
        .aclk           (tb_clk),
        .aclken         (tb_ce),
        .aresetn        (tb_sclr_n),
        .tready         (m1_ready_w),
        .tdata          (m1_video_data_w),
        .tvalid         (m1_valid_w),
        .tstrb          (m1_tstrb_w),
        .tkeep          (m1_tkeep_w),
        .tdest          (m1_tdest_w),
        .tid            (m1_tid_w),
        .sof            (m1_sof_w),
        .eol            (m1_eol_w),
        .EOF            (m1_EOF_w)
      );
      //AXI4-STREAM VIDEO MASTER INSTANCE
      axi4s_video_mst 
      #(
        .module_id     ("AXI4-S Video Master 3"),
        .drive_edge    ("fall"),
        .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
      ) MST2 (
        .aclk           (tb_clk),
        .aclken         (tb_ce),
        .aresetn        (tb_sclr_n),
        .tready         (m2_ready_w),
        .tdata          (m2_video_data_w),
        .tvalid         (m2_valid_w),
        .tstrb          (m2_tstrb_w),
        .tkeep          (m2_tkeep_w),
        .tdest          (m2_tdest_w),
        .tid            (m2_tid_w),
        .sof            (m2_sof_w),
        .eol            (m2_eol_w),
        .EOF            (m2_EOF_w)
      );
      //AXI4-STREAM VIDEO MASTER INSTANCE
      axi4s_video_mst 
      #(
        .module_id     ("AXI4-S Video Master 4"),
        .drive_edge    ("fall"),
        .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
      ) MST3 (
        .aclk           (tb_clk),
        .aclken         (tb_ce),
        .aresetn        (tb_sclr_n),
        .tready         (m3_ready_w),
        .tdata          (m3_video_data_w),
        .tvalid         (m3_valid_w),
        .tstrb          (m3_tstrb_w),
        .tkeep          (m3_tkeep_w),
        .tdest          (m3_tdest_w),
        .tid            (m3_tid_w),
        .sof            (m3_sof_w),
        .eol            (m3_eol_w),
        .EOF            (m3_EOF_w)
      );
      //AXI4-STREAM VIDEO MASTER INSTANCE
      axi4s_video_mst 
      #(
        .module_id     ("AXI4-S Video Master 5"),
        .drive_edge    ("fall"),
        .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
      ) MST4 (
        .aclk           (tb_clk),
        .aclken         (tb_ce),
        .aresetn        (tb_sclr_n),
        .tready         (m4_ready_w),
        .tdata          (m4_video_data_w),
        .tvalid         (m4_valid_w),
        .tstrb          (m4_tstrb_w),
        .tkeep          (m4_tkeep_w),
        .tdest          (m4_tdest_w),
        .tid            (m4_tid_w),
        .sof            (m4_sof_w),
        .eol            (m4_eol_w),
        .EOF            (m4_EOF_w)
      );
      //AXI4-STREAM VIDEO MASTER INSTANCE
      axi4s_video_mst 
      #(
        .module_id     ("AXI4-S Video Master 6"),
        .drive_edge    ("fall"),
        .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
      ) MST5 (
        .aclk           (tb_clk),
        .aclken         (tb_ce),
        .aresetn        (tb_sclr_n),
        .tready         (m5_ready_w),
        .tdata          (m5_video_data_w),
        .tvalid         (m5_valid_w),
        .tstrb          (m5_tstrb_w),
        .tkeep          (m5_tkeep_w),
        .tdest          (m5_tdest_w),
        .tid            (m5_tid_w),
        .sof            (m5_sof_w),
        .eol            (m5_eol_w),
        .EOF            (m5_EOF_w)
      );
      //AXI4-STREAM VIDEO MASTER INSTANCE
      axi4s_video_mst 
      #(
        .module_id     ("AXI4-S Video Master 7"),
        .drive_edge    ("fall"),
        .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
      ) MST6 (
        .aclk           (tb_clk),
        .aclken         (tb_ce),
        .aresetn        (tb_sclr_n),
        .tready         (m6_ready_w),
        .tdata          (m6_video_data_w),
        .tvalid         (m6_valid_w),
        .tstrb          (m6_tstrb_w),
        .tkeep          (m6_tkeep_w),
        .tdest          (m6_tdest_w),
        .tid            (m6_tid_w),
        .sof            (m6_sof_w),
        .eol            (m6_eol_w),
        .EOF            (m6_EOF_w)
      );
      //AXI4-STREAM VIDEO MASTER INSTANCE
      axi4s_video_mst 
      #(
        .module_id     ("AXI4-S Video Master 8"),
        .drive_edge    ("fall"),
        .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
      ) MST7 (
        .aclk           (tb_clk),
        .aclken         (tb_ce),
        .aresetn        (tb_sclr_n),
        .tready         (m7_ready_w),
        .tdata          (m7_video_data_w),
        .tvalid         (m7_valid_w),
        .tstrb          (m7_tstrb_w),
        .tkeep          (m7_tkeep_w),
        .tdest          (m7_tdest_w),
        .tid            (m7_tid_w),
        .sof            (m7_sof_w),
        .eol            (m7_eol_w),
        .EOF            (m7_EOF_w)
      );

      wire [63:0] intc_if;

      fmc_imageon_gs_v_osd_0_0 uut 
      (
        .aclk                (tb_clk),
        .aresetn             (tb_sclr_n),
        .aclken              (tb_ce),


            .s_axis_video0_tready(m0_ready_w),
            .s_axis_video0_tdata (m0_video_data_w),
            .s_axis_video0_tvalid(m0_valid_w),
            .s_axis_video0_tlast (m0_eol_w),
            .s_axis_video0_tuser (m0_sof_w),

              .s_axis_video1_tready(m1_ready_w),
              .s_axis_video1_tdata (m1_video_data_w),
              .s_axis_video1_tvalid(m1_valid_w),
              .s_axis_video1_tlast (m1_eol_w),
              .s_axis_video1_tuser (m1_sof_w),


                            .s_axi_aclk          (tb_clk),
                            .s_axi_aresetn       (tb_sclr_n),
                            .s_axi_aclken        (tb_ce),

                            .s_axi_awready  (m_awready_w),
                            .s_axi_awvalid  (m_awvalid_w),
                            .s_axi_awaddr   (m_awaddr_w),
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
                            .s_axi_rvalid   (m_rvalid_w),
                            .s_axi_rdata    (m_rdata_w),
                            .s_axi_rresp    (m_rresp_w),
                            .s_axi_rready   (m_rready_w),

                            .irq                 (irq_w),
                            .m_axis_video_tready (s_ready_w),
                            .m_axis_video_tdata  (s_video_data_w),
                            .m_axis_video_tvalid (s_valid_w),
                            .m_axis_video_tlast  (s_eol_w),
                            .m_axis_video_tuser  (s_sof_w)

                          );

                          //===============================================================================
                          //CE GENERATOR INSTANCE
                          ce_gen CE_GEN
                          (
                            .clk_in         (tb_clk),
                            .sclr_in        (tb_sclr),
                            .ce_out         (tb_ce)
                          );

                          //AXI4-LITE MASTER INSTANCE
                          axi4lite_mst
                          #(
                            .module_id    ("AXI4-LITE MASTER 1"),
                            .drive_edge   ("fall"),
                            .datawidth    (`C_AXI4LITE_DWIDTH),
                            .addrwidth    (`C_AXI4LITE_AWIDTH)
                          ) AXI4LITE_MST (
                            .aclk     (tb_clk),
                            .aclken   (tb_ce),
                            .aresetn  (tb_sclr_n),
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

                          //AXI4-STREAM VIDEO MASTER INSTANCE
                          axi4s_video_mst 
                          #(
                            .module_id     ("AXI-S Video Master 1"),
                            .drive_edge    ("fall"),
                            .datawidth     (`C_AXIS_MST_TDATA_WIDTH)
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
                            .drive_edge    ("fall"),
                            .datawidth     (`C_AXIS_SLV_TDATA_WIDTH),
                            .output_file   (1)
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
                              tb_sclr = 1'b1;
                              $display("@%10t : TB_TOP : SYSTEM RESET  ASSERTED!", $time);
                              wait_cycle(reset_length);
                              tb_sclr = 1'b0;
                              $display("@%10t : TB_TOP : SYSTEM RESET  DEASSERTED!", $time);
                              wait_cycle(1);
                            end
                          endtask

                          //==========================
                          // TESTBENCH CLK GENERATION
                          //==========================
                          initial 
                          begin
                            tb_clk    = 0;
                            tb_sclr	= 0;	
                            tb_sclr_axi	= 0;	
                            EOS	= 0;
                            EOS_AXI	= 0;
                            EOS_VIDEO	= 0;
                            while (!EOS)
                          begin
                            #(clock_period/2);
                            tb_clk = ~tb_clk;
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
                              $display(  "*********************************\n");
                            end
                            EOS = 1;
                            $finish; 
                          end
                        endtask

                        // Description : This module contains common register utility tasks 
                        //
                        // Available user tasks  :
                        // write_read_check     (<addr>, <write_data>,   <exp_data>,  <mask>) 
                        // default_check        (<addr>, <default_data>, <mask>             ) 
                        // reg_read_check       (<addr>, <exp_data>,     <mask>             ) 
                        // default_check_all   
                        // read_only_check_all  
                        // write_read_check_all 
                        // write_all_reg        
                        // reg_wr               (<"REG_NAME">, <data>)
                        // reg_rd               (<"REG_NAME">, <data>)
                        // wait_for_irq           
                        // wait_for_irq_non_block 
                        // 
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
              $display("ERROR : %s is not a valid register name", var_name);
              total_errors = total_errors + 1;
            end
            else
            begin
              $display("\tWriting to %s", var_name);
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
              $display("ERROR : %s is not a valid register name", var_name);
              total_errors = total_errors + 1;
            end
            else
            begin
              $display("\tReading from %s", var_name);
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
       $display("ERROR : %s is not a valid register name", var_name);
       total_errors = total_errors + 1;
     end
     else
     begin
       $display("\tWriting to %s", var_name);
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
       $display("ERROR : %s is not a valid register name", var_name);
       total_errors = total_errors + 1;
     end
     else
     begin
       $display("\tReading from %s", var_name);
       AXI4LITE_MST.rd_get_resp(reg_mem[temp_index][98:67], data, temp_resp);
       if(temp_resp != resp)
       begin
         $display("ERROR : Unexpected Read Response [EXPECTED : %2d , ACTUAL : %2d]", resp, temp_resp);
         total_errors = total_errors + 1;
       end
     end
   end
 endtask


 // Description : This module contains tasks for parsing the register
 //               configuration file & automatically reprogram & start
 //               transmission based on the transaction order in the config
 //               file.
 //
 // Available user tasks  :
 // run_conf_mngrg -> time consuming task w/c starts the parsing & automation.
 //
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
 reg [50*8:0] cm_stimuli1;
 reg [50*8:0] cm_stimuli2;
 reg [50*8:0] cm_stimuli3;
 reg [50*8:0] cm_stimuli4;
 reg [50*8:0] cm_stimuli5;
 reg [50*8:0] cm_stimuli6;
 reg [50*8:0] cm_stimuli7;
 reg [50*8:0] cm_golden;


 task run_conf_mngr;
   integer error;
   begin
     cm_isim_eof = 0;
     cm_file_handler =  $fopen(cm_file, "r");


     $ferror(cm_file_handler, error);
     if (error != 0) $display("\nCannot Open File = %x", error);

     if(cm_file_handler == 0)
     begin
       $display("WARNING : %s cannot be opened.... Simulation Stopped", cm_file);
       //$finish;
     end

     while((cm_isim_eof == 0)&&(cm_file_handler != 0))
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
       "STIMULI1_FILE_NAME" :
       begin
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
         if(cm_temp != "=")
         begin
           $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
           $finish;
         end
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli1);
         while (cm_stimuli1[399:392] == "") cm_stimuli1 = cm_stimuli1 << 8;
         cm_stimuli1 = cm_stimuli1 >> 80;
         cm_stimuli1 = {"./stimuli/", cm_stimuli1[319:0]};
       end
       "STIMULI2_FILE_NAME" :
       begin
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
         if(cm_temp != "=")
         begin
           $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
           $finish;
         end
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli2);
         while (cm_stimuli2[399:392] == "") cm_stimuli2 = cm_stimuli2 << 8;
         cm_stimuli2 = cm_stimuli2 >> 80;
         cm_stimuli2 = {"./stimuli/", cm_stimuli2[319:0]};
       end
       "STIMULI3_FILE_NAME" :
       begin
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
         if(cm_temp != "=")
         begin
           $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
           $finish;
         end
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli3);
         while (cm_stimuli3[399:392] == "") cm_stimuli3 = cm_stimuli3 << 8;
         cm_stimuli3 = cm_stimuli3 >> 80;
         cm_stimuli3 = {"./stimuli/", cm_stimuli3[319:0]};
       end
       "STIMULI4_FILE_NAME" :
       begin
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
         if(cm_temp != "=")
         begin
           $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
           $finish;
         end
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli4);
         while (cm_stimuli4[399:392] == "") cm_stimuli4 = cm_stimuli4 << 8;
         cm_stimuli4 = cm_stimuli4 >> 80;
         cm_stimuli4 = {"./stimuli/", cm_stimuli4[319:0]};
       end
       "STIMULI5_FILE_NAME" :
       begin
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
         if(cm_temp != "=")
         begin
           $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
           $finish;
         end
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli5);
         while (cm_stimuli5[399:392] == "") cm_stimuli5 = cm_stimuli5 << 8;
         cm_stimuli5 = cm_stimuli5 >> 80;
         cm_stimuli5 = {"./stimuli/", cm_stimuli5[319:0]};
       end
       "STIMULI6_FILE_NAME" :
       begin
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
         if(cm_temp != "=")
         begin
           $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
           $finish;
         end
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli6);
         while (cm_stimuli6[399:392] == "") cm_stimuli6 = cm_stimuli6 << 8;
         cm_stimuli6 = cm_stimuli6 >> 80;
         cm_stimuli6 = {"./stimuli/", cm_stimuli6[319:0]};
       end
       "STIMULI7_FILE_NAME" :
       begin
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_temp);
         if(cm_temp != "=")
         begin
           $display("FATAL ERROR : Incorrect Syntax in %s", cm_file);
           $finish;
         end
         cm_file_eof = $fscanf(cm_file_handler,"%s", cm_stimuli7);
         while (cm_stimuli7[399:392] == "") cm_stimuli7 = cm_stimuli7 << 8;
         cm_stimuli7 = cm_stimuli7 >> 80;
         cm_stimuli7 = {"./stimuli/", cm_stimuli7[319:0]};
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
 MST1.use_file(cm_stimuli1);
 MST2.use_file(cm_stimuli2);
 MST3.use_file(cm_stimuli3);
 MST4.use_file(cm_stimuli4);
 MST5.use_file(cm_stimuli5);
 MST6.use_file(cm_stimuli6);
 MST7.use_file(cm_stimuli7);
 SLV.use_file(cm_golden);

 if ((`C_NUM_LAYERS > 0) && (`C_LAYER0_TYPE==2)) begin
   MST.start;
 end
 if ((`C_NUM_LAYERS > 1) && (`C_LAYER1_TYPE==2)) begin
   MST1.start;
 end
 if ((`C_NUM_LAYERS > 2) && (`C_LAYER2_TYPE==2)) begin
   MST2.start;
 end
 if ((`C_NUM_LAYERS > 3) && (`C_LAYER3_TYPE==2)) begin
   MST3.start;
 end
 if ((`C_NUM_LAYERS > 4) && (`C_LAYER4_TYPE==2)) begin
   MST4.start;
 end
 if ((`C_NUM_LAYERS > 5) && (`C_LAYER5_TYPE==2)) begin
   MST5.start;
 end
 if ((`C_NUM_LAYERS > 6) && (`C_LAYER6_TYPE==2)) begin
   MST6.start;
 end
 if ((`C_NUM_LAYERS > 7) && (`C_LAYER7_TYPE==2)) begin
   MST7.start;
 end
 SLV.start;
 wait(s_EOF_w == 1);
 //MST.stop;
 if ((`C_NUM_LAYERS > 0) && (`C_LAYER0_TYPE==2)) begin
   MST.stop;
 end
 if ((`C_NUM_LAYERS > 1) && (`C_LAYER1_TYPE==2)) begin
   MST1.stop;
 end
 if ((`C_NUM_LAYERS > 2) && (`C_LAYER2_TYPE==2)) begin
   MST2.stop;
 end
 if ((`C_NUM_LAYERS > 3) && (`C_LAYER3_TYPE==2)) begin
   MST3.stop;
 end
 if ((`C_NUM_LAYERS > 4) && (`C_LAYER4_TYPE==2)) begin
   MST4.stop;
 end
 if ((`C_NUM_LAYERS > 5) && (`C_LAYER5_TYPE==2)) begin
   MST5.stop;
 end
 if ((`C_NUM_LAYERS > 6) && (`C_LAYER6_TYPE==2)) begin
   MST6.stop;
 end
 if ((`C_NUM_LAYERS > 7) && (`C_LAYER7_TYPE==2)) begin
   MST7.stop;
 end



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
   integer screen_width;
   integer screen_height;
   begin

     //***************************************************************
     // START OF TEST SEQUENCE
     //***************************************************************
     // REGISTER CONFIGURATION, TB COMPONENT CONFIGURATION
     // AND ALL OTHER CONTROLS YOU WANT TO SET FOR THE TEST
     //***************************************************************

     //==============================================
     // CHECKING THE DEFAULT VALUE AT POWERUP OF CORE
     //==============================================
     $display("==== TEST_REG_DEF_PWR_UP : BEGIN ==== \n");
     CE_GEN.start;
     wait_cycle(10); //wait arbitrary cycles
     default_check_all;
     wait_cycle(10);
     $display("==== TEST_REG_DEF_PWR_UP : END ==== \n");


     //=============================================================
     // CHECKING THE DEFAULT VALUE AFTER HARD RESET (Idle Condition)
     //=============================================================
     $display("==== TEST_REG_HW_RESET_IDLE : BEGIN ==== \n");
     reset(100);    
     CE_GEN.start;
     wait_cycle(10);
     default_check_all;
     wait_cycle(10);
     $display("==== TEST_REG_HW_RESET_IDLE : END ==== \n");


     //=============================================================
     // CHECKING THE DEFAULT VALUE AFTER HARD RESET (Busy Condition)
     //=============================================================
     $display("==== TEST_REG_HW_RESET_BUSY : BEGIN ==== \n");
     //configure MST & SLV
     MST.debug_on;
     SLV.debug_on;
     //MST.use_file("./stimuli/test_common_reg_stimuli.txt"); //This will set master to look for the given file path in run dir
     //SLV.use_file("./expected/test_common_reg_golden.txt"); //This will set slave to look for the given file path in run dir
     SLV.data_check_off; 
     //start AXI4S Video transaction
     $display("\nSTART OF TRANSACTION \n");
     //MST.start;
     //SLV.start;
     wait_cycle(50);
     reset(100);    
     CE_GEN.start;
     wait_cycle(10);
     default_check_all;
     wait_cycle(10);
     $display("==== TEST_REG_HW_RESET_BUSY : END ==== \n");


     //=============================================================
     // CHECKING THE DEFAULT VALUE AFTER S/W RESET (Idle Condition)
     //=============================================================
     $display("==== TEST_REG_SW_RESET_IDLE : BEGIN ==== \n");
     reset(100);
     CE_GEN.start;
     wait_cycle(50);

     write_all_reg(32'h000F0000);
     // Asserted Bit[31] of CONTROL register for S/W RESET
     $display("==== ASSERTING S/W RESET ==== \n");
     AXI4LITE_MST.wr(32'h00, 32'h80000000);

     wait_cycle(10); //wait arbitrary cycles
     default_check_all;
     $display("==== TEST_REG_SW_RESET_IDLE : END ==== \n");


     //=============================================================
     // CHECKING THE DEFAULT VALUE AFTER S/W RESET (Busy Condition)
     //=============================================================
     $display("==== TEST_REG_SW_RESET_BUSY : BEGIN ==== \n");
     //configure MST & SLV
     MST.debug_on;            //Turn debug messages ON
     SLV.debug_on;            //Turn debug messages ON
     //MST.use_file("./stimuli/test_common_reg_stimuli.txt"); //This will set master to look for the given file path in run dir
     //SLV.use_file("./expected/test_common_reg_golden.txt"); //This will set slave to look for the given file path in run dir
     SLV.data_check_off; 

     $display("\nSTART OF TRANSACTION \n");
     //CE_GEN.start;
     //MST.start;
     //SLV.start;

     wait_cycle(20); //wait arbitrary cycles

     // Asserted Bit[31] of CONTROL register for S/W RESET
     AXI4LITE_MST.wr(32'h00, 32'h80000000);

     MST.stop;
     SLV.stop; 
     wait_cycle(10);
     default_check_all;
     wait_cycle(10);
     $display("==== TEST_REG_SW_RESET_BUSY : END ==== \n");


     //=============================================================
     // CHECKING THE READ ONLY REGISTERS
     //=============================================================
     $display("==== TEST_REG_READ_ONLY : BEGIN ==== \n");
     reset(100);
     CE_GEN.start;
     wait_cycle(10);
     read_only_check_all;
     wait_cycle(10);
     $display("==== TEST_REG_READ_ONLY : END ==== \n");


     //=============================================================
     // CHECKING THE READ-WRITE REGISTERS
     //=============================================================
     $display("==== TEST_REG_WRITE_READ : BEGIN ==== \n");
     reset(100);    
     wait_cycle(10);
     CE_GEN.start;
     wait_cycle(10);
     write_read_check_all;
     $display("==== TEST_REG_WRITE_READ : END ==== \n");

     //**************************************************************************
     // END OF TEST SEQUENCE 1
     //**************************************************************************

     CE_GEN.start;
     reset(100);
     MST.debug_off;
     //MST.set_sof_phase(176);
     MST1.debug_off;
     //MST1.debug_on;
     //MST1.set_sof_phase(1383);
     //MST1.set_eol_phase(3);
     MST2.debug_off;
     MST3.debug_off;
     MST4.debug_off;
     MST5.debug_off;
     MST6.debug_off;
     MST7.debug_off;
     SLV.debug_off;
     SLV.stop_on_error; 

     fork
       begin
         ////////////////////////////////////////////////////////////////////
         // Uncomment the following line to feed the TB .cfg files generated
         // by the C model
         //run_conf_mngr;
         ////////////////////////////////////////////////////////////////////
         //

         ////////////////////////////////////////////////////////////////////
         // Example Fixed setup
         ////////////////////////////////////////////////////////////////////
         if(`C_M_AXIS_VIDEO_HEIGHT==0) begin
           screen_height = 80;
         end
         else begin
           screen_height = `C_M_AXIS_VIDEO_HEIGHT;
         end
         if(`C_M_AXIS_VIDEO_WIDTH==0) begin
           //screen_width = `C_SCREEN_WIDTH;
           screen_width = 80;
         end
         else begin
           screen_width = `C_M_AXIS_VIDEO_WIDTH;
         end

         MST.is_ramp_gen(screen_height, screen_width, 2);
         MST1.is_ramp_gen(screen_height, screen_width, 2);
         MST2.is_ramp_gen(screen_height, screen_width, 2);
         MST3.is_ramp_gen(screen_height, screen_width, 2);
         MST4.is_ramp_gen(screen_height, screen_width, 2);
         MST5.is_ramp_gen(screen_height, screen_width, 2);
         MST6.is_ramp_gen(screen_height, screen_width, 2);
         MST7.is_ramp_gen(screen_height, screen_width, 2);
         SLV.is_passive;


         AXI4LITE_MST.wr(32'h020, (screen_height<<16)|screen_width);
         AXI4LITE_MST.wr(32'h100, 32'h00000010); // BG Color 0
         AXI4LITE_MST.wr(32'h104, 32'h00000030); // BG Color 1
         AXI4LITE_MST.wr(32'h108, 32'h00000080); // BG Color 2

         AXI4LITE_MST.wr(32'h110, 32'h00800003); // Layer 0 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h114, 32'h00000000); // Layer 0 position
         AXI4LITE_MST.wr(32'h118, (screen_height<<16)|screen_width); // Layer 0 Size

         AXI4LITE_MST.wr(32'h120, 32'h00800103); // Layer 1 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h124, 32'h00000000); // Layer 1 position
         AXI4LITE_MST.wr(32'h128, (screen_height<<16)|screen_width); // Layer 1 Size

         AXI4LITE_MST.wr(32'h130, 32'h00800203); // Layer 2 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h134, 32'h00000000); // Layer 2 position
         AXI4LITE_MST.wr(32'h138, (screen_height<<16)|screen_width); // Layer 2 Size

         AXI4LITE_MST.wr(32'h140, 32'h00800303); // Layer 3 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h144, 32'h00000000); // Layer 3 position
         AXI4LITE_MST.wr(32'h148, (screen_height<<16)|screen_width); // Layer 3 Size

         AXI4LITE_MST.wr(32'h150, 32'h00800403); // Layer 4 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h154, 32'h00000000); // Layer 4 position
         AXI4LITE_MST.wr(32'h158, (screen_height<<16)|screen_width); // Layer 4 Size

         AXI4LITE_MST.wr(32'h160, 32'h00800503); // Layer 5 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h164, 32'h00000000); // Layer 5 position
         AXI4LITE_MST.wr(32'h168, (screen_height<<16)|screen_width); // Layer 5 Size

         AXI4LITE_MST.wr(32'h170, 32'h00800603); // Layer 6 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h174, 32'h00000000); // Layer 6 position
         AXI4LITE_MST.wr(32'h178, (screen_height<<16)|screen_width); // Layer 6 Size

         AXI4LITE_MST.wr(32'h180, 32'h00800703); // Layer 7 Control (Alpha, priority)
         AXI4LITE_MST.wr(32'h184, 32'h00000000); // Layer 7 position
         AXI4LITE_MST.wr(32'h188, (screen_height<<16)|screen_width); // Layer 7 Size

         AXI4LITE_MST.wr(32'h000, 3); // Enable Core and reg update


         if ((`C_NUM_LAYERS > 0) && (`C_LAYER0_TYPE==2)) begin
           MST.start;
         end
         if ((`C_NUM_LAYERS > 1) && (`C_LAYER1_TYPE==2)) begin
           MST1.start;
         end
         if ((`C_NUM_LAYERS > 2) && (`C_LAYER2_TYPE==2)) begin
           MST2.start;
         end
         if ((`C_NUM_LAYERS > 3) && (`C_LAYER3_TYPE==2)) begin
           MST3.start;
         end
         if ((`C_NUM_LAYERS > 4) && (`C_LAYER4_TYPE==2)) begin
           MST4.start;
         end
         if ((`C_NUM_LAYERS > 5) && (`C_LAYER5_TYPE==2)) begin
           MST5.start;
         end
         if ((`C_NUM_LAYERS > 6) && (`C_LAYER6_TYPE==2)) begin
           MST6.start;
         end
         if ((`C_NUM_LAYERS > 7) && (`C_LAYER7_TYPE==2)) begin
           MST7.start;
         end
         SLV.start;

         //MST.stop;
         if ((`C_NUM_LAYERS > 0) && (`C_LAYER0_TYPE==2)) begin
           wait(m_EOF_w == 1);
           MST.stop;
         end
         if ((`C_NUM_LAYERS > 1) && (`C_LAYER1_TYPE==2)) begin
           wait(m1_EOF_w == 1);
           MST1.stop;
         end
         if ((`C_NUM_LAYERS > 2) && (`C_LAYER2_TYPE==2)) begin
           wait(m2_EOF_w == 1);
           MST2.stop;
         end
         if ((`C_NUM_LAYERS > 3) && (`C_LAYER3_TYPE==2)) begin
           wait(m3_EOF_w == 1);
           MST3.stop;
         end
         if ((`C_NUM_LAYERS > 4) && (`C_LAYER4_TYPE==2)) begin
           wait(m4_EOF_w == 1);
           MST4.stop;
         end
         if ((`C_NUM_LAYERS > 5) && (`C_LAYER5_TYPE==2)) begin
           wait(m5_EOF_w == 1);
           MST5.stop;
         end
         if ((`C_NUM_LAYERS > 6) && (`C_LAYER6_TYPE==2)) begin
           wait(m6_EOF_w == 1);
           MST6.stop;
         end
         if ((`C_NUM_LAYERS > 7) && (`C_LAYER7_TYPE==2)) begin
           wait(m7_EOF_w == 1);
           MST7.stop;
         end
         wait_cycle(100);
         SLV.stop;
         wait_cycle(10);

       end
       begin
         // DO OTHER STUFF HERE
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
