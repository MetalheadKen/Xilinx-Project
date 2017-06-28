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
* @file xvtc.c
*
* This is main code of Xilinx MVI Video Timing Controller (VTC) device driver.
* The VTC device detects and generates video sync signals to Video IP cores
* like MVI Video Scaler. Please see xvtc.h for more details of the driver.
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
* 4.00a cjm  02/08/13 Removed XVTC_CTL_HASS_MASK
* </pre>
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xvtc.h"
#include "xenv.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

static void StubCallBack(void *CallBackRef);
static void StubErrCallBack(void *CallBackRef, u32 ErrorMask);

/************************** Function Definition ******************************/

/*****************************************************************************/
/**
 * This function initializes a VTC device. This function must be called
 * prior to using a VTC device. Initialization of a VTC includes
 * setting up the instance data, and ensuring the hardware is in a quiescent
 * state.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  CfgPtr points to the configuration structure associated with the
 *	   VTC device.
 * @param  EffectiveAddr is the base address of the device. If address
 *	   translation is being used, then this parameter must
 *	   reflect the virtual base address. Otherwise, the physical address
 *	   should be used.
 * @return XST_SUCCESS
 *
 *****************************************************************************/
int XVtc_CfgInitialize(XVtc *InstancePtr, XVtc_Config *CfgPtr,
				u32 EffectiveAddr)
{
	/* Verify arguments */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(CfgPtr != NULL);
	Xil_AssertNonvoid((u32 *)EffectiveAddr != NULL);

	/* Setup the instance */
	memset((void *)InstancePtr, 0, sizeof(XVtc));

	memcpy((void *)&(InstancePtr->Config), (const void *)CfgPtr,
			   sizeof(XVtc_Config));
	InstancePtr->Config.BaseAddress = EffectiveAddr;

	/* Set all handlers to stub values, let user configure this data later
	 */
	InstancePtr->FrameSyncCallBack = (XVtc_CallBack) StubCallBack;
	InstancePtr->LockCallBack = (XVtc_CallBack) StubCallBack;
	InstancePtr->DetectorCallBack = (XVtc_CallBack) StubCallBack;
	InstancePtr->GeneratorCallBack = (XVtc_CallBack) StubCallBack;
	InstancePtr->ErrCallBack = (XVtc_ErrorCallBack) StubErrCallBack;

	/* Reset the hardware and set the flag to indicate the driver is
	  ready */
	InstancePtr->IsReady = XIL_COMPONENT_IS_READY;
	XVtc_Reset(InstancePtr);

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
 * This function enables a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  Type indicates which module (Detector and/or Generator) to enable.
 *	   Valid values could be obtained by bit ORing of XVTC_EN_DETECTOR and
 *	   XVTC_EN_GENERATOR.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_Enable(XVtc *InstancePtr, u32 Type)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/* Read Control register value back */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress,
						XVTC_CTL);

	/* Change the value according to the enabling type and write it back */
	if (Type & XVTC_EN_DETECTOR)
		CtrlRegValue |= XVTC_CTL_DE_MASK;

	if (Type & XVTC_EN_GENERATOR)
		CtrlRegValue |= XVTC_CTL_GE_MASK;

	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_CTL,
				CtrlRegValue);
}

/*****************************************************************************/
/**
 * This function disables a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  Type indicates which module (Detector and/or Generator) to disable.
 *	   Valid values could be obtained by bit ORing of XVTC_EN_DETECTOR and
 *	   XVTC_EN_GENERATOR
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_Disable(XVtc *InstancePtr, u32 Type)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/* Read Control register value back */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress,
						XVTC_CTL);

	/* Change the value according to the disabling type and write it back*/
	if (Type & XVTC_EN_DETECTOR)
		CtrlRegValue &= ~XVTC_CTL_DE_MASK;

	if (Type & XVTC_EN_GENERATOR)
		CtrlRegValue &= ~XVTC_CTL_GE_MASK;

	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_CTL, CtrlRegValue);
}

/*****************************************************************************/
/**
 * This function sets up the output polarity of a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  PolarityPtr points to a Polarity configuration structure w/ the
 *	   setting to use on the VTC device.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetPolarity(XVtc *InstancePtr, XVtc_Polarity *PolarityPtr)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(PolarityPtr != NULL);

	/* Read Control register value back and clear all polarity bits first*/
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress,
						XVTC_GPOL);
	CtrlRegValue &= ~XVTC_CTL_ALLP_MASK;

	/* Change the register value according to the setting in the Polarity
	 * configuration structure
	 */
	if (PolarityPtr->ActiveChromaPol)
		CtrlRegValue |= XVTC_CTL_ACP_MASK;

	if (PolarityPtr->ActiveVideoPol)
		CtrlRegValue |= XVTC_CTL_AVP_MASK;

	if (PolarityPtr->FieldIdPol)
		CtrlRegValue |= XVTC_CTL_FIP_MASK;

	if (PolarityPtr->VBlankPol)
		CtrlRegValue |= XVTC_CTL_VBP_MASK;

	if (PolarityPtr->VSyncPol)
		CtrlRegValue |= XVTC_CTL_VSP_MASK;

	if (PolarityPtr->HBlankPol)
		CtrlRegValue |= XVTC_CTL_HBP_MASK;

	if (PolarityPtr->HSyncPol)
		CtrlRegValue |= XVTC_CTL_HSP_MASK;

	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GPOL, CtrlRegValue);
}

