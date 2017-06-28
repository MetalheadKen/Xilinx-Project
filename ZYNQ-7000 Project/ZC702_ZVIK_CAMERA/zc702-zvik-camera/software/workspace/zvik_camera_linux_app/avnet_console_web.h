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
// Create Date:         Apr 09, 2012
// Design Name:         Web Entry for Avnet Console
// Module Name:         avnet_console_web.h
// Project Name:        Web Entry for Avnet Console
//
// Tool versions:       ISE 14.1
//
// Description:         Web entry point for Avnet console
//                      - using named pipes
//
// Dependencies:        
//
// Revision:            Apr 09, 2012: 1.01 Initial version
//
//----------------------------------------------------------------

#ifndef __AVNET_CONSOLE_WEB_H__
#define __AVNET_CONSOLE_WEB_H__

int transfer_avnet_console_web_data();
void print_avnet_console_web_app_header();
int start_avnet_console_web_application();


#endif // __AVNET_CONSOLE_WEB_H__
