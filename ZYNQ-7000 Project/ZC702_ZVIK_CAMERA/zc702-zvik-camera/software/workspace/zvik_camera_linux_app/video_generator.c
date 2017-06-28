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
// Create Date:         Dec 09, 2011
// Design Name:         Video Generator
// Module Name:         video_generator.c
// Project Name:        FMC-IMAGEON
// Target Devices:      Virtex-6, Kintex-7
// Avnet Boards:        FMC-IMAGEON
//
// Tool versions:       ISE 14.4
//
// Description:         Video Generator using:
//                      - Xilinx Video Timing Controller (VTC)
//
// Dependencies:
//
// Revision:            Dec 09, 2011: 1.00 Initial version
//                      Dec 15, 2012: 1.03 Updated to use 14.4 cores
//                                         and Xilinx tools
//
//----------------------------------------------------------------

#include "video_generator.h"
#include "video_resolution.h"
#include "sleep.h"
#include "os.h"

/*****************************************************************************/
/**
*
* This function sets up the Video Timing Controller Signal configuration.
*
* @param	None.
*
* @return	None.
*
* @note		None.
*
****************************************************************************/
static void SignalSetup( XVtc *pVtc, Xuint32 ResolutionId, XVtc_Signal *SignalCfgPtr )
{
	vres_timing_t VideoTiming;

	int HFrontPorch;
	int HSyncWidth;
	int HBackPorch;
	int VFrontPorch;
	int VSyncWidth;
	int VBackPorch;
	int LineWidth;
	int FrameHeight;

	vres_get_timing(ResolutionId, &VideoTiming);

	HFrontPorch = VideoTiming.HFrontPorch;
	HSyncWidth  = VideoTiming.HSyncWidth;
	HBackPorch  = VideoTiming.HBackPorch;
	VFrontPorch = VideoTiming.VFrontPorch;
	VSyncWidth  = VideoTiming.VSyncWidth;
	VBackPorch  = VideoTiming.VBackPorch;
	LineWidth   = VideoTiming.HActiveVideo;
	FrameHeight = VideoTiming.VActiveVideo;

	/* Clear the VTC Signal config structure */

	memset((void *)SignalCfgPtr, 0, sizeof(XVtc_Signal));

	/* Populate the VTC Signal config structure. Ignore the Field 1 */

	SignalCfgPtr->HFrontPorchStart = 0;
	SignalCfgPtr->HTotal = HFrontPorch + HSyncWidth + HBackPorch
				+ LineWidth - 1;
	SignalCfgPtr->HBackPorchStart = HFrontPorch + HSyncWidth;
	SignalCfgPtr->HSyncStart = HFrontPorch;
	SignalCfgPtr->HActiveStart = HFrontPorch + HSyncWidth + HBackPorch;

	SignalCfgPtr->V0FrontPorchStart = 0;
	SignalCfgPtr->V0Total = VFrontPorch + VSyncWidth + VBackPorch
				+ FrameHeight - 1;
	SignalCfgPtr->V0BackPorchStart = VFrontPorch + VSyncWidth;
	SignalCfgPtr->V0SyncStart = VFrontPorch;
	SignalCfgPtr->V0ChromaStart = VFrontPorch + VSyncWidth + VBackPorch;
	SignalCfgPtr->V0ActiveStart = VFrontPorch + VSyncWidth + VBackPorch;

	 return;
}

/*****************************************************************************/
/**
*
* vgen_init
* - initializes the VTC detector
*
* @param	VtcDeviceID is the device ID of the Video Timing Controller core.
*           pVtc is a pointer to a VTC instance

*
* @return	0 if all tests pass, 1 otherwise.
*
* @note		None.
*
******************************************************************************/
int vgen_init(XVtc *pVtc, u16 VtcDeviceID)
{
	int Status;
	XVtc_Config *VtcCfgPtr;

	Xuint32 Width;
	Xuint32 Height;
	int ResolutionId;

	/* Look for the device configuration info for the Video Timing
	 * Controller.
	 */
	VtcCfgPtr = XVtc_LookupConfig( VtcDeviceID );
	if (VtcCfgPtr == NULL) {
		return 1;
	}

	/* Initialize the Video Timing Controller instance */

	Status = XVtc_CfgInitialize(pVtc, VtcCfgPtr,
		VtcCfgPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return 1;
	}

	XVtc_DisableSync(pVtc);

	sleep(1);

	/* Enable the generator module */

	XVtc_Enable(pVtc, XVTC_EN_GENERATOR);
	XVtc_Enable(pVtc, XVTC_EN_DETECTOR);
//	XVtc_DisableSync(pVtc);
	return 0;
}