/*****************************************************************************/
/**
 * This function gets the output polarity setting used by a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  PolarityPtr points to a Polarity configuration structure that will
 *	   be populated with the setting used on the VTC device after
 *	   this function returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetPolarity(XVtc *InstancePtr, XVtc_Polarity *PolarityPtr)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(PolarityPtr != NULL);

	/* Clear the Polarity configuration structure */
	memset((void *)PolarityPtr, 0, sizeof(XVtc_Polarity));

	/* Read Control register value back */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GPOL);

	/* Populate the Polarity configuration structure w/ the current setting
	 * used in the device
	 */
	if (CtrlRegValue & XVTC_CTL_ACP_MASK)
		PolarityPtr->ActiveChromaPol = 1;

	if (CtrlRegValue & XVTC_CTL_AVP_MASK)
		PolarityPtr->ActiveVideoPol = 1;

	if (CtrlRegValue & XVTC_CTL_FIP_MASK)
		PolarityPtr->FieldIdPol = 1;

	if (CtrlRegValue & XVTC_CTL_VBP_MASK)
		PolarityPtr->VBlankPol = 1;

	if (CtrlRegValue & XVTC_CTL_VSP_MASK)
		PolarityPtr->VSyncPol = 1;

	if (CtrlRegValue & XVTC_CTL_HBP_MASK)
		PolarityPtr->HBlankPol = 1;

	if (CtrlRegValue & XVTC_CTL_HSP_MASK)
		PolarityPtr->HSyncPol = 1;
}


/*****************************************************************************/
/**
 * This function gets the input polarity setting used by a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  PolarityPtr points to a Polarity configuration structure that will
 *	   be populated with the setting used on the VTC device after
 *	   this function returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetDetectorPolarity(XVtc *InstancePtr, XVtc_Polarity *PolarityPtr)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(PolarityPtr != NULL);

	/* Clear the Polarity configuration structure */
	memset((void *)PolarityPtr, 0, sizeof(XVtc_Polarity));

	/* Read Control register value back */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DPOL);

	/* Populate the Polarity configuration structure w/ the current setting
	 * used in the device
	 */
	if (CtrlRegValue & XVTC_CTL_ACP_MASK)
		PolarityPtr->ActiveChromaPol = 1;

	if (CtrlRegValue & XVTC_CTL_AVP_MASK)
		PolarityPtr->ActiveVideoPol = 1;

	if (CtrlRegValue & XVTC_CTL_FIP_MASK)
		PolarityPtr->FieldIdPol = 1;

	if (CtrlRegValue & XVTC_CTL_VBP_MASK)
		PolarityPtr->VBlankPol = 1;

	if (CtrlRegValue & XVTC_CTL_VSP_MASK)
		PolarityPtr->VSyncPol = 1;

	if (CtrlRegValue & XVTC_CTL_HBP_MASK)
		PolarityPtr->HBlankPol = 1;

	if (CtrlRegValue & XVTC_CTL_HSP_MASK)
		PolarityPtr->HSyncPol = 1;
}

/*****************************************************************************/
/**
 * This function sets up the source selecting of a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on
 * @param  SourcePtr points to a Source Selecting configuration structure with
 *	   the setting to use on the VTC device.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetSource(XVtc *InstancePtr, XVtc_SourceSelect *SourcePtr)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(SourcePtr != NULL);

	/* Read Control register value back and clear all source selection bits
	 * first
	 */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_CTL);
	CtrlRegValue &= ~XVTC_CTL_ALLSS_MASK;

	/* Change the register value according to the setting in the source
	 * selection configuration structure
	 */

	if (SourcePtr->FieldIdPolSrc)
		CtrlRegValue |= XVTC_CTL_FIPSS_MASK;

	if (SourcePtr->ActiveChromaPolSrc)
		CtrlRegValue |= XVTC_CTL_ACPSS_MASK;

	if (SourcePtr->ActiveVideoPolSrc)
		CtrlRegValue |= XVTC_CTL_AVPSS_MASK;

	if (SourcePtr->HSyncPolSrc)
		CtrlRegValue |= XVTC_CTL_HSPSS_MASK;

	if (SourcePtr->VSyncPolSrc)
		CtrlRegValue |= XVTC_CTL_VSPSS_MASK;

	if (SourcePtr->HBlankPolSrc)
		CtrlRegValue |= XVTC_CTL_HBPSS_MASK;

	if (SourcePtr->VBlankPolSrc)
		CtrlRegValue |= XVTC_CTL_VBPSS_MASK;


	if (SourcePtr->VChromaSrc)
		CtrlRegValue |= XVTC_CTL_VCSS_MASK;

	if (SourcePtr->VActiveSrc)
		CtrlRegValue |= XVTC_CTL_VASS_MASK;

	if (SourcePtr->VBackPorchSrc)
		CtrlRegValue |= XVTC_CTL_VBSS_MASK;

	if (SourcePtr->VSyncSrc)
		CtrlRegValue |= XVTC_CTL_VSSS_MASK;

	if (SourcePtr->VFrontPorchSrc)
		CtrlRegValue |= XVTC_CTL_VFSS_MASK;

	if (SourcePtr->VTotalSrc)
		CtrlRegValue |= XVTC_CTL_VTSS_MASK;

	if (SourcePtr->HBackPorchSrc)
		CtrlRegValue |= XVTC_CTL_HBSS_MASK;

	if (SourcePtr->HSyncSrc)
		CtrlRegValue |= XVTC_CTL_HSSS_MASK;

	if (SourcePtr->HFrontPorchSrc)
		CtrlRegValue |= XVTC_CTL_HFSS_MASK;

	if (SourcePtr->HTotalSrc)
		CtrlRegValue |= XVTC_CTL_HTSS_MASK;

	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_CTL, CtrlRegValue);
}

