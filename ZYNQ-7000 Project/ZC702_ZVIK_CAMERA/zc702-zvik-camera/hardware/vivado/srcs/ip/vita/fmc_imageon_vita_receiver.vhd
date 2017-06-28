------------------------------------------------------------------
--      _____
--     /     \
--    /____   \____
--   / \===\   \==/
--  /___\===\___\/  AVNET
--       \======/
--        \====/    
-----------------------------------------------------------------
--
-- This design is the property of Avnet.  Publication of this
-- design is not authorized without written consent from Avnet.
-- 
-- Please direct any questions to:  technical.support@avnet.com
--
-- Disclaimer:
--    Avnet, Inc. makes no warranty for the use of this code or design.
--    This code is provided  "As Is". Avnet, Inc assumes no responsibility for
--    any errors, which may appear in this code, nor does it make a commitment
--    to update the information contained herein. Avnet, Inc specifically
--    disclaims any implied warranties of fitness for a particular purpose.
--                     Copyright(c) 2011 Avnet, Inc.
--                             All rights reserved.
--
------------------------------------------------------------------
--
-- Create Date:         Sep 15, 2011
-- Design Name:         FMC-IMAGEON
-- Module Name:         fmc_imageon_vita_receiver.vhd
-- Project Name:        FMC-IMAGEON
-- Target Devices:      Virtex-6
--                      Kintex-7, Zynq
-- Avnet Boards:        FMC-IMAGEON
--
-- Tool versions:       ISE 14.1
--
-- Description:         FMC-IMAGEON VITA receiver interface.
--
-- Dependencies:        
--
-- Revision:            Sep 15, 2011: 1.00 Initial version:
--                                         - VITA SPI controller 
--                      Sep 22, 2011: 1.01 Added:
--                                         - ISERDES interface
--                      Sep 28, 2011: 1.02 Added:
--                                         - sync channel decoder
--                                         - crc checker
--                                         - data remapper
--                      Oct 20, 2011: 1.03 Modify:
--                                         - iserdes (use BUFR)
--                      Oct 21, 2011: 1.04 Added:
--                                         - fpn prnu correction
--                      Nov 03, 2011: 1.05 Added:
--                                         - trigger generator
--                      Dec 19, 2011: 1.06 Modified:
--                                         - port to Kintex-7
--                      Jan 12, 2012: 1.07 Added:
--                                         - new fsync output port
--                                         Modify:
--                                         - syncgen
--                      Feb 06, 2012: 1.08 Modify:
--                                         - triggergenerator
--                                           (new version with debounce logic)
--                                         - new C_XSVI_DIRECT_OUTPUT option
--                      Feb 22, 2012: 1.09 Modified
--                                         - port to Zynq
--                                         - new C_XSVI_USE_SYNCGEN option
--                      May 13, 2012: 1.10 Optimize
--                                         - remove one layer of registers
--                      May 28, 2012: 1.11 Modify
--                                         - host_triggen_cnt_update
--                                           (for simultaneous update of high/low values)
--                      Jun 01, 2012: 1.12 Modify:
--                                         - Move syncgen after demux_fifo
--                                         - Increase size of demux_fifo
--                                           (to tolerate jitter in video timing from sensor)
--                                         - Add programmable delay on framestart for syncgen
--                      Jul 31, 2012: 1.13 Modify:
--                                         - define clk200, clk, clk4x with SIGIS = CLK
--                                         - define reset with SIGIS = RST
--                                         - port to Spartan-6
--
------------------------------------------------------------------


------------------------------------------------------------------------------
-- fmc_imageon_vita_receiver.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          fmc_imageon_vita_receiver.vhd
-- Version:           1.00.a
-- Description:       Top level design, instantiates library components and user logic.
-- Date:              Thu Sep 15 13:07:23 2011 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v4_0;
use proc_common_v4_0.proc_common_pkg.all;
use proc_common_v4_0.ipif_pkg.all;

library axi_lite_ipif_v2_0;
use axi_lite_ipif_v2_0.axi_lite_ipif;

