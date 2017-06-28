/******************************************************************************
*
* (c) Copyright 2012 Xilinx, Inc. All rights reserved.
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
******************************************************************************/
/*****************************************************************************/
/**
 *  @file xaxivdma_i.h
 *
 * Internal API definitions shared by driver files.
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 1.00a jz   08/18/10 First release
 * 2.00a jz   12/10/10 Added support for direct register access mode, v3 core
 * 2.01a jz   01/19/11 Added ability to re-assign BD addresses
 *		       Replaced include xenv.h with string.h in xaxivdma_i.h
 * 		       file.
 *  	 rkv  03/28/11 Added support for frame store register.
 * 3.00a srt  08/26/11 Added support for Flush on Frame Sync and dynamic 
 *		       programming of Line Buffer Thresholds.
 * 4.00a srt  11/21/11 Added support for 32 Frame Stores and modified bit  
 *		       mask of Park Offset Register.
 *		       Added support for GenLock & Fsync Source Selection.
 * </pre>
 *
 *****************************************************************************/

#ifndef XAXIVDMA_I_H_    /* prevent circular inclusions */
#define XAXIVDMA_I_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <string.h>        /* memset */
#include "xil_types.h"
#include "xdebug.h"

/************************** Constant Definitions *****************************/
/**************************** Type Definitions *******************************/
/* Buffer Descriptor (BD) is only visible in this file
 */
typedef u32 XAxiVdma_Bd[XAXIVDMA_BD_MINIMUM_ALIGNMENT_WD];

/* The DMA channel is only visible to driver files
 */
typedef struct {
    u32 ChanBase;       /* Base address for this channel */
    u32 InstanceBase;   /* Base address for the whole device */
    u32 StartAddrBase;  /* Start address register array base */

    int IsValid;        /* Whether the channel has been initialized */
    int FlushonFsync;	/* VDMA Transactions are flushed & channel states
			   reset on Frame Sync */
    int HasSG;          /* Whether hardware has SG engine */
    int IsRead;         /* Read or write channel */
    int HasDRE;         /* Whether support unaligned transfer */
    int LineBufDepth;	/* Depth of Channel Line Buffer FIFO */
    int LineBufThreshold;	/* Threshold point at which Channel Line
                     	 	 *  almost empty flag asserts high */
    int WordLength;     /* Word length */
    int NumFrames;	/* Number of frames to work on */

    u32 HeadBdPhysAddr; /* Physical address of the first BD */
    u32 HeadBdAddr;     /* Virtual address of the first BD */
    u32 TailBdPhysAddr; /* Physical address of the last BD */
    u32 TailBdAddr;     /* Virtual address of the last BD */
    int Hsize;          /* Horizontal size */
    int Vsize;          /* Vertical size saved for no-sg mode hw start */

    int AllCnt;         /* Total number of BDs */

    int GenLock;	/* Mm2s Gen Lock Mode */
    int S2MmSOF;	/* S2MM Start of Flag */
    XAxiVdma_Bd BDs[XAXIVDMA_MAX_FRAMESTORE] __attribute__((__aligned__(32)));
                        /*Statically allocated BDs */
}XAxiVdma_Channel;

/* Duplicate layout of XAxiVdma_DmaSetup
 *
 * So to remove the dependency on xaxivdma.h
 */
typedef struct {
    int VertSizeInput;      /**< Vertical size input */
    int HoriSizeInput;      /**< Horizontal size input */
    int Stride;             /**< Stride */
    int FrameDelay;         /**< Frame Delay */

    int EnableCircularBuf;  /**< Circular Buffer Mode? */
    int EnableSync;         /**< Gen-Lock Mode? */
    int PointNum;           /**< Master we synchronize with */
    int EnableFrameCounter; /**< Frame Counter Enable */
    u32 FrameStoreStartAddr[XAXIVDMA_MAX_FRAMESTORE];
                            /**< Start Addresses of Frame Store Buffers. */
    int FixedFrameStoreAddr;/**< Fixed Frame Store Address index */
}XAxiVdma_ChannelSetup;

/************************** Function Prototypes ******************************/
/* Channel API
 */
void XAxiVdma_ChannelInit(XAxiVdma_Channel *Channel);
void XAxiVdma_ChannelReset(XAxiVdma_Channel *Channel);
int XAxiVdma_ChannelResetNotDone(XAxiVdma_Channel *Channel);
int XAxiVdma_ChannelIsRunning(XAxiVdma_Channel *Channel);
int XAxiVdma_ChannelIsBusy(XAxiVdma_Channel *Channel);
u32 XAxiVdma_ChannelGetStatus(XAxiVdma_Channel *Channel);
void XAxiVdma_ChannelRegisterDump(XAxiVdma_Channel *Channel);

int XAxiVdma_ChannelStartParking(XAxiVdma_Channel *Channel);
void XAxiVdma_ChannelStopParking(XAxiVdma_Channel *Channel);
void XAxiVdma_ChannelStartFrmCntEnable(XAxiVdma_Channel *Channel);

void XAxiVdma_ChannelEnableIntr(XAxiVdma_Channel *Channel, u32 IntrType);
void XAxiVdma_ChannelDisableIntr(XAxiVdma_Channel *Channel, u32 IntrType);
u32 XAxiVdma_ChannelGetPendingIntr(XAxiVdma_Channel *Channel);
u32 XAxiVdma_ChannelGetEnabledIntr(XAxiVdma_Channel *Channel);
void XAxiVdma_ChannelIntrClear(XAxiVdma_Channel *Channel, u32 IntrType);
int XAxiVdma_ChannelStartTransfer(XAxiVdma_Channel *Channel,
        XAxiVdma_ChannelSetup *ChannelCfgPtr);
int XAxiVdma_ChannelSetBdAddrs(XAxiVdma_Channel *Channel, u32 BdAddrPhys,
          u32 BdAddrVirt);
int XAxiVdma_ChannelConfig(XAxiVdma_Channel *Channel,
        XAxiVdma_ChannelSetup *ChannelCfgPtr);
int XAxiVdma_ChannelSetBufferAddr(XAxiVdma_Channel *Channel, u32 *AddrSet,
        int NumFrames);
int XAxiVdma_ChannelStart(XAxiVdma_Channel *Channel);
void XAxiVdma_ChannelStop(XAxiVdma_Channel *Channel);
int XAxiVdma_ChannelSetFrmCnt(XAxiVdma_Channel *Channel, u8 FrmCnt,
        u8 DlyCnt);
void XAxiVdma_ChannelGetFrmCnt(XAxiVdma_Channel *Channel, u8 *FrmCnt,
        u8 *DlyCnt);
u32 XAxiVdma_ChannelErrors(XAxiVdma_Channel *Channel);
void XAxiVdma_ClearChannelErrors(XAxiVdma_Channel *Channel, u32 ErrorMask);
#ifdef __cplusplus
}
#endif

#endif
