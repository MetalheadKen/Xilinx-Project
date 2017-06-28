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
// Create Date:         Nov 18, 2011
// Design Name:         Avnet Console
// Module Name:         avnet_console.c
// Project Name:        Avnet Console
//
// Tool versions:       Vivado 2013.2
//
// Description:         Text-based console for
//                      FMC-IMAGEON Getting Started Design
//
// Dependencies:        
//
// Revision:            Nov 18, 2010: 1.01 Initial version
//                      Sep 17, 2012: 1.02 Remove video multiplexers
//                                         Fix gamma equalization
//                      Dec 15, 2012: 1.03 Updated to use 14.4 cores
//                                         and Xilinx tools
//                      Aug 16, 2013: 1.04 Updated for new Image Enhancement core
//
//----------------------------------------------------------------


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

// Located in: microblaze_0/include/
#include "xbasic_types.h"
#include "xutil.h"
#include "xparameters.h"
#include "xstatus.h"

#include "sleep.h"

#if defined(LINUX_CODE)
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#endif

//#include "mfs_config.h"

#include "video_ipipe.h"
#include "fmc_imageon_demo.h"
extern fmc_imageon_demo_t fmc_imageon_demo;

#include "avnet_console.h"
#include "avnet_console_scanput.h"
#include "avnet_console_tokenize.h"

int avnet_console_get_line_poll( avnet_console_t *pConsole );

void avnet_console_verbose_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_delay_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_mem_command( avnet_console_t *pConsole, int cargc, char ** cargv, Xuint32 baseAddress );
void avnet_console_iic_command( avnet_console_t *pConsole, int cargc, char ** cargv, fmc_iic_t *pIIC );

void avnet_console_vita_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_vita_spi_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_vita_trigger_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_vita_aec_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_vita_again_command(avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_vita_dgain_command(avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_vita_exposure_command(avnet_console_t *pConsole, int cargc, char ** cargv );

void avnet_console_ipipe_dpc_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_ipipe_cfa_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_ipipe_stats_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_ipipe_awb_command( avnet_console_t *pConsole, int cargc, char ** cargv);
void avnet_console_ipipe_agc_command( avnet_console_t *pConsole, int cargc, char ** cargv);
void avnet_console_ipipe_aec_command( avnet_console_t *pConsole, int cargc, char ** cargv);
void avnet_console_ipipe_geq_command( avnet_console_t *pConsole, int cargc, char ** cargv);
void avnet_console_ipipe_noise_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_ipipe_enhance_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_ipipe_halo_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_ipipe_ccm_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_ipipe_gamma_command( avnet_console_t *pConsole, int cargc, char ** cargv );

void avnet_console_video_command( avnet_console_t *pConsole, int cargc, char ** cargv );

void avnet_console_adv7511_command( avnet_console_t *pConsole, int cargc, char ** cargv );

void avnet_console_vdma_command( avnet_console_t *pConsole, int cargc, char ** cargv );
#if defined(LINUX_CODE)
void avnet_console_record_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_playback_command( avnet_console_t *pConsole, int cargc, char ** cargv );
#endif // #if defined(LINUX_CODE)

void avnet_console_cdce913_command( avnet_console_t *pConsole, int cargc, char ** cargv );

//void avnet_console_mfs_command( avnet_console_t *pConsole, int cargc, char ** cargv );
void avnet_console_help( avnet_console_t *pConsole );

void avnet_console_init( avnet_console_t *pConsole )
{
   pConsole->inchar = ' ';
   pConsole->inline_count = 0;
   pConsole->verbose = 0;
   pConsole->echo = 1;
   pConsole->quit = 0;

   return;
}  

void avnet_console_process( avnet_console_t *pConsole )
{
  Xint32 inchar;
  int  cargc;
  char * cargv[MAX_ARGC];
  int len;

  if ( pConsole->echo )
  {
    pConsole->io_hprintf( pConsole->io_handle, "%c", pConsole->inchar );
  }
   
#if 1
  // Check if complete line has been received ...
  if ( avnet_console_get_line_poll(pConsole) == -1 )
  {
     return;
  }

  // Pre-process command line
  len = strlen(pConsole->inline_buffer);
  if (pConsole->inline_buffer[len-1] == '\n')
  {
     pConsole->inline_buffer[len-1] = 0;
  }
  tokenize(pConsole->inline_buffer, &cargc, cargv, MAX_ARGC);

  // Process command line
  if (cargc == 0) {
     pConsole->io_hprintf( pConsole->io_handle, "\n\r%s>", AVNET_CONSOLE_PROMPT );
     return;
  }
  else if ( pConsole->verbose )
  {
     pConsole->io_hprintf( pConsole->io_handle, "\t");
     for ( len = 0; len < cargc; len++ )
     {
         pConsole->io_hprintf( pConsole->io_handle, "%s ", cargv[len]);
     }
     pConsole->io_hprintf( pConsole->io_handle, "\n\r");
  }

  if ( cargv[0][0] == '#' )
  {
     // comment, ignore line ...
  }
  //
  // General Commands
  //
  else if ( !strcmp(cargv[0],"help") )
  {
     avnet_console_help(pConsole);
  }
  else if ( !strcmp(cargv[0],"quit") )
  {
     pConsole->quit = 1;
  }
  else if ( !strcmp(cargv[0],"verbose") )
  {
     avnet_console_verbose_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"delay") )
  {
     avnet_console_delay_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"mem") )
  {
     avnet_console_mem_command( pConsole, cargc, cargv, 0x00000000 );
  }
  //
  // I2C Commands
  //
  else if ( !strcmp(cargv[0],"iic0") )
  {
     avnet_console_iic_command( pConsole, cargc, cargv, &(fmc_imageon_demo.fmc_ipmi_iic) );
  }
  else if ( !strcmp(cargv[0],"iic1") )
  {
     avnet_console_iic_command( pConsole, cargc, cargv, &(fmc_imageon_demo.fmc_imageon_iic) );
  }
  //else if ( !strcmp(cargv[0],"iic2") )
  //{
  //   avnet_console_iic_command( pConsole, cargc, cargv, &(fmc_imageon_demo.dvi_out_iic) );
  //}
  //
  // VITA Commands
  //
  else if ( !strcmp(cargv[0],"vita") )
  {
     avnet_console_vita_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"vspi") )
  {
     avnet_console_vita_spi_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"vreg") )
  {
     avnet_console_mem_command( pConsole, cargc, cargv, fmc_imageon_demo.uBaseAddr_VITA_Receiver );
  }
  else if ( !strcmp(cargv[0],"trig") )
  {
     avnet_console_vita_trigger_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"vaec") )
  {
    avnet_console_vita_aec_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"again") )
  {
	avnet_console_vita_again_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"dgain") )
  {
	avnet_console_vita_dgain_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"exposure") )
  {
	avnet_console_vita_exposure_command( pConsole, cargc, cargv );
  }
  //
  // iPIPE Commands
  //
  else if ( !strcmp(cargv[0],"dpc") )
  {
     avnet_console_ipipe_dpc_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"cfa") )
  {
     avnet_console_ipipe_cfa_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"stats") || !strcmp(cargv[0], "s") )
  {
     avnet_console_ipipe_stats_command( pConsole, cargc, cargv );
  }
  else if (!strcmp(cargv[0], "awb"))
  {
     avnet_console_ipipe_awb_command(pConsole, cargc, cargv);
  }
  else if (!strcmp(cargv[0], "agc"))
  {
     avnet_console_ipipe_agc_command(pConsole, cargc, cargv);
  }
  else if (!strcmp(cargv[0], "aec"))
  {
     avnet_console_ipipe_aec_command(pConsole, cargc, cargv);
  }
  else if (!strcmp(cargv[0], "geq"))
  {
     avnet_console_ipipe_geq_command(pConsole, cargc, cargv);
  }
  else if ( !strcmp(cargv[0],"noise") )
  {
     avnet_console_ipipe_noise_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"enhance") )
  {
     avnet_console_ipipe_enhance_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"halo") )
  {
     avnet_console_ipipe_halo_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"ccm") )
  {
     avnet_console_ipipe_ccm_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"gamma") )
  {
     avnet_console_ipipe_gamma_command( pConsole, cargc, cargv );
  }
  //
  // Video Source Selection
  //
  else if ( !strcmp(cargv[0],"video") )
  {
     avnet_console_video_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"adv7511") )
  {
    avnet_console_adv7511_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"cdce913") )
  {
    avnet_console_cdce913_command( pConsole, cargc, cargv );
  }
  //
  // Record/Playback Commands
  //
  else if ( !strcmp(cargv[0],"vdma") )
  {
     avnet_console_vdma_command( pConsole, cargc, cargv );
  }
#if defined(LINUX_CODE)
  else if ( !strcmp(cargv[0],"record") || !strcmp(cargv[0], "rec") )
  {
    avnet_console_record_command( pConsole, cargc, cargv );
  }
  else if ( !strcmp(cargv[0],"playback") || !strcmp(cargv[0], "play") )
  {
    avnet_console_playback_command( pConsole, cargc, cargv );
  }
#endif // #if defined(LINUX_CODE)
  //
  //
  //
  //else if ( !strcmp(cargv[0],"mfs") )
  //{
  //   avnet_console_mfs_command( pConsole, cargc, cargv );
  //}
  else
  {
     pConsole->io_hprintf( pConsole->io_handle, "\tUnknown command : %s\n\r", cargv[0] );
  }
  pConsole->io_hprintf( pConsole->io_handle, "\n\r%s>", AVNET_CONSOLE_PROMPT );

#else
  // Get input character from xxx_session
  inchar = pConsole->inchar;
   
  //pConsole->io_hprintf( pConsole->io_handle, "%c (0x%02X)\n\r",inchar,inchar);

  switch ( inchar )
  {
     case '?':
     {
        avnet_console_help(p);
       break;
     }
     default:
     {
       break;
     }
  }

  pConsole->io_hprintf( pConsole->io_handle, "\n\r>");
#endif

  return;
}

void avnet_console_help( avnet_console_t *pConsole )
{
  pConsole->io_hprintf( pConsole->io_handle, "\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "------------------------------------------------------\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "--    Xilinx Zynq-7000 EPP Video and Imaging Kit    --\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "--      1080P60 Real-Time Camera Demonstration      --\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "------------------------------------------------------\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "General Commands:\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\thelp       Print the Top-Level menu Help Screen \n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tquit       Exit console (if applicable)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tverbose    Toggle verbosity on/off\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tdelay      Wait for specified delay\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tmem        Memory accesses\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "I2C Commands\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tiic0       IIC accesses on FMC-IPMI I2C chain\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tiic1       IIC accesses on FMC-IMAGEON I2C chain\n\r");
////pConsole->io_hprintf( pConsole->io_handle, "\tiic2       IIC accesses on ML605 DVI I2C chain\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "VITA Commands\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tvita       VITA commands (init, status, ...)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tvspi       SPI accesses to VITA sensor\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tvreg       Memory accesses to VITA receiver\n\r");
  //pConsole->io_hprintf( pConsole->io_handle, "\ttrig       Trigger configuration (off/stress/internal/external/manual)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tagain      Analog gain (0-10)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tdgain      Digital gain (0-4095) where 128 corresponds to 1.00\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\texposure   Exposure time (1-99) in percentage of frame period (16.66 msec)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "iPIPE Commands\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tdpc        Defect Pixel Correction configuration\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tcfa        Color Filter Array Interpolation configuration\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tstats|s    Image Statistics\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\t  awb      Auto White Balance (on|off)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\t  agc      Auto Gain Control (on|off)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\t  aec      Auto Exposure Control (on|off)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\t  geq      Gamma Equalization (on|off)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tnoise      Noise Reduction Threshold (0-255)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tenhance    Edge Enhancement Threshold (0-32768)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\thalo       Halo Suppression Threshold (0-32768)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tccm        Color Correction Matrix configuration\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tgamma      Gamma Correction configuration\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "Video Source Selection\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tvideo      Video Source Initialization and Selection (vita, ipipe)\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "Video Frame Buffer Commands\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tvdma       Control frame buffer (start/stop/fill)\n\r");
#if defined(LINUX_CODE)
  pConsole->io_hprintf( pConsole->io_handle, "\trec        Save frame buffer image to BMP file\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "\tplay       Fill frame buffer image from BMP file\n\r");
#endif // #if defined(LINUX_CODE)
  pConsole->io_hprintf( pConsole->io_handle, "\n\r");
  pConsole->io_hprintf( pConsole->io_handle, "------------------------------------------------------\n\r");

  return;
}

int avnet_console_get_line_poll( avnet_console_t *pConsole )
{
    int buffer_index;
    char character_copy = 0;
    u8 DataBuffer[MAX_LINE_LENGTH];
    unsigned int received_char_count = 0;
    //static unsigned int total_received_char_count = 0;

    // New characters come in one at a time ...
    DataBuffer[0] = (u8)pConsole->inchar;
    received_char_count = 1;

   for (buffer_index = 0; buffer_index < received_char_count; buffer_index++)
   {
      // Make sure that the line length has not been reached.
      if (pConsole->inline_count == (MAX_LINE_LENGTH-3))
      {
         // Force a line feed character, this is the end of the
         // line that is being polled for.
         pConsole->io_hprintf( pConsole->io_handle, "\r\n" );
         // Null terminate the string so that it is still a
         // valid string.
         pConsole->inline_buffer[pConsole->inline_count] = 0;
         // Reset the total character count in preparation for the
         // next line yet to be received.
         pConsole->inline_count = 0;
         // Return the total count of characters in the current line.
         return MAX_LINE_LENGTH;
      }
      // Get the next character that was received from the Uart Lite
      // device.
      character_copy = (char) DataBuffer[buffer_index];

      // Determine what action to take with the next received
      // character.
#if defined(LINUX_CODE)	  
      if (character_copy == '\r')
#else
      if (character_copy == '\n')
#endif	  
      {
         // Ignore it.
         ;
      }
#if defined(LINUX_CODE)	  
      else if (character_copy == '\n')
#else
      else if (character_copy == '\r')
#endif	  
      {
         // A line feed character has been encountered, this is the
         // end of the line that is being polled for.
         pConsole->io_hprintf( pConsole->io_handle, "\r\n" );
         // Null terminate the string so that it is still a
         // valid string.
         pConsole->inline_buffer[pConsole->inline_count] = 0;
         // Determine the number of characters that are in the line.
         received_char_count = pConsole->inline_count;
         // Reset the total character count in preparation for the
         // next line yet to be received.
         pConsole->inline_count = 0;
         // Return the total count of characters in the current line.
         return received_char_count;
      }
      // Check for backspace or delete key.
      else if ((character_copy == '\b') || (character_copy == 0x7F))
      {
         if (pConsole->inline_count > 0)
         {
            //outbyte('\b'); // Write backspace
            //outbyte(' ');  // Write space
            //outbyte('\b'); // Write backspace
            //pConsole->io_hprintf( pConsole->io_handle, "\b \b" );
            pConsole->io_hprintf( pConsole->io_handle, " \b" );
            pConsole->inline_count--;
            pConsole->inline_buffer[pConsole->inline_count] = 0;
         }
      }
      // Check for escape key or control-U.
      else if ((character_copy == 0x1b) || (character_copy == 0x15))
      {
         while (pConsole->inline_count > 0)
         {
            //outbyte('\b'); // Write backspace
            //outbyte(' ');  // Write space
            //outbyte('\b'); // Write backspace
            //pConsole->io_hprintf( pConsole->io_handle, "\b \b" );
            pConsole->io_hprintf( pConsole->io_handle, " \b" );
            pConsole->inline_count--;
            pConsole->inline_buffer[pConsole->inline_count] = 0;
         }
      }
      else
      {
         // Echo character back to the user.
         //pConsole->io_hprintf( pConsole->io_handle, "%c", character_copy );
         pConsole->inline_buffer[pConsole->inline_count] = character_copy;
         pConsole->inline_count++;
      }
   }

    return -1;
}

void avnet_console_verbose_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
      bDispSyntax = 1;
   }
   else if ( !strcmp(cargv[1],"ipipe") && cargc > 2 )
   {
	  if ( !strcmp(cargv[2],"on") || !strcmp(cargv[2],"1") )
	  {
		 fmc_imageon_demo.vipp.bVerbose = 1;
	  }
	  else
	  {
		 fmc_imageon_demo.vipp.bVerbose = 0;
	  }
   }
   else if ( cargc > 1 )
   {
      if ( !strcmp(cargv[1],"on") || !strcmp(cargv[1],"1") )
      {
         pConsole->verbose = 1;
         fmc_imageon_demo.bVerbose = 1;
      }
      else
      {
         pConsole->verbose = 0;
         fmc_imageon_demo.bVerbose = 0;
      }
   }

   pConsole->io_hprintf( pConsole->io_handle, "\tverbose = %s\n\r", pConsole->verbose ? "on" : "off" );

   if ( bDispSyntax )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tverbose on|1  => Enable verbose mode\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tverbose off   => Disable verbose mode\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tverbose ipipe on|1  => Enable verbose mode for ipipe\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tverbose ipipe off   => Disable verbose mode for ipipe\r\n" );
   }

   return;
}

