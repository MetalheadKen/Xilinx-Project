################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../peripherals/ccm.c \
../peripherals/cfa.c \
../peripherals/cresample.c \
../peripherals/dpc.c \
../peripherals/enhance.c \
../peripherals/fmc_iic_axi.c \
../peripherals/fmc_iic_sg.c \
../peripherals/fmc_imageon.c \
../peripherals/fmc_imageon_vita_receiver.c \
../peripherals/fmc_imageov.c \
../peripherals/fmc_ipmi.c \
../peripherals/fmc_ipmi_fru.c \
../peripherals/gamma.c \
../peripherals/noise.c \
../peripherals/rgb2ycrcb.c \
../peripherals/stats.c \
../peripherals/tpg.c \
../peripherals/xbasic_types.c \
../peripherals/xgpiops.c \
../peripherals/xgpiops_g.c \
../peripherals/xgpiops_intr.c \
../peripherals/xgpiops_selftest.c \
../peripherals/xgpiops_sinit.c \
../peripherals/xiic.c \
../peripherals/xiic_dyn_master.c \
../peripherals/xiic_g.c \
../peripherals/xiic_intr.c \
../peripherals/xiic_l.c \
../peripherals/xiic_master.c \
../peripherals/xiic_multi_master.c \
../peripherals/xiic_options.c \
../peripherals/xiic_selftest.c \
../peripherals/xiic_sinit.c \
../peripherals/xiic_slave.c \
../peripherals/xiic_stats.c \
../peripherals/xiicps.c \
../peripherals/xiicps_g.c \
../peripherals/xiicps_intr.c \
../peripherals/xiicps_master.c \
../peripherals/xiicps_options.c \
../peripherals/xiicps_selftest.c \
../peripherals/xiicps_sinit.c \
../peripherals/xiicps_slave.c \
../peripherals/xil_assert.c \
../peripherals/xil_io.c \
../peripherals/xvtc.c \
../peripherals/xvtc_g.c \
../peripherals/xvtc_intr.c \
../peripherals/xvtc_sinit.c 

OBJS += \
./peripherals/ccm.o \
./peripherals/cfa.o \
./peripherals/cresample.o \
./peripherals/dpc.o \
./peripherals/enhance.o \
./peripherals/fmc_iic_axi.o \
./peripherals/fmc_iic_sg.o \
./peripherals/fmc_imageon.o \
./peripherals/fmc_imageon_vita_receiver.o \
./peripherals/fmc_imageov.o \
./peripherals/fmc_ipmi.o \
./peripherals/fmc_ipmi_fru.o \
./peripherals/gamma.o \
./peripherals/noise.o \
./peripherals/rgb2ycrcb.o \
./peripherals/stats.o \
./peripherals/tpg.o \
./peripherals/xbasic_types.o \
./peripherals/xgpiops.o \
./peripherals/xgpiops_g.o \
./peripherals/xgpiops_intr.o \
./peripherals/xgpiops_selftest.o \
./peripherals/xgpiops_sinit.o \
./peripherals/xiic.o \
./peripherals/xiic_dyn_master.o \
./peripherals/xiic_g.o \
./peripherals/xiic_intr.o \
./peripherals/xiic_l.o \
./peripherals/xiic_master.o \
./peripherals/xiic_multi_master.o \
./peripherals/xiic_options.o \
./peripherals/xiic_selftest.o \
./peripherals/xiic_sinit.o \
./peripherals/xiic_slave.o \
./peripherals/xiic_stats.o \
./peripherals/xiicps.o \
./peripherals/xiicps_g.o \
./peripherals/xiicps_intr.o \
./peripherals/xiicps_master.o \
./peripherals/xiicps_options.o \
./peripherals/xiicps_selftest.o \
./peripherals/xiicps_sinit.o \
./peripherals/xiicps_slave.o \
./peripherals/xil_assert.o \
./peripherals/xil_io.o \
./peripherals/xvtc.o \
./peripherals/xvtc_g.o \
./peripherals/xvtc_intr.o \
./peripherals/xvtc_sinit.o 

C_DEPS += \
./peripherals/ccm.d \
./peripherals/cfa.d \
./peripherals/cresample.d \
./peripherals/dpc.d \
./peripherals/enhance.d \
./peripherals/fmc_iic_axi.d \
./peripherals/fmc_iic_sg.d \
./peripherals/fmc_imageon.d \
./peripherals/fmc_imageon_vita_receiver.d \
./peripherals/fmc_imageov.d \
./peripherals/fmc_ipmi.d \
./peripherals/fmc_ipmi_fru.d \
./peripherals/gamma.d \
./peripherals/noise.d \
./peripherals/rgb2ycrcb.d \
./peripherals/stats.d \
./peripherals/tpg.d \
./peripherals/xbasic_types.d \
./peripherals/xgpiops.d \
./peripherals/xgpiops_g.d \
./peripherals/xgpiops_intr.d \
./peripherals/xgpiops_selftest.d \
./peripherals/xgpiops_sinit.d \
./peripherals/xiic.d \
./peripherals/xiic_dyn_master.d \
./peripherals/xiic_g.d \
./peripherals/xiic_intr.d \
./peripherals/xiic_l.d \
./peripherals/xiic_master.d \
./peripherals/xiic_multi_master.d \
./peripherals/xiic_options.d \
./peripherals/xiic_selftest.d \
./peripherals/xiic_sinit.d \
./peripherals/xiic_slave.d \
./peripherals/xiic_stats.d \
./peripherals/xiicps.d \
./peripherals/xiicps_g.d \
./peripherals/xiicps_intr.d \
./peripherals/xiicps_master.d \
./peripherals/xiicps_options.d \
./peripherals/xiicps_selftest.d \
./peripherals/xiicps_sinit.d \
./peripherals/xiicps_slave.d \
./peripherals/xil_assert.d \
./peripherals/xil_io.d \
./peripherals/xvtc.d \
./peripherals/xvtc_g.d \
./peripherals/xvtc_intr.d \
./peripherals/xvtc_sinit.d 


# Each subdirectory must supply rules for building sources it contributes
peripherals/%.o: ../peripherals/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Linux gcc compiler'
	arm-xilinx-linux-gnueabi-gcc -Dxil_printf=printf -DLINUX_CODE -Wall -O0 -g3 -I../peripherals -I../peripherals/include -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


