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

#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

#ifdef USE_OPENCV
#include "opencv2/opencv.hpp"
#endif
#include "filter.h"
#include "linux.h"


int filter_fd;

static struct {
	filter_type type;
	const char *display_text;
	const char *dt_comp_string;
	const char *pr_file_name;
	char *pr_buf;
	unsigned int is_static;
	int index;
} filter_types[] = {
	{ FILTER_TYPE_FAST_CORNERS, "Fast Corners (OpenCV)", "", "fast_corners.bin", NULL, 0, -1 },
	{ FILTER_TYPE_SIMPLE_POSTERIZE, "Simple Posterize (OpenCV)", "", "simple_posterize.bin", NULL, 0, -1 },
	{ FILTER_TYPE_SOBEL, "Sobel (OpenCV)", "xlnx,v-hls-sobel", "sobel.bin", NULL, 1, -1 }
};

int filter_type_get_fd()
{
	return filter_fd;
}

void filter_type_set_fd(int fd)
{
	filter_fd = fd;
}

const char *filter_type_display_text(filter_type type)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].type == type)
			return filter_types[i].display_text;
	}

	return "Invalid";
}

const char *filter_type_dt_comp_string(filter_type type)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].type == type)
			return filter_types[i].dt_comp_string;
	}

	return "Invalid";
}

char *filter_type_pr_buf(filter_type type)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].type == type)
			return filter_types[i].pr_buf;
	}

	return NULL;
}

unsigned int filter_type_is_static(filter_type type)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].type == type)
			return filter_types[i].is_static;
	}

	return 0;
}

void filter_type_set_index(filter_type type, int index)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].type == type) {
			filter_types[i].index = index;
			break;
		}
	}
}

int filter_type_get_index(filter_type type)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].type == type)
			return filter_types[i].index;
	}

	return -1;
}

filter_type filter_type_from_index(int index)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].index == index)
			return filter_types[i].type;
	}
	return (filter_type)-1;
}

int filter_type_prefetch_bin()
{
	char file_name[128];
	char *buf;
	int fd;
	int ret;
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(filter_types); ++i) {
		if (filter_types[i].pr_file_name[0] != '\0') {
			// compose file name
			sprintf(file_name, "/media/card/partial/%s", filter_types[i].pr_file_name);

			// open partial bitfile
			fd = open(file_name, O_RDONLY);
			if (fd < 0) {
				printf("failed to open partial bitfile %s\n", file_name);
				return -1;
			}

			// allocate buffer and read partial bitfile into buffer
			buf = (char *) malloc(FILTER_PR_BIN_SIZE);
			ret = read(fd, buf, FILTER_PR_BIN_SIZE);
			if (ret < 0) {
				printf("failed to read partial bitfile %s\n", file_name);
				close(fd);
				return -1;
			}

			// store buffer address and close file handle
			filter_types[i].pr_buf = buf;
			close(fd);
		}
	}

	return 0;
}

int filter_type_free_bin()
{
	unsigned int i;

	/* In case arg to free is NULL, no action occurs */
	for (i = 0; i < ARRAY_SIZE(filter_types); ++i)
		free(filter_types[i].pr_buf);

	return 0;
}

int filter_type_config_bin(filter_type type)
{
	int fd;

	// Set is_partial_bitfile device attribute
	fd = open("/sys/devices/soc0/amba/f8007000.devcfg/is_partial_bitstream", O_RDWR);
	if (fd < 0) {
		printf("failed to set xdevcfg attribute 'is_partial_bitstream'\n");
		return -1;
	}
	write(fd, "1", 2);
	close(fd);

	// Write partial bitfile to xdevcfg device
	fd = open("/dev/xdevcfg", O_RDWR);
	if (fd < 0) {
		printf("failed to open xdevcfg device\n");
		return -1;
	}
	write(fd, filter_type_pr_buf(type), FILTER_PR_BIN_SIZE);
	close(fd);

	return 0;
}

#ifdef USE_OPENCV
extern void opencv_fast_corners(IplImage *src, IplImage *dst);
extern void opencv_simple_posterize(IplImage *src, IplImage *dst);
extern void opencv_sobel(IplImage *src, IplImage *dst);
#endif

void opencv_filter_func(unsigned char *frm_data_in, unsigned char *frm_data_out,
				 	 	int height, int width, int stride, filter_type type)
{
#ifdef USE_OPENCV
   	// constructing OpenCV interface
	IplImage* src_dma = cvCreateImageHeader(cvSize(width, height), IPL_DEPTH_8U, 2);
	IplImage* dst_dma = cvCreateImageHeader(cvSize(width, height), IPL_DEPTH_8U, 2);
	src_dma->imageData = (char *) frm_data_in;
	dst_dma->imageData = (char *) frm_data_out;
	src_dma->widthStep = 2 * stride;
	dst_dma->widthStep = 2 * stride;

	// call processing function
	switch (type) {
	case FILTER_TYPE_FAST_CORNERS:
		opencv_fast_corners(src_dma, dst_dma);
		break;
	case FILTER_TYPE_SIMPLE_POSTERIZE:
		opencv_simple_posterize(src_dma, dst_dma);
		break;
	case FILTER_TYPE_SOBEL:
		opencv_sobel(src_dma, dst_dma);
		break;
	default:
		printf("filter_func :: Invalid Filter Type \n");
	}

	cvReleaseImageHeader(&src_dma);
	cvReleaseImageHeader(&dst_dma);
#else
	switch (type) {
	case FILTER_TYPE_SOBEL:
		sobel_filter((unsigned short *) frm_data_in, (unsigned short *) frm_data_out, height, width, stride);
		break;
	default:
		printf("filter_func :: Invalid Filter Type \n");
	}
#endif
}
