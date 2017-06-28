

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

// Module Description : top level testbench 


`timescale 1ns/10ps

// DEFINES FOR TOP LEVEL TB 
`define C_RAND_SEED            0
`define C_CLOCK_PERIOD         13
`define TB_ACTIVE_EDGE "rise"
`define TB_DRIVE_DELAY 2
`define TB_OUTPUT_FILE 0
`define C_CLOCK_PERIOD_AXI     10
`define C_S_AXI_CLK_FREQ_HZ    100000000
`define C_ACTIVE_COLS          1920
`define C_ACTIVE_ROWS          1080
`define C_ACTIVE_SIZE          (`C_ACTIVE_ROWS<<16)+ `C_ACTIVE_COLS
`define C_HAS_INTC_IF          0
`define C_HAS_AXI4_LITE        0
`define C_AXI4LITE_AWIDTH      9
`define C_AXI4LITE_DWIDTH      32
`define C_AXIS_MST_TDATA_WIDTH 24
`define C_AXIS_SLV_TDATA_WIDTH 16

`define TB_STIMULI_TYPE           0  // 0 = RAMP DATA, 1 = CMODEL GENERATED FILE
`define STIMULI_FILE_NAME       "EMPTY"

 module  tb_fmc_imageon_gs_v_cresample_0_0;
 
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
 integer clock_period     = `C_CLOCK_PERIOD;
 integer clock_period_axi = `C_CLOCK_PERIOD_AXI;
 integer rseed            = `C_RAND_SEED;
 integer total_errors     = 0;

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
 //INTC_IF WIRE
 wire [8:0] intc_if_w;

  // uut INSTANCE
  fmc_imageon_gs_v_cresample_0_0 uut
  (
     .aclk                (tb_clk),
     .aresetn             (tb_sclr_n),
     .aclken              (tb_ce),



     .s_axis_video_tready      (m_ready_w),
     .s_axis_video_tdata       (m_video_data_w),
     .s_axis_video_tvalid      (m_valid_w),
     .s_axis_video_tlast       (m_eol_w),
     .s_axis_video_tuser       (m_sof_w),
     .m_axis_video_tready      (s_ready_w),
     .m_axis_video_tdata       (s_video_data_w),
     .m_axis_video_tvalid      (s_valid_w),
     .m_axis_video_tlast       (s_eol_w),
     .m_axis_video_tuser       (s_sof_w)
 );


 //CE (clock enable) GENERATOR INSTANCE
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
    .ce_out         ( )
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

 assign tb_sclr_n     = ~tb_sclr;
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
 initial 
 begin
      tb_clk    = 0;
      tb_sclr	= 0;	
      EOS	= 0;
      EOS_VIDEO = 0;
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
        $display("\n***********************");
        $display("**    TEST PASSED    **");
        $display("***********************\n");
	$display(" Test completed successfully \n");

     end
     EOS = 1;
     $finish; 
 end
 endtask


 task test_sequence;
 begin     
     reset(100);
     wait_cycle(50);

 //    if (`TB_STIMULI_TYPE == 0)
 //    begin
         MST.is_ramp_gen(`C_ACTIVE_ROWS, `C_ACTIVE_COLS, 2);
 //    end
 //    if (`TB_STIMULI_TYPE == 1)
 //    begin
 //        MST.use_file(`STIMULI_FILE_NAME);
 //    end

     SLV.is_passive;

     CE_GEN.start;
     wait_cycle(50);


     MST.start;
     SLV.start;
     wait(m_EOF_w ==1);
     wait_cycle(10);
     MST.stop;
     SLV.stop;
     wait_cycle(10);
     $display("TEST END :"); 
 end
 endtask

 //=========================
 // TEST FLOW
 //=========================
 initial 
 begin
     $display("TEST BEGIN :");
     test_sequence;
     test_summary;     
     $display("TEST END :");
  end 
 endmodule  //END OF TESTBENCH
