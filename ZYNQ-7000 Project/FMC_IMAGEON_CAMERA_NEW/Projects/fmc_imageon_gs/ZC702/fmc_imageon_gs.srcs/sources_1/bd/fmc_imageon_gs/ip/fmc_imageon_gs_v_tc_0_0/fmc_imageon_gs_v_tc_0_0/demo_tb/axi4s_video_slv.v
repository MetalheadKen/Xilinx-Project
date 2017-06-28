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
// Filename    : axi4s_video_slv.v
// Description : This module is a Slave-Receiver model based on 
//               Video over AXI4-Stream Specification v1.5 &
//               Video and Imaging IP Standard Data File Format v1.2 .
//
// Available user tasks  : 
// start()                -> enable module & start receiving video data
// stop()                 -> disable module & stop receiving video data
// throttle_on()          -> enable data throttling using tready
// throttle_off()         -> disable data throttling
// data_check_on()        -> enable output data checking
// data_check_off()       -> disable output data checking
// debug_on()             -> turn on debug displays
// debug_off()            -> turn off debug displays
// use_file(<filepath>)   -> specify golden file filepath. 
// set_throttle_valid(num) -> specify width of tready high when throttle is on
// set_throttle_wait(num)  -> specify width of tready low when throttle is on
// set_timeout(num)        -> # of aclk cycles before data timeout occurs
// stop_on_error()         -> kill simulation when error was flagged
// resume_on_error()       -> continue simulation with errors (default)
// eol_check_on()          -> enables EOL checking.
// eol_check_off()         -> disables EOL checking.
// sof_check_on()          -> enables SOF checking.
// sof_check_off()         -> disables SOF checking.
// is_active()             -> model is set to active mode
// is_passive()            -> model is set to passive mode
//
//-----------------------------------------------------------------------------
// Ver    Date        Modified by   Modification
//-----------------------------------------------------------------------------
// 1.0    27/10/2011  reinald       Initial code.
// 1.1    13/12/2011  reinald       Internal timeout counter implemented to 
//                                   check output data under run. 
//                                  Input signal "endofcheck" no longer used.
//                                  Added set_timeout() task.
//                                  Removed output data overrun check.
//                                  EOF asserts when end of golden file was 
//                                  reached or timeout occurred.
// 1.2    14/12/2011  reinald       Added additional port "aclken" that masks
//                                  aclk and suspends module operation.
//                                  Removed deprecated signal "endofcheck" 
// 1.3    21/12/2011  reinald       Modified behavior to still send slave
//                                  response (drive tready) even after EOF 
//                                  was reached. User must call stop() to 
//                                  disable slave response.
// 1.4    03/01/2012  reinald       added warning messages when total received 
//                                  pixels do not match header details.
//
// 1.5    30/01/2012  reinald       Fixed bug on YUV422 format chroma swap.
//                                  Fixed bug on YUV420 format 1 pixel offset 
//                                  in inactive chroma.
//                                  Added check for 'X' in tdata.
//                                  Added new controls for SOF & EOL checking.
//
// 1.6    14/05/2012  reinald       Added configurable drive delay for all 
//                                  output ports.
//                                  Fixed race condition on tready driving.
//                                  Fixed Sampling edge to clock rise. 
//                                  Driving edge configurable by parameter.
//                                  Modified for iSim & ncsim support.
//
// 1.7    04/07/2012  reinald       Added option to compare only valid bits
//
// 1.8    13/08/2012  reinald       Added option to make slave passive.
// 				    Added is_active() & is_passive() tasks.
//                                  
//-----------------------------------------------------------------------------
`timescale 1ns/1ns

module axi4s_video_slv
#(
    parameter module_id        = "AXI4-S Video Slave  1",
    parameter drive_edge       = "rise", //only "rise" & "fall" are valid
    parameter datawidth        = 32,     //must be multiple of 8
    parameter tuserwidth       = 1,      //tuser width for SOF
    parameter output_file      = 0,      //1:write sampled data to file, 0:No output file.
    parameter drive_dly        = 0       //add delay before driving output
)
(
    input aclk,
    input aclken,
    input aresetn,
    output reg tready,
    input [datawidth-1: 0] tdata,
    input tvalid,
    input eol,
    input [tuserwidth-1: 0] sof,
    output reg[31:0] error_count,
    output reg EOF
);
    reg tready_d0;
    always@(tready_d0) #(drive_dly) tready = tready_d0;

    // module control
    reg enable               = 0;
    reg data_check           = 1;
    reg eol_check            = 1;
    reg sof_check            = 1;
    reg debug                = 0;
    reg throttle             = 0;
    reg halt_on_error        = 0;
    reg [31:0] throttlewidth = 10;
    reg [31:0] throttlewait  = 10;
    reg [50*8:0] file_name   = "./expected/golden_1.txt";
    reg valid_bits_only      = 1;
    reg passive              = 0;
	
    // container for file read data
    reg [63:0] file_data;
    reg [63:0] actual_data;
    // containers for pixel components
    integer compA;
    integer compB;
    integer compC;
    integer compD;
    integer valid_bits;
    // containers for header data
    integer header_mode;
    integer header_frames;
    integer header_field;
    integer header_rows;
    integer header_cols;
    integer header_bpp;
    // variables for file handle operations
    integer file_handler;
    integer output_file_handler;
    integer file_eof;
    integer isim_eof;
    // variables for flow control
    integer pixel_count=0;
    integer throttle_data_cnt;
    integer throttle_wait_cnt;
    integer data_count;
    integer dataline_cnt;
    integer timeout_ctr;
    integer timeout;
    integer fileend;
    //events
    event aclk_rise;
    event aclk_fall;
    event aresetn_rise;
    event aresetn_fall;
    always @(posedge aclk) if(aclken) -> aclk_rise;
    always @(negedge aclk) if(aclken) -> aclk_fall;
    always @(posedge aresetn) -> aresetn_rise;
    always @(negedge aresetn) -> aresetn_fall;

    initial 
    begin
        tready_d0          = 0;
	error_count    = 0;
	EOF            = 0;
	throttle_data_cnt = throttlewidth;
	throttle_wait_cnt = throttlewait;
	file_data      = 0;
	pixel_count         = 0;
	data_count     = 0;
	dataline_cnt   = 0;
	data_check     = 1;
	timeout_ctr    = 0;
	timeout        = 10000;
	if((drive_edge != "rise")&&(drive_edge != "fall"))
        begin
            $display("@%10t : [%s] \"%s\" is not a valid drive_edge parameter value ...", $time, module_id, drive_edge);
            $finish; 
        end
    end
  
    
  //=============//
  // USER TASKS  //
  //=============//
    task use_file;
    input [50*8:0] filenum;
    begin
	file_name = filenum;
	$display("@%10t : [%s] attaching %s ...", $time, module_id, file_name);
    end
    endtask

    task is_active;
	begin
	    passive = 0;
	    $display("@%10t : [%s] set to Active Mode ...", $time, module_id);
	end	
    endtask

    task is_passive;
	begin
	    passive = 1;
	    $display("@%10t : [%s] set to Passive Mode ...", $time, module_id);
	end	
    endtask

    task start;
    begin
        EOF            = 0;
    	throttle_wait_cnt = throttlewait;
	file_data      = 0;
        pixel_count         = 0;
	isim_eof       = 0;
	dataline_cnt   = 0;
	data_count     = 0;
        timeout_ctr    = 0;

      if(!passive) 
      begin

        file_handler   = $fopen(file_name, "r");
        if (file_handler == 0) 
        begin
            $display("ERROR : %s cannot be opened.... Simulation Stopped", file_name);
            $finish;
        end
	file_eof = $fseek(file_handler, 0, 2);
	fileend  = $ftell(file_handler);
	file_eof = $fseek(file_handler, 0, 0);
	    //GET THE MODE
            file_eof = $fscanf(file_handler,"%s",file_data);
            file_eof = $fscanf(file_handler,"%d",file_data);
            header_mode    =  file_data;
            //GET THE NUMBER OF FRAMES
            file_eof = $fscanf(file_handler,"%s",file_data);
            file_eof = $fscanf(file_handler,"%d",file_data);
            header_frames =  file_data;
            //GET THE FIELD THAT COMES FIRST
            file_eof = $fscanf(file_handler,"%s",file_data);
            file_eof = $fscanf(file_handler,"%d",file_data);
            header_field =  file_data;
            //GET THE NUMBER OF ROWS
            file_eof = $fscanf(file_handler,"%s",file_data);
            file_eof = $fscanf(file_handler,"%d",file_data);                    
            header_rows    =  file_data;
            //GET THE NUMBER OF COLUMNS
            file_eof = $fscanf(file_handler,"%s",file_data);
            file_eof = $fscanf(file_handler,"%d",file_data);                    
            header_cols =  file_data;                    
            //GET THE NUMBER OF BITS 
            file_eof = $fscanf(file_handler,"%s",file_data);
            file_eof = $fscanf(file_handler,"%d",file_data);                                        
            header_bpp =  file_data;
	if(debug)
	begin
            $display("@%10t : [%s] EXPECTED TOTAL DATA COUNT = %d", $time, module_id, header_rows*header_cols);
	end

        if(output_file == 1)
	begin
  	   output_file_handler  = $fopen( {"./result/result_", file_name[8*5-1:8*4], ".txt"}   , "w");
           if(output_file_handler == 0)
           begin
	       $display("ERROR : result/result.txt cannot be opened for writing ... Simulation Stopped");
	       $finish;
	   end
	end

	fetch_data;

      end
        enable = 1;
        $display("@%10t : [%s] STARTED", $time, module_id);

    end
    endtask
    
    task stop;
    begin
        if(pixel_count > 0)
        begin 
            $fclose(file_handler);
	    if(output_file)
	    begin
		$fclose(output_file_handler); 
	    end
            pixel_count = 0;
        end
        enable = 0;
        //tready_d0  = 0;
	$display("@%10t : [%s] STOPPED", $time, module_id);
	EOF = 0;
    end
    endtask

    task data_check_on;
    begin
	if(debug)
	begin
	     $display("@%10t : [%s] Output Data Checker Turned ON", $time, module_id);
	end
        data_check = 1;
    end
    endtask

    task data_check_off;
    begin 
	if(debug)
	begin
	     $display("@%10t : [%s] Output Data Checker Turned OFF", $time, module_id);
	end
        data_check = 0;
    end
    endtask

    task eol_check_on;
    begin
	if(debug)
	begin
	     $display("@%10t : [%s] EOL Check Turned ON", $time, module_id);
	end
        eol_check = 1;
    end
    endtask

    task eol_check_off;
    begin 
	if(debug)
	begin
	     $display("@%10t : [%s] EOL Check Turned OFF", $time, module_id);
	end
        eol_check = 0;
    end
    endtask

    task sof_check_on;
    begin
	if(debug)
	begin
	     $display("@%10t : [%s] SOF Check Turned ON", $time, module_id);
	end
        sof_check = 1;
    end
    endtask

    task sof_check_off;
    begin 
	if(debug)
	begin
	     $display("@%10t : [%s] SOF Check Turned OFF", $time, module_id);
	end
        sof_check = 0;
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
        throttlewidth  = width;
	throttle_data_cnt = width;
	if(debug)
	     $display("@%10t : [%s] Data Throttle Width set to %d", $time, module_id, width);
    end
    endtask

    task set_timeout;
    input [31:0] timeout_cnt_input;
    begin
        timeout = timeout_cnt_input;
    end
    endtask

    task set_throttle_wait;
    input [31:0] width;
    begin
	throttlewait  = width;
	throttle_wait_cnt = width;	
	if(debug)
	    $display("@%10t : [%s] Data Throttle Wait  set to %d", $time, module_id, width);
    end
    endtask

    task stop_on_error;
    begin
	halt_on_error = 1;
	if(debug)
	    $display("@%10t : [%s] Set to Stop on Error", $time, module_id);
    end
    endtask

    task resume_on_error;
    begin
	halt_on_error = 0;
	if(debug)
	    $display("@%10t : [%s] Set to Resume on Error", $time, module_id);
    end
    endtask
    

  //=================//
  // INTERNAL TASKS  //
  //=================//
  
    task compare_data;
    begin
        data_count = data_count+1;
        if(^actual_data === 1'bX)
	begin
	    error_count = error_count + 1;
	    $display("@%10t : [%s] ERROR : OUTPUT DATA HAS UNDEFINED BIT/S!!!",  $time, module_id);
	    $display("@%10t : [%s]         DATA COUNT %0d: [EXP = 'h%4h  :: RCVD = 'h%4h]",  $time, module_id, data_count,file_data, actual_data);
	    if(halt_on_error) $finish;
	end
        else if(actual_data != file_data)
    	//if(actual_data != file_data)
	begin
	    error_count = error_count + 1;
	    $display("@%10t : [%s] ERROR : OUTPUT DATA MISMATCH !!!",  $time, module_id);
            $display("@%10t : [%s]         DATA COUNT %0d: [EXP = 'h%4h  :: RCVD = 'h%4h]",  $time, module_id, data_count,file_data, actual_data);
	    if(halt_on_error) $finish;
	end
	else 
	begin
            if(debug) $display("@%10t : [%s] Data Check OK! DATA COUNT %0d: [EXP = 'h%4h  :: RCVD = 'h%4h]",  $time, module_id, data_count, file_data, actual_data);
	end
    end
    endtask

    task check_eol;
    begin
        if(((pixel_count%header_cols) == 0)&&(eol != 1))
	begin
	    error_count = error_count + 1;
	    $display("@%10t : [%s] ERROR : Expected EOL assertion did NOT occur.", $time, module_id);  
	    if(halt_on_error) $finish;
	end
        if(((pixel_count%header_cols) != 0)&&(eol == 1))
	begin
	    error_count = error_count + 1;
	    $display("@%10t : [%s] ERROR : Unexpected EOL assertion.", $time, module_id);  
	    if(halt_on_error) $finish;
	end
    end
    endtask

    task check_sof;
    begin
        if((pixel_count%(header_cols*header_rows) == 1)&&(sof != 1))
	begin
	    error_count = error_count + 1;
	    $display("@%10t : [%s] ERROR : Expected SOF assertion did NOT occur.", $time, module_id);  
	    if(halt_on_error) $finish;
	end
        if((pixel_count%(header_cols*header_rows) != 1)&&(sof == 1))
	begin
	    error_count = error_count + 1;
	    $display("@%10t : [%s] ERROR : Unexpected SOF assertion.", $time, module_id);  
	    if(halt_on_error) $finish;
	end
    end
    endtask
	
    task fetch_data;
    begin
        file_data = 0;
        if(isim_eof == 0) 
	begin
        case(header_mode)
        0,4,11,100,104,111 : begin
            file_eof = $fscanf(file_handler,"%d", compA); //Mono
	    valid_bits = header_bpp;
            if(compA == 16777215) compA = 0;              //Don't Care place holder 16777215.
            isim_eof = $feof(file_handler);
            if((header_mode == 4)||(header_mode == 11)||(header_mode == 104)||(header_mode == 111))
            begin
	       valid_bits = header_bpp * 2;
               file_eof = $fscanf(file_handler,"%d", compB); //alpha or motion
               if(compB == 16777215) compB = 0;              //Don't Care place holder 16777215.
               isim_eof = $feof(file_handler);
               file_data = compB;
               file_data = file_data << header_bpp;
            end
            file_data = file_data + compA;
           end

         8,9,10,108,109,110 : begin
            file_eof = $fscanf(file_handler,"%d", compA); //R    
            file_eof = $fscanf(file_handler,"%d", compB); //G
            file_eof = $fscanf(file_handler,"%d", compC); //B 
	    valid_bits = header_bpp * 3;
            if(compA == 16777215) compA = 0;              //Don't Care place holder 16777215.
            if(compB == 16777215) compB = 0;              //Don't Care place holder 16777215.
            if(compC == 16777215) compC = 0;              //Don't Care place holder 16777215.               
            isim_eof = $feof(file_handler);
            if((header_mode == 9)||(header_mode == 10)||(header_mode == 109)||(header_mode == 110))
            begin
              valid_bits = header_bpp * 4;
              file_eof = $fscanf(file_handler,"%d", compD); //alpha or motion
              if(compD == 16777215) compD = 0;              //Don't Care place holder 16777215.
              isim_eof = $feof(file_handler);
              file_data = compD;
              file_data = file_data << header_bpp;
            end
            file_data = file_data + compA;
            file_data = file_data << header_bpp;
            file_data = file_data + compC;
            file_data = file_data << header_bpp;
            file_data = file_data + compB;
         end

         3,7,103,107 : begin
            file_eof = $fscanf(file_handler,"%d", compA); //Y    
            file_eof = $fscanf(file_handler,"%d", compB); //Cb
            file_eof = $fscanf(file_handler,"%d", compC); //Cr
	    valid_bits = header_bpp * 3;
            if(compA == 16777215) compA = 0;              //Don't Care place holder 16777215.
            if(compB == 16777215) compB = 0;              //Don't Care place holder 16777215.
            if(compC == 16777215) compC = 0;              //Don't Care place holder 16777215.
            isim_eof = $feof(file_handler);
            if((header_mode == 7)||(header_mode == 107))
            begin
	      valid_bits = header_bpp * 4;
              file_eof = $fscanf(file_handler,"%d", compD); //alpha or motion
              if(compD == 16777215) compD = 0;              //Don't Care place holder 16777215.
              isim_eof = $feof(file_handler);
              file_data = compD;
              file_data = file_data << header_bpp;
            end
            file_data = file_data + compC;
            file_data = file_data << header_bpp;
            file_data = file_data + compB;
            file_data = file_data << header_bpp;
            file_data = file_data + compA;
         end

         1,2,5,6,101,102,105,106 : begin
            file_eof = $fscanf(file_handler,"%d", compA); //Y     
            file_eof = $fscanf(file_handler,"%d", compB); //Cr or Cb
	    valid_bits = header_bpp * 2;
            if(compA == 16777215) compA = 0;              //Don't Care place holder 16777215.
            if(compB == 16777215) compB = 0;              //Don't Care place holder 16777215.
            isim_eof = $feof(file_handler);
            if((header_mode == 5)||(header_mode == 6)||(header_mode == 105)||(header_mode == 106))
            begin
              valid_bits = header_bpp * 3;
              file_eof = $fscanf(file_handler,"%d", compC); //alpha or motion
              if(compC == 16777215) compC = 0;              //Don't Care place holder 16777215.
              isim_eof = $feof(file_handler);
              file_data = compC;
              file_data = file_data << header_bpp;
            end
            file_data = file_data + compB;
            file_data = file_data << header_bpp;
            file_data = file_data + compA;
         end

        default : begin
                $display("@%10t : [%s] MODE is UNKNOWN... Data set to 0x0", $time, module_id);
        end
        endcase
        end//if(isim_eof == 0)
        pixel_count = pixel_count+1;

    end
    endtask
  
    task fetch_actual_data;
	begin
        actual_data = 0;
	actual_data = tdata;
	if(valid_bits_only)
	begin
	    actual_data = actual_data << (64-valid_bits);
	    actual_data = actual_data >> (64-valid_bits);
	end

	          //------------------------------------------------------
		  // For 420 YUV/YCrCb, Chroma is valid ONLY every second
		  // video line. Expected & actual chroma data are set to 
		  // zero for data comparison purposes on every inactive 
		  // chroma line.
	          //------------------------------------------------------
		  if((((pixel_count-1)%(header_cols*2)) < header_cols)  &&  
			((header_mode==5)||(header_mode==105)||(header_mode==1)||(header_mode==101) ))
		  begin
			 case(header_bpp)
			 8  : begin
					file_data[15:8]   = 0;
					actual_data[15:8] = 0;
				 end
			 10 : begin
					file_data[19:10]   = 0;
					actual_data[19:10] = 0;
				 end
			 12 : begin
					file_data[23:12]   = 0;
					actual_data[23:12] = 0;
				 end
			 14 : begin
					file_data[27:14]   = 0;
					actual_data[27:14] = 0;
				 end
			 16 : begin
					file_data[31:16]   = 0;
					actual_data[31:16] = 0;
				 end
			 default :
			     begin
		             end
			 endcase
		  end
	end
    endtask

  //================//
  // MAIN FUNCTIONS //
  //================//
  
    always @(negedge aresetn)
    begin
      if(debug == 1)
      begin
	  $display("@%10t : [%s] RESET asserted...", $time, module_id);	
      end
      if(!passive)
      begin
        if(pixel_count > 0)
        begin 
            $fclose(file_handler);
  	    if(output_file)
  	    begin
	        $fclose(output_file_handler); 
	    end
            pixel_count = 0;
        end
      end
      enable = 0;
      tready_d0  = 0;
      timeout_ctr = 0;
      @aresetn_rise;
      if(debug == 1)
      begin
	  $display("@%10t : [%s] RESET deasserted...", $time, module_id);	
      end
      EOF = 0;
    end


    //================//
    // TREADY DRIVER  //
    //================//

    task drive_output;
    begin
        if(drive_edge == "fall") @aclk_fall;

        if(enable)
        begin
  	  if((throttle == 1)&&(throttle_wait_cnt > 0)&&(throttle_data_cnt==0))
  	  begin 
	      throttle_wait_cnt <= throttle_wait_cnt - 1;
              tready_d0   <= 0;
  	  end
  	  else 
	  begin
	      if(throttle == 1)
	      begin
                  if((throttle_data_cnt == 0)&&(throttle_wait_cnt == 0))
                  begin
		      throttle_data_cnt <= throttlewidth - 1;
		      throttle_wait_cnt <= throttlewait;	
	          end
		  else throttle_data_cnt <= throttle_data_cnt - 1;
	      end
	      tready_d0 <= 1;
	  end
        end
        else//if(enable)
        begin
	    tready_d0 <= 0;
        end
    end
    endtask

    //================//
    // DATA CHECKER   //
    //================//
    always @(aclk_rise)
    begin
	if (EOF) EOF <= 0;

	if(tvalid)  timeout_ctr = 0;
	else        timeout_ctr = timeout_ctr + 1;

        //normal operation// 
      if(enable)
      begin
        if(!passive)
	begin 

        if((tready_d0)&&(tvalid)&&(EOF==0))
        begin
	    fetch_actual_data;
	    if(output_file) $fwrite(output_file_handler, "%d\n", actual_data);
	    if(debug)       $display("@%10t : [%s] Rx Data = %8h",  $time, module_id, tdata);

 	    if((isim_eof == 0)&&(data_check))
            begin
    	            compare_data;
		    if(eol_check) check_eol;
	            if(sof_check) check_sof;
	    end
	
	    fetch_data;
            if(isim_eof != 0)
	    begin
		    $display("@%10t : [%s] TOTAL PIXELS RECEIVED    = %8d", $time, module_id, pixel_count-1);
		    if((pixel_count-1)!=(header_cols*header_rows*header_frames))
			$display("@%10t : [%s] WARNING : TOTAL PIXELS RECEIVED DO NOT MATCH FILE HEADER", $time, module_id);

                    pixel_count = 0;
                    timeout_ctr = 0;
                    EOF         = 1'h1;

                    $fclose(file_handler);
		    if(output_file) $fclose(output_file_handler);
	    end
	end

	if((timeout_ctr > timeout))
	begin
	    fetch_data;
	    while((isim_eof == 0)&&(data_check))
	    begin
	        error_count = error_count + 1;
	        $display("@%10t : [%s] ERROR : Output Data UnderRun! Flushing Remaining Expected Data ... -> %8h", $time, module_id, file_data);  
	        if(halt_on_error) $finish;
	        fetch_data;
	    end		

	    enable = 0;
	    pixel_count = 0;
	    timeout_ctr = 0;
	    EOF	   = 1'h1;
	    $fclose(file_handler);		
	    if(output_file)
	    begin
		$fclose(output_file_handler);
	    end
	end

        end
	drive_output;

      end//if(enable)
    end 

endmodule
  
