################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../zvik_webserver/ServerCGIFiles/cgiUtils.c \
../zvik_webserver/ServerCGIFiles/debug.c \
../zvik_webserver/ServerCGIFiles/main.c \
../zvik_webserver/ServerCGIFiles/multiply.c \
../zvik_webserver/ServerCGIFiles/pipeProtocol.c 

OBJS += \
./zvik_webserver/ServerCGIFiles/cgiUtils.o \
./zvik_webserver/ServerCGIFiles/debug.o \
./zvik_webserver/ServerCGIFiles/main.o \
./zvik_webserver/ServerCGIFiles/multiply.o \
./zvik_webserver/ServerCGIFiles/pipeProtocol.o 

C_DEPS += \
./zvik_webserver/ServerCGIFiles/cgiUtils.d \
./zvik_webserver/ServerCGIFiles/debug.d \
./zvik_webserver/ServerCGIFiles/main.d \
./zvik_webserver/ServerCGIFiles/multiply.d \
./zvik_webserver/ServerCGIFiles/pipeProtocol.d 


# Each subdirectory must supply rules for building sources it contributes
zvik_webserver/ServerCGIFiles/%.o: ../zvik_webserver/ServerCGIFiles/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Linux gcc compiler'
	arm-xilinx-linux-gnueabi-gcc -Wall -O0 -g3 -I../zvik_webserver/ServerCGIFiles -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


