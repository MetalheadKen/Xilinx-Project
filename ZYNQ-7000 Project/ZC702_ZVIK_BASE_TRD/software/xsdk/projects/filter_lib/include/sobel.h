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

#ifndef ___SOBEL_H___
#define ___SOBEL_H___

#ifdef __cplusplus
extern "C" {
#endif

/* Maximum image size */
#define MAX_WIDTH  1920
#define MAX_HEIGHT 1080

/* Sobel filter macros */
#define HLS_SOBEL_HIGH_THRESH_VAL  200
#define HLS_SOBEL_LOW_THRESH_VAL   100
#define HLS_SOBEL_INVERT_VAL       0

/* Helper macros */
#define ABSDIFF(x,y)    ((x>y)? x - y : y - x)
#define ABS(x)          ((x>0)? x : -x)

extern int x_coeff[3][3];
extern int y_coeff[3][3];
extern unsigned int high_thresh;
extern unsigned int low_thresh;
extern unsigned int inv;

/* HW Sobel filter functions */
void v4l2_sobel_coeff(int x_coeff[3][3], int y_coeff[3][3]);
void v4l2_sobel_thresh(unsigned int max, unsigned int min);
void v4l2_sobel_invert(unsigned int inv);
void v4l2_sobel_init();

void sobel_filter( unsigned short *img_in,unsigned short *img_out, int height, int width, int stride);

#ifdef __cplusplus
}
#endif

#endif
