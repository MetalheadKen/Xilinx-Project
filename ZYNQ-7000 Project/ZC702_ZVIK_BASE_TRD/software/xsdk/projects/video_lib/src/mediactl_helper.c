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
* @file mediactl_helper.c
*
* This file implements the  helper functions for media library.
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
#include "mediactl_helper.h"

#define MEDIA_G_DVTIMINGS_RETRY_CNT 20


/*Print media device details */ 
void print_media_info(const struct media_device_info *info)
{
	printf("Media controller API version %u.%u.%u\n\n",
						   (info->media_version << 16) & 0xff,
						   (info->media_version << 8) & 0xff,
						   (info->media_version << 0) & 0xff);
	printf("Media device information\n"
						   "------------------------\n"
						   "driver			%s\n"
						   "model			%s\n"
						   "serial			%s\n"
						   "bus info		%s\n"
						   "hw revision 	0x%x\n"
						   "driver version	%u.%u.%u\n\n",
						   info->driver, info->model,
						   info->serial, info->bus_info,
						   info->hw_revision,
						   (info->driver_version << 16) & 0xff,
						   (info->driver_version << 8) & 0xff,
						   (info->driver_version << 0) & 0xff);
}

int set_media_control(struct video_pipeline *s, media_node node)
{
	struct media_device *media;
	struct v4l2_dv_timings timings;
	struct media_pad *pad;
	char media_devname[DEV_NAME_LEN];
	char media_formats[100];
	int ret = -1;
	int retry_cnt = MEDIA_G_DVTIMINGS_RETRY_CNT;

	/* TODO: obtain media node based on model instead of number */
	sprintf(media_devname, "/dev/media%d", node);

	/* Set media device node */
	media = media_device_new(media_devname);
	ASSERT(!media, "Failed to create media device %s\n", media_devname);

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	ASSERT(ret < 0, "Failed to enumerate %s\n", media_devname);

#ifdef DEBUG_MODE
	const struct media_device_info *info = media_get_info(media);
	print_media_info(info);
#endif

	memset(media_formats, 0, sizeof (media_formats));

	switch (node) {
		/* VCAP HDMI */
		case MEDIA_NODE_0:
			/* Skip initialization if FMC is not present */
			if (!s->hdmii_present)
				break;

			/* Get ADV7611 pad */
			pad = media_parse_pad(media, MEDIA_HDMI_PAD, NULL);
			ASSERT(pad == NULL, "Pad '%s' not found\n", MEDIA_HDMI_PAD);

			/* Repeat query dv_timings as occasionally the reported timings are incorrect */
			do {
				ret = v4l2_subdev_query_dv_timings(pad->entity, &timings);
				ASSERT(ret, "Failed to query DV timings: %s\n", strerror(ret));
			} while (timings.bt.width != s->w || timings.bt.height != s->h || !retry_cnt--);
			ASSERT(!retry_cnt, "Incorrect ADV7611 DV timings (%dx%d)\n", timings.bt.width, timings.bt.height);

			/* Set ADV7611 DV timing */
			ret = v4l2_subdev_set_dv_timings(pad->entity, &timings);
			ASSERT(ret < 0, "Failed to set DV timings: %s\n", strerror(ret));

			/* Set ADV7611 resolution */
			sprintf(media_formats, MEDIA_HDMI_FMT, 1, s->w, s->h);
			ret = v4l2_subdev_parse_setup_formats(media, media_formats);
			ASSERT(ret, "Unable to setup formats: %s (%d)\n", strerror(-ret), -ret);

			break;
		/* VCAP TPG */
		case MEDIA_NODE_1:
			/* Set TPG input resolution */
			sprintf(media_formats, MEDIA_TPG_FMT, 0, s->w, s->h);
			ret = v4l2_subdev_parse_setup_formats(media, media_formats);
			ASSERT(ret, "Unable to setup formats: %s (%d)\n", strerror(-ret), -ret);

			break;
		/* VM2M HLS */
		case MEDIA_NODE_2:
			/* Set HLS input resolution */
			sprintf(media_formats, MEDIA_HLS_FMT, 0, s->w, s->h);
			ret = v4l2_subdev_parse_setup_formats(media, media_formats);
			ASSERT(ret, "Unable to setup formats: %s (%d)\n", strerror(-ret), -ret);

			memset (media_formats, 0, sizeof (media_formats));

			/* Set HLS output resolution */
			sprintf(media_formats, MEDIA_HLS_FMT, 1, s->w, s->h);
			ret = v4l2_subdev_parse_setup_formats(media, media_formats);
			ASSERT(ret, "Unable to setup formats: %s (%d)\n", strerror(-ret), -ret);

			break;
		/* DEFAULT */
		default:
			break;
	}

	if (media)
		media_device_unref(media);

	return 0;
}

/* Helper function to search for an entity with a name equal to @name*/
int get_entity_state(media_node node, char *name)
{
	struct media_entity *entity;
	struct media_device *media;
	int status = 0, ret = 0;
	char dev_name[DEV_NAME_LEN];

	/* Set media device node */
	sprintf(dev_name, "/dev/media%d", node);
	media = media_device_new(dev_name);
	ASSERT(!media, "Failed to create media device device\n");

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	ASSERT(ret < 0, "Failed to enumerate %s (%d)\n", dev_name, ret);

	/* Check if entity is present */
	entity = media_get_entity_by_name(media, name, strlen(name));
	if (entity)
		status = 1;

	if (media)
		media_device_unref(media);

	return status;
}

/* Helper function that returns the full path and name to the device node 
 * corresponding to the given entity i.e (/dev/v4l-subdev* )  */
int get_entity_devname(media_node node, char *name, char *subdev_name)
{
	struct media_device *media;
	struct media_entity *entity;
	const char *entity_node_name;
	char dev_name[DEV_NAME_LEN];
	int ret;

	/* Set media device node */
	sprintf(dev_name, "/dev/media%d", node);
	media = media_device_new(dev_name);
	ASSERT(!media, "Failed to create media device\n");

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	ASSERT(ret < 0, "Failed to enumerate '%s'\n", dev_name);

	entity = media_get_entity_by_name(media, name, strlen(name));
	ASSERT(!entity, "Entity '%s' not found\n", name);

	entity_node_name = media_entity_get_devname(entity);
	ASSERT(!entity_node_name, "Entity '%s' has no device node name\n", name);

	strcpy(subdev_name, entity_node_name);
	media_device_unref(media);
	return VLIB_SUCCESS;
}

/* Helper function that retrieve the detected digital video timings for the currently
     selected input of @entity_name and store them in the @timings structure */
int  query_entity_dv_timings(media_node node,char *entity_name ,struct v4l2_dv_timings *timings )
{
	struct media_device *media;
	struct media_pad *pad;
	int ret = 0;
	char dev_name[DEV_NAME_LEN];

	/* Set media device node */
	sprintf(dev_name, "/dev/media%d", node);
	media = media_device_new(dev_name);
	ASSERT(!media, "Failed to create media device device\n");

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	ASSERT(ret < 0, "Failed to enumerate %s (%d)\n", dev_name, ret);

	pad = media_parse_pad(media, entity_name, NULL);
	ASSERT(!pad ,"Pad '%s' not found\n", entity_name);

	ret = v4l2_subdev_query_dv_timings(pad->entity, timings);

	if (media)
		media_device_unref(media);
	return ret;
}
