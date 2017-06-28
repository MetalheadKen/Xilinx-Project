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
//                     Copyright(c) 2010 Avnet, Inc.
//                             All rights reserved.
//
//----------------------------------------------------------------
//
// Create Date:         Jun 30, 2009
// Design Name:         FMC-IMAGEOV
// Module Name:         fmc_imageov.h
// Project Name:        FMC-IMAGEOV
// Target Devices:      Spartan-6
// Avnet Boards:        FMC-IMAGEOV
//
// Tool versions:       ISE 13.1
//
// Description:         FMC-IMAGEOV Software Services.
//
// Dependencies:        
//
// Revision:            Jun 30, 2009: 1.00 Initial version
//                      Jan 08, 2010: 1.01 Use new fmc_iic library
//                      Mar 17, 2010: 1.02 Add arguments to tfp403/tfo410 config routines
//                      May 12, 2010: 1.02b Add support for CDCE925's Y2 output
//                      ------------------------------------------
//                      Apr 12, 2011: 2.01 Modify *_usleep() function to prevent hanging
//
//----------------------------------------------------------------

#include <stdio.h>
#include <string.h>

// Located in: microblaze_0/include/
#include "xparameters.h"
#include "xstatus.h"

#include "fmc_iic.h"
#include "fmc_imageov.h"

////////////////////////////////////////////////////////////////////////
// Driver Initialization
////////////////////////////////////////////////////////////////////////

/******************************************************************************
* This function initializes the FMC-IMAGEOV driver.
*
* @param    pContext contains a pointer to the new FMC-IMAGEOV instance's context.
* @param    szName contains a string describing the new FMC-IMAGEOV instance.
* @param    pIIC contains a pointer to a FMC-IIC instance's context.
*
* @return   If successfull, returns 1.  Otherwise, returns 0.
*
* @note     None.
*
******************************************************************************/
int fmc_imageov_init( fmc_imageov_t *pContext, char szName[], fmc_iic_t *pIIC )
{
   pContext->pIIC = pIIC;
   strcpy( pContext->szName, szName );

   // Initialize the GPIO bits to known state
   //  [7] = unused
   //  [6] = fmc_imageov_dvi_rst = 0
   //  [5] = fmc_imageov_iic_rst# = 1
   //  [4] = fmc_imageov_camera_resync mode = 0
   //  [3] = fmc_imageov_cam2_rst = 0
   //  [2] = fmc_imageov_cam1_rst = 0
   //  [1] = fmc_imageov_cam2_pwdn = 0
   //  [0] = fmc_imageov_cam1_pwdn = 0
   pContext->GpioData = 0x20;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );

   return 1;
}

////////////////////////////////////////////////////////////////////////
// I2C MUX Functions
////////////////////////////////////////////////////////////////////////

