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
 *  @file xaxivdma_hw.h
 *
 * Hardware definition file. It defines the register interface and Buffer
 * Descriptor (BD) definitions.
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 1.00a jz   07/30/10 First release
 * 2.00a jz   12/10/10 Added support for direct register access mode, v3 core
 * 2.01a jz   01/19/11 Added ability to re-assign BD addresses
 * 	 rkv  03/28/11 Added support for frame store register.
 * 3.00a srt  08/26/11 - Added support for Line Buffer Threshold Registers.
 *		       - XAXIVDMA_MISMATCH_ERROR flag is added to support Flush
 *		       	 on Frame Sync for Mismatch Errors.
 * 4.00a srt  11/21/11 - XAxiVdma_ChannelSetBufferAddr API is changed to
 *			 support 32 Frame Stores.
 *		       - XAxiVdma_ChannelConfig API is changed to support
 *			 modified Park Offset Register bits.
 *		       - Added APIs: 
 *			 XAxiVdma_FsyncSrcSelect()
 *			 XAxiVdma_GenLockSourceSelect()
 *			 XAxiVdma_ChannelHiFrmAddrEnable()
 *			 XAxiVdma_ChannelHiFrmAddrDisable()
 * 4.01a srt  06/13/12 - Added new error bit mask XAXIVDMA_SR_ERR_SOF_LATE_MASK
 *		       - XAXIVDMA_MISMATCH_ERROR flag is deprecated.
 * 4.02a srt  10/11/12 - Changed Error bitmasks to support IP version 5.02a.
 *                      (CR 679959)
 *
 * </pre>
 *
 *****************************************************************************/

#ifndef XAXIVDMA_HW_H_    /* prevent circular inclusions */
#define XAXIVDMA_HW_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "xil_types.h"
#include "xil_io.h"


/************************** Constant Definitions *****************************/

/** @name Buffer Descriptor Alignment
 *  @{
 */
#define XAXIVDMA_BD_MINIMUM_ALIGNMENT    0x20  /**< Minimum byte alignment
                                               requirement for descriptors */
#define XAXIVDMA_BD_MINIMUM_ALIGNMENT_WD 0x8  /**< Minimum word alignment
                                               requirement for descriptors */
/**
 * Maximum number of the frame store
 */
#define XAXIVDMA_MAX_FRAMESTORE    32  /**< Maximum # of the frame store */

/*@}*/

/** @name Maximum transfer length
 *    This is determined by hardware
 * @{
 */
#define XAXIVDMA_MAX_VSIZE  0x1FFF  /* Max vertical size, 8K */
#define XAXIVDMA_MAX_HSIZE  0xFFFF  /* Max horizontal size, 64K */
#define XAXIVDMA_MAX_STRIDE 0xFFFF  /* Max stride size, 64K */
#define XAXIVDMA_FRMDLY_MAX 0xF     /**< Maximum frame delay */
/*@}*/

/**
 * Frame/Line Mismatch Error
 * This is a typical DMA Internal Error, which on detection doesnt require
 * a reset (as opposed to other errors). So a MSB bit is set to identify it,
 * from other DMA Internal Errors.
 *
 */
#define XAXIVDMA_MISMATCH_ERROR 0x80000010
/*                       	  |     |_ DMA Internal Error Bit.
 *                                |_______ Set to identify Mismatch Errors.
 */

/* Register offset definitions. Register accesses are 32-bit.
 */
/** @name Device registers
 *  Register sets on TX (Read) and RX (Write) channels are identical
 *
 *  The version register is shared by both channels
 *  @{
 */
#define XAXIVDMA_TX_OFFSET      0x00000000	/**< TX channel registers base */
#define XAXIVDMA_RX_OFFSET      0x00000030	/**< RX channel registers base */
#define XAXIVDMA_PARKPTR_OFFSET 0x00000028  /**< Park Pointer Register */
#define XAXIVDMA_VERSION_OFFSET 0x0000002C  /**< Version register */

/* This set of registers are applicable for both channels. Use
 * XAXIVDMA_TX_OFFSET for the TX channel, and XAXIVDMA_RX_OFFSET for the
 * RX channel
 */
#define XAXIVDMA_CR_OFFSET    	0x00000000	 /**< Channel control */
#define XAXIVDMA_SR_OFFSET    	0x00000004	 /**< Status */
#define XAXIVDMA_CDESC_OFFSET 	0x00000008	 /**< Current descriptor pointer */
#define XAXIVDMA_TDESC_OFFSET	0x00000010	 /**< Tail descriptor pointer */
#define XAXIVDMA_HI_FRMBUF_OFFSET	0x00000014 	 /**< 32 FrameBuf Sel*/
#define XAXIVDMA_FRMSTORE_OFFSET	0x00000018	 /**< Frame Store */
#define XAXIVDMA_BUFTHRES_OFFSET	0x0000001C	 /**< Line Buffer Thres */
#define XAXIVDMA_MM2S_ADDR_OFFSET 0x00000050 /**< MM2S channel Addr */
#define XAXIVDMA_S2MM_ADDR_OFFSET 0x000000A0 /**< S2MM channel Addr */
/*@}*/

