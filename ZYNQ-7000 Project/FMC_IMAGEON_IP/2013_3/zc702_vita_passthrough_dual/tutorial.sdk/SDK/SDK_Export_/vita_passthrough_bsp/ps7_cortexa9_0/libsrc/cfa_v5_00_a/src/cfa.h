//*******************************************************************
// (c) Copyright 2001-2011, Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*******************************************************************

/**
*
* @file cfa.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Xilinx Color Filter Array Interpolation 
* (CFA) core instance.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 5.00a se   12/01/11  Updated for CFA v5.0, replaced xio.h with xil_io.h
* 4.00a rc   09/11/11  Updated for CFA v4.0
* 3.00a gz   10/22/10  Updated for CFA V3.0
*
******************************************************************************/

#ifndef CFA_DRIVER_H        /* prevent circular inclusions */
#define CFA_DRIVER_H        /* by using protection macros */

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
#define CFA_CONTROL             0x000    /**< Control (R/W) */
#define CFA_STATUS              0x004    /**< Status (R/W) */
#define CFA_ERROR               0x008    /**< Error (R/W) */
#define CFA_IRQ_EN              0x00C    /**< IRQ Enable     */
#define CFA_VERSION             0x010    /**< Version        */
#define CFA_SYSDEBUG0           0x014    /**< System Debug 0 */
#define CFA_SYSDEBUG1           0x018    /**< System Debug 1 */
#define CFA_SYSDEBUG2           0x01C    /**< System Debug 2 */
/* Timing Control Registers */
#define CFA_ACTIVE_SIZE         0x020    /**< Active Size (V x H)       */
/* Core Specific Registers */
#define CFA_BAYER_PHASE         0x100    /**< bayer_phase R/W user register */


/**
 * CFA Control Register bit definition
 */
#define CFA_CTL_EN_MASK    0x00000001    /**< CFA Enable */
#define CFA_CTL_RUE_MASK   0x00000002    /**< CFA Register Update */
#define CFA_CTL_CS_MASK    0x00000004    /**< CFA Register Clear Status */
                                         
/**
 * CFA Reset Register bit definition     
 */                                      
#define CFA_RST_RESET      0x80000000    /**< Software Reset - Instantaneous */
#define CFA_RST_AUTORESET  0x40000000    /**< Software Reset - Auto-synchronize to SOF */

/***************** Macros (Inline Functions) Definitions *********************/
#define CFA_In32          Xil_In32
#define CFA_Out32         Xil_Out32


/**
*
* Read the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 CFA_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define CFA_ReadReg(BaseAddress, RegOffset) \
            CFA_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
* @param Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void CFA_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define CFA_WriteReg(BaseAddress, RegOffset, Data) \
            CFA_Out32((BaseAddress) + (RegOffset), (Data))

/*****************************************************************************/
/**
*
* This macro enables a CFA core instance.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CFA_Enable(u32 BaseAddress);
*
******************************************************************************/
#define CFA_Enable(BaseAddress) \
            CFA_WriteReg(BaseAddress, CFA_CONTROL, \
            	CFA_ReadReg(BaseAddress, CFA_CONTROL) | \
            	CFA_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro disables a CFA core instance.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CFA_Disable(u32 BaseAddress);
*
******************************************************************************/
#define CFA_Disable(BaseAddress) \
            CFA_WriteReg(BaseAddress, CFA_CONTROL, \
            	CFA_ReadReg(BaseAddress, CFA_CONTROL) & \
            	~CFA_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro commits all the register value changes made so far by the software 
* to the CFA core instance. The registers will be automatically updated
* on the next rising-edge of the VBlank_in signal on the core.
* It is up to the user to manually disable the register update after a sufficient
* amount if time.
*
* This function only works when the CFA core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CFA_RegUpdateEnable(u32 BaseAddress);
*
******************************************************************************/
#define CFA_RegUpdateEnable(BaseAddress) \
            CFA_WriteReg(BaseAddress, CFA_CONTROL, \
                CFA_ReadReg(BaseAddress, CFA_CONTROL) | \
                CFA_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro prevents the CFA core instance from committing recent changes made 
* so far by the software. When disabled, changes to other configuration registers
* are stored, but do not effect the behavior of the core. 
*
* This function only works when the CFA core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note 
* C-style signature:
*    void CFA_RegUpdateDisable(u32 BaseAddress);
*
******************************************************************************/
#define CFA_RegUpdateDisable(BaseAddress) \
            CFA_WriteReg(BaseAddress, CFA_CONTROL, \
                CFA_ReadReg(BaseAddress, CFA_CONTROL) & \
                ~CFA_CTL_RUE_MASK)

/*****************************************************************************/

/**
*
* This macro clears the status register of the CFA instance, by first asserting then
* deasserting the CLEAR_STATUS flag of CFA_CONTROL. 
* This function only works when the CFA core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note 
* C-style signature:
*    void CFA_ClearStatus(u32 BaseAddress);
*
******************************************************************************/
#define CFA_ClearStatus(BaseAddress) \
   CFA_WriteReg(BaseAddress, CFA_CONTROL, CFA_ReadReg(BaseAddress, CFA_CONTROL) |  CFA_CTL_CS_MASK); \
   CFA_WriteReg(BaseAddress, CFA_CONTROL, CFA_ReadReg(BaseAddress, CFA_CONTROL) & ~CFA_CTL_CS_MASK) 

/*****************************************************************************/


/**
*
* This macro resets a CFA core instance. This reset effects the core immediately,
* and may cause image tearing.
*
* This reset resets the CFA's configuration registers, and holds the core's outputs
* in their reset state until CFA_ClearReset() is called.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CFA_Reset(u32 BaseAddress);
*
******************************************************************************/
#define CFA_Reset(BaseAddress) \
            CFA_WriteReg(BaseAddress, CFA_CONTROL, CFA_RST_RESET) \

/*****************************************************************************/
/**
*
* This macro clears the CFA's reset flag (which is set using CFA_Reset(), and
* returns it to normal operation. This ClearReset effects the core immediately,
* and may cause image tearing.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CFA_ClearReset(u32 BaseAddress);
*
******************************************************************************/
#define CFA_ClearReset(BaseAddress) \
            CFA_WriteReg(BaseAddress, CFA_CONTROL, 0) \

/*****************************************************************************/
/**
*
* This macro resets a CFA instance, but differs from CFA_Reset() in that it
* automatically synchronizes to the SOF of the core to prevent tearing.
*
* On the next rising-edge of SOF following a call to CFA_AutoSyncReset(), 
* all of the core's configuration registers and outputs will be reset, then the
* reset flag will be immediately released, allowing the core to immediately resume
* default operation.
*
* @param BaseAddress is the Xilinx EDK base address of the CFA core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void CFA_FSyncReset(u32 BaseAddress);
*
******************************************************************************/
#define CFA_FSyncReset(BaseAddress) \
            CFA_WriteReg(BaseAddress, CFA_CONTROL, CFA_RST_AUTORESET) \

/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */ 
