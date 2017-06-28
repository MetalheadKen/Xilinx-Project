//------------------------------------------------------------------------------ 
// Copyright (c) 2007 Xilinx, Inc. 
// All Rights Reserved 
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
//  This module infers a RAM that is 2^RAM_ADRESS_SIZE x RAM_WIDTH.
//  It uses this RAM in an asynchronous FIFO. 
//  Since this FIFO is asynchronous, pointers 
//  are passed between clock domains using sample and 
//  a sample and handshaking  for glitch-free operation.  However, 
//  this synchronization requires latency, so updating of the 
//  flags and levels is not instantaneous and is pessimistic. 
//  Level is not valid if any of the flags are active.
//
//-----------------------------------------------------------------------------

`timescale 1 ps	/ 1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module v_vid_in_axi4s_v3_0_in_bridge_async_fifo_2
#(
// Parmeter for RAM Depth is in GUI
// Paraemeter for RAM width allows for future expanded component widths
//  Initial width is fixed at 8/8/8 
  parameter RAM_WIDTH =26,
  parameter RAM_ADDR_BITS = 10    // default depth = 1024
)
(	
  input wire                      wr_clk,	     // write clock		
  input wire                      rd_clk,      // read clock     
  input wire                      rst,         // async_reset
  input wire                      wr_ce,       // write clock enable
  input wire                      rd_ce,       // read clock enable     
  input wire                      wr_en,       // write enable    
  input wire                      rd_en,       // read enable    
  input wire [RAM_WIDTH-1:0]      din,         // data_in
    
  output reg  [RAM_WIDTH-1:0]     dout,        // output data
  output reg                      empty,       // empty flag in read clock domain
  output reg                      rd_error,    // read error (read when empty)
  output reg                      full,        // full flag in write clock domain
  output reg                      wr_error,    // write error (write when full)
  output     [RAM_ADDR_BITS-1:0]  level_rd,    // level in read domain 
  output     [RAM_ADDR_BITS-1:0]  level_wr     // level in write domain    
);             

   reg [RAM_WIDTH-1:0] fifo_ram [(2**RAM_ADDR_BITS)-1:0];    // RAM storage

   wire [RAM_WIDTH-1:0] ram_out;                             // RAM output
    (*ASYNC_REG = "TRUE"*) reg rst_wr_1;            // reset synchronizing registers
    (*ASYNC_REG = "TRUE"*) reg rst_wr_2;            
    (*ASYNC_REG = "TRUE"*) reg rst_rd_1;            
    (*ASYNC_REG = "TRUE"*) reg rst_rd_2;            
   
   reg  [RAM_ADDR_BITS+1:0] rd_ptr =0;       // FIFO read pointer
   reg  [RAM_ADDR_BITS+1:0] wr_ptr =0;       // FIFO write pointer
   wire [RAM_ADDR_BITS-1:0] rd_addr;          // ram_addresses
   wire [RAM_ADDR_BITS-1:0] wr_addr;          // ram_addresses
   reg  [RAM_ADDR_BITS+1:0] rd_ptr_sample;    // pointer sample regs
   reg  [RAM_ADDR_BITS+1:0] rd_ptr_wr_dom;    
   reg  [RAM_ADDR_BITS+1:0] wr_ptr_sample;    
   reg  [RAM_ADDR_BITS+1:0] wr_ptr_rd_dom;    
   wire                     ce_rd_ptr_sample; // clock enables for ptr samp regs
   wire                     ce_rd_ptr_wr_dom;
   wire                     ce_wr_ptr_sample;
   wire                     ce_wr_ptr_rd_dom;
   wire                     rd_to_wr_req;     // pointer sync handshaking 
   wire                     rd_to_wr_ack;     
   wire                     wr_to_rd_req;     
   wire                     wr_to_rd_ack;
   (*ASYNC_REG = "TRUE"*) reg  req_wr_dom_1;     // sycnronizer registers rd to wr
   (*ASYNC_REG = "TRUE"*) reg  req_wr_dom_2;    
   (*ASYNC_REG = "TRUE"*) reg  req_wr_dom_3;    
   (*ASYNC_REG = "TRUE"*) reg  ack_rd_dom_1;     
   (*ASYNC_REG = "TRUE"*) reg  ack_rd_dom_2;    
   (*ASYNC_REG = "TRUE"*) reg  ack_rd_dom_3;    
   (*ASYNC_REG = "TRUE"*) reg  req_rd_dom_1;     // sycnronizer registers wr to rd
   (*ASYNC_REG = "TRUE"*) reg  req_rd_dom_2;    
   (*ASYNC_REG = "TRUE"*) reg  req_rd_dom_3;    
   (*ASYNC_REG = "TRUE"*) reg  ack_wr_dom_1;     
   (*ASYNC_REG = "TRUE"*) reg  ack_wr_dom_2;    
   (*ASYNC_REG = "TRUE"*) reg  ack_wr_dom_3;    
  
   wire [RAM_ADDR_BITS+1:0] ptr_diff_rd_dom_comb;//Pointer difference comb.
   reg [RAM_ADDR_BITS+1:0] ptr_diff_rd_dom;   //Pointer difference values
   reg [RAM_ADDR_BITS+1:0] ptr_diff_wr_dom; 
   
   wire                    empty_comb;        // combinatorial empty flag  
   wire                    full_comb;         // combinatorial full flag
   wire[RAM_ADDR_BITS+1:0] ptr_diff_wr_dom_comb; //combinatorial pointer diff 
     
   // read error tracking regs
   reg                     ram_out_rd_error;
   
// 
// pointers and flags
//
   // parse pointers into addresses and revolutuion numbers 
   assign wr_addr = wr_ptr[RAM_ADDR_BITS-1:0];    
   assign rd_addr = rd_ptr[RAM_ADDR_BITS-1:0];
   assign ptr_diff_wr_dom_comb = wr_ptr - rd_ptr_wr_dom;
   
// Define levels
   assign level_rd = ptr_diff_rd_dom[RAM_ADDR_BITS-1:0];
   assign level_wr = ptr_diff_wr_dom[RAM_ADDR_BITS-1:0];
   assign  ptr_diff_rd_dom_comb = wr_ptr_rd_dom- rd_ptr;
   
// Define requests and acknowledge bits for clock-crossing handshaking   
   assign rd_to_wr_req = !ack_rd_dom_3;
   assign rd_to_wr_ack = req_wr_dom_3;
   assign wr_to_rd_req = !ack_wr_dom_3;
   assign wr_to_rd_ack = req_rd_dom_3;
   
// Define enables for clock-crossing sample registers.
   assign ce_rd_ptr_sample = ack_rd_dom_2 ^ ack_rd_dom_3;
   assign ce_rd_ptr_wr_dom = req_wr_dom_2 ^ req_wr_dom_3;
   assign ce_wr_ptr_sample = ack_wr_dom_2 ^ ack_wr_dom_3;
   assign ce_wr_ptr_rd_dom = req_rd_dom_2 ^ req_rd_dom_3;
   
// Define combinatorial flags
   assign empty_comb = ptr_diff_rd_dom_comb <= 1;
   assign full_comb = ptr_diff_wr_dom_comb[RAM_ADDR_BITS];
//                                                         
// infer RAM
//   
   always @(posedge wr_clk)
      if (wr_en & wr_ce)
         fifo_ram[wr_addr] <= din;

   assign ram_out = fifo_ram[rd_addr];  

//   
//  Move pointers
//
   // Write-clock domain   
   always @ (posedge wr_clk) begin
     rst_wr_1 <= rst;
     rst_wr_2 <= rst_wr_1;
     if (rst_wr_2) begin
       wr_ptr <= 1;
       wr_ptr_sample <= 0;
       rd_ptr_wr_dom <= 0;     
       req_wr_dom_1 <= 0;
       req_wr_dom_2 <= 0;
       req_wr_dom_3 <= 0;
       ack_wr_dom_1 <= 0;
       ack_wr_dom_2 <= 0;
       ack_wr_dom_3 <= 0;
       ptr_diff_wr_dom <= 0;
       full <= 0;
       wr_error <= 0;
     end  
     else begin
       if (wr_ce) begin
         if (wr_en) begin
           if (full_comb) begin
              wr_error <= 1;
           end
           else begin
              wr_ptr <= wr_ptr+1;  // increment write pointer
              wr_error <= 0;
           end
         end  
         else begin
           wr_error <= 0;
         end
       end // if (wr_ce)
       
       // sample write pointer
       if (ce_wr_ptr_sample)
         wr_ptr_sample <= wr_ptr;
       // synchronize read pointer into write domain
       if (ce_rd_ptr_wr_dom)
         rd_ptr_wr_dom <= rd_ptr_sample;
       
       // delay registers for wr to rd handshaking
       ack_wr_dom_1 <=  wr_to_rd_ack; 
       ack_wr_dom_2 <=  ack_wr_dom_1; 
       ack_wr_dom_3 <=  ack_wr_dom_2; 
       // delay registers for rd to wr handshaking
       req_wr_dom_1 <= rd_to_wr_req;
       req_wr_dom_2 <= req_wr_dom_1;
       req_wr_dom_3 <= req_wr_dom_2;
    
       ptr_diff_wr_dom <= ptr_diff_wr_dom_comb;
    
 
       full <= full_comb;
     end 
   end
   
   // Read-clock domain
   always @ (posedge rd_clk ) begin
     rst_rd_1 <= rst;
     rst_rd_2 <= rst_rd_1;
     if (rst_rd_2)  begin
       rd_ptr <= 0;
       rd_ptr_sample <= 0;
       wr_ptr_rd_dom <= 0;
       req_rd_dom_1 <= 0;
       req_rd_dom_2 <= 0;
       req_rd_dom_3 <= 0;
       ack_rd_dom_1 <= 0;
       ack_rd_dom_2 <= 0;
       ack_rd_dom_3 <= 0;
       ptr_diff_rd_dom <= 0;
       empty <= 1;
       rd_error <= 0;
       dout <= 0;
     end
     else begin
       if (rd_ce) begin
         if (rd_en) begin
             dout <= ram_out;
             rd_error <= ram_out_rd_error;    
           if (empty_comb) begin
             ram_out_rd_error <= 1;
           end
           else if (!empty_comb) begin
             rd_ptr <= rd_ptr + 1;
             ram_out_rd_error <= 0;
           end
         end // if (rd_en)
       end   
         
       // sample read pointer
       if (ce_rd_ptr_sample)
         rd_ptr_sample <= rd_ptr;

       // delay registers for rd to wr handshaking
       ack_rd_dom_1 <= rd_to_wr_ack; 
       ack_rd_dom_2 <= ack_rd_dom_1; 
       ack_rd_dom_3 <= ack_rd_dom_2; 
       // delay registers for wr to rd handshaking
       req_rd_dom_1 <= wr_to_rd_req;
       req_rd_dom_2 <= req_rd_dom_1;
       req_rd_dom_3 <= req_rd_dom_2;
         
       // synchonize write pointer into read clock domain
       if (ce_wr_ptr_rd_dom)  
         wr_ptr_rd_dom <= wr_ptr_sample;
       ptr_diff_rd_dom <= ptr_diff_rd_dom_comb;
       
       empty <= ptr_diff_rd_dom_comb <= 1 && (rd_en || empty);  
     end
   end    
					
endmodule