void avnet_console_delay_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   Xuint32 delay;

   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
      bDispSyntax = 1;
   }
   else if ( cargc < 2 )
   {
     pConsole->io_hprintf( pConsole->io_handle, "\twaiting 1 sec\n\r" );
     sleep(1);
   }
   else
   {
      scanhex( cargv[1], &delay );
      if ( cargc < 3 )
      {
        pConsole->io_hprintf( pConsole->io_handle, "\twaiting %d sec\n\r", delay );
        sleep(delay);
      }
      else if ( strcmp( cargv[2], "sec") == 0 )
      {
         pConsole->io_hprintf( pConsole->io_handle, "\twaiting %d sec\n\r", delay );
         sleep(delay);
      }
      else if ( strcmp( cargv[2], "msec") == 0 )
      {
         pConsole->io_hprintf( pConsole->io_handle, "\twaiting %d msec\n\r", delay );
         usleep(1000*delay);
      }
      else if ( strcmp( cargv[2], "usec") == 0 )
      {
         pConsole->io_hprintf( pConsole->io_handle, "\twaiting %d usec\n\r", delay );
         usleep(delay);
      }
   }

   if ( bDispSyntax )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tdelay {#}         => Delay by specified number of seconds\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tdelay {#} sec     => Delay by specified number of seconds\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tdelay {#} msec    => Delay by specified number of milli-seconds\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tdelay {#} usec    => Delay by specified number of micro-seconds\r\n" );
   }


}

void avnet_console_mem_command( avnet_console_t *pConsole, int cargc, char ** cargv, Xuint32 base_address )
{
   Xuint32 *pMemory;

   Xuint32 address, address2;
   Xuint32 data, data2;
   Xuint32 mask;

   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
      bDispSyntax = 1;
   }
   else if ( cargc < 2 )
   {
      bDispSyntax = 1;
   }
   else
   {
      if ( strcmp( cargv[1], "read") == 0 )
      {
         if ( cargc < 3 )
         {
            bDispSyntax = 1;
         }
         else
         {
            scanhex(cargv[2],&address);
            if ( pConsole->verbose )
            {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%08X\n\r", address);
            }
            pMemory = (Xuint32 *)(base_address + address);
            data = *pMemory;
            pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X => 0x%08X\n\r", pMemory, data );
         }
      }
      else if ( strcmp( cargv[1], "write") == 0 )
      {
          if ( cargc < 4 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&address);
             scanhex(cargv[3],&data);
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%08X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%08X\n\r", data);
             }
             pMemory = (Xuint32 *)(base_address + address);
             *pMemory = data;
             pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", pMemory, data );
          }
      }
      else if ( strcmp( cargv[1], "poll") == 0 )
      {
          if ( cargc < 5 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&address);
             scanhex(cargv[3],&data);
             scanhex(cargv[4],&mask);
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%08X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%08X\n\r", data);
                pConsole->io_hprintf( pConsole->io_handle, "\tmask = 0x%08X\n\r", mask);
             }
             pMemory = (Xuint32 *)(base_address + address);
             do
             {
                data2 = *pMemory;
                pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X => 0x%08X (polling for 0x%08X & 0x%08X)\n\r", pMemory, data2, data, mask );
             }
             while ( data != (data2 & mask) );
          }
      }
      else if ( strcmp( cargv[1], "rmw") == 0 )
      {
          if ( cargc < 5 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&address);
             scanhex(cargv[3],&data);
             scanhex(cargv[4],&mask);
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%08X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%08X\n\r", data);
                pConsole->io_hprintf( pConsole->io_handle, "\tmask = 0x%08X\n\r", mask);
             }
             pMemory = (Xuint32 *)(base_address + address);
             // Read
             data2 = *pMemory;
             pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X => 0x%08X\n\r", pMemory, data2 );
             // Modify
             data2 &= ~mask;
             data2 |=  data;
             // Write
             *pMemory = data2;
             pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", pMemory, data2 );
          }
      }
      else if ( strcmp( cargv[1], "dump") == 0 )
      {
          if ( cargc < 4 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&address);
             scanhex(cargv[3],&address2);
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\tstart address = 0x%08X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tend   address = 0x%08X\n\r", address2);
             }
             for ( ; address <= address2; address += 4 )
             {
                pMemory = (Xuint32 *)(base_address + address);
                data = *pMemory;
                pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X => 0x%08X\n\r", pMemory, data );
             }
          }
      }
   }

   if ( bDispSyntax == 1 )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s read  {address}                 => Read from {address}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s write {address} {data}          => Write {data} to {address}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s rmw   {address} {data} {mask}   => Read from {address}, apply {mask}, then write {data}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s poll  {address} {data} {mask}   => Read from {address}, apply {mask}, until matches {data}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s dump  {address1} {address2}     => Read from {address1} to {address2}\n\r", cargv[0] );
   }

   return;
}

void avnet_console_iic_command( avnet_console_t *pConsole, int cargc, char ** cargv, fmc_iic_t *pIIC )
{
   Xuint32 tmp;
   Xuint8 device;
   Xuint8 address, address2;
   Xuint8 data, data2;
   Xuint8 mask;
   int num_bytes;

   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
      bDispSyntax = 1;
   }
   else if ( cargc < 2 )
   {
      bDispSyntax = 1;
   }
   else
   {
     if ( strcmp( cargv[1], "scan") == 0 )
     {
         Xuint8 dev;
         address = 0x00;
         pConsole->io_hprintf( pConsole->io_handle, "\tScanning for I2C devices ...\n\r" );
         for ( dev = 1; dev < 128; dev++ )
         {
          device = (dev<<1);
         num_bytes = pIIC->fpIicRead( pIIC, (device>>1), address, &data, 1 );
         if ( num_bytes > 0 )
         {
            pConsole->io_hprintf( pConsole->io_handle, "\t\t0x%02X\n\r", device );
         }
       }
     }
     else if ( strcmp( cargv[1], "read") == 0 )
     {
       if ( cargc < 4 )
       {
         bDispSyntax = 1;
       }
       else
       {
            scanhex(cargv[2],&tmp); device = (Xuint8)tmp;
         scanhex(cargv[3],&tmp); address = (Xuint8)tmp;
         if ( pConsole->verbose )
         {
               pConsole->io_hprintf( pConsole->io_handle, "\tdevice = 0x%02X\n\r", device);
               pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%02X\n\r", address);
         }
         num_bytes = pIIC->fpIicRead( pIIC, (device>>1), address, &data, 1 );
         pConsole->io_hprintf( pConsole->io_handle, "\t0x%02X[0x%02X] => 0x%02X\n\r", device, address, data );
       }
     }
     else if ( strcmp( cargv[1], "write") == 0 )
     {
        if ( cargc < 5 )
        {
          bDispSyntax = 1;
        }
        else
        {
             scanhex(cargv[2],&tmp); device = (Xuint8)tmp;
             scanhex(cargv[3],&tmp); address = (Xuint8)tmp;
             scanhex(cargv[4],&tmp); data = (Xuint8)tmp;
          if ( pConsole->verbose )
          {
                pConsole->io_hprintf( pConsole->io_handle, "\tdevice = 0x%02X\n\r", device);
            pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%02X\n\r", address);
            pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%02X\n\r", data);
          }
             num_bytes = pIIC->fpIicWrite( pIIC, (device>>1), address, &data, 1 );
          pConsole->io_hprintf( pConsole->io_handle, "\t0x%02X[0x%02X] <= 0x%02X\n\r", device, address, data );
        }
     }
     else if ( strcmp( cargv[1], "poll") == 0 )
     {
        if ( cargc < 6 )
        {
          bDispSyntax = 1;
        }
        else
        {
             scanhex(cargv[2],&tmp); device = (Xuint8)tmp;
             scanhex(cargv[3],&tmp); address = (Xuint8)tmp;
             scanhex(cargv[4],&tmp); data = (Xuint8)tmp;
          scanhex(cargv[5],&tmp); mask = (Xuint8)tmp;
          if ( pConsole->verbose )
          {
                pConsole->io_hprintf( pConsole->io_handle, "\tdevice = 0x%02X\n\r", device);
            pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%02X\n\r", address);
            pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%02X\n\r", data);
            pConsole->io_hprintf( pConsole->io_handle, "\tmask = 0x%02X\n\r", mask);
          }
          do
          {
                num_bytes = pIIC->fpIicRead( pIIC, (device>>1), address, &data2, 1 );
            pConsole->io_hprintf( pConsole->io_handle, "\t0x%02X[0x%02X] => 0x%02X (polling for 0x%02X & 0x%02X)\n\r", device, address, data2, data, mask );
          }
          while ( data != (data2 & mask) );
        }
     }
     else if ( strcmp( cargv[1], "rmw") == 0 )
     {
        if ( cargc < 6 )
        {
          bDispSyntax = 1;
        }
        else
        {
             scanhex(cargv[2],&tmp); device = (Xuint8)tmp;
             scanhex(cargv[3],&tmp); address = (Xuint8)tmp;
             scanhex(cargv[4],&tmp); data = (Xuint8)tmp;
             scanhex(cargv[5],&tmp); mask = (Xuint8)tmp;
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\tdevice = 0x%02X\n\r", device);
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%02X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%02X\n\r", data);
                pConsole->io_hprintf( pConsole->io_handle, "\tmask = 0x%02X\n\r", mask);
             }
          // Read
             num_bytes = pIIC->fpIicRead( pIIC, (device>>1), address, &data2, 1 );
          pConsole->io_hprintf( pConsole->io_handle, "\t0x%02X[0x%02X] => 0x%02X\n\r", device, address, data2 );
          // Modify
          data2 &= ~mask;
          data2 |=  data;
          // Write
             num_bytes = pIIC->fpIicWrite( pIIC, (device>>1), address, &data2, 1 );
          pConsole->io_hprintf( pConsole->io_handle, "\t0x%02X[0x%02X] <= 0x%02X\n\r", device, address, data2 );
        }
     }
     else if ( strcmp( cargv[1], "dump") == 0 )
     {
        if ( cargc < 5 )
        {
          bDispSyntax = 1;
        }
        else
        {
             scanhex(cargv[2],&tmp); device = (Xuint8)tmp;
             scanhex(cargv[3],&tmp); address = (Xuint8)tmp;
             scanhex(cargv[4],&tmp); address2 = (Xuint8)tmp;
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\tdevice = 0x%02X\n\r", device);
                pConsole->io_hprintf( pConsole->io_handle, "\taddress(start) = 0x%02X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\taddress( end ) = 0x%02X\n\r", address2);
             }
          for ( ; address <= address2; address += 1 )
          {
                num_bytes = pIIC->fpIicRead( pIIC, (device>>1), address, &data, 1 );
            pConsole->io_hprintf( pConsole->io_handle, "\t0x%02X[0x%02X] => 0x%02X\n\r", device, address, data );
          }
        }
     }
      else if ( strcmp( cargv[1], "gpio") == 0 )
      {
         Xuint32 gpio;
         if ( cargc < 3 )
         {
            num_bytes = pIIC->fpGpoRead( pIIC, &gpio );
            pConsole->io_hprintf( pConsole->io_handle, "\tGPIO => 0x%02X\n\r", gpio );
         }
         else
         {
             scanhex(cargv[2],&gpio);
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%02X\n\r", gpio);
             }
             num_bytes = pIIC->fpGpoWrite( pIIC, gpio );
             pConsole->io_hprintf( pConsole->io_handle, "\tGPIO <= 0x%02X\n\r", gpio );
         }
     }
     else
     {
        bDispSyntax = 1;
     }
   }

   if ( bDispSyntax == 1 )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s scan                                    => Scan for I2C devices\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s read  {device} {address}                => For {device}, Read from {address}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s write {device} {address} {data}         => For {device}, Write {data} to {address}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s rmw   {device} {address} {data} {mask}  => For {device}, Read from {address}, apply {mask}, then write {data}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s poll  {device} {address} {data} {mask}  => For {device}, Read from {address}, apply {mask}, until matches {data}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s dump  {device} {address1} {address2}    => For {device}, Read from {address1} to {address2}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s gpio  {data}\n\r", cargv[0] );
   }

   return;
}

void avnet_console_vita_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( (cargc == 2) && !strcmp(cargv[1],"stat") )
   {
      fmc_imageon_vita_receiver_get_status( &(fmc_imageon_demo.vita_receiver), &(fmc_imageon_demo.vita_status_t1), 1 );
   }
   else if ( (cargc == 3) && !strcmp(cargv[1],"init") )
   {
      if ( !strcmp(cargv[2],"on") )
      {
         pConsole->io_hprintf( pConsole->io_handle, "\tExecuting init sequences SEQ00-SEQ06\r\n" );
         fmc_imageon_vita_receiver_sensor_initialize( &(fmc_imageon_demo.vita_receiver), SENSOR_INIT_ENABLE, 1 );
      }
      else if ( (cargc == 3) && !strcmp(cargv[1],"init") && !strcmp(cargv[2],"off") )
      {
         pConsole->io_hprintf( pConsole->io_handle, "\tExecuting init sequences SEQ07-SEQ10\r\n" );
         fmc_imageon_vita_receiver_sensor_initialize( &(fmc_imageon_demo.vita_receiver), SENSOR_INIT_DISABLE, 1 );
      }
      else if ( (cargc == 3) && !strcmp(cargv[1],"init") && !strcmp(cargv[2],"0") )
      {
         Xuint32 init_sequence;
         scanhex(cargv[2],&init_sequence);
         pConsole->io_hprintf( pConsole->io_handle, "\tExecuting init sequence SEQ%02d\r\n", init_sequence );
         fmc_imageon_vita_receiver_sensor_initialize( &(fmc_imageon_demo.vita_receiver), init_sequence, 1 );
      }
   }
   else
   {
      bDispSyntax = 1;
   }

   if ( bDispSyntax )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tvita init on  => Initialize VITA sensor (enable)\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tvita init off => Initialize VITA sensor (disable)\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\tvita init #   => Initialize VITA sensor (# = 0-10)\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                 Enable sequences:\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  0 => Assert/Deassert RESET_N pin\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  1 => Enable Clock Management - Part 1\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  2 => Verify PLL Lock Indicator\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  3 => Enable Clock Management - Part 2\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  4 => Required Register Upload\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  5 => Soft Power-Up\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  6 => Enable Sequencer\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                 Disable sequences:\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  7 => Disable Sequencer\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  8 => Soft Power-Down\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                  9 => Disable Clock Management - Part 2\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t                 10 => Disable Clock Management - Part 1\n\r" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvita stat    => Get status of VITA receiver\r\n" );
   }

   return;
}

