#include "sleep.h"


//defined in iic_init.c
//void usleep(unsigned int useconds)
//{
//   int i;
//   for(i=0; i<useconds*2; i++);
//}

void millisleep(unsigned int milliseconds)
{
	int i = 0;

	//xil_printf( "millisleep(%d) ...\n\r", milliseconds );

	for (i=0; i<milliseconds; i++)
	{
		usleep(1000);
	}
}

#if defined(LINUX_CODE)
#include <unistd.h>
#else
void sleep(unsigned int seconds)
{
	int i = 0;

	//xil_printf( "sleep(%d)...\n\r", seconds );

	for (i=0; i<seconds; i++)
	{
		millisleep(1000);
	}
}
#endif