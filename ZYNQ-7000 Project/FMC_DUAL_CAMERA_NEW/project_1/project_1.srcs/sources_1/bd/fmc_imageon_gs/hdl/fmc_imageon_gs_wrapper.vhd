--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
--Date        : Fri Feb 17 21:24:59 2017
--Host        : user-PC running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target fmc_imageon_gs_wrapper.bd
--Design      : fmc_imageon_gs_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fmc_imageon_gs_wrapper is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    IO_HDMIO_L_clk : out STD_LOGIC;
    IO_HDMIO_L_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    IO_HDMIO_L_spdif : out STD_LOGIC;
    IO_HDMIO_R_clk : out STD_LOGIC;
    IO_HDMIO_R_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    IO_HDMIO_R_spdif : out STD_LOGIC;
    IO_VITA_CAM_L_clk_out_n : in STD_LOGIC;
    IO_VITA_CAM_L_clk_out_p : in STD_LOGIC;
    IO_VITA_CAM_L_clk_pll : out STD_LOGIC;
    IO_VITA_CAM_L_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_L_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_L_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    IO_VITA_CAM_L_reset_n : out STD_LOGIC;
    IO_VITA_CAM_L_sync_n : in STD_LOGIC;
    IO_VITA_CAM_L_sync_p : in STD_LOGIC;
    IO_VITA_CAM_L_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    IO_VITA_CAM_R_clk_out_n : in STD_LOGIC;
    IO_VITA_CAM_R_clk_out_p : in STD_LOGIC;
    IO_VITA_CAM_R_clk_pll : out STD_LOGIC;
    IO_VITA_CAM_R_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_R_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_R_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    IO_VITA_CAM_R_reset_n : out STD_LOGIC;
    IO_VITA_CAM_R_sync_n : in STD_LOGIC;
    IO_VITA_CAM_R_sync_p : in STD_LOGIC;
    IO_VITA_CAM_R_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    IO_VITA_SPI_L_spi_miso : in STD_LOGIC;
    IO_VITA_SPI_L_spi_mosi : out STD_LOGIC;
    IO_VITA_SPI_L_spi_sclk : out STD_LOGIC;
    IO_VITA_SPI_L_spi_ssel_n : out STD_LOGIC;
    IO_VITA_SPI_R_spi_miso : in STD_LOGIC;
    IO_VITA_SPI_R_spi_mosi : out STD_LOGIC;
    IO_VITA_SPI_R_spi_sclk : out STD_LOGIC;
    IO_VITA_SPI_R_spi_ssel_n : out STD_LOGIC;
    fmc_imageon_iic_l_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    fmc_imageon_iic_l_scl_io : inout STD_LOGIC;
    fmc_imageon_iic_l_sda_io : inout STD_LOGIC;
    fmc_imageon_iic_r_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    fmc_imageon_iic_r_scl_io : inout STD_LOGIC;
    fmc_imageon_iic_r_sda_io : inout STD_LOGIC;
    fmc_imageon_vclk_l : in STD_LOGIC;
    fmc_imageon_vclk_r : in STD_LOGIC
  );
end fmc_imageon_gs_wrapper;