/*****************************************************************************/
/**
 * This function gets the source select setting used by a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on
 * @param  SourcePtr points to a source select configuration structure that
 *	   will be populated with the setting used on the VTC device after
 *	   this function returns
 * @return NONE
 *
 *****************************************************************************/
void XVtc_GetSource(XVtc *InstancePtr, XVtc_SourceSelect *SourcePtr)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(SourcePtr != NULL);

	/* Clear the source selection configuration structure */
	memset((void *)SourcePtr, 0, sizeof(XVtc_SourceSelect));

	/* Read Control register value back */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_CTL);

	/* Populate the source select configuration structure with the current
	 * setting used in the device
	 */
	if (CtrlRegValue & XVTC_CTL_FIPSS_MASK)
		SourcePtr->FieldIdPolSrc = 1;
	if (CtrlRegValue & XVTC_CTL_ACPSS_MASK)
		SourcePtr->ActiveChromaPolSrc = 1;
	if (CtrlRegValue & XVTC_CTL_AVPSS_MASK)
		SourcePtr->ActiveVideoPolSrc= 1;
	if (CtrlRegValue & XVTC_CTL_HSPSS_MASK)
		SourcePtr->HSyncPolSrc = 1;
	if (CtrlRegValue & XVTC_CTL_VSPSS_MASK)
		SourcePtr->VSyncPolSrc = 1;
	if (CtrlRegValue & XVTC_CTL_HBPSS_MASK)
		SourcePtr->HBlankPolSrc = 1;
	if (CtrlRegValue & XVTC_CTL_VBPSS_MASK)
		SourcePtr->VBlankPolSrc = 1;

	if (CtrlRegValue & XVTC_CTL_VCSS_MASK)
		SourcePtr->VChromaSrc = 1;
	if (CtrlRegValue & XVTC_CTL_VASS_MASK)
		SourcePtr->VActiveSrc = 1;
	if (CtrlRegValue & XVTC_CTL_VBSS_MASK)
		SourcePtr->VBackPorchSrc = 1;
	if (CtrlRegValue & XVTC_CTL_VSSS_MASK)
		SourcePtr->VSyncSrc = 1;
	if (CtrlRegValue & XVTC_CTL_VFSS_MASK)
		SourcePtr->VFrontPorchSrc = 1;
	if (CtrlRegValue & XVTC_CTL_VTSS_MASK)
		SourcePtr->VTotalSrc = 1;
	if (CtrlRegValue & XVTC_CTL_HBSS_MASK)
		SourcePtr->HBackPorchSrc = 1;
	if (CtrlRegValue & XVTC_CTL_HSSS_MASK)
		SourcePtr->HSyncSrc = 1;
	if (CtrlRegValue & XVTC_CTL_HFSS_MASK)
		SourcePtr->HFrontPorchSrc = 1;
	if (CtrlRegValue & XVTC_CTL_HTSS_MASK)
		SourcePtr->HTotalSrc = 1;
}

/*****************************************************************************/
/**
 * This function sets up the line skip setting of the Generator in a VTC 
 * device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  GeneratorChromaSkip indicates whether to skip 1 line between
 *	   active chroma for the Generator module. Use Non-0 value for this
 *	   parameter to skip 1 line, and 0 to not skip lines
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetSkipLine(XVtc *InstancePtr, int GeneratorChromaSkip)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/* Read Control register value back and clear all skip bits first */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress,
						XVTC_GFENC);
	CtrlRegValue &= ~XVTC_CTL_GACLS_MASK;

	/* Change the register value according to the skip setting passed
	 * into this function.
	 */
	if (GeneratorChromaSkip)
		CtrlRegValue |= XVTC_CTL_GACLS_MASK;

	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GFENC,
				CtrlRegValue);
}

/*****************************************************************************/
/**
 * This function gets the line skip setting used by the Generator in a VTC
 * device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  GeneratorChromaSkipPtr will point to the value indicating whether
 *	   1 line is skipped between active chroma for the Generator module
 *	   after this function returns. value 1 means that 1 line is skipped,
 *	   and 0 means that no lines are skipped
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetSkipLine(XVtc *InstancePtr, int *GeneratorChromaSkipPtr)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(GeneratorChromaSkipPtr != NULL);

	/* Read Control register value back */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GFENC);

	/* Populate the skip variable values according to the skip setting
	 * used by the device.
	 */
	if (CtrlRegValue & XVTC_CTL_GACLS_MASK)
		*GeneratorChromaSkipPtr = 1;
	else
		*GeneratorChromaSkipPtr = 0;
}