/** @name Start Addresses Register Array for a Channel
 *
 * Base offset is set in each channel
 * This set of registers are write only, they can be read when
 * C_ENABLE_VIDPRMTR_READS is 1.
 * @{
 */
#define XAXIVDMA_VSIZE_OFFSET         0x00000000  /**< Vertical size */
#define XAXIVDMA_HSIZE_OFFSET         0x00000004  /**< Horizontal size */
#define XAXIVDMA_STRD_FRMDLY_OFFSET   0x00000008  /**< Horizontal size */
#define XAXIVDMA_START_ADDR_OFFSET    0x0000000C  /**< Start of address */
#define XAXIVDMA_START_ADDR_LEN       0x00000004  /**< Each entry is 4 bytes */
/*@}*/

/** @name Bitmasks of the XAXIVDMA_CR_OFFSET register
 * @{
 */
#define XAXIVDMA_CR_RUNSTOP_MASK    0x00000001 /**< Start/stop DMA channel */
#define XAXIVDMA_CR_TAIL_EN_MASK    0x00000002 /**< Tail ptr enable or Park */
#define XAXIVDMA_CR_RESET_MASK      0x00000004 /**< Reset channel */
#define XAXIVDMA_CR_SYNC_EN_MASK    0x00000008 /**< Gen-lock enable */
#define XAXIVDMA_CR_FRMCNT_EN_MASK  0x00000010 /**< Frame count enable */
#define XAXIVDMA_CR_FSYNC_SRC_MASK  0x00000060 /**< Fsync Source Select */
#define XAXIVDMA_CR_GENLCK_SRC_MASK 0x00000080 /**< Genlock Source Select */
#define XAXIVDMA_CR_RD_PTR_MASK     0x00000F00 /**< Read pointer number */

#define XAXIVDMA_CR_RD_PTR_SHIFT    8   /**< Shift for read pointer number */
/*@}*/

/** @name Bitmasks of the XAXIVDMA_SR_OFFSET register
 * This register reports status of a DMA channel, including
 * run/stop/idle state, errors, and interrupts
 * @{
 */
#define XAXIVDMA_SR_HALTED_MASK       0x00000001  /**< DMA channel halted */
#define XAXIVDMA_SR_IDLE_MASK         0x00000002  /**< DMA channel idle */
#define XAXIVDMA_SR_ERR_INTERNAL_MASK 0x00000010  /**< Datamover internal err */
#define XAXIVDMA_SR_ERR_SLAVE_MASK    0x00000020  /**< Datamover slave err */
#define XAXIVDMA_SR_ERR_DECODE_MASK   0x00000040  /**< Datamover decode err */
#define XAXIVDMA_SR_ERR_FSZ_LESS_MASK 0x00000080  /**< FSize Less Mismatch err */
#define XAXIVDMA_SR_ERR_LSZ_LESS_MASK 0x00000100  /**< LSize Less Mismatch err */
#define XAXIVDMA_SR_ERR_SG_SLV_MASK   0x00000200  /**< SG slave err */
#define XAXIVDMA_SR_ERR_SG_DEC_MASK   0x00000400  /**< SG decode err */
#define XAXIVDMA_SR_ERR_FSZ_MORE_MASK 0x00000800  /**< FSize More Mismatch err */
#define XAXIVDMA_SR_ERR_ALL_MASK      0x00000FF0  /**< All errors */

/** @name Bitmask for interrupts
 * These masks are shared by the XAXIVDMA_CR_OFFSET register and
 * the XAXIVDMA_SR_OFFSET register
 * @{
 */
#define XAXIVDMA_IXR_FRMCNT_MASK      0x00001000 /**< Frame count intr */
#define XAXIVDMA_IXR_DELAYCNT_MASK    0x00002000 /**< Delay interrupt */
#define XAXIVDMA_IXR_ERROR_MASK       0x00004000 /**< Error interrupt */
#define XAXIVDMA_IXR_COMPLETION_MASK  0x00003000 /**< Completion interrupts */
#define XAXIVDMA_IXR_ALL_MASK         0x00007000 /**< All interrupts */
/*@}*/

/** @name Bitmask and shift for delay and coalesce
 * These masks are shared by the XAXIVDMA_CR_OFFSET register and
 * the XAXIVDMA_SR_OFFSET register
 * @{
 */
