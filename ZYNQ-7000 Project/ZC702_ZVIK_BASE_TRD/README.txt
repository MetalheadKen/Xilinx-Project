*************************************************************************
   ____  ____
  /   /\/   /
 /___/  \  /
 \   \   \/    © Copyright 2016 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary
  /   /        information of Xilinx, Inc. and is protected under U.S.
 /___/   /\    and international copyright and other intellectual
 \   \  /  \   property laws.
  \___\/\___\

*************************************************************************

Vendor: Xilinx
Current README.txt Version: 2.12.0
Date Last Modified        : 18DEC2015
Date Created              : 31MAY2012

Associated Filename: rdf0286-zc702-zvik-base-trd-2015-4.zip
Associated Document: http://www.wiki.xilinx.com/Zynq+Base+TRD+2015.4
		     US873 - Zynq Concepts, Tools and Techniques
		     UG798 - Xilinx Design Tools: Installation and Licensing Guide
		     UG925 - Zynq-7000 ZC702 Evaluation Kit User Guide
		     UG850 - ZC702 Evaluation Board User Guide
Supported Device(s): XC7Z020-1CLG484

*************************************************************************

Disclaimer:

      This disclaimer is not a license and does not grant any rights to
      the materials distributed herewith. Except as otherwise provided in
      a valid license issued to you by Xilinx, and to the maximum extent
      permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE
      "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL
      WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
      INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY,
      NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
      (2) Xilinx shall not be liable (whether in contract or tort,
      including negligence, or under any other theory of liability) for
      any loss or damage of any kind or nature related to, arising under
      or in connection with these materials, including for any direct, or
      any indirect, special, incidental, or consequential loss or damage
      (including loss of data, profits, goodwill, or any type of loss or
      damage suffered as a result of any action brought by a third party)
      even if such damage or loss was reasonably foreseeable or Xilinx
      had been advised of the possibility of the same.

Critical Applications:

      Xilinx products are not designed or intended to be fail-safe, or
      for use in any application requiring fail-safe performance, such as
      life-support or safety devices or systems, Class III medical
      devices, nuclear facilities, applications related to the deployment
      of airbags, or any other applications that could lead to death,
      personal injury, or severe property or environmental damage
      (individually and collectively, "Critical Applications"). Customer
      assumes the sole risk and liability of any use of Xilinx products
      in Critical Applications, subject only to applicable laws and
      regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS
FILE AT ALL TIMES.

*************************************************************************

