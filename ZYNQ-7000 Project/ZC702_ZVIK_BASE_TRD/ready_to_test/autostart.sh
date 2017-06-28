#!/bin/sh

# Source environment for init script
source /etc/profile

# Program EDID if ADV7611 subdev node exists
DEVNAME=$(media-ctl -e "adv7611 12-004c")
if [ -c $DEVNAME ] 2> /dev/null
then
    echo "Programming EDID into ADV7611..."
    edid $DEVNAME 0 /usr/local/lib/firmware/edid.bin
fi

# Start Qt application
echo "Starting Zynq Base TRD Application..."
run_video.sh -qt &

# Print info
echo "To re-run this application, type the following commands:"
echo "run_video.sh -qt"
