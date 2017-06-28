-- (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: avnet:avnet_hdmi:avnet_hdmi_in:3.1
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.avnet_hdmi_in;

ENTITY fmc_imageon_gs_avnet_hdmi_in_0_0 IS
  PORT (
    clk : IN STD_LOGIC;
    io_hdmii_spdif : IN STD_LOGIC;
    io_hdmii_video : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    audio_spdif : OUT STD_LOGIC;
    video_vblank : OUT STD_LOGIC;
    video_hblank : OUT STD_LOGIC;
    video_de : OUT STD_LOGIC;
    video_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END fmc_imageon_gs_avnet_hdmi_in_0_0;

ARCHITECTURE fmc_imageon_gs_avnet_hdmi_in_0_0_arch OF fmc_imageon_gs_avnet_hdmi_in_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF fmc_imageon_gs_avnet_hdmi_in_0_0_arch: ARCHITECTURE IS "yes";

  COMPONENT avnet_hdmi_in IS
    GENERIC (
      C_DATA_WIDTH : INTEGER; -- Video Data Width
      C_FAMILY : STRING
    );
    PORT (
      clk : IN STD_LOGIC;
      io_hdmii_spdif : IN STD_LOGIC;
      io_hdmii_video : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      audio_spdif : OUT STD_LOGIC;
      video_vblank : OUT STD_LOGIC;
      video_hblank : OUT STD_LOGIC;
      video_de : OUT STD_LOGIC;
      video_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      debug_o : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
    );
  END COMPONENT avnet_hdmi_in;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF fmc_imageon_gs_avnet_hdmi_in_0_0_arch: ARCHITECTURE IS "avnet_hdmi_in,Vivado 2015.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF fmc_imageon_gs_avnet_hdmi_in_0_0_arch : ARCHITECTURE IS "fmc_imageon_gs_avnet_hdmi_in_0_0,avnet_hdmi_in,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF clk: SIGNAL IS "xilinx.com:signal:clock:1.0 HDMI_CLOCK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF io_hdmii_spdif: SIGNAL IS "avnet.com:interface:avnet_hdmi:1.0 IO_HDMII SPDIF";
  ATTRIBUTE X_INTERFACE_INFO OF io_hdmii_video: SIGNAL IS "avnet.com:interface:avnet_hdmi:1.0 IO_HDMII DATA";
  ATTRIBUTE X_INTERFACE_INFO OF video_vblank: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT VBLANK";
  ATTRIBUTE X_INTERFACE_INFO OF video_hblank: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT HBLANK";
  ATTRIBUTE X_INTERFACE_INFO OF video_de: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT ACTIVE_VIDEO";
  ATTRIBUTE X_INTERFACE_INFO OF video_data: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT DATA";
BEGIN
  U0 : avnet_hdmi_in
    GENERIC MAP (
      C_DATA_WIDTH => 16,
      C_FAMILY => "zynq"
    )
    PORT MAP (
      clk => clk,
      io_hdmii_spdif => io_hdmii_spdif,
      io_hdmii_video => io_hdmii_video,
      audio_spdif => audio_spdif,
      video_vblank => video_vblank,
      video_hblank => video_hblank,
      video_de => video_de,
      video_data => video_data
    );
END fmc_imageon_gs_avnet_hdmi_in_0_0_arch;