/*****************************************************************************/
/**
 * This function sets up the pixel skip setting of the Generator in a VTC
 * device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  GeneratorChromaSkip indicates whether to skip 1 pixel between
 *	   active chroma for the Generator module. Use Non-0 value for this
 *	   parameter to skip 1 pixel, and 0 to not skip pixels
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetSkipPixel(XVtc *InstancePtr, int GeneratorChromaSkip)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/* Read Control register value back and clear all skip bits first */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress,
						XVTC_GFENC);
	CtrlRegValue &= ~XVTC_CTL_GACPS_MASK;

	/* Change the register value according to the skip setting passed
	 * into this function.
	 */
	if (GeneratorChromaSkip)
		CtrlRegValue |= XVTC_CTL_GACPS_MASK;

	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GFENC,
				CtrlRegValue);
}

/*****************************************************************************/
/**
 * This function gets the pixel skip setting used by the Generator in a VTC
 * device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  GeneratorChromaSkipPtr will point to the value indicating whether
 *	   1 pixel is skipped between active chroma for the Generator module
 *	   after this function returns. value 1 means that 1 pixel is skipped,
 *	   and 0 means that no pixels are skipped
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetSkipPixel(XVtc *InstancePtr, int *GeneratorChromaSkipPtr)
{
	u32 CtrlRegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(GeneratorChromaSkipPtr != NULL);

	/* Read Control register value back */
	CtrlRegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GFENC);

	/* Populate the skip variable values according to the skip setting
	 * used by the device.
	 */
	if (CtrlRegValue & XVTC_CTL_GACPS_MASK)
		*GeneratorChromaSkipPtr = 1;
	else
		*GeneratorChromaSkipPtr = 0;
}

/*****************************************************************************/
/**
 * This function sets up the Generator delay setting of a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  VertDelay indicates the number of total lines per frame to delay
 *	   the generator output. The valid range is from 0 to 4095.
 * @param  HoriDelay indicates the number of total clock cycles per line to
 *	   delay the generator output. The valid range is from 0 to 4095.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetDelay(XVtc *InstancePtr, int VertDelay, int HoriDelay)
{
	u32 RegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(VertDelay >= 0);
	Xil_AssertVoid(HoriDelay >= 0);
	Xil_AssertVoid(VertDelay <= 4095);
	Xil_AssertVoid(HoriDelay <= 4095);

	/* Calculate the delay value */
	RegValue = HoriDelay & XVTC_GGD_HDELAY_MASK;
	RegValue |= (VertDelay << XVTC_GGD_VDELAY_SHIFT) &
			XVTC_GGD_VDELAY_MASK;

	/* Update the Generator Global Delay register w/ the value */
	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GGD, RegValue);
}

/*****************************************************************************/
/**
 * This function gets the Generator delay setting used by a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  VertDelayPtr will point to a value indicating the number of total
 *	   lines per frame to delay the generator output after this function
 *	   returns.
 * @param  HoriDelayPtr will point to a value indicating the number of total
 *	   clock cycles per line to delay the generator output after this
 *	   function returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetDelay(XVtc *InstancePtr, int *VertDelayPtr, int *HoriDelayPtr)
{
	u32 RegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(VertDelayPtr != NULL);
	Xil_AssertVoid(HoriDelayPtr != NULL);

	/* Read the Generator Global Delay register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GGD);

	/* Calculate the delay values */
	*HoriDelayPtr = RegValue & XVTC_GGD_HDELAY_MASK;
	*VertDelayPtr = (RegValue & XVTC_GGD_VDELAY_MASK) >>
				XVTC_GGD_VDELAY_SHIFT;
}

/*****************************************************************************/
/**
 * This function sets up the SYNC setting of a Frame Sync used by VTC
 * device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  FrameSyncIndex indicates the index number of the frame sync.	 The
 *	   valid range is from 0 to 15.
 * @param  VertStart indicates the vertical line count during which the Frame
 *	   Sync is active. The valid range is from 0 to 4095.
 * @param  HoriStart indicates the horizontal cycle count during which the
 *	   Frame Sync is active. The valid range is from 0 to 4095.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetFSync(XVtc *InstancePtr, u16 FrameSyncIndex,
			u16 VertStart, u16 HoriStart)
{
	u32 RegValue;
	u32 RegAddress;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(FrameSyncIndex <= 15);
	Xil_AssertVoid(VertStart <= 4095);
	Xil_AssertVoid(HoriStart <= 4095);

	/* Calculate the sync value */
	RegValue = HoriStart & XVTC_FSXX_HSTART_MASK;
	RegValue |= (VertStart << XVTC_FSXX_VSTART_SHIFT) &
			XVTC_FSXX_VSTART_MASK;

	/* Calculate the frame sync register address to write to */
	RegAddress = XVTC_FS00 + FrameSyncIndex * XVTC_REG_ADDRGAP;

	/* Update the Generator Global Delay register w/ the value */
	XVtc_WriteReg(InstancePtr->Config.BaseAddress, RegAddress, RegValue);

}

