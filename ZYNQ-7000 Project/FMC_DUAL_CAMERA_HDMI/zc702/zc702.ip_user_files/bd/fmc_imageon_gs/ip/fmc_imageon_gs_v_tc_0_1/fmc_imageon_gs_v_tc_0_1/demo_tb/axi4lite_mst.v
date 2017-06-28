
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

//*****************************************************************************
// Filename    : axi4lite_mst.v
// Description : This module is a simple AXI4-Lite Master 
//
// Available user tasks  :
// wr(<addr>, <data>)     -> Perform AXI4-Lite Write Transaction
// rd(<addr>, <data>)     -> Perform AXI4-Lite Read Transaction
// debug_on()             -> turn on debug displays
// debug_off()            -> turn off debug displays
// on()                   -> enable module
// off()                  -> disable module
//
// Limitations :
//  - bready_d0 & rready_d0 are always asserted
//  - wstrb_d0  is always 4'b1111
//  - awprot_d0 is always 3'b010
//  - arprot_d0 is always 3'b010
//
//-----------------------------------------------------------------------------
// Ver    Date        Modified by   Modification
//-----------------------------------------------------------------------------
// 1.0    09/11/2011  reinald       Initial code.
// 1.1    13/12/2011  reinald       Modified wvalid_d0 to assert together with 
//                                  awvalid_d0 in address phase
// 1.2    14/12/2011  reinald       Added additional port "aclken" that masks
//                                  aclk and suspends module operation.
// 1.3    14/05/2012  reinald       Added configurable drive delay for all 
//                                  output ports.
//                                  Fixed Sampling edge to clock rise. 
//                                  Driving edge configurable by parameter.
//                                  Modified for iSim & ncsim support.
// 1.4    30/05/2012  reinald       added task wr_get_resp & read_get_resp.
//
//-----------------------------------------------------------------------------
`timescale 1ns/1ns

module axi4lite_mst
#(
    parameter module_id     = "AXI4-Lite Master 1",
    parameter drive_edge    = "rise", //only "rise" or "fall" is valid
    parameter datawidth     = 32,     //only 32 or 64 is valid
    parameter addrwidth     = 32,
    parameter drive_dly     = 0      //drive delay for output ports
)
(
    input aclk,
    input aclken,
    input aresetn,
    input awready,
    output reg awvalid,
    output reg [addrwidth-1:0] awaddr,
    output reg [2:0] awprot,
    input wready,
    output reg wvalid,
    output reg [datawidth-1:0] wdata,
    output reg [(datawidth/8)-1:0] wstrb,
    input bvalid,
    input [1:0] bresp,
    output reg bready,
    input arready,
    output reg arvalid,
    output reg [addrwidth-1:0] araddr,
    output reg [2:0] arprot,
    input rvalid,
    input [datawidth-1:0] rdata,
    input [1:0] rresp,
    output reg rready
);

    reg awvalid_d0;
    reg [addrwidth-1:0] awaddr_d0;
    reg [2:0] awprot_d0;
    reg wvalid_d0;
    reg [datawidth-1:0] wdata_d0;
    reg [(datawidth/8)-1:0] wstrb_d0;
    reg bready_d0;
    reg arvalid_d0;
    reg [addrwidth-1:0] araddr_d0;
    reg [2:0] arprot_d0;
    reg rready_d0;

    always @(awvalid_d0) #(drive_dly) awvalid = awvalid_d0;
    always @(awaddr_d0)  #(drive_dly) awaddr  = awaddr_d0;
    always @(awprot_d0 ) #(drive_dly) awprot  = awprot_d0;
    always @(wvalid_d0)  #(drive_dly) wvalid  = wvalid_d0;
    always @(wdata_d0)   #(drive_dly) wdata   = wdata_d0;
    always @(wstrb_d0)   #(drive_dly) wstrb   = wstrb_d0;
    always @(bready_d0)  #(drive_dly) bready  = bready_d0;
    always @(arvalid_d0) #(drive_dly) arvalid = arvalid_d0;
    always @(araddr_d0)  #(drive_dly) araddr  = araddr_d0;
    always @(arprot_d0)  #(drive_dly) arprot  = arprot_d0;
    always @(rready_d0)  #(drive_dly) rready  = rready_d0;

    // module control
    reg enable   = 1;
    reg debug    = 1;
    reg throttle = 0;
    reg [31:0] throttlewidth = 10;
    reg [31:0] throttlewait  = 5;

    // container for read data
    reg [datawidth-1:0] read_data_t  = 0;
    reg [datawidth-1:0] write_data_t = 0;
    reg [addrwidth-1:0] read_addr_t  = 0;
    reg [addrwidth-1:0] write_addr_t = 0;
    reg [1:0] bresp_t = 0;
    reg [1:0] rresp_t = 0;

    // variables for flow control
    integer throttle_data_cnt;
    integer throttle_wait_cnt;
    integer pending_wr_tx = 0;
    integer pending_rd_tx = 0;
   
    //transaction events
    event mst_write_req_evt;
    event mst_write_done_evt;
    event mst_read_req_evt;
    event mst_read_done_evt;
    event slv_write_rdy_evt;
    event slv_write_ack_evt;
    event slv_write_resp_evt;
    event slv_read_rdy_evt;
    event slv_read_resp_evt;

    //clock events
    event aclk_rise;
    event aclk_fall;
    event aresetn_rise;
    event aresetn_fall;

    always @(posedge aclk) if(aclken)    -> aclk_rise;
    always @(negedge aclk) if(aclken)    -> aclk_fall;
    always @(posedge aresetn) -> aresetn_rise;
    always @(negedge aresetn) -> aresetn_fall;
    always @(aclk_rise) if(awready && awvalid) -> slv_write_rdy_evt;
    always @(aclk_rise) if(wready  && wvalid)  -> slv_write_ack_evt;
    always @(aclk_rise) if(bready  && bvalid)  -> slv_write_resp_evt;
    always @(aclk_rise) if(arready && arvalid) -> slv_read_rdy_evt;
    always @(aclk_rise) if(rready  && rvalid)  -> slv_read_resp_evt;

    always @(mst_write_req_evt)
    begin
	if(drive_edge == "fall") @aclk_fall;
	pending_wr_tx = 1;
	awaddr_d0  = write_addr_t;
	awvalid_d0 = 1;
        wdata_d0   = write_data_t;
	wvalid_d0  = 1;
    end

    always @(slv_write_rdy_evt)
    begin
	if(drive_edge == "fall") @aclk_fall;
	awaddr_d0  = 0;
        awvalid_d0 = 0;
    end
	
    always @(slv_write_ack_evt)
    begin
	if(drive_edge == "fall") @aclk_fall;
	wdata_d0   = 0;
	wvalid_d0  = 0;
	bready_d0  = 1;
    end

    always @(slv_write_resp_evt)
    begin
	if(drive_edge == "fall") @aclk_fall;
        bresp_t = bresp;
	//IF NEEDED.
	//DO ERROR CHECKING HERE FOR RESPONSE
        -> mst_write_done_evt;
        pending_wr_tx = 0;
    end


    always @(mst_read_req_evt)
    begin
	if(drive_edge == "fall") @aclk_fall;
	pending_rd_tx = 1;
	araddr  = read_addr_t;
	arvalid_d0 = 1;
    end

    always @(slv_read_rdy_evt)
    begin
	if(drive_edge == "fall") @aclk_fall;
	araddr  = 0;
        arvalid_d0 = 0;
	rready_d0  = 1;
    end
	
    always @(slv_read_resp_evt)
    begin
	if(drive_edge == "fall") @aclk_fall;
	read_data_t = rdata;
        rresp_t = rresp;
	//IF NEEDED.
	//DO ERROR CHECKING HERE FOR RESPONSE
        -> mst_read_done_evt;
        pending_rd_tx = 0;
    end


    initial 
    begin
        on;
	throttle_data_cnt = throttlewidth;
	throttle_wait_cnt = throttlewait;        

	if((drive_edge != "rise")&&(drive_edge != "fall"))
	begin
	    $display("@%10t : [%s] \"%s\" is not a valid drive_edge parameter value ...", $time, module_id, drive_edge);
	    $finish; 
	end
    end
  
  //=============//
  // USER TASKS  //
  //=============//
    task init_ports;
    begin
	//output port initialization
        awvalid_d0  = 0;
	awaddr_d0   = 0;
	awprot_d0   = 3'b010;
	wvalid_d0   = 0;
	wdata_d0    = 0;
	wstrb_d0    = 4'b1111;
	bready_d0   = 1;
	arvalid_d0  = 0;
	araddr   = 0;
	arprot_d0   = 3'b010;
	rready_d0   = 1;
    end
    endtask

    task init_vars;
    begin
       read_data_t  = 0;
       read_addr_t  = 0;
       write_data_t = 0;
       write_addr_t = 0;

       pending_wr_tx     = 0;
       pending_rd_tx     = 0;
       throttle_data_cnt = 0;
       throttle_wait_cnt = 0;
    end
    endtask

    task on;
    begin
        enable = 1;
	init_ports;
        init_vars;
	$display("@%10t : [%s] Enabled.", $time, module_id);
    end
    endtask

    task off;
    begin
	enable = 0;
	init_ports;
	$display("@%10t : [%s] Disabled.", $time, module_id);
    end
    endtask
	
    task debug_on;
    begin
	debug = 1;
    end
    endtask
	
    task debug_off;
    begin
        debug = 0;
    end
    endtask

    task throttle_on;
    begin
	if(debug)
	begin
             $display("@%10t : [%s] Data Throttle Turned ON", $time, module_id);
	end
	throttle = 1;
	throttle_data_cnt = throttlewidth;
	throttle_wait_cnt = throttlewait;
    end
    endtask

    task throttle_off;
    begin
	if(debug)
	begin
             $display("@%10t : [%s] Data Throttle Turned OFF", $time, module_id);
	end
	throttle = 0;
    end
    endtask

    task set_throttle_valid;
    input [31:0] width;
    begin
	if(debug)
	begin
	    $display("@%10t : [%s] Data Throttle Width set to %d", $time, module_id, width);
	end
	throttlewidth  = width;
	throttle_data_cnt = width;
    end
    endtask

    task set_throttle_wait;
    input [31:0] width;
    begin
	if(debug)
	begin
	    $display("@%10t : [%s] Data Throttle Wait  set to %d", $time, module_id, width);
	end
	throttlewait  = width;
	throttle_wait_cnt = width;
    end
    endtask

    //=================================//
    // TASK TO ISSUE WRITE TRANSACTION //
    //=================================//
    task wr;
    input [addrwidth-1:0] useraddr;
    input [datawidth-1:0] userdata;
    begin
	if(enable)
	begin 
	    if(debug)  $display("@%10t : [%s] Write Start [ADDR = %8x , DATA = %8x]", $time, module_id, useraddr, userdata);
	    wait(pending_wr_tx == 0);
	    write_addr_t = useraddr;
	    write_data_t = userdata;
	    @(aclk_rise);
	    -> mst_write_req_evt;
	    @(mst_write_done_evt);
	    if(debug)  $display("@%10t : [%s] Write Done  [ADDR = %8x , DATA = %8x]", $time, module_id, useraddr, userdata);
	end
        else
	begin
            if(debug) $display("@%10t : [%s] Module disabled. Write Transaction NOT done. ", $time, module_id);
	end
    end
    endtask

    task wr_get_resp;
    input  [addrwidth-1:0] useraddr;
    input [datawidth-1:0] userdata;
    output [1:0] userrsp;
    begin
        wr(useraddr, userdata);
	userrsp = bresp_t;
    end
    endtask

    //=================================//
    // TASK TO ISSUE READ TRANSACTION  //
    //=================================//
    task rd;
    input  [addrwidth-1:0] useraddr;
    output [datawidth-1:0] userdata;
    begin
	if(enable)
	begin
	    if(debug)  $display("@%10t : [%s] Read Start [ADDR = %8x]", $time, module_id, useraddr);
	    wait(pending_rd_tx == 0);
	    read_addr_t = useraddr;
	    @(aclk_rise);
	    -> mst_read_req_evt;
	    @(mst_read_done_evt);
            userdata = read_data_t; 
	    if(debug)  $display("@%10t : [%s] Read Done  [ADDR = %8x, DATA = %8x]", $time, module_id, useraddr, userdata);
        end
        else
	begin
            if(debug) $display("@%10t : [%s] Module disabled. Read Transaction NOT done. ", $time, module_id);
	end
    end
    endtask

    task rd_get_resp;
    input  [addrwidth-1:0] useraddr;
    output [datawidth-1:0] userdata;
    output [1:0] userrsp;
    begin
        rd(useraddr, userdata);
	userrsp = rresp_t;
    end
    endtask

  //=================//
  // RESET DETECTION //
  //=================//
    always @(aresetn_fall)
    begin
      //aresetn assertion//
      if(debug == 1)
      begin
	  $display("@%10t : [%s] RESET asserted...", $time, module_id);
      end
      off;
          -> mst_read_done_evt;
          -> mst_write_done_evt;
	  pending_rd_tx = 0;
	  pending_wr_tx = 0;
      @aresetn_rise;
      if(debug == 1)
      begin
	  $display("@%10t : [%s] RESET deasserted...", $time, module_id);	
      end
      on;
    end

  endmodule
  