library fmc_imageon_vita_receiver_v1_13_a;
use fmc_imageon_vita_receiver_v1_13_a.user_logic;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_S_AXI_DATA_WIDTH           -- 
--   C_S_AXI_ADDR_WIDTH           -- 
--   C_S_AXI_MIN_SIZE             -- 
--   C_USE_WSTRB                  -- 
--   C_DPHASE_TIMEOUT             -- 
--   C_BASEADDR                   -- AXI4LITE slave: base address
--   C_HIGHADDR                   -- AXI4LITE slave: high address
--   C_FAMILY                     -- 
--   C_NUM_REG                    -- Number of software accessible registers
--   C_NUM_MEM                    -- Number of address-ranges
--   C_SLV_AWIDTH                 -- Slave interface address bus width
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--
-- Definition of Ports:
--   S_AXI_ACLK                   -- 
--   S_AXI_ARESETN                -- 
--   S_AXI_AWADDR                 -- 
--   S_AXI_AWVALID                -- 
--   S_AXI_WDATA                  -- 
--   S_AXI_WSTRB                  -- 
--   S_AXI_WVALID                 -- 
--   S_AXI_BREADY                 -- 
--   S_AXI_ARADDR                 -- 
--   S_AXI_ARVALID                -- 
--   S_AXI_RREADY                 -- 
--   S_AXI_ARREADY                -- 
--   S_AXI_RDATA                  -- 
--   S_AXI_RRESP                  -- 
--   S_AXI_RVALID                 -- 
--   S_AXI_WREADY                 -- 
--   S_AXI_BRESP                  -- 
--   S_AXI_BVALID                 -- 
--   S_AXI_AWREADY                -- 
------------------------------------------------------------------------------

entity fmc_imageon_vita_receiver is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    C_XSVI_DATA_WIDTH              : integer              := 10;
    C_XSVI_DIRECT_OUTPUT           : integer              := 0;
    C_XSVI_USE_SYNCGEN             : integer              := 1;
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_S_AXI_DATA_WIDTH             : integer              := 32;
    C_S_AXI_ADDR_WIDTH             : integer              := 32;
    C_S_AXI_MIN_SIZE               : std_logic_vector     := X"000001FF";
    C_USE_WSTRB                    : integer              := 0;
    C_DPHASE_TIMEOUT               : integer              := 8;
    C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
    C_HIGHADDR                     : std_logic_vector     := X"00000000";
    C_FAMILY                       : string               := "virtex6";
    C_NUM_REG                      : integer              := 1;
    C_NUM_MEM                      : integer              := 1;
    C_SLV_AWIDTH                   : integer              := 32;
    C_SLV_DWIDTH                   : integer              := 32
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    --USER ports added here
    clk200                         : in  std_logic;
    clk                            : in  std_logic;
    clk4x                          : in  std_logic;
    reset                          : in  std_logic;
    oe                             : in  std_logic;
    -- I/O pins
    io_vita_clk_pll                : out std_logic;
    io_vita_reset_n                : out std_logic;
    io_vita_spi_sclk               : out std_logic;
    io_vita_spi_ssel_n             : out std_logic;
    io_vita_spi_mosi               : out std_logic;
    io_vita_spi_miso               : in  std_logic;
    io_vita_trigger                : out std_logic_vector(2 downto 0);
    io_vita_monitor                : in  std_logic_vector(1 downto 0);
    io_vita_clk_out_p              : in  std_logic;
    io_vita_clk_out_n              : in  std_logic;
    io_vita_sync_p                 : in  std_logic;
    io_vita_sync_n                 : in  std_logic;
    io_vita_data_p                 : in  std_logic_vector(7 downto 0);
    io_vita_data_n                 : in  std_logic_vector(7 downto 0);
    -- Trigger Port
    trigger1                       : in  std_logic;
    -- Frame Sync Port
    fsync                          : out std_logic;
    -- XSVI Port
    xsvi_vsync_o                   : out  std_logic;
    xsvi_hsync_o                   : out  std_logic;
    xsvi_vblank_o                  : out  std_logic;
    xsvi_hblank_o                  : out  std_logic;
    xsvi_active_video_o            : out  std_logic;
    xsvi_video_data_o              : out  std_logic_vector((C_XSVI_DATA_WIDTH-1) downto 0);
    -- Debug Ports
    debug_host_o                   : out std_logic_vector(231 downto 0);
    debug_spi_o                    : out std_logic_vector( 95 downto 0);
    debug_iserdes_o                : out std_logic_vector(229 downto 0);
    debug_decoder_o                : out std_logic_vector(186 downto 0);
    debug_crc_o                    : out std_logic_vector( 87 downto 0);
    debug_triggen_o                : out std_logic_vector(  9 downto 0);
    debug_video_o                  : out std_logic_vector( 31 downto 0);
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    S_AXI_ACLK                     : in  std_logic;
    S_AXI_ARESETN                  : in  std_logic;
    S_AXI_AWADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWVALID                  : in  std_logic;
    S_AXI_WDATA                    : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB                    : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_WVALID                   : in  std_logic;
    S_AXI_BREADY                   : in  std_logic;
    S_AXI_ARADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID                  : in  std_logic;
    S_AXI_RREADY                   : in  std_logic;
    S_AXI_ARREADY                  : out std_logic;
    S_AXI_RDATA                    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP                    : out std_logic_vector(1 downto 0);
    S_AXI_RVALID                   : out std_logic;
    S_AXI_WREADY                   : out std_logic;
    S_AXI_BRESP                    : out std_logic_vector(1 downto 0);
    S_AXI_BVALID                   : out std_logic;
    S_AXI_AWREADY                  : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute MAX_FANOUT : string;
  attribute SIGIS : string;
  attribute MAX_FANOUT of S_AXI_ACLK       : signal is "10000";
  attribute MAX_FANOUT of S_AXI_ARESETN       : signal is "10000";
  attribute SIGIS of S_AXI_ACLK       : signal is "Clk";
  attribute SIGIS of S_AXI_ARESETN       : signal is "Rst";
