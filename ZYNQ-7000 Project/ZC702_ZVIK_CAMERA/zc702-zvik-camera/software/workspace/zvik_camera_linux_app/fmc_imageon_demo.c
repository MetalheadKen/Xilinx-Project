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
// Module Name:         fmc_imageon_demo.c
// Project Name:        ZVIK Camera Demo
// Target Devices:      Zynq-7000 SoC
// Hardware Boards:     ZC702 + FMC-IMAGEON
//
// Tool versions:       ISE 14.4
//
// Description:         FMC-IMAGEON VITA Frame Buffer Demo
//                      This application will configure the FMC-IMAGEON module
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

#include "fmc_imageon_demo.h"
#include "os.h"

Xuint8 fmc_imageon_hdmii_edid_content[256] =
{
		0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
		0x06, 0x8F, 0x07, 0x11, 0x01, 0x00, 0x00, 0x00,
		0x17, 0x11, 0x01, 0x03, 0x80, 0x0C, 0x09, 0x78,
		0x0A, 0x1E, 0xAC, 0x98, 0x59, 0x56, 0x85, 0x28,
		0x29, 0x52, 0x57, 0x00, 0x00, 0x00, 0x01, 0x01,
		0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
		0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x8C, 0x0A,
		0xD0, 0x8A, 0x20, 0xE0, 0x2D, 0x10, 0x10, 0x3E,
		0x96, 0x00, 0x81, 0x60, 0x00, 0x00, 0x00, 0x18,
		0x01, 0x1D, 0x80, 0x18, 0x71, 0x1C, 0x16, 0x20,
		0x58, 0x2C, 0x25, 0x00, 0x81, 0x49, 0x00, 0x00,
		0x00, 0x9E, 0x00, 0x00, 0x00, 0xFC, 0x00, 0x56,
		0x41, 0x2D, 0x31, 0x38, 0x30, 0x39, 0x41, 0x0A,
		0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xFD,
		0x00, 0x17, 0x3D, 0x0D, 0x2E, 0x11, 0x00, 0x0A,
		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x01, 0x1C,
		0x02, 0x03, 0x34, 0x71, 0x4D, 0x82, 0x05, 0x04,
		0x01, 0x10, 0x11, 0x14, 0x13, 0x1F, 0x06, 0x15,
		0x03, 0x12, 0x35, 0x0F, 0x7F, 0x07, 0x17, 0x1F,
		0x38, 0x1F, 0x07, 0x30, 0x2F, 0x07, 0x72, 0x3F,
		0x7F, 0x72, 0x57, 0x7F, 0x00, 0x37, 0x7F, 0x72,
		0x83, 0x4F, 0x00, 0x00, 0x67, 0x03, 0x0C, 0x00,
		0x10, 0x00, 0x88, 0x2D, 0x00, 0x00, 0x00, 0xFF,
		0x00, 0x0A, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00, 0x00,
		0x00, 0xFF, 0x00, 0x0A, 0x20, 0x20, 0x20, 0x20,
		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
		0x00, 0x00, 0x00, 0xFF, 0x00, 0x0A, 0x20, 0x20,
		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
		0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDA
};


/*
 * The following parameters are set to convert YCrCb 4:2:2 video input
 * to RGB 4:4:4 video output. CSC coefficients (registers 0x18 - 0x2F)
 * are taken from tables 40/57 of the ADV7511 programmer's guide i.e.
 * converting HDTV YCrCb (16 to 235 or limited range) to
 * RGB (0 to 255 or full range).
 */

