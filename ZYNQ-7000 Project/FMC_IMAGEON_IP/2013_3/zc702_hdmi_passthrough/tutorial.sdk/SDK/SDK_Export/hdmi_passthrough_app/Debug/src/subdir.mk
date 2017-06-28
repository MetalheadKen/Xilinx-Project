################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/fmc_imageon_hdmi_passthrough.c \
../src/helloworld.c \
../src/platform.c \
../src/video_resolution.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/fmc_imageon_hdmi_passthrough.o \
./src/helloworld.o \
./src/platform.o \
./src/video_resolution.o 

C_DEPS += \
./src/fmc_imageon_hdmi_passthrough.d \
./src/helloworld.d \
./src/platform.d \
./src/video_resolution.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../hdmi_passthrough_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


