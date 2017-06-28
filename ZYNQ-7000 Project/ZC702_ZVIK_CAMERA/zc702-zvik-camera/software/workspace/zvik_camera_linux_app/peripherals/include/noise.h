/********************************************************************
*   (c) Copyright 2011 Xilinx, Inc. All rights reserved.
*
*   This file contains confidential and proprietary information
*   of Xilinx, Inc. and is protected under U.S. and
*   international copyright and other intellectual property
*   laws.
*
*   DISCLAIMER
*   This disclaimer is not a license and does not grant any
*   rights to the materials distributed herewith. Except as
*   otherwise provided in a valid license issued to you by
*   Xilinx, and to the maximum extent permitted by applicable
*   law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
*   WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
*   AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
*   BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
*   INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
*   (2) Xilinx shall not be liable (whether in contract or tort,
*   including negligence, or under any other theory of
*   liability) for any loss or damage of any kind or nature
*   related to, arising under or in connection with these
*   materials, including for any direct, or any indirect,
*   special, incidental, or consequential loss or damage
*   (including loss of data, profits, goodwill, or any type of
*   loss or damage suffered as a result of any action brought
*   by a third party) even if such damage or loss was
*   reasonably foreseeable or Xilinx had been advised of the
*   possibility of the same.
*
*   CRITICAL APPLICATIONS
*   Xilinx products are not designed or intended to be fail-
*   safe, or for use in any application requiring fail-safe
*   performance, such as life-support or safety devices or
*   systems, Class III medical devices, nuclear facilities,
*   applications related to the deployment of airbags, or any
*   other applications that could lead to death, personal
*   injury, or severe property or environmental damage
*   (individually and collectively, "Critical
*   Applications"). Customer assumes the sole risk and
*   liability of any use of Xilinx products in Critical
*   Applications, subject only to applicable laws and
*   regulations governing limitations on product liability.
*
*   THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
*   PART OF THIS FILE AT ALL TIMES.
********************************************************************/

/**
*
* @file noise.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Xilinx Image Noise Reduction core instance.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 4.00a vc   04/24/12  Updated for NOISE V4.00.a
*                      Converted from xio.h to xil_io.h, translating
*                      basic type, MB cache functions, exceptions and
*                      assertion to xil_io format.
* 3.00a rc   09/11/11  Updated for NOISE V3.0
* 2.00a vc   12/14/10  Updated for NOISE V2.0
*
******************************************************************************/

#ifndef NOISE_DRIVER_H        /* prevent circular inclusions */
#define NOISE_DRIVER_H        /* by using protection macros */

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
#define NOISE_CONTROL        0x000    /**< Control        */
#define NOISE_STATUS         0x004    /**< Status         */
#define NOISE_ERROR          0x008    /**< Error          */
#define NOISE_IRQ_ENABLE     0x00C    /**< IRQ Enable     */
#define NOISE_VERSION        0x010    /**< Version        */
#define NOISE_SYSDEBUG0      0x014    /**< System Debug 0 */
#define NOISE_SYSDEBUG1      0x018    /**< System Debug 1 */
#define NOISE_SYSDEBUG2      0x01C    /**< System Debug 2 */
/* Timing Control Registers */
#define NOISE_ACTIVE_SIZE    0x020    /**< Horizontal and Vertical Active Frame Size */
/* Core Specific Registers */
#define NOISE_FILT_STRENGTH  0x100    /**< Smoothing Filter Strength */



/*****************************************************************************/
/**
 * Control Register bit definition
 */
#define NOISE_CTL_EN_MASK    0x00000001 /**< Enable */
#define NOISE_CTL_RU_MASK    0x00000002 /**< Register Update */
#define NOISE_CTL_AUTORESET  0x40000000 /**< Software Reset - Auto-synchronize to SOF */
#define NOISE_CTL_RESET      0x80000000 /**< Software Reset - Instantaneous */

/***************** Macros (Inline Functions) Definitions *********************/
#define NOISE_In32          Xil_In32
#define NOISE_Out32         Xil_Out32

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 NOISE_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define NOISE_ReadReg(BaseAddress, RegOffset) \
            NOISE_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
