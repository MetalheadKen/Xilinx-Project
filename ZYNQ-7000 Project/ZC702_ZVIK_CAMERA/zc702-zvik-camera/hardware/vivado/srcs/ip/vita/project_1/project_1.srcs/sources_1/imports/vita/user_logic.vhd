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
-- Module Name:         user_logic.vhd
-- Project Name:        FMC-IMAGEON
-- Target Devices:      Virtex-6
--                      Kintex-7, Zynq
-- Avnet Boards:        FMC-IMAGEON
--
-- Tool versions:       ISE 14.1
--
-- Description:         FMC-IMAGEON VITA receiver - User Logic.
--                      This layer implements the following programming model
--                         0x00 - SPI_CONTROL
--                                   [ 0] VITA_RESET
--                                   [ 1] SPI_RESET
--                                   [ 8] SPI_STATUS_BUSY
--                                   [ 9] SPI_STATUS_ERROR
--                                   [16] SPI_TXFIFO_FULL
--                                   [24] SPI_RXFIFO_EMPTY
--                         0x04 - SPI_TIMING[15:0]
--                         0x08 - SPI_TXFIFO_DATA[31:0]
--                         0x0C - SPI_RXFIFO_DATA[31:0]
--                         0x10 - ISERDES_CONTROL
--                                   [ 0] ISERDES_RESET
--                                   [ 1] ISERDES_AUTO_ALIGN
--                                   [ 2] ISERDES_ALIGN_START
--                                   [ 3] ISERDES_FIFO_ENABLE
--                                   [ 8] ISERDES_CLK_READY
--                                   [ 9] ISERDES_ALIGN_BUSY
--                                   [10] ISERDES_ALIGNED
--                                [23:16] ISERDES_TXCLK_STATUS
--                                [31:24] ISERDES_RXCLK_STATUS
--                         0x14 - ISERDES_TRAINING
--                         0x18 - ISERDES_MANUAL_TAP
--                         0x1C - {unused}
--                         0x20 - DECODER_CONTROL
--                                   [0] DECODER_RESET
--                                   [1] DECODER_ENABLE
--                         0x24 - DECODER_STARTODDEVEN
--                         0x28 - DECODER_CODES_LS_LE
--                                   [15: 0] CODE_LS
--                                   [31:16] CODE_LE
--                         0x2C - DECODER_CODES_FS_FE
--                                   [15: 0] CODE_FS
--                                   [31:16] CODE_FE
--                         0x30 - DECODER_CODES_BL_IMG
--                                   [15: 0] CODE_BL
--                                   [31:16] CODE_IMG
--                         0x34 - DECODER_CODES_TR_CRC
--                                   [15: 0] CODE_TR
--                                   [31:16] CODE_CRC
--                         0x38 - DECODER_CNT_BLACK_LINES
--                         0x3C - DECODER_CNT_IMAGE_LINES
--                         0x40 - DECODER_CNT_BLACK_PIXELS
--                         0x44 - DECODER_CNT_IMAGE_PIXELS
--                         0x48 - DECODER_CNT_FRAMES
--                         0x4C - DECODER_CNT_WINDOWS
--                         0x50 - DECODER_CNT_CLOCKS
--                         0x54 - DECODER_CNT_START_LINES
--                         0x58 - DECODER_CNT_END_LINES
--                         0x5C - SYNCGEN_DELAY
--                                   [15: 0] DELAY
--                         0x60 - SYNCGEN_HTIMING1
--                                   [15: 0] HACTIVE
--                                   [31:16] HFPORCH
--                         0x64 - SYNCGEN_HTIMING2
--                                   [15: 0] HSYNC
--                                   [31:16] HBPORCH
--                         0x68 - SYNCGEN_VTIMING1
--                                   [15: 0] VACTIVE
--                                   [31:16] VFPORCH
--                         0x6C - SYNCGEN_VTIMING2
--                                   [15: 0] VSYNC
--                                   [31:16] VBPORCH
--                         0x70 - CRC_CONTROL
--                                   [0] CRC_RESET
--                                   [1] CRC_INITVALUE
--                         0x74 - CRC_STATUS
--                         0x78 - REMAPPER_CONTROL[7:0]
--                                   [2:0] REMAPPER_WRITE_CFG
--                                   [6:4] REMAPPER_MODE
--                         0x7C - {unused}
--                         0x80 - FPN_PRNU_VALUES[ 31:  0]
--                                  [ 7: 0] PRNU_0
--                                  [15: 8] FPN_0
--                                  [23:16] PRNU_1
--                                  [31:24] FPN_1
--                         0x84 - FPN_PRNU_VALUES[ 63: 32]
--                                  [ 7: 0] PRNU_2
--                                  [15: 8] FPN_2
--                                  [23:16] PRNU_3
--                                  [31:24] FPN_3
--                         0x88 - FPN_PRNU_VALUES[ 95: 64]
--                         0x8C - FPN_PRNU_VALUES[127: 96]
--                         0x90 - FPN_PRNU_VALUES[159:128]
--                         0x94 - FPN_PRNU_VALUES[191:160]
--                         0x98 - FPN_PRNU_VALUES[223:192]
--                         0x9C - FPN_PRNU_VALUES[255:224]
--                                  [ 7: 0] PRNU_14
--                                  [15: 8] FPN_14
--                                  [23:16] PRNU_15
--                                  [31:24] FPN_15
--                         0xA0 - {unused}
--                         0xA4 - {unused}
--                         0xA8 - {unused}
--                         0xAC - {unused}
--                         0xB0 - {unused}
--                         0xB4 - {unused}
--                         0xB8 - {unused}
--                         0xBC - {unused}
--                         0xC0 - DECODER_CNT_MONITOR0_HIGH
--                         0xC4 - DECODER_CNT_MONITOR0_LOW
--                         0xC8 - DECODER_CNT_MONITOR1_HIGH
--                         0xCC - DECODER_CNT_MONITOR1_LOW
--                         0xD0 - {unused}
--                         0xD4 - {unused}
--                         0xD8 - {unused}
--                         0xDC - TRIGGEN_EXT_DEBOUNCE
--                         0xE0 - TRIGGEN_CONTROL
--                                [ 2: 0] TRIGGEN_ENABLE
--                                [ 6: 4] TRIGGEN_SYNC2READOUT
--                                [    8] TRIGGEN_READOUTTRIGGER
--                                [   16] TRIGGEN_EXT_POLARITY
--                                [   24] TRIGGEN_CNT_UPDATE
--                                [30:28] TRIGGEN_GEN_POLARITY
--                         0xE4 - TRIGGEN_DEFAULT_FREQ
--                         0xE8 - TRIGGEN_TRIG0_HIGH
--                         0xEC - TRIGGEN_TRIG0_LOW
--                         0xF0 - TRIGGEN_TRIG1_HIGH
--                         0xF4 - TRIGGEN_TRIG1_LOW
--                         0xF8 - TRIGGEN_TRIG2_HIGH
--                         0xFC - TRIGGEN_TRIG2_LOW
--
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
--                      May 28, 2012: 1.11 Added
--                                         - host_triggen_cnt_update
--                                           (for simultaneous update of high/low values)
--                                         - host_triggen_gen_polarity
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
-- user_logic.vhd - entity/architecture pair
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
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
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

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v4_0;
use proc_common_v4_0.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here
library fmc_imageon_vita_receiver_v1_13_a;
use fmc_imageon_vita_receiver_v1_13_a.fmc_imageon_vita_core;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_NUM_REG                    -- Number of software accessible registers
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Resetn                -- Bus to IP reset
--   Bus2IP_Addr                  -- Bus to IP address bus
--   Bus2IP_CS                    -- Bus to IP chip select
--   Bus2IP_RNW                   -- Bus to IP read/not write
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    C_XSVI_DATA_WIDTH              : integer              := 10;
    C_XSVI_DIRECT_OUTPUT           : integer              := 0;
    C_XSVI_USE_SYNCGEN             : integer              := 1;
    C_FAMILY                       : string               := "virtex6";
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_NUM_REG                      : integer              := 64;
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
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Resetn                  : in  std_logic;
    Bus2IP_Addr                    : in  std_logic_vector(0 to 31);
    Bus2IP_CS                      : in  std_logic_vector(0 to 0);
    Bus2IP_RNW                     : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    Bus2IP_BE                      : in  std_logic_vector(C_SLV_DWIDTH/8-1 downto 0);
    Bus2IP_RdCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    Bus2IP_WrCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    IP2Bus_Data                    : out std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute MAX_FANOUT : string;
  attribute SIGIS : string;

  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Resetn : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic

  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg0                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg1                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg2                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg3                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg4                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg5                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg6                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg7                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg8                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg9                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg10                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg11                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg12                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg13                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg14                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg15                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg16                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg17                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg18                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg19                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg20                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg21                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg22                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg23                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg24                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg25                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg26                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg27                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg28                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg29                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg30                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg31                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  --
  signal slv_reg32                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg33                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg34                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg35                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg36                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg37                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg38                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg39                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  --
  signal slv_reg55                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg56                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg57                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg58                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg59                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg60                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg61                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg62                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg63                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  --
  signal slv_reg_write_sel              : std_logic_vector(63 downto 0);
  signal slv_reg_read_sel               : std_logic_vector(63 downto 0);
  signal slv_ip2bus_data                : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_read_ack                   : std_logic;
  signal slv_write_ack                  : std_logic;
  
  signal slv_reg4_w1                    : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg4_r1                    : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg5_w1                    : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg6_w1                    : std_logic_vector(C_SLV_DWIDTH-1 downto 0);

  signal slv_reg8_w1                    : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg9_w1                    : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg10_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg11_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg12_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg13_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg14_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg15_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg16_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg17_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg18_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg19_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg20_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg21_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg22_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg23_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg24_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg25_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg26_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg27_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg28_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg29_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg30_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  --
  signal slv_reg32_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg33_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg34_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg35_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg36_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg37_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg38_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg39_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  --
  signal slv_reg48_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg49_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg50_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg51_r1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  --  
  signal slv_reg55_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg56_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg57_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg58_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg59_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg60_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg61_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg62_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg63_w1                   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);

  -- HOST Interface - VITA
  signal host_vita_reset                : std_logic;

  -- HOST Interface - SPI
  signal host_spi_clk                   : std_logic;
  signal host_spi_reset                 : std_logic;
  signal host_spi_timing                : std_logic_vector(15 downto 0);
  signal host_spi_status_busy           : std_logic;
  signal host_spi_status_error          : std_logic;
  signal host_spi_txfifo_clk            : std_logic;                          	
  signal host_spi_txfifo_wen_a1         : std_logic;                              
  signal host_spi_txfifo_wen            : std_logic;                              
  signal host_spi_txfifo_din            : std_logic_vector(31 downto 0);         
  signal host_spi_txfifo_full           : std_logic; 
  signal host_spi_rxfifo_clk            : std_logic;                          	
  signal host_spi_rxfifo_ren            : std_logic;                              
  signal host_spi_rxfifo_dout           : std_logic_vector(31 downto 0);         
  signal host_spi_rxfifo_empty          : std_logic; 

  -- HOST Interface - ISERDES
  signal host_iserdes_reset             : std_logic;
  signal host_iserdes_auto_align        : std_logic;
  signal host_iserdes_align_start       : std_logic;
  signal host_iserdes_fifo_enable       : std_logic;
  signal host_iserdes_manual_tap        : std_logic_vector(9 downto 0);
  signal host_iserdes_training          : std_logic_vector(9 downto 0);
  --
  signal host_iserdes_clk_ready         : std_logic;
  signal host_iserdes_clk_status        : std_logic_vector(15 downto 0);
  signal host_iserdes_align_busy        : std_logic;
  signal host_iserdes_aligned           : std_logic;

  -- HOST Interface - Sync Channel Decoder
  signal host_decoder_reset             : std_logic;
  signal host_decoder_enable            : std_logic;
  signal host_decoder_startoddeven      : std_logic_vector(31 downto 0);
  signal host_decoder_code_ls           : std_logic_vector(9 downto 0);
  signal host_decoder_code_le           : std_logic_vector(9 downto 0);
  signal host_decoder_code_fs           : std_logic_vector(9 downto 0);
  signal host_decoder_code_fe           : std_logic_vector(9 downto 0);
  signal host_decoder_code_bl           : std_logic_vector(9 downto 0);
  signal host_decoder_code_img          : std_logic_vector(9 downto 0);
  signal host_decoder_code_tr           : std_logic_vector(9 downto 0);
  signal host_decoder_code_crc          : std_logic_vector(9 downto 0);
  signal host_decoder_frame_start       : std_logic;
  signal host_decoder_cnt_black_lines   : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_image_lines   : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_black_pixels  : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_image_pixels  : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_frames        : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_windows       : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_clocks        : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_start_lines   : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_end_lines     : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_monitor0high  : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_monitor0low   : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_monitor1high  : std_logic_vector(31 downto 0);
  signal host_decoder_cnt_monitor1low   : std_logic_vector(31 downto 0);

  -- HOST Interface - CRC Checker
  signal host_crc_reset                 : std_logic;
  signal host_crc_initvalue             : std_logic;
  signal host_crc_status                : std_logic_vector(31 downto 0);

  -- HOST Interface - Data Channel Remapper
  signal host_remapper_write_cfg        : std_logic_vector(2 downto 0);
  signal host_remapper_mode             : std_logic_vector(2 downto 0);

  -- HOST Interface - Trigger Generator
  signal host_triggen_enable            : std_logic_vector(2 downto 0);
  signal host_triggen_sync2readout      : std_logic_vector(2 downto 0);
  signal host_triggen_readouttrigger    : std_logic;
  signal host_triggen_default_freq      : std_logic_vector(31 downto 0);
  signal host_triggen_cnt_trigger0high  : std_logic_vector(31 downto 0);
  signal host_triggen_cnt_trigger0low   : std_logic_vector(31 downto 0);
  signal host_triggen_cnt_trigger1high  : std_logic_vector(31 downto 0);
  signal host_triggen_cnt_trigger1low   : std_logic_vector(31 downto 0);
  signal host_triggen_cnt_trigger2high  : std_logic_vector(31 downto 0);
  signal host_triggen_cnt_trigger2low   : std_logic_vector(31 downto 0);
  signal host_triggen_ext_debounce      : std_logic_vector(31 downto 0);
  signal host_triggen_ext_polarity      : std_logic;
  signal host_triggen_cnt_update        : std_logic;  
  signal host_triggen_gen_polarity      : std_logic_vector(2 downto 0);

  -- HOST Interface - FPN/PRNU Correction
  signal host_fpn_prnu_values           : std_logic_vector((16*16)-1 downto 0);
  
  -- HOST Interface - Sync Generator
  signal host_syncgen_delay             : std_logic_vector(15 downto 0);
  signal host_syncgen_hactive           : std_logic_vector(15 downto 0);
  signal host_syncgen_hfporch           : std_logic_vector(15 downto 0);
  signal host_syncgen_hsync             : std_logic_vector(15 downto 0);
  signal host_syncgen_hbporch           : std_logic_vector(15 downto 0);
  signal host_syncgen_vactive           : std_logic_vector(15 downto 0);
  signal host_syncgen_vfporch           : std_logic_vector(15 downto 0);
  signal host_syncgen_vsync             : std_logic_vector(15 downto 0);
  signal host_syncgen_vbporch           : std_logic_vector(15 downto 0);