architecture STRUCTURE of fmc_imageon_gs_wrapper is
  component fmc_imageon_gs is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    IO_HDMIO_R_clk : out STD_LOGIC;
    IO_HDMIO_R_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    IO_HDMIO_R_spdif : out STD_LOGIC;
    fmc_imageon_iic_r_scl_i : in STD_LOGIC;
    fmc_imageon_iic_r_scl_o : out STD_LOGIC;
    fmc_imageon_iic_r_scl_t : out STD_LOGIC;
    fmc_imageon_iic_r_sda_i : in STD_LOGIC;
    fmc_imageon_iic_r_sda_o : out STD_LOGIC;
    fmc_imageon_iic_r_sda_t : out STD_LOGIC;
    IO_HDMIO_L_clk : out STD_LOGIC;
    IO_HDMIO_L_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    IO_HDMIO_L_spdif : out STD_LOGIC;
    fmc_imageon_iic_l_scl_i : in STD_LOGIC;
    fmc_imageon_iic_l_scl_o : out STD_LOGIC;
    fmc_imageon_iic_l_scl_t : out STD_LOGIC;
    fmc_imageon_iic_l_sda_i : in STD_LOGIC;
    fmc_imageon_iic_l_sda_o : out STD_LOGIC;
    fmc_imageon_iic_l_sda_t : out STD_LOGIC;
    fmc_imageon_vclk_r : in STD_LOGIC;
    fmc_imageon_iic_r_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    fmc_imageon_vclk_l : in STD_LOGIC;
    fmc_imageon_iic_l_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    IO_VITA_CAM_R_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_R_sync_p : in STD_LOGIC;
    IO_VITA_CAM_R_sync_n : in STD_LOGIC;
    IO_VITA_CAM_R_reset_n : out STD_LOGIC;
    IO_VITA_CAM_R_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    IO_VITA_CAM_R_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    IO_VITA_CAM_R_clk_pll : out STD_LOGIC;
    IO_VITA_CAM_R_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_R_clk_out_p : in STD_LOGIC;
    IO_VITA_CAM_R_clk_out_n : in STD_LOGIC;
    IO_VITA_CAM_L_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_L_sync_p : in STD_LOGIC;
    IO_VITA_CAM_L_sync_n : in STD_LOGIC;
    IO_VITA_CAM_L_reset_n : out STD_LOGIC;
    IO_VITA_CAM_L_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    IO_VITA_CAM_L_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    IO_VITA_CAM_L_clk_pll : out STD_LOGIC;
    IO_VITA_CAM_L_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_VITA_CAM_L_clk_out_p : in STD_LOGIC;
    IO_VITA_CAM_L_clk_out_n : in STD_LOGIC;
    IO_VITA_SPI_R_spi_sclk : out STD_LOGIC;
    IO_VITA_SPI_R_spi_ssel_n : out STD_LOGIC;
    IO_VITA_SPI_R_spi_mosi : out STD_LOGIC;
    IO_VITA_SPI_R_spi_miso : in STD_LOGIC;
    IO_VITA_SPI_L_spi_sclk : out STD_LOGIC;
    IO_VITA_SPI_L_spi_ssel_n : out STD_LOGIC;
    IO_VITA_SPI_L_spi_mosi : out STD_LOGIC;
    IO_VITA_SPI_L_spi_miso : in STD_LOGIC
  );
  end component fmc_imageon_gs;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal fmc_imageon_iic_l_scl_i : STD_LOGIC;
  signal fmc_imageon_iic_l_scl_o : STD_LOGIC;
  signal fmc_imageon_iic_l_scl_t : STD_LOGIC;
  signal fmc_imageon_iic_l_sda_i : STD_LOGIC;
  signal fmc_imageon_iic_l_sda_o : STD_LOGIC;
  signal fmc_imageon_iic_l_sda_t : STD_LOGIC;
  signal fmc_imageon_iic_r_scl_i : STD_LOGIC;
  signal fmc_imageon_iic_r_scl_o : STD_LOGIC;
  signal fmc_imageon_iic_r_scl_t : STD_LOGIC;
  signal fmc_imageon_iic_r_sda_i : STD_LOGIC;
  signal fmc_imageon_iic_r_sda_o : STD_LOGIC;
  signal fmc_imageon_iic_r_sda_t : STD_LOGIC;
