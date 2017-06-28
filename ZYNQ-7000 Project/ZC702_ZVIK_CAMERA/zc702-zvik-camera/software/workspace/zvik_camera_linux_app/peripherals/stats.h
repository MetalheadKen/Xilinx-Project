//*******************************************************************
// (c) Copyright 2009-2011, Xilinx, Inc. All rights reserved.
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
* @file stats.h
*
* This header file contains identifiers and register-level driver functions (or
* macros) that can be used to access the Xilinx Color Filter Array Interpolation 
* (STATS) core instance.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 4.00a se   12/01/11  Updated for STATS v4_00_a, replaced xio.h with xil_io.h
* 3.00a gz   10/22/10  Updated for STATS V3.0
*
******************************************************************************/

#ifndef STATS_DRIVER_H        /* prevent circular inclusions */
#define STATS_DRIVER_H        /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xil_io.h"

/************************** Constant Definitions *****************************/

/**
 * Register Offsets
 */
#define STATS_CONTROL           0x000    /**< Control register */
#define STATS_STATUS            0x004    /**< Status register */
#define STATS_ERROR             0x008    /**< Error (R/W) */
#define STATS_IRQ_EN            0x00C    /**< IRQ Enable     */
#define STATS_VERSION           0x010    /**< Version        */
#define STATS_SYSDEBUG0         0x014    /**< System Debug 0 */
#define STATS_SYSDEBUG1         0x018    /**< System Debug 1 */
#define STATS_SYSDEBUG2         0x01C    /**< System Debug 2 */
/* Timing Control Registers */
#define STATS_ACTIVE_SIZE       0x020    /**< Active Size (V x H)       */
/* Core Specific Registers */
#define STATS_HMAX0             0x100    /**< First Horizontal Zone Separator Value  */
#define STATS_HMAX1             0x104    /**< Second Horizontal Zone Separator Value */
#define STATS_HMAX2             0x108    /**< Third Horizontal Zone Separator Value  */
#define STATS_VMAX0             0x10C    /**< First Vertical Zone Separator Value    */
#define STATS_VMAX1             0x110    /**< Second Vertical Zone Separator Value   */
#define STATS_VMAX2             0x114    /**< Third Vertical Zone Separator Value    */
#define STATS_HIST_ZOOM_FACTOR  0x118    /**< 2 Dimensional Chrominance (Cr-Cb) Histogram Zoom Factor (0 to 3) */
#define STATS_RGB_HIST_ZONE_EN  0x11C    /**< RGB Histogram Zone Enable. Bits 0-15 correspond to zones 0-15.   */
#define STATS_YCC_HIST_ZONE_EN  0x120    /**< Y and CC Histogram Zone Enable. Bits 0-15 correspond to zones 0-15.   */
#define STATS_ZONE_ADDR         0x124    /**< Zone addresses for reading out out max,min,sum,pow,freq and edge content data (0 to 15)  */
#define STATS_COLOR_ADDR        0x128    /**< Color channel addresses for reading out max,min,sum,pow data (0 to 2)   */
#define STATS_HIST_ADDR         0x12C    /**< Histogram addresses for reading out histogram data (0 to 2^DATA_WIDTH-1)   */
#define STATS_ADDR_VALID        0x130    /**< 1 bit handshaking signal marking valid addresses   */
#define STATS_MAX               0x134   /**< Measured maximum value for currently addressed zone and color */
#define STATS_MIN               0x138   /**< Measured minimum value for currently addressed zone and color   */
#define STATS_SUM_LO            0x13C   /**< Lower  DWORD of measured sum of values for currently addressed zone and color   */
#define STATS_SUM_HI            0x140   /**< Higher DWORD of measured sum of values for currently addressed zone and color   */
#define STATS_POW_LO            0x144   /**< Lower  DWORD of measured summed square of values for currently addressed zone and color    */
#define STATS_POW_HI            0x148   /**< Higher DWORD of measured summed square of values for currently addressed zone and color    */
#define STATS_HSOBEL_LO         0x14C   /**< Lower  DWORD of measured Horizontal Sobel filtered luminance values for currently addressed zone and color    */ 
#define STATS_HSOBEL_HI         0x150   /**< Higher DWORD of measured Horizontal Sobel filtered luminance values for currently addressed zone and color    */ 
#define STATS_VSOBEL_LO         0x154   /**< Lower  DWORD of measured Vertical Sobel filtered luminance values for currently addressed zone and color    */  
#define STATS_VSOBEL_HI         0x158   /**< Higher DWORD of measured Vertical Sobel filtered luminance values for currently addressed zone and color    */ 
#define STATS_LSOBEL_LO         0x15C   /**< Lower  DWORD of measured Left Diagonal Sobel filtered luminance values for currently addressed zone and color    */ 
#define STATS_LSOBEL_HI         0x160   /**< Higher DWORD of measured Left Diagonal Sobel filtered luminance values for currently addressed zone and color    */ 
#define STATS_RSOBEL_LO         0x164   /**< Lower  DWORD of measured Right Diagonal Sobel filtered luminance values for currently addressed zone and color    */ 
#define STATS_RSOBEL_HI         0x168   /**< Higher DWORD of measured Right Diagonal Sobel filtered luminance values for currently addressed zone and color    */ 
#define STATS_HIFREQ_LO         0x16C   /**< Lower  DWORD of measured High Frequency content of luminance values for currently addressed zone and color    */ 
#define STATS_HIFREQ_HI         0x170   /**< Higher DWORD of measured High Frequency content of luminance values for currently addressed zone and color    */ 
#define STATS_LOFREQ_LO         0x174   /**< Lower  DWORD of measured Low Frequency content of luminance values for currently addressed zone and color    */ 
#define STATS_LOFREQ_HI         0x178   /**< Higher DWORD of measured Low Frequency content of luminance values for currently addressed zone and color    */ 
#define STATS_RHIST             0x17C   /**< Red histogram value corresponding to bin HIST_ADDR collected in zones enabled by RGB_HIST_EN   */ 
#define STATS_GHIST             0x180   /**< Green histogram value corresponding to bin HIST_ADDR collected in zones enabled by RGB_HIST_EN   */ 
#define STATS_BHIST             0x184   /**< Blue histogram value corresponding to bin HIST_ADDR collected in zones enabled by RGB_HIST_EN   */ 
#define STATS_YHIST             0x188   /**< Luminance histogram value corresponding to bin HIST_ADDR collected in zones enabled by RGB_HIST_EN   */ 
#define STATS_CCHIST            0x18C   /**< 2D Chrominance histogram value corresponding to bin HIST_ADDR collected in zones enabled by RGB_HIST_EN   */ 
#define STATS_DATA_VALID        0x190   /**< 1 bit handshaking signal qualifying measurement data (corresponding to addresses) as valid */

