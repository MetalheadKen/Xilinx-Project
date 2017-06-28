//
//  test-cgibin.c
//  ZynqDemo
//
//  Created by Paul Kneeland on 1/26/12.
//  Copyright (c) 2012 Advanced Electronic Designs. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "cgiUtils.h"

#include "debug.h"

#include "pipeProtocol.h"

static void ProtocolTest()
{
	int ret;
	unsigned char buffer[256] = "version\n\r";



	printf("**** Beginning Command Test ****\n");

	//printf("Detecting Input.\n");
#if 0
	pipeSendCommand( GET_DETECTED_INPUT_RESOLUTION_CMD, NULL, 0 );

	printf("Reading response from command 0x80...\n");
	ret = pipeReadCommandWithTimeout(buffer, sizeof(buffer), 1000);
	if ( ret > 0 )
	{
		// Validate response
		if ( pipeValidateCommand( buffer, ret,
				GET_DETECTED_INPUT_RESOLUTION_CMD,
				GET_DETECTED_INPUT_RESOLUTION_DATA_LENGTH ) == TRUE )
		{
			printf("Response to 0x80 is good!\n");
		}
	}
	else
	{
		printf("0x80 command failed!\n");
	}
#endif
	//detectInput();
	pipeSendCommandString( buffer, sizeof(buffer) );
}

char request[1024];

int main(int argc, char *argv[])
{
   int i;
   pipeInit();

   if ( argc > 1 && strcmp(argv[1], "TEST") == 0 )
   {
      ProtocolTest();
      return 0;
   }
   const char *command = cgiParameter("command");

   // Copy command and terminate with new line character(s)
   sprintf( request, "%s\n\r", command );

   // Replace underscores with spaces
   for ( i = 0; i < strlen(request); i++ )
   {
      if ( request[i] == '_' )
      {
    	  request[i] = ' ';
      }
   }
    
   cgiOutputHeader();
    
    if (request)
    {
    	printf( "Length = %04d, Command = %s\n\r", sizeof(request), request );
    	pipeSendCommandString( request, sizeof(request) );
//        if (strcmp("VERSION_INFO", command) == 0)
//        {
//            versionInfo();
//        }
//        else if (strcmp("DETECT_INPUT", command) == 0)
//        {
//            detectInput();
//        }
//        else if (strcmp("DEMO_SELECTED", command) == 0)
//        {
//            demoSelected();
//        }
//        else if (strcmp("CURRENT_PARAMETER_VALUES", command) == 0)
//        {
//            currentParameterValues();
//        }
//        else if (strcmp("SET_SCALAR_CONFIGURATION_VALUES", command) == 0)
//        {
//            setScalarConfigurationValues();
//        }
//        else if (strcmp("SET_OUTPUT_RESOLUTION", command) == 0)
//        {
//            setOutputResolution();
//        }
//        else
//        {
//            printf("<BR><BR><P>Invalid command... please see debug information...</P>\n");
//            debug();
//        }
    }
    else
    {
        printf("<BR><BR><P>There was no command given... please see debug information...</P>\n");
        debug();        
    }
    
    return 0;
}