void avnet_console_vita_spi_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   Xuint32 tmp;
   Xuint16 address, address2;
   Xuint16 data, data2;
   Xuint16 mask;

   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
      bDispSyntax = 1;
   }
   else if ( cargc < 2 )
   {
      bDispSyntax = 1;
   }
   else
   {
      if ( strcmp( cargv[1], "read") == 0 )
      {
         if ( cargc < 3 )
         {
            bDispSyntax = 1;
         }
         else
         {
            scanhex(cargv[2],&tmp); address = (Xuint16)tmp;
            if ( pConsole->verbose )
            {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%04X\n\r", address);
            }
            fmc_imageon_vita_receiver_spi_read( &(fmc_imageon_demo.vita_receiver), address, &data );
            pConsole->io_hprintf( pConsole->io_handle, "\t0x%04X => 0x%04X\n\r", address, data );
         }
      }
      else if ( strcmp( cargv[1], "write") == 0 )
      {
          if ( cargc < 4 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&tmp); address = (Xuint16)tmp;
             scanhex(cargv[3],&tmp); data = (Xuint16)tmp;
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%04X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%04X\n\r", data);
             }
             fmc_imageon_vita_receiver_spi_write( &(fmc_imageon_demo.vita_receiver), address, data );
             pConsole->io_hprintf( pConsole->io_handle, "\t0x%04X <= 0x%04X\n\r", address, data );
          }
      }
      else if ( strcmp( cargv[1], "poll") == 0 )
      {
          if ( cargc < 5 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&tmp); address = (Xuint16)tmp;
             scanhex(cargv[3],&tmp); data = (Xuint16)tmp;
             scanhex(cargv[4],&tmp); mask = (Xuint16)tmp;
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%04X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%04X\n\r", data);
                pConsole->io_hprintf( pConsole->io_handle, "\tmask = 0x%04X\n\r", mask);
             }
             do
             {
                fmc_imageon_vita_receiver_spi_read( &(fmc_imageon_demo.vita_receiver), address, &data );
                pConsole->io_hprintf( pConsole->io_handle, "\t0x%04X => 0x%04X (polling for 0x%04X & 0x%04X)\n\r", address, data2, data, mask );
             }
             while ( data2 != (data & mask) );
          }
      }
      else if ( strcmp( cargv[1], "rmw") == 0 )
      {
          if ( cargc < 5 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&tmp); address = (Xuint16)tmp;
             scanhex(cargv[3],&tmp); data = (Xuint16)tmp;
             scanhex(cargv[4],&tmp); mask = (Xuint16)tmp;
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\taddress = 0x%04X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tdata = 0x%04X\n\r", data);
                pConsole->io_hprintf( pConsole->io_handle, "\tmask = 0x%04X\n\r", mask);
             }
             // Read
             fmc_imageon_vita_receiver_spi_read( &(fmc_imageon_demo.vita_receiver), address, &data2 );
             pConsole->io_hprintf( pConsole->io_handle, "\t0x%04X => 0x%04X\n\r", address, data2 );
             // Modify
           data2 &= ~mask;
             data2 |=  data;
             // Write
             fmc_imageon_vita_receiver_spi_write( &(fmc_imageon_demo.vita_receiver), address, data2 );
             pConsole->io_hprintf( pConsole->io_handle, "\t0x%04X <= 0x%04X\n\r", address, data2 );
          }
      }
      else if ( strcmp( cargv[1], "dump") == 0 )
      {
          if ( cargc < 4 )
          {
             bDispSyntax = 1;
          }
          else
          {
             scanhex(cargv[2],&tmp); address = (Xuint16)tmp;
             scanhex(cargv[3],&tmp); address2 = (Xuint16)tmp;
             if ( pConsole->verbose )
             {
                pConsole->io_hprintf( pConsole->io_handle, "\tstart address = 0x%04X\n\r", address);
                pConsole->io_hprintf( pConsole->io_handle, "\tend   address = 0x%04X\n\r", address2);
             }
             for ( ; address <= address2; address += 1 )
             {
                fmc_imageon_vita_receiver_spi_read( &(fmc_imageon_demo.vita_receiver), address, &data );
                pConsole->io_hprintf( pConsole->io_handle, "\t0x%04X => 0x%04X\n\r", address, data );
             }
          }
      }
   }

   if ( bDispSyntax == 1 )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax:\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s read  {address}               => Read from {address}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s write {address} {data}        => Write {data} to {address}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s rmw   {address} {data} {mask} => Read from {address}, apply {mask}, then write {data}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s poll  {address} {data} {mask} => Read from {address}, apply {mask}, until matches {data}\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s dump  {address1} {address2}   => Read from {address1} to {address2}\n\r", cargv[0] );
   }

   return;
}

void avnet_console_vita_trigger_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   Xuint32 vitaTrigGenControl;
   Xuint32 vitaTrigGenDefaultFreq;
   Xuint32 vitaTrigGenTrig0High;
   Xuint32 vitaTrigGenTrig0Low;
   Xuint32 vitaTrigGenTrig1High;
   Xuint32 vitaTrigGenTrig1Low;
   Xuint32 vitaTrigGenTrig2High;
   Xuint32 vitaTrigGenTrig2Low;

   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
      bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
      if ( !strcmp(cargv[1],"manual") )
      {
         pConsole->io_hprintf( pConsole->io_handle, "\tTrigger = manual (pulse) ...\r\n" );
         vitaTrigGenControl  = fmc_imageon_vita_receiver_reg_read( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X => 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         vitaTrigGenControl |=  0x00000020; // manual trigger mode
         vitaTrigGenControl |=  0x00000100; // enable manual trigger
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         vitaTrigGenControl &= ~0x00000100; // disable manual trigger
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
      }
      else if ( !strcmp(cargv[1],"stress") )
      {
         pConsole->io_hprintf( pConsole->io_handle, "\tTrigger = stress (trigger[2:0] generating 1 cycle pulses at 8 cycles) ...\r\n" );
         vitaTrigGenDefaultFreq = 8-2;
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_DEFAULT_FREQ_REG, vitaTrigGenDefaultFreq );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_DEFAULT_FREQ_REG, vitaTrigGenDefaultFreq );
         vitaTrigGenTrig0High   = 0; // 1 cycle pulse
         vitaTrigGenTrig0Low    = 0;
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_HIGH_REG  , vitaTrigGenTrig0High   );
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_LOW_REG   , vitaTrigGenTrig0Low    );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_HIGH_REG, vitaTrigGenTrig0High );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_LOW_REG , vitaTrigGenTrig0Low  );
         vitaTrigGenTrig1High   = 0; // 1 cycle pulse
         vitaTrigGenTrig1Low    = 0;
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG1_HIGH_REG  , vitaTrigGenTrig1High   );
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG1_LOW_REG   , vitaTrigGenTrig1Low    );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG1_HIGH_REG, vitaTrigGenTrig1High );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG1_LOW_REG , vitaTrigGenTrig1Low  );
         vitaTrigGenTrig2High   = 0; // 1 cycle pulse
         vitaTrigGenTrig2Low    = 0;
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG2_HIGH_REG  , vitaTrigGenTrig2High   );
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG2_LOW_REG   , vitaTrigGenTrig2Low    );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG2_HIGH_REG, vitaTrigGenTrig2High );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG2_LOW_REG , vitaTrigGenTrig2Low  );

         vitaTrigGenControl     = 0x01000017; // internal trigger, enable trigger[2:0], update triggen_cnt registers
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         vitaTrigGenControl     = 0x00000017; // internal trigger, enable trigger[2:0]
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
      }
      else if ( !strcmp(cargv[1],"internal") )
      {
         Xuint32 trigFramesPerSec = 60;
         Xuint32 trigDutyCycle    = fmc_imageon_demo.vita_exposure;
         vitaTrigGenDefaultFreq = (((1920+88+44+148)*(1080+4+5+36))>>2) - 2;
         //vitaTrigGenDefaultFreq = (((1920+88+44+132)*(1080+4+5+36))>>2) - 2;

         if ( cargc > 2 )
         {
            scanhex(cargv[2],&trigFramesPerSec);
            vitaTrigGenDefaultFreq = ((148500000/trigFramesPerSec)>>2) - 2;
         }
         if ( cargc > 3 )
         {
            scanhex(cargv[3],&trigDutyCycle);
         }
         fmc_imageon_demo.vita_exposure = trigDutyCycle;
         pConsole->io_hprintf( pConsole->io_handle, "\tTrigger = internal (%d fps, duty cycle = %d \%, period = %d cycles)...\r\n", trigFramesPerSec, trigDutyCycle, vitaTrigGenDefaultFreq+2 );

         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_DEFAULT_FREQ_REG, vitaTrigGenDefaultFreq );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_DEFAULT_FREQ_REG, vitaTrigGenDefaultFreq );
         //vitaTrigGenTrig0High   = vitaTrigGenDefaultFreq>>1; // half frame width
         //vitaTrigGenTrig0High   = (vitaTrigGenDefaultFreq * trigDutyCycle)/100; // positive polarity
         vitaTrigGenTrig0High   = (vitaTrigGenDefaultFreq * (100-trigDutyCycle))/100; // negative polarity
         vitaTrigGenTrig0Low    = 1;
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_HIGH_REG  , vitaTrigGenTrig0High   );
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_LOW_REG   , vitaTrigGenTrig0Low    );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_HIGH_REG, vitaTrigGenTrig0High );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_TRIG0_LOW_REG , vitaTrigGenTrig0Low  );

         vitaTrigGenControl     = 0x31000011; // invert trigger[2:0], internal trigger, enable trigger[0], update triggen_cnt registers
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         vitaTrigGenControl     = 0x30000011; // invert trigger[2:0], internal trigger, enable trigger[0]
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
      }
      else if ( !strcmp(cargv[1],"external") )
      {
          pConsole->io_hprintf( pConsole->io_handle, "\tTrigger = external ...\r\n" );

          vitaTrigGenControl     = 0x00000047; // external trigger, enable trigger[2:0]
          fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
          if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
      }
      else
      {
         pConsole->io_hprintf( pConsole->io_handle, "\tTrigger = off ...\r\n" );

         vitaTrigGenControl     = 0x00000000;
         fmc_imageon_vita_receiver_reg_write( &(fmc_imageon_demo.vita_receiver), FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
         if ( pConsole->verbose ) pConsole->io_hprintf( pConsole->io_handle, "\t0x%08X <= 0x%08X\n\r", FMC_IMAGEON_VITA_RECEIVER_TRIGGEN_CONTROL_REG, vitaTrigGenControl );
      }
   }

   if ( bDispSyntax )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\ttrig off          => Disable all triggers\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\ttrig stress       => Enable all triggers (all triggers generate 1 cycle pulse at each 8 cycles\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\ttrig internal [#] => Enable trigger0 in specified [#] Hz\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\ttrig external     => Enable trigger0 in external mode\r\n" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\ttrig manual       => Simulate external trigger\r\n" );
   }

   return;
}

#define VITA_AUTOEXP_ON_QTY  2
Xuint16 local_vita_autoexp_on_seq[VITA_AUTOEXP_ON_QTY][3] = {
   // Auto-Exposure ON
   {160, 0x0001, 0x0001}, // [  4] Auto Exposure enable
   {161, 0x03FF, 0x00B8}  // [9:0] Desired Intensity Level
   };

#define VITA_AUTOEXP_OFF_QTY  1
Xuint16 local_vita_autoexp_off_seq[VITA_AUTOEXP_OFF_QTY][3] = {
   // Auto-Exposure OFF
   {160, 0x0001, 0x0000}, // [  4] Auto Exposure disable
   {161, 0x03FF, 0x00B8}  // [9:0] Desired Intensity Level
   };