/******************************************************************************
* This function applies a reset to the I2C MUX.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_iic_mux_reset( fmc_imageov_t *pContext )
{   
   // Apply reset to I2C mux
   //xil_printf( "Apply reset to I2C mux ...\n\r" );
   // Modify appropriate GPIO bits
   //  [5] = fmc_imageov_iic_rst# = 0
   pContext->GpioData &= ~0x20;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
      
   // sleep 1sec
   fmc_imageov_wait_usec(1000000); 
   
   // Release reset from I2C mux
   //xil_printf( "Release reset from I2C mux ...\n\r" );
   // Modify appropriate GPIO bits
   //  [5] = fmc_imageov_iic_rst# = 1
   pContext->GpioData |= 0x20;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
}

/******************************************************************************
* This function configures the PCAxxxx I2C multiplexer.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
* @param    MuxSelect specified which of the I2C mux's outputs to enable.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_iic_mux( fmc_imageov_t *pContext, Xuint32 MuxSelect )
{
   Xuint8 mux_data;
   Xuint8 num_bytes;
   
   switch ( MuxSelect )
   {
      //
      // Single Mux Selections
      //
      case FMC_IMAGEOV_I2C_SELECT_CAMERA2:
         mux_data = 0x01;
         num_bytes =  pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_I2C_MUX_ADDR, mux_data, &mux_data, 1); 
         break;
      case FMC_IMAGEOV_I2C_SELECT_CAMERA1:
         mux_data = 0x02;
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_I2C_MUX_ADDR, mux_data, &mux_data, 1); 
         break;
      case FMC_IMAGEOV_I2C_SELECT_TFP410:
      //case FMC_IMAGEOV_I2C_SELECT_CDCE925:
         mux_data = 0x04;
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_I2C_MUX_ADDR, mux_data, &mux_data, 1); 
         break;
      case FMC_IMAGEOV_I2C_SELECT_EDID:
         mux_data = 0x08;
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_I2C_MUX_ADDR, mux_data, &mux_data, 1); 
         break;
      //
      // Multiple Mux Selections
      //
      case FMC_IMAGEOV_I2C_SELECT_CAMERAS:
         mux_data = 0x01 | 0x02;
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_I2C_MUX_ADDR, mux_data, &mux_data, 1); 
         break;
   }
   //xil_printf("[fmc_imageov_iic_mux] I2C_MUX=%d\n\r", MuxSelect );

}

////////////////////////////////////////////////////////////////////////
// Generic I2C Configuration Functions
////////////////////////////////////////////////////////////////////////

/******************************************************************************
* This function sends an I2C configuration sequence.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
* @param    MuxSelect specified which of the I2C mux's outputs to enable.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_iic_config( fmc_imageov_t *pContext, Xuint8 ChipAddress, 
							 Xuint8 ConfigData[][2], Xuint32 ConfigLength )
{
   Xuint8 num_bytes;
   int i;

   //xil_printf("I2C[0x%02X] : ");
   for ( i = 0; i < ConfigLength; i++ )
   {
      num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, ChipAddress, ConfigData[i][0], &(ConfigData[i][1]), 1); 
      //if ( num_bytes > 0 ) xil_printf("+"); else xil_printf("-");
   }
   //xil_printf("\n\r");
}

////////////////////////////////////////////////////////////////////////
// CDCE925 Functions
////////////////////////////////////////////////////////////////////////

// CDCE925 
#define MAX_IIC_CDCE925 48
static Xuint8 iic_cdce925[MAX_IIC_CDCE925][2]=
{
   0x00, 0x81, // Byte 00 - 10000001
   0x01, 0x00, // Byte 01 - 00000000
               // [1:0] - Slave Address A[1:0]=00b
   //0x02, 0xB4, // Byte 02 - 10110100
   //0x03, 0x01, // Byte 03 - 00000001
   0x02, 0xB4, // [  7] = M1 = 1 (PLL1 Clock)
               // [1:0] = PDIV1[9:8] = 
   0x03, 0x02, // [7:0] = PDIV1[7:0] = 2
   0x04, 0x02, // Byte 04 - 00000010
   0x05, 0x50, // Byte 05 - 01010000
   0x06, 0x60, // Byte 06 - 01100000
   0x07, 0x00, // Byte 07 - 00000000
   0x08, 0x00, // Byte 08 - 00000000
   0x09, 0x00, // Byte 09 - 00000000
   0x0A, 0x00, // Byte 10 - 00000000
   0x0B, 0x00, // Byte 11 - 00000000
   0x0C, 0x00, // Byte 12 - 00000000
   0x0D, 0x00, // Byte 13 - 00000000
   0x0E, 0x00, // Byte 14 - 00000000
   0x0F, 0x00, // Byte 15 - 00000000
   0x10, 0x00, // Byte 16 - 00000000
   0x11, 0x00, // Byte 17 - 00000000
   0x12, 0x00, // Byte 18 - 00000000
   0x13, 0x00, // Byte 19 - 00000000
   //0x14, 0xED, // Byte 20 - 11101101
   0x14, 0x6D, // [  7] = MUX1 = 0 (PLL1)
               // [  6] = M2 = 1 (PDIV2)
               // [5:4] = M3 = 2 (PDIV3)
   0x15, 0x02, // Byte 21 - 00000010
   //0x16, 0x01, // Byte 22 - 00000001
   //0x17, 0x01, // Byte 23 - 00000001
   0x16, 0x00, // [6:0] = PDIV2 = 0 (reset and stand-by)
   0x17, 0x00, // [6:0] = PDIV3 = 0 (reset and stand-by)
   //0x18, 0x00, // Byte 24 - 00000000
   //0x19, 0x40, // Byte 25 - 01000000
   //0x1A, 0x02, // Byte 26 - 00000010
   //0x1B, 0x08, // Byte 27 - 00001000
               // PLL1 : Fin=27MHz, M=2, N=11, PDIV=2 Fout=74.25MHz
               //        Fvco = 148.5 MHz
               //        P = 4 - int(log2(11/2)) = 4 - 2 = 2
               //        N'= 11 * 2^2 = 44
               //        Q = int(44/2) = 22
               //        R = 44 - 2*22 = 0
   0x18, 0x00, // [7:0] = PLL1_0N[11:4] = 00000000
   0x19, 0xB0, // [7:4] = PLL1_0N[3:0] = 1011
               // [3:0] = PLL1_0R[8:5] = 0000
   0x1A, 0x02, // [7:3] = PLL1_0R[4:0] = 00000
               // [2:0] = PLL1_0Q[5:3] = 010
   0x1B, 0xC9, // [7:5] = PLL1_0Q[2:0] = 110
               // [4:2] = PLL1_0P[2:0] = 010
               // [1:0] = VC01_0_RANGE[1:0] = 01 (125 MHz < Fvco1 < 150 MHz)
   //0x1C, 0x00, // Byte 28 - 00000000
   //0x1D, 0x40, // Byte 29 - 01000000
   //0x1E, 0x02, // Byte 30 - 00000010
   //0x1F, 0x08, // Byte 31 - 00001000
               // PLL1 : Fin=27MHz, M=2, N=11, PDIV=2 Fout=74.25MHz
               //        Fvco = 148.5 MHz
               //        P = 4 - int(log2(11/2)) = 4 - 2 = 2
               //        N'= 11 * 2^2 = 44
               //        Q = int(44/2) = 22
               //        R = 44 - 2*22 = 0
   0x1C, 0x00, // [7:0] = PLL1_1N[11:4] = 00000000
   0x1D, 0xB0, // [7:4] = PLL1_1N[3:0] = 1011
               // [3:0] = PLL1_1R[8:5] = 0000
   0x1E, 0x02, // [7:3] = PLL1_1R[4:0] = 00000
               // [2:0] = PLL1_1Q[5:3] = 010
   0x1F, 0xC9, // [7:5] = PLL1_1Q[2:0] = 110
               // [4:2] = PLL1_1P[2:0] = 010
               // [1:0] = VC01_1_RANGE[1:0] = 01 (125 MHz < Fvco1 < 150 MHz)
   0x20, 0x00, // Byte 32 - 00000000
   0x21, 0x00, // Byte 33 - 00000000
   0x22, 0x00, // Byte 34 - 00000000
   0x23, 0x00, // Byte 35 - 00000000
//   0x24, 0xED, // Byte 36 - 11101101
   0x24, 0x6D, // [  7] = MUX2 = 0 (PLL2)
               // [  6] = M4 = 1 (PDIV4)
               // [5:4] = M5 = 2 (PDIV5)
   0x25, 0x02, // Byte 37 - 00000010
//   0x26, 0x01, // Byte 38 - 00000001
//   0x27, 0x01, // Byte 39 - 00000001
   0x26, 0x09, // [6:0] = PDIV4 = 9
   0x27, 0x09, // [6:0] = PDIV5 = 9
//   0x28, 0x00, // Byte 40 - 00000000
//   0x29, 0x40, // Byte 41 - 01000000
//   0x2A, 0x02, // Byte 42 - 00000010
//   0x2B, 0x08, // Byte 43 - 00001000
               // PLL2 : Fin=27MHz, M=511, N=4088, PDIV=9 Fout=24MHz
               //        Fvco = 216 MHz
               //        P = 4 - int(log2(4088/511)) = 4 - 3 = 1
               //        N'= 4088 * 2^1 = 8176
               //        Q = int(8176/511) = 16
               //        R = 8176 - 511*16 = 0
   0x28, 0xFF, // [7:0] = PLL2_0N[11:4] = 11111111
   0x29, 0x80, // [7:4] = PLL2_0N[3:0] = 1000
               // [3:0] = PLL2_0R[8:5] = 0000
   0x2A, 0x02, // [7:3] = PLL2_0R[4:0] = 00000
               // [2:0] = PLL2_0Q[5:3] = 010
   0x2B, 0x07, // [7:5] = PLL2_0Q[2:0] = 000
               // [4:2] = PLL2_0P[2:0] = 001
               // [1:0] = VC02_0_RANGE[1:0] = 11 (Fvco1 > 175 MHz)
//   0x2C, 0x00, // Byte 44 - 00000000
//   0x2D, 0x40, // Byte 45 - 01000000
//   0x2E, 0x02, // Byte 46 - 00000010
//   0x2F, 0x08  // Byte 47 - 00001000   
               // PLL2 : Fin=27MHz, M=511, N=4088, PDIV=9 Fout=24MHz
               //        Fvco = 216 MHz
               //        P = 4 - int(log2(4088/511)) = 4 - 3 = 1
               //        N'= 4088 * 2^1 = 8176
               //        Q = int(8176/511) = 16
               //        R = 8176 - 511*16 = 0
   0x2C, 0xFF, // [7:0] = PLL2_1N[11:4] = 11111111
   0x2D, 0x80, // [7:4] = PLL2_1N[3:0] = 1000
               // [3:0] = PLL2_1R[8:5] = 0000
   0x2E, 0x02, // [7:3] = PLL2_1R[4:0] = 00000
               // [2:0] = PLL2_1Q[5:3] = 010
   0x2F, 0x07  // [7:5] = PLL2_1Q[2:0] = 000
               // [4:2] = PLL2_1P[2:0] = 001
               // [1:0] = VC02_1_RANGE[1:0] = 11 (Fvco1 > 175 MHz)
};

//////////////////////////////////////////
// 25.175000 MHz
//////////////////////////////////////////
// PLL1: M = 270, N = 1007, Pdiv = 4
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 100.700000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 25.175000MHz
//       P = 4 - int(log2(M/N)) = 3
//       Np = N * 2^P = 8056
//       Q = int(Np/M) = 29
//       R = Np - M*Q = 226
static Xuint8 iic_cdce925_y1_config_25_175_000[6][2] = 
{
   0x02, 0xB4,   // [  7] = M1 = 1 (PLL1 clock) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x04,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x3E,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0xF7,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x13,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0xAC    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//////////////////////////////////////////
// 27.000000 MHz
//////////////////////////////////////////
// PLL1: M = 1, N = 1, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 27.000000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 27.000000MHz
//       P = 4 - int(log2(M/N)) = 4
//       Np = N * 2^P = 16
//       Q = int(Np/M) = 16
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y1_config_27_000_000[6][2] = 
{
   0x02, 0x34,   // [  7] = M1 = 0 (PLL1 bypassed) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x01,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x00,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0x10,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x02,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0x10    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//ERROR => Fvco = 80.000000MHz <= 100MHz !
//////////////////////////////////////////
// 40.000000 MHz
//////////////////////////////////////////
// PLL1: M = 27, N = 80, Pdiv = 2
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 80.000000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 40.000000MHz
//       P = 4 - int(log2(M/N)) = 3
//       Np = N * 2^P = 640
//       Q = int(Np/M) = 23
//       R = Np - M*Q = 19
static Xuint8 iic_cdce925_y1_config_40_000_000[6][2] = 
{
   0x02, 0xB4,   // [  7] = M1 = 1 (PLL1 clock) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x02,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x05,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0x00,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x9A,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0xEC    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//////////////////////////////////////////
// 65.000000 MHz
//////////////////////////////////////////
// PLL1: M = 27, N = 130, Pdiv = 2
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 130.000000MHz
//       Range = 1 (125 MHz <= Fvco < 150 MHz)
//       Fout = Fvco / Pdiv = 65.000000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 520
//       Q = int(Np/M) = 19
//       R = Np - M*Q = 7
static Xuint8 iic_cdce925_y1_config_65_000_000[6][2] = 
{
   0x02, 0xB4,   // [  7] = M1 = 1 (PLL1 clock) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x02,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x08,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0x20,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x3A,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0x69    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//////////////////////////////////////////
// 74.250000 MHz
//////////////////////////////////////////
// PLL1: M = 2, N = 11, Pdiv = 2
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 148.500000MHz
//       Range = 1 (125 MHz <= Fvco < 150 MHz)
//       Fout = Fvco / Pdiv = 74.250000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 44
//       Q = int(Np/M) = 22
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y1_config_74_250_000[6][2] = 
{
   0x02, 0xB4,   // [  7] = M1 = 1 (PLL1 clock) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x02,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x00,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0xB0,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x02,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0xC9    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//////////////////////////////////////////
// 110.000000 MHz
//////////////////////////////////////////
// PLL1: M = 27, N = 110, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 110.000000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 110.000000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 440
//       Q = int(Np/M) = 16
//       R = Np - M*Q = 8
static Xuint8 iic_cdce925_y1_config_110_000_000[6][2] = 
{
   0x02, 0xB4,   // [  7] = M1 = 1 (PLL1 clock) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x01,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x06,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0xE0,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x42,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0x08    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//////////////////////////////////////////
// 148.500000 MHz
//////////////////////////////////////////
// PLL1: M = 2, N = 11, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 148.500000MHz
//       Range = 1 (125 MHz <= Fvco < 150 MHz)
//       Fout = Fvco / Pdiv = 148.500000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 44
//       Q = int(Np/M) = 22
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y1_config_148_500_000[6][2] = 
{
   0x02, 0xB4,   // [  7] = M1 = 1 (PLL1 clock) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x01,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x00,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0xB0,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x02,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0xC9    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//////////////////////////////////////////
// 162.000000 MHz
//////////////////////////////////////////
// PLL1: M = 1, N = 6, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 162.000000MHz
//       Range = 2 (150 MHz <= Fvco < 175 MHz)
//       Fout = Fvco / Pdiv = 162.000000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 24
//       Q = int(Np/M) = 24
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y1_config_162_000_000[6][2] = 
{
   0x02, 0xB4,   // [  7] = M1 = 1 (PLL1 clock) 
                 // [1:0] = Pdiv1[9:8] 
   0x03, 0x01,   // [7:0] = Pdiv1[7:0] 
   0x18, 0x00,   // [7:0] = PLL1_0N[11:4] 
   0x19, 0x60,   // [7:4] = PLL1_0N[3:0]  
                 // [3:0] = PLL1_0R[8:5]  
   0x1A, 0x03,   // [7:3] = PLL1_0R[4:0]  
                 // [2:0] = PLL1_0Q[5:3]  
   0x1B, 0x0A    // [7:5] = PLL1_0Q[2:0] 
                 // [4:2] = PLL1_0P[2:0]  
                 // [1:0] = VCO1_0_RANGE[1:0] 
};

//////////////////////////////////////////
// 25.175000 MHz
//////////////////////////////////////////
// PLL1: M = 270, N = 1007, Pdiv = 4
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 100.700000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 25.175000MHz
//       P = 4 - int(log2(M/N)) = 3
//       Np = N * 2^P = 8056
//       Q = int(Np/M) = 29
//       R = Np - M*Q = 226
static Xuint8 iic_cdce925_y2_config_25_175_000[5][2] = 
{
   0x16, 0x04,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x3E,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0xF7,   // [7:4] = PLL1_1N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x13,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0xAC    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//////////////////////////////////////////
// 27.000000 MHz
//////////////////////////////////////////
// PLL1: M = 1, N = 1, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 27.000000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 27.000000MHz
//       P = 4 - int(log2(M/N)) = 4
//       Np = N * 2^P = 16
//       Q = int(Np/M) = 16
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y2_config_27_000_000[5][2] = 
{
   0x16, 0x01,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x00,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0x10,   // [7:4] = PLL1_1N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x02,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0x10    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//ERROR => Fvco = 80.000000MHz <= 100MHz !
//////////////////////////////////////////
// 40.000000 MHz
//////////////////////////////////////////
// PLL1: M = 27, N = 80, Pdiv = 2
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 80.000000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 40.000000MHz
//       P = 4 - int(log2(M/N)) = 3
//       Np = N * 2^P = 640
//       Q = int(Np/M) = 23
//       R = Np - M*Q = 19
static Xuint8 iic_cdce925_y2_config_40_000_000[5][2] = 
{
   0x16, 0x02,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x05,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0x00,   // [7:4] = PLL1_1N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x9A,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0xEC    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//////////////////////////////////////////
// 65.000000 MHz
//////////////////////////////////////////
// PLL1: M = 27, N = 130, Pdiv = 2
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 130.000000MHz
//       Range = 1 (125 MHz <= Fvco < 150 MHz)
//       Fout = Fvco / Pdiv = 65.000000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 520
//       Q = int(Np/M) = 19
//       R = Np - M*Q = 7
static Xuint8 iic_cdce925_y2_config_65_000_000[6][2] = 
{
   0x16, 0x02,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x08,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0x20,   // [7:4] = PLL1_1N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x3A,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0x69    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//////////////////////////////////////////
// 74.250000 MHz
//////////////////////////////////////////
// PLL1: M = 2, N = 11, Pdiv = 2
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 148.500000MHz
//       Range = 1 (125 MHz <= Fvco < 150 MHz)
//       Fout = Fvco / Pdiv = 74.250000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 44
//       Q = int(Np/M) = 22
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y2_config_74_250_000[5][2] = 
{
   0x16, 0x02,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x00,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0xB0,   // [7:4] = PLL1_1N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x02,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0xC9    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//////////////////////////////////////////
// 110.000000 MHz
//////////////////////////////////////////
// PLL1: M = 27, N = 110, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 110.000000MHz
//       Range = 0 (Fvco < 125 MHz)
//       Fout = Fvco / Pdiv = 110.000000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 440
//       Q = int(Np/M) = 16
//       R = Np - M*Q = 8
static Xuint8 iic_cdce925_y2_config_110_000_000[5][2] = 
{
   0x16, 0x01,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x06,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0xE0,   // [7:4] = PLL1_10N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x42,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0x08    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//////////////////////////////////////////
// 148.500000 MHz
//////////////////////////////////////////
// PLL1: M = 2, N = 11, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 148.500000MHz
//       Range = 1 (125 MHz <= Fvco < 150 MHz)
//       Fout = Fvco / Pdiv = 148.500000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 44
//       Q = int(Np/M) = 22
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y2_config_148_500_000[5][2] = 
{
   0x16, 0x01,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x00,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0xB0,   // [7:4] = PLL1_1N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x02,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0xC9    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//////////////////////////////////////////
// 162.000000 MHz
//////////////////////////////////////////
// PLL1: M = 1, N = 6, Pdiv = 1
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 162.000000MHz
//       Range = 2 (150 MHz <= Fvco < 175 MHz)
//       Fout = Fvco / Pdiv = 162.000000MHz
//       P = 4 - int(log2(M/N)) = 2
//       Np = N * 2^P = 24
//       Q = int(Np/M) = 24
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y2_config_162_000_000[5][2] = 
{
   0x16, 0x01,   // [7:0] = Pdiv2[6:0] 
   0x1C, 0x00,   // [7:0] = PLL1_1N[11:4] 
   0x1D, 0x60,   // [7:4] = PLL1_1N[3:0]  
                 // [3:0] = PLL1_1R[8:5]  
   0x1E, 0x03,   // [7:3] = PLL1_1R[4:0]  
                 // [2:0] = PLL1_1Q[5:3]  
   0x1F, 0x0A    // [7:5] = PLL1_1Q[2:0] 
                 // [4:2] = PLL1_1P[2:0]  
                 // [1:0] = VCO1_1_RANGE[1:0] 
};

//ERROR => Fvco = 216.000000MHz >= 200MHz !
//////////////////////////////////////////
// 24.000000 MHz
//////////////////////////////////////////
// PLL2: M = 511, N = 4088, Pdiv = 9
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 216.000000MHz
//       Range = 3 (Fvco >= 175 MHz)
//       Fout = Fvco / Pdiv = 24.000000MHz
//       P = 4 - int(log2(M/N)) = 1
//       Np = N * 2^P = 8176
//       Q = int(Np/M) = 16
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y4y5_config_24_000_000[7][2] = 
{
   0x24, 0x6D,   // [  7] = MUX2 = 0 (PLL2)
                 // [  6] = M4 = 1 (PDIV4)
                 // [5:4] = M5 = 2 (PDIV5)
   0x26, 0x09,   // [6:0] = PDIV4 = 9
   0x27, 0x09,   // [6:0] = PDIV5 = 9

   0x28, 0xFF,   // [7:0] = PLL2_0N[11:4] 
   0x29, 0x80,   // [7:4] = PLL2_0N[3:0]  
                 // [3:0] = PLL2_0R[8:5]  
   0x2A, 0x02,   // [7:3] = PLL2_0R[4:0]  
                 // [2:0] = PLL2_0Q[5:3]  
   0x2B, 0x07    // [7:5] = PLL2_0Q[2:0] 
                 // [4:2] = PLL2_0P[2:0]  
                 // [1:0] = VCO2_0_RANGE[1:0] 
};

//ERROR => Fvco = 216.000000MHz >= 200MHz !
//////////////////////////////////////////
// 12.000000 MHz
//////////////////////////////////////////
// PLL2: M = 511, N = 4088, Pdiv = 18
//       Fin  = 27.000000MHz
//       Fvco = Fin * N/M = 216.000000MHz
//       Range = 3 (Fvco >= 175 MHz)
//       Fout = Fvco / Pdiv = 12.000000MHz
//       P = 4 - int(log2(M/N)) = 1
//       Np = N * 2^P = 8176
//       Q = int(Np/M) = 16
//       R = Np - M*Q = 0
static Xuint8 iic_cdce925_y4y5_config_12_000_000[7][2] = 
{
   0x24, 0x6D,   // [  7] = MUX2 = 0 (PLL2)
                 // [  6] = M4 = 1 (PDIV4)
                 // [5:4] = M5 = 2 (PDIV5)
   0x26, 0x12,   // [6:0] = PDIV4 = 18
   0x27, 0x12,   // [6:0] = PDIV5 = 18

   0x28, 0xFF,   // [7:0] = PLL2_0N[11:4] 
   0x29, 0x80,   // [7:4] = PLL2_0N[3:0]  
                 // [3:0] = PLL2_0R[8:5]  
   0x2A, 0x02,   // [7:3] = PLL2_0R[4:0]  
                 // [2:0] = PLL2_0Q[5:3]  
   0x2B, 0x07    // [7:5] = PLL2_0Q[2:0] 
                 // [4:2] = PLL2_0P[2:0]  
                 // [1:0] = VCO2_0_RANGE[1:0] 
};

/******************************************************************************
* This function configures the CDCE925 video clock synthesizer.
* The CDCE925 has 5 outputs which are configured as follows:
*    Y1 => 74.25 MHz
*    Y2 => off
*    Y3 => off
*    Y4 => 24 MHz
*    Y5 => 24 MHz
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_config_cdce925( fmc_imageov_t *pContext )
{
   int dev;
   Xuint8 xdata;
   Xuint8 num_bytes;
   int i;

   fmc_imageov_iic_mux( pContext, FMC_IMAGEOV_I2C_SELECT_CDCE925 );

   /*
    * Send I2C config sequence
    */
   for ( i = 0; i < MAX_IIC_CDCE925; i++ )
   {
      num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC,
         FMC_IMAGEOV_CDCE925_ADDR, 
         (0x80 | iic_cdce925[i][0]), &(iic_cdce925[i][1]), 1); 
      //xil_printf("[fmc_imageov_config_cdce925] CDCE925[0x%02X] <= 0x%02X\n\r",(0x80 | iic_cdce925[i][0]), (iic_cdce925[i][1]));
      //num_bytes = pContext->pIIC->fpIicRead( pContext->pIIC,
      //   FMC_IMAGEOV_CDCE925_ADDR, 
      //   (0x80 | iic_cdce925[i][0]), &xdata, 1); 
      //xil_printf("[fmc_imageov_config_cdce925] CDCE925[0x%02X] => 0x%02X\n\r",(0x80 | iic_cdce925[i][0]), xdata);
   }
}

