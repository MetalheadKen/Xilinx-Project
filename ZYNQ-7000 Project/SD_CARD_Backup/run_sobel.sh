#!/bin/sh

# Define display usage
display_usage ()
{
	echo "Start command line or Qt sobel filter TRD application"
    echo ""
    echo "usage:"
    echo "    $0 <mode> <arguments>"
    echo ""
    echo "    <mode>:"
    echo "        -cmd : command line based application"
    echo "        -qt  : Qt based application"
    echo ""
    echo "    <arguments>: Optional"
    echo "        -res 1280x720 : For switching to 720p"
    exit 1
}
if [ $# -ne 1 ] && [ $# -ne 3 ] ; then
#Call display usage
display_usage
fi

tty=`tty`
# check mode
if [ $1 == "-cmd" ] ; then
    # check current terminal
    if [ $tty == "/dev/ttyPS0" ] ; then
        # run command line based application
         if [ $# == 1 ] ; then
	 ./sobel_cmd
	 else
	 ./sobel_cmd $2 $3 
	fi 
    else
        echo "Your current terminal is $tty."
        echo "Please start the command line based sobel filter TRD application from the UART terminal (/dev/ttyPS0)."
        exit 1
    fi
elif [ $1 == "-qt" ] ; then
    # set environment
    TRD_LIB=/usr/local/lib/zynq_qt_install
    export LD_LIBRARY_PATH=${TRD_LIB}/lib
    export QT_QWS_FONTDIR=${TRD_LIB}/lib/fonts
    # run Qt based application
    if [ $# == 1 ] ; then
    ./sobel_qt
    else
    ./sobel_qt $2 $3 
    fi
else
    # Call display usage
    display_usage
fi
