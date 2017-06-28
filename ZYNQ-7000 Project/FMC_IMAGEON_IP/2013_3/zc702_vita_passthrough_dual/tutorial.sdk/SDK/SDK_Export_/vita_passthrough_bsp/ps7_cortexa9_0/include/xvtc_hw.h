/* $Id: */
/******************************************************************************
 -- (c) Copyright 2008 - 2011 Xilinx, Inc. All rights reserved.
 --
 -- This file contains confidential and proprietary information
 -- of Xilinx, Inc. and is protected under U.S. and
 -- international copyright and other intellectual property
 -- laws.
 --
 -- DISCLAIMER
 -- This disclaimer is not a license and does not grant any
 -- rights to the materials distributed herewith. Except as
 -- otherwise provided in a valid license issued to you by
 -- Xilinx, and to the maximum extent permitted by applicable
 -- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
 -- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
 -- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
 -- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
 -- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
 -- (2) Xilinx shall not be liable (whether in contract or tort,
 -- including negligence, or under any other theory of
 -- liability) for any loss or damage of any kind or nature
 -- related to, arising under or in connection with these
 -- materials, including for any direct, or any indirect,
 -- special, incidental, or consequential loss or damage
 -- (including loss of data, profits, goodwill, or any type of
 -- loss or damage suffered as a result of any action brought
 -- by a third party) even if such damage or loss was
 -- reasonably foreseeable or Xilinx had been advised of the
 -- possibility of the same.
 --
 -- CRITICAL APPLICATIONS
 -- Xilinx products are not designed or intended to be fail-
 -- safe, or for use in any application requiring fail-safe
 -- performance, such as life-support or safety devices or
 -- systems, Class III medical devices, nuclear facilities,
 -- applications related to the deployment of airbags, or any
 -- other applications that could lead to death, personal
 -- injury, or severe property or environmental damage
 -- (individually and collectively, "Critical
 -- Applications"). Customer assumes the sole risk and
 -- liability of any use of Xilinx products in Critical
 -- Applications, subject only to applicable laws and
 -- regulations governing limitations on product liability.
 --
 -- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
 -- PART OF THIS FILE AT ALL TIMES.
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xvtc_hw.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Xilinx MVI VTC device.
*
* For more information about the operation of this device, see the hardware
* specification and documentation in the higher level driver xvtc.h source
* code file.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver	Who	Date		Changes
* -----	----	--------	-----------------------------------------------
* 1.00a	xd	08/05/08	First release
* 1.01a	xd	07/23/10	Added GIER; Added more h/w generic info into
*				xparameters.h; Feed callbacks with pending
*				interrupt info. Added Doxygen & Version support
* 2.00a cm   05/25/11 Renamed XVTC_CTL_GACS_MASK to XVTC_CTL_GACLS_MASK
*                     Added XVTC_CTL_GACPS_MASK
*				
* 3.00a cjm  08/01/12 Converted from xio.h to xil_io.h, translating
*                     basic types, MB cache functions, exceptions and
*                     assertions to xil_io format. 
*                     Replaced the following 
*                     "XExc_Init" -> "Xil_ExceptionInit"
*                     "XExc_RegisterHandler" -> "Xil_ExceptionRegisterHandler"
*                     "XEXC_ID_NON_CRITICAL_INT" -> "XIL_EXCEPTION_ID_INT"
*                     "XExceptionHandler" -> "Xil_ExceptionHandler"
*                     "XExc_mEnableExceptions" -> "Xil_ExceptionEnable"
*                     "XEXC_NON_CRITICAL" -> "XIL_EXCEPTION_NON_CRITICAL"
*                     "XExc_DisableExceptions" -> "Xil_ExceptionDisable"
*                     "XExc_RemoveHandler" -> "Xil_ExceptionRemoveHandler"
*                     "microblaze_enable_interrupts" -> "Xil_ExceptionEnable"
*                     "microblaze_disable_interrupts" -> "Xil_ExceptionDisable"
*                     
*                     "XCOMPONENT_IS_STARTED" -> "XIL_COMPONENT_IS_STARTED"
*                     "XCOMPONENT_IS_READY" -> "XIL_COMPONENT_IS_READY"
*                     
*                     "XASSERT_NONVOID" -> "Xil_AssertNonvoid"
*                     "XASSERT_VOID_ALWAYS" -> "Xil_AssertVoidAlways"
*                     "XASSERT_VOID" -> "Xil_AssertVoid"
*                     "Xil_AssertVoid_ALWAYS" -> "Xil_AssertVoidAlways" 
*                     "XAssertStatus" -> "Xil_AssertStatus"
*                     "XAssertSetCallback" -> "Xil_AssertCallback"
*                     
*                     "XASSERT_OCCURRED" -> "XIL_ASSERT_OCCURRED"
*                     "XASSERT_NONE" -> "XIL_ASSERT_NONE"
*                     
*                     "microblaze_disable_dcache" -> "Xil_DCacheDisable"
*                     "microblaze_enable_dcache" -> "Xil_DCacheEnable"
*                     "microblaze_enable_icache" -> "Xil_ICacheEnable"
*                     "microblaze_disable_icache" -> "Xil_ICacheDisable"
*                     "microblaze_init_dcache_range" -> "Xil_DCacheInvalidateRange"
*                     
*                     "XCache_DisableDCache" -> "Xil_DCacheDisable"
*                     "XCache_DisableICache" -> "Xil_ICacheDisable"
*                     "XCache_EnableDCache" -> "Xil_DCacheEnableRegion"
*                     "XCache_EnableICache" -> "Xil_ICacheEnableRegion"
*                     "XCache_InvalidateDCacheLine" -> "Xil_DCacheInvalidateRange"
*                     
*                     "XUtil_MemoryTest32" -> "Xil_TestMem32"
*                     "XUtil_MemoryTest16" -> "Xil_TestMem16"
*                     "XUtil_MemoryTest8" -> "Xil_TestMem8"
*                     
*                     "xutil.h" -> "xil_testmem.h"
*                     
*                     "xbasic_types.h" -> "xil_types.h"
*                     "xio.h" -> "xil_io.h"
*                     
*                     "XIo_In32" -> "Xil_In32"
*                     "XIo_Out32" -> "Xil_Out32"
*                     
*                     "XTRUE" -> "TRUE"
*                     "XFALSE" -> "FALSE"
*                     "XNULL" -> "NULL"
*                     
*                     "Xuint8" -> "u8"
*                     "Xuint16" -> "u16"
*                     "Xuint32" -> "u32"
*                     "Xint8" -> "char"
*                     "Xint16" -> "short"
*                     "Xint32" -> "long"
*                     "Xfloat32" -> "float"
*                     "Xfloat64" -> "double"
*                     "Xboolean" -> "int"
*                     "XTEST_FAILED" -> "XST_FAILURE"
*                     "XTEST_PASSED" -> "XST_SUCCESS"
* 3.00a cjm  08/02/12 Changed XVTC_RESET_RESET_MASK from 0x0000_000a to 0x8000_0000
* 4.00a cjm  02/07/13 Remove Unused defines:
*                     XVTC_GIER
*                     XVTC_GIER_GIE_MASK
* 4.00a cjm  02/08/13 Removed XVTC_CTL_HASS_MASK
* </pre>
*
******************************************************************************/

