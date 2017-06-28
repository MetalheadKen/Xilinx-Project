################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/fmc_imageon_vita_passthrough.c \
../src/helloworld.c \
../src/platform.c \
../src/sleep.c \
../src/video_generator.c \
../src/video_resolution.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/fmc_imageon_vita_passthrough.o \
./src/helloworld.o \
./src/platform.o \
./src/sleep.o \
./src/video_generator.o \
./src/video_resolution.o 

C_DEPS += \
./src/fmc_imageon_vita_passthrough.d \
./src/helloworld.d \
./src/platform.d \
./src/sleep.d \
./src/video_generator.d \
./src/video_resolution.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../dual_vita_passthrough_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


