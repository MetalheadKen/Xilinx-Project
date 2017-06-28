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
* @file m2m_hw_pipeline.c
*
* This file implements the  interface for memory to memory hw processing pipeline.
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
#include "common.h"
#include "filter.h"
#include "video.h"
#include "m2m_hw_pipeline.h"
#include "v4l2_helper.h"
#include "mediactl_helper.h"
#include "log_events.h"
static struct m2m_hw_stream m2m_hw_stream_handle;

static void drm_event_handler(int fd __attribute__((__unused__)),
	unsigned int frame __attribute__((__unused__)),
	unsigned int sec __attribute__((__unused__)),
	unsigned int usec __attribute__((__unused__)),
	void *data )
{
	struct video_pipeline *v_pipe = (struct video_pipeline *) data;

	ASSERT (!v_pipe, " %s :: argument NULL ",__func__);
	m2m_hw_stream_handle.pflip_pending = 0;
	/* Count number of VBLANK events */
	v_pipe->events[1].counter_val++;
}

int init_m2m_hw_pipeline(struct video_pipeline *s, filter_type type)
{
	int ret = 0;
	char hls_model[DEV_NAME_LEN];

	media_node node = s->vid_src == VIDEO_SRC_TPG ? MEDIA_NODE_1 : MEDIA_NODE_0;

	memset(&m2m_hw_stream_handle, 0, sizeof (struct m2m_hw_stream));

	/* Configure media pipelines */
	set_media_control(s, node);
	set_media_control(s, MEDIA_NODE_2);

	/* Set v4l2 device names */
	const char* entity_name = vlib_video_src_entity_name(s->vid_src);
	ret = v4l2_parse_node(entity_name, m2m_hw_stream_handle.video_in.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", entity_name, ret);
	ret = v4l2_parse_node(XLNX_M2M_IN_CARD_NAME, m2m_hw_stream_handle.video_post_process_in.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", XLNX_M2M_IN_CARD_NAME, ret);
	ret = v4l2_parse_node(XLNX_M2M_OUT_CARD_NAME, m2m_hw_stream_handle.video_post_process_out.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", XLNX_M2M_OUT_CARD_NAME, ret);

	/* Initialize v4l2 video input device */
	m2m_hw_stream_handle.video_in.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_in.format.width = s->w;
	m2m_hw_stream_handle.video_in.format.height = s->h;
	m2m_hw_stream_handle.video_in.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_in.format.colorspace = s->colorspace;
	m2m_hw_stream_handle.video_in.buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	m2m_hw_stream_handle.video_in.mem_type =V4L2_MEMORY_DMABUF ;
	m2m_hw_stream_handle.video_in.setup_ptr = s;
	ret = v4l2_init(&m2m_hw_stream_handle.video_in, BUFFER_CNT);
	if (ret == VLIB_ERROR)
		return ret;

	/* Initialize v4l2 video sobel-in device */
	m2m_hw_stream_handle.video_post_process_in.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_post_process_in.format.width = s->w;
	m2m_hw_stream_handle.video_post_process_in.format.height = s->h;
	m2m_hw_stream_handle.video_post_process_in.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_post_process_in.format.colorspace = V4L2_COLORSPACE_SRGB;
	m2m_hw_stream_handle.video_post_process_in.buf_type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
	m2m_hw_stream_handle.video_post_process_in.mem_type = V4L2_MEMORY_MMAP;
	ret = v4l2_init(&m2m_hw_stream_handle.video_post_process_in, BUFFER_CNT);
	if (ret == VLIB_ERROR)
		return ret;

	/* Initialize v4l2 video sobel-out device*/
	m2m_hw_stream_handle.video_post_process_out.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_post_process_out.format.width = s->w;
	m2m_hw_stream_handle.video_post_process_out.format.height = s->h;
	m2m_hw_stream_handle.video_post_process_out.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_post_process_out.format.colorspace = V4L2_COLORSPACE_SRGB;
	m2m_hw_stream_handle.video_post_process_out.buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	m2m_hw_stream_handle.video_post_process_out.mem_type = V4L2_MEMORY_DMABUF;
	ret = v4l2_init(&m2m_hw_stream_handle.video_post_process_out, BUFFER_CNT);
	if (ret == VLIB_ERROR)
		return ret;

	/* Load and initialize partial bitstream for filter */
	if (s->pr_enable) {
		ret = filter_type_config_bin(type);
		if (ret == VLIB_ERROR)
			return ret;
	}

	/* Validate HLS model name */
	v4l2_hls_model(filter_type_get_fd(), hls_model);
	if (!strcmp(filter_type_dt_comp_string(type), hls_model))
		v4l2_sobel_init();

	if (s->enable_log_event) {
		init_pipeline_events(s);
		/* Set number of active event counters */
		set_pipeline_events_cnt(s,4);
	}

	return VLIB_SUCCESS;
}

/* Process m2m sw pipeline input/output events .
TPG/External --> Hardware Processing -->DRM
Video input device allocate buffer - mmap that to userspace
Sobel input device re-uses that buffer using v4l2 export buffer interface.
DRM allocate framebuffer.
Sobel output device re-uses that buffer using DMA buffer sharing mechanism.
*/
void *process_m2m_hw_event_loop(void *ptr)
{
	int i = 0 , ret = 0;
	struct v4l2_exportbuffer eb;
	struct video_pipeline *v_pipe = (struct video_pipeline *) ptr;

	/* push cleanup handler */
	pthread_cleanup_push(uninit_m2m_hw_pipeline, ptr);

	if (v_pipe->enable_log_event) {
		ret = pthread_create(&v_pipe->event_thread, NULL, capture_pipeline_events, v_pipe);
		ASSERT( ret < 0 , "thread creation failed \n");
	}
	/* Assigning buffer index and set exported buff handle */
	for(i=0;i<BUFFER_CNT;i++) {
		m2m_hw_stream_handle.video_in.vid_buf[i].index =i ;
		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].index=i;
		m2m_hw_stream_handle.video_post_process_out.vid_buf[i].index =i;

		/* Assign DRM buffer buff-sharing handle */
		m2m_hw_stream_handle.video_post_process_out.vid_buf[i].dbuf_fd  = v_pipe->drm.d_buff[i].dbuf_fd;


		/* export buffer for sharing buffer between two v4l2 devices*/
		memset(&eb, 0, sizeof(eb));
		eb.type = m2m_hw_stream_handle.video_post_process_in.buf_type;
		eb.index = i;
		ret = ioctl(m2m_hw_stream_handle.video_post_process_in.fd, VIDIOC_EXPBUF, &eb);
		ASSERT(ret< 0, "VIDIOC_EXPBUF failed: %s\n", ERRSTR);
		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].dbuf_fd =eb.fd;

		/*Queue buffer to TPG */
		v4l2_queue_buffer(&m2m_hw_stream_handle.video_in,
				& (m2m_hw_stream_handle.video_post_process_in.vid_buf[i]));

		/* Queue buffer for sobel-out pipeline */
		v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out,
						& (m2m_hw_stream_handle.video_post_process_out.vid_buf[i]));
	}

	/* Start streaming */
	ret = v4l2_device_on(& m2m_hw_stream_handle.video_in);
	ASSERT (ret < 0, "v4l2_device_on [video_in] failed %d \n",ret);
	ret = v4l2_device_on (&m2m_hw_stream_handle.video_post_process_in);
	ASSERT (ret < 0, "v4l2_device_on [video_post_process_in] failed %d \n",ret);
	ret = v4l2_device_on (&m2m_hw_stream_handle.video_post_process_out);
	ASSERT (ret < 0, "v4l2_device_on [video_post_process_out] failed %d \n",ret);

#ifdef DEBUG_MODE
	printf("vlib :: Video Capture Pipeline started\n");
#endif
	/* Set current buffer index */
	m2m_hw_stream_handle.vin_index = -1;
	m2m_hw_stream_handle.process_in_index = -1;
	m2m_hw_stream_handle.process_out_index = -1;
	m2m_hw_stream_handle.vout_index = -1;

	struct pollfd fds[] = {
		{.fd = m2m_hw_stream_handle.video_in.fd, .events = POLLIN},
		{.fd = m2m_hw_stream_handle.video_post_process_in.fd, .events = POLLOUT},
		{.fd = m2m_hw_stream_handle.video_post_process_out.fd, .events = POLLIN},
		{.fd = v_pipe->drm.fd, .events = POLLIN},
	};

	/* Register drm event context */
	drmEventContext evctx;
	memset(&evctx, 0, sizeof evctx);
	evctx.version = DRM_EVENT_CONTEXT_VERSION;
	evctx.vblank_handler = drm_event_handler;


	int filter_m2s_qbuf_count=0, index = 0;
	struct buffer *b;
	/* NOTE : VDMA doesn't issue EOF interrupt , as a result even on the first frame done,
		 interrupt , it still updating it , current solution is to skip the first frame
		 done notification*/

	/* poll and pass buffers */
	while ((ret = poll(fds, ARRAY_SIZE(fds), POLL_TIMEOUT_MSEC)) > 0 ) {
		if (fds[0].revents & POLLIN) {
			v_pipe->events[CAPTURE].counter_val++;
			b  = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_in, m2m_hw_stream_handle.video_in.vid_buf);

			index = b->index;
			if (m2m_hw_stream_handle.vin_index == -1) {
				m2m_hw_stream_handle.vin_index = index;
				continue;
			}
			b  = &m2m_hw_stream_handle.video_in.vid_buf[m2m_hw_stream_handle.vin_index];
			m2m_hw_stream_handle.vin_index = index;

			v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_in, b);
			filter_m2s_qbuf_count++;
		}
		if (fds[1].revents & POLLOUT && filter_m2s_qbuf_count > 0) {
			v_pipe->events[PROCESS_IN].counter_val++;
			b = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_post_process_in,
					m2m_hw_stream_handle.video_post_process_in.vid_buf);

			index = b->index;
			if (m2m_hw_stream_handle.process_in_index == -1) {
				m2m_hw_stream_handle.process_in_index = index;
				continue;
			}
			b  = &m2m_hw_stream_handle.video_post_process_in.vid_buf[m2m_hw_stream_handle.process_in_index];
			m2m_hw_stream_handle.process_in_index = index;

			v4l2_queue_buffer(&m2m_hw_stream_handle.video_in, b);
			filter_m2s_qbuf_count--;
		}
		if (fds[2].revents & POLLIN) {
			v_pipe->events[PROCESS_OUT].counter_val++;
			b = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_post_process_out,
					m2m_hw_stream_handle.video_post_process_out.vid_buf);

			index = b->index;
			if (m2m_hw_stream_handle.process_out_index == -1) {
				m2m_hw_stream_handle.process_out_index = index;
				continue;
			}
			b  = &m2m_hw_stream_handle.video_post_process_out.vid_buf[m2m_hw_stream_handle.process_out_index];
			m2m_hw_stream_handle.process_out_index = index;

			ret = drm_set_plane(&v_pipe->drm, b->index);
			if (ret < 0) {
				/* If the flip failed, requeue the buffer on the V4L2 side
				 * immediately.
				 */
				 v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out, b);
			} else {
				/* If the flip succeeded, the previous buffer is now released.
				 * Requeue it on the V4L2 side, and store the index of the new
				 * buffer.
				 */
				drm_wait_vblank(&v_pipe->drm, (void *)v_pipe);
				m2m_hw_stream_handle.pflip_pending = 1;
				if (m2m_hw_stream_handle.vout_index != -1)
					v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out,
						  &m2m_hw_stream_handle.video_post_process_out.vid_buf[m2m_hw_stream_handle.vout_index]);
					m2m_hw_stream_handle.vout_index = b->index;
				}

		}
		if (fds[3].revents & POLLIN) {
			/* Processes outstanding DRM events on the DRM file-descriptor*/
			ret = drmHandleEvent(v_pipe->drm.fd, &evctx);
			ASSERT(ret, "drmHandleEvent failed: %s\n", ERRSTR);
		}
	}

	/* push cleanup handler */
	pthread_cleanup_pop(1);

	return VLIB_SUCCESS;
}