#define ZC702_HDMI_OUT_CONFIG_LEN  (40)
Xuint8 zc702_hdmi_out_config[ZC702_HDMI_OUT_CONFIG_LEN][3] =
{
	{ZC702_ADV7511_ADDR>>1, 0x15, 0x01}, // Input YCbCr 4:2:2 with seperate syncs
#if 0
	{ZC702_ADV7511_ADDR>>1, 0x16, 0x39}, // Output format 444, Input Color Depth = 8
                                         //    R0x16[  7] = Output Video Format = 0 (444)
                                         //    R0x16[5:4] = Input Video Color Depth = 11 (8 bits/color)
                                         //    R0x16[3:2] = Input Video Style = 10 (style 1)
                                         //    R0x16[  1] = DDR Input Edge = 0 (falling edge)
                                         //    R0x16[  0] = Output Color Space = 1 (YCbCr)
#else
	{ZC702_ADV7511_ADDR>>1, 0x16, 0x38}, // Output format 444, Input Color Depth = 8
                                         //    R0x16[  7] = Output Video Format = 0 (444)
                                         //    R0x16[5:4] = Input Video Color Depth = 11 (8 bits/color)
                                         //    R0x16[3:2] = Input Video Style = 10 (style 1)
                                         //    R0x16[  1] = DDR Input Edge = 0 (falling edge)
                                         //    R0x16[  0] = Output Color Space = 0 (RGB)
#endif
#if 0
    // HDTV YCbCr (16to235) to RGB (0to255)
	{ZC702_ADV7511_ADDR>>1, 0x18, 0xE7}, // Color Space Conversion
                                         //    R0x18[  7] = CSC enable = 1 (CSC enabled)
                                         //    R0x18[6:5] = CSC Scaling Factor = 11 (+/- 4.0, -16384 - 16380)
                                         //    R0x18[4:0] = CSC coefficient A1[12:8] = 00111
	{ZC702_ADV7511_ADDR>>1, 0x19, 0x34}, //    R0x19[7:0] = CSC coefficient A1[ 7:0] =      00110100
	{ZC702_ADV7511_ADDR>>1, 0x1A, 0x04}, //    R0x1A[  5] = CSC coefficient update
                                         //    R0x1A[4:0] = CSC coefficient A2[12:8] = 00100
	{ZC702_ADV7511_ADDR>>1, 0x1B, 0xAD}, //    R0x1B[7:0] = CSC coefficient A2[ 7:0] =      10101101
	{ZC702_ADV7511_ADDR>>1, 0x1C, 0x00}, //    R0x1C[4:0] = CSC coefficient A3[12:8] = 00000
	{ZC702_ADV7511_ADDR>>1, 0x1D, 0x00}, //    R0x1D[7:0] = CSC coefficient A3[ 7:0] =      00000000
	{ZC702_ADV7511_ADDR>>1, 0x1E, 0x1C}, //    R0x1E[4:0] = CSC coefficient A4[12:8] = 11100
	{ZC702_ADV7511_ADDR>>1, 0x1F, 0x1B}, //    R0x1F[7:0] = CSC coefficient A4[ 7:0] =      00011011
	{ZC702_ADV7511_ADDR>>1, 0x20, 0x1D}, //    R0x20[4:0] = CSC coefficient B1[12:8] = 11101
	{ZC702_ADV7511_ADDR>>1, 0x21, 0xDC}, //    R0x21[7:0] = CSC coefficient B1[ 7:0] =      11011100
	{ZC702_ADV7511_ADDR>>1, 0x22, 0x04}, //    R0x22[4:0] = CSC coefficient B2[12:8] = 00100
	{ZC702_ADV7511_ADDR>>1, 0x23, 0xAD}, //    R0x23[7:0] = CSC coefficient B2[ 7:0] =      10101101
	{ZC702_ADV7511_ADDR>>1, 0x24, 0x1F}, //    R0x24[4:0] = CSC coefficient B3[12:8] = 11111
	{ZC702_ADV7511_ADDR>>1, 0x25, 0x24}, //    R0x25[7:0] = CSC coefficient B3[ 7:0] =      00100100
	{ZC702_ADV7511_ADDR>>1, 0x26, 0x01}, //    R0x26[4:0] = CSC coefficient B4[12:8] = 00001
	{ZC702_ADV7511_ADDR>>1, 0x27, 0x35}, //    R0x27[7:0] = CSC coefficient B4[ 7:0] =      00110101
	{ZC702_ADV7511_ADDR>>1, 0x28, 0x00}, //    R0x28[4:0] = CSC coefficient C1[12:8] = 00000
	{ZC702_ADV7511_ADDR>>1, 0x29, 0x00}, //    R0x29[7:0] = CSC coefficient C1[ 7:0] =      00000000
	{ZC702_ADV7511_ADDR>>1, 0x2A, 0x04}, //    R0x2A[4:0] = CSC coefficient C2[12:8] = 00100
	{ZC702_ADV7511_ADDR>>1, 0x2B, 0xAD}, //    R0x2B[7:0] = CSC coefficient C2[ 7:0] =      10101101
	{ZC702_ADV7511_ADDR>>1, 0x2C, 0x08}, //    R0x2C[4:0] = CSC coefficient C3[12:8] = 01000
	{ZC702_ADV7511_ADDR>>1, 0x2D, 0x7C}, //    R0x2D[7:0] = CSC coefficient C3[ 7:0] =      01111100
	{ZC702_ADV7511_ADDR>>1, 0x2E, 0x1B}, //    R0x2E[4:0] = CSC coefficient C4[12:8] = 11011
	{ZC702_ADV7511_ADDR>>1, 0x2F, 0x77}, //    R0x2F[7:0] = CSC coefficient C4[ 7:0] =      01110111
#else
	// HDTV YCbCr (16to235) to RGB (16to235)
	{ZC702_ADV7511_ADDR>>1, 0x18, 0xAC},
	{ZC702_ADV7511_ADDR>>1, 0x19, 0x53},
	{ZC702_ADV7511_ADDR>>1, 0x1A, 0x08},
	{ZC702_ADV7511_ADDR>>1, 0x1B, 0x00},
	{ZC702_ADV7511_ADDR>>1, 0x1C, 0x00},
	{ZC702_ADV7511_ADDR>>1, 0x1D, 0x00},
	{ZC702_ADV7511_ADDR>>1, 0x1E, 0x19},
	{ZC702_ADV7511_ADDR>>1, 0x1F, 0xD6},
	{ZC702_ADV7511_ADDR>>1, 0x20, 0x1C},
	{ZC702_ADV7511_ADDR>>1, 0x21, 0x56},
	{ZC702_ADV7511_ADDR>>1, 0x22, 0x08},
	{ZC702_ADV7511_ADDR>>1, 0x23, 0x00},
	{ZC702_ADV7511_ADDR>>1, 0x24, 0x1E},
	{ZC702_ADV7511_ADDR>>1, 0x25, 0x88},
	{ZC702_ADV7511_ADDR>>1, 0x26, 0x02},
	{ZC702_ADV7511_ADDR>>1, 0x27, 0x91},
	{ZC702_ADV7511_ADDR>>1, 0x28, 0x1F},
	{ZC702_ADV7511_ADDR>>1, 0x29, 0xFF},
	{ZC702_ADV7511_ADDR>>1, 0x2A, 0x08},
	{ZC702_ADV7511_ADDR>>1, 0x2B, 0x00},
	{ZC702_ADV7511_ADDR>>1, 0x2C, 0x0E},
	{ZC702_ADV7511_ADDR>>1, 0x2D, 0x85},
	{ZC702_ADV7511_ADDR>>1, 0x2E, 0x18},
	{ZC702_ADV7511_ADDR>>1, 0x2F, 0xBE},
#endif
	{ZC702_ADV7511_ADDR>>1, 0x41, 0x10}, // Power down control
                                         //    R0x41[  6] = PowerDown = 0 (power-up)
	{ZC702_ADV7511_ADDR>>1, 0x48, 0x08}, // Video Input Justification
                                         //    R0x48[8:7] = Video Input Justification = 01 (right justified)
	{ZC702_ADV7511_ADDR>>1, 0x55, 0x00}, // Set RGB in AVinfo Frame
                                         //    R0x55[6:5] = Output Format = 00 (RGB)
	{ZC702_ADV7511_ADDR>>1, 0x56, 0x28}, // Aspect Ratio
                                         //    R0x56[5:4] = Picture Aspect Ratio = 10 (16:9)
                                         //    R0x56[3:0] = Active Format Aspect Ratio = 1000 (Same as Aspect Ratio)
	{ZC702_ADV7511_ADDR>>1, 0x98, 0x03}, // ADI Recommended Write
	{ZC702_ADV7511_ADDR>>1, 0x9A, 0xE0}, // ADI Recommended Write
	{ZC702_ADV7511_ADDR>>1, 0x9C, 0x30}, // PLL Filter R1 Value
	{ZC702_ADV7511_ADDR>>1, 0x9D, 0x61}, // Set clock divide
	{ZC702_ADV7511_ADDR>>1, 0xA2, 0xA4}, // ADI Recommended Write
	{ZC702_ADV7511_ADDR>>1, 0xA3, 0xA4}, // ADI Recommended Write
	{ZC702_ADV7511_ADDR>>1, 0xAF, 0x04}, // HDMI/DVI Modes
                                         //    R0xAF[  7] = HDCP Enable = 0 (HDCP disabled)
                                         //    R0xAF[  4] = Frame Encryption = 0 (Current frame NOT HDCP encrypted)
                                         //    R0xAF[3:2] = 01 (fixed)
                                         //    R0xAF[  1] = HDMI/DVI Mode Select = 0 (DVI Mode)
    //{ZC702_ADV7511_ADDR>>1, 0xBA, 0x00}, // Programmable delay for input video clock = 000 = -1.2ns
	{ZC702_ADV7511_ADDR>>1, 0xBA, 0x60}, // Programmable delay for input video clock = 011 = no delay
	{ZC702_ADV7511_ADDR>>1, 0xE0, 0xD0}, // Must be set to 0xD0 for proper operation
	{ZC702_ADV7511_ADDR>>1, 0xF9, 0x00}  // Fixed I2C Address (This should be set to a non-conflicting I2C address)
};


