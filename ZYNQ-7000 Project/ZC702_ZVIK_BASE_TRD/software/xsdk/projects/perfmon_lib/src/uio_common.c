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
* @file uio_common.c
*
* This file provides defines helper functions for UIO .
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



/***************************** Include Files *********************************/
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>

#include "uio_common.h"


/***************** Variable Definitions **************************************/
//static uio_info uio_info;

/************************** Function Implementation *************************/
static int line_from_file(char* filename, char* linebuf) {
    char* s;
    int i;

    FILE* fp = fopen(filename, "r");
    if (!fp)
    	return -1;

    s = fgets(linebuf, MAX_UIO_NAME_SIZE, fp);
    fclose(fp);
    if (!s)
    	return -2;

    for (i=0; (*s)&&(i<MAX_UIO_NAME_SIZE); i++) {
        if (*s == '\n')
	       	*s = 0;
        s++;
    }

    return 0;
}

static int uio_info_read_name(uio_info* info) {
    char file[MAX_UIO_PATH_SIZE];

    sprintf(file, "/sys/class/uio/uio%d/name", info->uio_num);

    return line_from_file(file, info->name);
}

static int uio_info_read_version(uio_info* info) {
    char file[MAX_UIO_PATH_SIZE];

    sprintf(file, "/sys/class/uio/uio%d/version", info->uio_num);

    return line_from_file(file, info->version);
}

static int uio_info_read_map_addr(uio_info* info, int n) {
    int ret;
    char file[MAX_UIO_PATH_SIZE];

    info->maps[n].addr = UIO_INVALID_ADDR;
    sprintf(file, "/sys/class/uio/uio%d/maps/map%d/addr", info->uio_num, n);

    FILE* fp = fopen(file, "r");
    if (!fp)
    	return -1;

    ret = fscanf(fp, "0x%x", &info->maps[n].addr);
    fclose(fp);
    if (ret < 0)
    	return -2;

    return 0;
}

static int uio_info_read_map_size(uio_info* info, int n) {
    int ret;
    char file[MAX_UIO_PATH_SIZE];

    sprintf(file, "/sys/class/uio/uio%d/maps/map%d/size", info->uio_num, n);

    FILE* fp = fopen(file, "r");
    if (!fp)
    	return -1;

    ret = fscanf(fp, "0x%x", &info->maps[n].size);
    fclose(fp);
    if (ret < 0)
    	return -2;

    return 0;
}

int uio_Initialize(uio_info *InfoPtr, const char* InstanceName) {
	struct dirent **namelist;
    int i, n;
    char* s;
    char file[MAX_UIO_PATH_SIZE];
    char name[MAX_UIO_NAME_SIZE];
    int flag = 0;

    n = scandir("/sys/class/uio", &namelist, 0, alphasort);
    if (n < 0)
    	return XST_DEVICE_NOT_FOUND;

    for (i = 0;  i < n; i++) {
		strcpy(file, "/sys/class/uio/");
		strcat(file, namelist[i]->d_name);
		strcat(file, "/name");

        if ((line_from_file(file, name) == 0) && (strcmp(name, InstanceName) == 0)) {
            flag = 1;
            s = namelist[i]->d_name;
            s += 3; // "uio"
            InfoPtr->uio_num = atoi(s);
            break;
        }
    }

    if (flag == 0)
    	return XST_DEVICE_NOT_FOUND;

    uio_info_read_name(InfoPtr);
    uio_info_read_version(InfoPtr);

    for (n = 0; n < MAX_UIO_MAPS; ++n) {
        uio_info_read_map_addr(InfoPtr, n);
        uio_info_read_map_size(InfoPtr, n);
    }

    InfoPtr->isInitialized = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}

int uio_get_Handler(uio_info *InfoPtr, uio_handle *handle, int map_count)
{
	char file[ MAX_UIO_PATH_SIZE ];
	int i ;
	assert(InfoPtr != NULL);
	assert(map_count <= MAX_UIO_MAPS);
	assert(InfoPtr->isInitialized == XIL_COMPONENT_IS_READY);

	sprintf(file, "/dev/uio%d", InfoPtr->uio_num);
	if ((InfoPtr->uio_fd = open(file, O_RDWR)) < 0) {
		return XST_OPEN_DEVICE_FAILED;
	}

	for (i = 0; i < map_count; i++) {
		// NOTE: slave interface 'Control_bus' should be mapped to uioX/map[i]
		handle->params[i] = mmap(NULL, InfoPtr->maps[i].size, PROT_READ|PROT_WRITE,
				MAP_SHARED, InfoPtr->uio_fd, 0 * getpagesize());
		assert(handle->params[i]);
	}
	/* Assigning Control bus address for backward compatibilty */
	handle->Control_bus_BaseAddress = handle->params[0];
	handle->IsReady = XIL_COMPONENT_IS_READY;

	return XST_SUCCESS;
}

int uio_release_handle(uio_info *InfoPtr, uio_handle *handle, int map_count)
{
	int i ;
	assert(handle != NULL);
	assert(map_count <= MAX_UIO_MAPS);
	assert(InfoPtr->isInitialized == XIL_COMPONENT_IS_READY);
	assert(handle->IsReady == XIL_COMPONENT_IS_READY);

	for (i = 0; i < map_count; i++) {
		munmap(handle->params[i], InfoPtr->maps[i].size);
	}

	close(InfoPtr->uio_fd);

	handle->Control_bus_BaseAddress = NULL;
	handle->IsReady = XIL_COMPONENT_NOT_READY;

	return XST_SUCCESS;
}

int uio_Release(uio_info *InfoPtr) {

    assert(InfoPtr != NULL);
    assert(InfoPtr->isInitialized == XIL_COMPONENT_IS_READY);

    InfoPtr->isInitialized = XIL_COMPONENT_NOT_READY;

    return XST_SUCCESS;
}
