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
// Design Name:         ZVIK Camera Demo
// Module Name:         fmc_imageon_demo.h
// Project Name:        ZVIK Camera Demo
// Target Devices:      Zynq-7000 SoC
// Hardware Boards:     ZC702 + FMC-IMAGEON
//
// Tool versions:       ISE 14.4
//
// Description:         FMC-IMAGEON Getting Started Demo
//                      This application will configure the FMC-IMAGEON module
//                      - HDMI Output
//                         - 1920x1080 resolution
//                         - ADV7511 configured for 16 bit YCbCr 4:2:2 mode
//                           with embedded syncs
//                      - VITA Input
//                         - 1920x1080 resolution
//
// Dependencies:
//
// Revision:            Nov 15, 2011: 1.00 Initial version
//                      Sep 17, 2012: 1.02 Remove video multiplexers
//                                         Fix gamma equalization
//                      Dec 15, 2012: 1.03 Updated to use 14.4 cores
//                                         and Xilinx tools
//
//----------------------------------------------------------------

#ifndef __FMC_IMAGEON_DEMO_H__
#define __FMC_IMAGEON_DEMO_H__

/*
 * Device related constants. Defined in xparameters.h.
 */
#include "xparameters.h"
#define VTC_ID                       XPAR_V_TC_1_DEVICE_ID
//#define VTC_VITA_DETECTOR_ID       XPAR_AXI_VTC_0_DEVICE_ID
//#define VTC_IPIPE_DETECTOR_ID      XPAR_AXI_VTC_1_DEVICE_ID
//#define VTC_HDMIO_GENERATOR_ID     XPAR_TPG_0_VTC_DEVICE_ID

//#define VDMA_MEM_BASE_ADDR        (XPAR_DDR_MEM_BASEADDR + 0x34000000)
//#define VDMA_MEM_HIGH_ADDR         XPAR_DDR_MEM_HIGHADDR
//#define VDMA_MEM_SPACE            (VDMA_MEM_HIGH_ADDR - VDMA_MEM_BASE_ADDR)

#define VDMA_VITA_DEVICE_ID        XPAR_AXI_VDMA_0_DEVICE_ID
#define VDMA_VITA_BASE_ADDR        XPAR_AXI_VDMA_0_BASEADDR
#define VDMA_VITA_READ_NUM_FRAMES  XPAR_AXI_VDMA_0_NUM_FSTORES
#define VDMA_VITA_WRITE_NUM_FRAMES XPAR_AXI_VDMA_0_NUM_FSTORES
#define VDMA_VITA_MEM_BASE_ADDR    0x30000000

// ZC702 IIC Specific definitions
#define ZC702_ADV7511_ADDR   0x72

#define ZC702_IIC_MUX_ADDR   0xE8
#define USRCLK   0x01
#define HDMI     0x02
#define EEPROM   0x04
#define USRCLK2  0x08
#define RTC      0x10
#define FMC1     0x20
#define FMC2     0x40
#define PMBUS    0x80

//
#include "fmc_iic.h"
#include "fmc_ipmi.h"
#include "fmc_imageon.h"
#include "fmc_imageon_vita_receiver.h"

#include "video_resolution.h"
#include "video_detector.h"
#include "video_generator.h"
#include "video_frame_buffer.h"
#include "video_ipipe.h"

#include "xvtc.h"
#include "xaxivdma.h"

// This structure contains the context for the VITA-2000 frame buffer design
struct struct_fmc_imageon_demo_t
{
   // IP base addresses
   Xuint32 uBaseAddr_IIC_FmcIpmi;
   Xuint32 uBaseAddr_IIC_FmcImageon;
   Xuint32 uBaseAddr_IIC_DviOut;
   Xuint32 uBaseAddr_IIC_HdmiOut;
   Xuint32 uBaseAddr_VITA_Receiver;
   Xuint32 uBaseAddr_VTC_VitaDetector;
   Xuint32 uBaseAddr_VTC_iPipeDetector;
   Xuint32 uBaseAddr_VTC_HdmioGenerator;

   // Frame Buffer memory addresses
   Xuint32 uBaseAddr_VDMA_VitaFrameBuffer;
   Xuint32 uBaseAddr_MEM_VitaFrameBuffer;

   fmc_iic_t fmc_ipmi_iic;
   fmc_iic_t fmc_imageon_iic;
   fmc_iic_t dvi_out_iic;
   fmc_iic_t hdmi_out_iic;

   fmc_imageon_t fmc_imageon;
   fmc_imageon_vita_receiver_t vita_receiver;
   fmc_imageon_vita_status_t vita_status_t1;
   fmc_imageon_vita_status_t vita_status_t2;
   video_ipipe_t vipp;

   XVtc vtc_hdmio_generator;
   XVtc vtc_vita_detector;
   XVtc vtc_hdmii_detector;
   XVtc vtc_ipipe_detector;
   XAxiVdma vdma_vita;

   Xuint32 vita_aec;
   Xuint32 vita_again;
   Xuint32 vita_dgain;
   Xuint32 vita_exposure;

   Xuint32 bVITAInitialized;
   Xuint32 bIPIPEInitialized;

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
typedef struct struct_fmc_imageon_demo_t fmc_imageon_demo_t;

int fmc_imageon_demo_init( fmc_imageon_demo_t *pDemo );
int fmc_imageon_demo_quit( fmc_imageon_demo_t *pDemo );

int fmc_imageon_demo_enable_hdmio( fmc_imageon_demo_t *pDemo );
int fmc_imageon_demo_enable_vita( fmc_imageon_demo_t *pDemo );
int fmc_imageon_demo_enable_ipipe( fmc_imageon_demo_t *pDemo );

// Image Sensor Controls
int fmc_imageon_demo_sensor_get_gain( fmc_imageon_demo_t *pDemo, int *pGain );
int fmc_imageon_demo_sensor_get_exposure( fmc_imageon_demo_t *pDemo, int *pExposure );
int fmc_imageon_demo_sensor_step_gain( fmc_imageon_demo_t *pDemo, int step );
int fmc_imageon_demo_sensor_step_exposure( fmc_imageon_demo_t *pDemo, int step );

#endif // __FMC_IMAGEON_DEMO_H__