void disable_vita_xsvi2axi( fmc_imageon_demo_t *pDemo );
void enable_vita_xsvi2axi( fmc_imageon_demo_t *pDemo );
void disable_hdmii_xsvi2axi( fmc_imageon_demo_t *pDemo );
void enable_hdmii_xsvi2axi( fmc_imageon_demo_t *pDemo );
void reset_dcms( fmc_imageon_demo_t *pDemo );

int fmc_imageon_demo_init( fmc_imageon_demo_t *pDemo )
{
   int ret;

   OS_PRINTF("\n\r");
   OS_PRINTF("------------------------------------------------------\n\r");
   OS_PRINTF("--    Xilinx Zynq-7000 EPP Video and Imaging Kit    --\n\r");
   OS_PRINTF("--      1080P60 Real-Time Camera Demonstration      --\n\r");
   OS_PRINTF("------------------------------------------------------\n\r");
   OS_PRINTF("\n\r");

   pDemo->bVITAInitialized = 0;
   pDemo->bIPIPEInitialized = 0;

   pDemo->bVerbose = 0;
   pDemo->hdmii_locked = 0;

   pDemo->vita_aec = 0; // off
   pDemo->vita_again = 0; // 1.0
   pDemo->vita_dgain = 128; // 1.0
   pDemo->vita_exposure = 90; // 90% of frame period

   OS_PRINTF( "FMC-IPMI Initialization ...\n\r" );

   ret = fmc_iic_axi_init(&(pDemo->fmc_ipmi_iic),"FMC-IPMI I2C Controller", pDemo->uBaseAddr_IIC_FmcIpmi );
   if ( !ret )
   {
      OS_PRINTF( "ERROR : Failed to open FMC-IIC driver\n\r" );
      return -1;
   }

#if defined(XPAR_IIC_MAIN_BASEADDR) // if ZC702 design
   // Configure ZC702 IIC Mux for Port 6 (FMC2)
   OS_PRINTF( "Configure ZC702 IIC Mux for Port 6 (FMC2) ...\n\r" );
   {
      Xuint8 mux_addr = ZC702_IIC_MUX_ADDR;
      Xuint8 mux_data = FMC2;
      pDemo->fmc_ipmi_iic.fpIicWrite( &(pDemo->fmc_ipmi_iic), (mux_addr>>1), mux_data, &mux_data, 1);
   }
#endif

#if 1  // if ZC702 design
   // FMC Module Validation
   if ( fmc_ipmi_detect( &(pDemo->fmc_ipmi_iic), "FMC-IMAGEON", FMC_ID_SLOT1 ) )
   {
      fmc_ipmi_enable( &(pDemo->fmc_ipmi_iic), FMC_ID_SLOT1 );
   }
   else
   {
      char inchar;
      OS_PRINTF( "... press the 'y' key to continue anyway ...\n\r" );
      inchar = OS_GETCHAR();
      if ( inchar = 'y' )
      {
         fmc_ipmi_enable( &(pDemo->fmc_ipmi_iic), FMC_ID_SLOT1 );
      }
      else
      {
         OS_PRINTF( "Exiting ...\n\r" );
          fmc_ipmi_disable( &(pDemo->fmc_ipmi_iic), FMC_ID_SLOT1 );
          exit(0);
      }
   }
#else
   OS_PRINTF( "Skipping FMC Module Identification ...\n\r");
   fmc_ipmi_enable( &(pDemo->fmc_ipmi_iic), FMC_ID_SLOT1 );
   OS_PRINTF( "Done!\n\r");
#endif

   OS_PRINTF( "FMC-IMAGEON Initialization ...\n\r" );

   ret = fmc_iic_axi_init(&(pDemo->fmc_imageon_iic),"FMC-IMAGEON I2C Controller", pDemo->uBaseAddr_IIC_FmcImageon );
   if ( !ret )
   {
      OS_PRINTF( "ERROR : Failed to open FMC-IIC driver\n\r" );
      return -1;
   }


   fmc_imageon_init(&(pDemo->fmc_imageon), "FMC-IMAGEON", &(pDemo->fmc_imageon_iic));

   // Init VCLK
   OS_PRINTF( "FMC-IMAGEON Video Clock Initialization ...\n\r" );
   fmc_imageon_vclk_init( &(pDemo->fmc_imageon) );
   fmc_imageon_vclk_config( &(pDemo->fmc_imageon), FMC_IMAGEON_VCLK_FREQ_148_500_000);
   //
   reset_dcms(pDemo);

   //OS_PRINTF( "Video Timing Controllers Initialization ...\n\r" );
   //vgen_init( &(pDemo->vtc_hdmio_generator), VTC_HDMIO_GENERATOR_ID );
   //vdet_init( &(pDemo->vtc_vita_detector  ), VTC_VITA_DETECTOR_ID );
   //vdet_init( &(pDemo->vtc_hdmii_detector ), VTC_HDMII_DETECTOR_ID );

   //OS_PRINTF( "FMC-IMAGEON HDMI Input Initialization ...\n\r" );
   //ret = fmc_imageon_hdmii_init( &(pDemo->fmc_imageon),
   //                              1, // hdmiiEnable = 1
   //                              1, // editInit = 1
   //                              fmc_imageon_hdmii_edid_content
   //                              );
   //if ( !ret )
   //{
   //   OS_PRINTF( "ERROR : Failed to init HDMI Input Interface\n\r" );
   //   return -1;
   //}

   // Initialize Video Output
   OS_PRINTF( "Initialize Video Output for 1080P60 ...\n\r" );
   {
      pDemo->hdmio_width  = 1920;
      pDemo->hdmio_height = 1080;

      //pDemo->hdmio_timing.IsHDMI        = 1; // HDMI Mode
      pDemo->hdmio_timing.IsHDMI        = 0; // DVI Mode
      pDemo->hdmio_timing.IsEncrypted   = 0;
      pDemo->hdmio_timing.IsInterlaced  = 0;
      pDemo->hdmio_timing.ColorDepth    = 8;

      pDemo->hdmio_timing.HActiveVideo  = 1920;
      pDemo->hdmio_timing.HFrontPorch   =   88;
      pDemo->hdmio_timing.HSyncWidth    =   44;
      pDemo->hdmio_timing.HSyncPolarity =    1;
      pDemo->hdmio_timing.HBackPorch    =  148;

      pDemo->hdmio_timing.VActiveVideo  = 1080;
      pDemo->hdmio_timing.VFrontPorch   =    4;
      pDemo->hdmio_timing.VSyncWidth    =    5;
      pDemo->hdmio_timing.VSyncPolarity =    1;
      pDemo->hdmio_timing.VBackPorch    =   36;

      if ( pDemo->bVerbose )
      {
         OS_PRINTF( "ADV7511 Video Output Information\n\r" );
         //OS_PRINTF( "\tVideo Output     = %s", hdmio_timing.IsHDMI ? "HDMI" : "DVI" );
         //OS_PRINTF( "%s", hdmio_timing.IsEncrypted ? ", HDCP Encrypted" : "" );
         //OS_PRINTF( ", %s\n\r", hdmio_timing.IsInterlaced ? "Interlaced" : "Progressive" );
         //OS_PRINTF( "\tColor Depth      = %d bits per channel\n\r", hdmio_timing.ColorDepth );
         OS_PRINTF( "\tHSYNC Timing     = hav=%04d, hfp=%02d, hsw=%02d(hsp=%d), hbp=%03d\n\r",
              pDemo->hdmio_timing.HActiveVideo,
              pDemo->hdmio_timing.HFrontPorch,
              pDemo->hdmio_timing.HSyncWidth, pDemo->hdmio_timing.HSyncPolarity,
              pDemo->hdmio_timing.HBackPorch
    		  );
         OS_PRINTF( "\tVSYNC Timing     = vav=%04d, vfp=%02d, vsw=%02d(vsp=%d), vbp=%03d\n\r",
    		  pDemo->hdmio_timing.VActiveVideo,
    		  pDemo->hdmio_timing.VFrontPorch,
    		  pDemo->hdmio_timing.VSyncWidth, pDemo->hdmio_timing.VSyncPolarity,
    		  pDemo->hdmio_timing.VBackPorch
    		  );
         OS_PRINTF( "\tVideo Dimensions = %d x %d\n\r", pDemo->hdmio_width, pDemo->hdmio_height );
      }

      pDemo->hdmio_resolution = vres_detect( pDemo->hdmio_width, pDemo->hdmio_height );
      OS_PRINTF( "\tVideo Resolution = %s\n\r", vres_get_name(pDemo->hdmio_resolution) );

      OS_PRINTF( "Video Generator Configuration ...\n\r" );

      vgen_init( &(pDemo->vtc_vita_detector), VTC_ID );
      //vgen_config( &(pDemo->vtc_vita_detector), pDemo->hdmio_resolution, 2 );

      //OS_PRINTF( "FMC-IMAGEON HDMI Output Initialization ...\n\r" );
      //ret = fmc_imageon_hdmio_init( &(pDemo->fmc_imageon),
      //                              1,                      // hdmioEnable = 1
      //                              &(pDemo->hdmio_timing), // pTiming
      //                              0                       // waitHPD = 0
      //                              );
      //if ( !ret )
      //{
      //   OS_PRINTF( "ERROR : Failed to init FMC-IMAGEON HDMI Output Interface\n\r" );
      //   exit(0);
      //}

#if defined(XPAR_IIC_MAIN_BASEADDR) // if ZC702 design
   // Configure ZC702 IIC Mux for Port 1 (HDMI)
   OS_PRINTF( "Configure ZC702 IIC Mux for Port 1 (HDMI) ...\n\r" );
   {
      Xuint8 mux_addr = ZC702_IIC_MUX_ADDR;
      Xuint8 mux_data = HDMI;
      pDemo->fmc_ipmi_iic.fpIicWrite( &(pDemo->fmc_ipmi_iic), (mux_addr>>1), mux_data, &mux_data, 1);
   }

   OS_PRINTF( "ZC702 HDMI Output Initialization ...\n\r" );
   {
      Xuint8 num_bytes;
      int i;

      for ( i = 0; i < ZC702_HDMI_OUT_CONFIG_LEN; i++ )
      {
     	 //OS_PRINTF( "[ZC702 HDMI] IIC Write - Device = 0x%02X, Address = 0x%02X, Data = 0x%02X\n\r", zc702_hdmi_out_config[i][0]<<1, zc702_hdmi_out_config[i][1], zc702_hdmi_out_config[i][2] );
         num_bytes = pDemo->fmc_ipmi_iic.fpIicWrite( &(pDemo->fmc_ipmi_iic), zc702_hdmi_out_config[i][0], zc702_hdmi_out_config[i][1], &(zc702_hdmi_out_config[i][2]), 1 );
      }
   }
#endif

#if defined(XPAR_IIC_HDMI_O_BASEADDR) // if ZedBoard design
      OS_PRINTF( "ZedBoard HDMI Output Initialization ...\n\r" );

      ret = fmc_iic_axi_init(&(pDemo->hdmi_out_iic),"ZC702 HDMI I2C Controller", pDemo->uBaseAddr_IIC_HdmiOut );
      if ( !ret )
      {
         OS_PRINTF( "ERROR : Failed to open FMC-IIC driver\n\r" );
         return -1;
      }


      {
         Xuint8 num_bytes;
         int i;

         for ( i = 0; i < ZC702_HDMI_OUT_CONFIG_LEN; i++ )
         {
        	//OS_PRINTF( "[ZC702 HDMI] IIC Write - Device = 0x%02X, Address = 0x%02X, Data = 0x%02X\n\r", zc702_hdmi_out_config[i][0]<<1, zc702_hdmi_out_config[i][1], zc702_hdmi_out_config[i][2] );
            num_bytes = pDemo->hdmi_out_iic.fpIicWrite( &(pDemo->hdmi_out_iic), zc702_hdmi_out_config[i][0], zc702_hdmi_out_config[i][1], &(zc702_hdmi_out_config[i][2]), 1 );
         }
      }
#endif

   }

   // FMC-IMAGEON VITA Receiver Initialization
   OS_PRINTF( "FMC-IMAGEON VITA Receiver Initialization ...\n\r" );
   fmc_imageon_vita_receiver_init( &(pDemo->vita_receiver), "VITA-2000", pDemo->uBaseAddr_VITA_Receiver );
   //OS_PRINTF( "FMC-IMAGEON VITA SPI Config for 10MHz (%d) ...\n\r", (XPAR_PROC_BUS_0_FREQ_HZ/10000000) );
   //fmc_imageon_vita_receiver_spi_config( &(pDemo->vita_receiver), (XPAR_PROC_BUS_0_FREQ_HZ/10000000) );
   fmc_imageon_vita_receiver_spi_config( &(pDemo->vita_receiver), (100000000/10000000) );


   // Initialize the Video Sources
   fmc_imageon_demo_enable_vita( pDemo );
   fmc_imageon_demo_enable_ipipe( pDemo );

   // Initialize FMC module's HDMI Output
   fmc_imageon_demo_enable_hdmio( pDemo );

   return 0;
}

