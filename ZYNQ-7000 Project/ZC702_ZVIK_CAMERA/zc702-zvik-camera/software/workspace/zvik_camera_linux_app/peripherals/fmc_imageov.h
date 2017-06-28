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
//                      Mar 17, 2010: 1.02 Add arguments to tfp403/tfp410 config routines
//                      May 12, 2010: 1.02b Add support for CDCE925's Y2 output
//                      ------------------------------------------
//                      Apr 12, 2011: 2.01 Modify *_usleep() function to prevent hanging
//
//----------------------------------------------------------------

#ifndef __FMC_IMAGEOV_H__
#define __FMC_IMAGEOV_H__

#include <stdio.h>

// Located in: microblaze_0/include/
#include "xparameters.h"
#include "xstatus.h"

#include "fmc_iic.h"

#define FMC_IMAGEOV_I2C_MUX_ADDR 0x70 // 0xE0/0xE1
#define FMC_IMAGEOV_TFP410_ADDR  0x38 // 0x70/0x71
#define FMC_IMAGEOV_CDCE925_ADDR 0x64 // 0xC8/0xC9
#define FMC_IMAGEOV_DDCEDID_ADDR 0x50 // 0xA0/0xA1

struct struct_fmc_imageov_t
{
   // software library version
   Xuint32 uVersion;

   // instantiation-specific name
   char szName[32];

   // pointer to FMC-IIC instance
   fmc_iic_t *pIIC;

   // GPIO value
   Xuint32 GpioData;
};
typedef struct struct_fmc_imageov_t fmc_imageov_t;

int fmc_imageov_init( fmc_imageov_t *pContext, char szName[], fmc_iic_t *pIIC );

// I2C MUX Functions
void fmc_imageov_iic_mux_reset( fmc_imageov_t *pContext );
void fmc_imageov_iic_mux( fmc_imageov_t *pContext, Xuint32 MuxSelect );
// Single Mux Selections
#define FMC_IMAGEOV_I2C_MIN               0
#define FMC_IMAGEOV_I2C_MAX               3
#define FMC_IMAGEOV_I2C_SELECT_CAMERA1    1
#define FMC_IMAGEOV_I2C_SELECT_CAMERA2    0
#define FMC_IMAGEOV_I2C_SELECT_TFP410     2
#define FMC_IMAGEOV_I2C_SELECT_CDCE925    2
#define FMC_IMAGEOV_I2C_SELECT_EDID       3
// Multiple Mux Selections
#define FMC_IMAGEOV_I2C_SELECT_CAMERAS    4 // select both CAMERA1 and CAMERA2

// General I2C Configuration Functions
void fmc_imageov_iic_config( fmc_imageov_t *pContext, Xuint8 ChipAddress, 
							 Xuint8 ConfigData[][2], Xuint32 ConfigLength );

// CDCE925 Functions
void fmc_imageov_config_cdce925( fmc_imageov_t *pContext );

void fmc_imageov_config_cdce925_y1_freq( fmc_imageov_t *pContext, Xuint32 FreqId );
void fmc_imageov_config_cdce925_y2_freq( fmc_imageov_t *pContext, Xuint32 FreqId );
#define FMC_IMAGEOV_FREQ_25_175_000       0
#define FMC_IMAGEOV_FREQ_27_000_000       1
#define FMC_IMAGEOV_FREQ_40_000_000       2
#define FMC_IMAGEOV_FREQ_65_000_000       3
#define FMC_IMAGEOV_FREQ_74_250_000       4
#define FMC_IMAGEOV_FREQ_110_000_000      5
#define FMC_IMAGEOV_FREQ_148_500_000      6
#define FMC_IMAGEOV_FREQ_162_000_000      7

void fmc_imageov_config_cdce925_y4y5_freq( fmc_imageov_t *pContext, Xuint32 FreqId );
#define FMC_IMAGEOV_FREQ_12_000_000       10
#define FMC_IMAGEOV_FREQ_24_000_000       11

// TFP410 Functions
#define FMC_IMAGEOV_TFP410_DISABLED       0
#define FMC_IMAGEOV_TFP410_ENABLED        1
#define FMC_IMAGEOV_TFP410_DESKEW_OFF     0x00  // de-skew = disabled
#define FMC_IMAGEOV_TFP410_DESKEW_n1400ps	0x10  // de-skew = -1400ps
#define FMC_IMAGEOV_TFP410_DESKEW_n1050ps 0x30  // de-skew = -1050ps
#define FMC_IMAGEOV_TFP410_DESKEW_n700ps  0x50  // de-skew =  -700ps
#define FMC_IMAGEOV_TFP410_DESKEW_n250ps  0x70  // de-skew =  -350ps
#define FMC_IMAGEOV_TFP410_DESKEW_p0ps    0x90  // de-skew =     0ps
#define FMC_IMAGEOV_TFP410_DESKEW_p350ps  0xB0  // de-skew =  +350ps
#define FMC_IMAGEOV_TFP410_DESKEW_p700ps  0xD0  // de-skew =  +700ps
#define FMC_IMAGEOV_TFP410_DESKEW_p1050ps 0xF0  // de-skew = +1050ps
void fmc_imageov_config_tfp410( fmc_imageov_t *pContext, Xuint32 Enable, Xuint32 DeSkew );
void fmc_imageov_reset_tfp410( fmc_imageov_t *pContext );

// DDC/EDID Functions
int fmc_imageov_read_dvio_edid( fmc_imageov_t *pContext, Xuint8 data[256] );

// Camera Functions
void fmc_imageov_camera_reset( fmc_imageov_t *pContext );
void fmc_imageov_camera_resync( fmc_imageov_t *pContext );
void fmc_imageov_camera_resync_mode( fmc_imageov_t *pContext, Xuint32 ResyncMode );

// Delay Functions
void fmc_imageov_wait_usec(unsigned int delay);

#endif // __FMC_IMAGEOV_H__