/*****************************************************************************/
/**
 * This function gets the SYNC setting of a Frame Sync used by VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  FrameSyncIndex indicates the index number of the frame sync. The
 *	   valid range is from 0 to 15.
 * @param  VertStartPtr will point to the value that indicates the vertical
 *	   line count during which the Frame Sync is active once this function
 *	   returns.
 * @param  HoriStartPtr will point to the value that indicates the horizontal
 *	   cycle count during which the Frame Sync is active once this function
 *	   returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetFSync(XVtc *InstancePtr, u16 FrameSyncIndex,
			u16 *VertStartPtr, u16 *HoriStartPtr)
{
	u32 RegValue;
	u32 RegAddress;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(FrameSyncIndex <= 15);
	Xil_AssertVoid(VertStartPtr != NULL);
	Xil_AssertVoid(VertStartPtr != NULL);

	/* Calculate the frame sync register address to read from */
	RegAddress = XVTC_FS00 + FrameSyncIndex * XVTC_REG_ADDRGAP;

	/* Read the frame sync register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, RegAddress);

	/* Calculate the frame sync values */
	*HoriStartPtr = RegValue & XVTC_FSXX_HSTART_MASK;
	*VertStartPtr = (RegValue & XVTC_FSXX_VSTART_MASK) >>
				XVTC_FSXX_VSTART_SHIFT;
}

/*****************************************************************************/
/**
 * This function sets the VBlank/VSync Horizontal Offsets for the Generator
 * in a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be worked on.
 * @param  HoriOffsets points to a VBlank/VSync Horizontal Offset configuration
 *	   with the setting to use on the VTC device.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetGeneratorHoriOffset(XVtc *InstancePtr,
				XVtc_HoriOffsets *HoriOffsets)
{
	u32 RegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(HoriOffsets != NULL);

	/* Calculate and update Generator VBlank Hori. Offset 0 register value
	 */
	RegValue = (HoriOffsets->V0BlankHoriStart) & XVTC_XVXHOX_HSTART_MASK;
	RegValue |= (HoriOffsets->V0BlankHoriEnd << XVTC_XVXHOX_HEND_SHIFT) &
					XVTC_XVXHOX_HEND_MASK;
	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVBHOFF, RegValue);

	/* Calculate and update Generator VSync Hori. Offset 0 register value
	 */
	RegValue = (HoriOffsets->V0SyncHoriStart) & XVTC_XVXHOX_HSTART_MASK;
	RegValue |= (HoriOffsets->V0SyncHoriEnd << XVTC_XVXHOX_HEND_SHIFT) &
					XVTC_XVXHOX_HEND_MASK;
	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVSHOFF, RegValue);

//	/* Calculate and update Generator VBlank Hori. Offset 1 register value */
//	RegValue = (HoriOffsets->V1BlankHoriStart) & XVTC_XVXHOX_HSTART_MASK;
//	RegValue |= (HoriOffsets->V1BlankHoriEnd << XVTC_XVXHOX_HEND_SHIFT) &
//					XVTC_XVXHOX_HEND_MASK;
//	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVBHO1, RegValue);
//
//	/* Calculate and update Generator VSync Hori. Offset 1 register value */
//	RegValue = (HoriOffsets->V1SyncHoriStart) & XVTC_XVXHOX_HSTART_MASK;
//	RegValue |= (HoriOffsets->V1SyncHoriEnd << XVTC_XVXHOX_HEND_SHIFT) &
//					XVTC_XVXHOX_HEND_MASK;
//	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVSHO1, RegValue);

	return;
}

/*****************************************************************************/
/**
 * This function gets the VBlank/VSync Horizontal Offsets currently used by
 * the Generator in a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  HoriOffsets points to a VBlank/VSync Horizontal Offset configuration
 *	   structure that will be populated with the setting currently used on
 *	   the Generator in the given VTC device after this function returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetGeneratorHoriOffset(XVtc *InstancePtr,
			   XVtc_HoriOffsets *HoriOffsets)
{
	u32 RegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(HoriOffsets != NULL);

	/* Parse Generator VBlank Hori. Offset 0 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVBHOFF);
	HoriOffsets->V0BlankHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V0BlankHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;

	/* Parse Generator VSync Hori. Offset 0 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVSHOFF);
	HoriOffsets->V0SyncHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V0SyncHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;

	/* Parse Generator VBlank Hori. Offset 1 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVBHOFF);
	HoriOffsets->V1BlankHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V1BlankHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;

	/* Parse Generator VSync Hori. Offset 1 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVSHOFF);
	HoriOffsets->V1SyncHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V1SyncHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;

	return;
}

/*****************************************************************************/
/**
 * This function gets the VBlank/VSync Horizontal Offsets detected by
 * the Detector in a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  HoriOffsets points to a VBlank/VSync Horizontal Offset configuration
 *	   structure that will be populated with the setting detected on
 *	   the Detector in the given VTC device after this function returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetDetectorHoriOffset(XVtc *InstancePtr,
				XVtc_HoriOffsets *HoriOffsets)
{
	u32 RegValue;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(HoriOffsets != NULL);

	/* Parse Detector VBlank Hori. Offset 0 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVBHOFF);
	HoriOffsets->V0BlankHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V0BlankHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;

	/* Parse Detector VSync Hori. Offset 0 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVSHOFF);
	HoriOffsets->V0SyncHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V0SyncHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;

	/* Parse Detector VBlank Hori. Offset 1 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVBHOFF);
	HoriOffsets->V1BlankHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V1BlankHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;

	/* Parse Detector VSync Hori. Offset 1 register value */
	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVSHOFF);
	HoriOffsets->V1SyncHoriStart = RegValue & XVTC_XVXHOX_HSTART_MASK;
	HoriOffsets->V1SyncHoriEnd = (RegValue & XVTC_XVXHOX_HEND_MASK)
					>> XVTC_XVXHOX_HEND_SHIFT;


	return;
}