/**
 * STATS Control Register bit definition
 */
#define STATS_CTL_EN_MASK    0x00000001 /**< STATS Enable */
#define STATS_CTL_RUE_MASK   0x00000002 /**< STATS Register Update Enable */
#define STATS_CTL_CS_MASK    0x00000004 /**< STATS Clear Status */
#define STATS_CTL_RO_MASK    0x00000040 /**< STATS Readout */

/**
 * STATS Reset Register bit definition
 */
#define STATS_RST_RESET      0x80000000 /**< Software Reset - Instantaneous */
#define STATS_RST_AUTORESET  0x40000000 /**< Software Reset - Auto-synchronize to SOF */

/***************** Macros (Inline Functions) Definitions *********************/
#define STATS_In32          Xil_In32
#define STATS_Out32         Xil_Out32


/**
*
* Read the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 STATS_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define STATS_ReadReg(BaseAddress, RegOffset) \
            STATS_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
* @param Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void STATS_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define STATS_WriteReg(BaseAddress, RegOffset, Data) \
            STATS_Out32((BaseAddress) + (RegOffset), (Data))

/*****************************************************************************/
/**
*
* This macro enables a STATS core instance.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void STATS_Enable(u32 BaseAddress);
*
******************************************************************************/
#define STATS_Enable(BaseAddress) \
            STATS_WriteReg(BaseAddress, STATS_CONTROL, \
            	STATS_ReadReg(BaseAddress, STATS_CONTROL) | \
            	STATS_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro disables a STATS core instance.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void STATS_Disable(u32 BaseAddress);
*
******************************************************************************/
#define STATS_Disable(BaseAddress) \
            STATS_WriteReg(BaseAddress, STATS_CONTROL, \
            	STATS_ReadReg(BaseAddress, STATS_CONTROL) & \
            	~STATS_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro commits all the register value changes made so far by the software 
* to the STATS core instance. The registers will be automatically updated
* on the next rising-edge of the VBlank_in signal on the core.
* It is up to the user to manually disable the register update after a sufficient
* amount if time.
*
* This function only works when the STATS core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void STATS_RegUpdateEnable(u32 BaseAddress);
*
******************************************************************************/
#define STATS_RegUpdateEnable(BaseAddress) \
            STATS_WriteReg(BaseAddress, STATS_CONTROL, \
                STATS_ReadReg(BaseAddress, STATS_CONTROL) | \
                STATS_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro prevents the STATS core instance from committing recent changes made 
* so far by the software. When disabled, changes to other configuration registers
* are stored, but do not effect the behavior of the core. 
*
* This function only works when the STATS core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note 
* C-style signature:
*    void STATS_RegUpdateDisable(u32 BaseAddress);
*
******************************************************************************/
#define STATS_RegUpdateDisable(BaseAddress) \
            STATS_WriteReg(BaseAddress, STATS_CONTROL, \
                STATS_ReadReg(BaseAddress, STATS_CONTROL) & \
                ~STATS_CTL_RUE_MASK)

/*****************************************************************************/

/**
*
* This macro clears the status register of the STATS instance, by first asserting then
* deasserting the CLR_STATUS flag of STATS_CONTROL. This function only works when the 
* STATS core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note 
* C-style signature:
*    void STATS_ClearStatus(u32 BaseAddress);
*
******************************************************************************/
#define STATS_ClearStatus(BaseAddress) \
   STATS_WriteReg(BaseAddress, STATS_CONTROL, STATS_ReadReg(BaseAddress, STATS_CONTROL) |  STATS_CTL_CS_MASK); \
   STATS_WriteReg(BaseAddress, STATS_CONTROL, STATS_ReadReg(BaseAddress, STATS_CONTROL) & ~STATS_CTL_CS_MASK) 

/*****************************************************************************/


/**
*
* This macro resets a STATS core instance. This reset effects the core immediately,
* and may cause image tearing.
*
* This reset resets the STATS's configuration registers, and holds the core's outputs
* in their reset state until STATS_ClearReset() is called.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void STATS_Reset(u32 BaseAddress);
*
******************************************************************************/
#define STATS_Reset(BaseAddress) \
            STATS_WriteReg(BaseAddress, STATS_CONTROL, STATS_RST_RESET) \

/*****************************************************************************/
/**
*
* This macro clears the STATS's reset flag (which is set using STATS_Reset(), and
* returns it to normal operation. This ClearReset effects the core immediately,
* and may cause image tearing.
* 
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void STATS_ClearReset(u32 BaseAddress);
*
******************************************************************************/
#define STATS_ClearReset(BaseAddress) \
            STATS_WriteReg(BaseAddress, STATS_CONTROL, 0) \

/*****************************************************************************/
/**
*
* This macro resets a STATS instance, but differs from STATS_Reset() in that it
* automatically synchronizes to the SOF of the core to prevent tearing.
*
* On the next rising-edge of SOF following a call to STATS_AutoSyncReset(), 
* all of the core's configuration registers and outputs will be reset, then the
* reset flag will be immediately released, allowing the core to immediately resume
* default operation.
*
* @param BaseAddress is the Xilinx EDK base address of the STATS core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void STATS_AutoSyncReset(u32 BaseAddress);
*
******************************************************************************/
#define STATS_FSync_Reset(BaseAddress) \
            STATS_WriteReg(BaseAddress, STATS_CONTROL, STATS_RST_AUTORESET) \


/************************** Function Prototypes ******************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */ 