#ifndef XVTC_HW_H		  /* prevent circular inclusions */
#define XVTC_HW_H		  /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xil_io.h"

/************************** Constant Definitions *****************************/

/** @name Device Register Offsets
 *  @{
 */
#define XVTC_CTL	  0x000	/**< Control */
#define XVTC_STATS	0x004	/**< Status */
#define XVTC_ERROR	0x008	/**< Error */

//#define XVTC_GH0	0x004	/**< Generator Horizontal Register 0 */
//#define XVTC_GH1	0x008	/**< Generator Horizontal Register 1 */
//#define XVTC_GH2	0x00C	/**< Generator Horizontal Register 2 */
//#define XVTC_GV0	0x010	/**< Generator Vertical Register 0 */
//#define XVTC_GV1	0x014	/**< Generator Vertical Register 1 */
//#define XVTC_GV2	0x018	/**< Generator Vertical Register 2 */
//#define XVTC_GV3	0x01C	/**< Generator Vertical Register 3 */
//#define XVTC_GV4	0x020	/**< Generator Vertical Register 4 */
//#define XVTC_GV5	0x024	/**< Generator Vertical Register 5 */
//
//#define XVTC_DS		0x028	/**< Detector Status Register */
//
//#define XVTC_DH0	0x02C	/**< Detector Horizontal Register 0 */
//#define XVTC_DH1	0x030	/**< Detector Horizontal Register 1 */
//#define XVTC_DH2	0x034	/**< Detector Horizontal Register 2 */
//#define XVTC_DV0	0x038	/**< Detector Vertical Register 0 */
//#define XVTC_DV1	0x03C	/**< Detector Vertical Register 1 */
//#define XVTC_DV2	0x040	/**< Detector Vertical Register 2 */
//#define XVTC_DV3	0x044	/**< Detector Vertical Register 3 */
//#define XVTC_DV4	0x048	/**< Detector Vertical Register 4 */
//#define XVTC_DV5	0x04C	/**< Detector Vertical Register 5 */

