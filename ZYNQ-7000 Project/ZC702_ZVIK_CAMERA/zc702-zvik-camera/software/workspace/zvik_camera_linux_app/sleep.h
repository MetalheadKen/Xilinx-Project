
// Function prototypes
//void usleep(unsigned int useconds);
#if !defined(LINUX_CODE)
int usleep(unsigned int useconds);
#endif

void millisleep(unsigned int microseconds);

#if !defined(LINUX_CODE)
void sleep(unsigned int seconds);
#endif
