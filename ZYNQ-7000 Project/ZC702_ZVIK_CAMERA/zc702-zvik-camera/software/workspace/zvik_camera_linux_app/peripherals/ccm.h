/******************************************************************************
* (c) Copyright 2011 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information
* of Xilinx, Inc. and is protected under U.S. and
* international copyright and other intellectual property
* laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any
* rights to the materials distributed herewith. Except as
* otherwise provided in a valid license issued to you by
* Xilinx, and to the maximum extent permitted by applicable
* law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
* WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
* AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
* BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
* INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
* (2) Xilinx shall not be liable (whether in contract or tort,
* including negligence, or under any other theory of
* liability) for any loss or damage of any kind or nature
* related to, arising under or in connection with these
* materials, including for any direct, or any indirect,
* special, incidental, or consequential loss or damage
* (including loss of data, profits, goodwill, or any type of
* loss or damage suffered as a result of any action brought
* by a third party) even if such damage or loss was
* reasonably foreseeable or Xilinx had been advised of the
* possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-
* safe, or for use in any application requiring fail-safe
* performance, such as life-support or safety devices or
* systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any
* other applications that could lead to death, personal
* injury, or severe property or environmental damage
* (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and
* liability of any use of Xilinx products in Critical
* Applications, subject only to applicable laws and
* regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
* PART OF THIS FILE AT ALL TIMES.
******************************************************************************/


/*****************************************************************************/
/**
*
* @file ccm.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Xilinx Color Correction Matrix(CCM) device.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 2.00a jo   05/1/10  Updated for CCM V2.0
* 3.00a ren  09/11/11 Updated for CCM V3.0
* 4.00a jj   12/18/12 Converted from xio.h to xil_io.h,translating   
*		      basic types,MB cache functions, exceptions 
*		      and assertions to xil_io format 
******************************************************************************/

#ifndef CCM_DRIVER_H        /* prevent circular inclusions */
#define CCM_DRIVER_H        /* by using protection macros */

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
#define CCM_CONTROL        0x000    /**< Control        */
#define CCM_STATUS         0x004    /**< Status         */
#define CCM_ERROR          0x008    /**< Error          */
#define CCM_IRQ_EN         0x00C    /**< IRQ Enable     */
#define CCM_VERSION        0x010    /**< Version        */
#define CCM_SYSDEBUG0      0x014    /**< System Debug 0 */
#define CCM_SYSDEBUG1      0x018    /**< System Debug 1 */
#define CCM_SYSDEBUG2      0x01C    /**< System Debug 2 */
/* Timing Control Registers */
#define CCM_ACTIVE_SIZE    0x020    /**< Active Size (V x H)       */
#define CCM_TIMING_STATUS  0x024    /**< Timing Measurement Status */
/* Core Specific Registers */
#define CCM_K11            0x100    /**< K11 Coefficient */
#define CCM_K12            0x104    /**< K12 Coefficient */
#define CCM_K13            0x108    /**< K13 Coefficient */
#define CCM_K21            0x10C    /**< K21 Coefficient */
#define CCM_K22            0x110    /**< K22 Coefficient */
#define CCM_K23            0x114    /**< K23 Coefficient */
#define CCM_K31            0x118    /**< K31 Coefficient */
#define CCM_K32            0x11C    /**< K32 Coefficient */
#define CCM_K33            0x120    /**< K33 Coefficient */
#define CCM_ROFFSET        0x124    /**< Red Offset      */
#define CCM_GOFFSET        0x128    /**< Green Offset    */
#define CCM_BOFFSET        0x12C    /**< Blue Offset     */
#define CCM_CLIP           0x130    /**< Clip (Max)      */
#define CCM_CLAMP          0x134    /**< Clamp (Min)     */

/*
 * CCM Control Register bit definition
 */
#define CCM_CTL_EN_MASK     0x00000001 /**< CCM Enable */
#define CCM_CTL_RUE_MASK    0x00000002 /**< CCM Register Update Enable */

/*
 * CCM Reset Register bit definition
 */