#define XAXIVDMA_DELAY_MASK    0xFF000000 /**< Delay timeout counter */
#define XAXIVDMA_FRMCNT_MASK   0x00FF0000 /**< Frame counter */
#define XAXIVDMA_REGINDEX_MASK		0x00000001 /**< Register Index */

#define XAXIVDMA_DELAY_SHIFT     24
#define XAXIVDMA_FRMCNT_SHIFT    16
/*@}*/

/** @name Bitmask for the XAXIVDMA_CDESC_OFFSET register
 * @{
 */
#define XAXIVDMA_CDESC_CURBD_MASK     0xFFFFFFE0 /**< BD now working on */
/*@}*/

/** @name Bitmask for XAXIVDMA_TDESC_OFFSET register
 * @{
 */
#define XAXIVDMA_TDESC_CURBD_MASK        0xFFFFFFE0 /**< BD to stop on */
/*@}*/

/** @name Bitmask for XAXIVDMA_FRMSTORE_OFFSET register
 * @{
 */
#define XAXIVDMA_FRMSTORE_MASK        0x0000003F
/*@}*/
/** @name Bitmask for XAXIVDMA_PARKPTR_OFFSET register
 * @{
 */
#define XAXIVDMA_PARKPTR_READREF_MASK 0x0000001F /**< Read frame to park on */
#define XAXIVDMA_PARKPTR_WRTREF_MASK  0x00001F00 /**< Write frame to park on */
#define XAXIVDMA_PARKPTR_READSTR_MASK 0x001F0000 /**< Current read frame */
#define XAXIVDMA_PARKPTR_WRTSTR_MASK  0x1F000000 /**< Current write frame */

#define XAXIVDMA_READREF_SHIFT        0
#define XAXIVDMA_WRTREF_SHIFT         8
#define XAXIVDMA_READSTR_SHIFT        16
#define XAXIVDMA_WRTSTR_SHIFT         24

#define XAXIVDMA_FRM_MAX              0xF       /**< At most 16 frames */
/*@}*/

/** @name Bitmask for XAXIVDMA_VERSION_OFFSET register
 * @{
 */
#define XAXIVDMA_VERSION_MAJOR_MASK 0xF0000000 /**< Major version */
#define XAXIVDMA_VERSION_MINOR_MASK 0x0FF00000 /**< Minor version */
#define XAXIVDMA_VERSION_REV_MASK   0x000F0000 /**< Revision letter */

#define XAXIVDMA_VERSION_MAJOR_SHIFT 28
#define XAXIVDMA_VERSION_MINOR_SHIFT 20
/*@}*/

/** @name Frame Delay shared by start address registers and BDs
 *
 *  @{
 */
#define XAXIVDMA_VSIZE_MASK       0x00001FFF /**< Vertical size */
#define XAXIVDMA_HSIZE_MASK       0x0000FFFF /**< Horizontal size */
#define XAXIVDMA_STRIDE_MASK      0x0000FFFF /**< Stride size */
#define XAXIVDMA_FRMDLY_MASK      0x0F000000 /**< Frame delay */

#define XAXIVDMA_FRMDLY_SHIFT     24     /**< Shift for frame delay */
/*@}*/

/* Buffer Descriptor (BD) definitions
 */

/** @name Buffer Descriptor offsets
 *
 *  @{
 */
#define XAXIVDMA_BD_NDESC_OFFSET       0x00  /**< Next descriptor pointer */
#define XAXIVDMA_BD_START_ADDR_OFFSET  0x08  /**< Start address */
#define XAXIVDMA_BD_VSIZE_OFFSET       0x10  /**< Vertical size */
#define XAXIVDMA_BD_HSIZE_OFFSET       0x14  /**< Horizontal size */
#define XAXIVDMA_BD_STRIDE_OFFSET      0x18  /**< Stride size */

#define XAXIVDMA_BD_NUM_WORDS      7   /**< Total number of words for one BD*/
#define XAXIVDMA_BD_HW_NUM_BYTES   28  /**< Number of bytes hw used */
#define XAXIVDMA_BD_BYTES_TO_CLEAR 20  /**< Skip next ptr when clearing */
/*@}*/


/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

#define XAxiVdma_In32  Xil_In32
#define XAxiVdma_Out32 Xil_Out32

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param    BaseAddress is the base address of the device
* @param    RegOffset is the register offset to be read
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 XAxiVdma_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define XAxiVdma_ReadReg(BaseAddress, RegOffset)             \
    XAxiVdma_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param    BaseAddress is the base address of the device
* @param    RegOffset is the register offset to be written
* @param    Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void XAxiVdma_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define XAxiVdma_WriteReg(BaseAddress, RegOffset, Data)          \
    XAxiVdma_Out32((BaseAddress) + (RegOffset), (Data))

#ifdef __cplusplus
}
#endif

#endif
