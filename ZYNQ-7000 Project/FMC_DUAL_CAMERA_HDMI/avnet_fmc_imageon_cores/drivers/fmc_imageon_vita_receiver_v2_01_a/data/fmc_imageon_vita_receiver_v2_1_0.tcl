##############################################################################
## Filename:          C:\FMC_IMAGEON_Tests\ml605_avnet_hw04/drivers/fmc_imageon_vita_receiver_v1_00_a/data/fmc_imageon_vita_receiver_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Thu Sep 15 13:07:28 2011 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "fmc_imageon_vita_receiver" "NUM_INSTANCES" "DEVICE_ID" "C_S00_AXI_BASEADDR" "C_S00_AXI_HIGHADDR" 
}