void avnet_console_vita_aec_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   Xuint16 **seqData;
   int seqLen;
   int bDispSyntax = 0;
   Xuint32 desiredLevel;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
      bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
      if ( !strcmp(cargv[1],"on") || !strcmp(cargv[1],"1") )
      {
    	  if ( cargc > 2 )
    	  {
            scanhex(cargv[2], &desiredLevel);
            local_vita_autoexp_on_seq[1][2] = desiredLevel;
    	  }
          seqData = local_vita_autoexp_on_seq;
          seqLen = VITA_AUTOEXP_ON_QTY;
    	  fmc_imageon_demo.vita_aec = 1;
      }
      else
      {
          seqData = local_vita_autoexp_off_seq;
          seqLen = VITA_AUTOEXP_OFF_QTY;
    	  fmc_imageon_demo.vita_aec = 0;
      }
      if ( fmc_imageon_demo.bVerbose)
      {
         fmc_imageon_vita_receiver_spi_display_sequence( &(fmc_imageon_demo.vita_receiver), seqData, seqLen );
      }
      fmc_imageon_vita_receiver_spi_write_sequence( &(fmc_imageon_demo.vita_receiver), seqData, seqLen );
      if ( !fmc_imageon_demo.vita_aec )
      {
         fmc_imageon_vita_receiver_set_analog_gain(&(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_again, fmc_imageon_demo.bVerbose);
         fmc_imageon_vita_receiver_set_digital_gain(&(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_dgain, fmc_imageon_demo.bVerbose);
         fmc_imageon_vita_receiver_set_exposure_time( &(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_exposure, fmc_imageon_demo.bVerbose);
         fmc_imageon_demo.vita_receiver.uAnalogGain = fmc_imageon_demo.vita_again;
         fmc_imageon_demo.vita_receiver.uDigitalGain = fmc_imageon_demo.vita_dgain;
         fmc_imageon_demo.vita_receiver.uExposureTime = fmc_imageon_demo.vita_exposure;
      }
   }

   if ( bDispSyntax == 1 )
   {
      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax:\n\r" );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s on    => Enable VITA AEC\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s off   => Disable VITA AEC\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s trig  => Global Reset\n\r", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s       => Display status of VITA AEC\n\r", cargv[0] );
      return;
   }

   pConsole->io_hprintf( pConsole->io_handle, "\tVITA AEC = %s\n\r", fmc_imageon_demo.vita_aec ? "on" : "off" );

   return;
}

void avnet_console_vita_again_command(avnet_console_t *pConsole, int cargc, char ** cargv) {
	int bDispSyntax = 0;

	if (cargc > 1 && !strcmp(cargv[1], "help")) {
		bDispSyntax = 1;
	} else if (cargc == 1) {
		pConsole->io_hprintf(pConsole->io_handle, "\tagain = %d\r\n", fmc_imageon_demo.vita_again );
	} else if (cargc == 2) {
		scanhex(cargv[1], &(fmc_imageon_demo.vita_again));
		fmc_imageon_vita_receiver_set_analog_gain(&(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_again, fmc_imageon_demo.bVerbose);
	} else {
		bDispSyntax = 1;
	}

	if (bDispSyntax) {
		pConsole->io_hprintf(pConsole->io_handle, "\tSyntax :\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\tagain    => Display analog gain\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\tagain #  => Set analog gain(# = 0-10)\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             0 = 1.00\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             1 = 1.14\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             2 = 1.33\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             3 = 1.60\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             4 = 2.00\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             5 = 2.29\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             6 = 2.67\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             7 = 3.20\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             8 = 4.00\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             9 = 5.33\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t            10 = 8.00\r\n");
	}

	return;
}

void avnet_console_vita_dgain_command(avnet_console_t *pConsole, int cargc, char ** cargv) {
	int bDispSyntax = 0;

	if (cargc > 1 && !strcmp(cargv[1], "help")) {
		bDispSyntax = 1;
	} else if (cargc == 1) {
		pConsole->io_hprintf(pConsole->io_handle, "\tdgain = %d\r\n", fmc_imageon_demo.vita_dgain );
	} else if (cargc == 2) {
		scanhex(cargv[1], &(fmc_imageon_demo.vita_dgain));
		fmc_imageon_vita_receiver_set_digital_gain(&(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_dgain, fmc_imageon_demo.bVerbose);
	} else {
		bDispSyntax = 1;
	}

	if (bDispSyntax) {
		pConsole->io_hprintf(pConsole->io_handle, "\tSyntax :\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\tdgain    => Display digital gain\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\tdgain #  => Set digital gain(# = 0-4095)\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t               0 = 0.00\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t               ...\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t             128 = 1.00\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t               ...\r\n");
	}

	return;
}

void avnet_console_vita_exposure_command(avnet_console_t *pConsole, int cargc, char ** cargv) {
	int bDispSyntax = 0;

	if (cargc > 1 && !strcmp(cargv[1], "help")) {
		bDispSyntax = 1;
	} else if (cargc == 1) {
		pConsole->io_hprintf(pConsole->io_handle, "\texposure = %d\r\n", fmc_imageon_demo.vita_exposure );
	} else if (cargc == 2) {
		scanhex(cargv[1], &(fmc_imageon_demo.vita_exposure));
        fmc_imageon_vita_receiver_set_exposure_time( &(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_exposure, fmc_imageon_demo.bVerbose);
	} else {
		bDispSyntax = 1;
	}

	if (bDispSyntax) {
		pConsole->io_hprintf(pConsole->io_handle, "\tSyntax :\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\texposure    => Display exposure\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\texposure #  => Set Exposure in percentage of frame time (16.6msec)\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t                1% => 0.16 msec\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t                      ...\r\n");
		pConsole->io_hprintf(pConsole->io_handle, "\t\t               99% => 16.5 msec\r\n");
	}

	return;
}

//void avnet_console_mfs_command( avnet_console_t *pConsole, int cargc, char ** cargv )
//{
//   int bDispSyntax = 0;
//
//   if ( cargc > 1 && !strcmp(cargv[1],"help") )
//   {
//      bDispSyntax = 1;
//   }
//   else if ( cargc > 1 )
//   {
//      if ( !strcmp(cargv[1],"list") )
//      {
//          pConsole->io_hprintf( pConsole->io_handle, "Listing content of file system ...\r\n" );
//
//          mfs_ls_r(2); // output sent to serial output
//      }
//   }
//
//   if ( bDispSyntax )
//   {
//      pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
//      pConsole->io_hprintf( pConsole->io_handle, "\t\tmfs list          => List contents of MFS file system\r\n" );
//   }
//
//   return;
//}


void avnet_console_ipipe_dpc_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint32 age;
   Xuint32 svar;
   Xuint32 tvar;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  vipp_dpc_status( &(fmc_imageon_demo.vipp) );
	  }
	  else if ( !strcmp(cargv[1],"set") && (cargc == 5) )
	  {
         scanhex( cargv[2], &tvar );
		 pConsole->io_hprintf( pConsole->io_handle, "Setting temporal variance to %d\n\r", tvar );
		 scanhex( cargv[3], &svar );
		 pConsole->io_hprintf( pConsole->io_handle, "Setting spatial variance to %d\n\r", svar );
		 scanhex( cargv[4], &age );
		 pConsole->io_hprintf( pConsole->io_handle, "Setting pixel age to %d\n\r", age );
		 vipp_dpc_config( &(fmc_imageon_demo.vipp), 1, tvar, svar, age );
	  }
	  else if ( !strcmp(cargv[1],"tvar") && (cargc == 3) )
	  {
		 scanhex( cargv[2], &tvar );
		 pConsole->io_hprintf( pConsole->io_handle, "Setting temporal variance to %d\n\r", tvar );
		 vipp_dpc_temporal_var( &(fmc_imageon_demo.vipp), tvar );
	  }
	  else if ( !strcmp(cargv[1],"svar") && (cargc == 3) )
	  {
		 scanhex( cargv[2], &svar );
		 pConsole->io_hprintf( pConsole->io_handle, "Setting spatial variance to %d\n\r", svar );
		 vipp_dpc_spatial_var( &(fmc_imageon_demo.vipp), svar );
	  }
	  else if ( !strcmp(cargv[1],"age") && (cargc == 3) )
	  {
		 scanhex( cargv[2], &age );
		 pConsole->io_hprintf( pConsole->io_handle, "Setting pixel age to %d\n\r", age );
		 vipp_dpc_pixel_age( &(fmc_imageon_demo.vipp), age );
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tdpc status    => Display status of DPC core\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tdpc set # # # => Set Temporal Var, Spatial Var, Pixel Age thresholds\n\r" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tdpc tvar #    => Set Temporal Var threshold of DPC core\n\r" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tdpc svar #    => Set Spatial Var threshold of DPC core\n\r" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tdpc age  #    => Set Pixel Age threshold of DPC core\n\r" );
   }

   return;
}

void avnet_console_ipipe_cfa_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint32 bayer = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  vipp_cfa_status( &(fmc_imageon_demo.vipp) );
	  }
	  else if ( !strcmp(cargv[1],"bayer") && (cargc > 2) )
	  {
         scanhex( cargv[2], &bayer );
         pConsole->io_hprintf( pConsole->io_handle, "Setting bayer to %d\n\r", bayer );
         vipp_bayer( &(fmc_imageon_demo.vipp), bayer );
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tcfa status    => Display status of CFA core\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tcfa bayer #   => Set CFA bayer pattern (0-3)\r\n" );
   }

   return;
}

void avnet_console_ipipe_stats_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   int bStatus = 0;
   Xuint32 histScale;
   float underExp, overExp;
   char szFactor[8];

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc == 1 )
   {
      bStatus = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  bStatus = 1;
	  }
	  else if ( !strcmp(cargv[1],"set") && cargc > 3 )
	  {
		  if ( !strcmp(cargv[2],"scale") )
		  {
             scanhex( cargv[3], &histScale );
		     pConsole->io_hprintf( pConsole->io_handle, "Setting histogram scale to %d\n\r", histScale );
		     fmc_imageon_demo.vipp.hist_scale = histScale;
		  }
		  else if ( !strcmp(cargv[2],"underexp") )
		  {
             sscanf( cargv[3], "%f", &underExp );
             sprintf( szFactor, "%f", underExp );
		     pConsole->io_hprintf( pConsole->io_handle, "Setting under exposure factor to %s\n\r", szFactor );
		     fmc_imageon_demo.vipp.exp_factor_under = underExp;
		  }
		  else if ( !strcmp(cargv[2],"overexp") )
		  {
             sscanf( cargv[3], "%f", &overExp );
             sprintf( szFactor, "%f", overExp );
		     pConsole->io_hprintf( pConsole->io_handle, "Setting over exposure factor to %s\n\r", szFactor );
		     fmc_imageon_demo.vipp.exp_factor_over = overExp;
		  }
	  }
#if defined(LINUX_CODE)
	  else if ( !strcmp(cargv[1],"log") )
	  {
		  pthread_mutex_lock( &(fmc_imageon_demo.vipp.stats_handler_mutex) ); // Enter critical section
          {
		      int fd_bmp;
		      //
		      int n;
		      //
		      Xuint32 height = 256;
		      Xuint32 width = STATS_HIST_DEPTH;
		      Xint32 level, idx, ramp;
		      Xuint8 luma_hist_norm[STATS_HIST_DEPTH];
		      int hist_scale = fmc_imageon_demo.vipp.hist_scale;
		      int color;
		      Xuint8 rgb_hist_norm[3][STATS_HIST_DEPTH];
		      Xuint8 bmp24Line[STATS_HIST_DEPTH * 3];
#if STATS_HIST_DEPTH == 256
		      char bmp24Header[54] = { 0x42,
		  			0x4D, // MAGIC ('B' 'M')
		  			0x36, 0x60, 0x09, 0x00, // FILE SIZE ((800*256*3) + 0x36)
		  			0x00, 0x00, // RSVD
		  			0x00, 0x00, // RSVD
		  			0x36, 0x00, 0x00, 0x00, // IMAGE OFFSET (54)
		  			0x28, 0x00, 0x00, 0x00, // DIB_HEADER SIZE (40)
		  			0x00, 0x01, 0x00, 0x00, // WIDTH (256)
		  			0x20, 0x03, 0x00, 0x00, // HEIGHT (800)
		  			0x01, 0x00, // COLOR PLANES (1)
		  			0x18, 0x00, // BPP (24)
		  			0x00, 0x00, 0x00, 0x00, // COMPRESSION METHOD
		  			0x00, 0x60, 0x09, 0x00, // IMAGE SIZE (800*256*3)
		  			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		  			0x00, 0x00, 0x00, 0x00, 0x00 };
#endif // #if STATS_HIST_DEPTH == 256
#if STATS_HIST_DEPTH == 1024
		      char bmp24Header[54] = { 0x42,
		  			0x4D, // MAGIC ('B' 'M')
		  			0x36, 0x80, 0x25, 0x00, // FILE SIZE ((800*1024*3) + 0x36)
		  			0x00, 0x00, // RSVD
		  			0x00, 0x00, // RSVD
		  			0x36, 0x00, 0x00, 0x00, // IMAGE OFFSET (54)
		  			0x28, 0x00, 0x00, 0x00, // DIB_HEADER SIZE (40)
		  			0x00, 0x04, 0x00, 0x00, // WIDTH (1024)
		  			0x20, 0x03, 0x00, 0x00, // HEIGHT (800)
		  			0x01, 0x00, // COLOR PLANES (1)
		  			0x18, 0x00, // BPP (24)
		  			0x00, 0x00, 0x00, 0x00, // COMPRESSION METHOD
		  			0x00, 0x80, 0x25, 0x00, // IMAGE SIZE (800*1024*3)
		  			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		  			0x00, 0x00, 0x00, 0x00, 0x00 };
#endif // #if STATS_HIST_DEPTH == 1024

			  // Open BMP file
		      fd_bmp = open(cargv[2], O_CREAT | O_RDWR);
			  if ( fd_bmp == -1 )
			  {
				  pConsole->io_hprintf( pConsole->io_handle, "\tERROR : failed to open %s\n", cargv[1] );
				  return;
			  }

			  // Write image to BMP file
			  if ( write(fd_bmp, (char *)bmp24Header, sizeof(bmp24Header)) == -1 )
			  {
				 pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing header to file %s\n\r", cargv[1]);
			  }

		      ////////////////////////////////
		      // RGB HISTROGRAMs
		      ////////////////////////////////

		      for ( color = 2; color >= 0; color-- )
		      {
				  // Normalize histogram
				  for ( idx = 0; idx < STATS_HIST_DEPTH; idx ++ )
				  {
					  rgb_hist_norm[color][idx] = (fmc_imageon_demo.vipp.stats_handler_rgb_hist[color][idx] >> hist_scale);
					  if ( rgb_hist_norm[color][idx] == 0 && fmc_imageon_demo.vipp.stats_handler_rgb_hist[color][idx] > 0 )
						  rgb_hist_norm[color][idx] = 1;
				  }

				  // Open BMP file
				  {
					 // draw a reference ramp on bottom 25 rows
					 for (level = 0; level < 25; level ++)
					 {
						for (idx = 0; idx < width; idx++)
						{
							bmp24Line[(3 * idx) + 0] = 0;
							bmp24Line[(3 * idx) + 1] = 0;
							bmp24Line[(3 * idx) + 2] = 0;
#if STATS_HIST_DEPTH == 256
							ramp = idx;
#endif
#if STATS_HIST_DEPTH == 1024
							ramp = idx>>2;
#endif
							if ( color == 0 ) bmp24Line[(3 * idx) + 2] = ramp;
							if ( color == 1 ) bmp24Line[(3 * idx) + 1] = ramp;
							if ( color == 2 ) bmp24Line[(3 * idx) + 0] = ramp;
						}
						if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
						{
						   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
						   break;
						}
					 }
					 // draw histogram in middle of image
					 //for (level = 0; level < height-50; level++)
					 for (level = 0; level < 125; level++)
					 {
						//pConsole->io_hprintf( pConsole->io_handle, "\t[row=%d] lineAddress = 0x%08X\n\r", row, lineAddress );
						for (idx = 0; idx < width; idx++)
						{
						   if ( rgb_hist_norm[color][idx] > level )
						   {
							  bmp24Line[(3 * idx) + 0] = 0xFF;
							  bmp24Line[(3 * idx) + 1] = 0xFF;
							  bmp24Line[(3 * idx) + 2] = 0xFF;
						   }
						   else
						   {
							  bmp24Line[(3 * idx) + 0] = 0x00;
							  bmp24Line[(3 * idx) + 1] = 0x00;
							  bmp24Line[(3 * idx) + 2] = 0x00;
						   }
						}
						if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
						{
						   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
						   break;
						}
					 }
					 // draw status of under/over exposure in top 25 rows
					 for (level = 0; level < 25; level ++)
					 {
						// too low (?)
						for (idx = 0; idx < width*0.25; idx++)
						{
							bmp24Line[(3 * idx) + 0] = 0;
							bmp24Line[(3 * idx) + 1] = 0;
							bmp24Line[(3 * idx) + 2] = 0;
						}
						// OK
						for (idx = width*0.25; idx < width*0.75; idx++)
						{
							bmp24Line[(3 * idx) + 0] = 0;
							bmp24Line[(3 * idx) + 1] = 0;
							bmp24Line[(3 * idx) + 2] = 0;
							if ( !fmc_imageon_demo.vipp.stats_handler_rgb_saturated[color] )
							{
							   bmp24Line[(3 * idx) + 1] = 0xFF; // green
							}
						}
						// saturated
						for (idx = width*0.75; idx < width; idx++)
						{
							bmp24Line[(3 * idx) + 0] = 0;
							bmp24Line[(3 * idx) + 1] = 0;
							bmp24Line[(3 * idx) + 2] = 0;
							if ( fmc_imageon_demo.vipp.stats_handler_rgb_saturated[color] )
							{
							   bmp24Line[(3 * idx) + 2] = 0xFF; // red
							}
						}
						if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
						{
						   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
						   break;
						}
					 }
					 // draw a spacer
					 for (level = 0; level < 25; level ++)
					 {
						for (idx = 0; idx < width; idx++)
						{
							bmp24Line[(3 * idx) + 0] = 0xFF;
							bmp24Line[(3 * idx) + 1] = 0xFF;
							bmp24Line[(3 * idx) + 2] = 0xFF;
						}
						if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
						{
						   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
						   break;
						}
					 }
				  }
		      }

		      ////////////////////////////////
		      // LUMA HISTROGRAM
		      ////////////////////////////////

		      // Normalize luma histogram
		      for ( idx = 0; idx < STATS_HIST_DEPTH; idx ++ )
		      {
		    	  luma_hist_norm[idx] = (fmc_imageon_demo.vipp.stats_handler_luma_hist[idx] >> hist_scale);
		    	  if ( luma_hist_norm[idx] == 0 && fmc_imageon_demo.vipp.stats_handler_luma_hist[idx] > 0 )
		    		  luma_hist_norm[idx] = 1;

                  //pConsole->io_hprintf( pConsole->io_handle, "\tstats_handler_luma_hist[%03d] 0x%08X (%d)\n\r", idx, fmc_imageon_demo.vipp.stats_handler_luma_hist[idx], luma_hist_norm[idx] );
		      }

			  {
				 // draw a reference ramp on bottom 25 rows
                 for (level = 0; level < 25; level ++)
                 {
 					for (idx = 0; idx < width; idx++)
 					{
#if STATS_HIST_DEPTH == 256
						ramp = idx;
#endif
#if STATS_HIST_DEPTH == 1024
						ramp = idx>>2;
#endif

                        bmp24Line[(3 * idx) + 0] = ramp;
                        bmp24Line[(3 * idx) + 1] = ramp;
                        bmp24Line[(3 * idx) + 2] = ramp;
 					}
 					if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
 					{
 					   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
 					   break;
 					}
                 }
                 // draw histogram in middle of image
				 //for (level = 0; level < height-50; level++)
                 for (level = 0; level < 150; level++)
				 {
					//pConsole->io_hprintf( pConsole->io_handle, "\t[row=%d] lineAddress = 0x%08X\n\r", row, lineAddress );
					for (idx = 0; idx < width; idx++)
					{
                       if ( luma_hist_norm[idx] > level )
                       {
                          bmp24Line[(3 * idx) + 0] = 0xFF;
                          bmp24Line[(3 * idx) + 1] = 0xFF;
                          bmp24Line[(3 * idx) + 2] = 0xFF;
                       }
                       else
                       {
                          bmp24Line[(3 * idx) + 0] = 0x00;
                          bmp24Line[(3 * idx) + 1] = 0x00;
                          bmp24Line[(3 * idx) + 2] = 0x00;
                       }
					}
					if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
					{
					   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
					   break;
					}
				 }
				 // draw status of under/over exposure in top 25 rows
                 for (level = 0; level < 25; level ++)
                 {
                	// under exposure
 					for (idx = 0; idx < width*0.25; idx++)
 					{
                        bmp24Line[(3 * idx) + 0] = 0;
                        bmp24Line[(3 * idx) + 1] = 0;
                        bmp24Line[(3 * idx) + 2] = 0;
 						if ( fmc_imageon_demo.vipp.stats_handler_exp_metric_under )
 						{
                           bmp24Line[(3 * idx) + 2] = 0xFF; // red
 						}
 					}
                	// good exposure
 					for (idx = width*0.25; idx < width*0.75; idx++)
 					{
                        bmp24Line[(3 * idx) + 0] = 0;
                        bmp24Line[(3 * idx) + 1] = 0;
                        bmp24Line[(3 * idx) + 2] = 0;
 						if ( !fmc_imageon_demo.vipp.stats_handler_exp_metric_under && !fmc_imageon_demo.vipp.stats_handler_exp_metric_over )
 						{
                           bmp24Line[(3 * idx) + 1] = 0xFF; // green
 						}
 					}
                	// under exposure
 					for (idx = width*0.75; idx < width; idx++)
 					{
                        bmp24Line[(3 * idx) + 0] = 0;
                        bmp24Line[(3 * idx) + 1] = 0;
                        bmp24Line[(3 * idx) + 2] = 0;
 						if ( fmc_imageon_demo.vipp.stats_handler_exp_metric_over )
 						{
                           bmp24Line[(3 * idx) + 2] = 0xFF; // red
 						}
 					}
 					if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
 					{
 					   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
 					   break;
 					}
                 }

			  }

		      // Close BMP file
		      close( fd_bmp );

          }
          pthread_mutex_unlock( &(fmc_imageon_demo.vipp.stats_handler_mutex) ); // Exit critical section
	  }
