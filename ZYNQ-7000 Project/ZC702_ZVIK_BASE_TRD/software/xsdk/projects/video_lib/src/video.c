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
* @file video_lib.c
*
*  This file implements video library interface. 
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


#include "video.h"
#include "common.h"
#include "m2m_sw_pipeline.h"
#include "m2m_hw_pipeline.h"
#include "s2m_pipeline.h"
#include "mediactl_helper.h"
#include "gpio_utils.h"

#define FSYNC_SEL_GPIO  1

static struct video_pipeline *video_setup;

static struct {
	video_src src;
	const char *display_text;
	const char *entity_name;
	unsigned int enabled;
	int index;
} video_srcs[] = {
	{ VIDEO_SRC_TPG, "Test Pattern Generator", "vcap_tpg output 0", 1, -1 },
	{ VIDEO_SRC_HDMII, "HDMI Input", "vcap_hdmi output 0", 1, -1 },
	{ VIDEO_SRC_UVC, "USB Webcam", "uvcvideo", 0, -1 },
	{ VIDEO_SRC_VIVID, "Virtual Video Device", "vivid", 0, -1 }
};

static char *tpg_pattern_menu_names[TPG_TEST_PATTERN_CNT];
static unsigned int tpg_test_pattern = TPG_TEST_PATTERN_DEFAULT;

const char *vlib_video_src_display_text(video_src src)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(video_srcs); ++i) {
		if (video_srcs[i].src == src)
			return video_srcs[i].display_text;
	}

	return "Invalid";
}

const char *vlib_video_src_entity_name(video_src src)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(video_srcs); ++i) {
		if (video_srcs[i].src == src)
			return video_srcs[i].entity_name;
	}

	return "Invalid";
}

unsigned int vlib_video_src_get_enabled(video_src src)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(video_srcs); ++i) {
		if (video_srcs[i].src == src)
			return video_srcs[i].enabled;
	}

	return 0;
}

void vlib_video_src_set_index(video_src src, int index)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(video_srcs); ++i) {
		if (video_srcs[i].src == src) {
			video_srcs[i].index = index;
			break;
		}
	}
}

int vlib_video_src_get_index(video_src src)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(video_srcs); ++i) {
		if (video_srcs[i].src == src)
			return video_srcs[i].index;
	}

	return -1;
}

video_src vlib_video_src_from_index(int index)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(video_srcs); ++i) {
		if (video_srcs[i].index == index)
			return video_srcs[i].src;
	}

	return -1;
}

const char *vlib_tpg_get_pattern_menu_name(unsigned int idx)
{
	ASSERT(idx > TPG_TEST_PATTERN_CNT, "Invalid test pattern index\r");

	return tpg_pattern_menu_names[idx];
}

void vlib_tpg_set_pattern(unsigned int idx)
{
	v4l2_tpg_set_pattern(video_setup, idx);
	tpg_test_pattern = idx;
}

int vlib_init(int pr_enable)
{
	int i;

	/* Allocate video_setup struct and zero out memory */
	video_setup = calloc (1, sizeof (*video_setup));
	video_setup->app_state = MODE_INIT;
	video_setup->in_fourcc = INPUT_PIX_FMT;
	video_setup->out_fourcc = OUTPUT_PIX_FMT;
	video_setup->pr_enable = pr_enable;

	/* Detect ADV7611 status */
	if (get_entity_state(MEDIA_NODE_0, MEDIA_HDMI_ENTITY))
		video_setup->hdmii_present = 1;

	/* Initialize HLS subdev */
	v4l2_hls_init();

	/* Retrieve list of test patterns */
	for (i = 0; i < TPG_TEST_PATTERN_CNT; i++)
		tpg_pattern_menu_names[i] = malloc(32 * sizeof(**tpg_pattern_menu_names));
	v4l2_tpg_get_pattern_menu_names(tpg_pattern_menu_names);

	/* Prefetch partial binaries of filters */
	if (video_setup->pr_enable)
		filter_type_prefetch_bin();

	return VLIB_SUCCESS;
}

