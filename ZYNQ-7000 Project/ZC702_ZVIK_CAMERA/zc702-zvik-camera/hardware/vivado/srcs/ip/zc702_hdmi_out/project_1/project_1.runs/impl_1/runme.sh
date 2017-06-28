#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/proj/xbuilds/2013.1_daily_latest/installs/lin64/SDK/2013.1/bin/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/EDK/bin/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/ISE/bin/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/bin
else
  PATH=/proj/xbuilds/2013.1_daily_latest/installs/lin64/SDK/2013.1/bin/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/EDK/bin/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/ISE/bin/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/EDK/lib/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/EDK/lib/lin64:/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD=`dirname "$0"`
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log zc702_hdmi_out.rdi -applog -m64 -messageDb vivado.pb -mode batch -source zc702_hdmi_out.tcl -notrace


