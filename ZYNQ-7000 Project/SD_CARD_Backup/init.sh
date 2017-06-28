#!/bin/sh

echo "Starting Zynq Base TRD Application..."

#Note : Imageon driver is not used in current Zynq Base TRD Design.
# Setup for imageon driver.
# Set the firmware timeout through sysfs 
# echo "20" > /sys/class/firmware/timeout
 
#ADV7611_PATH=/mnt/adv7611

# Copy EDID firmware
#if [ -f ${ADV7611_PATH}/adv7611_edid.bin ]
#then
#  mkdir -p /lib/firmware  
#  cp  ${ADV7611_PATH}/adv7611_edid.bin /lib/firmware/
#else
#  echo "Warning : ADV7611 EDID missing"
#fi

# Load imageon driver
#if [ -f ${ADV7611_PATH}/imageon-rx.ko ]
#then 
#  /sbin/insmod ${ADV7611_PATH}/imageon-rx.ko
#else
#  echo "Warning : ADV7611 imageon driver missing"
#fi

TRD_LIB=/usr/local/lib/zynq_qt_install

# Create local Qt libs directory
if [ ! -d ${TRD_LIB} ]
then
  mkdir -p ${TRD_LIB} 
fi

# Mount Qt libs directory
if [ ! -d ${TRD_LIB}/lib ]
then
  mount /mnt/qt_lib.img ${TRD_LIB} -r -o loop
fi

# Create VDMA device node
if [ ! -f /dev/xvdma ]
then
  mknod /dev/xvdma c 10 224
fi

# Execute Qt application
cd /mnt/
./run_sobel.sh -qt&

echo "To re-run this application, type the following commands:"
echo "cd /mnt/"
echo "./run_sobel.sh -qt"