/*****************************************************************************/
/**
*
* vgen_config
* - configures the generator to generate missing syncs
*
* @param	pVtc is a pointer to an initialized VTC instance
*           ResolutionId identified a video resolution
*           vVerbose = 0 no verbose, 1 minimal verbose, 2 most verbose
*
* @return	0 if all tests pass, 1 otherwise.
*
* @note		None.
*
******************************************************************************/
int vgen_config(XVtc *pVtc, int ResolutionId, int bVerbose)
{
	int Status;

	XVtc_Signal Signal;		/* VTC Signal configuration */
	XVtc_Polarity Polarity;		/* Polarity configuration */
	XVtc_HoriOffsets HoriOffsets;  /* Horizontal offsets configuration */
	XVtc_SourceSelect SourceSelect;	/* Source Selection configuration */


    if ( bVerbose )
    {
		OS_PRINTF( "\tVideo Resolution = %s\n\r", vres_get_name(ResolutionId) );
	}

    /* Set up Polarity of all outputs */

	memset((void *)&Polarity, 0, sizeof(Polarity));
	Polarity.ActiveChromaPol = 1;
	Polarity.ActiveVideoPol = 1;
	Polarity.FieldIdPol = 0;
	Polarity.VBlankPol = 1;
	Polarity.VSyncPol = 1;
	Polarity.HBlankPol = 1;
	Polarity.HSyncPol = 1;

	XVtc_SetPolarity(pVtc, &Polarity);

	/* Set up Generator */

	memset((void *)&HoriOffsets, 0, sizeof(HoriOffsets));
//	HoriOffsets.V0BlankHoriEnd = 2198;
//	HoriOffsets.V0BlankHoriStart = 2008;
	HoriOffsets.V0BlankHoriEnd = 2199;
	HoriOffsets.V0BlankHoriStart = 1920;
	HoriOffsets.V0SyncHoriEnd = 1920;
	HoriOffsets.V0SyncHoriStart = 1920;

	XVtc_SetGeneratorHoriOffset(pVtc, &HoriOffsets);

	SignalSetup(pVtc,ResolutionId, &Signal);

	if ( bVerbose == 2 )
	{
		OS_PRINTF("\tVTC Generator Configuration\n\r" );
		OS_PRINTF("\t\tHorizontal Timing:\n\r" );
		OS_PRINTF("\t\t\tHFrontPorchStart %d\r\n", Signal.HFrontPorchStart);
		OS_PRINTF("\t\t\tHSyncStart %d\r\n", Signal.HSyncStart);
		OS_PRINTF("\t\t\tHBackPorchStart %d\r\n", Signal.HBackPorchStart);
		OS_PRINTF("\t\t\tHActiveStart = %d\r\n", Signal.HActiveStart);
		OS_PRINTF("\t\t\tHTotal = %d\r\n", Signal.HTotal);
		OS_PRINTF("\t\tVertical Timing:\n\r" );
		OS_PRINTF("\t\t\tV0FrontPorchStart %d\r\n", Signal.V0FrontPorchStart);
		OS_PRINTF("\t\t\tV0SyncStart %d\r\n", Signal.V0SyncStart);
		OS_PRINTF("\t\t\tV0BackPorchStart %d\r\n", Signal.V0BackPorchStart);
		OS_PRINTF("\t\t\tV0ActiveStart %d\r\n", Signal.V0ActiveStart);
		OS_PRINTF("\t\t\tV0Total %d\r\n", Signal.V0Total);
	}

	XVtc_SetGenerator(pVtc, &Signal);

	/* Set up source select */

	memset((void *)&SourceSelect, 0, sizeof(SourceSelect));
	SourceSelect.VChromaSrc = 0;
	SourceSelect.VActiveSrc = 1;
	SourceSelect.VBackPorchSrc = 1;
	SourceSelect.VSyncSrc = 1;
	SourceSelect.VFrontPorchSrc = 1;
	SourceSelect.VTotalSrc = 1;
	SourceSelect.HActiveSrc = 1;
	SourceSelect.HBackPorchSrc = 1;
	SourceSelect.HSyncSrc = 1;
	SourceSelect.HFrontPorchSrc = 1;
	SourceSelect.HTotalSrc = 1;

	XVtc_SetSource(pVtc, &SourceSelect);


	/* Return success */

	return 0;
}