int vlib_drm_init()
{
	struct drm_device *drm_dev = &video_setup->drm;
	drm_dev->module = drm_module_name(video_setup->drm_module);
	drm_dev->format = video_setup->out_fourcc;

	/* Configure DRM */
	drm_init(drm_dev, BUFFER_CNT);

	/* Move video layer to the back */
	if (video_setup->drm_module == DRM_MODULE_XILINX) {
		drm_set_plane_prop(drm_dev, video_setup->drm.overlay_plane.plane_id, "zpos", 0);
		drm_set_plane_prop(drm_dev, video_setup->drm.prim_plane.plane_id, "zpos", 1);
	}

#ifdef DEBUG_MODE
	printf("vlib :: DRM Init done ..\n");
#endif

	return VLIB_SUCCESS;
}

int vlib_set_drm_module(drm_module module)
{
	video_setup->drm_module = module;

	return VLIB_SUCCESS;
}

int vlib_get_drm_module()
{
	return video_setup->drm_module;
}

/* Setter/getter for HDMI out pipeline height */	
int vlib_set_active_height(int h)
{
	video_setup->h = h;

	return VLIB_SUCCESS;
}

int vlib_get_active_height()
{
	return video_setup->h;
}

/* Setter/getter for HDMI out pipeline width */	
int vlib_set_active_width(int w)
{
	video_setup->w = w;

	/* Calculate stride in bytes */
	if (video_setup->drm_module == DRM_MODULE_XILINX)
		video_setup->stride = (video_setup->w * BYTES_PER_PIXEL);
	else // video_setup->drm_module == DRM_MODULE_XYLON
		video_setup->stride= (XYLON_DRM_STRIDE * BYTES_PER_PIXEL);

	return VLIB_SUCCESS;
}

int vlib_get_active_width()
{
	return video_setup->w;
}
	
int vlib_pipeline_stop()
{
	int ret =VLIB_ERROR;
	/* Add cleanup code */
	if(video_setup->eventloop != 0) {
		/* Set application state */
		video_setup->app_state = MODE_EXIT;
		ret = pthread_cancel(video_setup->eventloop);
		ret = pthread_join(video_setup->eventloop,NULL);
#ifdef DEBUG_MODE
		printf("vlib_pipeline_stop (pthread_join):: %d \n",ret);
#endif
	}
	/* Disable video layer on pipeline stop */
	drm_set_plane_state(&video_setup->drm, video_setup->drm.overlay_plane.plane_id, 0);
	return ret;
}

int vlib_uninit()
{
	/* close HLS subdev */
	v4l2_hls_uninit(filter_type_get_fd());
	free (video_setup);
	if (video_setup->pr_enable)
		filter_type_free_bin();
	return VLIB_SUCCESS;
}

int vlib_drm_uninit()
{
	drm_unit(&video_setup->drm);
	return VLIB_SUCCESS;
}