The video_qt application shipped with this reference design is based in
part on the work of the Qwt project (http://qwt.sf.net).

*************************************************************************

The applications shipped with this reference design include Linux kernel
header files and are not considered a "derivative work" for the purposes
of the GPL.

*************************************************************************

This readme file contains these sections:

1. REVISION HISTORY
2. OVERVIEW
3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
4. DESIGN FILE HIERARCHY
5. INSTALLATION AND OPERATING INSTRUCTIONS
6. OTHER INFORMATION
7. SUPPORT

1. REVISION HISTORY


            Readme
Date        Version      Revision Description
=========================================================================
31MAY2012   2.1.0       Zynq Base TRD 14.1 (2012.1) -- Initial Release
27JUL2012   2.2.0       Zynq Base TRD 14.2 (2012.2)
                            ~ IPs and Software Application upgraded for
                              14.2 (2012.2) tool version
                            ~ Drivers rebased for linux kernel 3.3
                            ~ Added kernel base driver for sobel filter
                            ~ Added support for 720p (along with 1080p)
                              depending on devicetree config.
                            ~ Software fixes
04OCT2012   2.2.1       Zynq Base TRD 14.2 (2012.2) Update 1
                            ~ FSBL modifications to fix issue when connecting
                            external video source through FMC IMAGEON
                            daughter card
19OCT2012   2.3.0       Zynq Base TRD 14.3 (2012.3)
                            ~ IPs and Software Application upgraded for
                              14.3 (2012.3) tool version
                            ~ Drivers rebased for Linux kernel 3.5
                            ~ UI Layout changed to horizontal orientation.
                              UI can be semi-transparent and pictorial
                              representation of sobel mode is Available.
17DEC2012  2.4.0       Zynq Base TRD 14.4 (2012.4)
                            ~ IPs and Software Application upgraded for
                              14.4(2012.4) tool version.
                            ~ Switch to TPG using AXI4-Stream.
                            ~ One Perf monitor for monitoring AXI bandwidth.
                            ~ Drivers rebased for Linux kernel 3.6
                            ~ new VDMA linux driver.
                            ~ Autotransparency in Sobel QT removed.
                            ~ Minor UI Fix.
18APR2013  2.5.0      Zynq Base TRD 14.5 (2013.1)
                            ~ IPs and Software Application upgraded for
                              14.5(2013.1) tool version.
                            ~ Integrated with linux Framebuffer API.
                            ~ UIO Linux drivers for Xilinx Video IPs.
                            ~ Configurable sobel controls i.e inversion of sobel
                              mode and changing sobel sensitivity .
                            ~ FMC detection based on reading IPMI FRU.
                            ~ One common API (sobel_lib)for both cmd and QT
                              applications.
                            ~ Video detection feature of Xilinx VTC IP used for
                              checking resolution of external video.
                            ~ QT resource file
03JULY2013 2.6.0       Zynq Base TRD 2013.2
                            ~ System hardware implementation in Vivado
                            ~ PetaLinux Framework
                            ~ Video Frame Synchronization using GenLock with TPG VDMA,
                              FILTER VDMA and LogiCVC.
10DEC2013 2.7.0        Zynq Base TRD 2013.3
                            ~ IPs and Software upgraded for 2013.3 tool
                              version.
                            ~ Petalinux SDK 2013.10
                            ~ Auto-start script decoupled from FIT image(image.ub).                                                                        User can easily customize auto-start of sobel
                              QT application.
                            ~ Improved TRD boot up time.
20JAN2014 2.8.0        Zynq Base TRD 2013.4
                            ~ IPs and Software upgraded for 2013.4 tool
                              version.

30JUL2014 2.9.0        Zynq Base TRD 2014.2
                            ~ IPs and Software upgraded for 2014.2 tool
                              version.
			    ~ Petalinux 2014.2
			    ~ Implements Linux V4L2 , media
			      framework for video capture/control and direct
			      rendering manager(DRM) framework for video
                              display.
                            ~ Input video pipe is converted to YUV422 format
15DEC2014 2.10.0        Zynq Base TRD 2014.4
                            ~ IPs and Software upgraded for 2014.4 tool
                              version.
			    ~ Petalinux 2014.4
			    ~ DRM: Implements universal plane support.
			    ~ APM in profile mode.
			    ~ Sobel software code uses OpenCV.
			    ~ Sobel HLS core switched to adapter-less flow.
			    ~ SD card image changed from FIT to discrete
			      components.

13JUL2015 2.11.0       Zynq Base TRD 2015.2
			    ~ IPs and Software upgraded for 2015.2 tool
                              version.
			    ~ Use AXI IIC instead of PS I2C1(EMIO).
			    ~ Petalinux 2015.2
			    ~ Xilinx APM driver.
			    ~ Fix display of half-processed frames during mode
			      switch.
                            ~ Remove video QT 720p support.
18DEC2015 2.12.0      Zynq Base TRD 2015.4
			    ~ IPs and Software upgraded for 2015.4 tool
                              version.
			    ~ Petalinux 2015.4
			    ~ Split capture pipeline for TGP and HDMI.
			    ~ Support added for TPG v7 (HLS based IP).
			    ~ Fix CTRL+c restore implementation in DRM
			      driver/application.
			    ~ QT 5.4.2
=========================================================================



2. OVERVIEW

The Base TRD is an embedded video processing application designed to showcase
various features and capabilities of Zynq Z-7020 All Programmable SoC (AP SoC)
device for the embedded domain. The Base TRD consists of two elements: The
Zynq-7000 AP SoC Processing System (PS) and a video processing pipeline
implemented in Programmable Logic (PL). The AP SoC allows the user to implement
a video processing algorithm that performs edge detection on an image (Sobel
filter) either as a software program running on the Zynq-7000 AP SoC PS or as
a hardware accelerator inside the PL.

The Base TRD demonstrates how the user can seamlessly switch between a software
or a hardware implementation and evaluate the cost and benefit of each
implementation. The TRD also demonstrates the value of offloading computation
intensive tasks onto PL, thereby freeing the CPU resources to be available for
user-specific applications.

The package consists of two video based application projects which differ
in user interface.
a) video_qt application has a graphical user interface designed
using QT framework.
b) video_cmd application has a command line based menu where the user can
navigate the menu by typing options into the terminal.

For information on how to use this package, along with build instructions,
please refer http://www.wiki.xilinx.com/Zynq+Base+TRD+2015.4

3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

Software:
  -- Vivado Design Suite 2015.4
  -- Proper installation of required license files for the TRD.
  -- Optional: ZC702 board uses CP210x USB to UART Bridge to provide COM port
     connection to the board. This configuration is highly recommended because
     the UART outputs information to hyper terminal right after power up.
     To use this feature, hyper terminal, Minicom, teraterm or equivalent
     terminal software on the host machine is required. For details, please
     refer to UG925 for USB-to-UART Bridge driver installation.
  -- For additional information on software installation, refer to UG798.

