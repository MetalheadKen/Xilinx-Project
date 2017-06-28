//*******************************************************************
//  (c) Copyright 2009-2013 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES. 
//*******************************************************************

/**
*
* @file enhance.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Xilinx Image Enhancement core instance.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 5.00a vyc  06/19/13  Updated for ENHANCE V8.0
*                      New edge enhancement algorithm and registers
*                      Noise reduction support added
* 4.00a vyc  04/24/12  Updated for ENHANCE V4.00.a
*                      Converted from xio.h to xil_io.h, translating
*                      basic type, MB cache functions, exceptions and
*                      assertion to xil_io format.
* 3.00a rc   09/11/11  Updated for ENHANCE V3.0
* 2.00a vc   12/14/10  Updated for ENHANCE V2.0
*
******************************************************************************/

#ifndef ENHANCE_DRIVER_H        /* prevent circular inclusions */
#define ENHANCE_DRIVER_H        /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xil_io.h"

/************************** Constant Definitions *****************************/

/**
 * Register Offsets
 */
/* General Control Registers */
#define ENHANCE_CONTROL          0x0000    /**< Control        */
#define ENHANCE_STATUS           0x0004    /**< Status         */
#define ENHANCE_ERROR            0x0008    /**< Error          */
#define ENHANCE_IRQ_ENABLE       0x000C    /**< IRQ Enable     */
#define ENHANCE_VERSION          0x0010    /**< Version        */
#define ENHANCE_SYSDEBUG0        0x0014    /**< System Debug 0 */
#define ENHANCE_SYSDEBUG1        0x0018    /**< System Debug 1 */
#define ENHANCE_SYSDEBUG2        0x001C    /**< System Debug 2 */
/* Timing Control Registers */
#define ENHANCE_ACTIVE_SIZE      0x0020    /**< Horizontal and Vertical Active Frame Size */
/* Core Specific Registers */
#define ENHANCE_NOISE_THRESHOLD  0x0100    /**< Noise Reduction Control */
#define ENHANCE_ENHANCE_STRENGTH 0x0104    /**< Edge Enhancement Control */
#define ENHANCE_HALO_SUPRESS     0x0108    /**< Halo Control */


/*****************************************************************************/
/**
 * Control Register bit definition
 */
#define ENHANCE_CTL_EN_MASK    0x00000001 /**< Enable */
#define ENHANCE_CTL_RU_MASK    0x00000002 /**< Register Update */
#define ENHANCE_CTL_AUTORESET  0x40000000 /**< Software Reset - Auto-synchronize to SOF */
#define ENHANCE_CTL_RESET      0x80000000 /**< Software Reset - Instantaneous */

/***************** Macros (Inline Functions) Definitions *********************/
#define ENHANCE_In32          Xil_In32
#define ENHANCE_Out32         Xil_Out32

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 ENHANCE_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define ENHANCE_ReadReg(BaseAddress, RegOffset) \
            ENHANCE_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
* @param Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void ENHANCE_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define ENHANCE_WriteReg(BaseAddress, RegOffset, Data) \
            ENHANCE_Out32((BaseAddress) + (RegOffset), (Data))

/*****************************************************************************/
/**
*
* This macro enables a Image Enhancement core instance.
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void ENHANCE_Enable(u32 BaseAddress);
*
******************************************************************************/
#define ENHANCE_Enable(BaseAddress) \
            ENHANCE_WriteReg(BaseAddress, ENHANCE_CONTROL, \
            	ENHANCE_ReadReg(BaseAddress, ENHANCE_CONTROL) | \
            	ENHANCE_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro disables a Image Enhancement core instance.
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void ENHANCE_Disable(u32 BaseAddress);
*
******************************************************************************/
#define ENHANCE_Disable(BaseAddress) \
            ENHANCE_WriteReg(BaseAddress, ENHANCE_CONTROL, \
            	ENHANCE_ReadReg(BaseAddress, ENHANCE_CONTROL) & \
            	~ENHANCE_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro commits all the register value changes made so far by the software 
* to the Image Enhancement core instance. The registers will be automatically updated
* on the next rising-edge of the SOF signal on the core.
* It is up to the user to manually disable the register update after a sufficient
* amount of time.
*
* This function only works when the Image Enhancement core is enabled.
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void ENHANCE_RegUpdateEnable(u32 BaseAddress);
*
******************************************************************************/
#define ENHANCE_RegUpdateEnable(BaseAddress) \
            ENHANCE_WriteReg(BaseAddress, ENHANCE_CONTROL, \
                ENHANCE_ReadReg(BaseAddress, ENHANCE_CONTROL) | \
                ENHANCE_CTL_RU_MASK)

/*****************************************************************************/
/**
*
* This macro prevents the Image Enhancement core instance from committing recent changes made 
* so far by the software. When disabled, changes to other configuration registers
* are stored, but do not effect the behavior of the core. 
*
* This function only works when the Image Enhancement core is enabled.
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
*
* @return None.
*
* @note 
* C-style signature:
*    void ENHANCE_RegUpdateDisable(u32 BaseAddress);
*
******************************************************************************/
#define ENHANCE_RegUpdateDisable(BaseAddress) \
            ENHANCE_WriteReg(BaseAddress, ENHANCE_CONTROL, \
                ENHANCE_ReadReg(BaseAddress, ENHANCE_CONTROL) & \
                ~ENHANCE_CTL_RU_MASK)

/*****************************************************************************/

/**
*
* This macro resets a Image Enhancement core instance. This reset effects the core immediately,
* and may cause image tearing.
*
* This reset resets the Image Enhancement's configuration registers, and holds the core's outputs
* in their reset state until ENHANCE_ClearReset() is called.
* 
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void ENHANCE_Reset(u32 BaseAddress);
*
******************************************************************************/
#define ENHANCE_Reset(BaseAddress) \
            ENHANCE_WriteReg(BaseAddress, ENHANCE_CONTROL, ENHANCE_CTL_RESET) \

/*****************************************************************************/
/**
*
* This macro clears the Image Enhancement's reset flag (which is set using ENHANCE_Reset(), and
* returns it to normal operation. This ClearReset effects the core immediately,
* and may cause image tearing.
* 
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void ENHANCE_ClearReset(u32 BaseAddress);
*
******************************************************************************/
#define ENHANCE_ClearReset(BaseAddress) \
            ENHANCE_WriteReg(BaseAddress, ENHANCE_CONTROL, 0) \

/*****************************************************************************/
/**
*
* This macro resets a Image Enhancement core instance, but differs from ENHANCE_Reset() in that it
* automatically synchronizes to the SOF input of the core to prevent tearing.
*
* On the next SOF following a call to ENHANCE_AutoSyncReset(), 
* all of the core's configuration registers and outputs will be reset, then the
* reset flag will be immediately released, allowing the core to immediately resume
* default operation.
*
* @param BaseAddress is the Xilinx base address of the Image Enhancement core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void ENHANCE_AutoSyncReset(u32 BaseAddress);
*
******************************************************************************/
#define ENHANCE_AutoSyncReset(BaseAddress) \
            ENHANCE_WriteReg(BaseAddress, ENHANCE_CONTROL, ENHANCE_CTL_AUTORESET) \


/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */ 