/******************************************************************************
* This function configures the CDCE925 video clock synthesizer's Y1 output.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
* @param    FreqId contains the id of the frequency to configure.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_config_cdce925_y1_freq( fmc_imageov_t *pContext, Xuint32 FreqId )
{
   int dev;
   Xuint8 num_bytes;
   int i;

   fmc_imageov_iic_mux( pContext, FMC_IMAGEOV_I2C_SELECT_CDCE925 );

   switch ( FreqId )
   {
   case FMC_IMAGEOV_FREQ_25_175_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_25_175_000[i][0]), &(iic_cdce925_y1_config_25_175_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_27_000_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_27_000_000[i][0]), &(iic_cdce925_y1_config_27_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_40_000_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_40_000_000[i][0]), &(iic_cdce925_y1_config_40_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_65_000_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_65_000_000[i][0]), &(iic_cdce925_y1_config_65_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_74_250_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_74_250_000[i][0]), &(iic_cdce925_y1_config_74_250_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_110_000_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_110_000_000[i][0]), &(iic_cdce925_y1_config_110_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_148_500_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_148_500_000[i][0]), &(iic_cdce925_y1_config_148_500_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_162_000_000:
      for ( i = 0; i < 6; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y1_config_162_000_000[i][0]), &(iic_cdce925_y1_config_162_000_000[i][1]), 1); 
      }
      break;
   }
}

/******************************************************************************
* This function configures the CDCE925 video clock synthesizer's Y2 output.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
* @param    FreqId contains the id of the frequency to configure.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_config_cdce925_y2_freq( fmc_imageov_t *pContext, Xuint32 FreqId )
{
   int dev;
   Xuint8 num_bytes;
   int i;

   fmc_imageov_iic_mux( pContext, FMC_IMAGEOV_I2C_SELECT_CDCE925 );

   switch ( FreqId )
   {
   case FMC_IMAGEOV_FREQ_25_175_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_25_175_000[i][0]), &(iic_cdce925_y2_config_25_175_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_27_000_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_27_000_000[i][0]), &(iic_cdce925_y2_config_27_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_40_000_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_40_000_000[i][0]), &(iic_cdce925_y2_config_40_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_65_000_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_65_000_000[i][0]), &(iic_cdce925_y2_config_65_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_74_250_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_74_250_000[i][0]), &(iic_cdce925_y2_config_74_250_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_110_000_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_110_000_000[i][0]), &(iic_cdce925_y2_config_110_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_148_500_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_148_500_000[i][0]), &(iic_cdce925_y2_config_148_500_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_162_000_000:
      for ( i = 0; i < 5; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y2_config_162_000_000[i][0]), &(iic_cdce925_y2_config_162_000_000[i][1]), 1); 
      }
      break;
   }
}

/******************************************************************************
* This function configures the CDCE925 video clock synthesizer's Y4 & Y5 outputs.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
* @param    FreqId contains the id of the frequency to configure.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_config_cdce925_y4y5_freq( fmc_imageov_t *pContext, Xuint32 FreqId )
{
   int dev;
   Xuint8 num_bytes;
   int i;

   fmc_imageov_iic_mux( pContext, FMC_IMAGEOV_I2C_SELECT_CDCE925 );

   switch ( FreqId )
   {
   case FMC_IMAGEOV_FREQ_12_000_000:
      for ( i = 0; i < 7; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y4y5_config_12_000_000[i][0]), &(iic_cdce925_y4y5_config_12_000_000[i][1]), 1); 
      }
      break;
   case FMC_IMAGEOV_FREQ_24_000_000:
      for ( i = 0; i < 7; i++ )
      {
         num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_CDCE925_ADDR, 
            (0x80 | iic_cdce925_y4y5_config_24_000_000[i][0]), &(iic_cdce925_y4y5_config_24_000_000[i][1]), 1); 
      }
      break;
   }
}

////////////////////////////////////////////////////////////////////////
// TFP410 Functions
////////////////////////////////////////////////////////////////////////

/******************************************************************************
* This function configures the TFP410 TMDS serializer.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
* @param    Enable will activate the TFP410 device (when 0, the device is powered-down).
* @param    DeSkew will confifure the TFP410's programmable input data de-skew.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_config_tfp410( fmc_imageov_t *pContext, Xuint32 Enable, Xuint32 DeSkew )
{
   Xuint8 dvi_data;
   Xuint8 num_bytes;

   fmc_imageov_iic_mux( pContext, FMC_IMAGEOV_I2C_SELECT_TFP410 );

   num_bytes = pContext->pIIC->fpIicRead( pContext->pIIC, FMC_IMAGEOV_TFP410_ADDR, 0x08, &dvi_data, 1); 
   //xil_printf( "[fmc_imageov_config_tfp410] TFP410[0x08] <= 0x%02X\n\r", dvi_data );
   if ( Enable )
   {
      dvi_data |=  0x01; // PDN# = 1 (active)
   }
   else
   {
      dvi_data &=  ~0x01; // PDN# = 0 (power down)
   }
   dvi_data |=  0x02; // EDGE = 1
   dvi_data &= ~0x04; // BSEL = 0 (12-bit dual-edge mode)
   dvi_data &= ~0x08; // DSEL = 0 (single-ended clock)
   //xil_printf( "[fmc_imageov_config_tfp410] TFP410[0x08] <= 0x%02X\n\r", dvi_data );
   num_bytes = pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_TFP410_ADDR, 0x08, &dvi_data, 1); 

   // Adjust de-skewing delay on DVI_OUT_DATA[11:0]
   dvi_data = DeSkew;
   //xil_printf( "[fmc_imageov_config_tfp410] TFP410[0x0A] <= 0x%02X\n\r", dvi_data );
   num_bytes =pContext->pIIC->fpIicWrite( pContext->pIIC, FMC_IMAGEOV_TFP410_ADDR, 0x0A, &dvi_data, 1); 
   
}

/******************************************************************************
* This function resets the TFP410 TMDS serializer.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_reset_tfp410( fmc_imageov_t *pContext )
{
   // Apply reset to I2C mux
   //xil_printf( "Apply reset to I2C mux ...\n\r" );
   // Modify appropriate GPIO bits
   //  [6] = fmc_imageov_dvi_rst = 0
   pContext->GpioData |= 0x40;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
   
   // sleep 1sec
   fmc_imageov_wait_usec(1000000); 
   
   // Release reset from I2C mux
   //xil_printf( "Release reset from I2C mux ...\n\r" );
   // Modify appropriate GPIO bits
   //  [6] = fmc_imageov_dvi_rst = 0
   pContext->GpioData &= ~0x40;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
}

////////////////////////////////////////////////////////////////////////
// DDC/EDID Functions
////////////////////////////////////////////////////////////////////////
/******************************************************************************
* This function reads the contents of the DVI output's EDID EEPROM.
*
* @param    pContext contains a pointer to a FMC-IMAGEOV instance's context.
* @param    pData contains a vector where the EDID EEPROM are stored.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
int fmc_imageov_read_dvio_edid( fmc_imageov_t *pContext, Xuint8 data[256] )
{
   Xuint8 num_bytes = 0;
   int    idx;
   
   // Mux Selection
   fmc_imageov_iic_mux( pContext, FMC_IMAGEOV_I2C_SELECT_EDID );

   // Read contents of EDID EEPROM
   for ( idx = 0; idx < 256; idx++ )
   {
      num_bytes += pContext->pIIC->fpIicRead( pContext->pIIC, FMC_IMAGEOV_DDCEDID_ADDR, idx, &data[idx], 1); 
   }
   
   return num_bytes;
}

////////////////////////////////////////////////////////////////////////
// Camera Functions
////////////////////////////////////////////////////////////////////////

/******************************************************************************
* This function applies a reset to both cameras.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_camera_reset( fmc_imageov_t *pContext )
{   
   // Apply reset to both image sensors
   //xil_printf( "Apply reset to both image sensors ...\n\r" );
   // Modify appropriate GPIO bits
   //  [3] = fmc_imageov_cam2_rst = 1
   //  [2] = fmc_imageov_cam1_rst = 1
   pContext->GpioData |= 0x0C;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
   
   // sleep 1sec
   fmc_imageov_wait_usec(1000000); 
   
   // Release reset from both image sensors
   //xil_printf( "Release reset from both image sensors ...\n\r" );
   // Modify appropriate GPIO bits
   //  [3] = fmc_imageov_cam2_rst = 0
   //  [2] = fmc_imageov_cam1_rst = 0
   pContext->GpioData &= ~0x0C;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
}

/******************************************************************************
* This function synchronizes the two camera streams together.
* This is accomplished with the PWDN signals.
*
* @param    pContext contains a pointer to the FMC-IMAGEOV instance's context.
*
* @return   None.
*
* @note     None.
*
******************************************************************************/
void fmc_imageov_camera_resync( fmc_imageov_t *pContext )
{   
   // Apply PWDN on both image sensors simultaneously to synchronize them together
   xil_printf( "Apply powerdown to both image sensors ...\n\r" );
   
   // Modify appropriate GPIO bits
   //  [1] = fmc_imageov_cam2_pwdn = 1
   //  [0] = fmc_imageov_cam1_pwdn = 1
   pContext->GpioData |= 0x03;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
   
   // sleep 1sec
   fmc_imageov_wait_usec(1000000); 
   
   xil_printf( "Release powerdown from both image sensors ...\n\r" );
   // Modify appropriate GPIO bits
   //  [1] = fmc_imageov_cam2_pwdn = 0
   //  [0] = fmc_imageov_cam1_pwdn = 0
   pContext->GpioData &= ~0x03;
   pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
}

void fmc_imageov_camera_resync_mode( fmc_imageov_t *pContext, Xuint32 ResyncMode )
{
   if ( ResyncMode == 0 )
   {
      // Initialize the GPIO bits to known state
      //  [4] = fmc_imageov_camera_resync mode = 0
      pContext->GpioData &= ~0x10;
      pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
   }
   else
   {
      // Initialize the GPIO bits to known state
      //  [4] = fmc_imageov_camera_resync mode = 1
      pContext->GpioData |= 0x10;
      pContext->pIIC->fpGpoWrite( pContext->pIIC, pContext->GpioData );
   }
}

////////////////////////////////////////////////////////////////////////
// Delay Functions
////////////////////////////////////////////////////////////////////////

/***********************************************************************
* Wait the specified number of microseconds
*
* @param    delay specifies the number of microseconds to wait.
*
* @return   None. 
*
* @note     Call external usleep() function, supplied by user application
*
***********************************************************************/
extern void usleep(unsigned int useconds);
void fmc_imageov_wait_usec(unsigned int delay) {
#if SIM
  // no delay for simulation
  return;
#endif

  usleep(delay);
}