int vlib_change_mode(vlib_config config)
{
	int ret=0;
	struct v4l2_dv_timings dv_timings;
	void *(*process_thread_fptr)(void *);

	/* Check for HDMI presence and resolution */
	if (config.src == VIDEO_SRC_HDMII) {
		/* No FMC detected */
		if (!video_setup->hdmii_present) {
			printf("[info] :: FMC not connected\n");
			printf("[info] :: Continue with previous mode\n");
			return VLIB_ERROR;
		}
		/* Input resolution doesn't match output */
		query_entity_dv_timings(MEDIA_NODE_0, MEDIA_HDMI_PAD, &dv_timings);
		if ((dv_timings.bt.width != video_setup->w || dv_timings.bt.height != video_setup->h)) {
			printf("[info] :: HDMI input resolution '%dx%d' does not match display '%dx%d'\n",
					dv_timings.bt.width, dv_timings.bt.height, video_setup->w, video_setup->h);
			printf("[info] :: Continue with previous mode\n");
			return VLIB_ERROR;
		}
	}

	/* Set video source and color space */
	video_setup->vid_src = config.src;
	video_setup->colorspace = config.src == VIDEO_SRC_TPG ? V4L2_COLORSPACE_SRGB : V4L2_COLORSPACE_REC709;

	/* Stop processing loop */
	if(video_setup->eventloop != 0) {
		/* Set application state */
		video_setup->app_state = MODE_CHANGE;
		/* Stop previous running mode if any */
		ret = pthread_cancel(video_setup->eventloop);
		ret = pthread_join(video_setup->eventloop, NULL);
#ifdef DEBUG_MODE
		printf("vlib_change_mode (pthread_join):: %d \n",ret);
#endif
	}

	/* Set TPG pattern */
	/* Set FSYNC MUX - TODO: remove once VDMA driver is fixed */
	if (config.src == VIDEO_SRC_TPG) {
		v4l2_tpg_set_pattern(video_setup, tpg_test_pattern);
		/* Select TPG VDMA fsync */
		gpio_export(FSYNC_SEL_GPIO);
		gpio_dir_out(FSYNC_SEL_GPIO);
		gpio_value(FSYNC_SEL_GPIO, 1);
		gpio_unexport(FSYNC_SEL_GPIO);
	} else {
		/* Select HDMI Rx VDMA fsync */
		gpio_export(FSYNC_SEL_GPIO);
		gpio_dir_out(FSYNC_SEL_GPIO);
		gpio_value(FSYNC_SEL_GPIO, 0);
		gpio_unexport(FSYNC_SEL_GPIO);
	}

	/* Initialize filter mode */
	switch(config.mode) {
	case FILTER_MODE_OFF:
		ret = init_s2m_pipeline(video_setup);
		if (ret == VLIB_ERROR)
			return ret;
		process_thread_fptr = process_s2m_event_loop;
		break;
	case FILTER_MODE_SW:
		ret = init_m2m_sw_pipeline(video_setup, config.type);
		if (ret == VLIB_ERROR)
			return ret;
		process_thread_fptr = process_m2m_sw_event_loop;
		break;
	case FILTER_MODE_HW:
		ret = init_m2m_hw_pipeline(video_setup, config.type);
		if (ret == VLIB_ERROR)
			return ret;
		process_thread_fptr = process_m2m_hw_event_loop;
		break;
	default:
		ASSERT(1, "Invalid application mode!\n");
	}

	/* Start the processing loop */
	ret = pthread_create(&video_setup->eventloop, NULL, process_thread_fptr, video_setup);
	ASSERT( ret < 0 , "thread creation failed \n");

	return VLIB_SUCCESS;
}

int vlib_drm_set_layer0_state(int enable_state)
{
	/* Map primary-plane cordinates into CRTC using drmModeSetPlane */
	drm_set_plane_state(&video_setup->drm, video_setup->drm.prim_plane.plane_id, enable_state);
	return VLIB_SUCCESS;
}

int vlib_drm_set_layer0_transparency(int transparency)
{
	/* Setting DRM CRTC "transparency/alpha" property controls Layer Alpha Register for console layer */
	if (video_setup->drm_module == DRM_MODULE_XYLON) {
		drm_set_plane_prop(&video_setup->drm, video_setup->drm.prim_plane.plane_id, "transparency",
					(XYLON_MAX_TRANSPARENCY-transparency));
	} else { // DRM_MODULE_XILINX
		drm_set_plane_prop(&video_setup->drm, video_setup->drm.prim_plane.plane_id, "alpha",
					 (XILINX_MAX_TRANSPARENCY-transparency));
	}
	return VLIB_SUCCESS;
}

int vlib_drm_get_module_type(const char *str)
{
	drm_module_from_string(str);
	return VLIB_SUCCESS;
}

const char *vlib_drm_get_module_name(drm_module module)
{
	return drm_module_name(module);
}

int vlib_drm_set_layer0_position(int x, int y)
{
	drm_set_prim_plane_pos(&video_setup->drm, x, y);
	return VLIB_SUCCESS;
}

/* Set event-log state */
int vlib_set_event_log(int state)
{
	video_setup->enable_log_event = state;
	return VLIB_SUCCESS;
}

/* Query pipeline events*/
int vlib_get_event_cnt(pipeline_event event)
{
	if (video_setup->enable_log_event && event < NUM_EVENTS) {
		return video_setup->events[event].sampled_val;
	}
	return VLIB_ERROR;
}
