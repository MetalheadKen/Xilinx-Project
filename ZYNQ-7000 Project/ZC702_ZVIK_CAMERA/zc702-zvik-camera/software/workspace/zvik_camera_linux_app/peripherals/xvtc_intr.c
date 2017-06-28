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
* @file xvtc_intr.c
*
* This code contains interrupt related functions of Xilinx MVI VTC
* device driver. Please see xvtc.h for more details of the driver.
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
* </pre>
*
******************************************************************************/

#include "xvtc.h"

/*****************************************************************************/
/**
*
* This function is the interrupt handler for the VTC driver.
*
* This handler reads the pending interrupt from the IER/ISR, determines the
* source of the interrupts, calls according callbacks, and finally clears the
* interrupts.
*
* The application is responsible for connecting this function to the interrupt
* system. Application beyond this driver is also responsible for providing
* callbacks to	handle interrupts and installing the callbacks using
* XVtc_SetCallBack() during initialization phase. An example delivered
* with this driver demonstrates how this could be done.
*
* @param   InstancePtr is a pointer to the XVtc instance that just
*	   interrupted.
* @return  None.
* @note	   None.
*
******************************************************************************/
void XVtc_IntrHandler(void *InstancePtr)
{
	u32 PendingIntr;
	u32 ErrorStatus;
	XVtc *XVtcPtr = (XVtc *) InstancePtr;

	/* Validate parameters */
	Xil_AssertVoid(XVtcPtr != NULL);
	Xil_AssertVoid(XVtcPtr->IsReady == XIL_COMPONENT_IS_READY);

	/* Get pending interrupts */
	PendingIntr = XVtc_IntrGetPending(XVtcPtr);

	/* Clear pending interrupt(s) */
	XVtc_IntrClear(XVtcPtr, PendingIntr);

	/* Spurious interrupt has happened */
	if (0 == (PendingIntr | XVTC_IXR_ALLINTR_MASK)) {
		ErrorStatus = 0;
		XVtcPtr->ErrCallBack(XVtcPtr->ErrRef, ErrorStatus);
		return;
	}

	/* A generator event has happened */
	if ((PendingIntr & XVTC_IXR_G_ALL_MASK))
		XVtcPtr->GeneratorCallBack(XVtcPtr->GeneratorRef,
		PendingIntr);

	/* A detector event has happened */
	if ((PendingIntr & XVTC_IXR_D_ALL_MASK))
		XVtcPtr->DetectorCallBack(XVtcPtr->DetectorRef,
		PendingIntr);

	/* A frame sync is done */
	if ((PendingIntr & XVTC_IXR_FSYNCALL_MASK))
		XVtcPtr->FrameSyncCallBack(XVtcPtr->FrameSyncRef,
		PendingIntr);

	/* A signal lock is detected */
	if ((PendingIntr & XVTC_IXR_LOCKALL_MASK))
		XVtcPtr->LockCallBack(XVtcPtr->LockRef,
		PendingIntr);
}


/*****************************************************************************/
/**
*
* This routine installs an asynchronous callback function for the given
* HandlerType:
*
* <pre>
* HandlerType		   Callback Function Type
* -----------------------  ---------------------------
* XVTC_HANDLER_FRAMESYNC   XVtc_FrameSyncCallBack
* XVTC_HANDLER_LOCK	   XVtc_LockCallBack
* XVTC_HANDLER_DETECTOR	   XVtc_DetectorCallBack
* XVTC_HANDLER_GENERATOR   XVtc_GeneratorCallBack
* XVTC_HANDLER_ERROR	   XVtc_ErrCallBack
*
* HandlerType		   Invoked by this driver when:
* -----------------------  --------------------------------------------------
* XVTC_HANDLER_FRAMESYNC   A frame sync event happens
* XVTC_HANDLER_LOCK	   A signal lock event happens
* XVTC_HANDLER_DETECTOR	   A detector related event happens
* XVTC_HANDLER_GENERATOR   A generator related event happens
* XVTC_HANDLER_ERROR	   An error condition happens
*
* </pre>
*
* @param	InstancePtr is a pointer to the XVtc instance to be worked
*               on.
* @param	HandlerType specifies which callback is to be attached.
* @param	CallbackFunc is the address of the callback function.
* @param	CallbackRef is a user data item that will be passed to the
*		callback function when it is invoked.
*
* @return
*		- XST_SUCCESS when handler is installed.
*		- XST_INVALID_PARAM when HandlerType is invalid.
*
* @note
* Invoking this function for a handler that already has been installed replaces
* it with the new handler.
*
******************************************************************************/
int XVtc_SetCallBack(XVtc *InstancePtr, u32 HandlerType,
				void *CallBackFunc, void *CallBackRef)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	switch (HandlerType) {
	case XVTC_HANDLER_FRAMESYNC:
		InstancePtr->FrameSyncCallBack =
				(XVtc_CallBack) CallBackFunc;
		InstancePtr->FrameSyncRef = CallBackRef;
		break;

	case XVTC_HANDLER_LOCK:
		InstancePtr->LockCallBack = (XVtc_CallBack) CallBackFunc;
		InstancePtr->LockRef = CallBackRef;
		break;

	case XVTC_HANDLER_DETECTOR:
		InstancePtr->DetectorCallBack =
				(XVtc_CallBack) CallBackFunc;
		InstancePtr->DetectorRef = CallBackRef;
		break;

	case XVTC_HANDLER_GENERATOR:
		InstancePtr->GeneratorCallBack =
				(XVtc_CallBack) CallBackFunc;
		InstancePtr->GeneratorRef = CallBackRef;
		break;

	case XVTC_HANDLER_ERROR:
		InstancePtr->ErrCallBack =
				(XVtc_ErrorCallBack) CallBackFunc;
		InstancePtr->ErrRef = CallBackRef;
		break;

	default:
		return XST_INVALID_PARAM;

	}
	return XST_SUCCESS;
}