#define XVTC_DASIZE  0x020 /**< Detector Active Size */
#define XVTC_DTSTAT  0x024 /**< Detector Timing Status */
#define XVTC_DFENC   0x028 /**< Detector Encoding */
#define XVTC_DPOL    0x02c /**< Detector Polarity */
#define XVTC_DHSIZE  0x030 /**< Detector Frame Horizontal Size */
#define XVTC_DVSIZE  0x034 /**< Detector Frame Vertical Size */
#define XVTC_DHSYNC  0x038 /**< Detector Horizontal sync */
#define XVTC_DVBHOFF 0x03c /**< Detector Vblank Horizontal Offset */
#define XVTC_DVSYNC  0x040 /**< Detector Vertical Sync */
#define XVTC_DVSHOFF 0x044 /**< Detector Vsync Horizontal Offset */

#define XVTC_GASIZE  0x060 /**< Generator Active Size */
#define XVTC_GTSTAT  0x064 /**< Generator Timing Status */
#define XVTC_GFENC   0x068 /**< Generator Encoding */
#define XVTC_GPOL    0x06c /**< Generator Polarity */
#define XVTC_GHSIZE  0x070 /**< Generator Frame Horizontal Size */
#define XVTC_GVSIZE  0x074 /**< Generator Frame Vertical Size */
#define XVTC_GHSYNC  0x078 /**< Generator Horizontal Sync */
#define XVTC_GVBHOFF 0x07c /**< Generator Vblank Horizontal Offset */
#define XVTC_GVSYNC  0x080 /**< Generator Vertical Sync */
#define XVTC_GVSHOFF 0x084 /**< Generator Vsync horizontal Offset */


#define XVTC_FS00	0x100	/**< Frame Sync 00 Config Register */
#define XVTC_FS01	0x104	/**< Frame Sync 01 Config Register */
#define XVTC_FS02	0x108	/**< Frame Sync 02 Config Register */
#define XVTC_FS03	0x10C	/**< Frame Sync 03 Config Register */
#define XVTC_FS04	0x110	/**< Frame Sync 04 Config Register */
#define XVTC_FS05	0x114	/**< Frame Sync 05 Config Register */
#define XVTC_FS06	0x118	/**< Frame Sync 06 Config Register */
#define XVTC_FS07	0x11C	/**< Frame Sync 07 Config Register */
#define XVTC_FS08	0x120	/**< Frame Sync 08 Config Register */
#define XVTC_FS09	0x124	/**< Frame Sync 09 Config Register */
#define XVTC_FS10	0x128	/**< Frame Sync 10 Config Register */
#define XVTC_FS11	0x12C	/**< Frame Sync 11 Config Register */
#define XVTC_FS12	0x130	/**< Frame Sync 12 Config Register */
#define XVTC_FS13	0x134	/**< Frame Sync 13 Config Register */
#define XVTC_FS14	0x138	/**< Frame Sync 14 Config Register */
#define XVTC_FS15	0x13C	/**< Frame Sync 15 Config Register */

#define XVTC_GGD	0x140	/**< Generator Global Delay register */

#define XVTC_GVBHO0	0x0A0	/**< Generator VBlank Hori Offset 0 register */
#define XVTC_GVSHO0	0x0A4	/**< Generator VSync  Hori Offset 0 register */
#define XVTC_GVBHO1	0x0A8	/**< Generator VBlank Hori Offset 1 register */
#define XVTC_GVSHO1	0x0AC	/**< Generator VSync  Hori Offset 1 register */

#define XVTC_DVBHO0	0x0B0	/**< Detector VBlank Hori Offset 0 register */
#define XVTC_DVSHO0	0x0B4	/**< Detector VSync  Hori Offset 0 register */
#define XVTC_DVBHO1	0x0B8	/**< Detector VBlank Hori Offset 1 register */
#define XVTC_DVSHO1	0x0BC	/**< Detector VSync  Hori Offset 1 register */

