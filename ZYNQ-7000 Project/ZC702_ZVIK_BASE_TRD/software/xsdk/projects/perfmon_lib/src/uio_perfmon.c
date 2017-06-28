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
* @file uio_perfmon.c
*
* This file provides implements AXI perf-mon internal interface .
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

#define PerfMon_HACK

#include <assert.h>
#include <unistd.h>
#include <stdio.h>
#include "uio_common.h"
#include "uio_perfmon.h"
#include "uio_perfmon_hw.h"

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)


static uio_info uPMonInfo;


/*****************************************************************************/
/**
*
* This function resets all Metric Counters of AXI Performance Monitor
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	XST_SUCCESS
*
*
* @note		None.
*
******************************************************************************/
int XAxiPmon_ResetMetricCounter(const uio_handle *InstancePtr)
{
	u32 RegValue;

	/*
	 * Assert the arguments.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Write the reset value to the Control register to reset
	 * Metric counters
	 */
	RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
							 XAPM_CTL_OFFSET);
	XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress, XAPM_CTL_OFFSET,
					(RegValue | XAPM_CR_MCNTR_RESET_MASK));
	/*
	 * Release from Reset
	 */
	XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress, XAPM_CTL_OFFSET,
				(RegValue & ~(XAPM_CR_MCNTR_RESET_MASK)));

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function resets Global Clock Counter of AXI Performance Monitor
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void XAxiPmon_ResetGlobalClkCounter(const uio_handle *InstancePtr)
{
	u32 RegValue;

	/*
	 * Assert the arguments.
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Write the reset value to the Control register to reset
	 * Global Clock Counter
	 */
	RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
							 XAPM_CTL_OFFSET);
	XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress, XAPM_CTL_OFFSET,
					(RegValue | XAPM_CR_GCC_RESET_MASK));

	/*
	 * Release from Reset
	 */
	XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress, XAPM_CTL_OFFSET,
				(RegValue & ~(XAPM_CR_GCC_RESET_MASK)));
}

/*****************************************************************************/
/**
*
* This function resets Streaming FIFO of AXI Performance Monitor
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	XST_SUCCESS
*
* @note		None.
*
******************************************************************************/
int XAxiPmon_ResetFifo(const uio_handle *InstancePtr)
{
	u32 RegValue;

	/*
	 * Assert the arguments.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Write the reset value to the Control register to reset
	 * FIFO
	 */
	RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
							 XAPM_CTL_OFFSET);
	XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress, XAPM_CTL_OFFSET,
					(RegValue | XAPM_CR_FIFO_RESET_MASK));
	/*
	 * Release from Reset
	 */
	XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress, XAPM_CTL_OFFSET,
				(RegValue & ~(XAPM_CR_FIFO_RESET_MASK)));

	return XST_SUCCESS;
}


/****************************************************************************/
/**
*
* This routine enables the Global Interrupt.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	None.
*
* @note		C-Style signature:
*		void XAxiPmon_IntrGlobalEnable(const uio_handle *InstancePtr)
*
*****************************************************************************/
#define XAxiPmon_IntrGlobalEnable(InstancePtr)			\
	XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, 	\
			XAPM_GIE_OFFSET, 1)


/****************************************************************************/
/**
*
* This routine disables the Global Interrupt.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	None.
*
* @note		C-Style signature:
*		void XAxiPmon_IntrGlobalDisable(const uio_handle *InstancePtr)
*
*****************************************************************************/
#define XAxiPmon_IntrGlobalDisable(InstancePtr)				\
	XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, 		\
				XAPM_GIE_OFFSET, 0)


/****************************************************************************/
/**
*
* This routine enables interrupt(s). Use the XAPM_IXR_* constants defined in
* xaxipmon_hw.h to create the bit-mask to enable interrupts.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
* @param	Mask is the mask to enable. Bit positions of 1 will be enabled.
*		Bit positions of 0 will keep the previous setting. This mask is
*		formed by OR'ing XAPM_IXR__* bits defined in xaxipmon_hw.h.
*
* @return	None.
*
* @note		C-Style signature:
*		void XAxiPmon_IntrEnable(const uio_handle *InstancePtr, u32 Mask)
*
*****************************************************************************/
#define XAxiPmon_IntrEnable(InstancePtr, Mask)				     \
	XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, XAPM_IE_OFFSET, \
			XAxiPmon_ReadReg((InstancePtr)->Control_bus_BaseAddress, \
			XAPM_IE_OFFSET) | Mask);


