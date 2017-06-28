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
* @file uio_common.h
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

#ifndef UIO_COMMON_H_
#define UIO_COMMON_H_


/***************** Macros (Inline Functions) Definitions *********************/
#define MAX_UIO_PATH_SIZE       256
#define MAX_UIO_NAME_SIZE       64
#define MAX_UIO_MAPS            5
#define UIO_INVALID_ADDR        0

/**
 * @name Macros for Modes of APM
 *
 */
#define XAPM_MODE_TRACE			2 /**< APM in Trace mode */
#define XAPM_MODE_PROFILE		1 /**< APM in Profile mode */
#define XAPM_MODE_ADVANCED		0 /**< APM in Advanced mode */

/**************************** Type Definitions ******************************/

typedef unsigned int u32;
typedef unsigned char u8;
typedef unsigned short int u16;

typedef struct {
    u32 addr;
    u32 size;
} uio_map;

typedef struct {
	int isInitialized;
	int  uio_fd;
    int  uio_num;
    char name[ MAX_UIO_NAME_SIZE ];
    char version[ MAX_UIO_NAME_SIZE ];
    uio_map maps[ MAX_UIO_MAPS ];
} uio_info;

typedef struct {
	void *Control_bus_BaseAddress; /**< XAxiPmon_Config of current device */
	void *params[MAX_UIO_MAPS];
	u32 IsReady; /**< Device is initialized and ready  */
} uio_handle;

//Err code
enum err_code
{
	XST_SUCCESS,
	XST_DEVICE_NOT_FOUND,
	XST_OPEN_DEVICE_FAILED,
	XST_ERR_TIMEOUT
};

//States
#define XIL_COMPONENT_IS_READY  1
#define XIL_COMPONENT_NOT_READY 0

// Reg read/write macro.
#define HW_WRITE(addr, off, val) (*(volatile unsigned int*)(addr+off)=(val))
#define HW_READ(addr,off) (*(volatile unsigned int*)(addr+off))

#define SHIFT_16	16

// uio api
int uio_Initialize(uio_info *InfoPtr, const char* InstanceName);
int uio_get_Handler(uio_info *InfoPtr, uio_handle *handle, int map_count);
int uio_release_handle(uio_info *InfoPtr, uio_handle *handle, int map_count);


#endif /* UIO_COMMON_H_ */
