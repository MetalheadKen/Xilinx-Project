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

#include <linux/xilinx-hls.h>
#include <linux/xilinx-v4l2-controls.h>
#include <sys/ioctl.h>

#include "linux.h"
#include "sobel.h"

#define HLS_SOBEL_HIGH_THRESH_OFF  0x90
#define HLS_SOBEL_LOW_THRESH_OFF   0x98
#define HLS_SOBEL_INVERT_OFF       0xa0

extern int filter_fd;

int x_coeff[3][3] = {
	{1, 0, -1},
	{2, 0, -2},
	{1, 0, -1}
};
int y_coeff[3][3] = {
	{ 1,  2,  1},
	{ 0,  0,  0},
	{-1, -2, -1}
};
unsigned int high_thresh = HLS_SOBEL_HIGH_THRESH_VAL;
unsigned int low_thresh = HLS_SOBEL_LOW_THRESH_VAL;
unsigned int inv = HLS_SOBEL_INVERT_VAL;


void v4l2_sobel_coeff(int x[3][3], int y[3][3])
{
	struct xilinx_axi_hls_register reg[18];
	unsigned int row;
	unsigned int col;
	unsigned int off = 0;
	unsigned int i;
	int ret;

	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++) {
			i = row * 3 + col;
			reg[i].offset = off;
			reg[i].value = x[row][col];
			off += 8;
		}
	}

	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++) {
			i = row * 3 + col + 9;
			reg[i].offset = off;
			reg[i].value = y[row][col];
			off += 8;
		}
	}

	struct xilinx_axi_hls_registers regs = {
		ARRAY_SIZE(reg),
		reg
	};

	ret = ioctl(filter_fd, XILINX_AXI_HLS_WRITE, &regs);
	ASSERT(ret < 0, "XILINX_AXI_HLS_WRITE failed: %s\n", ERRSTR);

	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++) {
			x_coeff[row][col] = x[row][col];
			y_coeff[row][col] = y[row][col];
		}
	}
}

void v4l2_sobel_thresh(unsigned int max, unsigned int min)
{
	int ret;

	struct xilinx_axi_hls_register reg[] = {
		{HLS_SOBEL_HIGH_THRESH_OFF, max},
		{HLS_SOBEL_LOW_THRESH_OFF, min}
	};

	struct xilinx_axi_hls_registers regs = {
		ARRAY_SIZE(reg),
		reg
	};

	ret = ioctl(filter_fd , XILINX_AXI_HLS_WRITE, &regs);
	ASSERT(ret < 0, "XILINX_AXI_HLS_WRITE failed: %s\n", ERRSTR);

	high_thresh = max;
	low_thresh = min;
}

void v4l2_sobel_invert(unsigned int val)
{
	int ret;

	struct xilinx_axi_hls_register reg = {
		HLS_SOBEL_INVERT_OFF,
		val
	};

	struct xilinx_axi_hls_registers regs = {
		1,
		&reg
	};

	ret = ioctl(filter_fd, XILINX_AXI_HLS_WRITE, &regs);
	ASSERT(ret < 0, "XILINX_AXI_HLS_WRITE failed: %s\n", ERRSTR);

	inv = val;
}

void v4l2_sobel_init()
{
	v4l2_sobel_coeff(x_coeff, y_coeff);
	v4l2_sobel_thresh(high_thresh, low_thresh);
	v4l2_sobel_invert(inv);
}
