onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -pli "E:/Xilinx/Vivado/2015.4/lib/win64.o/libxil_vsim.dll" -lib xil_defaultlib fmc_imageon_gs_opt

do {wave.do}

view wave
view structure
view signals

do {fmc_imageon_gs.udo}

run -all

quit -force