/****************************************************************************/
/**
*
* This routine disable interrupt(s). Use the XAPM_IXR_* constants defined in
* xaxipmon_hw.h to create the bit-mask to disable interrupts.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
* @param	Mask is the mask to disable. Bit positions of 1 will be
*		disabled. Bit positions of 0 will keep the previous setting.
*		This mask is formed by OR'ing XAPM_IXR_* bits defined in
*		xaxipmon_hw.h.
*
* @return	None.
*
* @note		C-Style signature:
*		void XAxiPmon_IntrEnable(const uio_handle *InstancePtr, u32 Mask)
*
*****************************************************************************/
#define XAxiPmon_IntrDisable(InstancePtr, Mask)				     \
	XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, XAPM_IE_OFFSET, \
			XAxiPmon_ReadReg((InstancePtr)->Control_bus_BaseAddress, \
			XAPM_IE_OFFSET) | Mask);

/****************************************************************************/
/**
*
* This routine clears the specified interrupt(s).
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
* @param	Mask is the mask to clear. Bit positions of 1 will be cleared.
*		This mask is formed by OR'ing XAPM_IXR_* bits defined in
*		xaxipmon_hw.h.
*
* @return	None.
*
* @note		C-Style signature:
*		void XAxiPmon_IntrClear(const uio_handle *InstancePtr, u32 Mask)
*
*****************************************************************************/
#define XAxiPmon_IntrClear(InstancePtr, Mask)				     \
	XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, XAPM_IS_OFFSET, \
			XAxiPmon_ReadReg((InstancePtr)->Control_bus_BaseAddress, \
			XAPM_IS_OFFSET) | Mask);

/****************************************************************************/
/**
*
* This routine returns the Interrupt Status Register when running application in Poll-mode.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	Interrupt Status Register contents
*
* @note		C-Style signature:
*		void XAxiPmon_IntrGetStatus(const uio_handle *InstancePtr)
*
*****************************************************************************/
#define XAxiPmon_IntrGetStatus(InstancePtr)				     \
			XAxiPmon_ReadReg((InstancePtr)->Control_bus_BaseAddress, \
			XAPM_IS_OFFSET);

/****************************************************************************/
/**
*
* This function sets Metrics for specified Counter in the corresponding
* Metric Selector Register.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
* @param	Slot is the slot ID for which specified counter has to
*		be connected.
* @param	Metrics is one of the Metric Sets. User has to use
*		XAPM_METRIC_SET_* macros in xaxipmon.h for this parameter
* @param	CounterNum is the Counter Number.
*		The valid values are 0 to 9.
*
* @return	XST_SUCCESS if Success
*		XST_FAILURE if Failure
*
* @note		None.
*
*****************************************************************************/
int XAxiPmon_SetMetrics(const uio_handle *InstancePtr, u8 Slot, u8 Metrics,
						u8 CounterNum)
{
	u32 RegValue;
	u32 Mask;
	/*
	 * Assert the arguments.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/* Find Mask value to force zero in counternum byte range */
	if (CounterNum == 0 || CounterNum == 4 || CounterNum == 8) {
		Mask = 0xFFFFFF00;
	}
	else if (CounterNum == 1 || CounterNum == 5 || CounterNum == 9) {
		Mask = 0xFFFF00FF;
	}
	else if (CounterNum == 2 || CounterNum == 6) {
		Mask = 0xFF00FFFF;
	}
	else {
		Mask = 0x00FFFFFF;
	}

	if(CounterNum <= 3) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
					    XAPM_MSR0_OFFSET);

		RegValue = RegValue & Mask;
		RegValue = RegValue | (Metrics << (CounterNum * 8));
		RegValue = RegValue | (Slot << (CounterNum * 8 + 5));
		XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
					XAPM_MSR0_OFFSET,RegValue);
	}
	else if((CounterNum >= 4) && (CounterNum <= 7)) {
		CounterNum = CounterNum - 4;
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
					    XAPM_MSR1_OFFSET);

		RegValue = RegValue & Mask;
		RegValue = RegValue | (Metrics << (CounterNum * 8));
		RegValue = RegValue | (Slot << (CounterNum * 8 + 5));
		XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
					XAPM_MSR1_OFFSET,RegValue);
	}
	else {
		CounterNum = CounterNum - 8;
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
					    XAPM_MSR2_OFFSET);

		RegValue = RegValue & Mask;
		RegValue = RegValue | (Metrics << (CounterNum * 8));
		RegValue = RegValue | (Slot << (CounterNum * 8 + 5));
		XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
					XAPM_MSR2_OFFSET,RegValue);
	}
	return XST_SUCCESS;
}