#define XVTC_VER	0x010	/**< Version Register */
#define XVTC_RESET	0x000	/**< Reset Register */
#define XVTC_ISR	0x004	/**< Interrupt Status Register */
#define XVTC_IER	0x00c	/**< Interrupt Enable Register */
/*@}*/

/** @name Control Register bit definition
 *  @{
 */
#define XVTC_CTL_FIP_MASK	0x00000040 /**< Field ID Output Polarity */
#define XVTC_CTL_ACP_MASK	0x00000020 /**< Active Chroma Output Polarity*/
#define XVTC_CTL_AVP_MASK	0x00000010 /**< Active Video Output Polarity */
#define XVTC_CTL_HSP_MASK	0x00000008 /**< Horizontal Sync Output Polarity
					     */
#define XVTC_CTL_VSP_MASK	0x00000004 /**< Vertical Sync Output Polarity
					     */
#define XVTC_CTL_HBP_MASK	0x00000002 /**< Horizontal Blank Output
					     *  Polarity */
#define XVTC_CTL_VBP_MASK	0x00000001 /**< Vertical Blank Output Polarity
					     */
#define XVTC_CTL_ALLP_MASK	0x0000007F /**< Bit mask for all polarity bits
					     */


#define XVTC_CTL_FIPSS_MASK	0x04000000 /**< Field ID Output Polarity Source */
#define XVTC_CTL_ACPSS_MASK	0x02000000 /**< Active Chroma Output Polarity Source */
#define XVTC_CTL_AVPSS_MASK	0x01000000 /**< Active Video Output Polarity Source */
#define XVTC_CTL_HSPSS_MASK	0x00800000 /**< Horizontal Sync Output Polarity
					     Source */
#define XVTC_CTL_VSPSS_MASK	0x00400000 /**< Vertical Sync Output Polarity
					     Source */
#define XVTC_CTL_HBPSS_MASK	0x00200000 /**< Horizontal Blank Output
					     *  Polarity Source */
#define XVTC_CTL_VBPSS_MASK	0x00100000 /**< Vertical Blank Output Polarity
					     Source */



#define XVTC_CTL_VCSS_MASK	0x00040000 /**< Start of Active Chroma Register
					     *  Source Select */
#define XVTC_CTL_VASS_MASK	0x00020000 /**< Vertical Active Video Start
					     *  Register Source Select */
#define XVTC_CTL_VBSS_MASK	0x00010000 /**< Vertical Back Porch Start
					     *  Register Source Select (Sync End) */
#define XVTC_CTL_VSSS_MASK	0x00008000 /**< Vertical Sync Start Register
					     *  Source Select */
#define XVTC_CTL_VFSS_MASK	0x00004000 /**< Vertical Front Porch Start
					     *  Register Source Select (Active Size) */
#define XVTC_CTL_VTSS_MASK	0x00002000 /**< Vertical Total Register Source
					     *  Select (Frame Size) */


#define XVTC_CTL_HBSS_MASK	0x00000800 /**< Horizontal Back Porch Start
					     *  Register Source Select (Sync End) */
#define XVTC_CTL_HSSS_MASK	0x00000400 /**< Horizontal Sync Start Register
					     *  Source Select */
#define XVTC_CTL_HFSS_MASK	0x00000200 /**< Horizontal Front Porch Start
					     *  Register Source Select (Active Size) */
#define XVTC_CTL_HTSS_MASK	0x00000100 /**< Horizontal Total Register
					     *  Source Select (Frame Size) */


#define XVTC_CTL_ALLSS_MASK	0x03F7EF00 /**< Bit mask for all source select
					     */
#define XVTC_CTL_GACPS_MASK	0x00000200 /**< Generator Active Chroma Pixel
					     *  Skip */
#define XVTC_CTL_GACLS_MASK	0x00000001 /**< Generator Active Chroma Line
					     *  Skip */
//#define XVTC_CTL_LP_MASK	0x00000008 /**< Lock Polarity */
#define XVTC_CTL_SE_MASK	0x00000020 /**< Enable Sync with Detector */
#define XVTC_CTL_DE_MASK	0x00000008 /**< VTC Detector Enable */
#define XVTC_CTL_GE_MASK	0x00000004 /**< VTC Generator Enable */
#define XVTC_CTL_RU_MASK	0x00000002 /**< VTC Register Update */
#define XVTC_CTL_SW_MASK	0x00000001 /**< VTC Core Enable */
/*@}*/

