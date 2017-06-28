//----------------------------------------------------------------
//      _____
//     /     \
//    /____   \____
//   / \===\   \==/
//  /___\===\___\/  AVNET
//       \======/
//        \====/    
//---------------------------------------------------------------
//
// This design is the property of Avnet.  Publication of this
// design is not authorized without written consent from Avnet.
// 
// Please direct any questions to:  technical.support@avnet.com
//
// Disclaimer:
//    Avnet, Inc. makes no warranty for the use of this code or design.
//    This code is provided  "As Is". Avnet, Inc assumes no responsibility for
//    any errors, which may appear in this code, nor does it make a commitment
//    to update the information contained herein. Avnet, Inc specifically
//    disclaims any implied warranties of fitness for a particular purpose.
//                     Copyright(c) 2011 Avnet, Inc.
//                             All rights reserved.
//
//----------------------------------------------------------------
//
// Create Date:         Sep 19, 2011
// Design Name:         FMC-IMAGEON VITA Receiver
// Module Name:         fmc_imageon_vita_receiver.h
// Project Name:        FMC-IMAGEON
// Target Devices:      Spartan-6, Virtex-6, Kintex-7
// Avnet Boards:        FMC-IMAGEON
//
// Tool versions:       Vivado 2013.3
//
// Description:         FMC-IMAGEON Software Library.
//                      Initial version generated with EDK Create Peripheral Wizard
//                      - contained generic macros to access 32 registers
//                      Driver modified to add:
//                      - Data structure for driver context
//                      - Init routine
//                      - SPI Read routine
//                      - SPI Write routine
//
// Dependencies:        
//
// Revision:            Sep 15, 2011: 1.00 Initial version:
//                                         - VITA SPI controller 
//                      Sep 22, 2011: 1.01 Added:
//                                         - ISERDES interface
//                      Sep 28, 2011: 1.02 Added:
//                                         - sync channel decoder
//                                         - crc checker
//                                         - data remapper
//                      Oct 20, 2011: 1.03 Modify:
//                                         - iserdes (use BUFR)
//                      Oct 21, 2011: 1.04 Added:
//                                         - fpn prnu correction
//                      Nov 03, 2011: 1.05 Added:
//                                         - trigger generator
//                      Dec 19, 2011: 1.06 Modified:
//                                         - port to Kintex-7
//                      Feb 09, 2011: 1.08 Add VITA configuration functions
//                                         - init
//                                         - get_status
//                                         - set_exposure
//                                         - set_analog_gain
//                                         - set_digital_gain
//                      Jun 01, 2012: 1.12 Change syncgen configuration code
//                      Dec 17, 2013: 2.01 Port to Vivado 2013.3
//
//----------------------------------------------------------------


