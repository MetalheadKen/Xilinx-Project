/*
 * pipeProtocol.c
 *
 *  Created on: Mar 19, 2012
 *      Author: bretts
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <string.h>

#include "pipeProtocol.h"

#define PIPE_OUT_NAME "/tmp/zvik_camera_linux_pipe_req"
#define PIPE_IN_NAME "/tmp/zvik_camera_linux_pipe_rsp"
#define BUFFER_SIZE PIPE_BUF

static int g_pipe_in_fd = -1;
static int g_pipe_out_fd = -1;

static int g_msgId = 0;

void pipeInit(void)
{
	// Open the input pipe for reading.
	g_pipe_in_fd = open(PIPE_IN_NAME, O_RDONLY | O_NONBLOCK );
	if ( g_pipe_in_fd == -1 )
	{
		printf("Could not open pipe %s\n", PIPE_IN_NAME);
	}
	// Open the output pipe for writing
	g_pipe_out_fd = open(PIPE_OUT_NAME, O_WRONLY | O_NONBLOCK );
	if ( g_pipe_out_fd == -1 )
	{
		printf("Could not open pipe %s\n", PIPE_OUT_NAME);
	}

}

void pipeSendCommandString( char *pCommand, int length )
{
   int ret;

   if ( g_pipe_out_fd == -1 )
      return;

	ret = write(g_pipe_out_fd, pCommand, length );

	if ( ret != length )
	{
		printf("Error sending command string to demo : %s\n", pCommand );
	}

}

void pipeSendCommand( unsigned char cmdIdx, unsigned char* buffer, unsigned char bufLen)
{
	int ret;

	if ( g_pipe_out_fd == -1 )
		return;
	// build up the command
	unsigned char* outBuf = (unsigned char*)malloc(bufLen + HEADER_OVERHEAD);
	if ( outBuf == NULL )
	{
		return;
	}
	outBuf[HDR_CODE_IDX] = cmdIdx;
	outBuf[HDR_LEN_IDX] = bufLen;
	outBuf[HDR_ID_IDX] = ++g_msgId;
	outBuf[HDR_SUB_IDX] = 0;
	if ( buffer && bufLen )
	{
		memcpy(&outBuf[DATA_IDX], buffer, bufLen);
	}

	ret = write(g_pipe_out_fd, outBuf, bufLen + HEADER_OVERHEAD);

	if ( ret != bufLen + HEADER_OVERHEAD )
	{
		printf("Error writing command 0x%X to demo.\n", cmdIdx);
	}

	free(outBuf);

}

static unsigned char g_inBuf[256];
static int g_numInputChars = 0;
int pipeReadCommand( unsigned char* buffer, int bufLen )
{
	int ret;
	int totalChars;

	if ( g_pipe_in_fd == -1 )
		return -1;

	bufLen = bufLen > 256 ? 256 : bufLen;
	ret = read(g_pipe_in_fd, &g_inBuf[g_numInputChars], bufLen-g_numInputChars );

	if ( ret > 0 )
	{
		g_numInputChars += ret;
	}

	totalChars = g_inBuf[HDR_LEN_IDX] + HEADER_OVERHEAD;
	if ( g_numInputChars >= 2 && g_numInputChars >= totalChars )
	{
		g_numInputChars = 0;
		memcpy( buffer, g_inBuf, bufLen < totalChars ? bufLen : totalChars );
		return totalChars;
	}

	return ret < 0 ? ret : 0;

}

#define MSEC_TO_10_MSEC(n) ((n)/10)
#define USLEEP_10_MSEC	10000		// 10000 usec = 10 msec
int pipeReadCommandWithTimeout( unsigned char* buffer, int bufLen, int timeoutMsec )
{
	int i;
	int ret = 0;
	int timeoutLoops = MSEC_TO_10_MSEC(timeoutMsec);
	if ( timeoutLoops == 0 )
	{
		timeoutLoops = 1;
	}

	// Try to read the response.
	for ( i = 0; i < timeoutLoops; ++i )
	{
		ret = pipeReadCommand( buffer, bufLen );
		if ( ret > 0 )
		{
			return ret;
		}
		// Wait 10 msec and try again
		usleep( USLEEP_10_MSEC );
	}
	return ret;
}

int pipeValidateCommand( unsigned char* buffer, int bufLen, unsigned char cmd, unsigned char dataLen )
{
	if ( bufLen < HEADER_OVERHEAD )
	{
		return FALSE;
	}
	if ( buffer[HDR_CODE_IDX] == cmd && buffer[HDR_LEN_IDX] == dataLen )
	{
		return TRUE;
	}

	return FALSE;

}

unsigned char* pipeWriteNetFloat( unsigned char* pBuffer, float data )
{
	unsigned char* pData = (unsigned char*)&data;
	int i;
	for ( i = 0; i < sizeof(float); ++i )
	{
		*pBuffer++ = *pData++;
	}

	return ( pBuffer );

}

unsigned char* pipeWriteNetWord( unsigned char* pBuffer, unsigned short data )
{
	*pBuffer++ = HIBYTE( LOWORD( data ) );
	*pBuffer++ = LOBYTE( LOWORD( data ) );

	return ( pBuffer );
}

unsigned char* pipeReadNetWord( unsigned char* pBuffer, unsigned short* data )
{
	int i;
	*data = 0;

	for ( i = 0; i < sizeof(unsigned short); i++ )
	{
		*data <<= 8;
		*data += (unsigned short)*pBuffer++;
	}

	return ( pBuffer );
}

unsigned char* pipeReadNetFloat( unsigned char* pBuffer, float* data )
{
	unsigned char* pData = (unsigned char*)data;
	int i;
	for ( i = 0; i < sizeof(float); ++i )
	{
		*pData++ = *pBuffer++;
	}
	return ( pBuffer );
}



