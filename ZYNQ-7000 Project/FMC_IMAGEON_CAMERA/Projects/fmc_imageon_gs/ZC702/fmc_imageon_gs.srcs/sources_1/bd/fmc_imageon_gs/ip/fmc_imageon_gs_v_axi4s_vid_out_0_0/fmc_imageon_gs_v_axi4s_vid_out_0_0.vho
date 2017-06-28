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

-- IP VLNV: xilinx.com:ip:v_axi4s_vid_out:4.0
-- IP Revision: 1

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT fmc_imageon_gs_v_axi4s_vid_out_0_0
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_video_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_video_tvalid : IN STD_LOGIC;
    s_axis_video_tready : OUT STD_LOGIC;
    s_axis_video_tuser : IN STD_LOGIC;
    s_axis_video_tlast : IN STD_LOGIC;
    fid : IN STD_LOGIC;
    vid_io_out_clk : IN STD_LOGIC;
    vid_io_out_ce : IN STD_LOGIC;
    vid_io_out_reset : IN STD_LOGIC;
    vid_active_video : OUT STD_LOGIC;
    vid_vsync : OUT STD_LOGIC;
    vid_hsync : OUT STD_LOGIC;
    vid_vblank : OUT STD_LOGIC;
    vid_hblank : OUT STD_LOGIC;
    vid_field_id : OUT STD_LOGIC;
    vid_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    vtg_vsync : IN STD_LOGIC;
    vtg_hsync : IN STD_LOGIC;
    vtg_vblank : IN STD_LOGIC;
    vtg_hblank : IN STD_LOGIC;
    vtg_active_video : IN STD_LOGIC;
    vtg_field_id : IN STD_LOGIC;
    vtg_ce : OUT STD_LOGIC;
    locked : OUT STD_LOGIC;
    overflow : OUT STD_LOGIC;
    underflow : OUT STD_LOGIC;
    status : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : fmc_imageon_gs_v_axi4s_vid_out_0_0
  PORT MAP (
    aclk => aclk,
    aclken => aclken,
    aresetn => aresetn,
    s_axis_video_tdata => s_axis_video_tdata,
    s_axis_video_tvalid => s_axis_video_tvalid,
    s_axis_video_tready => s_axis_video_tready,
    s_axis_video_tuser => s_axis_video_tuser,
    s_axis_video_tlast => s_axis_video_tlast,
    fid => fid,
    vid_io_out_clk => vid_io_out_clk,
    vid_io_out_ce => vid_io_out_ce,
    vid_io_out_reset => vid_io_out_reset,
    vid_active_video => vid_active_video,
    vid_vsync => vid_vsync,
    vid_hsync => vid_hsync,
    vid_vblank => vid_vblank,
    vid_hblank => vid_hblank,
    vid_field_id => vid_field_id,
    vid_data => vid_data,
    vtg_vsync => vtg_vsync,
    vtg_hsync => vtg_hsync,
    vtg_vblank => vtg_vblank,
    vtg_hblank => vtg_hblank,
    vtg_active_video => vtg_active_video,
    vtg_field_id => vtg_field_id,
    vtg_ce => vtg_ce,
    locked => locked,
    overflow => overflow,
    underflow => underflow,
    status => status
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file fmc_imageon_gs_v_axi4s_vid_out_0_0.vhd when simulating
-- the core, fmc_imageon_gs_v_axi4s_vid_out_0_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