/*****************************************************************************
* Filename:          C:\FMC_IMAGEON_Tests\ml605_avnet_hw04/drivers/fmc_imageon_vita_receiver_v1_00_a/src/fmc_imageon_vita_receiver.h
* Version:           1.00.a
* Description:       fmc_imageon_vita_receiver Driver Header File
* Date:              Thu Sep 15 13:07:28 2011 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef FMC_IMAGEON_VITA_RECEIVER_H
#define FMC_IMAGEON_VITA_RECEIVER_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG0_OFFSET 0
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG1_OFFSET 4
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG2_OFFSET 8
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG3_OFFSET 12
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG4_OFFSET 16
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG5_OFFSET 20
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG6_OFFSET 24
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG7_OFFSET 28
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG8_OFFSET 32
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG9_OFFSET 36
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG10_OFFSET 40
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG11_OFFSET 44
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG12_OFFSET 48
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG13_OFFSET 52
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG14_OFFSET 56
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG15_OFFSET 60
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG16_OFFSET 64
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG17_OFFSET 68
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG18_OFFSET 72
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG19_OFFSET 76
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG20_OFFSET 80
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG21_OFFSET 84
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG22_OFFSET 88
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG23_OFFSET 92
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG24_OFFSET 96
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG25_OFFSET 100
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG26_OFFSET 104
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG27_OFFSET 108
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG28_OFFSET 112
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG29_OFFSET 116
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG30_OFFSET 120
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG31_OFFSET 124
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG32_OFFSET 128
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG33_OFFSET 132
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG34_OFFSET 136
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG35_OFFSET 140
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG36_OFFSET 144
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG37_OFFSET 148
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG38_OFFSET 152
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG39_OFFSET 156
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG40_OFFSET 160
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG41_OFFSET 164
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG42_OFFSET 168
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG43_OFFSET 172
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG44_OFFSET 176
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG45_OFFSET 180
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG46_OFFSET 184
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG47_OFFSET 188
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG48_OFFSET 192
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG49_OFFSET 196
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG50_OFFSET 200
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG51_OFFSET 204
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG52_OFFSET 208
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG53_OFFSET 212
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG54_OFFSET 216
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG55_OFFSET 220
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG56_OFFSET 224
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG57_OFFSET 228
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG58_OFFSET 232
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG59_OFFSET 236
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG60_OFFSET 240
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG61_OFFSET 244
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG62_OFFSET 248
#define FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG63_OFFSET 252

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a FMC_IMAGEON_VITA_RECEIVER register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the FMC_IMAGEON_VITA_RECEIVER device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void FMC_IMAGEON_VITA_RECEIVER_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define FMC_IMAGEON_VITA_RECEIVER_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a FMC_IMAGEON_VITA_RECEIVER register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the FMC_IMAGEON_VITA_RECEIVER device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 FMC_IMAGEON_VITA_RECEIVER_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define FMC_IMAGEON_VITA_RECEIVER_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from FMC_IMAGEON_VITA_RECEIVER user logic slave registers.
 *
 * @param   BaseAddress is the base address of the FMC_IMAGEON_VITA_RECEIVER device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 FMC_IMAGEON_VITA_RECEIVER_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_LV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg8(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG8_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg9(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG9_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg10(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG10_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg11(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG11_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg12(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG12_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg13(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG13_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg14(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG14_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg15(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG15_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg16(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG16_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg17(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG17_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg18(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG18_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg19(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG19_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg20(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG20_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg21(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG21_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg22(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG22_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg23(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG23_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg24(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG24_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg25(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG25_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg26(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG26_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg27(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG27_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg28(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG28_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg29(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG29_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg30(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG30_OFFSET) + (RegOffset), (Xuint32)(Value))
#define FMC_IMAGEON_VITA_RECEIVER_mWriteSlaveReg31(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG31_OFFSET) + (RegOffset), (Xuint32)(Value))

#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG0_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg1(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG1_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg2(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG2_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg3(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG3_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg4(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG4_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg5(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG5_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg6(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG6_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg7(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG7_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg8(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG8_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg9(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG9_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg10(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG10_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg11(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG11_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg12(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG12_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg13(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG13_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg14(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG14_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg15(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG15_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg16(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG16_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg17(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG17_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg18(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG18_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg19(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG19_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg20(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG20_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg21(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG21_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg22(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG22_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg23(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG23_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg24(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG24_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg25(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG25_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg26(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG26_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg27(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG27_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg28(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG28_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg29(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG29_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg30(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG30_OFFSET) + (RegOffset))
#define FMC_IMAGEON_VITA_RECEIVER_mReadSlaveReg31(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (FMC_IMAGEON_VITA_RECEIVER_S00_AXI_SLV_REG31_OFFSET) + (RegOffset))

/************************** Function Prototypes ****************************/

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the FMC_IMAGEON_VITA_RECEIVER instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus FMC_IMAGEON_VITA_RECEIVER_SelfTest(void * baseaddr_p);
/**
*  Defines the number of registers available for read and write*/
#define TEST_AXI_LITE_USER_NUM_REG             32
#define FMC_IMAGEON_VITA_RECEIVER_USER_NUM_REG 32


/*****************************************************************************
*
* User Content Added Here
*
*****************************************************************************/

#define FMC_IMAGEON_VITA_RECEIVER_SPI_CONTROL_REG     0x00000000
#define FMC_IMAGEON_VITA_RECEIVER_SPI_STATUS_REG      0x00000000
   #define FMC_IMAGEON_VITA_RECEIVER_VITA_RESET_BIT       0x00000001
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_RESET_BIT        0x00000002
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_ERROR_BIT        0x00000100
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_BUSY_BIT         0x00000200
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_TXFIFO_FULL_BIT  0x00010000
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_RXFIFO_EMPTY_BIT 0x01000000
#define FMC_IMAGEON_VITA_RECEIVER_SPI_TIMING_REG      0x00000004
#define FMC_IMAGEON_VITA_RECEIVER_SPI_TXFIFO_REG      0x00000008
#define FMC_IMAGEON_VITA_RECEIVER_SPI_RXFIFO_REG      0x0000000C
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_SYNC2_BIT        0x80000000
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_SYNC1_BIT        0x40000000
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_NOP_BIT          0x20000000
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_READ_BIT         0x10000000
   #define FMC_IMAGEON_VITA_RECEIVER_SPI_WRITE_BIT        0x00000000

