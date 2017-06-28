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
// Create Date:         Dec 23, 2011
// Design Name:         Video Frame Buffer
// Module Name:         video_frame_buffer.c
// Project Name:        FMC-IMAGEON
// Target Devices:      Zynq-7000 SoC
// Hardware Boards:     ZC702 + FMC-IMAGEON
//
// Tool versions:       ISE 14.4
//
// Description:         Video Frame Buffer
//                      - use with AXI_VDMA pcore
//
// Dependencies:        
//
// Revision:            Dec 23, 2011: 1.00 Initial Version
//                      Sep 17, 2012: 1.01 Remove TX initialization
//                      Dec 15, 2012: 1.03 Updated to use 14.4 cores
//                                         and Xilinx tools
//
//----------------------------------------------------------------

#include <stdio.h>
#include "os.h"

//#include "platform.h"
#include "xparameters.h"

#include "video_resolution.h"

#include "xaxivdma.h"

int vdma_init( Xuint32 uBaseAddr, Xuint32 ResolutionId, Xuint32 uMemAddr )
{
   vdma_rx_stop( uBaseAddr );


   vdma_rx_start( uBaseAddr, ResolutionId, uMemAddr );
   return 0;
}

int vdma_status( Xuint32 uBaseAddr )
{
   OS_PRINTF( "VDMA - Partial Register Dump (uBaseAddr = 0x%08X):\n\r", uBaseAddr );
   OS_PRINTF( "\t PARKPTR          = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_PARKPTR_OFFSET )) );
   OS_PRINTF( "\t ----------------\n\r" );
   OS_PRINTF( "\t S2MM_DMACR       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET )) );
   OS_PRINTF( "\t S2MM_DMASR       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_SR_OFFSET )) );
   OS_PRINTF( "\t S2MM_STRD_FRMDLY = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_STRD_FRMDLY_OFFSET)) );
   OS_PRINTF( "\t S2MM_START_ADDR0 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+0)) );
   OS_PRINTF( "\t S2MM_START_ADDR1 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+4)) );
   OS_PRINTF( "\t S2MM_START_ADDR2 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+8)) );
   OS_PRINTF( "\t S2MM_HSIZE       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_HSIZE_OFFSET)) );
   OS_PRINTF( "\t S2MM_VSIZE       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_VSIZE_OFFSET)) );
   OS_PRINTF( "\t ----------------\n\r" );
   OS_PRINTF( "\t MM2S_DMACR       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_CR_OFFSET )) );
   OS_PRINTF( "\t MM2S_DMASR       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_SR_OFFSET )) );
   OS_PRINTF( "\t MM2S_STRD_FRMDLY = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_STRD_FRMDLY_OFFSET)) );
   OS_PRINTF( "\t MM2S_START_ADDR0 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+0)) );
   OS_PRINTF( "\t MM2S_START_ADDR1 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+4)) );
   OS_PRINTF( "\t MM2S_START_ADDR2 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+8)) );
   OS_PRINTF( "\t MM2S_HSIZE       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_HSIZE_OFFSET)) );
   OS_PRINTF( "\t MM2S_VSIZE       = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_VSIZE_OFFSET)) );
   OS_PRINTF( "\t ----------------\n\r" );
   OS_PRINTF( "\t S2MM_HSIZE_STATUS= 0x%08X\n\r", *((volatile int *)(uBaseAddr+0xF0 )) );
   OS_PRINTF( "\t S2MM_VSIZE_STATUS= 0x%08X\n\r", *((volatile int *)(uBaseAddr+0xF4 )) );
   OS_PRINTF( "\t ----------------\n\r" );

   return 0;
}

#define VDMA_WAIT_TIMEOUT 1000

int vdma_rx_start( Xuint32 uBaseAddr, Xuint32 ResolutionId, Xuint32 uMemAddr )
{
   int timeout;

   Xuint32 frame_width;
   Xuint32 frame_height;
   Xuint32 frame_stride;
   Xuint32 frame_size;

   Xuint32 frameAddress1;
   Xuint32 frameAddress2;
   Xuint32 frameAddress3;

   frame_height = vres_get_height( ResolutionId );      // in lines
   frame_width  = vres_get_width ( ResolutionId ) << 2; // in bytes
   //frame_size   = frame_width * frame_height;

   frame_stride = 0x00002000;
   frame_size   = 0x00870000;

   frameAddress1 = uMemAddr + (frame_size * 0);
   frameAddress2 = uMemAddr + (frame_size * 1);
   frameAddress3 = uMemAddr + (frame_size * 2);
   //OS_PRINTF("[vdma_rx_start] frameAddress1 = 0x%08X\n\r", frameAddress1 );
   //OS_PRINTF("[vdma_rx_start] frameAddress2 = 0x%08X\n\r", frameAddress2 );
   //OS_PRINTF("[vdma_rx_start] frameAddress3 = 0x%08X\n\r", frameAddress3 );

   //*((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x00010003; // does not work ... need to set FsyncSrcSelect to 10 (tuser[0]/sof)
   *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x00010043;  // S2MM_DMACR[0] : RS = 1 (Run)
                                                                                                        // S2MM_DMACR[1] : Circular_Park = 1 (Circular)
                                                                                                        // S2MM_DMACR[2] : Reset = 0 (disabled)
                                                                                                        // S2MM_DMACR[3] : SyncEn = 0 (disabled)
                                                                                                        // S2MM_DMACR[ 6: 5] : FsyncSrcSelect = 10 (tuser[0]/sof)
                                                                                                        // S2MM_DMACR[23:16] : IRQFrameCount = 1
                                                                                                        // S2MM_DMACR[31:24] : IRQDelayCount = 0
   *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_STRD_FRMDLY_OFFSET )) = 0x00002000;  // Frame delay is set to zero + Stride is set to 0x2000
   *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+0)) = frameAddress1; //0x30000000;  // DDR starting address of frame buffer-0
   *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+4)) = frameAddress2; //0x30870000;  // DDR starting address of frame buffer-1
   *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+8)) = frameAddress3; //0x310E0000;  // DDR starting address of frame buffer-2
   *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_HSIZE_OFFSET       )) = frame_width;   // (1920*4)  => 0x1E00
   *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_VSIZE_OFFSET	      )) = frame_height;  // 1080 lines => 0x00000438

#if 1
   millisleep(10);
#else
   timeout = VDMA_WAIT_TIMEOUT;
   while(--timeout)
   {
      int x;
   	  // Read Park Pointer register of VDMA
      x =   *((volatile int *)(uBaseAddr+XAXIVDMA_PARKPTR_OFFSET ));

	  // Bit wise anding for bits 27:24
      x =   x & 0x0F000000;
      if(x != 0)
	     	break;
      millisleep(1); // wait 1 msec between each iteration
   }
   if ( !timeout )
   {
      OS_PRINTF( "\t[vdma_rx_start] ERROR : Timeout waiting for VDMA ...\n\r" );
      OS_PRINTF( "\t[vdma_rx_start] S2MM_DMACR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET )) );
      OS_PRINTF( "\t[vdma_rx_start] S2MM_DMASR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_SR_OFFSET )) );
      OS_PRINTF( "\t[vdma_rx_start] S2MM_HSIZE_STATUS = 0x%08X\n\r", *((volatile int *)(uBaseAddr+0xF0 )) );
      OS_PRINTF( "\t[vdma_rx_start] S2MM_VSIZE_STATUS = 0x%08X\n\r", *((volatile int *)(uBaseAddr+0xF4 )) );
   }
#endif

   return 0;
}

int vdma_rx_stop( Xuint32 uBaseAddr )
{
   int timeout;
   int x;

   *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x00010002;  // S2MM_DMACR[0] : RS = 0 (Stop)
                                                                                                        // S2MM_DMACR[1] : Circular_Park = 1 (Circular)
                                                                                                        // S2MM_DMACR[2] : Reset = 0 (disabled)
                                                                                                        // S2MM_DMACR[3] : SyncEn = 0 (disabled)
   // Wait for VDMA to halt
   timeout = VDMA_WAIT_TIMEOUT;
   while(--timeout)
   {
      // Read VDMA Status register
      x =   *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_SR_OFFSET ));
      // Bit wise anding for bit 0
      x =   x & 0x00000001;
      if(x != 0)
         break;
      millisleep(1); // wait 1 msec between each iteration
   }
   if ( !timeout )
   {
      OS_PRINTF( "\t[vdma_rx_stop] ERROR : Timeout waiting for VDMA ...\n\r" );
      OS_PRINTF( "\t[vdma_rx_stop] S2MM_DMACR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET )) );
      OS_PRINTF( "\t[vdma_rx_stop] S2MM_DMASR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_SR_OFFSET )) );
   }

   *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x00010006;  // S2MM_DMACR[0] : RS = 0 (Stop)
                                                                                                        // S2MM_DMACR[1] : Circular_Park = 1 (Circular)
                                                                                                        // S2MM_DMACR[2] : Reset = 1 (enabled)
                                                                                                        // S2MM_DMACR[3] : SyncEn = 0 (disabled)

   return 0;
}

int vdma_rx_pause( Xuint32 uBaseAddr ) // same as vdma_rx_stop, but without the reset
{
   int timeout;
   int x;

   *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x00010002;  // S2MM_DMACR[0] : RS = 0 (Stop)
                                                                                                        // S2MM_DMACR[1] : Circular_Park = 1 (Circular)
                                                                                                        // S2MM_DMACR[2] : Reset = 0 (disabled)
                                                                                                        // S2MM_DMACR[3] : SyncEn = 0 (disabled)
   // Wait for VDMA to halt
   timeout = VDMA_WAIT_TIMEOUT;
   while(--timeout)
   {
      // Read VDMA Status register
      x =   *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_SR_OFFSET ));
      // Bit wise anding for bit 0
      x =   x & 0x00000001;
      if(x != 0)
         break;
      millisleep(1); // wait 1 msec between each iteration
   }
   if ( !timeout )
   {
      OS_PRINTF( "\t[vdma_rx_stop] ERROR : Timeout waiting for VDMA ...\n\r" );
      OS_PRINTF( "\t[vdma_rx_stop] S2MM_DMACR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_CR_OFFSET )) );
      OS_PRINTF( "\t[vdma_rx_stop] S2MM_DMASR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_RX_OFFSET+XAXIVDMA_SR_OFFSET )) );
   }

   return 0;
}

int vdma_tx_start( Xuint32 uBaseAddr, Xuint32 ResolutionId, Xuint32 uMemAddr )
{
   int timeout;
   int x;

   Xuint32 frame_width;
   Xuint32 frame_height;
   Xuint32 frame_stride;
   Xuint32 frame_size;

   Xuint32 frameAddress1;
   Xuint32 frameAddress2;
   Xuint32 frameAddress3;

   frame_height = vres_get_height( ResolutionId );      // in lines
   frame_width  = vres_get_width ( ResolutionId ) << 2; // in bytes
   //frame_size   = frame_width * frame_height;

   frame_stride = 0x00002000;
   frame_size   = 0x00870000;

   frameAddress1 = uMemAddr + (frame_size * 0);
   frameAddress2 = uMemAddr + (frame_size * 1);
   frameAddress3 = uMemAddr + (frame_size * 2);
   //OS_PRINTF("[vdma_tx_start] frameAddress1 = 0x%08X\n\r", frameAddress1 );
   //OS_PRINTF("[vdma_tx_start] frameAddress2 = 0x%08X\n\r", frameAddress2 );
   //OS_PRINTF("[vdma_tx_start] frameAddress3 = 0x%08X\n\r", frameAddress3 );


   *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x0001000B;  // MM2S_DMACR[    0] : RS = 1 (Run)
                                                                                                        // MM2S_DMACR[    1] : Circular_Park = 1 (Circular)
                                                                                                        // MM2S_DMACR[    2] : Reset = 0 (disabled)
                                                                                                        // MM2S_DMACR[    3] : SyncEn = 1 (enabled)
                                                                                                        // MM2S_DMACR[ 6: 5] : FsyncSrcSelect = 00 (mm2s_fsync)
                                                                                                        // MM2S_DMACR[23:16] : IRQFrameCount = 1
                                                                                                        // MM2S_DMACR[31:24] : IRQDelayCount = 0
   *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_STRD_FRMDLY_OFFSET )) = 0x00002000;  // Frame delay is set to zero + Stride is set to 0x2000
   *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+0)) = frameAddress1; //0x30000000;  // DDR starting address of frame buffer-0
   *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+4)) = frameAddress2; //0x30870000;  // DDR starting address of frame buffer-1
   *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+8)) = frameAddress3; //0x310E0000;  // DDR starting address of frame buffer-2
   *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_HSIZE_OFFSET   	  )) = frame_width;  // (1920*4)  => 0x1E00
   *((volatile int *)(uBaseAddr+XAXIVDMA_MM2S_ADDR_OFFSET+XAXIVDMA_VSIZE_OFFSET	      )) = frame_height; // 1080 lines => 0x00000438

