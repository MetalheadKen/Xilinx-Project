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
// Create Date:         Feb 14, 2012
// Design Name:         ZVIK Camera Demo
// Module Name:         main.c
// Project Name:        ZVIK Camera Demo
//
// Tool versions:       ISE 14.4
//
// Description:         ZVIK Camera Demo
//
// Dependencies:
//
// Revision:            Feb 14, 2012: 1.01 Initial version
//                      Dec 15, 2012: 1.03 Updated to use 14.4 cores
//                                         and Xilinx tools
//
//----------------------------------------------------------------

// ---------------------------------------------------------------------------
// System Includes.
#include <stdio.h>

#include "fmc_imageon_demo.h"
fmc_imageon_demo_t fmc_imageon_demo;

#include "avnet_console_serial.h"
#include "avnet_console_web.h"

#if defined(LINUX_CODE)
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#define VIDEO_MMAP_SIZE	0x338 + sizeof(Xuint32)
#endif
#include "os.h"

// forward declarations
int init_base_addresses( fmc_imageon_demo_t *pDemo, int bVerbose );

// ---------------------------------------------------------------------------
// Main entry point.
//
int main()
{
   // Specify Base Addresses of all PCOREs
   init_base_addresses( &fmc_imageon_demo, 1/*bVerbose*/ );

   // Initialize FMC-IMAGEON Demo
   fmc_imageon_demo_init( &fmc_imageon_demo );

   // Initialize Web Console
   print_avnet_console_web_app_header();
   start_avnet_console_web_application();

   // Initialize Serial Console
   print_avnet_console_serial_app_header();
   start_avnet_console_serial_application();

   while (1)
   {
      // Process user input from Serial Console
      if ( transfer_avnet_console_serial_data() )
      {
         // user requested to quit
         break;
      }
   }

   // Shutdown the FMC-IMAGEON Demo
   fmc_imageon_demo_quit( &fmc_imageon_demo );

   return 0;
}

int init_base_addresses( fmc_imageon_demo_t *pDemo, int bVerbose )
{
#if defined(LINUX_CODE)
  int fd;
  Xuint32 map_CoreAddress;
  extern XVtc_Config XVtc_ConfigTable[];

  fd = open("/dev/mem", O_RDWR);

  //
  // Specify Base Addresses for FMC-IMAGEON demo
  //
  if ( bVerbose ) OS_PRINTF( "Specifying Base Addresses for FMC-IMAGEON demo ...\n\r" );

  // IIC - FMC IMAGEON
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_FMC_IMAGEON_IIC_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map IIC FMC-IMAGEON peripheral\n");
	 return 0;
  }
  pDemo->uBaseAddr_IIC_FmcImageon = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_IIC_FmcImageon = 0x%08X\n\r", pDemo->uBaseAddr_IIC_FmcImageon );

  // VITA Receiver
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_FMC_IMAGEON_VITA_RECEIVER_1_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map VITA Receiver peripheral\n");
	 return 0;
  }
  pDemo->uBaseAddr_VITA_Receiver = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_VITA_Receiver = 0x%08X\n\r", pDemo->uBaseAddr_VITA_Receiver );

#if defined(XPAR_IIC_MAIN_BASEADDR)
  // IIC - FMC IPMI
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_IIC_MAIN_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map IIC FMC IPMI peripheral\n");
	 return 0;
  }
  pDemo->uBaseAddr_IIC_FmcIpmi = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_IIC_FmcIpmi = 0x%08X\n\r", pDemo->uBaseAddr_IIC_FmcIpmi );
#endif

  // CFA
#if defined(XPAR_CFA_0_BASEADDR)
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_CFA_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map CFA peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_CFA = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_CFA = 0x%08X\n\r", pDemo->vipp.uBaseAddr_CFA );
#endif

  // TPG
#if defined(XPAR_TPG_0_BASEADDR)
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_TPG_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map TPG 0 peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_TPG0 = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_TPG0 = 0x%08X\n\r", pDemo->vipp.uBaseAddr_TPG0 );
#endif

  // TPG
