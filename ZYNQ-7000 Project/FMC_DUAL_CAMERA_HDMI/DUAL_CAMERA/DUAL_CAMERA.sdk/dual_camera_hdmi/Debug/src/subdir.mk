################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/demo.c \
../src/edid_fmc_imageon.c \
../src/main.c \
../src/platform.c \
../src/sleep.c \
../src/xaxivdma_ext.c 

OBJS += \
./src/demo.o \
./src/edid_fmc_imageon.o \
./src/main.o \
./src/platform.o \
./src/sleep.o \
./src/xaxivdma_ext.o 

C_DEPS += \
./src/demo.d \
./src/edid_fmc_imageon.d \
./src/main.d \
./src/platform.d \
./src/sleep.d \
./src/xaxivdma_ext.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../dual_camera_hdmi_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