/*****************************************************************************/
/**
 * This function sets up VTC signal to be used by the Generator module
 * in a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  SignalCfgPtr is a pointer to the VTC signal configuration
 *	   to be used by the Generator module in the VTC device.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_SetGenerator(XVtc *InstancePtr, XVtc_Signal *SignalCfgPtr)
{
	u32 RegValue;
  u32 r_htotal, r_vtotal, r_hactive, r_vactive;
	XVtc_Signal *SCPtr;
	XVtc_HoriOffsets horiOffsets;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(SignalCfgPtr != NULL);

	SCPtr = SignalCfgPtr;
  if(SCPtr->OriginMode == 0)
  {
    r_htotal = SCPtr->HTotal+1;
    r_vtotal = SCPtr->V0Total+1;
  
    r_hactive = r_htotal - SCPtr->HActiveStart;
    r_vactive = r_vtotal - SCPtr->V0ActiveStart;
  
  	RegValue = (r_htotal) & 0x1fff;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GHSIZE, RegValue);
  
  	RegValue = (r_vtotal) & 0x1fff;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVSIZE, RegValue);
  
  
  	RegValue = (r_hactive) & 0x1fff;
    RegValue |= ((r_vactive) & 0x1fff) << 16;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GASIZE, RegValue);
  
  ///////////////////////////////////////////////////
  
  	/* Update the Generator Horizontal 1 Register */
  	RegValue = (SCPtr->HSyncStart + r_hactive) & XVTC_GH1_SYNCSTART_MASK;
  	RegValue |= ((SCPtr->HBackPorchStart + r_hactive) << XVTC_GH1_BPSTART_SHIFT) &
  					XVTC_GH1_BPSTART_MASK;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GHSYNC, RegValue);
  
  
  	/* Update the Generator Vertical 1 Register (field 0) */
  	RegValue = (SCPtr->V0SyncStart + r_vactive -1) & XVTC_GV1_SYNCSTART_MASK;
  	RegValue |= ((SCPtr->V0BackPorchStart + r_vactive -1) << XVTC_GV1_BPSTART_SHIFT) &
  					XVTC_GV1_BPSTART_MASK;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVSYNC, RegValue);

    /* Chroma Start */
	  RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DFENC);
    RegValue &= ~XVTC_GV2_CHROMASTART_MASK;
    RegValue = (((SCPtr->V0ChromaStart - SCPtr->V0ActiveStart) << XVTC_GV2_CHROMASTART_SHIFT)
               & XVTC_GV2_CHROMASTART_MASK) | RegValue; 
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_DFENC, RegValue);
  
    /* Setup default Horizontal Offsets - can override later with XVtc_SetGeneratorHoriOffset() */
  	horiOffsets.V0BlankHoriStart = r_hactive;
  	horiOffsets.V0BlankHoriEnd = r_hactive;
  	horiOffsets.V0SyncHoriStart = r_hactive;
  	horiOffsets.V0SyncHoriEnd = r_hactive;
  	horiOffsets.V1BlankHoriStart = r_hactive;
  	horiOffsets.V1BlankHoriEnd = r_hactive;
  	horiOffsets.V1SyncHoriStart = r_hactive;
  	horiOffsets.V1SyncHoriEnd = r_hactive;
  
  	XVtc_SetGeneratorHoriOffset(InstancePtr, &horiOffsets);
  }
  else
  {
    r_htotal = SCPtr->HTotal; /* Total in mode=1 is the line width */
    r_vtotal = SCPtr->V0Total; /* Total in mode=1 is the frame height */
  
    r_hactive = SCPtr->HFrontPorchStart;
    r_vactive = SCPtr->V0FrontPorchStart;
  
  	RegValue = (r_htotal) & 0x1fff;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GHSIZE, RegValue);
  
  	RegValue = (r_vtotal) & 0x1fff;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVSIZE, RegValue);
  
  
  	RegValue = (r_hactive) & 0x1fff;
    RegValue |= ((r_vactive) & 0x1fff) << 16;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GASIZE, RegValue);
  
  ///////////////////////////////////////////////////
  
  	/* Update the Generator Horizontal 1 Register */
  	RegValue = (SCPtr->HSyncStart) & XVTC_GH1_SYNCSTART_MASK;
  	RegValue |= ((SCPtr->HBackPorchStart) << XVTC_GH1_BPSTART_SHIFT) &
  					XVTC_GH1_BPSTART_MASK;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GHSYNC, RegValue);
  
  
  	/* Update the Generator Vertical 1 Register (field 0) */
  	RegValue = (SCPtr->V0SyncStart) & XVTC_GV1_SYNCSTART_MASK;
  	RegValue |= ((SCPtr->V0BackPorchStart) << XVTC_GV1_BPSTART_SHIFT) &
  					XVTC_GV1_BPSTART_MASK;
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_GVSYNC, RegValue);

    /* Chroma Start */
	  RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DFENC);
    RegValue &= ~XVTC_GV2_CHROMASTART_MASK;
    RegValue = (((SCPtr->V0ChromaStart - SCPtr->V0ActiveStart) << XVTC_GV2_CHROMASTART_SHIFT)
               & XVTC_GV2_CHROMASTART_MASK) | RegValue; 
  	XVtc_WriteReg(InstancePtr->Config.BaseAddress, XVTC_DFENC, RegValue);

    /* Setup default Horizontal Offsets - can override later with XVtc_SetGeneratorHoriOffset() */
  	horiOffsets.V0BlankHoriStart = r_hactive;
  	horiOffsets.V0BlankHoriEnd = r_hactive;
  	horiOffsets.V0SyncHoriStart = r_hactive;
  	horiOffsets.V0SyncHoriEnd = r_hactive;
  	horiOffsets.V1BlankHoriStart = r_hactive;
  	horiOffsets.V1BlankHoriEnd = r_hactive;
  	horiOffsets.V1SyncHoriStart = r_hactive;
  	horiOffsets.V1SyncHoriEnd = r_hactive;
  
  	XVtc_SetGeneratorHoriOffset(InstancePtr, &horiOffsets);
  }

}