#endif
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bStatus )
   {
       Xuint32 sensor_gain;
       Xuint32 sensor_exposure;
       int r, c;

       fmc_imageon_demo.vipp.fpSensorGetGain(fmc_imageon_demo.vipp.pSensor, &sensor_gain );
       fmc_imageon_demo.vipp.fpSensorGetExposure(fmc_imageon_demo.vipp.pSensor, &sensor_exposure );

       pConsole->io_hprintf( pConsole->io_handle, "\tIterations = %6d ", fmc_imageon_demo.vipp.stats_handler_frame_cnt );
       pConsole->io_hprintf( pConsole->io_handle, "\r\n" );
       pConsole->io_hprintf( pConsole->io_handle, "\tIntensity(luminance)\r\n" );
       pConsole->io_hprintf( pConsole->io_handle, "\t\taverage = %4d\r\n", fmc_imageon_demo.vipp.average_level  );
       pConsole->io_hprintf( pConsole->io_handle, "\t\ttarget  = %4d\r\n", fmc_imageon_demo.vipp.target_level  );
       pConsole->io_hprintf( pConsole->io_handle, "\tExposure = %s\r\n",
          fmc_imageon_demo.vipp.stats_handler_exp_metric_over  ? "over  " :
          fmc_imageon_demo.vipp.stats_handler_exp_metric_under ? "under " :
                                                                 "ok    " );
       pConsole->io_hprintf( pConsole->io_handle, "\t\tlow  25% = %7d\r\n", fmc_imageon_demo.vipp.stats_handler_luma_metric_lo  );
       pConsole->io_hprintf( pConsole->io_handle, "\t\tmid  50% = %7d\r\n", fmc_imageon_demo.vipp.stats_handler_luma_metric_mid );
       pConsole->io_hprintf( pConsole->io_handle, "\t\thigh 25% = %7d\r\n", fmc_imageon_demo.vipp.stats_handler_luma_metric_hi  );
       if ( fmc_imageon_demo.vipp.auto_exp_en )
       {
     	  pConsole->io_hprintf( pConsole->io_handle, "\tAuto Exposure ON  (  auto => %4d) \r\n", sensor_exposure );
       }
       else
       {
     	  pConsole->io_hprintf( pConsole->io_handle, "\tAuto Exposure OFF (manual => %4d) \r\n", fmc_imageon_demo.vita_exposure );
       }
       if ( fmc_imageon_demo.vipp.auto_gain_en )
       {
     	  pConsole->io_hprintf( pConsole->io_handle, "\tAuto Gain ON  ( auto => %4d) \r\n", sensor_gain );
       }
       else
       {
     	  pConsole->io_hprintf( pConsole->io_handle, "\tAuto Gain OFF (manual => %4d) \r\n", fmc_imageon_demo.vita_dgain );
       }
       if ( fmc_imageon_demo.vipp.auto_wb_en )
       {
     	  pConsole->io_hprintf( pConsole->io_handle, "\tAuto White Balance ON\r\n" );
     	  pConsole->io_hprintf( pConsole->io_handle, "\t\t              Daylight = %3d%% \n\r", fmc_imageon_demo.vipp.stats_handler_awb_metric_day );
     	  pConsole->io_hprintf( pConsole->io_handle, "\t\tCool White Fluorescent = %3d%% \n\r", fmc_imageon_demo.vipp.stats_handler_awb_metric_cwf );
     	  pConsole->io_hprintf( pConsole->io_handle, "\t\t       Hot Fluorescent = %3d%% \n\r", fmc_imageon_demo.vipp.stats_handler_awb_metric_u30 );
     	  pConsole->io_hprintf( pConsole->io_handle, "\t\t          Incandescent = %3d%% \n\r", fmc_imageon_demo.vipp.stats_handler_awb_metric_inc );
       }
       else
       {
     	  pConsole->io_hprintf( pConsole->io_handle, "\tAuto White Balance OFF\r\n" );
       }

       //pConsole->io_hprintf( pConsole->io_handle, "RGB Average Values :\n\r" );
       //pConsole->io_hprintf( pConsole->io_handle, "\tRed   = %d\r\n", fmc_imageon_demo.vipp.stats_handler_rgb_mean[0] );
       //pConsole->io_hprintf( pConsole->io_handle, "\tGreen = %d\r\n", fmc_imageon_demo.vipp.stats_handler_rgb_mean[1] );
       //pConsole->io_hprintf( pConsole->io_handle, "\tBlue  = %d\r\n", fmc_imageon_demo.vipp.stats_handler_rgb_mean[2] );

		  pConsole->io_hprintf( pConsole->io_handle, "\tChrominance Histogram :\n\r" );
       for ( r = 0; r < 16; r++ )
       {
          pConsole->io_hprintf( pConsole->io_handle, "\t\t[ " );
          for ( c = 0; c < 16; c++ )
          {
             pConsole->io_hprintf( pConsole->io_handle, "%4d, ", fmc_imageon_demo.vipp.stats_handler_chroma_hist[((r)*16)+(c)]/1000 );
          }
          pConsole->io_hprintf( pConsole->io_handle, " ];\r\n" );
       }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tstats                 => Status of Image Statistics Engine\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tstats status          => Status of Image Statistics Engine\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tstats log             => Create histogram BMP file (imstats.bmp)\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tstats set scale #     => Set scale factor for histogram BMP file\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tstats set underexp #  => Set under-exposure threshold\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tstats set overexp  #  => Set over-exposure threshold\r\n" );
   }

   return;
}

void avnet_console_ipipe_awb_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  //if ( !strcmp(cargv[0],"awb") )
	  {
		if (!strcmp(cargv[1], "on") || !strcmp(cargv[1], "1")) {
			fmc_imageon_demo.vipp.auto_wb_en = 1;
			stats_set_chrom_hist_zoom( fmc_imageon_demo.vipp.uBaseAddr_STATS, 2); // ZOOM2
		} else {
			fmc_imageon_demo.vipp.auto_wb_en = 0;
            millisleep(50);
            pConsole->io_hprintf( pConsole->io_handle, "\tCCM = Bypass\r\n" );
            vipp_ccm_setCoefficients( &(fmc_imageon_demo.vipp), &CCM_RGB_BYPASS);
		}
	  }
	  //else
	  //{
      //   bDispSyntax = 1;
	  //}
   }

   pConsole->io_hprintf( pConsole->io_handle, "\tauto white balance    = %s\r\n", fmc_imageon_demo.vipp.auto_wb_en   ? "on" : "off " );

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tawb on|off   => auto white balance    (on|off)\r\n" );
   }

   return;
}

void avnet_console_ipipe_agc_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint32 target_level;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if (!strcmp(cargv[1], "on") || !strcmp(cargv[1], "1"))
	  {
		 fmc_imageon_demo.vipp.auto_gain_en = 1;
	  }
	  else if (!strcmp(cargv[1], "off") || !strcmp(cargv[1], "0"))
	  {
		 fmc_imageon_demo.vipp.auto_gain_en = 0;
		 millisleep(50);
		 //pConsole->io_hprintf( pConsole->io_handle, "\tDigital Gain = 1.0\r\n" );
		 //fmc_imageon_vita_receiver_set_digital_gain( &(fmc_imageon_demo.vita_receiver), 128 /*uDigitalGain*/, 0/*bVerbose*/ );
		 //pConsole->io_hprintf( pConsole->io_handle, "\tAnalog Gain = 1.0\r\n" );
		 //fmc_imageon_vita_receiver_set_analog_gain( &(fmc_imageon_demo.vita_receiver), 0 /*uAnalogGain*/, 0/*bVerbose*/ );
		 pConsole->io_hprintf( pConsole->io_handle, "\tAnalog Gain = %d\r\n", fmc_imageon_demo.vita_again );
		 fmc_imageon_vita_receiver_set_analog_gain(&(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_again, fmc_imageon_demo.bVerbose);
		 fmc_imageon_demo.vita_receiver.uAnalogGain = fmc_imageon_demo.vita_again;
		 pConsole->io_hprintf( pConsole->io_handle, "\tDigital Gain = \r\n", fmc_imageon_demo.vita_dgain );
		 fmc_imageon_vita_receiver_set_digital_gain(&(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_dgain, fmc_imageon_demo.bVerbose);
		 fmc_imageon_demo.vita_receiver.uDigitalGain = fmc_imageon_demo.vita_dgain;
	  }
	  else if (!strcmp(cargv[1], "level") )
	  {
         scanhex( cargv[2], &target_level );
         if ( target_level > 1023 ) target_level = 1023;
         pConsole->io_hprintf( pConsole->io_handle, "Setting target intensity to %d\n\r", target_level );
         fmc_imageon_demo.vipp.target_level = target_level;
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   pConsole->io_hprintf( pConsole->io_handle, "\tauto gain control     = %s\r\n", fmc_imageon_demo.vipp.auto_gain_en ? "on" : "off " );

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tagc on|off   => auto gain control     (on|off)\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tagc level #  => target intensity (0-1023)\r\n" );
   }

   return;
}

void avnet_console_ipipe_aec_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  //else if ( !strcmp(cargv[0],"aec") )
	  {
		if (!strcmp(cargv[1], "on") || !strcmp(cargv[1], "1")) {
			fmc_imageon_demo.vipp.auto_exp_en = 1;
		} else {
			fmc_imageon_demo.vipp.auto_exp_en = 0;
			millisleep(100);
            fmc_imageon_vita_receiver_set_exposure_time( &(fmc_imageon_demo.vita_receiver), fmc_imageon_demo.vita_exposure, fmc_imageon_demo.bVerbose);
            fmc_imageon_demo.vita_receiver.uExposureTime = fmc_imageon_demo.vita_exposure;
		}
        pConsole->io_hprintf( pConsole->io_handle, "\tauto exposure control = %s\r\n", fmc_imageon_demo.vipp.auto_exp_en  ? "on" : "off " );
	  }
	  //else
	  //{
      //   bDispSyntax = 1;
	  //}
   }

   pConsole->io_hprintf( pConsole->io_handle, "\tauto exposure control = %s\r\n", fmc_imageon_demo.vipp.auto_exp_en  ? "on" : "off " );

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\taec on|off   => auto exposure control (on|off)\r\n" );
   }

   return;
}

void avnet_console_ipipe_geq_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   int gamma_idx;
   Xuint32 gamma_strength;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
      if (!strcmp(cargv[1], "on") || !strcmp(cargv[1], "1"))
      {
         fmc_imageon_demo.vipp.gamma_eq_en = 1;
      }
      else if (!strcmp(cargv[1], "off") || !strcmp(cargv[1], "0"))
      {
         fmc_imageon_demo.vipp.gamma_eq_en = 0;
         millisleep(50);
         gamma_idx = 0;
         pConsole->io_hprintf( pConsole->io_handle, "Setting gamma to %s\n\r", gamma_names[gamma_idx] );
         vipp_download_gamma_table( &(fmc_imageon_demo.vipp), gamma_idx, 3);
      }
      else if ( !strcmp(cargv[1],"strength") )
	  {
		 scanhex( cargv[2], &gamma_strength );
		 if ( gamma_strength > 100 ) gamma_strength = 100;
		 fmc_imageon_demo.vipp.gamma_eq_str = ((float)(gamma_strength)) / 100.0;
		 fmc_imageon_demo.vipp.brightness_set = 1;
		 pConsole->io_hprintf( pConsole->io_handle, "\tGamma Equalization Strength = %d%%\r\n", (Xuint32)((fmc_imageon_demo.vipp.gamma_eq_str)*100.0) );
	  }
      else
      {
         bDispSyntax = 1;
      }
   }

   pConsole->io_hprintf( pConsole->io_handle, "\tGamma Rqualization    = %s\r\n", fmc_imageon_demo.vipp.gamma_eq_en  ? "on" : "off " );

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tgeq on|off       => gain equalization (on|off)\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tgeq strength {#} => gain equalization strength (0-100%)\r\n" );
   }

   return;
}


void avnet_console_ipipe_noise_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint32 noise;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  pConsole->io_hprintf( pConsole->io_handle, "\t...\r\n" );
	  }
	  else if ( !strcmp(cargv[1],"set") && (cargc > 2) )
	  {
         scanhex( cargv[2], &noise );
         pConsole->io_hprintf( pConsole->io_handle, "Setting Noise Suppression Threshold to %d\n\r", noise );
         vipp_noise( &(fmc_imageon_demo.vipp), noise );
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tnoise status   => ...\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tnoise set #    => Set Noise Suppression Threshold (0-255)\r\n" );
   }

   return;
}

