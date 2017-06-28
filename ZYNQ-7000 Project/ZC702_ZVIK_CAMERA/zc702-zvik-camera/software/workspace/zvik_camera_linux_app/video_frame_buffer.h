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
// Module Name:         video_frame_buffer.h
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
//                      Sep 17, 2012: 1.02 Remove video multiplexers
//                                         Fix gamma equalization
//                      Dec 15, 2012: 1.03 Updated to use 14.4 cores
//                                         and Xilinx tools
//
//----------------------------------------------------------------

#ifndef __VIDEO_FRAME_BUFFER_H__
#define __VIDEO_FRAME_BUFFER_H__

#include "xaxivdma.h"

int vdma_init( Xuint32 uBaseAddr, Xuint32 ResolutionId, Xuint32 uMemAddr );

int vdma_status( Xuint32 uBaseAddr );

int vdma_rx_start( Xuint32 uBaseAddr, Xuint32 ResolutionId, Xuint32 uMemAddr );
int vdma_rx_stop( Xuint32 uBaseAddr );
int vdma_rx_pause( Xuint32 uBaseAddr );

int vdma_tx_start( Xuint32 uBaseAddr, Xuint32 ResolutionId, Xuint32 uMemAddr );
int vdma_tx_stop( Xuint32 uBaseAddr );

Xuint32 vdma_address( Xuint32 uBaseAddr );

#endif // __VIDEO_FRAME_BUFFER_H__