/****************************************************************************/
/**
*
* This function returns the contents of the Metric Counter Register.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
* @param	CounterNum is the number of the Metric Counter to be read.
*		Use the XAPM_METRIC_COUNTER* defines for the counter number in
*		xaxipmon.h. The valid values are 0 (XAPM_METRIC_COUNTER_0) to
*		9 (XAPM_METRIC_COUNTER_9).
* @return	RegValue is the content of specified Metric Counter.
*
* @note		None.
*
*****************************************************************************/
u32 XAxiPmon_GetMetricCounter(const uio_handle *InstancePtr, u32 CounterNum)
{

	u32 RegValue;

	/*
	 * Assert the arguments.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	if (CounterNum < 10 ) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_MC0_OFFSET + (CounterNum * 16)));
	}
	else if (CounterNum >= 10 && CounterNum < 12) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_MC10_OFFSET + ((CounterNum - 10) * 16)));
	}
	else if (CounterNum >= 12 && CounterNum < 24) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_MC12_OFFSET + ((CounterNum - 12) * 16)));
	}
	else if (CounterNum >= 24 && CounterNum < 36) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_MC24_OFFSET + ((CounterNum - 24) * 16)));
	}
	else
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_MC36_OFFSET + ((CounterNum - 36) * 16)));

	return RegValue;
}

u32 XAxiPmon_GetSampleCounter(const uio_handle *InstancePtr, u32 CounterNum)
{

	u32 RegValue;

	/*
	 * Assert the arguments.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	if (CounterNum < 10 ) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_SMC0_OFFSET + (CounterNum * 16)));
	}
	else if (CounterNum >= 10 && CounterNum < 12) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_SMC10_OFFSET + ((CounterNum - 10) * 16)));
	}
	else if (CounterNum >= 12 && CounterNum < 24) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_SMC12_OFFSET + ((CounterNum - 12) * 16)));
	}
	else if (CounterNum >= 24 && CounterNum < 36) {
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_SMC24_OFFSET + ((CounterNum - 24) * 16)));
	}
	else
		RegValue = XAxiPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,
			(XAPM_SMC36_OFFSET + ((CounterNum - 36) * 16)));

	return RegValue;
}
/****************************************************************************/
/**
*
* This function loads the sample interval register value into the sample
* interval counter.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	None
*
* @note		C-Style signature:
*		void XAxiPmon_LoadSampleIntervalCounter(const uio_handle *InstancePtr);
*
*****************************************************************************/
#define XAxiPmon_LoadSampleIntervalCounter(InstancePtr) \
       XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, XAPM_SICR_OFFSET, \
							XAPM_SICR_LOAD_MASK);



/****************************************************************************/
/**
*
* This enables Reset of Metric Counters when Sample Interval Counter lapses.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	None
*
* @note		C-Style signature:
*		void XAxiPmon_EnableMetricCounterReset(const uio_handle *InstancePtr);
*
*****************************************************************************/
#define XAxiPmon_EnableMetricCounterReset(InstancePtr) \
	XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, XAPM_SICR_OFFSET,\
						XAPM_SICR_MCNTR_RST_MASK);



/****************************************************************************/
/**
*
* This function sets the Sample Interval Register
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
* @param	SampleIntervalHigh is the Sample Interval Register higher
*		32 bits.
* @param	SampleIntervalLow is the Sample Interval Register lower
*		32 bits.
*
* @return	None
*
* @note		None.
*
*****************************************************************************/
void XAxiPmon_SetSampleInterval(const uio_handle *InstancePtr, u32 SampleIntervalHigh,
				u32 SampleIntervalLow)
{

	/*
	 * Assert the arguments.
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	if(APM_COUNTER_WIDTH == 64) {
		/*
		 * Set Sample Interval Upper
		 */
		XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			XAPM_SI_HIGH_OFFSET, SampleIntervalHigh);
	}

	/*
	 * Set Sample Interval Lower
	 */
	XAxiPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
		XAPM_SI_LOW_OFFSET, SampleIntervalLow);

}