#define FMC_IMAGEON_VITA_RECEIVER_ISERDES_CONTROL_REG     0x00000010
   #define FMC_IMAGEON_VITA_RECEIVER_ISERDES_RESET_BIT       0x00000001
   #define FMC_IMAGEON_VITA_RECEIVER_ISERDES_AUTO_ALIGN_BIT  0x00000002
   #define FMC_IMAGEON_VITA_RECEIVER_ISERDES_ALIGN_START_BIT 0x00000004
   #define FMC_IMAGEON_VITA_RECEIVER_ISERDES_FIFO_ENABLE_BIT 0x00000008
#define FMC_IMAGEON_VITA_RECEIVER_ISERDES_STATUS_REG      0x00000010
#define FMC_IMAGEON_VITA_RECEIVER_ISERDES_TRAINING_REG    0x00000014
#define FMC_IMAGEON_VITA_RECEIVER_ISERDES_MANUAL_TAP_REG  0x00000018

#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CONTROL_REG           0x00000020
   #define FMC_IMAGEON_VITA_RECEIVER_DECODER_RESET_BIT            0x00000001
   #define FMC_IMAGEON_VITA_RECEIVER_DECODER_ENABLE_BIT           0x00000002
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_STARTODDEVEN_REG      0x00000024
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CODES_LS_LE_REG       0x00000028
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CODES_FS_FE_REG       0x0000002C
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CODES_BL_IMG_REG      0x00000030
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CODES_TR_CRC_REG      0x00000034
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_BLACK_LINES_REG   0x00000038
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_IMAGE_LINES_REG   0x0000003C
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_BLACK_PIXELS_REG  0x00000040
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_IMAGE_PIXELS_REG  0x00000044
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_FRAMES_REG        0x00000048
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_WINDOWS_REG       0x0000004C
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_CLOCKS_REG        0x00000050
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_START_LINES_REG   0x00000054
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_END_LINES_REG     0x00000058
#define FMC_IMAGEON_VITA_RECEIVER_SYNCGEN_DELAY_REG             0x0000005C
#define FMC_IMAGEON_VITA_RECEIVER_SYNCGEN_HTIMING1_REG          0x00000060
#define FMC_IMAGEON_VITA_RECEIVER_SYNCGEN_HTIMING2_REG          0x00000064
#define FMC_IMAGEON_VITA_RECEIVER_SYNCGEN_VTIMING1_REG          0x00000068
#define FMC_IMAGEON_VITA_RECEIVER_SYNCGEN_VTIMING2_REG          0x0000006C

#define FMC_IMAGEON_VITA_RECEIVER_CRC_CONTROL_REG               0x00000070
   #define FMC_IMAGEON_VITA_RECEIVER_CRC_RESET_BIT                 0x00000001
   #define FMC_IMAGEON_VITA_RECEIVER_CRC_INITVALUE_BIT             0x00000002
#define FMC_IMAGEON_VITA_RECEIVER_CRC_STATUS_REG                0x00000074

#define FMC_IMAGEON_VITA_RECEIVER_REMAPPER_CONTROL_REG          0x00000078

#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG           0x00000080
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG0          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x00000000)
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG1          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x00000004)
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG2          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x00000008)
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG3          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x0000000C)
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG4          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x00000010)
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG5          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x00000014)
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG6          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x00000018)
#define FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG7          (FMC_IMAGEON_VITA_RECEIVER_FPN_PRNU_VALUES_REG + 0x0000001C)

#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_MONITOR0_HIGH_REG 0x000000C0
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_MONITOR0_LOW_REG  0x000000C4
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_MONITOR1_HIGH_REG 0x000000C8
#define FMC_IMAGEON_VITA_RECEIVER_DECODER_CNT_MONITOR1_LOW_REG  0x000000CC

#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG           0x000000E0
#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_DEFAULT_FREQ_REG      0x000000E4
#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_HIGH_REG        0x000000E8
#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_LOW_REG         0x000000EC
#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG1_HIGH_REG        0x000000F0
#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG1_LOW_REG         0x000000F4
#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG2_HIGH_REG        0x000000F8
#define FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG2_LOW_REG         0x000000FC


struct struct_fmc_imageon_vita_receiver_t
{
   // software library version
   Xuint32 uVersion;

   // instantiation-specific name
   char szName[32];

   // Base Address
   Xuint32 uBaseAddr;

