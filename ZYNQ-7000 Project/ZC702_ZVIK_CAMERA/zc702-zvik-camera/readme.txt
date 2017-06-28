*************************************************************************
   ____  ____ 
  /   /\/   / 
 /___/  \  /   
 \   \   \/    © Copyright 2013 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary 
  /   /        information of Xilinx, Inc. and is protected under U.S. 
 /___/   /\    and international copyright and other intellectual 
 \   \  /  \   property laws. 
  \___\/\___\ 
 
*************************************************************************

Vendor: Xilinx 
Current readme.txt Version: 2.1.0
Date Last Modified:  13AUG2013 
Date Created: 13AUG2013

Associated Filename: xapp794.zip
Associated Document: xapp794, 1080P60 Camera Image Processing Reference 
                     Design

Supported Device(s): Zynq-70xx All Programmable SoC's
   
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

This readme file contains these sections:

1. REVISION HISTORY
2. OVERVIEW
3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
4. DESIGN FILE HIERARCHY
5. INSTALLATION AND OPERATING INSTRUCTIONS
6. OTHER INFORMATION (OPTIONAL)
7. SUPPORT


1. REVISION HISTORY 

            Readme  
Date        Version      Revision Description
=========================================================================
18DEC2013   1.0          Initial Xilinx release.
24JAN2013   1.1          Updated for 14.4.
15AUG2013   1.2          Updated for 2013.2
=========================================================================



2. OVERVIEW

This readme describes how to use the files that come with XAPP794.  This 
design includes all of the SD card files needed to setup and run the 
design on the Zynq-7000 All Programmable SoC Video and Imaging Kit (ZVIK) 
and all of the software and hardware design files needed to completely 
rebuild the entire design.  This design includes an Ethernet port for 
controlling the Graphical User Interface and a serial port.  The 
design uses the AXI4-Lite interface for communication between the ARM-9
processor and the Video IP cores instantiated in the Programmable Logic.
Refer to XAPP794 for a complete description of setting up and running the
design and also for complete instructions on rebuilding the design. 

3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

The installed software tool requirements for building this reference system are:
* Xilinx Vivado 2013.2
* Xilinx IP Integrator 2013.2
* SDK 2013.2

The software and hardware requirements for running the reference design on
the target hardware are:
* 32-bit/64-bit host PC with Ethernet port running Windows XP or Windows 7 
  Professional 32-bit/64-bit, or Ubuntu 10 or later 32-bit/64-bit Linux 
  distribution
* UART connected terminal (for example, Tera Term 4.69 or HyperTerminal) 
  (if desired)
* Zip/Unzip software (for example, 7-zip)
* Web browser such as Internet Explorer (to operate the web-based GUI)
• USB-UART driver from Silicon Labs. For information about installing the 
  USB-UART driver, see Zynq-7000 All Programmable SoC: ZC702 Evaluation Kit 
  and Video and Imaging Kit Getting Started Guide - described in XAPP794.


4. DESIGN FILE HIERARCHY

The directory structure underneath this top-level folder is described
below:

|-- binaries/
|   |-- boot_image/
|   |     Contains all of the boot image files for the ARM Processor
|   |-- sd_content/
|         Contains all of the SD card files required to boot the 
|         ZC702 board for this design.  COpy all files in this directory
|         to the root directory of the SD card.
|
|-- doc/
|         Contains the resource utilization in system_summary.html and an
|         Xcell Journal article on color calibration for the image sensor
|
|-- matlab/
|         Contains MATLAB scripts that were used to create the color correction
|         coefficients for the Color Correction Matrix IP core and the sample
|         images that were used to create them.  Also contains a User Guide for
|         the MATLAB scripts
|
|-- hardware/
|   |-- vivado/                 
|         Vivado hardware project for camera design
|
|-- software/
    |---workspace/
          Contains the SDK workspace, 
          including the Linux Camera application and the Linux webserver                                #Linux applications
                                #Zynq First Stage Boot Loader (FSBL) SDK project.
                                #FSBL BSP project.

5. INSTALLATION AND OPERATING INSTRUCTIONS 
Review XAPP794 for complete setup instructions

6. SUPPORT

To obtain technical support for this reference design, go to 
www.xilinx.com/support to locate answers to known issues in the Xilinx
Answers Database or to create a WebCase.  