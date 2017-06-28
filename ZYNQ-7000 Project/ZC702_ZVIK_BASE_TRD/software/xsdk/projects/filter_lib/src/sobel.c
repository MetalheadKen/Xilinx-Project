/***************************************************************************

*   © Copyright 2013 Xilinx, Inc. All rights reserved.

*   This file contains confidential and proprietary information of Xilinx,
*   Inc. and is protected under U.S. and international copyright and other
*   intellectual property laws.

*   DISCLAIMER
*   This disclaimer is not a license and does not grant any rights to the
*   materials distributed herewith. Except as otherwise provided in a valid
*   license issued to you by Xilinx, and to the maximum extent permitted by
*   applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH
*   ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS,
*   EXPRESS, IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES
*   OF MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR
*   PURPOSE; and (2) Xilinx shall not be liable (whether in contract or
*   tort, including negligence, or under any other theory of liability)
*   for any loss or damage of any kind or nature related to, arising under
*   or in connection with these materials, including for any direct, or any
*   indirect, special, incidental, or consequential loss or damage (including
*   loss of data, profits, goodwill, or any type of loss or damage suffered
*   as a result of any action brought by a third party) even if such damage
*   or loss was reasonably foreseeable or Xilinx had been advised of the
*   possibility of the same.

*   CRITICAL APPLICATIONS
*   Xilinx products are not designed or intended to be fail-safe, or for use
*   in any application requiring fail-safe performance, such as life-support
*   or safety devices or systems, Class III medical devices, nuclear facilities,
*   applications related to the deployment of airbags, or any other applications
*   that could lead to death, personal injury, or severe property or environmental
*   damage (individually and collectively, "Critical Applications"). Customer
*   assumes the sole risk and liability of any use of Xilinx products in Critical
*   Applications, subject only to applicable laws and regulations governing
*   limitations on product liability.

*   THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT
*   ALL TIMES.

***************************************************************************/

#include "sobel.h"

static unsigned char line_buffer[3][MAX_WIDTH];

void sobel_filter( unsigned short *img_in,unsigned short *img_out,
				int height, int width, int stride)
{

	int pix_i = 0, pix_j = 0 , k =  0;
	short x_weight;
	short y_weight;
	short edge_weight;
	unsigned char edge_val;


	/* Clearing 0th row : Sobel filter is not applied on 0th ROW: to have consistent data flow */
	for(pix_j = 0; pix_j < stride; pix_j++) {
		*(img_out++) = 0x8000;
	}

	/* convert initial(i-1 & i) 2-rows of pixel data into line buffers*/
	for(pix_j = 0; pix_j < (width +1); pix_j++) {
		line_buffer[0][pix_j]  = ((*img_in) & 0x000000FF) ;
		img_in++;
	}

	/*  In-case Stride is different from WIDTH of the row */
	img_in = img_in + stride - width -1;

	for(pix_j = 0; pix_j < (width+1); pix_j++) {	/* 1st row */
		line_buffer[1][pix_j]  = ((*img_in) & 0x000000FF) ;
		img_in++;
	}

	/*  In-case Stride is different from WIDTH of the row */
	img_in = img_in + stride - width  - 1;
	/* ++ went 1beyond so (-1) */

	for(pix_i = 2; pix_i < height; pix_i++) {
		/* copy (pix_i) row into line_buffer, i.e: line_buffer[2] <-- row[pix_i] */
		for(pix_j = 0; pix_j < (width +1); pix_j++) {
			line_buffer[2][pix_j]  = ((*img_in) & 0x000000FF) ;
			img_in++;
		}

		/*  In-case Stride is different from WIDTH of the row */
		img_in = img_in + stride - width -1;
		/* making first pixel zero */
		*img_out = 0x8000;

		/* compute sobel filtering over (pix_i - 1) pixels */
		for(pix_j = 1; pix_j < (width+1); pix_j++) {
			x_weight =  line_buffer[0][pix_j-1]*x_coeff[0][2] + line_buffer[0][pix_j+1]*x_coeff[0][0] +
						line_buffer[1][pix_j-1]*x_coeff[1][2] + line_buffer[1][pix_j+1]*x_coeff[1][0] +
						line_buffer[2][pix_j-1]*x_coeff[2][2] + line_buffer[2][pix_j+1]*x_coeff[2][0];
			y_weight =  line_buffer[0][pix_j-1]*y_coeff[0][2] + line_buffer[0][pix_j]*y_coeff[0][1] + line_buffer[0][pix_j+1]*y_coeff[0][0] +
						line_buffer[2][pix_j-1]*y_coeff[2][2] + line_buffer[2][pix_j]*y_coeff[2][1] + line_buffer[2][pix_j+1]*y_coeff[2][0];

			edge_weight = ABS(x_weight) + ABS(y_weight);

			if(edge_weight < 255)
				edge_val = (255-(unsigned char)(edge_weight));
			else
				edge_val = 0;

			if(edge_val > high_thresh)
				edge_val = 255;
			else if(edge_val < low_thresh)
				edge_val = 0;


			/* If Sobel invert is enabled */
			if(inv == 1)
				edge_val=255-edge_val;

			img_out++;	/* col starts from 1 NOT 0...???*be careful here */
			*img_out = (edge_val) | (0x80<<8);

		}

		/* Pass through mode - In-case Stride is different from WIDTH of the row */
		for ( k = width; k < stride ; k++)
			*img_out++ = 0x8000;

		/* copy the history of pixel data */
		for(pix_j = 0; pix_j < width ; pix_j++) {
			line_buffer[0][pix_j] = line_buffer[1][pix_j] ;
			line_buffer[1][pix_j] = line_buffer[2][pix_j] ;
		}
	}
	/* clearing the last line */
	for(pix_j=0; pix_j < stride; pix_j++) {
		img_out[pix_j] = 0x8000;
	}
}