#if defined(XPAR_TPG_1_BASEADDR)
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_TPG_1_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map TPG 1 peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_TPG1 = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_TPG1 = 0x%08X\n\r", pDemo->vipp.uBaseAddr_TPG1 );
#endif

  // Chroma Resampler
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_CRESAMPLE_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map Chroma Resampler peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_CRES = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_CRES = 0x%08X\n\r", pDemo->vipp.uBaseAddr_CRES );

  // rgb2ycc
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_RGB2YCRCB_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map RGB2YCC peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_RGBYCC = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_RGBYCC = 0x%08X\n\r", pDemo->vipp.uBaseAddr_RGBYCC );


#if defined(XPAR_IIC_FMC_BASEADDR)
  // IIC - FMC IPMI
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_IIC_FMC_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map IIC FMC IPMI peripheral\n");
	 return 0;
  }
  pDemo->uBaseAddr_IIC_FmcIpmi = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_IIC_FmcIpmi = 0x%08X\n\r", pDemo->uBaseAddr_IIC_FmcIpmi );
#endif

  // IIC - DVI OUT
  pDemo->uBaseAddr_IIC_DviOut     = 0;

#if defined(XPAR_IIC_HDMI_O_BASEADDR)
  // IIC - HDMI OUT
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_IIC_HDMI_O_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map IIC FMC IPMI peripheral\n");
	 return 0;
  }
  pDemo->uBaseAddr_IIC_HdmiOut = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_IIC_HdmiOut = 0x%08X\n\r", pDemo->uBaseAddr_IIC_HdmiOut );
#endif

  // VTC - Vita Detector
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_V_TC_1_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map VTC - Vita Detector peripheral\n");
	 return 0;
  }
  pDemo->uBaseAddr_VTC_VitaDetector = map_CoreAddress;
  XVtc_ConfigTable[XPAR_V_TC_1_DEVICE_ID].BaseAddress = (u32)map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_VTC_VitaDetector = 0x%08X\n\r", pDemo->uBaseAddr_VTC_VitaDetector );

  // VTC - iPipe Detector
//  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
//		  (off_t)XPAR_AXI_VTC_1_BASEADDR );
//  if (map_CoreAddress == (Xuint32)MAP_FAILED)
//  {
//	 OS_PRINTF("MMap failed to map VTC - iPipe Detector peripheral\n");
//	 return 0;
//  }
//  pDemo->uBaseAddr_VTC_iPipeDetector = map_CoreAddress;
//  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_VTC_iPipeDetector = 0x%08X\n\r", pDemo->uBaseAddr_VTC_iPipeDetector );
//
//  // VTC - Hdmio Generator
//  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
//		  (off_t)XPAR_TPG_0_VTC_BASEADDR );
//  if (map_CoreAddress == (Xuint32)MAP_FAILED)
//  {
//	 OS_PRINTF("MMap failed to map VTC - Hdmio Generator peripheral\n");
//	 return 0;
//  }
//  pDemo->uBaseAddr_VTC_HdmioGenerator = map_CoreAddress;
//  if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_VTC_HdmioGenerator = 0x%08X\n\r", pDemo->uBaseAddr_VTC_HdmioGenerator );
//

  // DPC
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_DPC_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map DPC peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_DPC = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_DPC = 0x%08X\n\r", pDemo->vipp.uBaseAddr_DPC );

  // STATS
#if defined(XPAR_STATS_0_BASEADDR)
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_STATS_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map STATS peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_STATS = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_STATS = 0x%08X\n\r", pDemo->vipp.uBaseAddr_STATS );
#endif

  // CCM
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_CCM_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map CCM0 peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_CCM = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_CCM = 0x%08X\n\r", pDemo->vipp.uBaseAddr_CCM );

  // NOISE