/* Un-init m2m hw pipeline ->uninit HLS sobel module , stop the video stream and close video devices */
void uninit_m2m_hw_pipeline(void *ptr)
{
	int ret, i;
	drmEventContext evctx;

	struct video_pipeline *v_pipe = (struct video_pipeline *) ptr;
	/* Register drm event context */
	memset(&evctx, 0, sizeof evctx);
	evctx.version = DRM_EVENT_CONTEXT_VERSION;
	evctx.vblank_handler = drm_event_handler;

	/* Wait for pending vblanks events */
	while (m2m_hw_stream_handle.pflip_pending) {
		ret = drmHandleEvent(v_pipe->drm.fd, &evctx);
		ASSERT(ret, "drmHandleEvent failed: %s\n", ERRSTR);
		if (ret)
			break;
	}
	/* Set display to last buffer index */
	ret = drm_set_plane(&v_pipe->drm, BUFFER_CNT-1);

	ret = v4l2_device_off(&m2m_hw_stream_handle.video_in);
	ASSERT(ret < 0, "video_in :: stream-off failed\n");

	ret = v4l2_device_off(&m2m_hw_stream_handle.video_post_process_in);
	ASSERT(ret < 0, "video_post_process_in :: stream-off failed\n");

	ret = v4l2_device_off(&m2m_hw_stream_handle.video_post_process_out);
	ASSERT(ret < 0, "post_process_out :: stream-off failed\n");

	/* delete dumb buffers */
	for (i = 0; i < BUFFER_CNT; i++)
		close(m2m_hw_stream_handle.video_post_process_in.vid_buf[i].dbuf_fd);

	close(m2m_hw_stream_handle.video_in.fd);
	close(m2m_hw_stream_handle.video_post_process_in.fd);
	close(m2m_hw_stream_handle.video_post_process_out.fd);

if (v_pipe->enable_log_event) {
	ret = pthread_cancel(v_pipe->event_thread);
	ret = pthread_join(v_pipe->event_thread, NULL);
	ASSERT(ret < 0, "log_events :: pthread_join failed\n");
}
	v_pipe->eventloop = 0;
}
