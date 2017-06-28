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

#include "opencv2/opencv.hpp"
#include "sobel.h"

using namespace cv;

static Vec2b opencv_sobel_operator(unsigned char y_window[3][3], int low_thresh, int high_thresh, int inv)
{
	unsigned int i, j;

	short x_weight = 0;
	short y_weight = 0;

	short edge_weight;
	unsigned char edge_val;
	Vec2b pixel;

	// Compute approximation of the gradients in the X-Y direction
	for (i = 0; i < 3; i++) {
		for (j = 0; j < 3; j++) {
			// X direction gradient
			x_weight = x_weight + (y_window[i][j] * x_coeff[i][j]);
			// Y direction gradient
			y_weight = y_weight + (y_window[i][j] * y_coeff[i][j]);
		}
	}

	edge_weight = ABS(x_weight) + ABS(y_weight);

	if (edge_weight < 255)
		edge_val = (255-(unsigned char)(edge_weight));
	else
		edge_val = 0;

	// Edge thresholding
	if(edge_val > high_thresh)
		edge_val = 255;
	else if(edge_val < low_thresh)
		edge_val = 0;

	// Inversion
	if (inv == 1)
		edge_val = 255 - edge_val;

	pixel.val[0] = edge_val;
	pixel.val[1] = 128;

	return pixel;
}

void opencv_sobel(IplImage *_src, IplImage *_dst)
{
    Mat src(_src);
    Mat dst(_dst);
    unsigned char y_window[3][3] = {0};
    unsigned char line_buffer[3][MAX_WIDTH+1];
    int rows = src.rows;
    int cols = src.cols;
    int row, col, i;
    assert(rows <= MAX_HEIGHT);
    assert(cols <= MAX_WIDTH);

    /* Cache Sobel low,high threshold and invert state for each frame it will ensure
     * that changes are not applied on mid-frame .
     */
    unsigned int img_low_thresh = low_thresh;
    unsigned int img_high_thresh = high_thresh;
    unsigned int img_inv = inv;

    for (row = 0; row < rows + 1; row++) {
        for (col = 0; col < cols + 1; col++) {
            Vec2b p;
            unsigned char pix;

            if (row < rows && col < cols) {
                p = src.at<Vec2b>(row, col);
            }

            for (i = 0; i < 3; i++) {
                y_window[i][2] = y_window[i][1];
                y_window[i][1] = y_window[i][0];
            }

            y_window[2][0] = (line_buffer[2][col] = line_buffer[1][col]);
            y_window[1][0] = (pix = line_buffer[1][col] = line_buffer[0][col]);
            y_window[0][0] = (line_buffer[0][col] = p.val[0]);

            int output_row = row-1;
            int output_col = col-1;
            Vec2b edge;

            if(output_row == 0 || output_col == 0 || output_row == (rows-1) || output_col == (cols-1)){
                edge.val[0] = 0;
                edge.val[1] = 128;
            } else {
                //edge.val[0] = y_window[1][1];
                //edge.val[1] = 128;
                edge = opencv_sobel_operator(y_window, img_low_thresh, img_high_thresh, img_inv);
            }

            // Account for the spatial shift introduced by the filter.
            if(output_row >= 0 && output_col >= 0) {
                dst.at<Vec2b>(output_row, output_col) = edge;
            }
        }
    }
}
