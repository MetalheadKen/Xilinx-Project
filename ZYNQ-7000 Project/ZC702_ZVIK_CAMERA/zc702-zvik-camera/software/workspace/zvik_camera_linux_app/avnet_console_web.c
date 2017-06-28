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


#include <stdio.h>
#include <string.h>
#include <stdarg.h> // for variable argument lists
#include <stdlib.h>

#if defined(LINUX_CODE)
// for linux threads
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
void *web_session_handler(void* p);
#endif

#include "os.h"

// Located in: microblaze_0/include/
//#include "xbasic_types.h"
//#include "xutil.h"
#include "xparameters.h"
#include "xstatus.h"

#include "avnet_console.h"

#define PIPE_IN_NAME "/tmp/zvik_camera_linux_pipe_req"
#define PIPE_OUT_NAME "/tmp/zvik_camera_linux_pipe_rsp"

// This structure allows the text-based console to be accessed from any interface
//   for example: serial port, ethernet connection, etc...
struct struct_web_session_t
{
   // avnet console
   avnet_console_t avnet_console;

   // Names Pipes
   int pipe_in_fd;
   int pipe_out_fd;

   Xuint32 handler_active;
   Xuint32 handler_stop;
#if defined(LINUX_CODE)
   pthread_t handler_thread;
   int handler_thread_id;
   pthread_mutex_t handler_mutex;
#endif
};
typedef struct struct_web_session_t web_session_t;

web_session_t web_session;
static unsigned web_session_running = 0;

void *web_handle = (void *)&web_session;
int web_hprintf( void *web_handle, const char * fmt, ...)
{
   int ret;

   web_session_t *pSession = (web_session_t *)web_handle;
   static char buf[1024];
   va_list marker;
   int n;
   int i;

   va_start( marker, fmt);
   n = vsnprintf( buf, sizeof buf, fmt, marker);
   va_end( marker);

//   ret = write( pSession->pipe_out_fd, buf, n );
//   if ( ret != n )
//   {
//      OS_PRINTF("Failed to send response to output pipe %s\n", PIPE_OUT_NAME);
//   }
   OS_PRINTF( buf );

   return n;
}

int
transfer_avnet_console_web_data()
{
}

void
print_avnet_console_web_app_header()
{
   OS_PRINTF("web avnet console : IN(%s) OUT(%s)\n\r", PIPE_IN_NAME, PIPE_OUT_NAME );
}


int
start_avnet_console_web_application()
{
	int ret;

    // Initialize serial console
    avnet_console_init( &(web_session.avnet_console) );
    web_session.avnet_console.io_handle = web_handle;
    web_session.avnet_console.io_hprintf = web_hprintf;
    web_session.avnet_console.echo = 0;

    web_session_running = 1;

	// See if we need to make the input pipe
    OS_PRINTF("access(PIPE_IN_NAME, F_OK) ...");
	if ( access(PIPE_IN_NAME, F_OK) == -1 )
	{
		ret = mkfifo(PIPE_IN_NAME, 0777);
		if ( ret != 0 )
		{
			OS_PRINTF("Could not create pipe %s\n", PIPE_IN_NAME);
			//exit(0);
		}
	}
    OS_PRINTF( "done\n\r" );

	// See if we need to make the output pipe
    OS_PRINTF("access(PIPE_OUT_NAME, F_OK) ...");
	if ( access(PIPE_OUT_NAME, F_OK) == -1 )
	{
		ret = mkfifo(PIPE_OUT_NAME, 0777);
		if ( ret != 0 )
		{
			OS_PRINTF("Could not create pipe %s\n", PIPE_OUT_NAME);
			//exit(0);
		}
	}
    OS_PRINTF( "done\n\r" );

	// Open the input pipe for reading.
    OS_PRINTF("open(PIPE_IN_NAME, O_RDONLY | O_NONBLOCK ) ...");
	web_session.pipe_in_fd = open(PIPE_IN_NAME, O_RDONLY | O_NONBLOCK );
	if ( web_session.pipe_in_fd == -1 )
	{
		OS_PRINTF("Could not open pipe %s\n", PIPE_IN_NAME);
		//exit(0);
	}
    OS_PRINTF( "done\n\r" );

	// Open the output pipe for writing
//    OS_PRINTF("open(PIPE_OUT_NAME, O_WRONLY ) ...");
//	web_session.pipe_out_fd = open(PIPE_OUT_NAME, O_WRONLY );
//	if ( web_session.pipe_out_fd == -1 )
//	{
//		OS_PRINTF("Could not open pipe %s\n", PIPE_OUT_NAME);
//		//exit(0);
//	}
//    OS_PRINTF( "done\n\r" );

   web_session.handler_active = 0;
   web_session.handler_stop   = 0;

#if defined(LINUX_CODE)
   web_session.handler_thread_id = pthread_create( &(web_session.handler_thread), NULL, &web_session_handler, (void *)&web_session);
   if ( web_session.handler_thread_id )
   {
	  OS_PRINTF("ERROR; return code from pthread_create() is %d\n", web_session.handler_thread_id );
	  return -1;
   }
#endif

    return 0;
}

#if defined(LINUX_CODE)
void *web_session_handler(void* p)
{
   web_session_t *pSession = (web_session_t *)p;

   pSession->handler_active = 1;
   OS_PRINTF("[web_session_handler] ... started\n\r" );

   while ( !pSession->handler_stop )
   {
      char inchar;
      int ret;

      ret = read( web_session.pipe_in_fd, &inchar, 1 );
      if ( ret > 0 )
      {
         web_session.avnet_console.inchar = inchar;
         if ( inchar == '\n' )
         {
        	 OS_PRINTF("[web_session_handler] ... %s\n\r", web_session.avnet_console.inline_buffer );
         }
         if ( inchar != 0x00 )
         {
            //OS_PRINTF("[web_session_handler] ... %c (0x%02X)\n\r", inchar, inchar );

            pthread_mutex_lock( &(pSession->handler_mutex) ); // Enter critical section
            {
               avnet_console_process( &(web_session.avnet_console) );
            }
            pthread_mutex_unlock( &(pSession->handler_mutex) ); // Exit critical section
         }
      }
   }

   pSession->handler_active = 0;
   OS_PRINTF("[web_session_handler] ... stopped\n\r" );

   return NULL;
}
#endif
