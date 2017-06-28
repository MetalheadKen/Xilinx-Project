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

-- IP VLNV: xilinx.com:ip:v_osd:6.0
-- IP Revision: 9

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY v_osd_v6_0_9;
USE v_osd_v6_0_9.v_osd;

ENTITY fmc_imageon_gs_v_osd_0_0 IS
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aclken : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axis_video0_tvalid : IN STD_LOGIC;
    s_axis_video0_tlast : IN STD_LOGIC;
    s_axis_video0_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_video0_tuser : IN STD_LOGIC;
    s_axis_video0_tready : OUT STD_LOGIC;
    s_axis_video1_tvalid : IN STD_LOGIC;
    s_axis_video1_tlast : IN STD_LOGIC;
    s_axis_video1_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_video1_tuser : IN STD_LOGIC;
    s_axis_video1_tready : OUT STD_LOGIC;
    m_axis_video_tvalid : OUT STD_LOGIC;
    m_axis_video_tlast : OUT STD_LOGIC;
    m_axis_video_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_video_tuser : OUT STD_LOGIC;
    m_axis_video_tready : IN STD_LOGIC;
    irq : OUT STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC
  );
END fmc_imageon_gs_v_osd_0_0;

ARCHITECTURE fmc_imageon_gs_v_osd_0_0_arch OF fmc_imageon_gs_v_osd_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF fmc_imageon_gs_v_osd_0_0_arch: ARCHITECTURE IS "yes";

  COMPONENT v_osd IS
    GENERIC (
      C_HAS_AXI4_LITE : INTEGER;
      C_HAS_INTC_IF : INTEGER;
      C_S_AXIS_VIDEO_DATA_WIDTH : INTEGER;
      C_S_AXIS_VIDEO_FORMAT : INTEGER;
      C_S_AXIS_VIDEO_TDATA_WIDTH : INTEGER;
      C_M_AXIS_VIDEO_TDATA_WIDTH : INTEGER;
      C_NUM_LAYERS : INTEGER;
      C_SCREEN_WIDTH : INTEGER;
      C_M_AXIS_VIDEO_WIDTH : INTEGER;
      C_M_AXIS_VIDEO_HEIGHT : INTEGER;
      C_LAYER0_TYPE : INTEGER;
      C_LAYER1_TYPE : INTEGER;
      C_LAYER2_TYPE : INTEGER;
      C_LAYER3_TYPE : INTEGER;
      C_LAYER4_TYPE : INTEGER;
      C_LAYER5_TYPE : INTEGER;
      C_LAYER6_TYPE : INTEGER;
      C_LAYER7_TYPE : INTEGER;
      C_BGCOLOR0 : INTEGER;
      C_BGCOLOR1 : INTEGER;
      C_BGCOLOR2 : INTEGER;
      C_LAYER0_ENABLE : INTEGER;
      C_LAYER0_GALPHA_EN : INTEGER;
      C_LAYER0_PRIORITY : INTEGER;
      C_LAYER0_ALPHA : INTEGER;
      C_LAYER0_X_POS : INTEGER;
      C_LAYER0_Y_POS : INTEGER;
      C_LAYER0_X_SIZE : INTEGER;
      C_LAYER0_Y_SIZE : INTEGER;
      C_LAYER1_ENABLE : INTEGER;
      C_LAYER1_GALPHA_EN : INTEGER;
      C_LAYER1_PRIORITY : INTEGER;
      C_LAYER1_ALPHA : INTEGER;
      C_LAYER1_X_POS : INTEGER;
      C_LAYER1_Y_POS : INTEGER;
      C_LAYER1_X_SIZE : INTEGER;
      C_LAYER1_Y_SIZE : INTEGER;
      C_LAYER2_ENABLE : INTEGER;
      C_LAYER2_GALPHA_EN : INTEGER;
      C_LAYER2_PRIORITY : INTEGER;
      C_LAYER2_ALPHA : INTEGER;
      C_LAYER2_X_POS : INTEGER;
      C_LAYER2_Y_POS : INTEGER;
      C_LAYER2_X_SIZE : INTEGER;
      C_LAYER2_Y_SIZE : INTEGER;
      C_LAYER3_ENABLE : INTEGER;
      C_LAYER3_GALPHA_EN : INTEGER;
      C_LAYER3_PRIORITY : INTEGER;
      C_LAYER3_ALPHA : INTEGER;
      C_LAYER3_X_POS : INTEGER;
      C_LAYER3_Y_POS : INTEGER;
      C_LAYER3_X_SIZE : INTEGER;
      C_LAYER3_Y_SIZE : INTEGER;
      C_LAYER4_ENABLE : INTEGER;
      C_LAYER4_GALPHA_EN : INTEGER;
      C_LAYER4_PRIORITY : INTEGER;
      C_LAYER4_ALPHA : INTEGER;
      C_LAYER4_X_POS : INTEGER;
      C_LAYER4_Y_POS : INTEGER;
      C_LAYER4_X_SIZE : INTEGER;
      C_LAYER4_Y_SIZE : INTEGER;
      C_LAYER5_ENABLE : INTEGER;
      C_LAYER5_GALPHA_EN : INTEGER;
      C_LAYER5_PRIORITY : INTEGER;
      C_LAYER5_ALPHA : INTEGER;
      C_LAYER5_X_POS : INTEGER;
      C_LAYER5_Y_POS : INTEGER;
      C_LAYER5_X_SIZE : INTEGER;
      C_LAYER5_Y_SIZE : INTEGER;
      C_LAYER6_ENABLE : INTEGER;
      C_LAYER6_GALPHA_EN : INTEGER;
      C_LAYER6_PRIORITY : INTEGER;
      C_LAYER6_ALPHA : INTEGER;
      C_LAYER6_X_POS : INTEGER;
      C_LAYER6_Y_POS : INTEGER;
      C_LAYER6_X_SIZE : INTEGER;
      C_LAYER6_Y_SIZE : INTEGER;
      C_LAYER7_ENABLE : INTEGER;
      C_LAYER7_GALPHA_EN : INTEGER;
      C_LAYER7_PRIORITY : INTEGER;
      C_LAYER7_ALPHA : INTEGER;
      C_LAYER7_X_POS : INTEGER;
      C_LAYER7_Y_POS : INTEGER;
      C_LAYER7_X_SIZE : INTEGER;
      C_LAYER7_Y_SIZE : INTEGER;
      C_LAYER0_IMEM_SIZE : INTEGER;
      C_LAYER0_INS_BOX_EN : INTEGER;
      C_LAYER0_INS_LINE_EN : INTEGER;
      C_LAYER0_INS_TEXT_EN : INTEGER;
      C_LAYER0_CLUT_SIZE : INTEGER;
      C_LAYER0_CLUT_MEMTYPE : INTEGER;
      C_LAYER0_FONT_NUM_CHARS : INTEGER;
      C_LAYER0_FONT_WIDTH : INTEGER;
      C_LAYER0_FONT_HEIGHT : INTEGER;
      C_LAYER0_FONT_BPP : INTEGER;
      C_LAYER0_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER0_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER0_TEXT_MAX_STRING_LENGTH : INTEGER;
      C_LAYER1_IMEM_SIZE : INTEGER;
      C_LAYER1_INS_BOX_EN : INTEGER;
      C_LAYER1_INS_LINE_EN : INTEGER;
      C_LAYER1_INS_TEXT_EN : INTEGER;
      C_LAYER1_CLUT_SIZE : INTEGER;
      C_LAYER1_CLUT_MEMTYPE : INTEGER;
      C_LAYER1_FONT_NUM_CHARS : INTEGER;
      C_LAYER1_FONT_WIDTH : INTEGER;
      C_LAYER1_FONT_HEIGHT : INTEGER;
      C_LAYER1_FONT_BPP : INTEGER;
      C_LAYER1_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER1_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER1_TEXT_MAX_STRING_LENGTH : INTEGER;
      C_LAYER2_IMEM_SIZE : INTEGER;
      C_LAYER2_INS_BOX_EN : INTEGER;
      C_LAYER2_INS_LINE_EN : INTEGER;
      C_LAYER2_INS_TEXT_EN : INTEGER;
      C_LAYER2_CLUT_SIZE : INTEGER;
      C_LAYER2_CLUT_MEMTYPE : INTEGER;
      C_LAYER2_FONT_NUM_CHARS : INTEGER;
      C_LAYER2_FONT_WIDTH : INTEGER;
      C_LAYER2_FONT_HEIGHT : INTEGER;
      C_LAYER2_FONT_BPP : INTEGER;
      C_LAYER2_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER2_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER2_TEXT_MAX_STRING_LENGTH : INTEGER;
      C_LAYER3_IMEM_SIZE : INTEGER;
      C_LAYER3_INS_BOX_EN : INTEGER;
      C_LAYER3_INS_LINE_EN : INTEGER;
      C_LAYER3_INS_TEXT_EN : INTEGER;
      C_LAYER3_CLUT_SIZE : INTEGER;
      C_LAYER3_CLUT_MEMTYPE : INTEGER;
      C_LAYER3_FONT_NUM_CHARS : INTEGER;
      C_LAYER3_FONT_WIDTH : INTEGER;
      C_LAYER3_FONT_HEIGHT : INTEGER;
      C_LAYER3_FONT_BPP : INTEGER;
      C_LAYER3_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER3_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER3_TEXT_MAX_STRING_LENGTH : INTEGER;
      C_LAYER4_IMEM_SIZE : INTEGER;
      C_LAYER4_INS_BOX_EN : INTEGER;
      C_LAYER4_INS_LINE_EN : INTEGER;
      C_LAYER4_INS_TEXT_EN : INTEGER;
      C_LAYER4_CLUT_SIZE : INTEGER;
      C_LAYER4_CLUT_MEMTYPE : INTEGER;
      C_LAYER4_FONT_NUM_CHARS : INTEGER;
      C_LAYER4_FONT_WIDTH : INTEGER;
      C_LAYER4_FONT_HEIGHT : INTEGER;
      C_LAYER4_FONT_BPP : INTEGER;
      C_LAYER4_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER4_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER4_TEXT_MAX_STRING_LENGTH : INTEGER;
      C_LAYER5_IMEM_SIZE : INTEGER;
      C_LAYER5_INS_BOX_EN : INTEGER;
      C_LAYER5_INS_LINE_EN : INTEGER;
      C_LAYER5_INS_TEXT_EN : INTEGER;
      C_LAYER5_CLUT_SIZE : INTEGER;
      C_LAYER5_CLUT_MEMTYPE : INTEGER;
      C_LAYER5_FONT_NUM_CHARS : INTEGER;
      C_LAYER5_FONT_WIDTH : INTEGER;
      C_LAYER5_FONT_HEIGHT : INTEGER;
      C_LAYER5_FONT_BPP : INTEGER;
      C_LAYER5_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER5_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER5_TEXT_MAX_STRING_LENGTH : INTEGER;
      C_LAYER6_IMEM_SIZE : INTEGER;
      C_LAYER6_INS_BOX_EN : INTEGER;
      C_LAYER6_INS_LINE_EN : INTEGER;
      C_LAYER6_INS_TEXT_EN : INTEGER;
      C_LAYER6_CLUT_SIZE : INTEGER;
      C_LAYER6_CLUT_MEMTYPE : INTEGER;
      C_LAYER6_FONT_NUM_CHARS : INTEGER;
      C_LAYER6_FONT_WIDTH : INTEGER;
      C_LAYER6_FONT_HEIGHT : INTEGER;
      C_LAYER6_FONT_BPP : INTEGER;
      C_LAYER6_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER6_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER6_TEXT_MAX_STRING_LENGTH : INTEGER;
      C_LAYER7_IMEM_SIZE : INTEGER;
      C_LAYER7_INS_BOX_EN : INTEGER;
      C_LAYER7_INS_LINE_EN : INTEGER;
      C_LAYER7_INS_TEXT_EN : INTEGER;
      C_LAYER7_CLUT_SIZE : INTEGER;
      C_LAYER7_CLUT_MEMTYPE : INTEGER;
      C_LAYER7_FONT_NUM_CHARS : INTEGER;
      C_LAYER7_FONT_WIDTH : INTEGER;
      C_LAYER7_FONT_HEIGHT : INTEGER;
      C_LAYER7_FONT_BPP : INTEGER;
      C_LAYER7_FONT_ASCII_OFFSET : INTEGER;
      C_LAYER7_TEXT_NUM_STRINGS : INTEGER;
      C_LAYER7_TEXT_MAX_STRING_LENGTH : INTEGER
    );
    PORT (
      aclk : IN STD_LOGIC;
      aclken : IN STD_LOGIC;
      aresetn : IN STD_LOGIC;
      s_axi_aclk : IN STD_LOGIC;
      s_axi_aclken : IN STD_LOGIC;
      s_axi_aresetn : IN STD_LOGIC;
      s_axis_video0_tvalid : IN STD_LOGIC;
      s_axis_video0_tlast : IN STD_LOGIC;
      s_axis_video0_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video0_tuser : IN STD_LOGIC;
      s_axis_video0_tready : OUT STD_LOGIC;
      s_axis_video1_tvalid : IN STD_LOGIC;
      s_axis_video1_tlast : IN STD_LOGIC;
      s_axis_video1_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video1_tuser : IN STD_LOGIC;
      s_axis_video1_tready : OUT STD_LOGIC;
      s_axis_video2_tvalid : IN STD_LOGIC;
      s_axis_video2_tlast : IN STD_LOGIC;
      s_axis_video2_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video2_tuser : IN STD_LOGIC;
      s_axis_video2_tready : OUT STD_LOGIC;
      s_axis_video3_tvalid : IN STD_LOGIC;
      s_axis_video3_tlast : IN STD_LOGIC;
      s_axis_video3_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video3_tuser : IN STD_LOGIC;
      s_axis_video3_tready : OUT STD_LOGIC;
      s_axis_video4_tvalid : IN STD_LOGIC;
      s_axis_video4_tlast : IN STD_LOGIC;
      s_axis_video4_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video4_tuser : IN STD_LOGIC;
      s_axis_video4_tready : OUT STD_LOGIC;
      s_axis_video5_tvalid : IN STD_LOGIC;
      s_axis_video5_tlast : IN STD_LOGIC;
      s_axis_video5_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video5_tuser : IN STD_LOGIC;
      s_axis_video5_tready : OUT STD_LOGIC;
      s_axis_video6_tvalid : IN STD_LOGIC;
      s_axis_video6_tlast : IN STD_LOGIC;
      s_axis_video6_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video6_tuser : IN STD_LOGIC;
      s_axis_video6_tready : OUT STD_LOGIC;
      s_axis_video7_tvalid : IN STD_LOGIC;
      s_axis_video7_tlast : IN STD_LOGIC;
      s_axis_video7_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_video7_tuser : IN STD_LOGIC;
      s_axis_video7_tready : OUT STD_LOGIC;
      m_axis_video_tvalid : OUT STD_LOGIC;
      m_axis_video_tlast : OUT STD_LOGIC;
      m_axis_video_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m_axis_video_tuser : OUT STD_LOGIC;
      m_axis_video_tready : IN STD_LOGIC;
      intc_if : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      irq : OUT STD_LOGIC;
      s_axi_awaddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      s_axi_awvalid : IN STD_LOGIC;
      s_axi_awready : OUT STD_LOGIC;
      s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s_axi_wvalid : IN STD_LOGIC;
      s_axi_wready : OUT STD_LOGIC;
      s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_bvalid : OUT STD_LOGIC;
      s_axi_bready : IN STD_LOGIC;
      s_axi_araddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      s_axi_arvalid : IN STD_LOGIC;
      s_axi_arready : OUT STD_LOGIC;
      s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_rvalid : OUT STD_LOGIC;
      s_axi_rready : IN STD_LOGIC
    );
  END COMPONENT v_osd;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 aclk_intf CLK";
  ATTRIBUTE X_INTERFACE_INFO OF aclken: SIGNAL IS "xilinx.com:signal:clockenable:1.0 aclken_intf CE";
  ATTRIBUTE X_INTERFACE_INFO OF aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 aresetn_intf RST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 s_axi_aclk_intf CLK";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_aclken: SIGNAL IS "xilinx.com:signal:clockenable:1.0 s_axi_aclken_intf CE";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 s_axi_aresetn_intf RST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video0_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s0_in TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video0_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s0_in TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video0_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s0_in TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video0_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s0_in TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video0_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s0_in TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video1_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s1_in TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video1_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s1_in TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video1_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s1_in TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video1_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s1_in TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_video1_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 video_s1_in TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_video_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 video_out TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_video_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 video_out TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_video_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 video_out TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_video_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 video_out TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_video_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 video_out TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF irq: SIGNAL IS "xilinx.com:signal:interrupt:1.0 IRQ INTERRUPT";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 ctrl RREADY";
