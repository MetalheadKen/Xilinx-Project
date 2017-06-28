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
*
* @file xaxivdma.h
*
* This is the Xilinx MVI AXI Video DMA device driver. The DMA engine transfers
* frames from the AXI Bus or to the AXI Bus. It is in the chain of video
* IPs, which process video frames.
*
* It supports the following features:
*  - Continuous transfers of video frames, AKA circular buffer mode
*  - Continuous transfers of one specific video frame, AKA park mode
*  - Optionally only transfer a certain amount of video frames
*  - Optionally transfer unaligned frame buffers
*
* An AXI Video DMA engine can have one or two channels. If configured as two
* channels, then one of the channels reads data from memory, and the other
* channel writes to the memory.
*
* For a full description of AXI Video DMA features, please see the hardware
* spec.
*
* The driver composes of three parts: initialization, start a DMA transfer, and
* interrupt handling.
*
* <b> Driver Initialization </b>
*
* To initialize the driver, the caller needs to pass a configuration structure
* to the driver. This configuration structure contains information about the
* hardware build.
*
* A caller can manually setup the configuration structure, or call
* XAxiVdma_LoopkupConfig().
*
* The sequence of initialization of the driver is:
*  1. XAxiVdma_LookupConfig() to get the configuration structure, or manually
*     setup the structure.
*  2. XAxiVdma_CfgInitialize() to initialize the driver & device.
*  3. XAxiVdma_SetFrmStore() to set the desired frame store number which
*     is optional.
*  4. If interrupt is desired:
*     - Set frame counter using XAxiVdma_SetFrameCounter()
*     - Set call back functions for each channel. There are two types of call
*       backfunctions: general and error
*     - Enable interrupts that the user cares about
*
* <b>Start a DMA Transaction </b>
*
* If you are using the driver API to start the transfer, then there are two
* ways to start a DMA transaction:
*
* 1. Invoke XAxiVdma_StartWriteFrame() or XAxiVdma_StartReadFrame() to start a
*    DMA operation, depending on the purpose of the transfer (Read or Write).
*
* 2. Or, call the phased functions as the following:
*    - Call XAxiVdma_DmaConfig() to set up a DMA operation configuration
*    - Call XAxiVdma_DmaSetBufferAddr() to set up the DMA buffers
*    - Call XAxiVdma_DmaStart() to kick off the DMA operation
*
* If you are writing your own functions to start the transfer, the order of
* setting up the hardware must be the following:
*
* - Do any processing or setting, but do not start the hardware, means do not
* set the RUN/STOP bit in the XAXIVDMA_CR_OFFSET register.
* - After any reset you need to do, write the head of your BD ring into the
* XAXIVDMA_CDESC_OFFSET register.
* - You can do other setup for the harware.
* - Start your hardware, by setting up the RUN/STOP bit in the
* XAXIVDMA_CR_OFFSET register.
* - You can do other setup for the hardware.
* - If you are done with all the setup, now write the tail of your BD ring to
* the XAXIVDMA_TDESC_OFFSET register to start the transfer.
*
* You can refer to XAxiVdma_ChannelStartTransfer() to see how this order is
* preserved there. The function is in xaxivdma_channel.c.
*
* Note a Read VDMA could work with one out of multiple write VDMA instances
* and vice versa. The PointNum in structure XAxiVdma_DmaSetup decides which
* VDMA instance this VDMA is working with.
*
* <b>Interrupt Handling </b>
*
* Each VDMA channel supports 2 kinds of interrupts:
* - General Interrupt: An interrupt other than error interrupt.
* - Error Interrupt: An error just happened.
*
* The driver does the interrupt handling, and dispatch to the user application
* through callback functions that user has registered. If there are no
* registered callback functions, then a stub callback function is called.
*
* Each channel has two interrupt callback functions. One for IOC and delay
* interrupt, or general interrupt; one for error interrupt.
*
* <b>Reset</b>
*
* Reset a DMA channel causes the channel enter the following state:
*
* - Interrupts are disabled
* - Coalescing threshold is one
* - Delay counter is 0
* - RUN/STOP bit low
* - Halted bit high
* - XAXIVDMA_CDESC_OFFSET register has 0
* - XAXIVDMA_TDESC_OFFSET register has 0
*
* If there is an active transfer going on when reset (or stop) is issued to
* the hardware, the current transfer will gracefully finish. For a maximum
* transfer length of (0x1FFF * 0xFFFF) bytes, on a 100 MHz system, it can take
* as long as 1.34 seconds, assuming that the system responds to DMA engine's
* requests quickly.
*
* To ensure that the hardware finishes the reset, please use
* XAxiVdma_ResetNotDone() to check for completion of the reset.
*
* To start a transfer after a reset, the following actions are the minimal
* requirement before setting RUN/STOP bit high to avoid crashing the system:
*
* - XAXIVDMA_CDESC_OFFSET register has a valid BD pointer, it should be the
* head of the BD ring.
* - XAXIVDMA_TDESC_OFFSET register has a valid BD pointer, it should be the
* tail of the BD ring.
*
* If you are using the driver API to start a transfer after a reset, then it
* should be fine.
*
* <b>Stop</b>
*
* Stop a channel using XAxiVDma_DmaStop() is similar to a reset, except the
* registers are kept intact.
*
* To start a transfer after a stop:
*
* - If there are error bits in the status register, then a reset is necessary.
* Please refer to the <b>Reset</b> section for more details on how to start a
* transfer after a reset.
* - If there are no error bits in the status register, then you can call
* XAxiVdma_DmaStart() to start the transfer again. Note that the transfer
* always starts from the first video frame.
*
* <b> Examples</b>
*
* We provide one example on how to use the AXI VDMA with AXI Video IPs. This
* example does not work by itself. To make it work, you must have two other
* Video IPs to connect to the VDMA. One of the Video IP does the write and the
* other does the read.
*
* <b>Cache Coherency</b>
*
* This driver does not handle any cache coherency for the data buffers.
* The application is responsible for handling cache coherency, if the cache
* is enabled.
*
* <b>Alignment</b>
*
* The VDMA supports any buffer alignment when DRE is enabled in the hardware
* configuration. It only supports word-aligned buffers otherwise. Note that
* "word" is defined by C_M_AXIS_MM2S_TDATA_WIDTH and C_S_AXIS_S2MM_TDATA_WIDTH
* for the read and write channel specifically.
*
* If the horizonal frame size is not word-aligned, then DRE must be enabled
* in the hardware. Otherwise, undefined results happen.
*
* <b>Address Translation</b>
*
* Buffer addresses for transfers are physical addresses. If the system does not
* use MMU, then physical and virtual addresses are the same.
*
* <b>API Change from PLB Video DMA</b>
*
* We try to keep the API as consistent with the PLB Video DMA driver as
* possible. However, due to hardware differences, some of the PLB video DMA
* driver APIs are changed or removed. Two API functions are added to the AXI
* DMA driver.
*
* For details on the API changes, please refer to xaxivdma_porting_guide.h.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 1.00a jz   08/16/10 First release
* 2.00a jz   12/10/10 Added support for direct register access mode, v3 core
* 2.01a jz   01/19/11 Added ability to re-assign BD addresses
*		      Replaced include xenv.h with string.h in xaxivdma_i.h
* 		      file.
* 2.01a	rkv  03/28/11 Added support for frame store register and 
*                     XAxiVdma_ChannelInit API is changed.
* 3.00a srt  08/26/11 - Added support for Flush on Frame Sync and dynamic 
*		      	programming of Line Buffer Thresholds.
*		      - XAxiVdma_ChannelErrors API is changed to support for
*			Flush on Frame Sync feature.
*		      - Two flags, XST_VDMA_MISMATCH_ERROR & XAXIVDMA_MIS
*			MATCH_ERROR are added to report error status when
*			Flush on Frame Sync feature is enabled.		    
* 4.00a srt  11/21/11 - XAxiVdma_ChannelSetBufferAddr API is changed to
*			support 32 Frame Stores.
*		      - XAxiVdma_ChannelConfig API is changed to support
*			modified Park Offset Register bits.
*		      - Added APIs: 
*			XAxiVdma_FsyncSrcSelect()
*			XAxiVdma_GenLockSourceSelect()
*		      - Modified structures XAxiVdma_Config and XAxiVdma to
*		        include new parameters.
* 4.01a srt  06/13/12 - Added APIs:
*			XAxiVdma_GetDmaChannelErrors()
*			XAxiVdma_ClearDmaChannelErrors()
*			XAxiVdma_ClearChannelErrors()
*		      - XAxiVdma_ChannelErrors API is changed to remove 
*			Mismatch error logic.
*		      - Removed Error checking logic in the channel APIs.
*			Provided User APIs to do this.
*		      - Added new error bit mask XAXIVDMA_SR_ERR_SOF_LATE_MASK
*		      - XAXIVDMA_MISMATCH_ERROR flag is deprecated.
* 		      - Modified the logic of Error handling in interrupt
*		        handlers. 
* 4.02a srt  10/11/12 - Fixed CR 678734
*                       Description - XAxiVdma_SetFrmStore function changed to
*                       remove Reset logic after setting number of frame
*                       stores.
*                     - Changed Error bitmasks to support IP version 5.02a.
*                       (CR 679959)
* </pre>
*
******************************************************************************/

