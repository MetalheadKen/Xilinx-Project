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
* @file dpc.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Xilinx Defective Pixel Correction (DPC) instance.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 5.00a se   12/01/11  Updated for DPC v5.0, replaced xio.h with xil_io.h
* 4.00a rc   9/11/11   Updated for DPC V4.0
* 3.00a vc   3/11/11   Updated for DPC V3.0
*
******************************************************************************/

#ifndef DPC_DRIVER_H        /* prevent circular inclusions */
#define DPC_DRIVER_H        /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xil_io.h"

/************************** Constant Definitions *****************************/

/**
 * Register Offsets
 */
#define DPC_CONTROL             0x000    /**< Control register */
#define DPC_STATUS              0x004    /**< Status register */
#define DPC_ERROR               0x008    /**< Error (R/W) */
#define DPC_IRQ_EN              0x00C    /**< IRQ Enable     */
#define DPC_VERSION             0x010    /**< Version        */
#define DPC_SYSDEBUG0           0x014    /**< System Debug 0 */
#define DPC_SYSDEBUG1           0x018    /**< System Debug 1 */
#define DPC_SYSDEBUG2           0x01C    /**< System Debug 2 */
/* Timing Control Registers */
#define DPC_ACTIVE_SIZE         0x020    /**< Active Size (V x H)       */
/* Core Specific Registers */
#define DPC_THRESH_TEMPORAL_VAR 0x100    /**< Allowed inter-frame variance of defective pixels */
#define DPC_THRESH_SPATIAL_VAR  0x104    /**< Allowed spatial variance beyond which a pixel is characterized as an outlier */
#define DPC_THRESH_PIXEL_AGE    0x108    /**< Number of frames an outlier pixel has to keep its value within the range specified */
#define DPC_NUM_CANDIDATES      0x10C    /**< Total number of potential defective pixel candidates stored in FIFO (in previous frame) */
#define DPC_NUM_DEFECTIVE       0x110    /**< Total number of pixels being actively interpolated (in previous frame) */

/**
 * DPC Control Register bit definition
 */
#define DPC_CTL_EN_MASK     0x00000001   /**< DPC Enable */
#define DPC_CTL_RUE_MASK    0x00000002   /**< DPC Register Update Enable */
#define DPC_CTL_CS_MASK     0x00000004   /**< DPC Register Clear Status */

/**
 * DPC Reset Register bit definition
 */
#define DPC_RST_RESET      0x80000000    /**< Software Reset - Instantaneous */
#define DPC_RST_AUTORESET  0x40000000    /**< Software Reset - Auto-synchronize to SOF */


/***************** Macros (Inline Functions) Definitions *********************/

#define DPC_In32          Xil_In32
#define DPC_Out32         Xil_Out32


/*****************************************************************************/
/**
*
* This macro enables an DPC instance.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void DPC_Enable(u32 BaseAddress);
*
******************************************************************************/
#define DPC_Enable(BaseAddress) \
            DPC_WriteReg(BaseAddress, DPC_CONTROL, \
            DPC_ReadReg(BaseAddress, DPC_CONTROL) | \
            DPC_CTL_EN_MASK)

/*****************************************************************************/

/**
*
* This macro disables an DPC instance.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void DPC_Disable(u32 BaseAddress);
*
******************************************************************************/
#define DPC_Disable(BaseAddress) \
            DPC_WriteReg(BaseAddress, DPC_CONTROL, \
            DPC_ReadReg(BaseAddress,  DPC_CONTROL) & \
            ~DPC_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro tells an DPC instance to pick up all the register value changes
* made so far by the software. The registers will be automatically updated
* on the next rising-edge of the VBlank_in signal on the core.
* It is up to the user to manually disable the register update after a sufficient
* amount if time.
*
* This function only works when the DPC core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void DPC_RegUpdateEnable(u32 BaseAddress);
*
******************************************************************************/
#define DPC_RegUpdateEnable(BaseAddress) \
            DPC_WriteReg(BaseAddress, DPC_CONTROL, \
                DPC_ReadReg(BaseAddress, DPC_CONTROL) | \
                DPC_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro tells an DPC instance not to update it's configuration registers made
* so far by the software. When disabled, changes to other configuration registers
* are stored, but do not effect the core's behavior. 
*
* This function only works when the DPC core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void DPC_RegUpdateDisable(u32 BaseAddress);
*
******************************************************************************/
#define DPC_RegUpdateDisable(BaseAddress) \
            DPC_WriteReg(BaseAddress, DPC_CONTROL, \
                DPC_ReadReg(BaseAddress, DPC_CONTROL) & \
                ~DPC_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro resets an DPC instance. This reset effects the core immediately,
* and may cause image tearing.
*
* This reset resets the DPC's configuration registers, and holds the core's outputs
* in their reset state until DPC_ClearReset() is called.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void DPC_Reset(u32 BaseAddress);
*
******************************************************************************/
#define DPC_Reset(BaseAddress) \
            DPC_WriteReg(BaseAddress, DPC_CONTROL, DPC_RST_RESET) \

/*****************************************************************************/
/**
*
* This macro clears the DPC's reset flag (which is set using DPC_Reset(), and
* returns it to normal operation. This ClearReset effects the core immediately,
* and may cause image tearing.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void DPC_ClearReset(u32 BaseAddress);
*
******************************************************************************/
#define DPC_ClearReset(BaseAddress) \
            DPC_WriteReg(BaseAddress, DPC_CONTROL, 0) \

/*****************************************************************************/
/**
*
* This macro resets a DPC instance, but differs from DPC_Reset() in that it
* automatically synchronizes to the SOF of the core to prevent tearing.
*
* On the next rising-edge of SOF following a call to DPC_AutoSyncReset(), 
* all of the core's configuration registers and outputs will be reset, then the
* reset flag will be immediately released, allowing the core to immediately resume
* default operation.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void DPC_AutoSyncReset(u32 BaseAddress);
*
******************************************************************************/
#define DPC_FSyncReset(BaseAddress) \
            DPC_WriteReg(BaseAddress, DPC_CONTROL, DPC_RST_AUTORESET) \

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 DPC_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define DPC_ReadReg(BaseAddress, RegOffset) \
            DPC_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
* @param Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void DPC_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define DPC_WriteReg(BaseAddress, RegOffset, Data) \
            DPC_Out32((BaseAddress) + (RegOffset), (Data))


            /*****************************************************************************/

/**
*
* This macro clears the status register of the DPC instance, by first asserting then
* deasserting the CLEAR_STATUS flag of DPC_CONTROL. 
* This function only works when the DPC core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the DPC core (from xparameters.h)
*
* @return None.
*
* @note 
* C-style signature:
*    void DPC_ClearStatus(u32 BaseAddress);
*
******************************************************************************/
#define DPC_ClearStatus(BaseAddress) \
   DPC_WriteReg(BaseAddress, DPC_CONTROL, DPC_ReadReg(BaseAddress, DPC_CONTROL) |  DPC_CTL_CS_MASK); \
   DPC_WriteReg(BaseAddress, DPC_CONTROL, DPC_ReadReg(BaseAddress, DPC_CONTROL) & ~DPC_CTL_CS_MASK) 


/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