void avnet_console_ipipe_enhance_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint32 enhance;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  pConsole->io_hprintf( pConsole->io_handle, "\t...\r\n" );
	  }
	  else if ( !strcmp(cargv[1],"set") && (cargc > 2) )
	  {
         scanhex( cargv[2], &enhance );
         pConsole->io_hprintf( pConsole->io_handle, "Setting Edge Enhancement Threshold to %d\n\r", enhance );
         vipp_enhance( &(fmc_imageon_demo.vipp), enhance );
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tenhance status   => ...\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tenhance set #    => Set Edge Enhancement Threshold (0-32768)\r\n" );
   }

   return;
}

void avnet_console_ipipe_halo_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint32 halo;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  pConsole->io_hprintf( pConsole->io_handle, "\t...\r\n" );
	  }
	  else if ( !strcmp(cargv[1],"set") && (cargc > 2) )
	  {
         scanhex( cargv[2], &halo );
         pConsole->io_hprintf( pConsole->io_handle, "Setting Halo Suppression Threshold to %d\n\r", halo );
         vipp_halo( &(fmc_imageon_demo.vipp), halo );
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\thalo status   => ...\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\thalo set #    => Set Halo Suppression Threshold (0-32768)\r\n" );
   }

   return;
}

void avnet_console_ipipe_ccm_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   int contrast = 0;
   int brightness = 0;
   int saturation = 0;


   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  CCM_Coefficient ccmCustom;
          vipp_ccm_getCoefficients( &(fmc_imageon_demo.vipp), &ccmCustom );
          pConsole->io_hprintf( pConsole->io_handle, "\t%s coefficients = ...\r\n", cargv[0] );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk11 = %d\n\r", ccmCustom.k11 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk12 = %d\n\r", ccmCustom.k12 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk13 = %d\n\r", ccmCustom.k13 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk21 = %d\n\r", ccmCustom.k21 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk22 = %d\n\r", ccmCustom.k22 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk23 = %d\n\r", ccmCustom.k23 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk31 = %d\n\r", ccmCustom.k31 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk32 = %d\n\r", ccmCustom.k32 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tk33 = %d\n\r", ccmCustom.k33 );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tR offset = %d\n\r", ccmCustom.rOffset );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tG offset = %d\n\r", ccmCustom.gOffset );
          pConsole->io_hprintf( pConsole->io_handle, "\t\tB offset = %d\n\r", ccmCustom.bOffset );
	  }
	  else if ( !strcmp(cargv[1],"custom") && (cargc == 14) )
	  {
		  CCM_Coefficient ccmCustom;
	      char *pArg;
	      Xuint32 uvalue;
	      Xint32  negative;
	      Xint32  svalues[12];
	      int i;
	      for ( i = 0; i < 12; i++ )
	      {
	         pArg = cargv[2+i];
	         negative = 0;
	         if ( pArg[0] == '-' )
	         {
	            pArg++;
	            negative = 1;
	         }
	         if ( pArg[0] == '+' )
	         {
	            pArg++;
	            negative = 0;
	         }
	         scanhex( pArg, &uvalue );
	         svalues[i] = (Xint32)uvalue;
	         if ( negative )
	         {
	            svalues[i] = -svalues[i];
	         }
	      }
	      ccmCustom.k11 = svalues[ 0];
	      ccmCustom.k12 = svalues[ 1];
	      ccmCustom.k13 = svalues[ 2];
	      ccmCustom.k21 = svalues[ 3];
	      ccmCustom.k22 = svalues[ 4];
	      ccmCustom.k23 = svalues[ 5];
	      ccmCustom.k31 = svalues[ 6];
	      ccmCustom.k32 = svalues[ 7];
	      ccmCustom.k33 = svalues[ 8];
	      ccmCustom.rOffset = svalues[ 9];
	      ccmCustom.gOffset = svalues[10];
	      ccmCustom.bOffset = svalues[11];
          vipp_ccm_setCoefficients( &(fmc_imageon_demo.vipp), &ccmCustom );
	  }
	  else if ( !strcmp(cargv[1],"bypass") )
      {
          fmc_imageon_demo.vipp.auto_wb_en = 0;
          fmc_imageon_demo.vipp.ccm_select = 0;
          millisleep(50);
		  pConsole->io_hprintf( pConsole->io_handle, "\tCCM = Bypass\r\n" );
          vipp_ccm_setCoefficients( &(fmc_imageon_demo.vipp), &CCM_RGB_BYPASS );
      }
	  else if ( !strcmp(cargv[1],"day") )
      {
          fmc_imageon_demo.vipp.auto_wb_en = 0;
          fmc_imageon_demo.vipp.ccm_select = 1;
          millisleep(50);
		  pConsole->io_hprintf( pConsole->io_handle, "\tCCM = Daylight\r\n" );
          vipp_ccm_setCoefficients( &(fmc_imageon_demo.vipp), &CCM_RGB_DAY );
      }
	  else if ( !strcmp(cargv[1],"cwf") )
      {
          fmc_imageon_demo.vipp.auto_wb_en = 0;
          fmc_imageon_demo.vipp.ccm_select = 2;
          millisleep(50);
		  pConsole->io_hprintf( pConsole->io_handle, "\tCCM = CoolWhiteFluorescent\r\n" );
          vipp_ccm_setCoefficients( &(fmc_imageon_demo.vipp), &CCM_RGB_CWF );
      }
	  else if ( !strcmp(cargv[1],"u30") )
      {
          fmc_imageon_demo.vipp.auto_wb_en = 0;
          fmc_imageon_demo.vipp.ccm_select = 3;
          millisleep(50);
		  pConsole->io_hprintf( pConsole->io_handle, "\tCCM = 3000K\r\n" );
          vipp_ccm_setCoefficients( &(fmc_imageon_demo.vipp), &CCM_RGB_U30 );
      }
	  else if ( !strcmp(cargv[1],"inc") )
      {
          fmc_imageon_demo.vipp.auto_wb_en = 0;
          fmc_imageon_demo.vipp.ccm_select = 4;
          millisleep(50);
		  pConsole->io_hprintf( pConsole->io_handle, "\tCCM = Incandescent\r\n" );
          vipp_ccm_setCoefficients( &(fmc_imageon_demo.vipp), &CCM_RGB_INC );
      }
	  else if ( !strcmp(cargv[1],"auto") )
      {
		  pConsole->io_hprintf( pConsole->io_handle, "\tCCM = Auto White Balance\r\n" );
          fmc_imageon_demo.vipp.auto_wb_en = 1;
          stats_set_chrom_hist_zoom( fmc_imageon_demo.vipp.uBaseAddr_STATS, 2); // ZOOM2
      }
	  else if ( !strcmp(cargv[1],"contrast") )
      {
	      char *pArg = cargv[2];
	      Xuint32 uvalue = 0;
	      Xint32  negative = 0;
          if ( pArg[0] == '-' )
          {
            pArg++;
            negative = 1;
          }
          if ( pArg[0] == '+' )
          {
            pArg++;
            negative = 0;
          }
          scanhex( pArg, &uvalue );
          contrast = (Xint32)uvalue;
          if ( negative )
          {
        	  contrast = -contrast;
          }
          fmc_imageon_demo.vipp.contrast = contrast;
          fmc_imageon_demo.vipp.contrast_set = 1;
		  pConsole->io_hprintf( pConsole->io_handle, "\tContrast = %d\r\n", fmc_imageon_demo.vipp.contrast );
      }
	  else if ( !strcmp(cargv[1],"brightness") )
      {
		  scanhex( cargv[2], &brightness );
          fmc_imageon_demo.vipp.brightness = brightness;
          fmc_imageon_demo.vipp.brightness_set = 1;
		  pConsole->io_hprintf( pConsole->io_handle, "\tBrightness = %d\r\n", fmc_imageon_demo.vipp.brightness );
      }
	  else if ( !strcmp(cargv[1],"saturation") )
      {
		  scanhex( cargv[2], &saturation );
          fmc_imageon_demo.vipp.saturation = saturation;
          fmc_imageon_demo.vipp.saturation_set = 1;
		  pConsole->io_hprintf( pConsole->io_handle, "\tSaturation = %d\r\n", fmc_imageon_demo.vipp.saturation );
      }



	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t%s status   => ...\r\n", cargv[0] );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t%s bypass   => Set CCM for bypass\r\n", cargv[0] );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t%s day      => Set CCM for Daylight\r\n", cargv[0] );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t%s cwf      => Set CCM for CoolWhiteFluorescent\r\n", cargv[0] );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t%s u30      => Set CCM for 3000K\r\n", cargv[0] );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t%s inc      => Set CCM for Incandescent\r\n", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t%s custom k11 k12 k13 k21 k22 k23 k31 k32 k33 ro go bo\r\n", cargv[0] );
      pConsole->io_hprintf( pConsole->io_handle, "\t\t            => Update %s with custom Color Correction Matrix values\r\n", cargv[0] );
   }

   return;
}

void avnet_console_ipipe_gamma_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   int gamma_idx;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		  pConsole->io_hprintf( pConsole->io_handle, "\t...\r\n" );
	  }
	  else if ( !strcmp(cargv[1],"set") && (cargc > 2) )
	  {
         scanhex( cargv[2], &gamma_idx );
         if ( gamma_idx > 4 ) gamma_idx = 0;
         pConsole->io_hprintf( pConsole->io_handle, "Setting gamma to %s\n\r", gamma_names[gamma_idx] );
         vipp_download_gamma_table( &(fmc_imageon_demo.vipp), gamma_idx, 3);
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  //pConsole->io_hprintf( pConsole->io_handle, "\t\tgamma status   => ...\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tgamma set # => Set gamma table to one of the following\r\n" );
	  for ( gamma_idx = 0; gamma_idx < 5; gamma_idx++ )
	  {
         pConsole->io_hprintf( pConsole->io_handle, "\t\t   %d = %s\r\n", gamma_idx, gamma_names[gamma_idx] );
	  }
   }

   return;
}

void avnet_console_video_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"vita") )
	  {
         fmc_imageon_demo_enable_vita( &fmc_imageon_demo );
	  }
	  else if ( !strcmp(cargv[1],"ipipe") )
	  {
         fmc_imageon_demo_enable_ipipe( &fmc_imageon_demo );
	  }
	  else if ( !strcmp(cargv[1],"hdmio") )
	  {
         fmc_imageon_demo_enable_hdmio( &fmc_imageon_demo );
	  }
	  else if ( !strcmp(cargv[1],"off") )
	  {
         // Force all Initialized flags as false
         fmc_imageon_demo.bVITAInitialized = 0;
         fmc_imageon_demo.bIPIPEInitialized = 0;
	  }
	  else
	  {
         bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvideo vita    => Select VITA sensor\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvideo ipipe   => Select Image Processing Pipeline\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvideo hdmio   => Run ADV7511 HDMI Output Initialization\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvideo off     => Disable all sources\n\r" );
   }

   return;
}


#define ADV7511_CSC_CONFIG_LEN  (24)

// ADV7511 Default Values
Xuint8 adv7511_csc_config_00[ADV7511_CSC_CONFIG_LEN][3] =
{
		IIC_ADV7511_BASE_ADDR>>1, 0x18, 0xC6,
		IIC_ADV7511_BASE_ADDR>>1, 0x19, 0x62,
		IIC_ADV7511_BASE_ADDR>>1, 0x1A, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x1B, 0xA8,
		IIC_ADV7511_BASE_ADDR>>1, 0x1C, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1D, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1E, 0x1C,
		IIC_ADV7511_BASE_ADDR>>1, 0x1F, 0x84,
		IIC_ADV7511_BASE_ADDR>>1, 0x20, 0x1C,
		IIC_ADV7511_BASE_ADDR>>1, 0x21, 0xBF,
		IIC_ADV7511_BASE_ADDR>>1, 0x22, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x23, 0xA8,
		IIC_ADV7511_BASE_ADDR>>1, 0x24, 0x1E,
		IIC_ADV7511_BASE_ADDR>>1, 0x25, 0x70,
		IIC_ADV7511_BASE_ADDR>>1, 0x26, 0x02,
		IIC_ADV7511_BASE_ADDR>>1, 0x27, 0x1E,
		IIC_ADV7511_BASE_ADDR>>1, 0x28, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x29, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x2A, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x2B, 0xA8,
		IIC_ADV7511_BASE_ADDR>>1, 0x2C, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x2D, 0x12,
		IIC_ADV7511_BASE_ADDR>>1, 0x2E, 0x1B,
		IIC_ADV7511_BASE_ADDR>>1, 0x2F, 0xAC
};

// HDTV YCbCr (16to235) to RGB (16to235)
Xuint8 adv7511_csc_config_01[ADV7511_CSC_CONFIG_LEN][3] =
{
		IIC_ADV7511_BASE_ADDR>>1, 0x18, 0xAC,
		IIC_ADV7511_BASE_ADDR>>1, 0x19, 0x53,
		IIC_ADV7511_BASE_ADDR>>1, 0x1A, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x1B, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1C, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1D, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1E, 0x19,
		IIC_ADV7511_BASE_ADDR>>1, 0x1F, 0xD6,
		IIC_ADV7511_BASE_ADDR>>1, 0x20, 0x1C,
		IIC_ADV7511_BASE_ADDR>>1, 0x21, 0x56,
		IIC_ADV7511_BASE_ADDR>>1, 0x22, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x23, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x24, 0x1E,
		IIC_ADV7511_BASE_ADDR>>1, 0x25, 0x88,
		IIC_ADV7511_BASE_ADDR>>1, 0x26, 0x02,
		IIC_ADV7511_BASE_ADDR>>1, 0x27, 0x91,
		IIC_ADV7511_BASE_ADDR>>1, 0x28, 0x1F,
		IIC_ADV7511_BASE_ADDR>>1, 0x29, 0xFF,
		IIC_ADV7511_BASE_ADDR>>1, 0x2A, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x2B, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x2C, 0x0E,
		IIC_ADV7511_BASE_ADDR>>1, 0x2D, 0x85,
		IIC_ADV7511_BASE_ADDR>>1, 0x2E, 0x18,
		IIC_ADV7511_BASE_ADDR>>1, 0x2F, 0xBE
};

// HDTV YCbCr (16to235) to RGB (0to255)
Xuint8 adv7511_csc_config_02[ADV7511_CSC_CONFIG_LEN][3] =
{
		IIC_ADV7511_BASE_ADDR>>1, 0x18, 0xE7,
		IIC_ADV7511_BASE_ADDR>>1, 0x19, 0x34,
		IIC_ADV7511_BASE_ADDR>>1, 0x1A, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x1B, 0xAD,
		IIC_ADV7511_BASE_ADDR>>1, 0x1C, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1D, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1E, 0x1C,
		IIC_ADV7511_BASE_ADDR>>1, 0x1F, 0x1B,
		IIC_ADV7511_BASE_ADDR>>1, 0x20, 0x1D,
		IIC_ADV7511_BASE_ADDR>>1, 0x21, 0xDC,
		IIC_ADV7511_BASE_ADDR>>1, 0x22, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x23, 0xAD,
		IIC_ADV7511_BASE_ADDR>>1, 0x24, 0x1F,
		IIC_ADV7511_BASE_ADDR>>1, 0x25, 0x24,
		IIC_ADV7511_BASE_ADDR>>1, 0x26, 0x01,
		IIC_ADV7511_BASE_ADDR>>1, 0x27, 0x35,
		IIC_ADV7511_BASE_ADDR>>1, 0x28, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x29, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x2A, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x2B, 0xAD,
		IIC_ADV7511_BASE_ADDR>>1, 0x2C, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x2D, 0x7C,
		IIC_ADV7511_BASE_ADDR>>1, 0x2E, 0x1B,
		IIC_ADV7511_BASE_ADDR>>1, 0x2F, 0x77
};

