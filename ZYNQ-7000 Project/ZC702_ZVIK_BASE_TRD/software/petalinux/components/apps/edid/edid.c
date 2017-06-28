/*
 * edid --  V4L2 EDID Setup Application
 *
 * Copyright (C) 2014 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <sys/ioctl.h>
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <linux/v4l2-subdev.h>
#include <linux/videodev2.h>

int main(int argc, char *argv[])
{
	struct v4l2_subdev_edid edid = { .blocks = 2, };
	unsigned int pad;
	uint8_t data[256];
	ssize_t len;
	char *endp;
	int fd;
	int ret;


	if (argc != 4) {
		printf("Usage: %s device pad edid-file\n", argv[0]);
		return 1;
	}

	pad = strtol(argv[2], &endp, 0);
	if (*endp != 0) {
		printf("Invalid pad number '%s'\n", argv[2]);
		return 1;
	}

	fd = open(argv[3], O_RDONLY);
	if (fd < 0) {
		printf("Failed to open EDID file '%s': %s\n", argv[3],
		       strerror(errno));
		return 1;
	}

	len = read(fd, data, 256);
	close(fd);

	if (len < 0) {
		printf("Failed to read EDID file '%s': %s\n", argv[3],
		       strerror(errno));
		return 1;
	} else if (len != 256) {
		printf("EDID data must be 256 bytes long\n");
		return 1;
	}

	fd = open(argv[1], O_RDWR);
	if (fd < 0) {
		printf("Error opening device '%s': %s\n", argv[1],
		       strerror(errno));
		return 1;
	}

	edid.pad = pad;
	edid.edid = data;

	ret = ioctl(fd, VIDIOC_SUBDEV_S_EDID, &edid);
	if (ret < 0) {
		printf("Failed to set EDID: %s\n", strerror(errno));
		ret = 1;
	} else {
		printf("EDID set successfully.\n");
		ret = 0;
	}

	close(fd);

	return ret;
}