int fmc_imageon_demo_quit( fmc_imageon_demo_t *pDemo )
{
   if ( pDemo->bIPIPEInitialized == 1 )
   {
      OS_PRINTF("Image Processing Pipeline (iPIPE) Shutdown ...\n\r" );
      vipp_quit( &(pDemo->vipp) );
   }

   return 0;
}

int fmc_imageon_demo_enable_hdmio( fmc_imageon_demo_t *pDemo )
{
   int ret;

   //OS_PRINTF( "FMC-IMAGEON HDMI Output Initialization ...\n\r" );
   //ret = fmc_imageon_hdmio_init( &(pDemo->fmc_imageon),
   //                              1,                      // hdmioEnable = 1
   //                              &(pDemo->hdmio_timing), // pTiming
   //                              0                       // waitHPD = 0
   //                              );
   //if ( !ret )
   //{
   //   OS_PRINTF( "ERROR : Failed to init FMC-IMAGEON HDMI Output Interface\n\r" );
   //   exit(0);
   //}

#if defined(XPAR_IIC_MAIN_BASEADDR) // if ZC702 design
   // Configure ZC702 IIC Mux for Port 1 (HDMI)
   OS_PRINTF( "Configure ZC702 IIC Mux for Port 1 (HDMI) ...\n\r" );
   {
      Xuint8 mux_addr = ZC702_IIC_MUX_ADDR;
      Xuint8 mux_data = HDMI;
      pDemo->fmc_ipmi_iic.fpIicWrite( &(pDemo->fmc_ipmi_iic), (mux_addr>>1), mux_data, &mux_data, 1);
   }

   OS_PRINTF( "ZC702 HDMI Output Initialization ...\n\r" );
   {
      Xuint8 num_bytes;
      int i;

      for ( i = 0; i < ZC702_HDMI_OUT_CONFIG_LEN; i++ )
      {
     	 //OS_PRINTF( "[ZC702 HDMI] IIC Write - Device = 0x%02X, Address = 0x%02X, Data = 0x%02X\n\r", zc702_hdmi_out_config[i][0]<<1, zc702_hdmi_out_config[i][1], zc702_hdmi_out_config[i][2] );
         num_bytes = pDemo->fmc_ipmi_iic.fpIicWrite( &(pDemo->fmc_ipmi_iic), zc702_hdmi_out_config[i][0], zc702_hdmi_out_config[i][1], &(zc702_hdmi_out_config[i][2]), 1 );
      }
   }
#endif

#if defined(XPAR_IIC_HDMI_O_BASEADDR) // if ZedBoard design
   OS_PRINTF( "ZedBoard HDMI Output Initialization ...\n\r" );
   {
      Xuint8 num_bytes;
      int i;

      for ( i = 0; i < ZC702_HDMI_OUT_CONFIG_LEN; i++ )
      {
         //OS_PRINTF( "[ZC702 HDMI] IIC Write - Device = 0x%02X, Address = 0x%02X, Data = 0x%02X\n\r", zc702_hdmi_out_config[i][0]<<1, zc702_hdmi_out_config[i][1], zc702_hdmi_out_config[i][2] );
         num_bytes = pDemo->hdmi_out_iic.fpIicWrite( &(pDemo->hdmi_out_iic), zc702_hdmi_out_config[i][0], zc702_hdmi_out_config[i][1], &(zc702_hdmi_out_config[i][2]), 1 );
      }
   }
#endif

   return 0;
}

