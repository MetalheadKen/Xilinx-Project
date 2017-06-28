################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../avnet_console.c \
../avnet_console_scanput.c \
../avnet_console_serial.c \
../avnet_console_tokenize.c \
../avnet_console_web.c \
../fmc_imageon_demo.c \
../main.c \
../sleep.c \
../video_detector.c \
../video_frame_buffer.c \
../video_generator.c \
../video_ipipe.c \
../video_ipipe_stats.c \
../video_resolution.c 

OBJS += \
./avnet_console.o \
./avnet_console_scanput.o \
./avnet_console_serial.o \
./avnet_console_tokenize.o \
./avnet_console_web.o \
./fmc_imageon_demo.o \
./main.o \
./sleep.o \
./video_detector.o \
./video_frame_buffer.o \
./video_generator.o \
./video_ipipe.o \
./video_ipipe_stats.o \
./video_resolution.o 

C_DEPS += \
./avnet_console.d \
./avnet_console_scanput.d \
./avnet_console_serial.d \
./avnet_console_tokenize.d \
./avnet_console_web.d \
./fmc_imageon_demo.d \
./main.d \
./sleep.d \
./video_detector.d \
./video_frame_buffer.d \
./video_generator.d \
./video_ipipe.d \
./video_ipipe_stats.d \
./video_resolution.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Linux gcc compiler'
	arm-xilinx-linux-gnueabi-gcc -Dxil_printf=printf -DLINUX_CODE -Wall -O0 -g3 -I../peripherals -I../peripherals/include -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