end entity fmc_imageon_vita_receiver;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of fmc_imageon_vita_receiver is

  constant USER_SLV_DWIDTH                : integer              := C_S_AXI_DATA_WIDTH;

  constant IPIF_SLV_DWIDTH                : integer              := C_S_AXI_DATA_WIDTH;

  constant ZERO_ADDR_PAD                  : std_logic_vector(0 to 31) := (others => '0');
  constant USER_SLV_BASEADDR              : std_logic_vector     := C_BASEADDR;
  constant USER_SLV_HIGHADDR              : std_logic_vector     := C_HIGHADDR;

  constant IPIF_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE     := 
    (
      ZERO_ADDR_PAD & USER_SLV_BASEADDR,  -- user logic slave space base address
      ZERO_ADDR_PAD & USER_SLV_HIGHADDR   -- user logic slave space high address
    );

  constant USER_SLV_NUM_REG               : integer              := 64;
  constant USER_NUM_REG                   : integer              := USER_SLV_NUM_REG;
  constant TOTAL_IPIF_CE                  : integer              := USER_NUM_REG;

  constant IPIF_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE   := 
    (
      0  => (USER_SLV_NUM_REG)            -- number of ce for user logic slave space
    );

  ------------------------------------------
  -- Index for CS/CE
  ------------------------------------------
  constant USER_SLV_CS_INDEX              : integer              := 0;
  constant USER_SLV_CE_INDEX              : integer              := calc_start_ce_index(IPIF_ARD_NUM_CE_ARRAY, USER_SLV_CS_INDEX);

  constant USER_CE_INDEX                  : integer              := USER_SLV_CE_INDEX;

  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations
  ------------------------------------------
  signal ipif_Bus2IP_Clk                : std_logic;
  signal ipif_Bus2IP_Resetn             : std_logic;
  signal ipif_Bus2IP_Addr               : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
  signal ipif_Bus2IP_RNW                : std_logic;
  signal ipif_Bus2IP_BE                 : std_logic_vector(IPIF_SLV_DWIDTH/8-1 downto 0);
  signal ipif_Bus2IP_CS                 : std_logic_vector((IPIF_ARD_ADDR_RANGE_ARRAY'LENGTH)/2-1 downto 0);
  signal ipif_Bus2IP_RdCE               : std_logic_vector(calc_num_ce(IPIF_ARD_NUM_CE_ARRAY)-1 downto 0);
  signal ipif_Bus2IP_WrCE               : std_logic_vector(calc_num_ce(IPIF_ARD_NUM_CE_ARRAY)-1 downto 0);
  signal ipif_Bus2IP_Data               : std_logic_vector(IPIF_SLV_DWIDTH-1 downto 0);
  signal ipif_IP2Bus_WrAck              : std_logic;
  signal ipif_IP2Bus_RdAck              : std_logic;
  signal ipif_IP2Bus_Error              : std_logic;
  signal ipif_IP2Bus_Data               : std_logic_vector(IPIF_SLV_DWIDTH-1 downto 0);
  signal user_Bus2IP_RdCE               : std_logic_vector(USER_NUM_REG-1 downto 0);
  signal user_Bus2IP_WrCE               : std_logic_vector(USER_NUM_REG-1 downto 0);
  signal user_IP2Bus_Data               : std_logic_vector(USER_SLV_DWIDTH-1 downto 0);
  signal user_IP2Bus_RdAck              : std_logic;
  signal user_IP2Bus_WrAck              : std_logic;
  signal user_IP2Bus_Error              : std_logic;

begin

  ------------------------------------------
  -- instantiate axi_lite_ipif
  ------------------------------------------
  AXI_LITE_IPIF_I : entity axi_lite_ipif_v2_0.axi_lite_ipif
    generic map
    (
      C_S_AXI_DATA_WIDTH             => IPIF_SLV_DWIDTH,
      C_S_AXI_ADDR_WIDTH             => C_S_AXI_ADDR_WIDTH,
      C_S_AXI_MIN_SIZE               => C_S_AXI_MIN_SIZE,
      C_USE_WSTRB                    => C_USE_WSTRB,
      C_DPHASE_TIMEOUT               => C_DPHASE_TIMEOUT,
      C_ARD_ADDR_RANGE_ARRAY         => IPIF_ARD_ADDR_RANGE_ARRAY,
      C_ARD_NUM_CE_ARRAY             => IPIF_ARD_NUM_CE_ARRAY,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      S_AXI_ACLK                     => S_AXI_ACLK,
      S_AXI_ARESETN                  => S_AXI_ARESETN,
      S_AXI_AWADDR                   => S_AXI_AWADDR,
      S_AXI_AWVALID                  => S_AXI_AWVALID,
      S_AXI_WDATA                    => S_AXI_WDATA,
      S_AXI_WSTRB                    => S_AXI_WSTRB,
      S_AXI_WVALID                   => S_AXI_WVALID,
      S_AXI_BREADY                   => S_AXI_BREADY,
      S_AXI_ARADDR                   => S_AXI_ARADDR,
      S_AXI_ARVALID                  => S_AXI_ARVALID,
      S_AXI_RREADY                   => S_AXI_RREADY,
      S_AXI_ARREADY                  => S_AXI_ARREADY,
      S_AXI_RDATA                    => S_AXI_RDATA,
      S_AXI_RRESP                    => S_AXI_RRESP,
      S_AXI_RVALID                   => S_AXI_RVALID,
      S_AXI_WREADY                   => S_AXI_WREADY,
      S_AXI_BRESP                    => S_AXI_BRESP,
      S_AXI_BVALID                   => S_AXI_BVALID,
      S_AXI_AWREADY                  => S_AXI_AWREADY,
      Bus2IP_Clk                     => ipif_Bus2IP_Clk,
      Bus2IP_Resetn                  => ipif_Bus2IP_Resetn,
      Bus2IP_Addr                    => ipif_Bus2IP_Addr,
      Bus2IP_RNW                     => ipif_Bus2IP_RNW,
      Bus2IP_BE                      => ipif_Bus2IP_BE,
      Bus2IP_CS                      => ipif_Bus2IP_CS,
      Bus2IP_RdCE                    => ipif_Bus2IP_RdCE,
      Bus2IP_WrCE                    => ipif_Bus2IP_WrCE,
      Bus2IP_Data                    => ipif_Bus2IP_Data,
      IP2Bus_WrAck                   => ipif_IP2Bus_WrAck,
      IP2Bus_RdAck                   => ipif_IP2Bus_RdAck,
      IP2Bus_Error                   => ipif_IP2Bus_Error,
      IP2Bus_Data                    => ipif_IP2Bus_Data
    );

  ------------------------------------------
  -- instantiate User Logic
  ------------------------------------------
  USER_LOGIC_I : entity fmc_imageon_vita_receiver_v1_13_a.user_logic
    generic map
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      --USER generics mapped here
      C_XSVI_DATA_WIDTH              => C_XSVI_DATA_WIDTH,
      C_XSVI_DIRECT_OUTPUT           => C_XSVI_DIRECT_OUTPUT,
      C_XSVI_USE_SYNCGEN             => C_XSVI_USE_SYNCGEN,
      C_FAMILY                       => C_FAMILY,
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_NUM_REG                      => USER_NUM_REG,
      C_SLV_DWIDTH                   => USER_SLV_DWIDTH
    )
    port map
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------
      --USER ports mapped here
      clk200                         => clk200,
      clk                            => clk,
      clk4x                          => clk4x,
      reset                          => reset,
      oe                             => oe,
      -- I/O pins
      io_vita_clk_pll                => io_vita_clk_pll,
      io_vita_reset_n                => io_vita_reset_n,
      io_vita_spi_sclk               => io_vita_spi_sclk,
      io_vita_spi_ssel_n             => io_vita_spi_ssel_n,
      io_vita_spi_mosi               => io_vita_spi_mosi,
      io_vita_spi_miso               => io_vita_spi_miso,
      io_vita_trigger                => io_vita_trigger,
      io_vita_monitor                => io_vita_monitor,
      io_vita_clk_out_p              => io_vita_clk_out_p,
      io_vita_clk_out_n              => io_vita_clk_out_n,
      io_vita_sync_p                 => io_vita_sync_p,
      io_vita_sync_n                 => io_vita_sync_n,
      io_vita_data_p                 => io_vita_data_p,
      io_vita_data_n                 => io_vita_data_n,
      -- Trigger Port
      trigger1                       => trigger1,
      -- Frame Sync Port
      fsync                          => fsync,
      -- XSVI Port
      xsvi_vsync_o                   => xsvi_vsync_o,
      xsvi_hsync_o                   => xsvi_hsync_o,
      xsvi_vblank_o                  => xsvi_vblank_o,
      xsvi_hblank_o                  => xsvi_hblank_o,
      xsvi_active_video_o            => xsvi_active_video_o,
      xsvi_video_data_o              => xsvi_video_data_o,
      -- Debug Ports
      debug_host_o                   => debug_host_o,
      debug_spi_o                    => debug_spi_o,
      debug_iserdes_o                => debug_iserdes_o,
      debug_decoder_o                => debug_decoder_o,
      debug_crc_o                    => debug_crc_o,
      debug_triggen_o                => debug_triggen_o,
      debug_video_o                  => debug_video_o,
      -- MAP USER PORTS ABOVE THIS LINE ------------------

      Bus2IP_Clk                     => ipif_Bus2IP_Clk,
      Bus2IP_Resetn                  => ipif_Bus2IP_Resetn,
      Bus2IP_Addr                    => ipif_Bus2IP_Addr,
      Bus2IP_CS                      => ipif_Bus2IP_CS,
      Bus2IP_RNW                     => ipif_Bus2IP_RNW,
      Bus2IP_Data                    => ipif_Bus2IP_Data,
      Bus2IP_BE                      => ipif_Bus2IP_BE,
      Bus2IP_RdCE                    => user_Bus2IP_RdCE,
      Bus2IP_WrCE                    => user_Bus2IP_WrCE,
      IP2Bus_Data                    => user_IP2Bus_Data,
      IP2Bus_RdAck                   => user_IP2Bus_RdAck,
      IP2Bus_WrAck                   => user_IP2Bus_WrAck,
      IP2Bus_Error                   => user_IP2Bus_Error
    );

  ------------------------------------------
  -- connect internal signals
  ------------------------------------------
  ipif_IP2Bus_Data <= user_IP2Bus_Data;
  ipif_IP2Bus_WrAck <= user_IP2Bus_WrAck;
  ipif_IP2Bus_RdAck <= user_IP2Bus_RdAck;
  ipif_IP2Bus_Error <= user_IP2Bus_Error;

  user_Bus2IP_RdCE <= ipif_Bus2IP_RdCE(USER_NUM_REG-1 downto 0);
  user_Bus2IP_WrCE <= ipif_Bus2IP_WrCE(USER_NUM_REG-1 downto 0);

end IMP;