int fmc_imageon_demo_enable_vita( fmc_imageon_demo_t *pDemo )
{
   int ret;

   // VITA-2000 Initialization
   OS_PRINTF( "FMC-IMAGEON VITA Initialization ...\n\r" );
   ret = fmc_imageon_vita_receiver_sensor_initialize( &(pDemo->vita_receiver), SENSOR_INIT_ENABLE, pDemo->bVerbose );
   if ( ret == 0 )
   {
      OS_PRINTF( "VITA sensor failed to initialize ...\n\r" );
      return -1;
   }

   sleep(1);

   OS_PRINTF( "FMC-IMAGEON VITA Configuration for 1080P60 timing ...\n\r" );
   ret = fmc_imageon_vita_receiver_sensor_1080P60( &(pDemo->vita_receiver), pDemo->bVerbose );
   if ( ret == 0 )
   {
      OS_PRINTF( "VITA sensor failed to configure for 1080P60 timing ...\n\r" );
      return -1;
   }

   sleep(1);
   //OS_PRINTF( "FMC-IMAGEON VITA Status ...\n\r" );
   fmc_imageon_vita_receiver_get_status( &(pDemo->vita_receiver), &(pDemo->vita_status_t1), 0/*pDemo->bVerbose*/ );
   sleep(1);
   //OS_PRINTF( "FMC-IMAGEON VITA Status ...\n\r" );
   fmc_imageon_vita_receiver_get_status( &(pDemo->vita_receiver), &(pDemo->vita_status_t2), 0/*pDemo->bVerbose*/ );
   //
   OS_PRINTF( "VITA Status = \n\r" );
   OS_PRINTF("\tImage Width  = %d\n\r", pDemo->vita_status_t1.cntImagePixels * 4 );
   OS_PRINTF("\tImage Height = %d\n\r", pDemo->vita_status_t1.cntImageLines  );
   OS_PRINTF("\tFrame Rate   = %d frames/sec\n\r", pDemo->vita_status_t2.cntFrames - pDemo->vita_status_t1.cntFrames );

   pDemo->bVITAInitialized = 1;


   // Re-Initialize Video Frame Buffer
   vdma_init( pDemo->uBaseAddr_VDMA_VitaFrameBuffer,
              pDemo->hdmio_resolution,
              VDMA_VITA_MEM_BASE_ADDR
            );

   return 0;
}