#ifndef XAXIVDMA_H_     /* Prevent circular inclusions */
#define XAXIVDMA_H_     /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xaxivdma_hw.h"
#include "xaxivdma_i.h"
#include "xstatus.h"
#include "xil_assert.h"


/************************** Constant Definitions *****************************/

/**
 * VDMA data transfer direction
 */
#define XAXIVDMA_WRITE       1        /**< DMA transfer into memory */
#define XAXIVDMA_READ        2        /**< DMA transfer from memory */

/**
 * Frame Sync Source Selection 
 */
#define XAXIVDMA_CHAN_FSYNC		0
#define XAXIVDMA_CHAN_OTHER_FSYNC	1
#define XAXIVDMA_S2MM_TUSER_FSYNC	2

/**
 * GenLock Source Selection 
 */
#define XAXIVDMA_EXTERNAL_GENLOCK	0
#define XAXIVDMA_INTERNAL_GENLOCK	1

/**
 * Interrupt type for setting up callback
 */
#define XAXIVDMA_HANDLER_GENERAL   1  /**< Non-Error Interrupt Type */
#define XAXIVDMA_HANDLER_ERROR     2  /**< Error Interrupt Type */

/**
 * Flag to signal that device is ready to be used
 */
#define XAXIVDMA_DEVICE_READY      0x11111111