//  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
//		  (off_t)XPAR_NOISE_0_BASEADDR );
//  if (map_CoreAddress == (Xuint32)MAP_FAILED)
//  {
//	 OS_PRINTF("MMap failed to map NOISE peripheral\n");
//	 return 0;
//  }
//  pDemo->vipp.uBaseAddr_NOISE = map_CoreAddress;
//  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_NOISE = 0x%08X\n\r", pDemo->vipp.uBaseAddr_NOISE );

  // ENHANCE
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_ENHANCE_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map NOISE peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_ENHANCE = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_ENHANCE = 0x%08X\n\r", pDemo->vipp.uBaseAddr_ENHANCE );

  // GAMMA
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		  (off_t)XPAR_GAMMA_0_BASEADDR );
  if (map_CoreAddress == (Xuint32)MAP_FAILED)
  {
	 OS_PRINTF("MMap failed to map GAMMA peripheral\n");
	 return 0;
  }
  pDemo->vipp.uBaseAddr_GAMMA = map_CoreAddress;
  if ( bVerbose ) OS_PRINTF("\tpDemo->vipp.uBaseAddr_GAMMA = 0x%08X\n\r", pDemo->vipp.uBaseAddr_GAMMA );

  // AXI_VDMA
  map_CoreAddress = (Xuint32)mmap(NULL, VIDEO_MMAP_SIZE,
		PROT_READ | PROT_WRITE, MAP_SHARED, fd, (off_t)XPAR_AXI_VDMA_1_BASEADDR );
 if (map_CoreAddress == (Xuint32)MAP_FAILED)
 {
    OS_PRINTF("MMap failed to map VDMA peripheral\n");
    return 0;
  }
 pDemo->uBaseAddr_VDMA_VitaFrameBuffer = map_CoreAddress;
 if ( bVerbose ) OS_PRINTF("\tpDemo->uBaseAddr_VDMA_VitaFrameBuffer = 0x%08X\r\n", pDemo->uBaseAddr_VDMA_VitaFrameBuffer);


#else

   // Specify Base Addresses for FMC-IMAGEON demo
#if defined(XPAR_IIC_MAIN_BASEADDR)
   pDemo->uBaseAddr_IIC_FmcIpmi    = XPAR_IIC_MAIN_BASEADDR;
#endif
#if defined(XPAR_IIC_FMC_BASEADDR)
   pDemo->uBaseAddr_IIC_FmcIpmi    = XPAR_IIC_FMC_BASEADDR;
#endif
   pDemo->uBaseAddr_IIC_FmcImageon = XPAR_FMC_IMAGEON_IIC_0_BASEADDR;
   pDemo->uBaseAddr_IIC_DviOut     = 0;
#if defined(XPAR_IIC_HDMI_O_BASEADDR)
   pDemo->uBaseAddr_IIC_HdmiOut    = XPAR_IIC_HDMI_O_BASEADDR;
#endif
   pDemo->uBaseAddr_VITA_Receiver  = XPAR_FMC_IMAGEON_VITA_RECEIVER_0_BASEADDR;
   pDemo->uBaseAddr_VTC_VitaDetector     = XPAR_AXI_VTC_0_BASEADDR;
   pDemo->uBaseAddr_VTC_iPipeDetector    = XPAR_AXI_VTC_1_BASEADDR;
   pDemo->uBaseAddr_VTC_HdmioGenerator   = XPAR_TPG_0_VTC_BASEADDR;
   pDemo->uBaseAddr_MEM_VitaFrameBuffer  = 0; // VDMA_VITA_MEM_BASE_ADDR;
   pDemo->uBaseAddr_MEM_HdmiFrameBuffer  = 0; // VDMA_HDMI_MEM_BASE_ADDR;
   pDemo->vipp.uBaseAddr_DPC     = XPAR_DPC_0_BASEADDR;
   pDemo->vipp.uBaseAddr_CFA     = XPAR_CFA_0_BASEADDR;
   pDemo->vipp.uBaseAddr_STATS   = XPAR_STATS_0_BASEADDR;
   pDemo->vipp.uBaseAddr_CCM     = XPAR_CCM_0_BASEADDR;
   pDemo->vipp.uBaseAddr_NOISE   = XPAR_NOISE_0_BASEADDR;
   pDemo->vipp.uBaseAddr_ENHANCE = XPAR_ENHANCE_0_BASEADDR;
   pDemo->vipp.uBaseAddr_GAMMA   = XPAR_GAMMA_0_BASEADDR;
   pDemo->uBaseAddr_VDMA_VitaFrameBuffer = XPAR_AXI_VDMA_0_BASEADDR;
#endif
  
   return 0;
}