int fmc_imageon_demo_enable_ipipe( fmc_imageon_demo_t *pDemo )
{
   int ret;

   if ( pDemo->bVITAInitialized == 0 )
   {
	   fmc_imageon_demo_enable_vita( pDemo );
   }

//   if ( pDemo->bIPIPEInitialized == 0 )
//   {
      OS_PRINTF( "Video Detector Initialization ...\n\r" );
//      vdet_init( &(pDemo->vtc_vita_detector  ), VTC_VITA_DETECTOR_ID );
      vdet_init( &(pDemo->vtc_ipipe_detector  ), VTC_ID );
      OS_PRINTF( "Video Detector Configuration ...\n\r" );
//      vdet_config( &(pDemo->vtc_vita_detector), pDemo->hdmio_resolution, pDemo->bVerbose );
//      vdet_config( &(pDemo->vtc_ipipe_detector), pDemo->hdmio_resolution, pDemo->bVerbose );
      // For debug (verbose) purposes
      vdet_config( &(pDemo->vtc_vita_detector), pDemo->hdmio_resolution, 2 );
      //vdet_detect( &(pDemo->vtc_vita_detector), 2 );
      //vdet_config( &(pDemo->vtc_ipipe_detector), pDemo->hdmio_resolution, 2 );
      //vdet_detect( &(pDemo->vtc_ipipe_detector), 2 );


      OS_PRINTF("Image Processing Pipeline (iPIPE) Initialization ...\n\r" );
      vipp_init( &(pDemo->vipp) );
      //
      pDemo->vipp.pSensor = (void *)pDemo;
      pDemo->vipp.fpSensorGetGain      = &fmc_imageon_demo_sensor_get_gain;
      pDemo->vipp.fpSensorGetExposure  = &fmc_imageon_demo_sensor_get_exposure;
      pDemo->vipp.fpSensorStepGain     = &fmc_imageon_demo_sensor_step_gain;
      pDemo->vipp.fpSensorStepExposure = &fmc_imageon_demo_sensor_step_exposure;

      pDemo->bIPIPEInitialized = 1;
//   }

   //OS_PRINTF( "Video Detection at output of iPIPE  ...\n\r" );
   //vdet_detect( &(pDemo->vtc_ipipe_detector), 2 );


   // Re-Initialize Video Frame Buffer
   vdma_init( pDemo->uBaseAddr_VDMA_VitaFrameBuffer,
              pDemo->hdmio_resolution,
              VDMA_VITA_MEM_BASE_ADDR
            );

   return 0;
}