#define CCM_RST_RESET      0x80000000 /**< Software Reset - Instantaneous */
#define CCM_RST_AUTORESET  0x40000000 /**< Software Reset - Auto-synchronize to SOF */


/***************** Macros (Inline Functions) Definitions *********************/

#define CCM_In32          Xil_In32
#define CCM_Out32         Xil_Out32


/*****************************************************************************/
/**
*
* This macro enables a CCM device.
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CCM_Enable(u32 BaseAddress);
*
******************************************************************************/
#define CCM_Enable(BaseAddress) \
            CCM_WriteReg(BaseAddress, CCM_CONTROL, \
            	CCM_ReadReg(BaseAddress, CCM_CONTROL) | \
            	CCM_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro disables a CCM device.
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CCM_Disable(u32 BaseAddress);
*
******************************************************************************/
#define CCM_Disable(BaseAddress) \
            CCM_WriteReg(BaseAddress, CCM_CONTROL, \
            	CCM_ReadReg(BaseAddress, CCM_CONTROL) & \
            	~CCM_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro tells a CCM device to pick up all the register value changes
* made so far by the software. The registers will be automatically updated
* on the next rising-edge of the VBlank_in signal on the core.
* It is up to the user to manually disable the register update after a sufficient
* amount if time.
*
* This function only works when the CCM core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CCM_RegUpdateEnable(u32 BaseAddress);
*
******************************************************************************/
#define CCM_RegUpdateEnable(BaseAddress) \
            CCM_WriteReg(BaseAddress, CCM_CONTROL, \
                CCM_ReadReg(BaseAddress, CCM_CONTROL) | \
                CCM_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro tells a CCM device not to update it's configuration registers made
* so far by the software. When disabled, changes to other configuration registers
* are stored, but do not effect the core's behavior. 
*
* This function only works when the CCM core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CCM_RegUpdateDisable(u32 BaseAddress);
*
******************************************************************************/
#define CCM_RegUpdateDisable(BaseAddress) \
            CCM_WriteReg(BaseAddress, CCM_CONTROL, \
                CCM_ReadReg(BaseAddress, CCM_CONTROL) & \
                ~CCM_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro resets a CCM device. This reset effects the core immediately,
* and may cause image tearing.
*
* This reset resets the CCM's configuration registers, and holds the core's outputs
* in their reset state until CCM_ClearReset() is called.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CCM_Reset(u32 BaseAddress);
*
******************************************************************************/
#define CCM_Reset(BaseAddress) \
            CCM_WriteReg(BaseAddress, CCM_CONTROL, CCM_RST_RESET) \

/*****************************************************************************/
/**
*
* This macro clears the CCM's reset flag (which is set using CCM_Reset(), and
* returns it to normal operation. This ClearReset effects the core immediately,
* and may cause image tearing.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CCM_ClearReset(u32 BaseAddress);
*
******************************************************************************/
#define CCM_ClearReset(BaseAddress) \
            CCM_WriteReg(BaseAddress, CCM_CONTROL, 0) \


/*****************************************************************************/
/**
*
* This macro resets a CCM device, but differs from CCM_Reset() in that it
* automatically synchronizes to the VBlank_in input of the core to prevent tearing.
*
* On the next rising-edge of VBlank_in following a call to CCM_AutoSyncReset(), 
* all of the core's configuration registers and outputs will be reset, then the
* reset flag will be immediately released, allowing the core to immediately resume
* default operation.
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CCM_Reset(u32 BaseAddress);
*
******************************************************************************/
#define CCM_AutoSyncReset(BaseAddress) \
            CCM_WriteReg(BaseAddress, CCM_CONTROL, CCM_RST_AUTORESET) \

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 CCM_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define CCM_ReadReg(BaseAddress, RegOffset) \
            CCM_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the CCM core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
* @param Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void CCM_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define CCM_WriteReg(BaseAddress, RegOffset, Data) \
            CCM_Out32((BaseAddress) + (RegOffset), (Data))

/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