BEGIN
  U0 : v_osd
    GENERIC MAP (
      C_HAS_AXI4_LITE => 1,
      C_HAS_INTC_IF => 0,
      C_S_AXIS_VIDEO_DATA_WIDTH => 8,
      C_S_AXIS_VIDEO_FORMAT => 0,
      C_S_AXIS_VIDEO_TDATA_WIDTH => 16,
      C_M_AXIS_VIDEO_TDATA_WIDTH => 16,
      C_NUM_LAYERS => 2,
      C_SCREEN_WIDTH => 1920,
      C_M_AXIS_VIDEO_WIDTH => 1920,
      C_M_AXIS_VIDEO_HEIGHT => 1080,
      C_LAYER0_TYPE => 2,
      C_LAYER1_TYPE => 2,
      C_LAYER2_TYPE => 0,
      C_LAYER3_TYPE => 0,
      C_LAYER4_TYPE => 0,
      C_LAYER5_TYPE => 0,
      C_LAYER6_TYPE => 0,
      C_LAYER7_TYPE => 0,
      C_BGCOLOR0 => 128,
      C_BGCOLOR1 => 128,
      C_BGCOLOR2 => 128,
      C_LAYER0_ENABLE => 0,
      C_LAYER0_GALPHA_EN => 1,
      C_LAYER0_PRIORITY => 0,
      C_LAYER0_ALPHA => 256,
      C_LAYER0_X_POS => 0,
      C_LAYER0_Y_POS => 0,
      C_LAYER0_X_SIZE => 1920,
      C_LAYER0_Y_SIZE => 1080,
      C_LAYER1_ENABLE => 0,
      C_LAYER1_GALPHA_EN => 1,
      C_LAYER1_PRIORITY => 1,
      C_LAYER1_ALPHA => 256,
      C_LAYER1_X_POS => 0,
      C_LAYER1_Y_POS => 0,
      C_LAYER1_X_SIZE => 1920,
      C_LAYER1_Y_SIZE => 1080,
      C_LAYER2_ENABLE => 0,
      C_LAYER2_GALPHA_EN => 0,
      C_LAYER2_PRIORITY => 1,
      C_LAYER2_ALPHA => 256,
      C_LAYER2_X_POS => 0,
      C_LAYER2_Y_POS => 0,
      C_LAYER2_X_SIZE => 1280,
      C_LAYER2_Y_SIZE => 720,
      C_LAYER3_ENABLE => 0,
      C_LAYER3_GALPHA_EN => 0,
      C_LAYER3_PRIORITY => 1,
      C_LAYER3_ALPHA => 256,
      C_LAYER3_X_POS => 0,
      C_LAYER3_Y_POS => 0,
      C_LAYER3_X_SIZE => 1280,
      C_LAYER3_Y_SIZE => 720,
      C_LAYER4_ENABLE => 0,
      C_LAYER4_GALPHA_EN => 0,
      C_LAYER4_PRIORITY => 1,
      C_LAYER4_ALPHA => 256,
      C_LAYER4_X_POS => 0,
      C_LAYER4_Y_POS => 0,
      C_LAYER4_X_SIZE => 1280,
      C_LAYER4_Y_SIZE => 720,
      C_LAYER5_ENABLE => 0,
      C_LAYER5_GALPHA_EN => 0,
      C_LAYER5_PRIORITY => 1,
      C_LAYER5_ALPHA => 256,
      C_LAYER5_X_POS => 0,
      C_LAYER5_Y_POS => 0,
      C_LAYER5_X_SIZE => 1280,
      C_LAYER5_Y_SIZE => 720,
      C_LAYER6_ENABLE => 0,
      C_LAYER6_GALPHA_EN => 0,
      C_LAYER6_PRIORITY => 1,
      C_LAYER6_ALPHA => 256,
      C_LAYER6_X_POS => 0,
      C_LAYER6_Y_POS => 0,
      C_LAYER6_X_SIZE => 1280,
      C_LAYER6_Y_SIZE => 720,
      C_LAYER7_ENABLE => 0,
      C_LAYER7_GALPHA_EN => 0,
      C_LAYER7_PRIORITY => 1,
      C_LAYER7_ALPHA => 256,
      C_LAYER7_X_POS => 0,
      C_LAYER7_Y_POS => 0,
      C_LAYER7_X_SIZE => 1280,
      C_LAYER7_Y_SIZE => 720,
      C_LAYER0_IMEM_SIZE => 48,
      C_LAYER0_INS_BOX_EN => 1,
      C_LAYER0_INS_LINE_EN => 0,
      C_LAYER0_INS_TEXT_EN => 1,
      C_LAYER0_CLUT_SIZE => 16,
      C_LAYER0_CLUT_MEMTYPE => 2,
      C_LAYER0_FONT_NUM_CHARS => 96,
      C_LAYER0_FONT_WIDTH => 8,
      C_LAYER0_FONT_HEIGHT => 8,
      C_LAYER0_FONT_BPP => 1,
      C_LAYER0_FONT_ASCII_OFFSET => 32,
      C_LAYER0_TEXT_NUM_STRINGS => 8,
      C_LAYER0_TEXT_MAX_STRING_LENGTH => 32,
      C_LAYER1_IMEM_SIZE => 48,
      C_LAYER1_INS_BOX_EN => 1,
      C_LAYER1_INS_LINE_EN => 0,
      C_LAYER1_INS_TEXT_EN => 1,
      C_LAYER1_CLUT_SIZE => 16,
      C_LAYER1_CLUT_MEMTYPE => 2,
      C_LAYER1_FONT_NUM_CHARS => 96,
      C_LAYER1_FONT_WIDTH => 8,
      C_LAYER1_FONT_HEIGHT => 8,
      C_LAYER1_FONT_BPP => 1,
      C_LAYER1_FONT_ASCII_OFFSET => 32,
      C_LAYER1_TEXT_NUM_STRINGS => 8,
      C_LAYER1_TEXT_MAX_STRING_LENGTH => 32,
      C_LAYER2_IMEM_SIZE => 48,
      C_LAYER2_INS_BOX_EN => 1,
      C_LAYER2_INS_LINE_EN => 0,
      C_LAYER2_INS_TEXT_EN => 1,
      C_LAYER2_CLUT_SIZE => 16,
      C_LAYER2_CLUT_MEMTYPE => 2,
      C_LAYER2_FONT_NUM_CHARS => 96,
      C_LAYER2_FONT_WIDTH => 8,
      C_LAYER2_FONT_HEIGHT => 8,
      C_LAYER2_FONT_BPP => 1,
      C_LAYER2_FONT_ASCII_OFFSET => 32,
      C_LAYER2_TEXT_NUM_STRINGS => 8,
      C_LAYER2_TEXT_MAX_STRING_LENGTH => 32,
      C_LAYER3_IMEM_SIZE => 48,
      C_LAYER3_INS_BOX_EN => 1,
      C_LAYER3_INS_LINE_EN => 0,
      C_LAYER3_INS_TEXT_EN => 1,
      C_LAYER3_CLUT_SIZE => 16,
      C_LAYER3_CLUT_MEMTYPE => 2,
      C_LAYER3_FONT_NUM_CHARS => 96,
      C_LAYER3_FONT_WIDTH => 8,
      C_LAYER3_FONT_HEIGHT => 8,
      C_LAYER3_FONT_BPP => 1,
      C_LAYER3_FONT_ASCII_OFFSET => 32,
      C_LAYER3_TEXT_NUM_STRINGS => 8,
      C_LAYER3_TEXT_MAX_STRING_LENGTH => 32,
      C_LAYER4_IMEM_SIZE => 48,
      C_LAYER4_INS_BOX_EN => 1,
      C_LAYER4_INS_LINE_EN => 0,
      C_LAYER4_INS_TEXT_EN => 1,
      C_LAYER4_CLUT_SIZE => 16,
      C_LAYER4_CLUT_MEMTYPE => 2,
      C_LAYER4_FONT_NUM_CHARS => 96,
      C_LAYER4_FONT_WIDTH => 8,
      C_LAYER4_FONT_HEIGHT => 8,
      C_LAYER4_FONT_BPP => 1,
      C_LAYER4_FONT_ASCII_OFFSET => 32,
      C_LAYER4_TEXT_NUM_STRINGS => 8,
      C_LAYER4_TEXT_MAX_STRING_LENGTH => 32,
      C_LAYER5_IMEM_SIZE => 48,
      C_LAYER5_INS_BOX_EN => 1,
      C_LAYER5_INS_LINE_EN => 0,
      C_LAYER5_INS_TEXT_EN => 1,
      C_LAYER5_CLUT_SIZE => 16,
      C_LAYER5_CLUT_MEMTYPE => 2,
      C_LAYER5_FONT_NUM_CHARS => 96,
      C_LAYER5_FONT_WIDTH => 8,
      C_LAYER5_FONT_HEIGHT => 8,
      C_LAYER5_FONT_BPP => 1,
      C_LAYER5_FONT_ASCII_OFFSET => 32,
      C_LAYER5_TEXT_NUM_STRINGS => 8,
      C_LAYER5_TEXT_MAX_STRING_LENGTH => 32,
      C_LAYER6_IMEM_SIZE => 48,
      C_LAYER6_INS_BOX_EN => 1,
      C_LAYER6_INS_LINE_EN => 0,
      C_LAYER6_INS_TEXT_EN => 1,
      C_LAYER6_CLUT_SIZE => 16,
      C_LAYER6_CLUT_MEMTYPE => 2,
      C_LAYER6_FONT_NUM_CHARS => 96,
      C_LAYER6_FONT_WIDTH => 8,
      C_LAYER6_FONT_HEIGHT => 8,
      C_LAYER6_FONT_BPP => 1,
      C_LAYER6_FONT_ASCII_OFFSET => 32,
      C_LAYER6_TEXT_NUM_STRINGS => 8,
      C_LAYER6_TEXT_MAX_STRING_LENGTH => 32,
      C_LAYER7_IMEM_SIZE => 48,
      C_LAYER7_INS_BOX_EN => 1,
      C_LAYER7_INS_LINE_EN => 0,
      C_LAYER7_INS_TEXT_EN => 1,
      C_LAYER7_CLUT_SIZE => 16,
      C_LAYER7_CLUT_MEMTYPE => 2,
      C_LAYER7_FONT_NUM_CHARS => 96,
      C_LAYER7_FONT_WIDTH => 8,
      C_LAYER7_FONT_HEIGHT => 8,
      C_LAYER7_FONT_BPP => 1,
      C_LAYER7_FONT_ASCII_OFFSET => 32,
      C_LAYER7_TEXT_NUM_STRINGS => 8,
      C_LAYER7_TEXT_MAX_STRING_LENGTH => 32
    )
    PORT MAP (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      s_axi_aclk => s_axi_aclk,
      s_axi_aclken => s_axi_aclken,
      s_axi_aresetn => s_axi_aresetn,
      s_axis_video0_tvalid => s_axis_video0_tvalid,
      s_axis_video0_tlast => s_axis_video0_tlast,
      s_axis_video0_tdata => s_axis_video0_tdata,
      s_axis_video0_tuser => s_axis_video0_tuser,
      s_axis_video0_tready => s_axis_video0_tready,
      s_axis_video1_tvalid => s_axis_video1_tvalid,
      s_axis_video1_tlast => s_axis_video1_tlast,
      s_axis_video1_tdata => s_axis_video1_tdata,
      s_axis_video1_tuser => s_axis_video1_tuser,
      s_axis_video1_tready => s_axis_video1_tready,
      s_axis_video2_tvalid => '0',
      s_axis_video2_tlast => '0',
      s_axis_video2_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      s_axis_video2_tuser => '0',
      s_axis_video3_tvalid => '0',
      s_axis_video3_tlast => '0',
      s_axis_video3_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      s_axis_video3_tuser => '0',
      s_axis_video4_tvalid => '0',
      s_axis_video4_tlast => '0',
      s_axis_video4_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      s_axis_video4_tuser => '0',
      s_axis_video5_tvalid => '0',
      s_axis_video5_tlast => '0',
      s_axis_video5_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      s_axis_video5_tuser => '0',
      s_axis_video6_tvalid => '0',
      s_axis_video6_tlast => '0',
      s_axis_video6_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      s_axis_video6_tuser => '0',
      s_axis_video7_tvalid => '0',
      s_axis_video7_tlast => '0',
      s_axis_video7_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      s_axis_video7_tuser => '0',
      m_axis_video_tvalid => m_axis_video_tvalid,
      m_axis_video_tlast => m_axis_video_tlast,
      m_axis_video_tdata => m_axis_video_tdata,
      m_axis_video_tuser => m_axis_video_tuser,
      m_axis_video_tready => m_axis_video_tready,
      irq => irq,
      s_axi_awaddr => s_axi_awaddr,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_awready => s_axi_awready,
      s_axi_wdata => s_axi_wdata,
      s_axi_wstrb => s_axi_wstrb,
      s_axi_wvalid => s_axi_wvalid,
      s_axi_wready => s_axi_wready,
      s_axi_bresp => s_axi_bresp,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_bready => s_axi_bready,
      s_axi_araddr => s_axi_araddr,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_arready => s_axi_arready,
      s_axi_rdata => s_axi_rdata,
      s_axi_rresp => s_axi_rresp,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_rready => s_axi_rready
    );
END fmc_imageon_gs_v_osd_0_0_arch;
