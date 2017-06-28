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
//                     Copyright(c) 2012 Avnet, Inc.
//                             All rights reserved.
//
//----------------------------------------------------------------
//
// Create Date:         Feb 11, 2012
// Design Name:         Video Image Processing Pipeline
// Module Name:         video_ipipe.h
// Project Name:        FMC-IMAGEON
// Target Devices:      Zynq-7000
// Avnet Boards:        FMC-IMAGEON
//
// Tool versions:       Vivado 2013.2
//
// Description:         Video Image Processing Pipeline using:
//                      - Defect Pixel Correction (DPC)
//                      - Color Filter Array Interpolation (CFA)
//                      - Image Statistics (STATS)
//                      - Image Enhancement (ENHANCE)
//                      - Color Correction (CCM)
//                      - Gamma Correction (GAMMA)
//
// Dependencies:
//
// Revision:            Feb 11, 2012: 1.00 Initial version
//                      Jul 20, 2012: 1.01 Update code for single CCM
//                      Dec 15, 2012: 1.03 Updated to use 14.4 cores
//                                         and Xilinx tools
//                      Aug 16, 2013: 1.04 Updated for new Image Enhancement core
//
//----------------------------------------------------------------

#ifndef __VIDEO_IPIPE_H__
#define __VIDEO_IPIPE_H__

#include "xparameters.h"

//#define AUTO_GAIN_BASED_ON_EXPOSURE_STATUS
#define AUTO_GAIN_BASED_ON_TARGET_LEVEL

//#if defined(STATS_DATA_WIDTH)
  #define CCM_DATA_WIDTH STATS_DATA_WIDTH
  #define GAMMA_DATA_WIDTH STATS_DATA_WIDTH
//#else
//  #define CCM_DATA_WIDTH 10
//  #define GAMMA_DATA_WIDTH 10
//#endif

#include "tpg.h"
#include "dpc.h"
#include "cfa.h"
#include "ccm.h"
#include "cresample.h"
#include "rgb2ycrcb.h"

#if defined(XPAR_STATS_0_BASEADDR)
#include "stats.h"
#include "video_ipipe_stats.h"
#endif
#if defined(XPAR_GAMMA_0_BASEADDR)
#include "gamma.h"
#endif
#if defined(XPAR_NOISE_0_BASEADDR)
#include "noise.h"
#endif
#if defined(XPAR_ENHANCE_0_BASEADDR)
#include "enhance.h"
#endif

#if defined(LINUX_CODE)
// for linux threads
#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#endif

#define COL_RED 0
#define COL_GRN 1
#define COL_BLU 2

#define ROFFSET_INIT 0x80
#define GOFFSET_INIT 0x80
#define BOFFSET_INIT 0x80
#define THRESHOLD_1_INIT 0x60
#define THRESHOLD_2_INIT 0x60
#define H_SOBEL_INIT 0
#define V_SOBEL_INIT 0
#define D_SOBEL_INIT 1
#define LAPLACE_INIT 1
#define NOISE_INIT 2
#define NOISE_ON_INIT 1
#define GAMMA_EQ_STR_INIT 0.5

#define NUM_OF_HIST_BINS 16
#define CC_HIST_ZOOM_FACTOR 4
#define SIZE_OF_BINS (NUM_OF_HIST_BINS / CC_HIST_ZOOM_FACTOR)


typedef struct {
	Xint32 k11;
	Xint32 k12;
	Xint32 k13;
	Xint32 k21;
	Xint32 k22;
	Xint32 k23;
	Xint32 k31;
	Xint32 k32;
	Xint32 k33;
	Xint32 rOffset;
	Xint32 gOffset;
	Xint32 bOffset;
} CCM_Coefficient;

extern CCM_Coefficient CCM_IDENTITY;

extern CCM_Coefficient CCM_PRE_MULT;
extern CCM_Coefficient CCM_RGB_BYPASS;
extern CCM_Coefficient CCM_RGB_DAY;
extern CCM_Coefficient CCM_RGB_CWF;
extern CCM_Coefficient CCM_RGB_U30;
extern CCM_Coefficient CCM_RGB_INC;

extern Xuint32 STATS_ZOOM2_DAY[256];
extern Xuint32 STATS_ZOOM2_CWF[256];
extern Xuint32 STATS_ZOOM2_U30[256];
extern Xuint32 STATS_ZOOM2_INC[256];

extern Xuint8 stats_readout_indexes[];
extern Xuint8 day_nonzero_indexes[];
extern Xuint8 cwf_nonzero_indexes[];
extern Xuint8 u30_nonzero_indexes[];
extern Xuint8 inc_nonzero_indexes[];

extern Xuint32 wb_mask[16][16];

extern unsigned char gamma_names[5][24];

// TODO : Need to abstract the image sensor out
//#include "fmc_imageon_vita_receiver.h"
//#include "fmc_imageon_demo.h"
//extern fmc_imageon_demo_t vita_demo;

// This structure contains the context for the video iPIPE
struct struct_video_ipipe_t
{
   // Image Processing Pipeline IP base addresses
   Xuint32 uBaseAddr_DPC;
   Xuint32 uBaseAddr_CFA;
   Xuint32 uBaseAddr_TPG0;
   Xuint32 uBaseAddr_TPG1;
   Xuint32 uBaseAddr_CRES;
   Xuint32 uBaseAddr_RGBYCC;
   Xuint32 uBaseAddr_STATS;
   Xuint32 uBaseAddr_CCM;
   Xuint32 uBaseAddr_ENHANCE;
   Xuint32 uBaseAddr_GAMMA;