/** @name VTC Generator Horizontal 0
 *  @{
 */
#define XVTC_GH0_FPSTART_MASK	0x1FFF0000 /**< Horizontal Front Porch Start
					     *  Cycle Count */
#define XVTC_GH0_FPSTART_SHIFT	16	   /**< Bit shift for Horizontal
					     *  Front Porch Start Cycle
					     *  Count */
#define XVTC_GH0_TOTAL_MASK	0x00001FFF /**< Total clock cycles per Line
					     */
/*@}*/

/** @name VTC Generator Horizontal 1
 *  @{
 */
#define XVTC_GH1_BPSTART_MASK   0x1FFF0000 /**< Horizontal Back Porch Start
					    *  Cycle Count */
#define XVTC_GH1_BPSTART_SHIFT  16	   /**< Bit shift for Horizontal Back
					    *  Porch Start Cycle Count */
#define XVTC_GH1_SYNCSTART_MASK 0x00001FFF /**< Horizontal Sync Start Cycle
					    *  Count */
/*@}*/

/** @name VTC Generator Horizontal 2
 *  @{
 */
#define XVTC_GH2_ACTIVESTART_MASK 0x00001FFF /**< Horizontal Active Video Start
					      *  Cycle Count */
/*@}*/

/** @name VTC Generator Vertical 0 (Field 0)
 *  @{
 */
#define XVTC_GV0_FPSTART_MASK   0x1FFF0000  /**< Vertical Front Porch Start
					      *  Cycle Count */
#define XVTC_GV0_FPSTART_SHIFT  16	    /**< Bit shift for Vertical Front
					      *  Porch Start Cycle Count */
#define XVTC_GV0_TOTAL_MASK	0x00001FFF  /**< Total lines per Frame */
/*@}*/

/** @name VTC Generator Vertical 1 (Field 0)
 *  @{
 */
#define XVTC_GV1_BPSTART_MASK   0x1FFF0000  /**< Vertical Back Porch Start
					      *  Cycle Count */
#define XVTC_GV1_BPSTART_SHIFT  16	   /**< Bit shift for Vertical Back
					     *  Porch Start Cycle Count */
#define XVTC_GV1_SYNCSTART_MASK 0x00001FFF  /**< Vertical Sync Start Cycle
					     *  Count */
/*@}*/

/** @name VTC Generator Vertical 2 (Field 0)
 *  @{
 */
#define XVTC_GV2_CHROMASTART_MASK  0x00000100 /**< Active Chroma Start Line
					       *  Count */
#define XVTC_GV2_CHROMASTART_SHIFT 8	     /**< Bit shift for Active Chroma
					       *  Start Line Count */
#define XVTC_GV2_ACTIVESTART_MASK  0x00001FFF /**< Vertical Active Video Start
					       *  Cycle Count */
/*@}*/

/** @name VTC Generator Vertical 3 (Field 1)
 *  @{
 */
#define XVTC_GV3_FPSTART_MASK	0x1FFF0000    /**< Vertical Front Porch Start
					       *  Cycle Count */
#define XVTC_GV3_FPSTART_SHIFT	16	      /**< Bit shift for Vertical Front
					       *  Porch Start Cycle Count */
#define XVTC_GV3_TOTAL_MASK	0x00001FFF    /**< Total lines per Frame */
/*@}*/

/** @name VTC Generator Vertical 4 (Field 1)
 *  @{
 */
#define XVTC_GV4_BPSTART_MASK	0x1FFF0000    /**< Vertical Back Porch Start
						*  Cycle Count */
#define XVTC_GV4_BPSTART_SHIFT	16	      /**< Bit shift for Vertical Back
						*  Porch Start Cycle Count */
#define XVTC_GV4_SYNCSTART_MASK	0x00001FFF    /**< Vertical Sync Start Cycle
						*  Count */
/*@}*/

/** @name VTC Generator Vertical 5 (Field 1)
 *  @{
 */
#define XVTC_GV5_CHROMASTART_MASK  0x1FFF0000  /**< Active Chroma Start Line
						*  Count */
#define XVTC_GV5_CHROMASTART_SHIFT 16	      /**< Bit shift for Active Chroma
						*  Start Line Count */
