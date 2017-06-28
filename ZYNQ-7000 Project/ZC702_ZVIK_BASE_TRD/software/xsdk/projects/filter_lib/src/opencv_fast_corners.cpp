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

using namespace cv;

static void chroma_upsampling(Mat &yuv422, Mat &yuv444)
{
	int row, col;

    for (row = 0; row < yuv422.rows; row++) {
        for (col = 0; col < yuv444.cols; col+=2) {
            Vec2b p0_in = yuv422.at<Vec2b>(row, col);
            Vec2b p1_in = yuv422.at<Vec2b>(row, col+1);
            Vec3b p0_out, p1_out;
            p0_out.val[0] = p0_in.val[0];
            p0_out.val[1] = p0_in.val[1];
            p0_out.val[2] = p1_in.val[1];
            p1_out.val[0] = p1_in.val[0];
            p1_out.val[1] = p0_in.val[1];
            p1_out.val[2] = p1_in.val[1];
            yuv444.at<Vec3b>(row, col) = p0_out;
            yuv444.at<Vec3b>(row, col+1) = p1_out;
        }
    }
}

static void chroma_downsampling(Mat &yuv444, Mat &yuv422)
{
	int row, col;

    for (row = 0; row < yuv444.rows; row++) {
        for (col = 0; col < yuv444.cols; col+=2) {
            Vec3b p0_in = yuv444.at<Vec3b>(row, col);
            Vec3b p1_in = yuv444.at<Vec3b>(row, col+1);
            Vec2b p0_out, p1_out;
            p0_out.val[0] = p0_in.val[0];
            p0_out.val[1] = p0_in.val[1];
            p1_out.val[0] = p1_in.val[0];
            p1_out.val[1] = p0_in.val[2];
            yuv422.at<Vec2b>(row, col) = p0_out;
            yuv422.at<Vec2b>(row, col+1) = p1_out;
        }
    }
}

void opencv_fast_corners(IplImage *_src, IplImage *_dst)
{
    Mat src(_src);
    Mat dst(_dst);
    Mat yuv444(src.rows, src.cols, CV_8UC3);
    std::vector<Mat> layers;
    std::vector<KeyPoint> keypoints;
    unsigned int i;

    chroma_upsampling(src, yuv444);
    split(yuv444, layers);
    FAST(layers[0], keypoints, 20, true);

    for (i = 0; i < keypoints.size(); i++) {
        rectangle(yuv444,
        		  Point(keypoints[i].pt.x-1, keypoints[i].pt.y-1),
        		  Point(keypoints[i].pt.x+1, keypoints[i].pt.y+1),
                  Scalar(76,84,255),
                  CV_FILLED);
    }

    chroma_downsampling(yuv444, dst);
}