/* Defined for backward compatiblity.
 * This  is a typical DMA Internal Error, which on detection doesnt require a
 * reset (as opposed to other errors). So user on seeing this need only to
 * reinitialize channels.
 *
 */
#ifndef XST_VDMA_MISMATCH_ERROR
#define XST_VDMA_MISMATCH_ERROR 1430
#endif

/**************************** Type Definitions *******************************/

/*****************************************************************************/
/**
 * Callback type for general interrupts
 *
 * @param   CallBackRef is a callback reference passed in by the upper layer
 *          when setting the callback functions, and passed back to the
 *          upper layer when the callback is called.
 * @param   InterruptTypes indicates the detailed type(s) of the interrupt.
 *          Its value equals 'OR'ing one or more XAXIVDMA_IXR_* values defined
 *          in xaxivdma_hw.h
 *****************************************************************************/
typedef void (*XAxiVdma_CallBack) (void *CallBackRef, u32 InterruptTypes);

/*****************************************************************************/
/**
 * Callback type for Error interrupt.
 *
 * @param   CallBackRef is a callback reference passed in by the upper layer
 *          when setting the callback function, and it is passed back to the
 *          upper layer when the callback is called.
 * @param   ErrorMask is a bit mask indicating the cause of the error. Its
 *          value equals 'OR'ing one or more XAXIVDMA_IXR_* values defined in
 *          xaxivdma_hw.h
 *****************************************************************************/
typedef void (*XAxiVdma_ErrorCallBack) (void *CallBackRef, u32 ErrorMask);

/**
 * This typedef contains the hardware configuration information for a VDMA
 * device. Each VDMA device should have a configuration structure associated
 * with it.
 */