/****************************************************************************/
/**
*
* This enables the down count of the sample interval counter.
*
* @param	InstancePtr is a pointer to the XAxiPmon instance.
*
* @return	None
*
* @note		C-Style signature:
*	   void XAxiPmon_EnableSampleIntervalCounter(const uio_handle *InstancePtr);
*
*****************************************************************************/
#define XAxiPmon_EnableSampleIntervalCounter(InstancePtr) \
	XAxiPmon_WriteReg((InstancePtr)->Control_bus_BaseAddress, XAPM_SICR_OFFSET,\
							XAPM_SICR_ENABLE_MASK);


//-------------------------------------- interface

int uPerfMon_Init()
{
	uio_handle pmon_handle;

	int ret = uio_Initialize(&uPMonInfo, APM_INSTANCE_NAME);
	if (ret == XST_DEVICE_NOT_FOUND)
		return ret;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);

	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);

	XAxiPmon_SetSampleInterval(&pmon_handle, 0, APM_SAMPLE_VALUE); // Equals 1 second

	uio_release_handle(&uPMonInfo,&pmon_handle, MAP_CNT);

	return ret;
}

void uPerfMon_Enable()
{
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);

	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);

	// Load Sample Interval Counter and start Countdown
	XAxiPmon_LoadSampleIntervalCounter(&pmon_handle);
	XAxiPmon_WriteReg((&pmon_handle)->Control_bus_BaseAddress, XAPM_SICR_OFFSET, 0);
	XAxiPmon_WriteReg((&pmon_handle)->Control_bus_BaseAddress, XAPM_SICR_OFFSET, 0x101);
	XAxiPmon_WriteReg((&pmon_handle)->Control_bus_BaseAddress, XAPM_CTL_OFFSET, 0x202);
	XAxiPmon_WriteReg((&pmon_handle)->Control_bus_BaseAddress, XAPM_CTL_OFFSET, 0x101);
	// Enable the interrupts for "Sample Interval Counter" overflow
        XAxiPmon_IntrEnable(&pmon_handle, XAPM_IXR_SIC_OVERFLOW_MASK);
	// Enable the "Global Interrupt Enable Register"
        XAxiPmon_IntrGlobalEnable(&pmon_handle);

	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);
}


void uPerfMon_Disable()
{
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);

        uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
        assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);
	// Disable the "Global Interrupt Enable Register"
        XAxiPmon_IntrGlobalDisable(&pmon_handle);

        // Disable the interrupts for "Sample Interval Counter" overflow
        XAxiPmon_IntrDisable(&pmon_handle, XAPM_IXR_SIC_OVERFLOW_MASK);

	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);
}

u32 uPerfMon_Check_SIC_Overflow_Mask()
{
	u32 reg = 0;
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);

        uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
        assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);
	reg = ((struct xapm_param *)pmon_handle.params[1])->isr;

	if (reg & XAPM_IXR_SIC_OVERFLOW_MASK)
		reg = 1;

	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);
	return reg;

}


void uPerfMon_RestartCounters()
{
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);

	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);

	u32 reg_value = XAxiPmon_IntrGetStatus(&pmon_handle);
	// Clear Sample Interval Counter Overflow Interrupt Bit
	XAxiPmon_IntrClear(&pmon_handle, reg_value);
	// Load Sample Interval Counter and start Countdown
	XAxiPmon_LoadSampleIntervalCounter(&pmon_handle);
	XAxiPmon_WriteReg((&pmon_handle)->Control_bus_BaseAddress, XAPM_SICR_OFFSET, 0);
	XAxiPmon_WriteReg((&pmon_handle)->Control_bus_BaseAddress, XAPM_SICR_OFFSET, 0x101);

	uio_release_handle(&uPMonInfo,&pmon_handle, MAP_CNT);
}


int uPerfMon_Wait_for_counter_overflow()
{
	u8 buf[255];
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);

        uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
        assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);

        /* Wait for SIC overflow interrupt */
        if (read(uPMonInfo.uio_fd, &buf, 4) < 0)
		perror("Read");

	uio_release_handle(&uPMonInfo,&pmon_handle, MAP_CNT);

	return XST_SUCCESS;
}

unsigned long uPerfMon_getCounterValue(int hp_port, int read_write)
{
	uio_handle pmon_handle;
	int counter_id;
	unsigned long perfCount = 0;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);

	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);

	counter_id = APM_COUNTER_ID(hp_port, read_write);
	perfCount = XAxiPmon_GetSampleCounter(&pmon_handle, counter_id);

	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);

	return perfCount;
}

//-------------------------------------------------------------------------------