#define XVTC_GV5_ACTIVESTART_MASK  0x00001FFF  /**< Vertical Active Video Start
						*  Cycle Count */
/*@}*/

/** @name VTC Detector Status
 *  @{
 */
#define XVTC_DS_AC_POL_MASK	0x04000000 /**< Active Chroma Output Polarity
					     */
#define XVTC_DS_AV_POL_MASK	0x02000000 /**< Active Video Output Polarity
					     */
#define XVTC_DS_FID_POL_MASK	0x01000000 /**< Field ID Output Polarity */
#define XVTC_DS_VBLANK_POL_MASK	0x00800000 /**< Vertical Blank Output
					     *  Polarity */
#define XVTC_DS_VSYNC_POL_MASK	0x00400000 /**< Vertical Sync Output Polarity
					     */
#define XVTC_DS_HBLANK_POL_MASK	0x00200000 /**< Horizontal Blank Output
					     *  Polarity */
#define XVTC_DS_HSYNC_POL_MASK	0x00100000 /**< Horizontal Sync Output
					     *  Polarity */
#define XVTC_DS_ACSKIP_MASK	0x00000010 /**< Detector Active Chroma Skip
					     */
/*@}*/

/** @name VTC Detector Horizontal 0
 *  @{
 */
#define XVTC_DH0_FPSTART_MASK	0x1FFF0000 /**< Detected Horizontal Front
					     *  Porch Start Cycle Count */
#define XVTC_DH0_FPSTART_SHIFT	16	   /**< Bit shift for Detected
					     *  Horizontal Front Porch Start
					     *  Cycle Count */
#define XVTC_DH0_TOTAL_MASK	0x00001FFF /**< Detected Total clock cycles
					     *  per Line */
/*@}*/

/** @name VTC Detector  Horizontal 1
 *  @{
 */
#define XVTC_DH1_BPSTART_MASK	0x1FFF0000 /**< Detected Horizontal Back
					     *  Porch Start Cycle Count */
#define XVTC_DH1_BPSTART_SHIFT	16	   /**< Bit shift for Detected
					     *  Horizontal Back Porch Start
					     *  Cycle Count */
#define XVTC_DH1_SYNCSTART_MASK	0x00001FFF /**< Detected Horizontal Sync
					     *  Start Cycle Count */
/*@}*/

/** @name VTC Detector Horizontal 2
 *  @{
 */
#define XVTC_DH2_ACTIVESTART_MASK 0x00001FFF /**< Detected Horizontal Active
					      *  Video Start Cycle Count */
/*@}*/

/** @name VTC Detector Vertical 0 (Field 0)
 *  @{
 */
#define XVTC_DV0_FPSTART_MASK	0x1FFF0000 /**< Detected Vertical Front Porch
					     *  Start Cycle Count */
#define XVTC_DV0_FPSTART_SHIFT	16	   /**< Bit shift for Detected
					     *  Vertical Front Porch Start
					     *  Cycle Count */
#define XVTC_DV0_TOTAL_MASK	0x00001FFF /**< Detected Total lines per
					     *  Frame */
/*@}*/

/** @name VTC Detector Vertical 1 (Field 0)
 *  @{
 */
#define XVTC_DV1_BPSTART_MASK	0x1FFF0000 /**< Detected Vertical Back Porch
					     *  Start Cycle Count */
#define XVTC_DV1_BPSTART_SHIFT	16	   /**< Bit shift for Detected
					     *  Vertical Back Porch Start
					     *  Cycle Count */
#define XVTC_DV1_SYNCSTART_MASK	0x00001FFF /**< Detected Vertical Sync Start
					     *  Cycle Count */
/*@}*/

/** @name VTC Detector Vertical 2 (Field 0)
 *  @{
 */
#define XVTC_DV2_CHROMASTART_MASK  0x1FFF0000 /**< Detected Active Chroma Start
					       *  Line Count */
#define XVTC_DV2_CHROMASTART_SHIFT 16	     /**< Bit shift for Detected Active
					       *  Chroma Start Line Count */
#define XVTC_DV2_ACTIVESTART_MASK  0x00001FFF /**< Detected Vertical Active
					       *  Video Start Cycle Count */
/*@}*/

/** @name VTC Detector Vertical 3 (Field 1)
 *  @{
 */
