################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/avnet_console.c \
../src/avnet_console_scanput.c \
../src/avnet_console_serial.c \
../src/avnet_console_tokenize.c \
../src/demo.c \
../src/edid_fmc_imageon.c \
../src/main.c \
../src/sleep.c \
../src/xaxivdma_ext.c 

OBJS += \
./src/avnet_console.o \
./src/avnet_console_scanput.o \
./src/avnet_console_serial.o \
./src/avnet_console_tokenize.o \
./src/demo.o \
./src/edid_fmc_imageon.o \
./src/main.o \
./src/sleep.o \
./src/xaxivdma_ext.o 

C_DEPS += \
./src/avnet_console.d \
./src/avnet_console_scanput.d \
./src/avnet_console_serial.d \
./src/avnet_console_tokenize.d \
./src/demo.d \
./src/edid_fmc_imageon.d \
./src/main.d \
./src/sleep.d \
./src/xaxivdma_ext.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../fmc_imageon_gs_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