   // Manual Tap
   Xuint32 uManualTap;

   // Gain/Exposure
   Xuint32 uAnalogGain;
   Xuint32 uDigitalGain;
   Xuint32 uExposureTime;
};
typedef struct struct_fmc_imageon_vita_receiver_t fmc_imageon_vita_receiver_t;


struct struct_fpn_prnu_value_t
{
   Xuint8 fpn;  // offset
   Xuint8 prnu; // gain (decimal part of 1.xxx)
};
typedef struct struct_fpn_prnu_value_t fpn_prnu_value_t;

struct struct_fmc_imageon_vita_status_t
{
   // Sync Channel Decoder status
   Xuint32 cntBlackLines;
   Xuint32 cntImageLines;
   Xuint32 cntBlackPixels;
   Xuint32 cntImagePixels;
   Xuint32 cntFrames;
   Xuint32 cntWindows;
   Xuint32 cntStartLines;
   Xuint32 cntEndLines;
   Xuint32 cntClocks;

   // CRC status
   Xuint32 crcStatus;

};
typedef struct struct_fmc_imageon_vita_status_t fmc_imageon_vita_status_t;

/******************************************************************************
* This function initializes the FMC-IMAGEON VITA Receiver.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    szName contains a string describing the new VITA instance.
* @param    uBaseAddr contains the base address of the VITA pcore.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_init( fmc_imageon_vita_receiver_t *pContext, char szName[], Xuint32 uBaseAddr );

/******************************************************************************
* This function performs an register read transaction.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    uOffset contains the register offset (in bytes)
*
* @return   32 bit register value.
*
* @note     None.
*
******************************************************************************/
Xuint32 fmc_imageon_vita_receiver_reg_read( fmc_imageon_vita_receiver_t *pContext, Xuint32 uRegOffset );

