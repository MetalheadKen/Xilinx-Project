/*
 * pipeProtocol.h
 *
 *  Created on: Mar 19, 2012
 *      Author: bretts
 */

#ifndef PIPEPROTOCOL_H_
#define PIPEPROTOCOL_H_

#define HDR_CODE_IDX 	0
#define HDR_LEN_IDX 	1
#define HDR_ID_IDX 		2
#define HDR_SUB_IDX 	3
#define DATA_IDX		4

#define HEADER_OVERHEAD	4

#ifndef TRUE
#define TRUE	1
#endif

#ifndef FALSE
#define FALSE 	0
#endif

/******************* Nice Macros *************************/
#define BIT( n ) \
	( 1 << (n) )

#define SETBIT( r, n ) \
	( (r) |= (n) )

#define CLEARBIT( r, n ) \
	( (r) &= ~(n) )

#define TESTBIT( r, n ) \
	(( (r) & (n) ) != 0 )

#define TESTBITS( r, n ) \
	(( (r) & (n) ) == (n) )

#define HINIBBLE( n ) \
	((unsigned char)(( (n) >> 4 ) & 0x0F ))

#define LONIBBLE( n ) \
	((unsigned char)( (n) & 0x0F ))

#define HIBYTE( n ) \
	((unsigned char)(( (n) >> 8 ) & 0xFF ))

#define LOBYTE( n ) \
	((unsigned char)( (n) & 0xFF ))

#define HIWORD( n ) \
	((unsigned short)(( (n) >> 16 ) & 0xFFFF ))

#define LOWORD( n ) \
	((unsigned short)( (n) & 0xFFFF ))

#define HILONG( n ) \
	((unsigned long)(( (n) >> 32 ) & 0xFFFFFFFF ))

#define LOLONG( n ) \
	((unsigned long)( (n) & 0xFFFFFFFF ))



// Commands
#define GET_DETECTED_INPUT_RESOLUTION_CMD			0x80
#define SET_OUTPUT_RESOLUTION_CMD					0x81

// Data Lengths for responses
#define GET_DETECTED_INPUT_RESOLUTION_DATA_LENGTH	5

// Function Prototypes
unsigned char* pipeWriteNetFloat( unsigned char* pBuffer, float data );
unsigned char* pipeWriteNetWord( unsigned char* pBuffer, unsigned short data );
unsigned char* pipeReadNetWord( unsigned char* pBuffer, unsigned short* data );
unsigned char* pipeReadNetFloat( unsigned char* pBuffer, float* data );

void pipeInit(void);

void pipeSendCommandString( char *pCommand, int length );

void pipeSendCommand( unsigned char cmdIdx, unsigned char* buffer, unsigned char bufLen);
int pipeReadCommand( unsigned char* buffer, int bufLen );
int pipeReadCommandWithTimeout( unsigned char* buffer, int bufLen, int timeoutMsec );

int pipeValidateCommand( unsigned char* buffer, int bufLen, unsigned char cmd, unsigned char dataLen );
#endif /* PIPEPROTOCOL_H_ */