   // Image Sensor Controls
   void *pSensor;
   int (*fpSensorGetGain)    ( void *pSensor, int *pGain );
   int (*fpSensorGetExposure)( void *pSensor, int *pExposure );
   int (*fpSensorStepGain)    ( void *pSensor, int step );
   int (*fpSensorStepExposure)( void *pSensor, int step );

   // Stats Handler
   Xuint32 auto_wb_en;
   Xuint32 auto_gain_en;
   Xuint32 gamma_eq_en;
   Xuint32 auto_exp_en;
   Xuint32 target_level;
   Xuint32 average_level;

   // Color Correction Selection
   Xuint32 ccm_select; // 0-4
   Xint32 ccm[12];

   // Contrast/Brightness/Saturation controls
   int contrast;
   int brightness;
   int saturation;
   int brightness_set;
   int contrast_set;
   int saturation_set;

   // Gamma controls
   float gamma_eq_str;

   // Defective Pixel Correction
   Xuint32  default_spc_age;

   // histogram controls
   int hist_scale; // 2^N
   float exp_factor_under;
   float exp_factor_over;

   // Stats Handler status
   //Xuint32 lum_data_valid;
   //Xuint32 cc_data_valid;
   //
   Xuint32 stats_handler_frame_cnt;
   Xuint32 stats_handler_awb_metric_day;
   Xuint32 stats_handler_awb_metric_cwf;
   Xuint32 stats_handler_awb_metric_u30;
   Xuint32 stats_handler_awb_metric_inc;
   Xuint32 stats_handler_luma_hist[STATS_HIST_DEPTH];
   Xuint32 stats_handler_rgb_hist[3][STATS_HIST_DEPTH];
   Xuint32 stats_handler_rgb_saturated[3];
   Xuint32 stats_handler_rgb_mean[3];
   Xuint32 stats_handler_chroma_hist[256];
   Xuint32 stats_handler_luma_metric_lo ;
   Xuint32 stats_handler_luma_metric_mid;
   Xuint32 stats_handler_luma_metric_hi ;
   Xuint32 stats_handler_exp_metric_over ;
   Xuint32 stats_handler_exp_metric_under;
   Xint32 stats_handler_aec_adjust_lpf;
   Xint32 stats_handler_aec_adjust_inc;
   Xint32 stats_handler_agc_adjust_lpf;
   Xint32 stats_handler_agc_adjust_inc;

   Xuint32 bVerbose;

   Xuint32 stats_handler_active;
   Xuint32 stats_handler_stop;
#if defined(LINUX_CODE)
   pthread_t stats_handler_thread;
   int stats_handler_thread_id;
   pthread_mutex_t stats_handler_mutex;
#endif
};
typedef struct struct_video_ipipe_t video_ipipe_t;

/*
 * Function prototypes
 */
int vipp_init( video_ipipe_t *pContext );
int vipp_quit( video_ipipe_t *pContext );

Xint32 vipp_bayer( video_ipipe_t *pContext, Xuint32 phase);
void vipp_cfa_status( video_ipipe_t *pContext );
void vipp_dpc_status( video_ipipe_t *pContext );
void vipp_dpc_config( video_ipipe_t *pContext,
		            Xuint32 enable,
                    Xuint32 thresh_temporal_var,
                    Xuint32 thresh_spatial_var,
                    Xuint32 thres_pixel_age
                    );
void vipp_dpc_pixel_age( video_ipipe_t *pContext, Xuint32 pixel_age);
void vipp_dpc_spatial_var( video_ipipe_t *pContext, Xuint32 spatial_var);
void vipp_dpc_temporal_var( video_ipipe_t *pContext, Xuint32 temporal_var);
void vipp_ccm_getCoefficients( video_ipipe_t *pContext, CCM_Coefficient* coefficientPtr);
void vipp_ccm_setCoefficients( video_ipipe_t *pContext, CCM_Coefficient* coefficientPtr);

#if defined(XPAR_GAMMA_0_BASEADDR)
Xuint16 vipp_gamma_table_value( video_ipipe_t *pContext, int TABLE_ID, int addr);
int vipp_download_gamma_table( video_ipipe_t *pContext, int GAMMA_TABLE_ID, int LUTS);
#endif
#if defined(XPAR_ENHANCE_0_BASEADDR)
void vipp_noise( video_ipipe_t *pContext, Xuint32 noise);
void vipp_enhance( video_ipipe_t *pContext, Xuint32 enhance);
void vipp_halo( video_ipipe_t *pContext, Xuint32 halo);
#endif

void vipp_interrupt_init( video_ipipe_t *pContext );

#define float_decimal(val) \
	((Xuint32) (((val) - ((Xuint32) (val))) * 100))
Xuint32 luminance_min( video_ipipe_t *pContext, Xuint32 y_hist[]);
Xuint32 luminance_max( video_ipipe_t *pContext, Xuint32 y_hist[]);
void calc_cc_means( video_ipipe_t *pContext, Xuint32 cc_hist[], Xuint32* mean_cb, Xuint32* mean_cr);

void set_contrast( video_ipipe_t *pContext, Xint32 ccm[]);
void set_brightness( video_ipipe_t *pContext, Xint32 ccm[]);
void set_saturation( video_ipipe_t *pContext, Xint32 ccm[]);
void auto_white_balance( video_ipipe_t *pContext );
void adjust_exposure( video_ipipe_t *pContext, Xint32 difference);
void adjust_gain( video_ipipe_t *pContext, Xint32 difference);
void auto_gain_exposure( video_ipipe_t *pContext );
void gamma_equalization( video_ipipe_t *pContext );

void *vipp_stats_handler(void* p);

#endif // __VIDEO_IPIPE_H__