begin

  --USER logic implementation added here

  ------------------------------------------
  -- Example code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(63 downto 0);
  slv_reg_read_sel  <= Bus2IP_RdCE(63 downto 0);
  slv_write_ack     <= Bus2IP_WrCE( 0) or Bus2IP_WrCE( 1) or Bus2IP_WrCE( 2) or Bus2IP_WrCE( 3) or Bus2IP_WrCE( 4) or Bus2IP_WrCE( 5) or Bus2IP_WrCE( 6) or Bus2IP_WrCE( 7) 
                    or Bus2IP_WrCE( 8) or Bus2IP_WrCE( 9) or Bus2IP_WrCE(10) or Bus2IP_WrCE(11) or Bus2IP_WrCE(12) or Bus2IP_WrCE(13) or Bus2IP_WrCE(14) or Bus2IP_WrCE(15)
                    or Bus2IP_WrCE(16) or Bus2IP_WrCE(17) or Bus2IP_WrCE(18) or Bus2IP_WrCE(19) or Bus2IP_WrCE(20) or Bus2IP_WrCE(21) or Bus2IP_WrCE(22) or Bus2IP_WrCE(23)
                    or Bus2IP_WrCE(24) or Bus2IP_WrCE(25) or Bus2IP_WrCE(26) or Bus2IP_WrCE(27) or Bus2IP_WrCE(28) or Bus2IP_WrCE(29) or Bus2IP_WrCE(30) or Bus2IP_WrCE(31) 
                    or Bus2IP_WrCE(32) or Bus2IP_WrCE(33) or Bus2IP_WrCE(34) or Bus2IP_WrCE(35) or Bus2IP_WrCE(36) or Bus2IP_WrCE(37) or Bus2IP_WrCE(38) or Bus2IP_WrCE(39)
                    or Bus2IP_WrCE(40) or Bus2IP_WrCE(41) or Bus2IP_WrCE(42) or Bus2IP_WrCE(43) or Bus2IP_WrCE(44) or Bus2IP_WrCE(45) or Bus2IP_WrCE(46) or Bus2IP_WrCE(47)
                    or Bus2IP_WrCE(48) or Bus2IP_WrCE(49) or Bus2IP_WrCE(50) or Bus2IP_WrCE(51) or Bus2IP_WrCE(52) or Bus2IP_WrCE(53) or Bus2IP_WrCE(54) or Bus2IP_WrCE(55)
                    or Bus2IP_WrCE(56) or Bus2IP_WrCE(57) or Bus2IP_WrCE(58) or Bus2IP_WrCE(59) or Bus2IP_WrCE(60) or Bus2IP_WrCE(61) or Bus2IP_WrCE(62) or Bus2IP_WrCE(63);
  slv_read_ack      <= Bus2IP_RdCE( 0) or Bus2IP_RdCE( 1) or Bus2IP_RdCE( 2) or Bus2IP_RdCE( 3) or Bus2IP_RdCE( 4) or Bus2IP_RdCE( 5) or Bus2IP_RdCE( 6) or Bus2IP_RdCE( 7)
                    or Bus2IP_RdCE( 8) or Bus2IP_RdCE( 9) or Bus2IP_RdCE(10) or Bus2IP_RdCE(11) or Bus2IP_RdCE(12) or Bus2IP_RdCE(13) or Bus2IP_RdCE(14) or Bus2IP_RdCE(15) 
                    or Bus2IP_RdCE(16) or Bus2IP_RdCE(17) or Bus2IP_RdCE(18) or Bus2IP_RdCE(19) or Bus2IP_RdCE(20) or Bus2IP_RdCE(21) or Bus2IP_RdCE(22) or Bus2IP_RdCE(23) 
                    or Bus2IP_RdCE(24) or Bus2IP_RdCE(25) or Bus2IP_RdCE(26) or Bus2IP_RdCE(27) or Bus2IP_RdCE(28) or Bus2IP_RdCE(29) or Bus2IP_RdCE(30) or Bus2IP_RdCE(31) 
                    or Bus2IP_RdCE(32) or Bus2IP_RdCE(33) or Bus2IP_RdCE(34) or Bus2IP_RdCE(35) or Bus2IP_RdCE(36) or Bus2IP_RdCE(37) or Bus2IP_RdCE(38) or Bus2IP_RdCE(39)
                    or Bus2IP_RdCE(40) or Bus2IP_RdCE(41) or Bus2IP_RdCE(42) or Bus2IP_RdCE(43) or Bus2IP_RdCE(44) or Bus2IP_RdCE(45) or Bus2IP_RdCE(46) or Bus2IP_RdCE(47)
                    or Bus2IP_RdCE(48) or Bus2IP_RdCE(49) or Bus2IP_RdCE(50) or Bus2IP_RdCE(51) or Bus2IP_RdCE(52) or Bus2IP_RdCE(53) or Bus2IP_RdCE(54) or Bus2IP_RdCE(55)
                    or Bus2IP_RdCE(56) or Bus2IP_RdCE(57) or Bus2IP_RdCE(58) or Bus2IP_RdCE(59) or Bus2IP_RdCE(60) or Bus2IP_RdCE(61) or Bus2IP_RdCE(62) or Bus2IP_RdCE(63);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Resetn = '0' then
        slv_reg0 <= (others => '0');
        slv_reg1 <= (others => '0');
        slv_reg2 <= (others => '0');
        slv_reg3 <= (others => '0');
        slv_reg4 <= (others => '0');
        slv_reg5 <= (others => '0');
        slv_reg6 <= (others => '0');
        slv_reg7 <= (others => '0');
        slv_reg8 <= (others => '0');
        slv_reg9 <= (others => '0');
        slv_reg10 <= (others => '0');
        slv_reg11 <= (others => '0');
        slv_reg12 <= (others => '0');
        slv_reg13 <= (others => '0');
        slv_reg14 <= (others => '0');
        slv_reg15 <= (others => '0');
        slv_reg16 <= (others => '0');
        slv_reg17 <= (others => '0');
        slv_reg18 <= (others => '0');
        slv_reg19 <= (others => '0');
        slv_reg20 <= (others => '0');
        slv_reg21 <= (others => '0');
        slv_reg22 <= (others => '0');
        slv_reg23 <= (others => '0');
        slv_reg24 <= (others => '0');
        slv_reg25 <= (others => '0');
        slv_reg26 <= (others => '0');
        slv_reg27 <= (others => '0');
        slv_reg28 <= (others => '0');
        slv_reg29 <= (others => '0');
        slv_reg30 <= (others => '0');
        slv_reg31 <= (others => '0');
        slv_reg32 <= (others => '0');
        slv_reg33 <= (others => '0');
        slv_reg34 <= (others => '0');
        slv_reg35 <= (others => '0');
        slv_reg36 <= (others => '0');
        slv_reg37 <= (others => '0');
        slv_reg38 <= (others => '0');
        slv_reg39 <= (others => '0');
        --
        slv_reg55 <= (others => '0');
        slv_reg56 <= (others => '0');
        slv_reg57 <= (others => '0');
        slv_reg58 <= (others => '0');
        slv_reg59 <= (others => '0');
        slv_reg60 <= (others => '0');
        slv_reg61 <= (others => '0');
        slv_reg62 <= (others => '0');
        slv_reg63 <= (others => '0');

      else
        case slv_reg_write_sel is
          when "1000000000000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg0(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0100000000000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg1(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0010000000000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg2(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0001000000000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg3(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000100000000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg4(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000010000000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg5(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000001000000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg6(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000100000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg7(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000010000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg8(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000001000000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg9(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000100000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg10(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000010000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg11(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000001000000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg12(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000100000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg13(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000010000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg14(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000001000000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg15(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000100000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg16(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000010000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg17(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000001000000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg18(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000100000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg19(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000010000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg20(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000001000000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg21(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000100000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg22(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000010000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg23(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000001000000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg24(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000100000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg25(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000010000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg26(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000001000000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg27(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000100000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg28(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000010000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg29(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000001000000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg30(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000100000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg31(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000010000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg32(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000001000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg33(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000100000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg34(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000010000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg35(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000001000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg36(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000100000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg37(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000010000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg38(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000001000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg39(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          --
          when "0000000000000000000000000000000000000000000000000000000100000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg55(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000010000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg56(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000001000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg57(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000000100000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg58(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000000010000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg59(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000000001000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg60(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000000000100" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg61(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000000000010" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg62(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0000000000000000000000000000000000000000000000000000000000000001" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg63(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when others => null;
        end case;
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : process( slv_reg_read_sel, slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6, slv_reg7, slv_reg8, slv_reg9, slv_reg10, slv_reg11, slv_reg12, slv_reg13, slv_reg14, slv_reg15, slv_reg16, slv_reg17, slv_reg18, slv_reg19, slv_reg20, slv_reg21, slv_reg22, slv_reg23, slv_reg24, slv_reg25, slv_reg26, slv_reg27, slv_reg28, slv_reg29, slv_reg30, slv_reg31, slv_reg32, slv_reg33, slv_reg34, slv_reg35, slv_reg36, slv_reg37, slv_reg38, slv_reg39 ) is
  begin

    case slv_reg_read_sel is
      when "1000000000000000000000000000000000000000000000000000000000000000" =>
         --slv_ip2bus_data <= slv_reg0;
         -- 0x00 - SPI_CONTROL
         --           [ 0] VITA_RESET
         --           [ 1] SPI_RESET
         --           [ 8] SPI_STATUS_BUSY
         --           [ 9] SPI_STATUS_ERROR
         --           [16] SPI_TXFIFO_FULL
         --           [24] SPI_RXFIFO_EMPTY
         slv_ip2bus_data <= "0000000" & host_spi_rxfifo_empty &
                            "0000000" & host_spi_txfifo_full &
                            "000000" & host_spi_status_error & host_spi_status_busy &
                            "000000" & host_spi_reset & host_vita_reset;
      when "0100000000000000000000000000000000000000000000000000000000000000" =>
         -- 0x04 - SPI_TIMING[15:0]
         slv_ip2bus_data <= slv_reg1;
      when "0010000000000000000000000000000000000000000000000000000000000000" =>
         -- 0x08 - SPI_TXFIFO_DATA[31:0]
         slv_ip2bus_data <= slv_reg2;
      when "0001000000000000000000000000000000000000000000000000000000000000" =>
         --slv_ip2bus_data <= slv_reg3;
         -- 0x0C - SPI_RXFIFO_DATA[31:0]
         slv_ip2bus_data <= host_spi_rxfifo_dout;
      when "0000100000000000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg4_r1;
      when "0000010000000000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg5;
      when "0000001000000000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg6;
      when "0000000100000000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg7;
      when "0000000010000000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg8;
      when "0000000001000000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg9;
      when "0000000000100000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg10;
      when "0000000000010000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg11;
      when "0000000000001000000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg12;
      when "0000000000000100000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg13;
      when "0000000000000010000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg14_r1;
      when "0000000000000001000000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg15_r1;
      when "0000000000000000100000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg16_r1;
      when "0000000000000000010000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg17_r1;
      when "0000000000000000001000000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg18_r1;
      when "0000000000000000000100000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg19_r1;
      when "0000000000000000000010000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg20_r1;
      when "0000000000000000000001000000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg21_r1;
      when "0000000000000000000000100000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg22_r1;
      when "0000000000000000000000010000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg23;
      when "0000000000000000000000001000000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg24;
      when "0000000000000000000000000100000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg25;
      when "0000000000000000000000000010000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg26;
      when "0000000000000000000000000001000000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg27;
      when "0000000000000000000000000000100000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg28;
      when "0000000000000000000000000000010000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg29_r1;
      when "0000000000000000000000000000001000000000000000000000000000000000" => slv_ip2bus_data <= slv_reg30;
      when "0000000000000000000000000000000100000000000000000000000000000000" => slv_ip2bus_data <= slv_reg31;
      when "0000000000000000000000000000000010000000000000000000000000000000" => slv_ip2bus_data <= slv_reg32;
      when "0000000000000000000000000000000001000000000000000000000000000000" => slv_ip2bus_data <= slv_reg33;
      when "0000000000000000000000000000000000100000000000000000000000000000" => slv_ip2bus_data <= slv_reg34;
      when "0000000000000000000000000000000000010000000000000000000000000000" => slv_ip2bus_data <= slv_reg35;
      when "0000000000000000000000000000000000001000000000000000000000000000" => slv_ip2bus_data <= slv_reg36;
      when "0000000000000000000000000000000000000100000000000000000000000000" => slv_ip2bus_data <= slv_reg37;
      when "0000000000000000000000000000000000000010000000000000000000000000" => slv_ip2bus_data <= slv_reg38;
      when "0000000000000000000000000000000000000001000000000000000000000000" => slv_ip2bus_data <= slv_reg39;
      --
      when "0000000000000000000000000000000000000000000000001000000000000000" => slv_ip2bus_data <= slv_reg48_r1;
      when "0000000000000000000000000000000000000000000000000100000000000000" => slv_ip2bus_data <= slv_reg49_r1;
      when "0000000000000000000000000000000000000000000000000010000000000000" => slv_ip2bus_data <= slv_reg50_r1;
      when "0000000000000000000000000000000000000000000000000001000000000000" => slv_ip2bus_data <= slv_reg51_r1;
      --
      when "0000000000000000000000000000000000000000000000000000000100000000" => slv_ip2bus_data <= slv_reg55;
      when "0000000000000000000000000000000000000000000000000000000010000000" => slv_ip2bus_data <= slv_reg56;
      when "0000000000000000000000000000000000000000000000000000000001000000" => slv_ip2bus_data <= slv_reg57;
      when "0000000000000000000000000000000000000000000000000000000000100000" => slv_ip2bus_data <= slv_reg58;
      when "0000000000000000000000000000000000000000000000000000000000010000" => slv_ip2bus_data <= slv_reg59;
      when "0000000000000000000000000000000000000000000000000000000000001000" => slv_ip2bus_data <= slv_reg60;
      when "0000000000000000000000000000000000000000000000000000000000000100" => slv_ip2bus_data <= slv_reg61;
      when "0000000000000000000000000000000000000000000000000000000000000010" => slv_ip2bus_data <= slv_reg62;
      when "0000000000000000000000000000000000000000000000000000000000000001" => slv_ip2bus_data <= slv_reg63;

      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data  <= slv_ip2bus_data when slv_read_ack = '1' else
                  (others => '0');

  IP2Bus_WrAck <= slv_write_ack;
  IP2Bus_RdAck <= slv_read_ack;
  IP2Bus_Error <= '0';

  --
  -- HOST Interface - SPI
  --

  host_spi_clk          <= Bus2IP_Clk;
  host_spi_txfifo_clk   <= Bus2IP_Clk;
  host_spi_rxfifo_clk   <= Bus2IP_Clk;

  host_spi_process : process ( Bus2IP_Clk )
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Resetn = '0' then
        host_vita_reset        <= '0';
        host_spi_reset         <= '0';
        host_spi_timing        <= (others => '0');
        host_spi_txfifo_wen_a1 <= '0';
        host_spi_txfifo_wen    <= '0';
        host_spi_txfifo_din    <= (others => '0');
        host_spi_rxfifo_ren    <= '0';
      else
         -- 0x00 - SPI_CONTROL
         --           [ 0] VITA_RESET
         --           [ 1] SPI_RESET
         --           [ 8] SPI_STATUS_BUSY
         --           [ 9] SPI_STATUS_ERROR
         --           [16] SPI_TXFIFO_FULL
         --           [24] SPI_RXFIFO_EMPTY
        host_vita_reset        <= slv_reg0(0);
        host_spi_reset         <= slv_reg0(1);
        host_spi_timing        <= slv_reg1(15 downto  0);
        -- slv_reg2 is valid 1 cycle after slv_reg_write_sel(63-2)
        host_spi_txfifo_wen_a1 <= slv_reg_write_sel(63-2);
        host_spi_txfifo_wen    <= host_spi_txfifo_wen_a1;
        host_spi_txfifo_din    <= slv_reg2;
        -- use write to pop value from RXFIFO ...
        host_spi_rxfifo_ren    <= slv_reg_write_sel(63-3);
      end if;
    end if;
  end process host_spi_process;

        slv_reg4_w1                  <= slv_reg4;
        slv_reg5_w1                  <= slv_reg5;
        slv_reg6_w1                  <= slv_reg6;
        slv_reg8_w1                  <= slv_reg8;
        slv_reg9_w1                  <= slv_reg9;
        slv_reg10_w1                 <= slv_reg10;
        slv_reg11_w1                 <= slv_reg11;
        slv_reg12_w1                 <= slv_reg12;
        slv_reg13_w1                 <= slv_reg13;
        slv_reg23_w1                 <= slv_reg23;
        slv_reg24_w1                 <= slv_reg24;
        slv_reg25_w1                 <= slv_reg25;
        slv_reg26_w1                 <= slv_reg26;
        slv_reg27_w1                 <= slv_reg27;
        slv_reg28_w1                 <= slv_reg28;
        slv_reg30_w1                 <= slv_reg30;
        --
        slv_reg32_w1                 <= slv_reg32;
        slv_reg33_w1                 <= slv_reg33;
        slv_reg34_w1                 <= slv_reg34;
        slv_reg35_w1                 <= slv_reg35;
        slv_reg36_w1                 <= slv_reg36;
        slv_reg37_w1                 <= slv_reg37;
        slv_reg38_w1                 <= slv_reg38;
        slv_reg39_w1                 <= slv_reg39;
        --
        slv_reg55_w1                 <= slv_reg55;
        slv_reg56_w1                 <= slv_reg56;
        slv_reg57_w1                 <= slv_reg57;
        slv_reg58_w1                 <= slv_reg58;
        slv_reg59_w1                 <= slv_reg59;
        slv_reg60_w1                 <= slv_reg60;
        slv_reg61_w1                 <= slv_reg61;
        slv_reg62_w1                 <= slv_reg62;
        slv_reg63_w1                 <= slv_reg63;

  host_iserdes_process : process ( clk )
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
--        slv_reg4_w1                  <= (others => '0');
        slv_reg4_r1                  <= (others => '0');
--        slv_reg5_w1                  <= (others => '0');
--        slv_reg6_w1                  <= (others => '0');
--        slv_reg8_w1                  <= (others => '0');
--        slv_reg9_w1                  <= (others => '0');
--        slv_reg10_w1                 <= (others => '0');
--        slv_reg11_w1                 <= (others => '0');
--        slv_reg12_w1                 <= (others => '0');
--        slv_reg13_w1                 <= (others => '0');
        slv_reg14_r1                 <= (others => '0');
        slv_reg15_r1                 <= (others => '0');
        slv_reg16_r1                 <= (others => '0');
        slv_reg17_r1                 <= (others => '0');
        slv_reg18_r1                 <= (others => '0');
        slv_reg19_r1                 <= (others => '0');
        slv_reg20_r1                 <= (others => '0');
        slv_reg21_r1                 <= (others => '0');
        slv_reg22_r1                 <= (others => '0');
--        slv_reg23_w1                 <= (others => '0');
--        slv_reg24_w1                 <= (others => '0');
--        slv_reg25_w1                 <= (others => '0');
--        slv_reg26_w1                 <= (others => '0');
--        slv_reg27_w1                 <= (others => '0');
--        slv_reg28_w1                 <= (others => '0');
        slv_reg29_r1                 <= (others => '0');
--        slv_reg30_w1                 <= (others => '0');
        --
--        slv_reg32_w1                 <= (others => '0');
--        slv_reg33_w1                 <= (others => '0');
--        slv_reg34_w1                 <= (others => '0');
--        slv_reg35_w1                 <= (others => '0');
--        slv_reg36_w1                 <= (others => '0');
--        slv_reg37_w1                 <= (others => '0');
--        slv_reg38_w1                 <= (others => '0');
--        slv_reg39_w1                 <= (others => '0');
        --
        slv_reg48_r1                 <= (others => '0');
        slv_reg49_r1                 <= (others => '0');
        slv_reg50_r1                 <= (others => '0');
        slv_reg51_r1                 <= (others => '0');
        --       
--        slv_reg55_w1                 <= (others => '0');
--        slv_reg56_w1                 <= (others => '0');
--        slv_reg57_w1                 <= (others => '0');
--        slv_reg58_w1                 <= (others => '0');
--        slv_reg59_w1                 <= (others => '0');
--        slv_reg60_w1                 <= (others => '0');
--        slv_reg61_w1                 <= (others => '0');
--        slv_reg62_w1                 <= (others => '0');
--        slv_reg63_w1                 <= (others => '0');
        --
        host_iserdes_reset           <= '0';
        host_iserdes_auto_align      <= '0';
        host_iserdes_align_start     <= '0';
        host_iserdes_fifo_enable     <= '0';
        host_iserdes_training        <= (others => '0');
        host_iserdes_manual_tap      <= (others => '0');
	  --
        host_fpn_prnu_values         <= (others => '0');
        --
        host_triggen_enable            <= (others => '0');
        host_triggen_sync2readout      <= (others => '0');
        host_triggen_readouttrigger    <= '0';
        host_triggen_default_freq      <= (others => '0');
        host_triggen_cnt_trigger0high  <= (others => '0');
        host_triggen_cnt_trigger0low   <= (others => '0');
        host_triggen_cnt_trigger1high  <= (others => '0');
        host_triggen_cnt_trigger1low   <= (others => '0');
        host_triggen_cnt_trigger2high  <= (others => '0');
        host_triggen_cnt_trigger2low   <= (others => '0');
        host_triggen_ext_debounce      <= (others => '0');
        host_triggen_ext_polarity      <= '0';
        host_triggen_cnt_update        <= '0';

      else
--        slv_reg4_w1                  <= slv_reg4;
--        slv_reg5_w1                  <= slv_reg5;
--        slv_reg6_w1                  <= slv_reg6;
--        slv_reg8_w1                  <= slv_reg8;
--        slv_reg9_w1                  <= slv_reg9;
--        slv_reg10_w1                 <= slv_reg10;
--        slv_reg11_w1                 <= slv_reg11;
--        slv_reg12_w1                 <= slv_reg12;
--        slv_reg13_w1                 <= slv_reg13;
--        slv_reg23_w1                 <= slv_reg23;
--        slv_reg24_w1                 <= slv_reg24;
--        slv_reg25_w1                 <= slv_reg25;
--        slv_reg26_w1                 <= slv_reg26;
--        slv_reg27_w1                 <= slv_reg27;
--        slv_reg28_w1                 <= slv_reg28;
--        slv_reg30_w1                 <= slv_reg30;
        --
--        slv_reg32_w1                 <= slv_reg32;
--        slv_reg33_w1                 <= slv_reg33;
--        slv_reg34_w1                 <= slv_reg34;
--        slv_reg35_w1                 <= slv_reg35;
--        slv_reg36_w1                 <= slv_reg36;
--        slv_reg37_w1                 <= slv_reg37;
--        slv_reg38_w1                 <= slv_reg38;
--        slv_reg39_w1                 <= slv_reg39;
        --
--        slv_reg55_w1                 <= slv_reg55;
--        slv_reg56_w1                 <= slv_reg56;
--        slv_reg57_w1                 <= slv_reg57;
--        slv_reg58_w1                 <= slv_reg58;
--        slv_reg59_w1                 <= slv_reg59;
--        slv_reg60_w1                 <= slv_reg60;
--        slv_reg61_w1                 <= slv_reg61;
--        slv_reg62_w1                 <= slv_reg62;
--        slv_reg63_w1                 <= slv_reg63;
        --
        -- 0x10 - ISERDES_CONTROL
        --           [ 0] ISERDES_RESET
        --           [ 1] ISERDES_AUTO_ALIGN
        --           [ 2] ISERDES_ALIGN_START
        --           [ 3] ISERDES_FIFO_ENABLE
        --           [ 8] ISERDES_CLK_READY
        --           [ 9] ISERDES_ALIGN_BUSY
        --           [10] ISERDES_ALIGNED
        --        [23:16] ISERDES_TXCLK_STATUS
        --        [31:24] ISERDES_RXCLK_STATUS
        host_iserdes_reset           <= slv_reg4_w1(0);
        host_iserdes_auto_align      <= slv_reg4_w1(1);
        host_iserdes_align_start     <= slv_reg4_w1(2);
        host_iserdes_fifo_enable     <= slv_reg4_w1(3);
        slv_reg4_r1 <= host_iserdes_clk_status & 
                       "00000" & host_iserdes_aligned & host_iserdes_align_busy & host_iserdes_clk_ready &
                       "0000" & host_iserdes_fifo_enable & host_iserdes_align_start & host_iserdes_auto_align & host_iserdes_reset;
        --       
        -- 0x14 - ISERDES_TRAINING
        host_iserdes_training        <= slv_reg5_w1(9 downto 0);
        --       
        -- 0x18 - ISERDES_MANUAL_TAP
        host_iserdes_manual_tap      <= slv_reg6_w1(9 downto 0);

        --       
        -- 0x20 - DECODER_CONTROL[7:0]
        --           [0] DECODER_RESET
        --           [1] DECODER_ENABLE
        host_decoder_reset           <= slv_reg8_w1(0);
        host_decoder_enable          <= slv_reg8_w1(1);
        --       
        -- 0x24 - DECODER_STARTODDEVEN
        host_decoder_startoddeven    <= slv_reg9_w1;
        --       
        -- 0x28 - DECODER_CODES_LS_LE
        host_decoder_code_ls         <= slv_reg10_w1( 9 downto  0);
        host_decoder_code_le         <= slv_reg10_w1(25 downto 16);
        --       
        -- 0x2C - DECODER_CODES_FS_FE
        host_decoder_code_fs         <= slv_reg11_w1( 9 downto  0);
        host_decoder_code_fe         <= slv_reg11_w1(25 downto 16);
        --       
        -- 0x30 - DECODER_CODES_BL_IMG
        host_decoder_code_bl         <= slv_reg12_w1( 9 downto  0);
        host_decoder_code_img        <= slv_reg12_w1(25 downto 16);
        --       
        -- 0x34 - DECODER_CODES_TR_CRC
        host_decoder_code_tr         <= slv_reg13_w1( 9 downto  0);
        host_decoder_code_crc        <= slv_reg13_w1(25 downto 16);

      if ( host_decoder_frame_start = '1' ) then

        --       
        -- 0x38 - DECODER_CNT_BLACK_LINES
        slv_reg14_r1 <= host_decoder_cnt_black_lines;
        --       
        -- 0x3C - DECODER_CNT_IMAGE_LINES
        slv_reg15_r1 <= host_decoder_cnt_image_lines;
        --       
        -- 0x40 - DECODER_CNT_BLACK_PIXELS
        slv_reg16_r1 <= host_decoder_cnt_black_pixels;
        --       
        -- 0x44 - DECODER_CNT_IMAGE_PIXELS
        slv_reg17_r1 <= host_decoder_cnt_image_pixels;
        --       
        -- 0x48 - DECODER_CNT_FRAMES
        slv_reg18_r1 <= host_decoder_cnt_frames;
        --       
        -- 0x4C - DECODER_CNT_WINDOWS
        slv_reg19_r1 <= host_decoder_cnt_windows;
        --       
        -- 0x50 - DECODER_CNT_CLOCKS
        slv_reg20_r1 <= host_decoder_cnt_clocks;
        --       
        -- 0x54 - DECODER_CNT_START_LINES
        slv_reg21_r1 <= host_decoder_cnt_start_lines;
        --       
        -- 0x58 - DECODER_CNT_END_LINES
        slv_reg22_r1 <= host_decoder_cnt_end_lines;

      end if; --if ( host_decoder_frame_start = '1' ) then

        -- 0x5C - SYNCGEN_DELAY
        --           [15: 0] DELAY
        host_syncgen_delay <= slv_reg23_w1(15 downto  0);
        -- 0x60 - SYNCGEN_HTIMING1
        --           [15: 0] HACTIVE
        --           [31:16] HFPORCH
        -- 0x64 - SYNCGEN_HTIMING2
        --           [15: 0] HSYNC
        --           [31:16] HBPORCH
        -- 0x68 - SYNCGEN_VTIMING1
        --           [15: 0] VACTIVE
        --           [31:16] VFPORCH
        -- 0x6C - SYNCGEN_VTIMING2
        --           [15: 0] VSYNC
        --           [31:16] VBPORCH
        host_syncgen_hactive <= slv_reg24_w1(15 downto  0);
        host_syncgen_hfporch <= slv_reg24_w1(31 downto 16);
        host_syncgen_hsync   <= slv_reg25_w1(15 downto  0);
        host_syncgen_hbporch <= slv_reg25_w1(31 downto 16);
        host_syncgen_vactive <= slv_reg26_w1(15 downto  0);
        host_syncgen_vfporch <= slv_reg26_w1(31 downto 16);
        host_syncgen_vsync   <= slv_reg27_w1(15 downto  0);
        host_syncgen_vbporch <= slv_reg27_w1(31 downto 16);

        --       
        -- 0x70 - CRC_CONTROL[7:0]
        --           [0] CRC_RESET
        --           [1] CRC_INITVALUE
        host_crc_reset               <= slv_reg28_w1(0);
        host_crc_initvalue           <= slv_reg28_w1(1);
        --       
        -- 0x74 - CRC_STATUS
        slv_reg29_r1 <= host_crc_status;

        --       
        -- 0x78 - REMAPPER_CONTROL[7:0]
        --           [2:0] REMAPPER_WRITE_CFG
        --           [6:4] REMAPPER_MODE
        host_remapper_write_cfg      <= slv_reg30_w1(2 downto 0);
        host_remapper_mode           <= slv_reg30_w1(6 downto 4);

        -- 0x80 - FPN_PRNU_VALUES[ 31:  0]
        -- 0x84 - FPN_PRNU_VALUES[ 63: 32]
        -- 0x88 - FPN_PRNU_VALUES[ 95: 64]
        -- 0x8C - FPN_PRNU_VALUES[127: 96]
        -- 0x90 - FPN_PRNU_VALUES[159:128]
        -- 0x94 - FPN_PRNU_VALUES[191:160]
        -- 0x98 - FPN_PRNU_VALUES[223:192]
        -- 0x9C - FPN_PRNU_VALUES[255:224]
        host_fpn_prnu_values( 31 downto   0) <= slv_reg32_w1;
        host_fpn_prnu_values( 63 downto  32) <= slv_reg33_w1;
        host_fpn_prnu_values( 95 downto  64) <= slv_reg34_w1;
        host_fpn_prnu_values(127 downto  96) <= slv_reg35_w1;
        host_fpn_prnu_values(159 downto 128) <= slv_reg36_w1;
        host_fpn_prnu_values(191 downto 160) <= slv_reg37_w1;
        host_fpn_prnu_values(223 downto 192) <= slv_reg38_w1;
        host_fpn_prnu_values(255 downto 224) <= slv_reg39_w1;


        --       
        -- 0xC0 - DECODER_CNT_MONITOR0_HIGH
        slv_reg48_r1 <= host_decoder_cnt_monitor0high;
        --       
        -- 0xC4 - DECODER_CNT_MONITOR0_LOW
        slv_reg49_r1 <= host_decoder_cnt_monitor0low;
        --       
        -- 0xC8 - DECODER_CNT_MONITOR1_HIGH
        slv_reg50_r1 <= host_decoder_cnt_monitor1high;
        --       
        -- 0xCC - DECODER_CNT_MONITOR1_LOW
        slv_reg51_r1 <= host_decoder_cnt_monitor1low;


        --
        -- 0xDC - TRIGGEN_EXT_DEBOUNCE
        host_triggen_ext_debounce      <= slv_reg55_w1;
        --
        -- 0xE0 - TRIGGEN_CONTROL
        --        [ 2: 0] TRIGGEN_ENABLE
        --        [ 6: 4] TRIGGEN_SYNC2READOUT
        --        [    8] TRIGGEN_READOUTTRIGGER
        --        [   16] TRIGGEN_EXT_POLARITY
        --        [   24] TRIGGEN_CNT_UPDATE
        --        [30:28] TRIGGEN_GEN_POLARITY
        host_triggen_enable            <= slv_reg56_w1(2 downto 0);
        host_triggen_sync2readout      <= slv_reg56_w1(6 downto 4);
        host_triggen_readouttrigger    <= slv_reg56_w1(8);
        host_triggen_ext_polarity      <= slv_reg56_w1(16);
        host_triggen_cnt_update        <= slv_reg56_w1(24);
        host_triggen_gen_polarity      <= slv_reg56_w1(30 downto 28);
        --
        -- 0xE4 - TRIGGEN_DEFAULT_FREQ
        host_triggen_default_freq      <= slv_reg57_w1;
        --
        if ( host_triggen_cnt_update = '1' ) then
           --
           -- 0xE8 - TRIGGEN_TRIG0_HIGH
           host_triggen_cnt_trigger0high  <= slv_reg58_w1;
           --
           -- 0xEC - TRIGGEN_TRIG0_LOW
           host_triggen_cnt_trigger0low   <= slv_reg59_w1;
           --
           -- 0xF0 - TRIGGEN_TRIG1_HIGH
           host_triggen_cnt_trigger1high  <= slv_reg60_w1;
           --
           -- 0xF4 - TRIGGEN_TRIG1_LOW
           host_triggen_cnt_trigger1low   <= slv_reg61_w1;
           --
           -- 0xF8 - TRIGGEN_TRIG2_HIGH
           host_triggen_cnt_trigger2high  <= slv_reg62_w1;
           --
           -- 0xFC - TRIGGEN_TRIG2_LOW
           host_triggen_cnt_trigger2low   <= slv_reg63_w1;
           --
        end if; -- if ( host_triggen_cnt_update == '1' ) then

      end if;
    end if;
  end process host_iserdes_process;


  ------------------------------------------
  -- VITA Receiver Core Logic
  ------------------------------------------
  VITA_CORE_I : entity fmc_imageon_vita_receiver_v1_13_a.fmc_imageon_vita_core
    generic map
    (
      C_XSVI_DATA_WIDTH              => C_XSVI_DATA_WIDTH,
      C_XSVI_DIRECT_OUTPUT           => C_XSVI_DIRECT_OUTPUT,
      C_XSVI_USE_SYNCGEN             => C_XSVI_USE_SYNCGEN,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      clk200                         => clk200,
      clk                            => clk,
      clk4x                          => clk4x,
      reset                          => reset,
      oe                             => oe,
      -- HOST Interface - VITA      
      host_vita_reset                => host_vita_reset,
      -- HOST Interface - SPI
      host_spi_clk                   => host_spi_clk,
      host_spi_reset                 => host_spi_reset,
      host_spi_timing                => host_spi_timing,
      host_spi_status_busy           => host_spi_status_busy,
      host_spi_status_error          => host_spi_status_error,
      host_spi_txfifo_clk            => host_spi_txfifo_clk,
      host_spi_txfifo_wen            => host_spi_txfifo_wen,
      host_spi_txfifo_din            => host_spi_txfifo_din,
      host_spi_txfifo_full           => host_spi_txfifo_full,
      host_spi_rxfifo_clk            => host_spi_rxfifo_clk,
      host_spi_rxfifo_ren            => host_spi_rxfifo_ren,
      host_spi_rxfifo_dout           => host_spi_rxfifo_dout,
      host_spi_rxfifo_empty          => host_spi_rxfifo_empty,
      -- HOST Interface - ISERDES
      host_iserdes_reset             => host_iserdes_reset,
      host_iserdes_auto_align        => host_iserdes_auto_align,
      host_iserdes_align_start       => host_iserdes_align_start,
      host_iserdes_fifo_enable       => host_iserdes_fifo_enable,
      host_iserdes_manual_tap        => host_iserdes_manual_tap,
      host_iserdes_training          => host_iserdes_training,
      host_iserdes_clk_ready         => host_iserdes_clk_ready,
      host_iserdes_clk_status        => host_iserdes_clk_status,
      host_iserdes_align_busy        => host_iserdes_align_busy,
      host_iserdes_aligned           => host_iserdes_aligned,
      -- HOST Interface - Sync Channel Decoder
      host_decoder_reset             => host_decoder_reset,
      host_decoder_enable            => host_decoder_enable,
      host_decoder_startoddeven      => host_decoder_startoddeven,
      host_decoder_code_ls           => host_decoder_code_ls,
      host_decoder_code_le           => host_decoder_code_le,
      host_decoder_code_fs           => host_decoder_code_fs,
      host_decoder_code_fe           => host_decoder_code_fe,
      host_decoder_code_bl           => host_decoder_code_bl,
      host_decoder_code_img          => host_decoder_code_img,
      host_decoder_code_tr           => host_decoder_code_tr,
      host_decoder_code_crc          => host_decoder_code_crc,
      host_decoder_frame_start       => host_decoder_frame_start,
      host_decoder_cnt_black_lines   => host_decoder_cnt_black_lines,
      host_decoder_cnt_image_lines   => host_decoder_cnt_image_lines,
      host_decoder_cnt_black_pixels  => host_decoder_cnt_black_pixels,
      host_decoder_cnt_image_pixels  => host_decoder_cnt_image_pixels,
      host_decoder_cnt_frames        => host_decoder_cnt_frames,
      host_decoder_cnt_windows       => host_decoder_cnt_windows,
      host_decoder_cnt_clocks        => host_decoder_cnt_clocks,
      host_decoder_cnt_start_lines   => host_decoder_cnt_start_lines,
      host_decoder_cnt_end_lines     => host_decoder_cnt_end_lines,
      host_decoder_cnt_monitor0high  => host_decoder_cnt_monitor0high,
      host_decoder_cnt_monitor0low   => host_decoder_cnt_monitor0low,
      host_decoder_cnt_monitor1high  => host_decoder_cnt_monitor1high,
      host_decoder_cnt_monitor1low   => host_decoder_cnt_monitor1low,
      -- HOST Interface - CRC Checker
      host_crc_reset                 => host_crc_reset,
      host_crc_initvalue             => host_crc_initvalue,
      host_crc_status                => host_crc_status,
      -- HOST Interface - Data Channel Remapper
      host_remapper_write_cfg        => host_remapper_write_cfg,
      host_remapper_mode             => host_remapper_mode,
      -- HOST Interface - Trigger Generator
      host_triggen_enable            => host_triggen_enable,
      host_triggen_sync2readout      => host_triggen_sync2readout,
      host_triggen_readouttrigger    => host_triggen_readouttrigger,
      host_triggen_default_freq      => host_triggen_default_freq,
      host_triggen_cnt_trigger0high  => host_triggen_cnt_trigger0high,
      host_triggen_cnt_trigger0low   => host_triggen_cnt_trigger0low,
      host_triggen_cnt_trigger1high  => host_triggen_cnt_trigger1high,
      host_triggen_cnt_trigger1low   => host_triggen_cnt_trigger1low,
      host_triggen_cnt_trigger2high  => host_triggen_cnt_trigger2high,
      host_triggen_cnt_trigger2low   => host_triggen_cnt_trigger2low,
      host_triggen_ext_debounce      => host_triggen_ext_debounce,
      host_triggen_ext_polarity      => host_triggen_ext_polarity,
      host_triggen_gen_polarity      => host_triggen_gen_polarity,
      -- HOST Interface - FPN/PRNU Correction
      host_fpn_prnu_values           => host_fpn_prnu_values,
      -- HOST Interface - Sync Generator
      host_syncgen_delay             => host_syncgen_delay,
      host_syncgen_hactive           => host_syncgen_hactive,
      host_syncgen_hfporch           => host_syncgen_hfporch,
      host_syncgen_hsync             => host_syncgen_hsync,
      host_syncgen_hbporch           => host_syncgen_hbporch,
      host_syncgen_vactive           => host_syncgen_vactive,
      host_syncgen_vfporch           => host_syncgen_vfporch,
      host_syncgen_vsync             => host_syncgen_vsync,
      host_syncgen_vbporch           => host_syncgen_vbporch,
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
      -- Debug Port
      debug_spi_o                    => debug_spi_o,
      debug_iserdes_o                => debug_iserdes_o,
      debug_decoder_o                => debug_decoder_o,
      debug_crc_o                    => debug_crc_o,
      debug_triggen_o                => debug_triggen_o,
      debug_video_o                  => debug_video_o
   );

   --
   -- Debug Port
   --    Can be used to connect to ChipScope for debugging.
   --    Having a port makes these signals accessible for debug via EDK.
   -- 

   debug_host_l : process (Bus2IP_Clk)
   begin
      if Rising_Edge(Bus2IP_Clk) then
         debug_host_o( 31 downto   0) <= Bus2IP_Addr;
         debug_host_o( 63 downto  32) <= Bus2IP_Data;
         debug_host_o( 95 downto  64) <= slv_ip2bus_data;
         debug_host_o(159 downto  96) <= Bus2IP_WrCE;
         debug_host_o(223 downto 160) <= Bus2IP_RdCE;
         debug_host_o(           224) <= Bus2IP_CS(0);
         debug_host_o(           225) <= Bus2IP_RNW;
         debug_host_o(229 downto 226) <= Bus2IP_BE;
         debug_host_o(           230) <= slv_write_ack;
         debug_host_o(           231) <= slv_read_ack;

      end if;
   end process;

end IMP;
