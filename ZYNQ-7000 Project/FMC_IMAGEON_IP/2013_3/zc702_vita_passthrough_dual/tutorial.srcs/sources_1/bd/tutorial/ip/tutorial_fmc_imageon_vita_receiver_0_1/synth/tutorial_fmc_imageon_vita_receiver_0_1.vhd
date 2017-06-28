-- (c) Copyright 1995-2014 Xilinx, Inc. All rights reserved.
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

-- IP VLNV: avnet:fmc_imageon:fmc_imageon_vita_receiver:2.2
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.vita_receiver_v2_0;

ENTITY tutorial_fmc_imageon_vita_receiver_0_1 IS
  PORT (
    clk200 : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    oe : IN STD_LOGIC;
    io_vita_clk_pll : OUT STD_LOGIC;
    io_vita_reset_n : OUT STD_LOGIC;
    io_vita_spi_sclk : OUT STD_LOGIC;
    io_vita_spi_ssel_n : OUT STD_LOGIC;
    io_vita_spi_mosi : OUT STD_LOGIC;
    io_vita_spi_miso : IN STD_LOGIC;
    io_vita_trigger : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    io_vita_monitor : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    io_vita_clk_out_p : IN STD_LOGIC;
    io_vita_clk_out_n : IN STD_LOGIC;
    io_vita_sync_p : IN STD_LOGIC;
    io_vita_sync_n : IN STD_LOGIC;
    io_vita_data_p : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    io_vita_data_n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    trigger1 : IN STD_LOGIC;
    fsync : OUT STD_LOGIC;
    video_vsync : OUT STD_LOGIC;
    video_hsync : OUT STD_LOGIC;
    video_vblank : OUT STD_LOGIC;
    video_hblank : OUT STD_LOGIC;
    video_active_video : OUT STD_LOGIC;
    video_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    s00_axi_aclk : IN STD_LOGIC;
    s00_axi_aresetn : IN STD_LOGIC;
    s00_axi_awaddr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s00_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_awvalid : IN STD_LOGIC;
    s00_axi_awready : OUT STD_LOGIC;
    s00_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_wvalid : IN STD_LOGIC;
    s00_axi_wready : OUT STD_LOGIC;
    s00_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_bvalid : OUT STD_LOGIC;
    s00_axi_bready : IN STD_LOGIC;
    s00_axi_araddr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s00_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_arvalid : IN STD_LOGIC;
    s00_axi_arready : OUT STD_LOGIC;
    s00_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_rvalid : OUT STD_LOGIC;
    s00_axi_rready : IN STD_LOGIC
  );
END tutorial_fmc_imageon_vita_receiver_0_1;