#define XVTC_DV3_FPSTART_MASK	0x1FFF0000   /**< Detected Vertical Front Porch
					       *  Start Cycle Count */
#define XVTC_DV3_FPSTART_SHIFT	16	     /**< Bit shift for Detected
					       *  Vertical Front Porch Start
					       *  Cycle Count */
#define XVTC_DV3_TOTAL_MASK	0x00001FFF   /**< Detected Total lines per
					       *  Frame */
/*@}*/

/** @name VTC Detector Vertical 4 (Field 1)
 *  @{
 */
#define XVTC_DV4_BPSTART_MASK	0x1FFF0000 /**< Detected Vertical Back Porch
					     *  Start Cycle Count */
#define XVTC_DV4_BPSTART_SHIFT	16	   /**< Bit shift for Detected
					     *  Vertical Back Porch Start
					     *  Cycle Count */
#define XVTC_DV4_SYNCSTART_MASK	0x00001FFF /**< Detected Vertical Sync Start
					     *  Cycle Count */
/*@}*/

/** @name VTC Detector Vertical 5 (Field 1)
 *  @{
 */
#define XVTC_DV5_CHROMASTART_MASK  0x1FFF0000 /**< Detected Active Chroma Start
					       *  Line Count */
#define XVTC_DV5_CHROMASTART_SHIFT 16	     /**< Bit shift for Detected Active
					      *  Chroma Start Line Count */
#define XVTC_DV5_ACTIVESTART_MASK  0x00001FFF /**< Detected Vertical Active
					       *  Video Start Cycle Count */
/*@}*/

/** @name VTC Frame Sync 00 --- 15
 *  @{
 */
#define XVTC_FSXX_VSTART_MASK	0x1FFF0000 /**< Vertical line count during
					     *  which current Frame Sync is
					     *  active */
#define XVTC_FSXX_VSTART_SHIFT	16	   /**< Bit shift for the vertical
					     * line count */
#define XVTC_FSXX_HSTART_MASK	0x00001FFF /**< Horizontal cycle count during
					     *  which current Frame Sync is
					     *  active */
/*@}*/

/** @name VTC Generator Global Delay
 *  @{
 */
#define XVTC_GGD_VDELAY_MASK	0x1FFF0000 /**< Total lines per frame to delay
					     *	generator output */
#define XVTC_GGD_VDELAY_SHIFT	16	   /**< Bit shift for the total
					     *	lines */
#define XVTC_GGD_HDELAY_MASK	0x00001FFF /**< Total clock cycles per line to
					     *  delay generator output */
/*@}*/

/** @name VTC Generator/Detector VBlank/VSync Hori. Offset registers
 *  @{
 */
#define XVTC_XVXHOX_HEND_MASK	0x1FFF0000 /**< Horizontal Offset End */
#define XVTC_XVXHOX_HEND_SHIFT	16		   /**< Horizontal Offset End Shift */
#define XVTC_XVXHOX_HSTART_MASK	0x00001FFF /**< Horizontal Offset Start */
/*@}*/

/** @name Reset Register bit definition
 *  @{
 */
#define XVTC_RESET_RESET_MASK	0x80000000 /**< Software Reset */
#define XVTC_SYNC_RESET_MASK	0x40000000 /**< Frame Sync'ed Software Reset */
/*@}*/

/** @name Version Register bit definition
 *  @{
 */
#define XVTC_VER_MAJOR_MASK	0xFF000000	/**< Major Version*/
#define XVTC_VER_MAJOR_SHIFT	24		/**< Major Version Bit Shift*/
#define XVTC_VER_MINOR_MASK	0x00FF0000	/**< Minor Version */
#define XVTC_VER_MINOR_SHIFT	16		/**< Minor Version Bit Shift*/
#define XVTC_VER_REV_MASK	0x0000F000	/**< Revision Version */
#define XVTC_VER_REV_SHIFT	12		/**< Revision Bit Shift*/
/*@}*/

/** @name Interrupt Status/Enable Register bit definition
 *  @{
 */
