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
// Create Date:         Nov 15, 2011
// Design Name:         FMC-IMAGEON HDMI Passthrough
// Module Name:         fmc_imageon_hdmi_passthrough.h
// Project Name:        FMC-IMAGEON HDMI Passthrough Program
// Target Devices:      Spartan-6, Virtex-6, Kintex-6
// Hardware Boards:     FMC-IMAGEON
// 
//
// Tool versions:       ISE 14.3
//
// Description:         FMC-IMAGEON HDMI Demo Program
//                      This application will configure the FMC-IMAGEON module
//                      for the simple case of an HDMI passthrough:
//                      - HDMI Input
//                         - ADV7611 configured for 16 bit YCbCr 4:2:2 mode
//                           with embedded syncs
//                      - HDMI Output
//                         - ADV7511 configured for 16 bit YCbCr 4:2:2 mode
//                           with embedded syncs
//                      If present, it will also reset the Video Timing Controller
//                      that is used for timing in the AXI4-Stream bridges
//
// Dependencies:
//
// Revision:            Nov 15, 2011: 1.00 Initial version
//                      Oct 17, 2012: 1.01 Add VTC Initialization
//
//----------------------------------------------------------------

#ifndef __FMC_IMAGEON_HDMI_PASSTHROUGH_H__
#define __FMC_IMAGEON_HDMI_PASSTHROUGH_H__

#include "xparameters.h"
#include "sleep.h"

#include "fmc_iic.h"
#include "fmc_imageon.h"
#include "video_resolution.h"

#if defined(XPAR_XVTC_NUM_INSTANCES)
   // If the design contains at least one VTC instance
   #include "xvtc_hw.h"
#endif

// This structure contains the context for the VITA-2000 frame buffer design
struct struct_fmc_imageon_hdmi_passthrough_t
{
   // IP base addresses
   Xuint32 uBaseAddr_IIC_FmcImageon;
#if defined(XPAR_XVTC_NUM_INSTANCES)
   Xuint32 uBaseAddr_VTC_Axi4sTiming;
#endif

   fmc_iic_t fmc_imageon_iic;

   fmc_imageon_t fmc_imageon;

   Xuint32 bVerbose;

   // HDMI Output settings
   Xuint32 hdmio_width;
   Xuint32 hdmio_height;
   Xuint32 hdmio_resolution;
   fmc_imageon_video_timing_t hdmio_timing;

   // HDMI Input Settings
   Xuint32 hdmii_locked;
   Xuint32 hdmii_width;
   Xuint32 hdmii_height;
   Xuint32 hdmii_resolution;
   fmc_imageon_video_timing_t hdmii_timing;

};
typedef struct struct_fmc_imageon_hdmi_passthrough_t fmc_imageon_hdmi_passthrough_t;

int fmc_imageon_hdmi_passthrough_init( fmc_imageon_hdmi_passthrough_t *pDemo );

#endif // __FMC_IMAGEON_HDMI_PASSTHROUGH_H__