// Image Sensor Controls
int fmc_imageon_demo_sensor_get_gain( fmc_imageon_demo_t *pDemo, int *pGain )
{
   //*pGain = pDemo->vita_receiver.uAnalogGain;
   *pGain = pDemo->vita_receiver.uDigitalGain;

   return 0;
}

int fmc_imageon_demo_sensor_get_exposure( fmc_imageon_demo_t *pDemo, int *pExposure )
{
   *pExposure = pDemo->vita_receiver.uExposureTime;

   return 0;
}

int fmc_imageon_demo_sensor_step_gain( fmc_imageon_demo_t *pDemo, int step )
{
   //pDemo->vita_receiver.uAnalogGain += step;
   //// analog gain is specified as an index from 0 to 10, corresponding to 1.0 to 8.0
   //if ( pDemo->vita_receiver.uAnalogGain > 10 )
   //   pDemo->vita_receiver.uAnalogGain = 10;
   //if ( pDemo->vita_receiver.uAnalogGain < 1 )
   //   pDemo->vita_receiver.uAnalogGain = 1;
   //fmc_imageon_vita_receiver_set_analog_gain( &(pDemo->vita_receiver), pDemo->vita_receiver.uAnalogGain, 0 );

   pDemo->vita_receiver.uDigitalGain += step;
   //OS_PRINTF("[fmc_imageon_demo_sensor_step_gain] step=%d, gain=%d => ", step, pDemo->vita_receiver.uDigitalGain );
   // digital gain is specified as an index from 0 to 4095, corresponding to 0.00 to 31.99
   if ( pDemo->vita_receiver.uDigitalGain > 4095 )
	   pDemo->vita_receiver.uDigitalGain = 4095;
   if ( pDemo->vita_receiver.uDigitalGain < 1 )
	   pDemo->vita_receiver.uDigitalGain = 1;
   //OS_PRINTF("%d\n\r", pDemo->vita_receiver.uDigitalGain );
   fmc_imageon_vita_receiver_set_digital_gain( &(pDemo->vita_receiver), pDemo->vita_receiver.uDigitalGain, 0 );

   return 0;
}

