/******************************************************************************
*
* (c) Copyright 2012-2014 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
*******************************************************************************/

/*****************************************************************************
*
* @file log_events.c
*
* This file implements helper functions for logging video pipeline events.
*
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date        Changes
* ----- ---- -------- -------------------------------------------------------
* 1.00a RSP   05/06/15 Initial release
* </pre>
*
* @note
*
******************************************************************************/

#include "common.h"

int init_pipeline_events(void *ptr)
{

	struct video_pipeline *v_pipe = (struct video_pipeline *) ptr;
	v_pipe->events[CAPTURE].name = "Capture";
	v_pipe->events[CAPTURE].counter_val = 0;
	v_pipe->events[DISPLAY].name = "Display";
	v_pipe->events[DISPLAY].counter_val = 0;
	v_pipe->events[PROCESS_IN].name = "Filter-In";
	v_pipe->events[PROCESS_IN].counter_val = 0;
	v_pipe->events[PROCESS_OUT].name = "Filter-Out";
	v_pipe->events[PROCESS_OUT].counter_val = 0;

	return VLIB_SUCCESS;

}

int set_pipeline_events_cnt(void *ptr , int count)
{

	struct video_pipeline *v_pipe = (struct video_pipeline *) ptr;
	v_pipe->active_events = count;

	return VLIB_SUCCESS;
}

void *capture_pipeline_events(void *ptr)
{

	int i=0;
	struct video_pipeline *v_pipe = (struct video_pipeline *) ptr;

	while (1) {
		pthread_testcancel();
		for ( i = 0 ; i < v_pipe->active_events; i++) {
			v_pipe->events[i].sampled_val = v_pipe->events[i].counter_val;
			v_pipe->events[i].counter_val = 0;
		}
		sleep(1);
	}
}