#define XVTC_IXR_FSYNC15_MASK	0x80000000 /**< Frame Sync Interrupt 15 */
#define XVTC_IXR_FSYNC14_MASK	0x40000000 /**< Frame Sync Interrupt 14 */
#define XVTC_IXR_FSYNC13_MASK	0x20000000 /**< Frame Sync Interrupt 13 */
#define XVTC_IXR_FSYNC12_MASK	0x10000000 /**< Frame Sync Interrupt 12 */
#define XVTC_IXR_FSYNC11_MASK	0x08000000 /**< Frame Sync Interrupt 11 */
#define XVTC_IXR_FSYNC10_MASK	0x04000000 /**< Frame Sync Interrupt 10 */
#define XVTC_IXR_FSYNC09_MASK	0x02000000 /**< Frame Sync Interrupt 09 */
#define XVTC_IXR_FSYNC08_MASK	0x01000000 /**< Frame Sync Interrupt 08 */
#define XVTC_IXR_FSYNC07_MASK	0x00800000 /**< Frame Sync Interrupt 07 */
#define XVTC_IXR_FSYNC06_MASK	0x00400000 /**< Frame Sync Interrupt 06 */
#define XVTC_IXR_FSYNC05_MASK	0x00200000 /**< Frame Sync Interrupt 05 */
#define XVTC_IXR_FSYNC04_MASK	0x00100000 /**< Frame Sync Interrupt 04 */
#define XVTC_IXR_FSYNC03_MASK	0x00080000 /**< Frame Sync Interrupt 03 */
#define XVTC_IXR_FSYNC02_MASK	0x00040000 /**< Frame Sync Interrupt 02 */
#define XVTC_IXR_FSYNC01_MASK	0x00020000 /**< Frame Sync Interrupt 01 */
#define XVTC_IXR_FSYNC00_MASK	0x00010000 /**< Frame Sync Interrupt 00 */
#define XVTC_IXR_FSYNCALL_MASK	0xFFFF0000 /**< All Frame Sync Interrupt 0-15*/

#define XVTC_IXR_G_AV_MASK	0x00002000 /**< Generator Active Video Intr */
#define XVTC_IXR_G_VBLANK_MASK	0x00001000 /**< Generator VBLANK Interrupt */
#define XVTC_IXR_G_ALL_MASK	0x00003000 /**< All Generator interrupts */

#define XVTC_IXR_D_AV_MASK	0x00000800 /**< Detector Active Video Intr */
#define XVTC_IXR_D_VBLANK_MASK	0x00000400 /**< Detector VBLANK Interrupt */
#define XVTC_IXR_D_ALL_MASK	0x00000C00 /**< All Detector interrupts */

#define XVTC_IXR_LOL_MASK	0x00000200 /**< Lock Loss */
#define XVTC_IXR_LO_MASK	0x00000100 /**< Lock  */
#define XVTC_IXR_LOCKALL_MASK	0x00000300 /**< All Signal Lock interrupt */

#define XVTC_IXR_ACL_MASK	0x00200000 /**< Active Chroma signal lock */
#define XVTC_IXR_AVL_MASK	0x00100000 /**< Active Video Signal Lock */
#define XVTC_IXR_HSL_MASK	0x00080000 /**< Horizontal Sync Signal Lock */
#define XVTC_IXR_VSL_MASK	0x00040000 /**< Vertical Sync Signal Lock */
#define XVTC_IXR_HBL_MASK	0x00020000 /**< Horizontal Blank Signal Lock */
#define XVTC_IXR_VBL_MASK	0x00010000 /**< Vertical Blank Signal Lock */

#define XVTC_IXR_ALLINTR_MASK	(XVTC_IXR_FSYNCALL_MASK | \
					XVTC_IXR_G_ALL_MASK | \
					XVTC_IXR_D_ALL_MASK | \
					XVTC_IXR_LOCKALL_MASK) /**< Mask for
								*   all
								*   interrupts
								*/
/*@}*/

/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/

/** @name Register Access Macro Definition
 *  @{
 */
#define XVtc_In32		Xil_In32
#define XVtc_Out32		Xil_Out32

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param	BaseAddress is the base address of the device
* @param	RegOffset is the register offset to be read
*
* @return	The 32-bit value of the register
*
* @note
* C-style signature:
*	 u32 XVtc_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define XVtc_ReadReg(BaseAddress, RegOffset) \
	XVtc_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param	BaseAddress is the base address of the device
* @param	RegOffset is the register offset to be written
* @param	Data is the 32-bit value to write to the register
*
* @return	None.
*
* @note
* C-style signature:
*	 void XVtc_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define XVtc_WriteReg(BaseAddress, RegOffset, Data) \
	XVtc_Out32((BaseAddress) + (RegOffset), (Data))

/*@}*/

/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