int fmc_imageon_demo_sensor_step_exposure( fmc_imageon_demo_t *pDemo, int step )
{
   pDemo->vita_receiver.uExposureTime += step;
   //OS_PRINTF("[fmc_imageon_demo_sensor_step_exposure] step=%d, exposure=%d => ", step, pDemo->vita_receiver.uExposureTime );
   // exposure is specified in % of frame time, from 1% to 99%
   if ( pDemo->vita_receiver.uExposureTime > 99 )
	   pDemo->vita_receiver.uExposureTime = 99;
   if ( pDemo->vita_receiver.uExposureTime < 1 )
	   pDemo->vita_receiver.uExposureTime = 1;
   //OS_PRINTF("%d\n\r", pDemo->vita_receiver.uExposureTime );
   fmc_imageon_vita_receiver_set_exposure_time( &(pDemo->vita_receiver), pDemo->vita_receiver.uExposureTime, 0 );

   return 0;
}


/***********************************************************************
* This function enables the XSVI2AXI PCORE
*
* @param    None.
*
* @return   None.
*
* @note     None.
*
***********************************************************************/
void enable_vita_xsvi2axi( fmc_imageon_demo_t *pDemo )
{
   Xuint32 value;

   pDemo->fmc_ipmi_iic.fpGpoRead( &(pDemo->fmc_ipmi_iic), &value );
   value = value | 0x00000008; // Force bit 3 to 1
   pDemo->fmc_ipmi_iic.fpGpoWrite( &(pDemo->fmc_ipmi_iic), value );

   usleep(100);
}

/***********************************************************************
* This function disables the XSVI2AXI PCORE
*
* @param    None.
*
* @return   None.
*
* @note     None.
*
***********************************************************************/
void disable_vita_xsvi2axi( fmc_imageon_demo_t *pDemo )
{
   Xuint32 value;

   pDemo->fmc_ipmi_iic.fpGpoRead( &(pDemo->fmc_ipmi_iic), &value );
   value = value & ~0x00000008; // Force bit 3 to 0
   pDemo->fmc_ipmi_iic.fpGpoWrite( &(pDemo->fmc_ipmi_iic), value );

   usleep(250);
}

/***********************************************************************
* This function enables the XSVI2AXI PCORE
*
* @param    None.
*
* @return   None.
*
* @note     None.
*
***********************************************************************/
void enable_hdmii_xsvi2axi( fmc_imageon_demo_t *pDemo )
{
   Xuint32 value;

   pDemo->fmc_ipmi_iic.fpGpoRead( &(pDemo->fmc_ipmi_iic), &value );
   value = value | 0x00000010; // Force bit 4 to 1
   pDemo->fmc_ipmi_iic.fpGpoWrite( &(pDemo->fmc_ipmi_iic), value );

   usleep(100);
}

/***********************************************************************
* This function disables the XSVI2AXI PCORE
*
* @param    None.
*
* @return   None.
*
* @note     None.
*
***********************************************************************/
void disable_hdmii_xsvi2axi( fmc_imageon_demo_t *pDemo )
{
   Xuint32 value;

   pDemo->fmc_ipmi_iic.fpGpoRead( &(pDemo->fmc_ipmi_iic), &value );
   value = value & ~0x00000010; // Force bit 4 to 0
   pDemo->fmc_ipmi_iic.fpGpoWrite( &(pDemo->fmc_ipmi_iic), value );

   usleep(250);
}

/***********************************************************************
* This function puts the DCM_0 PCORE into reset
*
* @param    None.
*
* @return   None.
*
* @note     None.
*
***********************************************************************/
void set_dcm_0_reset( fmc_imageon_demo_t *pDemo )
{
   Xuint32 value;

   pDemo->fmc_ipmi_iic.fpGpoRead( &(pDemo->fmc_ipmi_iic), &value );
   value = value | 0x00000004; // Force bit 2 to 1
   pDemo->fmc_ipmi_iic.fpGpoWrite( &(pDemo->fmc_ipmi_iic), value );
}

/***********************************************************************
* This function releases the DCM_0 PCORE from reset
*
* @param    None.
*
* @return   None.
*
* @note     None.
*
***********************************************************************/
void release_dcm_0_reset( fmc_imageon_demo_t *pDemo )
{
   Xuint32 value;

   pDemo->fmc_ipmi_iic.fpGpoRead( &(pDemo->fmc_ipmi_iic), &value );
   value = value & ~0x00000004; // Force bit 2 to 0
   pDemo->fmc_ipmi_iic.fpGpoWrite( &(pDemo->fmc_ipmi_iic), value );
}


void reset_dcms( fmc_imageon_demo_t *pDemo )
{
    // Reset DCMs
    set_dcm_0_reset(pDemo);
    usleep(200000);
    release_dcm_0_reset(pDemo);
    usleep(500000);
}