begin
fmc_imageon_gs_i: component fmc_imageon_gs
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      IO_HDMIO_L_clk => IO_HDMIO_L_clk,
      IO_HDMIO_L_data(15 downto 0) => IO_HDMIO_L_data(15 downto 0),
      IO_HDMIO_L_spdif => IO_HDMIO_L_spdif,
      IO_HDMIO_R_clk => IO_HDMIO_R_clk,
      IO_HDMIO_R_data(15 downto 0) => IO_HDMIO_R_data(15 downto 0),
      IO_HDMIO_R_spdif => IO_HDMIO_R_spdif,
      IO_VITA_CAM_L_clk_out_n => IO_VITA_CAM_L_clk_out_n,
      IO_VITA_CAM_L_clk_out_p => IO_VITA_CAM_L_clk_out_p,
      IO_VITA_CAM_L_clk_pll => IO_VITA_CAM_L_clk_pll,
      IO_VITA_CAM_L_data_n(3 downto 0) => IO_VITA_CAM_L_data_n(3 downto 0),
      IO_VITA_CAM_L_data_p(3 downto 0) => IO_VITA_CAM_L_data_p(3 downto 0),
      IO_VITA_CAM_L_monitor(1 downto 0) => IO_VITA_CAM_L_monitor(1 downto 0),
      IO_VITA_CAM_L_reset_n => IO_VITA_CAM_L_reset_n,
      IO_VITA_CAM_L_sync_n => IO_VITA_CAM_L_sync_n,
      IO_VITA_CAM_L_sync_p => IO_VITA_CAM_L_sync_p,
      IO_VITA_CAM_L_trigger(2 downto 0) => IO_VITA_CAM_L_trigger(2 downto 0),
      IO_VITA_CAM_R_clk_out_n => IO_VITA_CAM_R_clk_out_n,
      IO_VITA_CAM_R_clk_out_p => IO_VITA_CAM_R_clk_out_p,
      IO_VITA_CAM_R_clk_pll => IO_VITA_CAM_R_clk_pll,
      IO_VITA_CAM_R_data_n(3 downto 0) => IO_VITA_CAM_R_data_n(3 downto 0),
      IO_VITA_CAM_R_data_p(3 downto 0) => IO_VITA_CAM_R_data_p(3 downto 0),
      IO_VITA_CAM_R_monitor(1 downto 0) => IO_VITA_CAM_R_monitor(1 downto 0),
      IO_VITA_CAM_R_reset_n => IO_VITA_CAM_R_reset_n,
      IO_VITA_CAM_R_sync_n => IO_VITA_CAM_R_sync_n,
      IO_VITA_CAM_R_sync_p => IO_VITA_CAM_R_sync_p,
      IO_VITA_CAM_R_trigger(2 downto 0) => IO_VITA_CAM_R_trigger(2 downto 0),
      IO_VITA_SPI_L_spi_miso => IO_VITA_SPI_L_spi_miso,
      IO_VITA_SPI_L_spi_mosi => IO_VITA_SPI_L_spi_mosi,
      IO_VITA_SPI_L_spi_sclk => IO_VITA_SPI_L_spi_sclk,
      IO_VITA_SPI_L_spi_ssel_n => IO_VITA_SPI_L_spi_ssel_n,
      IO_VITA_SPI_R_spi_miso => IO_VITA_SPI_R_spi_miso,
      IO_VITA_SPI_R_spi_mosi => IO_VITA_SPI_R_spi_mosi,
      IO_VITA_SPI_R_spi_sclk => IO_VITA_SPI_R_spi_sclk,
      IO_VITA_SPI_R_spi_ssel_n => IO_VITA_SPI_R_spi_ssel_n,
      fmc_imageon_iic_l_rst_n(0) => fmc_imageon_iic_l_rst_n(0),
      fmc_imageon_iic_l_scl_i => fmc_imageon_iic_l_scl_i,
      fmc_imageon_iic_l_scl_o => fmc_imageon_iic_l_scl_o,
      fmc_imageon_iic_l_scl_t => fmc_imageon_iic_l_scl_t,
      fmc_imageon_iic_l_sda_i => fmc_imageon_iic_l_sda_i,
      fmc_imageon_iic_l_sda_o => fmc_imageon_iic_l_sda_o,
      fmc_imageon_iic_l_sda_t => fmc_imageon_iic_l_sda_t,
      fmc_imageon_iic_r_rst_n(0) => fmc_imageon_iic_r_rst_n(0),
      fmc_imageon_iic_r_scl_i => fmc_imageon_iic_r_scl_i,
      fmc_imageon_iic_r_scl_o => fmc_imageon_iic_r_scl_o,
      fmc_imageon_iic_r_scl_t => fmc_imageon_iic_r_scl_t,
      fmc_imageon_iic_r_sda_i => fmc_imageon_iic_r_sda_i,
      fmc_imageon_iic_r_sda_o => fmc_imageon_iic_r_sda_o,
      fmc_imageon_iic_r_sda_t => fmc_imageon_iic_r_sda_t,
      fmc_imageon_vclk_l => fmc_imageon_vclk_l,
      fmc_imageon_vclk_r => fmc_imageon_vclk_r
    );
fmc_imageon_iic_l_scl_iobuf: component IOBUF
     port map (
      I => fmc_imageon_iic_l_scl_o,
      IO => fmc_imageon_iic_l_scl_io,
      O => fmc_imageon_iic_l_scl_i,
      T => fmc_imageon_iic_l_scl_t
    );
fmc_imageon_iic_l_sda_iobuf: component IOBUF
     port map (
      I => fmc_imageon_iic_l_sda_o,
      IO => fmc_imageon_iic_l_sda_io,
      O => fmc_imageon_iic_l_sda_i,
      T => fmc_imageon_iic_l_sda_t
    );
fmc_imageon_iic_r_scl_iobuf: component IOBUF
     port map (
      I => fmc_imageon_iic_r_scl_o,
      IO => fmc_imageon_iic_r_scl_io,
      O => fmc_imageon_iic_r_scl_i,
      T => fmc_imageon_iic_r_scl_t
    );
fmc_imageon_iic_r_sda_iobuf: component IOBUF
     port map (
      I => fmc_imageon_iic_r_sda_o,
      IO => fmc_imageon_iic_r_sda_io,
      O => fmc_imageon_iic_r_sda_i,
      T => fmc_imageon_iic_r_sda_t
    );
end STRUCTURE;
