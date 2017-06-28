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
// Filename     : ce_generator.v
// Description : This module generates CE signal 
//               in 3 different patterns,
//	        (1) Always asserted
//		(2) Random assertion
//		(3) Periodic assertion based on input period
//------------------------------------------------------------------------------
// Ver   Date	    Modified by	    Modification
//------------------------------------------------------------------------------
// 1.0 	20/05/11    Reinald Cruz    Initial release.
// 1.1	24/05/11    Reinald Cruz    Changed module interface names to *_in/*_out
// 1.2  04/11/11    Reinald Cruz    Changed module interface & task input
//------------------------------------------------------------------------------

`timescale 1ns/1ns
 //--------------------------------------------------
 //-- Clock Enable Generator
 //--------------------------------------------------
 module ce_gen        
 (
     input clk_in,
     input sclr_in,
     output reg ce_out	    
 );

 integer rseed         = 0;	       
 integer ce_period     = 10;
 integer ce_period_cnt = 0;
 reg enable 	       = 0;
 reg [1:0] ce_pattern  = 2'b00;	
 //----------------------------------------------------
 // CE PATTERN :
 // 2'b00 : CE is always asserted 
 // 2'b01 : CE is asserted periodically every ce_period
 // 2'b10 : CE is asserted randomly
 // 2'b11 : FORBIDDEN
 //----------------------------------------------------
															
 task start_random;
 input [31:0] seed;
   begin
     rseed         <= seed;
     ce_pattern    <= 2'b10;
     enable 	   <= 1;
     $display("@%10t : CE Generator : Enabled (Random)", $time); 
   end
 endtask

 task start_periodic;
 input [31:0] input_period;
   begin
     ce_period     <= input_period;
     ce_period_cnt <= 0;
     ce_pattern    <= 2'b01;
     enable 	   <= 1;
     $display("@%10t : CE Generator : Enabled (Periodic) [%dns]", $time, input_period); 
   end 
 endtask

 task start;
   begin
     ce_pattern    <= 2'b00;
     enable        <= 1;
     $display("@%10t : CE Generator : Enabled (always asserted)", $time); 
   end
 endtask

 task stop;
   begin
     enable 	<= 0;
     $display("@%10t : CE Generator : Disabled.", $time); 
   end
 endtask


 // RESET DETECTION
 always @ (posedge sclr_in)
 begin
         ce_out        = 0;
         ce_period_cnt = 0;
         enable        = 0;
 end

 // CE GENERATION
 always @ (posedge clk_in)
 begin
     if (enable)
     begin
	 case (ce_pattern)
	     2'b00 : begin
                         ce_out = 1;
		     end
	     2'b01 : begin
                         if (ce_period_cnt % (ce_period/2) == 0) 
                         begin
                             ce_out    = ~ce_out;
                             ce_period_cnt = 0;
                         end
                         ce_period_cnt = ce_period_cnt + 1;
		     end
	     2'b10 : begin
                         ce_out = {$random(rseed)}%2;
		     end
	   default : begin
                         $display("CE Generator : ERROR! ce_pattern[1:0] = 2'b11  IS NOT A VALID SETTING.");
                         $finish;
		     end
	 endcase	
     end
     else
     begin 
         ce_period_cnt <= 0;
         ce_out        <= 0;
     end			
 end
 	
 endmodule