* @param Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void NOISE_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define NOISE_WriteReg(BaseAddress, RegOffset, Data) \
            NOISE_Out32((BaseAddress) + (RegOffset), (Data))

/*****************************************************************************/
/**
*
* This macro enables a Image Noise Reduction core instance.
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void NOISE_Enable(u32 BaseAddress);
*
******************************************************************************/
#define NOISE_Enable(BaseAddress) \
            NOISE_WriteReg(BaseAddress, NOISE_CONTROL, \
            	NOISE_ReadReg(BaseAddress, NOISE_CONTROL) | \
            	NOISE_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro disables a Image Noise Reduction core instance.
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void NOISE_Disable(u32 BaseAddress);
*
******************************************************************************/
#define NOISE_Disable(BaseAddress) \
            NOISE_WriteReg(BaseAddress, NOISE_CONTROL, \
            	NOISE_ReadReg(BaseAddress, NOISE_CONTROL) & \
            	~NOISE_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro commits all the register value changes made so far by the software 
* to the Image Noise Reduction core instance. The registers will be automatically updated
* on the next rising-edge of the SOF signal on the core.
* It is up to the user to manually disable the register update after a sufficient
* amount of time.
*
* This function only works when the Image Noise Reduction core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void NOISE_RegUpdateEnable(u32 BaseAddress);
*
******************************************************************************/
#define NOISE_RegUpdateEnable(BaseAddress) \
            NOISE_WriteReg(BaseAddress, NOISE_CONTROL, \
                NOISE_ReadReg(BaseAddress, NOISE_CONTROL) | \
                NOISE_CTL_RU_MASK)

/*****************************************************************************/
/**
*
* This macro prevents the Image Noise Reduction core instance from committing recent changes made 
* so far by the software. When disabled, changes to other configuration registers
* are stored, but do not effect the behavior of the core. 
*
* This function only works when the Image Noise Reduction core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
*
* @return None.
*
* @note 
* C-style signature:
*    void NOISE_RegUpdateDisable(u32 BaseAddress);
*
******************************************************************************/
#define NOISE_RegUpdateDisable(BaseAddress) \
            NOISE_WriteReg(BaseAddress, NOISE_CONTROL, \
                NOISE_ReadReg(BaseAddress, NOISE_CONTROL) & \
                ~NOISE_CTL_RU_MASK)

/*****************************************************************************/

/**
*
* This macro resets a Image Noise Reduction core instance. This reset effects the core immediately,
* and may cause image tearing.
*
* This reset resets the Image Noise Reduction's configuration registers, and holds the core's outputs
* in their reset state until NOISE_ClearReset() is called.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void NOISE_Reset(u32 BaseAddress);
*
******************************************************************************/
#define NOISE_Reset(BaseAddress) \
            NOISE_WriteReg(BaseAddress, NOISE_CONTROL, NOISE_CTL_RESET) \

/*****************************************************************************/
/**
*
* This macro clears the Image Noise Reduction's reset flag (which is set using NOISE_Reset(), and
* returns it to normal operation. This ClearReset effects the core immediately,
* and may cause image tearing.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void NOISE_ClearReset(u32 BaseAddress);
*
******************************************************************************/
#define NOISE_ClearReset(BaseAddress) \
            NOISE_WriteReg(BaseAddress, NOISE_CONTROL, 0) \

/*****************************************************************************/
/**
*
* This macro resets a Image Noise Reduction core instance, but differs from NOISE_Reset() in that it
* automatically synchronizes to the SOF input of the core to prevent tearing.
*
* On the next SOF following a call to NOISE_AutoSyncReset(), 
* all of the core's configuration registers and outputs will be reset, then the
* reset flag will be immediately released, allowing the core to immediately resume
* default operation.
*
* @param BaseAddress is the Xilinx EDK base address of the Image Noise Reduction core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void NOISE_AutoSyncReset(u32 BaseAddress);
*
******************************************************************************/
#define NOISE_AutoSyncReset(BaseAddress) \
            NOISE_WriteReg(BaseAddress, NOISE_CONTROL, NOISE_CTL_AUTORESET) \


/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */ 