// SDTV YCbCr (16to235) to RGB (16to235)
Xuint8 adv7511_csc_config_03[ADV7511_CSC_CONFIG_LEN][3] =
{
		IIC_ADV7511_BASE_ADDR>>1, 0x18, 0xAA,
		IIC_ADV7511_BASE_ADDR>>1, 0x19, 0xF8,
		IIC_ADV7511_BASE_ADDR>>1, 0x1A, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x1B, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1C, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1D, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1E, 0x1A,
		IIC_ADV7511_BASE_ADDR>>1, 0x1F, 0x84,
		IIC_ADV7511_BASE_ADDR>>1, 0x20, 0x1A,
		IIC_ADV7511_BASE_ADDR>>1, 0x21, 0x6A,
		IIC_ADV7511_BASE_ADDR>>1, 0x22, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x23, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x24, 0x1D,
		IIC_ADV7511_BASE_ADDR>>1, 0x25, 0x50,
		IIC_ADV7511_BASE_ADDR>>1, 0x26, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x27, 0x23,
		IIC_ADV7511_BASE_ADDR>>1, 0x28, 0x1F,
		IIC_ADV7511_BASE_ADDR>>1, 0x29, 0xFC,
		IIC_ADV7511_BASE_ADDR>>1, 0x2A, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x2B, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x2C, 0x0D,
		IIC_ADV7511_BASE_ADDR>>1, 0x2D, 0xDE,
		IIC_ADV7511_BASE_ADDR>>1, 0x2E, 0x19,
		IIC_ADV7511_BASE_ADDR>>1, 0x2F, 0x13
};

// SDTV YCbCr (16to235) to RGB (0to255)
Xuint8 adv7511_csc_config_04[ADV7511_CSC_CONFIG_LEN][3] =
{
		IIC_ADV7511_BASE_ADDR>>1, 0x18, 0xE6,
		IIC_ADV7511_BASE_ADDR>>1, 0x19, 0x69,
		IIC_ADV7511_BASE_ADDR>>1, 0x1A, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x1B, 0xAC,
		IIC_ADV7511_BASE_ADDR>>1, 0x1C, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1D, 0x00,
		IIC_ADV7511_BASE_ADDR>>1, 0x1E, 0x1C,
		IIC_ADV7511_BASE_ADDR>>1, 0x1F, 0x81,
		IIC_ADV7511_BASE_ADDR>>1, 0x20, 0x1C,
		IIC_ADV7511_BASE_ADDR>>1, 0x21, 0xBC,
		IIC_ADV7511_BASE_ADDR>>1, 0x22, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x23, 0xAD,
		IIC_ADV7511_BASE_ADDR>>1, 0x24, 0x1E,
		IIC_ADV7511_BASE_ADDR>>1, 0x25, 0x6E,
		IIC_ADV7511_BASE_ADDR>>1, 0x26, 0x02,
		IIC_ADV7511_BASE_ADDR>>1, 0x27, 0x20,
		IIC_ADV7511_BASE_ADDR>>1, 0x28, 0x1F,
		IIC_ADV7511_BASE_ADDR>>1, 0x29, 0xFE,
		IIC_ADV7511_BASE_ADDR>>1, 0x2A, 0x04,
		IIC_ADV7511_BASE_ADDR>>1, 0x2B, 0xAD,
		IIC_ADV7511_BASE_ADDR>>1, 0x2C, 0x08,
		IIC_ADV7511_BASE_ADDR>>1, 0x2D, 0x1A,
		IIC_ADV7511_BASE_ADDR>>1, 0x2E, 0x1B,
		IIC_ADV7511_BASE_ADDR>>1, 0x2F, 0xA9,
};

Xuint8 adv7511_clk_delay[1][3] =
{
		IIC_ADV7511_BASE_ADDR>>1, 0xBA, 0xA0 // 101 = 0.8ns
};

void avnet_console_adv7511_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint32 csc_idx;
   Xuint32 clk_delay;
   int i;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"csc0") )
	  {
		 scanhex( cargv[2], &csc_idx );
		 if ( csc_idx > 4 ) csc_idx = 0;
		 switch ( csc_idx )
		 {
		 case 0:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = {default values}\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_00, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_ipmi_iic.fpIicWrite( &(fmc_imageon_demo.fmc_ipmi_iic), adv7511_csc_config_00[i][0], adv7511_csc_config_00[i][1], &(adv7511_csc_config_00[i][2]), 1);
             }
			 break;
		 case 1:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = HDTV YCbCr (16to235) to RGB (16to235)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_01, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_ipmi_iic.fpIicWrite( &(fmc_imageon_demo.fmc_ipmi_iic), adv7511_csc_config_01[i][0], adv7511_csc_config_01[i][1], &(adv7511_csc_config_01[i][2]), 1);
             }
			 break;
		 case 2:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = HDTV YCbCr (16to235) to RGB (0to255)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_02, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_ipmi_iic.fpIicWrite( &(fmc_imageon_demo.fmc_ipmi_iic), adv7511_csc_config_02[i][0], adv7511_csc_config_02[i][1], &(adv7511_csc_config_02[i][2]), 1);
             }
			 break;
		 case 3:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = SDTV YCbCr (16to235) to RGB (16to235)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_03, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_ipmi_iic.fpIicWrite( &(fmc_imageon_demo.fmc_ipmi_iic), adv7511_csc_config_03[i][0], adv7511_csc_config_03[i][1], &(adv7511_csc_config_03[i][2]), 1);
             }
			 break;
		 case 4:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = SDTV YCbCr (16to235) to RGB (0to255)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_04, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_ipmi_iic.fpIicWrite( &(fmc_imageon_demo.fmc_ipmi_iic), adv7511_csc_config_04[i][0], adv7511_csc_config_04[i][1], &(adv7511_csc_config_04[i][2]), 1);
             }
			 break;
		 }
	  }
	  else if ( !strcmp(cargv[1],"csc1") )
	  {
		 scanhex( cargv[2], &csc_idx );
		 if ( csc_idx > 4 ) csc_idx = 0;
		 switch ( csc_idx )
		 {
		 case 0:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = {default values}\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_00, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_imageon_iic.fpIicWrite( &(fmc_imageon_demo.fmc_imageon_iic), adv7511_csc_config_00[i][0], adv7511_csc_config_00[i][1], &(adv7511_csc_config_00[i][2]), 1);
             }
			 break;
		 case 1:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = HDTV YCbCr (16to235) to RGB (16to235)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_01, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_imageon_iic.fpIicWrite( &(fmc_imageon_demo.fmc_imageon_iic), adv7511_csc_config_01[i][0], adv7511_csc_config_01[i][1], &(adv7511_csc_config_01[i][2]), 1);
             }
			 break;
		 case 2:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = HDTV YCbCr (16to235) to RGB (0to255)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_02, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_imageon_iic.fpIicWrite( &(fmc_imageon_demo.fmc_imageon_iic), adv7511_csc_config_02[i][0], adv7511_csc_config_02[i][1], &(adv7511_csc_config_02[i][2]), 1);
             }
			 break;
		 case 3:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = SDTV YCbCr (16to235) to RGB (16to235)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_03, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_imageon_iic.fpIicWrite( &(fmc_imageon_demo.fmc_imageon_iic), adv7511_csc_config_03[i][0], adv7511_csc_config_03[i][1], &(adv7511_csc_config_03[i][2]), 1);
             }
			 break;
		 case 4:
			 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 CSC = SDTV YCbCr (16to235) to RGB (0to255)\n\r" );
			 //fmc_imageon_iic_config3( &(fmc_imageon_demo.fmc_imageon), adv7511_csc_config_04, ADV7511_CSC_CONFIG_LEN);
             for ( i = 0; i < ADV7511_CSC_CONFIG_LEN; i++ )
             {
            	 fmc_imageon_demo.fmc_imageon_iic.fpIicWrite( &(fmc_imageon_demo.fmc_imageon_iic), adv7511_csc_config_04[i][0], adv7511_csc_config_04[i][1], &(adv7511_csc_config_04[i][2]), 1);
             }
			 break;
		 }
	  }
	  if ( !strcmp(cargv[1],"clk0") )
	  {
		 scanhex( cargv[2], &clk_delay );
		 if ( clk_delay > 7 ) clk_delay = 0;
		 adv7511_clk_delay[0][2] = clk_delay << 5;
		 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 Clock Delay = \n\r", clk_delay );
       	 fmc_imageon_demo.fmc_ipmi_iic.fpIicWrite( &(fmc_imageon_demo.fmc_ipmi_iic), adv7511_clk_delay[0][0], adv7511_clk_delay[0][1], &(adv7511_clk_delay[0][2]), 1);
	  }
	  else if ( !strcmp(cargv[1],"clk1") )
	  {
		 scanhex( cargv[2], &clk_delay );
		 if ( clk_delay > 7 ) clk_delay = 0;
		 adv7511_clk_delay[0][2] = clk_delay << 5;
		 pConsole->io_hprintf( pConsole->io_handle, "ADV7511 Clock Delay = %d\n\r", clk_delay );
       	 fmc_imageon_demo.fmc_imageon_iic.fpIicWrite( &(fmc_imageon_demo.fmc_imageon_iic), adv7511_clk_delay[0][0], adv7511_clk_delay[0][1], &(adv7511_clk_delay[0][2]), 1);
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tadv7511 csc0 #  => Select ZC702's ADV7511 Color Space Conversion coefficients\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tadv7511 csc1 #  => Select FMC's ADV7511 Color Space Conversion coefficients\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t0 = {default values}\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t1 = HDTV YCbCr (16to235) to RGB (16to235)\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t2 = HDTV YCbCr (16to235) to RGB (0to255)\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t3 = SDTV YCbCr (16to235) to RGB (16to235)\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t4 = SDTV YCbCr (16to235) to RGB (0to255)\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tadv7511 clk0 #  => Set the ZC702's ADV7511 programmable clock delay\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tadv7511 clk1 #  => Set the FMC's ADV7511 programmable clock delay\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t0 = -1.2ns\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t1 = -0.8ns\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t2 = -0.4ns\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t3 = no delays\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t4 = +0.4\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t5 = +0.8ns\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t6 = +1.2ns\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t\t7 = +1.6ns\r\n" );
   }

   return;
}