ARCHITECTURE tutorial_fmc_imageon_vita_receiver_0_1_arch OF tutorial_fmc_imageon_vita_receiver_0_1 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF tutorial_fmc_imageon_vita_receiver_0_1_arch: ARCHITECTURE IS "yes";

  COMPONENT vita_receiver_v2_0 IS
    GENERIC (
      C_VIDEO_DATA_WIDTH : INTEGER;
      C_VIDEO_DIRECT_OUTPUT : INTEGER;
      C_IO_VITA_DATA_WIDTH : INTEGER;
      C_FAMILY : STRING;
      C_S00_AXI_DATA_WIDTH : INTEGER;
      C_S00_AXI_ADDR_WIDTH : INTEGER
    );
    PORT (
      clk200 : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      oe : IN STD_LOGIC;
      io_vita_clk_pll : OUT STD_LOGIC;
      io_vita_reset_n : OUT STD_LOGIC;
      io_vita_spi_sclk : OUT STD_LOGIC;
      io_vita_spi_ssel_n : OUT STD_LOGIC;
      io_vita_spi_mosi : OUT STD_LOGIC;
      io_vita_spi_miso : IN STD_LOGIC;
      io_vita_trigger : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      io_vita_monitor : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      io_vita_clk_out_p : IN STD_LOGIC;
      io_vita_clk_out_n : IN STD_LOGIC;
      io_vita_sync_p : IN STD_LOGIC;
      io_vita_sync_n : IN STD_LOGIC;
      io_vita_data_p : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      io_vita_data_n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      trigger1 : IN STD_LOGIC;
      fsync : OUT STD_LOGIC;
      video_vsync : OUT STD_LOGIC;
      video_hsync : OUT STD_LOGIC;
      video_vblank : OUT STD_LOGIC;
      video_hblank : OUT STD_LOGIC;
      video_active_video : OUT STD_LOGIC;
      video_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      debug_spi_o : OUT STD_LOGIC_VECTOR(95 DOWNTO 0);
      debug_iserdes_o : OUT STD_LOGIC_VECTOR(229 DOWNTO 0);
      debug_decoder_o : OUT STD_LOGIC_VECTOR(186 DOWNTO 0);
      debug_crc_o : OUT STD_LOGIC_VECTOR(87 DOWNTO 0);
      debug_triggen_o : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
      debug_syncgen_o : OUT STD_LOGIC_VECTOR(37 DOWNTO 0);
      debug_video_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_aclk : IN STD_LOGIC;
      s00_axi_aresetn : IN STD_LOGIC;
      s00_axi_awaddr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s00_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_awvalid : IN STD_LOGIC;
      s00_axi_awready : OUT STD_LOGIC;
      s00_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_wvalid : IN STD_LOGIC;
      s00_axi_wready : OUT STD_LOGIC;
      s00_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_bvalid : OUT STD_LOGIC;
      s00_axi_bready : IN STD_LOGIC;
      s00_axi_araddr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s00_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_arvalid : IN STD_LOGIC;
      s00_axi_arready : OUT STD_LOGIC;
      s00_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_rvalid : OUT STD_LOGIC;
      s00_axi_rready : IN STD_LOGIC
    );
  END COMPONENT vita_receiver_v2_0;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF tutorial_fmc_imageon_vita_receiver_0_1_arch: ARCHITECTURE IS "vita_receiver_v2_0,Vivado 2013.3";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF tutorial_fmc_imageon_vita_receiver_0_1_arch : ARCHITECTURE IS "tutorial_fmc_imageon_vita_receiver_0_1,vita_receiver_v2_0,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF reset: SIGNAL IS "xilinx.com:signal:reset:1.0 CORE_RST RST";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_clk_pll: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA clk_pll";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_reset_n: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA reset_n";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_spi_sclk: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA spi_sclk";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_spi_ssel_n: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA spi_ssel_n";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_spi_mosi: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA spi_mosi";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_spi_miso: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA spi_miso";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_trigger: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA trigger";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_monitor: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA monitor";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_clk_out_p: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA clk_out_p";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_clk_out_n: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA clk_out_n";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_sync_p: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA sync_p";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_sync_n: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA sync_n";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_data_p: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA data_p";
  ATTRIBUTE X_INTERFACE_INFO OF io_vita_data_n: SIGNAL IS "avnet.com:interface:avnet_vita:1.0 IO_VITA data_n";
  ATTRIBUTE X_INTERFACE_INFO OF fsync: SIGNAL IS "xilinx.com:signal:video_frame_sync:1.0 FRAME_SYNC FRAME_SYNC";
  ATTRIBUTE X_INTERFACE_INFO OF video_vsync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT VSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF video_hsync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT HSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF video_vblank: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT VBLANK";
  ATTRIBUTE X_INTERFACE_INFO OF video_hblank: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT HBLANK";
  ATTRIBUTE X_INTERFACE_INFO OF video_active_video: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT ACTIVE_VIDEO";
  ATTRIBUTE X_INTERFACE_INFO OF video_data: SIGNAL IS "xilinx.com:interface:vid_io:1.0 VID_IO_OUT DATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 S00_AXI_RST RST";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RREADY";
BEGIN
  U0 : vita_receiver_v2_0
    GENERIC MAP (
      C_VIDEO_DATA_WIDTH => 8,
      C_VIDEO_DIRECT_OUTPUT => 0,
      C_IO_VITA_DATA_WIDTH => 4,
      C_FAMILY => "zynq",
      C_S00_AXI_DATA_WIDTH => 32,
      C_S00_AXI_ADDR_WIDTH => 8
    )
    PORT MAP (
      clk200 => clk200,
      clk => clk,
      reset => reset,
      oe => oe,
      io_vita_clk_pll => io_vita_clk_pll,
      io_vita_reset_n => io_vita_reset_n,
      io_vita_spi_sclk => io_vita_spi_sclk,
      io_vita_spi_ssel_n => io_vita_spi_ssel_n,
      io_vita_spi_mosi => io_vita_spi_mosi,
      io_vita_spi_miso => io_vita_spi_miso,
      io_vita_trigger => io_vita_trigger,
      io_vita_monitor => io_vita_monitor,
      io_vita_clk_out_p => io_vita_clk_out_p,
      io_vita_clk_out_n => io_vita_clk_out_n,
      io_vita_sync_p => io_vita_sync_p,
      io_vita_sync_n => io_vita_sync_n,
      io_vita_data_p => io_vita_data_p,
      io_vita_data_n => io_vita_data_n,
      trigger1 => trigger1,
      fsync => fsync,
      video_vsync => video_vsync,
      video_hsync => video_hsync,
      video_vblank => video_vblank,
      video_hblank => video_hblank,
      video_active_video => video_active_video,
      video_data => video_data,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_awaddr => s00_axi_awaddr,
      s00_axi_awprot => s00_axi_awprot,
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_awready => s00_axi_awready,
      s00_axi_wdata => s00_axi_wdata,
      s00_axi_wstrb => s00_axi_wstrb,
      s00_axi_wvalid => s00_axi_wvalid,
      s00_axi_wready => s00_axi_wready,
      s00_axi_bresp => s00_axi_bresp,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_araddr => s00_axi_araddr,
      s00_axi_arprot => s00_axi_arprot,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_arready => s00_axi_arready,
      s00_axi_rdata => s00_axi_rdata,
      s00_axi_rresp => s00_axi_rresp,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_rready => s00_axi_rready
    );
END tutorial_fmc_imageon_vita_receiver_0_1_arch;