Hardware:
  -- The reference design targets the Zynq ZC702 evaluation board, Rev C or
     above.
  -- ZC702 evaluation board setup in the default configuration as documented
     in the Default Switch and Jumper Setting of UG850.
  -- AC power adapter (12VDC)
  -- HDMI-to-HDMI or HDMI-to-DVI cable (depending on available Monitor)
  -- Monitor capable of supporting 1080p60 / 720p60
  -- USB Type-A Female to USB Micro-B Male cable
  -- USB hub
  -- USB mouse
  -- Optional: USB Type A Male to USB Mini-B Male cable if using USB-to-UART
     bridge
  -- Optional: Avnet FMC IMAGEON daughter card for video input with 1080p / 720p
     input video source
  -- SD memory card reader for transferring files onto the SD card.
     (not included in the package)


4. DESIGN FILE HIERARCHY


The directory structure underneath this top-level folder is described
below:

\Source
 |
 +----- \README.txt
 |              This file
 |
 +----- \IMPORTANT_NOTICE_CONCERNING_THIRD_PARTY_CONTENT.txt
 |              List of third party content
 |
 +----- \THIRD_PARTY_NOTICES.zip
 |		Third party notices extracted from original sources
 |
 +----- \hardware
 |           +--\vivado
 |              Vivado hardware project for TRD design
 |
 |           +--\vivado_hls
 |              Vivado HLS project .The C-algorithm for the sobel
 |              filter that gets synthesized to an RTL pcore
 |
 +----- \ready_to_test
 |           +--\BOOT.BIN
 |              Zynq Boot Image, which is created from
 |              FSBL, hardware bitstream and u-boot
 |
 |           +--\uImage
 |              Xilinx Linux kernel
 |
 |           +--\devicetree.dtb
 |	        Device tree.
 |
 |           +--\uramdisk.image.gz
 |	        ramdisk image with third party libs/apps(DRM,V4Ls)
 |
 |           +--\autostart.sh
 |              TRD init script.
 |
 |           +--\bin
 |		Contains video cmd and QT applications.
 |
 +----- \software
 |           +--\petalinux
 |              Petalinux project.
 |              Includes-
 |              Kernel,u-boot configurations.
 |              User application and libraries.
 |              Dynamic libraries and helper utilities of DRM/KMS/multimedia/V4L2 framework
 |
 |          +--\xsdk
 |             TRD application/libraries for XSDK.
 |             Headers of DRM/KMS/multimedia framework.
 |             Xilinx Linux 4.0 kernel exported headers.
 |             Dynamic libraries for DRM/V4L2/multimedia/V4L2/OpenCV.

5. INSTALLATION AND OPERATING INSTRUCTIONS


ZC702 Initial Setup:
--------------------

-- All jumpers and switches should be in default setting except SW16.
   Mode switch SW16 should be set to boot from SD card.
   See image for SD boot in User Guide (UG925).
   For a board with SW16, use the following configuration
   1: GND
   2: GND
   3: VCC
   4: VCC
   5: GND
   J21, J20, J22, J25, J26: Unstuffed
   For Rev C version of the board which does not have SW16,
   use the following jumper settings:
   J21: 2-3
   J20: 2-3
   J22: 1-2
   J25: 1-2
   J26: 2-3
-- Connect one end of the HDMI cable to board HDMI connector, connect the other
   end to the monitor's HDMI or DVI input
-- Connect USB Micro-B cable to on-board USB Micro connector J1, then connect up
   USB hub, mouse and keyboard.
-- connect the AC power adapter
-- Optional: If USB-to-UART bridge is used, connect USB Mini-B side of USB-to-
   Mini-B cable to the on-board mini USB connector (J17). Connect USB side to
   the control PC.
-- Optional: If Avnet Imageon card is used, connect the card to FMC slot 2.
   Connect 1080p/720p video input source to HDMI-IN.

Building Design:
----------------

Instructions to Build Hardware and Software for this TRD are available at
http://www.wiki.xilinx.com/Zynq+Base+TRD+2015.4

The pre compiled files are kept in ready_to_test directory and can be loaded on SD card
root to get started with the design. On Linux boot up the TRD application is
auto loaded and GUI comes on the screen. Here various options can be explored.

For more details on how to Run the TRD please see UG925,User Guide.

6.OTHER INFORMATION

1) Design Notes
	Not applicable.

2) Known Issues
	Mouse hotplugging is not supported in Video QT application.
	Hence it is must to connect mouse before starting application.
	Reason: Qt 5 has a hard dependency on libudev for hot pluggable hardware detection/support.

7. SUPPORT

To obtain technical support for this reference design, go to www.xilinx.com/support
to locate answers to known issues in the Xilinx Answers Database.