void avnet_console_vdma_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"status") )
	  {
		 vdma_status( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
	  }
	  else if ( !strcmp(cargv[1],"start") )
	  {
         vdma_rx_start( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer,
        		        fmc_imageon_demo.hdmio_resolution,
                        VDMA_VITA_MEM_BASE_ADDR
                      );
	  }
	  else if ( !strcmp(cargv[1],"stop") )
	  {
         vdma_rx_pause( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
	  }
	  else if ( !strcmp(cargv[1],"fill") )
	   {
		  Xuint32 physicalAddress;
		  Xuint32 physicalSize;
		  Xuint32 virtualAddress;
		  int fd_mmap;
		  //
		  int n;
		  //
      #define BORDER 40
	  #define FILL_WIDTH 1920
	  #define FILL_HEIGHT 1080
		  Xuint32 height = FILL_HEIGHT;
		  Xuint32 width = FILL_WIDTH;
		  Xuint32 stride = 0x00002000; //width << 2; // 32 bit pixels
		  Xuint32 frameIdx;
		  Xuint32 frameAddress;
		  Xuint32 lineAddress;
		  Xuint32 pixelAddress;
		  Xuint32 *p32Frame;
		  Xuint32 mem32Pixel;
		  Xint32 row, col;

		  // Stop Video Frame Buffer
		  vdma_rx_pause( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
		  physicalAddress = VDMA_VITA_MEM_BASE_ADDR; //vdma_address( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
		  physicalSize    = 3*0x870000*sizeof(unsigned int);

		  // Map physical frame buffer address to virtual space
#if defined(LINUX_CODE)
		  fd_mmap = open("/dev/mem", O_RDWR);
		  if ( fd_mmap == -1 )
		  {
			  pConsole->io_hprintf( pConsole->io_handle, "\tERROR : failed to open /dev/mem\n");
			  return;
		  }
		  virtualAddress = (Xuint32)mmap(NULL, physicalSize,
					PROT_READ | PROT_WRITE, MAP_SHARED, fd_mmap, (off_t)physicalAddress );
		  if (virtualAddress == (Xuint32)MAP_FAILED)
		  {
			 pConsole->io_hprintf( pConsole->io_handle, "\tERROR : mmap failed.\n");
			 return;
		  }
#else
		  virtualAddress = physicalAddress;
#endif

		  for ( frameIdx = 0; frameIdx < 3; frameIdx++ )
		  {
	         frameAddress = virtualAddress + frameIdx*0x870000;

			  // Fill frame buffer with color bars
			  {
				 // Data in memory corresponds to:
				 // [23:16] Red
				 // [15: 8] Green
				 // [ 7: 0] Blue
				 n = 0;
				 for (row = 0; row < height; row++)
				 {
					lineAddress = frameAddress + (row * stride);
					for (col = 0; col < width; col++)
					{
                        // Horizontal Ramp
						if((row >= ((height>>1)-40)) && (row < ((height>>1)-20)))
						{
							mem32Pixel = ((col&0xff) << 16) | ((col&0xff) << 8) | (col&0xff) << 0; // W (R+G+B)
						}
						else if((row >= ((height>>1)-20) ) && (row < (height>>1) ))
						{
							mem32Pixel = ((col&0xff) << 16); // R
						}
						else if((row >= (height>>1) ) && (row < ((height>>1)+20)))
						{
							mem32Pixel = ((col&0xff) << 8); // G
						}
						else if((row >= ((height>>1)+20)) && (row < ((height>>1)+40) ))
						{
							mem32Pixel = (col&0xff) << 0; // B
						}
						else
						{
						    // Color Bar
							if( col < width/8 )
							{
								mem32Pixel = 0x00FFFFFF; // W (R+G+B)
							}
							else if(col < width*2/8)
							{
								mem32Pixel = 0x00FFFF00; // Y (R+G)
							}
							else if(col < width*3/8)
							{
								mem32Pixel = 0x0000FFFF; // C (G+B)
							}
							else if(col < width*4/8)
							{
								mem32Pixel = 0x0000FF00; // G
							}
							else if(col < width*5/8)
							{
								mem32Pixel = 0x00FF00FF; // M (R+B)
							}
							else if(col < width*6/8)
							{
								mem32Pixel = 0x00FF0000; // R
							}
							else if(col < width*7/8)
							{
								mem32Pixel = 0x000000FF; // B
							}
							else
							{
								mem32Pixel = 0x00000000; // K
							}
						}
					    // Inverse Color Border
						if((col == (BORDER-1)) || (col == (width-BORDER)) || (row == (BORDER-1)) || (row == (height-BORDER)))
						{
							mem32Pixel = mem32Pixel ^ 0x00FFFFFF;
						}
					   // alpha channel
					   mem32Pixel = 0xFF000000 | mem32Pixel;
					   //
					   pixelAddress = lineAddress + (col << 2);
					   p32Frame = (Xuint32 *) pixelAddress;
					   *p32Frame = mem32Pixel;
					   //
					}
					n += (width * 3);
				 }
				 pConsole->io_hprintf( pConsole->io_handle, "\theight = %d, width = %d, n = %d\n\r", height, width, n);
			  }

		  } // for ( frameIdx = 0; frameIdx < 3; frameIdx++ )

		  // Unmap frame buffer address
#if defined(LINUX_CODE)
		  munmap((void *)virtualAddress,physicalSize);
		  close(fd_mmap);
#endif

		  // (Re)Start Video Frame Buffer
		  //vdma_rx_start( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );

	   }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvdma status   => Display AXI_VDMA registers\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvdma start    => Start Video Frame Buffer\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvdma stop     => Stop Video Frame Buffer\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tvdma fill     => Fill Video Frame Buffer with test pattern\r\n" );
   }

   return;
}

#if defined(LINUX_CODE)
void avnet_console_record_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
      Xuint32 physicalAddress;
      Xuint32 physicalSize;
      Xuint32 virtualAddress;
      int fd_mmap;
      int fd_bmp;
      //
      int n;
      //
  #define CAPTURE_WIDTH 1920
  #define CAPTURE_HEIGHT 1080
      Xuint32 height = CAPTURE_HEIGHT;
      Xuint32 width = CAPTURE_WIDTH;
      Xuint32 stride = 0x00002000; //width << 2; // 32 bit pixels
      Xuint32 frameIdx;
      Xuint32 frameAddress;
      Xuint32 lineAddress;
      Xuint32 pixelAddress;
      Xuint32 *p32Frame;
      Xint32 row, col;
      Xuint32 mem32Pixel;
      Xuint8 memRed;
      Xuint8 memGreen;
      Xuint8 memBlue;
      Xuint8 bmp24Line[CAPTURE_WIDTH * 3];
      char bmp24Header[54] = { 0x42,
  			0x4D, // MAGIC ('B' 'M')
  			0x36, 0xEC, 0x5E, 0x00, // FILE SIZE ((1920*1080*3) + 0x36)
  			0x00, 0x00, // RSVD
  			0x00, 0x00, // RSVD
  			0x36, 0x00, 0x00, 0x00, // IMAGE OFFSET (54)
  			0x28, 0x00, 0x00, 0x00, // DIB_HEADER SIZE (40)
  			0x80, 0x07, 0x00, 0x00, // WIDTH (1920)
  			0x38, 0x04, 0x00, 0x00, // HEIGHT (1080)
  			0x01, 0x00, // COLOR PLANES (1)
  			0x18, 0x00, // BPP (24)
  			0x00, 0x00, 0x00, 0x00, // COMPRESSION METHOD
  			0x00, 0xEC, 0x5E, 0x00, // IMAGE SIZE (1920*1080*3)
  			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  			0x00, 0x00, 0x00, 0x00, 0x00 };

      // Stop Video Frame Buffer
      vdma_rx_pause( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
      physicalAddress = vdma_address( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
      physicalSize    = 0x870000*sizeof(unsigned int);

      // Map physical frame buffer address to virtual space
      fd_mmap = open("/dev/mem", O_RDWR);
      if ( fd_mmap == -1 )
      {
          pConsole->io_hprintf( pConsole->io_handle, "\tERROR : failed to open /dev/mem\n");
          return;
      }
      virtualAddress = (Xuint32)mmap(NULL, physicalSize,
				PROT_READ | PROT_WRITE, MAP_SHARED, fd_mmap, (off_t)physicalAddress );
      if (virtualAddress == (Xuint32)MAP_FAILED)
      {
         pConsole->io_hprintf( pConsole->io_handle, "\tERROR : mmap failed.\n");
         return;
      }

      frameIdx = 0;
	  {
         frameAddress = virtualAddress + frameIdx*0x870000;

		  // Open BMP file
		  fd_bmp = open(cargv[1], O_CREAT | O_RDWR);
		  if ( fd_bmp == -1 )
		  {
			  pConsole->io_hprintf( pConsole->io_handle, "\tERROR : failed to open %s\n", cargv[1] );
			  return;
		  }

		  // Write image to BMP file
		  if ( write(fd_bmp, (char *)bmp24Header, sizeof(bmp24Header)) == -1 )
		  {
			 pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing header to file %s\n\r", cargv[1]);
		  }
		  else
		  {
			 // Data in memory corresponds to Video over AXI4-Stream pixel data ordering
			 // remapped:
			 // [23:16] Red
			 // [15: 8] Green
			 // [ 7: 0] Blue
			 n = 0;
			 for (row = height - 1; row >= 0; row--)
			 {
				lineAddress = frameAddress + (row * stride);
				//pConsole->io_hprintf( pConsole->io_handle, "\t[row=%d] lineAddress = 0x%08X\n\r", row, lineAddress );
				for (col = 0; col < width; col++)
				{
				   pixelAddress = lineAddress + (col << 2);
				   p32Frame = (Xuint32 *) pixelAddress;
				   mem32Pixel = *p32Frame;
				   //
				   memBlue  = (mem32Pixel & 0x000000FF) >> 0;
				   memGreen = (mem32Pixel & 0x0000FF00) >> 8;
				   memRed   = (mem32Pixel & 0x00FF0000) >> 16;
				   bmp24Line[(3 * col) + 0] = memBlue;
				   bmp24Line[(3 * col) + 1] = memGreen;
				   bmp24Line[(3 * col) + 2] = memRed;
				}
				if ( write(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
				{
				   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : writing video line to file %s\n\r", cargv[1]);
				   break;
				}
				n += (width * 3);
			 }
			 pConsole->io_hprintf( pConsole->io_handle, "\theight = %d, width = %d, n = %d\n\r", height, width, n);
		  }

	  } // frameIdx = ...

      // Close BMP file
      close( fd_bmp );

      // Unmap frame buffer address
      munmap((void *)virtualAddress,physicalSize);
      close(fd_mmap);

      // (Re)Start Video Frame Buffer
      vdma_rx_start( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer,
    		         fmc_imageon_demo.hdmio_resolution,
                     VDMA_VITA_MEM_BASE_ADDR
                   );
   }
   else
   {
 	 bDispSyntax = 1;
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\trec {filename} => Write frame buffer image to BMP file\r\n" );
   }

   return;
}

void avnet_console_playback_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  Xuint32 physicalAddress;
	  Xuint32 physicalSize;
	  Xuint32 virtualAddress;
	  int fd_mmap;
	  int fd_bmp;
	  //
	  int n;
	  //
  #define PLAYBACK_WIDTH 1920
  #define PLAYBACK_HEIGHT 1080
	  Xuint32 height = PLAYBACK_HEIGHT;
	  Xuint32 width = PLAYBACK_WIDTH;
	  Xuint32 stride = 0x00002000; //width << 2; // 32 bit pixels
	  Xuint32 frameIdx;
	  Xuint32 frameAddress;
	  Xuint32 lineAddress;
	  Xuint32 pixelAddress;
	  Xuint32 *p32Frame;
	  Xint32 row, col;
	  Xuint32 mem32Pixel;
	  Xuint8 memRed;
	  Xuint8 memGreen;
	  Xuint8 memBlue;
	  Xuint8 bmp24Line[CAPTURE_WIDTH * 3];
	  char bmp24Header[54] = { 0x42,
			0x4D, // MAGIC ('B' 'M')
			0x36, 0xEC, 0x5E, 0x00, // FILE SIZE ((1920*1080*3) + 0x36)
			0x00, 0x00, // RSVD
			0x00, 0x00, // RSVD
			0x36, 0x00, 0x00, 0x00, // IMAGE OFFSET (54)
			0x28, 0x00, 0x00, 0x00, // DIB_HEADER SIZE (40)
			0x80, 0x07, 0x00, 0x00, // WIDTH (1920)
			0x38, 0x04, 0x00, 0x00, // HEIGHT (1080)
			0x01, 0x00, // COLOR PLANES (1)
			0x18, 0x00, // BPP (24)
			0x00, 0x00, 0x00, 0x00, // COMPRESSION METHOD
			0x00, 0xEC, 0x5E, 0x00, // IMAGE SIZE (1920*1080*3)
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00, 0x00 };

	  // Stop Video Frame Buffer
	  vdma_rx_pause( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
	  physicalAddress = vdma_address( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );
	  physicalSize    = 3*0x870000*sizeof(unsigned int);

	  // Map physical frame buffer address to virtual space
	  fd_mmap = open("/dev/mem", O_RDWR);
	  if ( fd_mmap == -1 )
	  {
		  pConsole->io_hprintf( pConsole->io_handle, "\tERROR : failed to open /dev/mem\n");
		  return;
	  }
	  virtualAddress = (Xuint32)mmap(NULL, physicalSize,
				PROT_READ | PROT_WRITE, MAP_SHARED, fd_mmap, (off_t)physicalAddress );
	  if (virtualAddress == (Xuint32)MAP_FAILED)
	  {
		 pConsole->io_hprintf( pConsole->io_handle, "\tERROR : mmap failed.\n");
		 return;
	  }

	  for ( frameIdx = 0; frameIdx < 3; frameIdx++ )
	  {
         frameAddress = virtualAddress + frameIdx*0x870000;

		  // Open BMP file
		  fd_bmp = open(cargv[1], O_RDONLY);
		  if ( fd_bmp == -1 )
		  {
			  pConsole->io_hprintf( pConsole->io_handle, "\tERROR : failed to open %s\n", cargv[1] );
			  return;
		  }

		  // Read image from BMP file
		  if ( read(fd_bmp, (char *)bmp24Header, sizeof(bmp24Header)) == -1 )
		  {
			 pConsole->io_hprintf( pConsole->io_handle, "\tERROR : reading header from file %s\n\r", cargv[1]);
		  }
		  else
		  {
			 // Data in memory corresponds to XSVI pixel data ordering:
			 // [23:16] Red
			 // [15: 8] Green
			 // [ 7: 0] Blue
			 n = 0;
			 for (row = height - 1; row >= 0; row--)
			 {
				lineAddress = frameAddress + (row * stride);
				//pConsole->io_hprintf( pConsole->io_handle, "\t[row=%d] lineAddress = 0x%08X\n\r", row, lineAddress );
				if ( read(fd_bmp, (char *) bmp24Line, width * 3) == -1 )
				{
				   pConsole->io_hprintf( pConsole->io_handle, "\tERROR : reading video line to file %s\n\r", cargv[1]);
				   break;
				}
				for (col = 0; col < width; col++)
				{
				   memBlue  = bmp24Line[(3 * col) + 0];
				   memGreen = bmp24Line[(3 * col) + 1];
				   memRed   = bmp24Line[(3 * col) + 2];
				   //memBlue  = (mem32Pixel & 0x000000FF) >> 0;
				   //memGreen = (mem32Pixel & 0x0000FF00) >> 8;
				   //memRed   = (mem32Pixel & 0x00FF0000) >> 16;
				   mem32Pixel =              ((Xuint32)memBlue ) <<  0;
				   mem32Pixel = mem32Pixel | ((Xuint32)memGreen) <<  8;
				   mem32Pixel = mem32Pixel | ((Xuint32)memRed  ) << 16;
				   // alpha channel
				   mem32Pixel = 0xFF000000 | mem32Pixel;
                   //
				   pixelAddress = lineAddress + (col << 2);
				   p32Frame = (Xuint32 *) pixelAddress;
				   *p32Frame = mem32Pixel;
				}
				n += (width * 3);
			 }
			 pConsole->io_hprintf( pConsole->io_handle, "\theight = %d, width = %d, n = %d\n\r", height, width, n);
		  }

		  // Close BMP file
		  close( fd_bmp );

	  } // for ( frameIdx = 0; frameIdx < 3; frameIdx++ )

	  // Unmap frame buffer address
	  munmap((void *)virtualAddress,physicalSize);
	  close(fd_mmap);

	  // (Re)Start Video Frame Buffer
	  //vdma_rx_start( fmc_imageon_demo.uBaseAddr_VDMA_VitaFrameBuffer );

   }
   else
   {
	 bDispSyntax = 1;
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tplay {filename} => Fill frame buffer image from BMP file\r\n" );
   }

   return;

}
#endif // #if defined(LINUX_CODE)

// CDCE913
#define MAX_IIC_CDCE913_SSC 3
static Xuint8 iic_cdce913_ssc_off[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0x00, // SSC = 000 (off)
   0x11, 0x00, //
   0x12, 0x00  //
};
static Xuint8 iic_cdce913_ssc_0_25[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0x24, // SSC = 001 (0.25%)
   0x11, 0x92, //
   0x12, 0x49  //
};
static Xuint8 iic_cdce913_ssc_0_50[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0x49, // SSC = 010 (0.50%)
   0x11, 0x24, //
   0x12, 0x92  //
};
static Xuint8 iic_cdce913_ssc_0_75[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0x6D, // SSC = 011 (0.75%)
   0x11, 0xB6, //
   0x12, 0xDB  //
};
static Xuint8 iic_cdce913_ssc_1_00[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0x92, // SSC = 100 (1.00%)
   0x11, 0x49, //
   0x12, 0x24  //
};
static Xuint8 iic_cdce913_ssc_1_25[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0xB6, // SSC = 101 (1.25%)
   0x11, 0xDB, //
   0x12, 0x6D  //
};
static Xuint8 iic_cdce913_ssc_1_50[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0xDB, // SSC = 110 (1.50%)
   0x11, 0x6D, //
   0x12, 0xB6  //
};
static Xuint8 iic_cdce913_ssc_2_00[MAX_IIC_CDCE913_SSC][2]=
{
   0x10, 0xFF, // SSC = 111 (2.00%)
   0x11, 0xFF, //
   0x12, 0xFF  //
};

void avnet_console_cdce913_command( avnet_console_t *pConsole, int cargc, char ** cargv )
{
   int bDispSyntax = 0;
   Xuint8 num_bytes;
   int i;

   if ( cargc > 1 && !strcmp(cargv[1],"help") )
   {
	  bDispSyntax = 1;
   }
   else if ( cargc > 1 )
   {
	  if ( !strcmp(cargv[1],"ssc") && cargc > 2 )
	  {
         fmc_imageon_iic_mux( &(fmc_imageon_demo.fmc_imageon), FMC_IMAGEON_I2C_SELECT_VID_CLK );
         //
         if ( !strcmp(cargv[2],"off") || !strcmp(cargv[2],"0") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
               num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_off[i][0]), &(iic_cdce913_ssc_off[i][1]), 1);
            }
         }
         else if ( !strcmp(cargv[2],"0.25") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
                num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_0_25[i][0]), &(iic_cdce913_ssc_0_25[i][1]), 1);
            }
         }
         else if ( !strcmp(cargv[2],"0.50") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
                num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_0_50[i][0]), &(iic_cdce913_ssc_0_50[i][1]), 1);
            }
         }
         else if ( !strcmp(cargv[2],"on") || !strcmp(cargv[2],"0.75") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
                num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_0_75[i][0]), &(iic_cdce913_ssc_0_75[i][1]), 1);
            }
         }
         else if ( !strcmp(cargv[2],"1.00") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
                num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_1_00[i][0]), &(iic_cdce913_ssc_1_00[i][1]), 1);
            }
         }
         else if ( !strcmp(cargv[2],"1.25") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
                num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_1_25[i][0]), &(iic_cdce913_ssc_1_25[i][1]), 1);
            }
         }
         else if ( !strcmp(cargv[2],"1.50") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
                num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_1_50[i][0]), &(iic_cdce913_ssc_1_50[i][1]), 1);
            }
         }
         else if ( !strcmp(cargv[2],"2.00") )
         {
            for ( i = 0; i < MAX_IIC_CDCE913_SSC; i++ )
            {
                num_bytes = fmc_imageon_demo.fmc_imageon.pIIC->fpIicWrite( fmc_imageon_demo.fmc_imageon.pIIC, FMC_IMAGEON_VID_CLK_ADDR,
            		(0x80 | iic_cdce913_ssc_2_00[i][0]), &(iic_cdce913_ssc_2_00[i][1]), 1);
            }
         }
         else
         {
    		 bDispSyntax = 1;
         }
	  }
	  else
	  {
		 bDispSyntax = 1;
	  }
   }

   if ( bDispSyntax )
   {
	  pConsole->io_hprintf( pConsole->io_handle, "\tSyntax :\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\tcdce913 ssc off|0.25|0.50|0.75|1.00|1.25|1.50|2.00\r\n" );
	  pConsole->io_hprintf( pConsole->io_handle, "\t\t                     => Spread Spectrum Clocking\r\n" );
   }

   return;
}