typedef struct {
    u16 DeviceId;         /**< DeviceId is the unique ID  of the device */
    u32 BaseAddress;      /**< BaseAddress is the physical base address of the
                            *  device's registers */
    u16 MaxFrameStoreNum; /**< The maximum number of Frame Stores */
    int HasMm2S;          /**< Whether hw build has read channel */
    int HasMm2SDRE;       /**< Read channel supports unaligned transfer */
    int Mm2SWordLen;      /**< Read channel word length */
    int HasS2Mm;          /**< Whether hw build has write channel */
    int HasS2MmDRE;       /**< Write channel supports unaligned transfer */
    int S2MmWordLen;      /**< Write channel word length */
    int HasSG;            /**< Whether hardware has SG engine */
    int EnableVIDParamRead;
    			  /**< Read Enable for video parameters in direct
    			    *  register mode */
    int UseFsync;	  /**< DMA operations synchronized to Frame Sync */
    int FlushonFsync;	  /**< VDMA Transactions are flushed & channel states
			    *	reset on Frame Sync */ 
    int Mm2SBufDepth;	  /**< Depth of Read Channel Line Buffer FIFO */
    int S2MmBufDepth;	  /**< Depth of Write Channel Line Buffer FIFO */
    int Mm2SGenLock;	  /**< Mm2s Gen Lock Mode */
    int S2MmGenLock;	  /**< S2Mm Gen Lock Mode */
    int InternalGenLock;  /**< Internal Gen Lock */
    int S2MmSOF;	  /**< S2MM Start of Flag Enable */
} XAxiVdma_Config;

/**
 * The XAxiVdma_DmaSetup structure contains all the necessary information to
 * start a frame write or read.
 *
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
} XAxiVdma_DmaSetup;

/**
 * The XAxiVdmaFrameCounter structure contains the interrupt threshold settings
 * for both the transmit and the receive channel.
 *
 */
typedef struct {
    u8 ReadFrameCount;      /**< Interrupt threshold for Receive */
    u8 ReadDelayTimerCount; /**< Delay timer threshold for receive */
    u8 WriteFrameCount;     /**< Interrupt threshold for transmit */
    u8 WriteDelayTimerCount;/**< Delay timer threshold for transmit */
} XAxiVdma_FrameCounter;

/**
 * Channel callback functions
 */
typedef struct {
    XAxiVdma_CallBack CompletionCallBack; /**< Call back for completion intr */
    void *CompletionRef;                  /**< Call back ref */

    XAxiVdma_ErrorCallBack ErrCallBack;   /**< Call back for error intr */
    void *ErrRef;                         /**< Call back ref */
} XAxiVdma_ChannelCallBack;

/**
 * The XAxiVdma driver instance data.
 */
typedef struct {
    u32 BaseAddr;                   /**< Memory address for this device */
    int HasSG;                      /**< Whether hardware has SG engine */
    int IsReady;                    /**< Whether driver is initialized */

    int MaxNumFrames;                /**< Number of frames to work on */
    int HasMm2S;                    /**< Whether hw build has read channel */
    int HasMm2SDRE;                 /**< Whether read channel has DRE */
    int HasS2Mm;                    /**< Whether hw build has write channel */
    int HasS2MmDRE;                 /**< Whether write channel has DRE */
    int EnableVIDParamRead;	    /**< Read Enable for video parameters in
    				      *  direct register mode */
    int UseFsync;       	    /**< DMA operations synchronized to
				      * Frame Sync */
    int InternalGenLock;  	    /**< Internal Gen Lock */
    XAxiVdma_ChannelCallBack ReadCallBack;  /**< Call back for read channel */
    XAxiVdma_ChannelCallBack WriteCallBack; /**< Call back for write channel */

    XAxiVdma_Channel ReadChannel;  /**< Channel to read from memory */
    XAxiVdma_Channel WriteChannel; /**< Channel to write to memory */
} XAxiVdma;


/************************** Function Prototypes ******************************/
/* Initialization */
XAxiVdma_Config *XAxiVdma_LookupConfig(u16 DeviceId);

int XAxiVdma_CfgInitialize(XAxiVdma *InstancePtr, XAxiVdma_Config *CfgPtr,
					u32 EffectiveAddr);