/******************************************************************************
* This function performs an register write transaction.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    uOffset contains the register offset (in bytes)
* @param    uData contains the 32 bit register value
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
void fmc_imageon_vita_receiver_reg_write( fmc_imageon_vita_receiver_t *pContext, Xuint32 uRegOffset, Xuint32 uData );

/******************************************************************************
* This function resets the VITA image sensor.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    uReset contains the value of the reset.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_reset( fmc_imageon_vita_receiver_t *pContext, Xuint32 uReset );

/******************************************************************************
* This function configures the SPI controller.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    uTiming contains the 16 bit value to adjust the SPI timing.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_spi_config( fmc_imageon_vita_receiver_t *pContext, Xuint16 uTiming );

/******************************************************************************
* This function performs an SPI read transaction.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    uAddr contains the 10 bit SPI address.
* @param    pData contains a pointer to the 16 SPI data value.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_spi_read( fmc_imageon_vita_receiver_t *pContext, Xuint16 uAddr, Xuint16 *pData );

/******************************************************************************
* This function performs an SPI write transaction.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    uAddr contains the 10 bit SPI address.
* @param    uData contains the 16 bit SPI data value.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_spi_write( fmc_imageon_vita_receiver_t *pContext, Xuint16 uAddr, Xuint16 uData );

/******************************************************************************
* This function performs an SPI nop transaction.
*
* @param    pContext contains a pointer to the new VITA instance's context.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_spi_nop( fmc_imageon_vita_receiver_t *pContext );

/******************************************************************************
* This function performs a sequence of SPI write transactions.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    pConfig contains a sequence of address/mask/value sets.
* @param    uLength contains the number of address/mask/value sets in sequence.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_spi_write_sequence( fmc_imageon_vita_receiver_t *pContext, Xuint16 pConfig[][3], Xuint32 uLength );

/******************************************************************************
* This function performs a sequence of SPI write transactions.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    pConfig contains a sequence of address/mask/value sets.
* @param    uLength contains the number of address/mask/value sets in sequence.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_spi_display_sequence( fmc_imageon_vita_receiver_t *pContext, Xuint16 pConfig[][3], Xuint32 uLength );


/******************************************************************************
* This function performs VITA initialization sequences.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    initId identifies which portion of the initialization is to be performed.
*              The initialization sequences correspond to the VITA datasheet
*
*              - SENSOR_INIT_SEQ00 => Assert/Deassert RESET_N pin
*              - SENSOR_INIT_SEQ01 => Enable Clock Management - Part 1
*              - SENSOR_INIT_SEQ02 => Verify PLL Lock Indicator
*              - SENSOR_INIT_SEQ03 => Enable Clock Management - Part 2
*              - SENSOR_INIT_SEQ04 => Required Register Upload
*              - SENSOR_INIT_SEQ05 => Soft Power-Up
*              - SENSOR_INIT_SEQ06 => Enable Sequencer
*
*              - SENSOR_INIT_SEQ07 => Disable Sequencer
*              - SENSOR_INIT_SEQ08 => Soft Power-Down
*              - SENSOR_INIT_SEQ09 => Disable Clock Management - Part 2
*              - SENSOR_INIT_SEQ10 => Disable Clock Management - Part 1
*
*              - SENSOR_INIT_ENABLE  => perform SEQ00 to SEQ06
*              - SENSOR_INIT_DISABLE => perform SEQ06 to SEQ10
*
* @param    bVerbose identified wether or not to display verbose information.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
#define SENSOR_INIT_SEQ00	  0
#define SENSOR_INIT_SEQ01	  1
#define SENSOR_INIT_SEQ02	  2
#define SENSOR_INIT_SEQ03	  3
#define SENSOR_INIT_SEQ04	  4
#define SENSOR_INIT_SEQ05	  5
#define SENSOR_INIT_SEQ06	  6
#define SENSOR_INIT_SEQ07	  7
#define SENSOR_INIT_SEQ08	  8
#define SENSOR_INIT_SEQ09	  9
#define SENSOR_INIT_SEQ10	 10
#define SENSOR_INIT_ENABLE  101 // Execute sequences 0,1,2,3,4,5,6
#define SENSOR_INIT_DISABLE 102 // Execute sequences 7, 8, 9, 10
int fmc_imageon_vita_receiver_sensor_initialize( fmc_imageon_vita_receiver_t *pContext, int initID, int bVerbose );

/******************************************************************************
* This function returns the status of the VITA receiver.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    pStatus contains a pointer to the VITA's status.
* @param    bVerbose identified wether or not to display verbose information.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_get_status( fmc_imageon_vita_receiver_t *pContext, fmc_imageon_vita_status_t *pStatus, int bVerbose );

/******************************************************************************
* This function configures the VITA-2000 to generate 1080P60 timing.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    bVerbose identified wether or not to display verbose information.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_sensor_1080P60( fmc_imageon_vita_receiver_t *pContext, int bVerbose );

/******************************************************************************
* This function configures the VITA-2000's analog gain.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    uAnalogGain contains the value of the analog gain.
*              00 => 1.00 : gain_state1=0x02(1.00), gain_stage2=0xF(1.00)
*              01 => 1.14 : gain_state1=0x02(1.00), gain_stage2=0x7(1.14)
*              02 => 1.33 : gain_state1=0x02(1.00), gain_stage2=0x3(1.33)
*              03 => 1.60 : gain_state1=0x02(1.00), gain_stage2=0x5(1.60)
*              04 => 2.00 : gain_state1=0x02(1.00), gain_stage2=0x1(2.00)
*              05 => 2.29 : gain_state1=0x01(2.00), gain_stage2=0x7(1.14)
*              06 => 2.67 : gain_state1=0x01(2.00), gain_stage2=0x3(1.33)
*              07 => 3.20 : gain_state1=0x01(2.00), gain_stage2=0x5(1.60)
*              08 => 4.00 : gain_state1=0x01(2.00), gain_stage2=0x1(2.00)
*              09 => 5.33 : gain_state1=0x01(2.00), gain_stage2=0x6(2.67)
*              10 => 8.00 : gain_state1=0x01(2.00), gain_stage2=0x2(4.00)
* @param    bVerbose identified wether or not to display verbose information.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_set_analog_gain( fmc_imageon_vita_receiver_t *pContext, Xuint32 uAnalogGain, int bVerbose );

/******************************************************************************
* This function configures the VITA-2000's digital gain.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    digitalGain contains the value of the digital gain.
* @param    bVerbose identified wether or not to display verbose information.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_set_digital_gain( fmc_imageon_vita_receiver_t *pContext, Xuint32 uDigitalGain, int bVerbose );

/******************************************************************************
* This function configures the VITA-2000's exposure time.
*
* @param    pContext contains a pointer to the new VITA instance's context.
* @param    analogGain contains the value of the exposure time (in usec)
* @param    bVerbose identified wether or not to display verbose information.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageon_vita_receiver_set_exposure_time( fmc_imageon_vita_receiver_t *pContext, Xuint32 exposureTime, int bVerbose );

#endif /** FMC_IMAGEON_VITA_RECEIVER_H */
