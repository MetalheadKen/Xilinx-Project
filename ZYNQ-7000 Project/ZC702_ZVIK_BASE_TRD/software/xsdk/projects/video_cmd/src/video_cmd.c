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
* @file video_cmd.c
*
* This file implements command line interface for Zynq Base TRD .
* 
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date        Changes
* ----- ---- -------- -------------------------------------------------------
* 1.00a RSP   14/07/14 Initial release
* </pre>
*
* @note
*
******************************************************************************/


#include <stdio.h>
#include <getopt.h>
#include <errno.h>
#include <stdlib.h>

#include "video.h"


int getInput(void)
{
	int ch;
	int ret = -1;

	ch = getchar();

	if (ch >= '0' && ch <= '9')
		ret = ch - '0';

	while ((ch = getchar()) != '\n' && ch != EOF);

	return ret;
}

static void usage(const char *argv0)
{
	printf("Usage: %s [options]\n", argv0);
	printf("-d, --drm-module name   DRM module: 'xilinx' or 'xylon' (default: xylon)\n");
	printf("-h, --help              Show this help screen\n");
	printf("-p, --partial-reconfig  Enable partial reconfiguration of image filter\n");
	printf("-r, --resolution WxH    Width'x'Height (default: 1920x1080)\n");
}

static struct option opts[] = {
	{ "drm-module", required_argument, NULL, 'd' },
	{ "help", no_argument, NULL, 'h' },
	{ "partial-reconfig", no_argument, NULL, 'p' },
	{ "resolution", required_argument, NULL, 'r' },
	{ NULL, 0, NULL, 0 }
};


int main(int argc, char *argv[])
{
	int ret = 0;
	int i, j, k;
	const char *s, *t;

	/* Options parsing */
	int c, choice, current_choice = -1;
	int hdmi_out_width = HRES_1080P;
	int hdmi_out_height = VRES_1080P;
	drm_module module = DRM_MODULE_XYLON;
	int pr_enable = 0;

	vlib_config config = {
		.src = VIDEO_SRC_TPG,
		.type = FILTER_TYPE_SOBEL,
		.mode = FILTER_MODE_OFF
	};
	vlib_config current_config;

	/* Parse command line arguments */
	while ((c = getopt_long(argc, argv, "d:hpr:", opts, NULL)) != -1) {
		switch (c) {
		case 'd':
			module = vlib_drm_get_module_type(optarg);
			if (module == DRM_MODULE_NONE) {
				printf("Invalid DRM module '%s'\n", optarg);
				return 1;
			}
			break;
		case 'h':
			usage(argv[0]);
			return 0;
		case 'p':
			pr_enable = 1;
			break;
		case 'r':
			ret = sscanf(optarg, "%ux%u", &hdmi_out_width, &hdmi_out_height);
			if (ret != 2) {
				printf("Invalid size '%s'\n", optarg);
				return 1;
			}
			break;
		default:
			printf("Invalid option -%c\n", c);
			printf("Run %s -h for help\n", argv[0]);
			return 1;
		}
	}

	/* Initialize video library */
	vlib_init(pr_enable);
	vlib_set_drm_module(module);
	vlib_set_active_height(hdmi_out_height);
	vlib_set_active_width(hdmi_out_width);
	vlib_drm_init();

	/* Specifically disable Layer0 for command line application */
	vlib_drm_set_layer0_state(0);

	/* Print application status */
	printf("Video Control application:\n");
	printf("------------------------\n");
	printf("DRM module name: %s\n", vlib_drm_get_module_name(vlib_get_drm_module()));
	printf("HDMI output resolution: %dx%d\n", vlib_get_active_width(), vlib_get_active_height());

	/* Start default video src, filter type, filter mode */
	vlib_change_mode(config);

	/* Main control menu */
	do {
		/* start with menu index 1 since 0 is used for exit */
		j = 1;
		printf("\n--------------- Select Video Source ---------------\n");
		for (i = 0; i < VIDEO_SRC_CNT; i++) {
			if (vlib_video_src_get_enabled((video_src) i)) {
				s = vlib_video_src_display_text((video_src) i);
				vlib_video_src_set_index((video_src) i, j);
				if (config.src == i)
					t = "(*)";
				else
					t = "";
				printf("%d : %s  %s\n", j++, s, t);
			}
		}
		k = j;
		printf("\n--------------- Select Filter Type ----------------\n");
		for (i = 0; i < FILTER_TYPE_CNT; i++) {
			if (filter_type_is_static((filter_type) i) || pr_enable) {
				s = filter_type_display_text((filter_type) i);
				filter_type_set_index((filter_type) i, k);
				if (config.type == i)
					t = "(*)";
				else
					t = "";
				printf("%d : %s  %s\n", k++, s, t);
			}
		}
		printf("\n--------------- Toggle Filter Mode ----------------\n");
		switch (config.mode) {
			case FILTER_MODE_OFF:
				t = "(OFF)";
				break;
			case FILTER_MODE_SW:
				t = "(SW)";
				break;
			case FILTER_MODE_HW:
				t = "(HW)";
				break;
			default:
				break;
		}
		printf("%d : Filter OFF/SW/HW  %s\n", k, t);
		printf("\n--------------- Exit Application ------------------\n");
		printf("0 : Exit\n\n");
		printf("\nEnter your choice : ");

		choice = getInput();

		/* Same option selected */
		if (current_choice == choice && choice < k)
			continue;

		current_config = config;

		if (choice == 0) {
			vlib_pipeline_stop();
			vlib_drm_set_layer0_state(1);
			vlib_drm_uninit();
			vlib_uninit();
			exit(0);
		} else if (choice > 0 && choice < j) {
			config.src = vlib_video_src_from_index(choice);
		} else if (choice >= j && choice < k) {
			config.type = filter_type_from_index(choice);
		} else if (choice == k) {
			config.mode++;
			config.mode %= FILTER_MODE_CNT;
		} else {
			printf("\n\n********* Invalid input, Please try Again ***********\n");
			continue;
		}

		/* restore previous mode */
		if (pr_enable && filter_type_pr_buf(config.type) == NULL &&	config.mode == FILTER_MODE_HW) {
			printf("\n\n********* HW module for filter '%s' not available *********\n",
							   filter_type_display_text(config.type));
			config = current_config;
			continue;
		}

		/* Switch to selected video src, filter type, filter mode */
		ret = vlib_change_mode(config);
		if (!ret && choice < j)
			current_choice = choice;
		else
			config.src = current_config.src;

	} while (choice);

	return 0;
}
