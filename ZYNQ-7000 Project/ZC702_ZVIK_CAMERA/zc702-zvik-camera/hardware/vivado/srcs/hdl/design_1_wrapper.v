`timescale 1 ps / 1 ps
// lib IP_Integrator_Lib
module design_1_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    clk_in1,
    iic_main_scl_io,
    iic_main_sda_io,
    iic_rst,
    iic_scl_io,
    iic_sda_io,
    io_hdmio_clk,
    io_hdmio_de,
    io_hdmio_hsync,
    io_hdmio_spdif,
    io_hdmio_video,
    io_hdmio_vsync,
    io_vita_clk_out_n,
    io_vita_clk_out_p,
    io_vita_clk_pll,
    io_vita_data_n,
    io_vita_data_p,
    io_vita_monitor,
    io_vita_reset_n,
    io_vita_spi_miso,
    io_vita_spi_mosi,
    io_vita_spi_sclk,
    io_vita_spi_ssel_n,
    io_vita_sync_n,
    io_vita_sync_p,
    io_vita_trigger);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input clk_in1;
  inout iic_main_scl_io;
  inout iic_main_sda_io;
  output [0:0]iic_rst;
  inout iic_scl_io;
  inout iic_sda_io;
  output io_hdmio_clk;
  output io_hdmio_de;
  output io_hdmio_hsync;
  output io_hdmio_spdif;
  output [15:0]io_hdmio_video;
  output io_hdmio_vsync;
  input io_vita_clk_out_n;
  input io_vita_clk_out_p;
  output io_vita_clk_pll;
  input [7:0]io_vita_data_n;
  input [7:0]io_vita_data_p;
  input [1:0]io_vita_monitor;
  output io_vita_reset_n;
  input io_vita_spi_miso;
  output io_vita_spi_mosi;
  output io_vita_spi_sclk;
  output io_vita_spi_ssel_n;
  input io_vita_sync_n;
  input io_vita_sync_p;
  output [2:0]io_vita_trigger;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire clk_in1;
  wire iic_main_scl_i;
  wire iic_main_scl_io;
  wire iic_main_scl_o;
  wire iic_main_scl_t;
  wire iic_main_sda_i;
  wire iic_main_sda_io;
  wire iic_main_sda_o;
  wire iic_main_sda_t;
  wire [0:0]iic_rst;
  wire iic_scl_i;
  wire iic_scl_io;
  wire iic_scl_o;
  wire iic_scl_t;
  wire iic_sda_i;
  wire iic_sda_io;
  wire iic_sda_o;
  wire iic_sda_t;
  wire io_hdmio_clk;
  wire io_hdmio_de;
  wire io_hdmio_hsync;
  wire io_hdmio_spdif;
  wire [15:0]io_hdmio_video;
  wire io_hdmio_vsync;
  wire io_vita_clk_out_n;
  wire io_vita_clk_out_p;
  wire io_vita_clk_pll;
  wire [7:0]io_vita_data_n;
  wire [7:0]io_vita_data_p;
  wire [1:0]io_vita_monitor;
  wire io_vita_reset_n;
  wire io_vita_spi_miso;
  wire io_vita_spi_mosi;
  wire io_vita_spi_sclk;
  wire io_vita_spi_ssel_n;
  wire io_vita_sync_n;
  wire io_vita_sync_p;
  wire [2:0]io_vita_trigger;

design_1 design_1_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .clk_in1(clk_in1),
        .iic_main_scl_i(iic_main_scl_i),
        .iic_main_scl_o(iic_main_scl_o),
        .iic_main_scl_t(iic_main_scl_t),
        .iic_main_sda_i(iic_main_sda_i),
        .iic_main_sda_o(iic_main_sda_o),
        .iic_main_sda_t(iic_main_sda_t),
        .iic_rst(iic_rst),
        .iic_scl_i(iic_scl_i),
        .iic_scl_o(iic_scl_o),
        .iic_scl_t(iic_scl_t),
        .iic_sda_i(iic_sda_i),
        .iic_sda_o(iic_sda_o),
        .iic_sda_t(iic_sda_t),
        .io_hdmio_clk(io_hdmio_clk),
        .io_hdmio_de(io_hdmio_de),
        .io_hdmio_hsync(io_hdmio_hsync),
        .io_hdmio_spdif(io_hdmio_spdif),
        .io_hdmio_video(io_hdmio_video),
        .io_hdmio_vsync(io_hdmio_vsync),
        .io_vita_clk_out_n(io_vita_clk_out_n),
        .io_vita_clk_out_p(io_vita_clk_out_p),
        .io_vita_clk_pll(io_vita_clk_pll),
        .io_vita_data_n(io_vita_data_n),
        .io_vita_data_p(io_vita_data_p),
        .io_vita_monitor(io_vita_monitor),
        .io_vita_reset_n(io_vita_reset_n),
        .io_vita_spi_miso(io_vita_spi_miso),
        .io_vita_spi_mosi(io_vita_spi_mosi),
        .io_vita_spi_sclk(io_vita_spi_sclk),
        .io_vita_spi_ssel_n(io_vita_spi_ssel_n),
        .io_vita_sync_n(io_vita_sync_n),
        .io_vita_sync_p(io_vita_sync_p),
        .io_vita_trigger(io_vita_trigger));
IOBUF iic_main_scl_iobuf
       (.I(iic_main_scl_o),
        .IO(iic_main_scl_io),
        .O(iic_main_scl_i),
        .T(iic_main_scl_t));
IOBUF iic_main_sda_iobuf
       (.I(iic_main_sda_o),
        .IO(iic_main_sda_io),
        .O(iic_main_sda_i),
        .T(iic_main_sda_t));
IOBUF iic_scl_iobuf
       (.I(iic_scl_o),
        .IO(iic_scl_io),
        .O(iic_scl_i),
        .T(iic_scl_t));
IOBUF iic_sda_iobuf
       (.I(iic_sda_o),
        .IO(iic_sda_io),
        .O(iic_sda_i),
        .T(iic_sda_t));
endmodule