/*****************************************************************************/
/**
 * This function gets the VTC signal setting used by the Generator module
 * in a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  SignalCfgPtr is a pointer to a VTC signal configuration
 *	   which will be populated with the setting used by the Generator
 *	   module in the VTC device once this function returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetGenerator(XVtc *InstancePtr, XVtc_Signal *SignalCfgPtr)
{
	u32 RegValue;
  u32 r_htotal, r_vtotal, r_hactive, r_vactive;
	XVtc_Signal *SCPtr;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(SignalCfgPtr != NULL);

	SCPtr = SignalCfgPtr;
  if(SCPtr->OriginMode == 0)
  {
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GHSIZE);
  	r_htotal = (RegValue) & 0x1fff;
  	SCPtr->HTotal = (r_htotal-1) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVSIZE);
  	r_vtotal = (RegValue) & 0x1fff;
  	SCPtr->V0Total = (r_vtotal-1) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GASIZE);
  	r_hactive = (RegValue) & 0x1fff;
  	SCPtr->HActiveStart = (r_htotal - r_hactive) & 0x1fff;
  	r_vactive = (RegValue>>16) & 0x1fff;
  	SCPtr->V0ActiveStart = (r_vtotal - r_vactive) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GHSYNC);
    SCPtr->HSyncStart = ((RegValue - r_hactive) & 0x1fff);
    SCPtr->HBackPorchStart = (((RegValue>>16) - r_hactive) & 0x1fff);
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVSYNC);
    SCPtr->V0SyncStart = ((RegValue-r_vactive+1) & 0x1fff);
    SCPtr->V0BackPorchStart = (((RegValue>>16) - r_vactive+1) & 0x1fff);
  
  
  	/* Get signal values from the Generator Vertical 2 Register (field 0)*/
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GFENC);
  	SCPtr->V0ChromaStart = (((RegValue & XVTC_GV2_CHROMASTART_MASK) >>
  					XVTC_GV2_CHROMASTART_SHIFT) + (r_vtotal - r_vactive)) & 0x1fff;
  
  
    SCPtr->HFrontPorchStart = 0;
    SCPtr->V0FrontPorchStart = 0;
  }
  else
  {
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GHSIZE);
  	r_htotal = (RegValue) & 0x1fff;
  	SCPtr->HTotal = (r_htotal) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVSIZE);
  	r_vtotal = (RegValue) & 0x1fff;
  	SCPtr->V0Total = (r_vtotal) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GASIZE);
  	r_hactive = (RegValue) & 0x1fff;
  	SCPtr->HFrontPorchStart = (r_hactive) & 0x1fff;
  	r_vactive = (RegValue>>16) & 0x1fff;
  	SCPtr->V0FrontPorchStart = (r_vactive) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GHSYNC);
    SCPtr->HSyncStart = ((RegValue) & 0x1fff);
    SCPtr->HBackPorchStart = (((RegValue>>16)) & 0x1fff);
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GVSYNC);
    SCPtr->V0SyncStart = ((RegValue) & 0x1fff);
    SCPtr->V0BackPorchStart = (((RegValue>>16)) & 0x1fff);
  
  
  	/* Get signal values from the Generator Vertical 2 Register (field 0)*/
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_GFENC);
  	SCPtr->V0ChromaStart = (((RegValue & XVTC_GV2_CHROMASTART_MASK) >>
  					XVTC_GV2_CHROMASTART_SHIFT)) & 0x1fff;
  
  
  	SCPtr->HActiveStart = 0;
  	SCPtr->V0ActiveStart = 0;
  }
}

/*****************************************************************************/
/**
 * This function gets the VTC signal setting used by the Detector module
 * in a VTC device.
 *
 * @param  InstancePtr is a pointer to the VTC device instance to be
 *	   worked on.
 * @param  SignalCfgPtr is a pointer to a VTC signal configuration
 *	   which will be populated with the setting used by the Detector
 *	   module in the VTC device once this function returns.
 * @return NONE.
 *
 *****************************************************************************/
