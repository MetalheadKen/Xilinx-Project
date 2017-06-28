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
// Create Date:         Mar 05, 2010
// Design Name:         Video Resolution utility
// Module Name:         video_resolution.h
// Project Name:        FMC-IMAGEON
// Target Devices:      Virtex-6, Kintex-7
// Avnet Boards:        FMC-IMAGEON
//
// Tool versions:       ISE 13.3
//
// Description:         IVK Video Resolution
//                      - video timing definitions
//                      - video resolution detection
//
// Dependencies:        
//
// Revision:            Mar 05, 2010: 1.00 Initial version for S6-IVK
//                      Dec 03, 2011: 1.01 Reuse for FMC-IMAGEON
//
//----------------------------------------------------------------

#ifndef __VIDEO_RESOLUTION_H__
#define __VIDEO_RESOLUTION_H__

#include "xbasic_types.h"

// Video Pattern Generator - Video Resolution values
#define VIDEO_RESOLUTION_VGA       0
#define VIDEO_RESOLUTION_NTSC      1
#define VIDEO_RESOLUTION_SVGA      2
#define VIDEO_RESOLUTION_XGA       3
#define VIDEO_RESOLUTION_720P      4
#define VIDEO_RESOLUTION_SXGA      5
#define VIDEO_RESOLUTION_1080P     6
#define VIDEO_RESOLUTION_UXGA      7
#define NUM_VIDEO_RESOLUTIONS      8

struct struct_vres_timing_t
{
	char *pName;
	Xuint32 VActiveVideo;
	Xuint32 VFrontPorch;
	Xuint32 VSyncWidth;
	Xuint32 VBackPorch;
	Xuint32 VSyncPolarity;
	Xuint32 HActiveVideo;
	Xuint32 HFrontPorch;
	Xuint32 HSyncWidth;
	Xuint32 HBackPorch;
	Xuint32 HSyncPolarity;
};
typedef struct struct_vres_timing_t vres_timing_t;

char *  vres_get_name(Xuint32 resolutionId);
Xuint32 vres_get_width(Xuint32 resolutionId);
Xuint32 vres_get_height(Xuint32 resolutionId);
Xuint32 vres_get_timing(Xuint32 resolutionId, vres_timing_t *pTiming );

Xint32 vres_detect( Xuint32 width, Xuint32 height );


#endif // __VIDEO_RESOLUTION_H__