#if 1
   millisleep(10);
#else
   timeout = VDMA_WAIT_TIMEOUT;
   while(--timeout)
   {
	  // Read Park Pointer register of VDMA0
	  x =   *((volatile int *)(uBaseAddr+XAXIVDMA_PARKPTR_OFFSET ));

	  // Bit wise anding for bits 27:24
	  x =   x & 0x0F000000;
	  if(x != 0)
			break;
	  millisleep(1); // wait 1 msec between each iteration
   }
   if ( !timeout )
   {
	  OS_PRINTF( "\t[vdma_tx_start] ERROR : Timeout waiting for VDMA ...\n\r" );
      OS_PRINTF( "\t[vdma_tx_start] MM2S_DMACR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_CR_OFFSET )) );
      OS_PRINTF( "\t[vdma_tx_start] MM2S_DMASR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_SR_OFFSET )) );
   }
#endif

   return 0;
}

int vdma_tx_stop( Xuint32 uBaseAddr )
{
   int timeout;
   int x;

   *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x00010002;  // MM2S_DMACR[0] : RS = 0 (Run)
                                                                                                        // MM2S_DMACR[1] : Circular_Park = 1 (Circular)
                                                                                                        // MM2S_DMACR[2] : Reset = 0 (disabled)
                                                                                                        // MM2S_DMACR[3] : SyncEn = 1 (enabled)
                                                                                                        // MM2S_DMACR[23:16] : IRQFrameCount = 1
                                                                                                        // MM2S_DMACR[31:24] : IRQDelayCount = 0
   // Wait for VDMA to halt

   timeout = VDMA_WAIT_TIMEOUT;
   while(--timeout)
   {
	  // Read VDMA Status register
	  x =   *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_SR_OFFSET ));
	  // Bit wise anding for bit 0
	  x =   x & 0x00000001;
	  if(x != 0)
		 break;
	  millisleep(1); // wait 1 msec between each iteration
   }
   if ( !timeout )
   {
	  OS_PRINTF( "\t[vdma_tx_stop] ERROR : Timeout waiting for VDMA ...\n\r" );
      OS_PRINTF( "\t[vdma_tx_stop] MM2S_DMACR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_CR_OFFSET )) );
      OS_PRINTF( "\t[vdma_tx_stop] MM2S_DMASR = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_SR_OFFSET )) );
   }

   *((volatile int *)(uBaseAddr+XAXIVDMA_TX_OFFSET+XAXIVDMA_CR_OFFSET                 )) = 0x0001000E;  // MM2S_DMACR[0] : RS = 0 (Run)
                                                                                                        // MM2S_DMACR[1] : Circular_Park = 1 (Circular)
                                                                                                        // MM2S_DMACR[2] : Reset = 1 (disabled)
                                                                                                        // MM2S_DMACR[3] : SyncEn = 1 (enabled)
                                                                                                        // MM2S_DMACR[23:16] : IRQFrameCount = 1
                                                                                                        // MM2S_DMACR[31:24] : IRQDelayCount = 0

   return 0;
}


Xuint32 vdma_address( Xuint32 uBaseAddr )
{
   Xuint32 frameId;
   Xuint32 frameAddress;

   //OS_PRINTF( "\t[vdma_address] PARKPTR    = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_PARKPTR_OFFSET )) );
   //OS_PRINTF( "\t[vdma_address] S2MM_ADDR0 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+0)) );
   //OS_PRINTF( "\t[vdma_address] S2MM_ADDR1 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+4)) );
   //OS_PRINTF( "\t[vdma_address] S2MM_ADDR2 = 0x%08X\n\r", *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+8)) );

   //frameId = 0; // TODO
   {
      int x;
   	  // Read Park Pointer register of VDMA
      x = *((volatile int *)(uBaseAddr+XAXIVDMA_PARKPTR_OFFSET ));

	  // Bit wise anding for bits 27:24
      x = x & 0x0F000000;

      // Shift bits down
      frameId = x >> 24;
   }
   //OS_PRINTF("[vdma_address] frameId = %d\n\r", frameId );

   //frameAddress = 0x30000000 + (0x00870000*frameId); // TODO
   switch ( frameId )
   {
   case 0:
	   frameAddress = *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+0));
	   break;
   case 1:
	   frameAddress = *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+4));
	   break;
   case 2:
	   frameAddress = *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+8));
	   break;
   default:
	   frameAddress = *((volatile int *)(uBaseAddr+XAXIVDMA_S2MM_ADDR_OFFSET+XAXIVDMA_START_ADDR_OFFSET+0));
	   break;
   }
   //OS_PRINTF("[vdma_address] frameAddress = 0x%08X\n\r", frameAddress );

   return frameAddress;
}

