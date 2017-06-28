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

-- IP VLNV: avnet:onsemi_vita:onsemi_vita_cam:3.2
-- IP Revision: 3

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT fmc_imageon_gs_onsemi_vita_cam_0_0
  PORT (
    clk200 : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    oe : IN STD_LOGIC;
    io_vita_clk_pll : OUT STD_LOGIC;
    io_vita_reset_n : OUT STD_LOGIC;
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
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : fmc_imageon_gs_onsemi_vita_cam_0_0
  PORT MAP (
    clk200 => clk200,
    clk => clk,
    reset => reset,
    oe => oe,
    io_vita_clk_pll => io_vita_clk_pll,
    io_vita_reset_n => io_vita_reset_n,
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
-- INST_TAG_END ------ End INSTANTIATION Template ---------