void XVtc_GetDetector(XVtc *InstancePtr, XVtc_Signal *SignalCfgPtr)
{
	u32 RegValue;
  u32 r_htotal, r_vtotal, r_hactive, r_vactive;
	XVtc_Signal *SCPtr;

	/* Assert bad arguments and conditions */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(SignalCfgPtr != NULL);

	SCPtr = SignalCfgPtr;

  if(SCPtr->OriginMode == 0)
  {
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DHSIZE);
  	r_htotal = (RegValue) & 0x1fff;
  	SCPtr->HTotal = (r_htotal-1) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVSIZE);
  	r_vtotal = (RegValue) & 0x1fff;
  	SCPtr->V0Total = (r_vtotal-1) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DASIZE);
  	r_hactive = (RegValue) & 0x1fff;
  	SCPtr->HActiveStart = (r_htotal - r_hactive) & 0x1fff;
  	r_vactive = (RegValue>>16) & 0x1fff;
  	SCPtr->V0ActiveStart = (r_vtotal - r_vactive) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DHSYNC);
    SCPtr->HSyncStart = ((RegValue - r_hactive) & 0x1fff);
    SCPtr->HBackPorchStart = (((RegValue>>16) - r_hactive) & 0x1fff);
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVSYNC);
    SCPtr->V0SyncStart = ((RegValue-r_vactive+1) & 0x1fff);
    SCPtr->V0BackPorchStart = (((RegValue>>16) - r_vactive+1) & 0x1fff);
  
  
  	/* Get signal values from the Generator Vertical 2 Register (field 0)*/
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DFENC);
  	SCPtr->V0ChromaStart = (((RegValue & XVTC_GV2_CHROMASTART_MASK) >>
  					XVTC_GV2_CHROMASTART_SHIFT) + (r_vtotal - r_vactive)) & 0x1fff;
  
    SCPtr->HFrontPorchStart = 0;
    SCPtr->V0FrontPorchStart = 0;
  }
  else
  {
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DHSIZE);
  	r_htotal = (RegValue) & 0x1fff;
  	SCPtr->HTotal = (r_htotal) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVSIZE);
  	r_vtotal = (RegValue) & 0x1fff;
  	SCPtr->V0Total = (r_vtotal) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DASIZE);
  	r_hactive = (RegValue) & 0x1fff;
  	SCPtr->HFrontPorchStart = (r_hactive) & 0x1fff;
  	r_vactive = (RegValue>>16) & 0x1fff;
  	SCPtr->V0FrontPorchStart = (r_vactive) & 0x1fff;
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DHSYNC);
    SCPtr->HSyncStart = ((RegValue) & 0x1fff);
    SCPtr->HBackPorchStart = (((RegValue>>16)) & 0x1fff);
  
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DVSYNC);
    SCPtr->V0SyncStart = ((RegValue) & 0x1fff);
    SCPtr->V0BackPorchStart = (((RegValue>>16)) & 0x1fff);
  
  
  	/* Get signal values from the Generator Vertical 2 Register (field 0)*/
  	RegValue = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_DFENC);
  	SCPtr->V0ChromaStart = (((RegValue & XVTC_DV2_CHROMASTART_MASK) >>
  					XVTC_DV2_CHROMASTART_SHIFT)) & 0x1fff;
  
  
  	SCPtr->HActiveStart = 0;
  	SCPtr->V0ActiveStart = 0;
  }


}

/*****************************************************************************/
/**
*
* This function returns the version of a VTC device.
*
* @param  InstancePtr is a pointer to the VTC device instance to be
*	  worked on.
* @param  Major points to an unsigned 16-bit variable that will be assigned
*	  with the major version number after this function returns. Value
*	  range is from 0x0 to 0xF.
* @param  Minor points to an unsigned 16-bit variable that will be assigned
*	  with the minor version number after this function returns. Value
*	  range is from 0x00 to 0xFF.
* @param  Revision points to an unsigned 16-bit variable that will be assigned
*	  with the revision version number after this function returns. Value
*	  range is from 0xA to 0xF.
* @return None.
* @note	  Example: Device version should read v2.01.c if major version number
*	  is 0x2, minor version number is 0x1, and revision version number is
*	  0xC.
*
******************************************************************************/
void XVtc_GetVersion(XVtc *InstancePtr, u16 *Major, u16 *Minor, u16 *Revision)
{
	u32 Version;

	/* Verify arguments */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(Major != NULL);
	Xil_AssertVoid(Minor != NULL);
	Xil_AssertVoid(Revision != NULL);

	/* Read device version */
	Version = XVtc_ReadReg(InstancePtr->Config.BaseAddress, XVTC_VER);

	/* Parse the version and pass the info to the caller via output
	 * parameter
	 */
	*Major = (u16)
		((Version & XVTC_VER_MAJOR_MASK) >> XVTC_VER_MAJOR_SHIFT);

	*Minor = (u16)
		((Version & XVTC_VER_MINOR_MASK) >> XVTC_VER_MINOR_SHIFT);

	*Revision = (u16)
		((Version & XVTC_VER_REV_MASK) >> XVTC_VER_REV_SHIFT);

	return;
}

/*****************************************************************************/
/*
 * This routine is a stub for the asynchronous callbacks. The stub is here in
 * case the upper layer forgot to set the handlers. On initialization, All
 * handlers except error handler are set to this callback. It is considered an
 * error for this handler to be invoked.
 *
 *****************************************************************************/
static void StubCallBack(void *CallBackRef)
{
	Xil_AssertVoidAlways();
}

/*****************************************************************************/
/*
 * This routine is a stub for the asynchronous error interrupt callback. The
 * stub is here in case the upper layer forgot to set the error interrupt
 * handler. On initialization, Error interrupt handler is set to this
 * callback. It is considered an error for this handler to be invoked.
 *
 *****************************************************************************/
static void StubErrCallBack(void *CallBackRef, u32 ErrorMask)
{
	Xil_AssertVoidAlways();
}