/* Engine and channel operations */
void XAxiVdma_Reset(XAxiVdma *InstancePtr, u16 Direction);
int XAxiVdma_ResetNotDone(XAxiVdma *InstancePtr, u16 Direction);
int XAxiVdma_IsBusy(XAxiVdma *InstancePtr, u16 Direction);
u32 XAxiVdma_CurrFrameStore(XAxiVdma *InstancePtr, u16 Direction);
u32 XAxiVdma_GetVersion(XAxiVdma *InstancePtr);
u32 XAxiVdma_GetStatus(XAxiVdma *InstancePtr, u16 Direction);
int XAxiVdma_SetLineBufThreshold(XAxiVdma *InstancePtr, int LineBufThreshold,
	u16 Direction);
int XAxiVdma_StartParking(XAxiVdma *InstancePtr, int FrameIndex,
         u16 Direction);
void XAxiVdma_StopParking(XAxiVdma *InstancePtr, u16 Direction);
void XAxiVdma_StartFrmCntEnable(XAxiVdma *InstancePtr, u16 Direction);

void XAxiVdma_IntrEnable(XAxiVdma *InstancePtr, u32 IntrType, u16 Direction);
void XAxiVdma_IntrDisable(XAxiVdma *InstancePtr, u32 IntrType ,u16 Direction);
u32 XAxiVdma_IntrGetPending(XAxiVdma *InstancePtr, u16 Direction);
void XAxiVdma_IntrClear(XAxiVdma *InstancePtr, u32 IntrType ,u16 Direction);

int XAxiVdma_SetBdAddrs(XAxiVdma *InstancePtr, u32 BdAddrPhys, u32 BdAddrVirt,
         int NumBds, u16 Direction);

XAxiVdma_Channel *XAxiVdma_GetChannel(XAxiVdma *InstancePtr, u16 Direction);
int XAxiVdma_SetFrmStore(XAxiVdma *InstancePtr, u8 FrmStoreNum, u16 Direction);
void XAxiVdma_GetFrmStore(XAxiVdma *InstancePtr, u8 *FrmStoreNum,
								u16 Direction);
int XAxiVdma_FsyncSrcSelect(XAxiVdma *InstancePtr, u32 Source,
                                u16 Direction);
int XAxiVdma_GenLockSourceSelect(XAxiVdma *InstancePtr, u32 Source,
                                        u16 Direction);
int XAxiVdma_GetDmaChannelErrors(XAxiVdma *InstancePtr, u16 Direction);
int XAxiVdma_ClearDmaChannelErrors(XAxiVdma *InstancePtr, u16 Direction,
					u32 ErrorMask);

/* Transfers */
int XAxiVdma_StartWriteFrame(XAxiVdma *InstancePtr,
        XAxiVdma_DmaSetup *DmaConfigPtr);
int XAxiVdma_StartReadFrame(XAxiVdma *InstancePtr,
        XAxiVdma_DmaSetup *DmaConfigPtr);

int XAxiVdma_DmaConfig(XAxiVdma *InstancePtr, u16 Direction,
        XAxiVdma_DmaSetup *DmaConfigPtr);
int XAxiVdma_DmaSetBufferAddr(XAxiVdma *InstancePtr, u16 Direction,
        u32 *BufferAddrSet);
int XAxiVdma_DmaStart(XAxiVdma *InstancePtr, u16 Direction);
void XAxiVdma_DmaStop(XAxiVdma *InstancePtr, u16 Direction);
void XAxiVdma_DmaRegisterDump(XAxiVdma *InstancePtr, u16 Direction);

int XAxiVdma_SetFrameCounter(XAxiVdma *InstancePtr,
        XAxiVdma_FrameCounter *FrameCounterCfgPtr);
void XAxiVdma_GetFrameCounter(XAxiVdma *InstancePtr,
         XAxiVdma_FrameCounter *FrameCounterCfgPtr);

/*
 * Interrupt related functions in xaxivdma_intr.c
 */
void XAxiVdma_ReadIntrHandler(void * InstancePtr);
void XAxiVdma_WriteIntrHandler(void * InstancePtr);
int XAxiVdma_SetCallBack(XAxiVdma * InstancePtr, u32 HandlerType,
        void *CallBackFunc, void *CallBackRef, u16 Direction);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
