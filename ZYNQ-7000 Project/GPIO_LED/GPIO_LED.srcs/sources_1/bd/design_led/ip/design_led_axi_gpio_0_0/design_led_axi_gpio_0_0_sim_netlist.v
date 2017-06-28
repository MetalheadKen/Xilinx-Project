// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Thu Oct 20 18:11:37 2016
// Host        : user-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               d:/Xilinx_Project/GPIO_LED/GPIO_LED.srcs/sources_1/bd/design_led/ip/design_led_axi_gpio_0_0/design_led_axi_gpio_0_0_sim_netlist.v
// Design      : design_led_axi_gpio_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_led_axi_gpio_0_0,axi_gpio,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "axi_gpio,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module design_led_axi_gpio_0_0
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    gpio_io_o);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK" *) input s_axi_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST" *) input s_axi_aresetn;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) input [8:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) input [8:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) input s_axi_rready;
  (* x_interface_info = "xilinx.com:interface:gpio:1.0 GPIO TRI_O" *) output [7:0]gpio_io_o;

  wire [7:0]gpio_io_o;
  wire s_axi_aclk;
  wire [8:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [8:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire NLW_U0_ip2intc_irpt_UNCONNECTED;
  wire [31:0]NLW_U0_gpio2_io_o_UNCONNECTED;
  wire [31:0]NLW_U0_gpio2_io_t_UNCONNECTED;
  wire [7:0]NLW_U0_gpio_io_t_UNCONNECTED;

  (* C_ALL_INPUTS = "0" *) 
  (* C_ALL_INPUTS_2 = "0" *) 
  (* C_ALL_OUTPUTS = "1" *) 
  (* C_ALL_OUTPUTS_2 = "0" *) 
  (* C_DOUT_DEFAULT = "0" *) 
  (* C_DOUT_DEFAULT_2 = "0" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_GPIO2_WIDTH = "32" *) 
  (* C_GPIO_WIDTH = "8" *) 
  (* C_INTERRUPT_PRESENT = "0" *) 
  (* C_IS_DUAL = "0" *) 
  (* C_S_AXI_ADDR_WIDTH = "9" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_TRI_DEFAULT = "-1" *) 
  (* C_TRI_DEFAULT_2 = "-1" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* ip_group = "LOGICORE" *) 
  design_led_axi_gpio_0_0_axi_gpio U0
       (.gpio2_io_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gpio2_io_o(NLW_U0_gpio2_io_o_UNCONNECTED[31:0]),
        .gpio2_io_t(NLW_U0_gpio2_io_t_UNCONNECTED[31:0]),
        .gpio_io_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gpio_io_o(gpio_io_o),
        .gpio_io_t(NLW_U0_gpio_io_t_UNCONNECTED[7:0]),
        .ip2intc_irpt(NLW_U0_ip2intc_irpt_UNCONNECTED),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "GPIO_Core" *) 
module design_led_axi_gpio_0_0_GPIO_Core
   (D,
    GPIO_xferAck_i,
    gpio_xferAck_Reg,
    ip2bus_rdack_i,
    ip2bus_wrack_i_D1_reg,
    gpio_io_o,
    gpio_io_t,
    Q,
    bus2ip_rnw_i_reg,
    \Not_Dual.gpio_Data_In_reg[7]_0 ,
    s_axi_aclk,
    \Not_Dual.gpio_Data_In_reg[6]_0 ,
    \Not_Dual.gpio_Data_In_reg[5]_0 ,
    \Not_Dual.gpio_Data_In_reg[4]_0 ,
    \Not_Dual.gpio_Data_In_reg[3]_0 ,
    \Not_Dual.gpio_Data_In_reg[2]_0 ,
    \Not_Dual.gpio_Data_In_reg[1]_0 ,
    GPIO_DBus_i,
    SS,
    bus2ip_rnw,
    bus2ip_cs,
    gpio_io_i,
    E,
    \MEM_DECODE_GEN[0].cs_out_i_reg[0] ,
    rst_reg);
  output [7:0]D;
  output GPIO_xferAck_i;
  output gpio_xferAck_Reg;
  output ip2bus_rdack_i;
  output ip2bus_wrack_i_D1_reg;
  output [7:0]gpio_io_o;
  output [7:0]gpio_io_t;
  output [7:0]Q;
  input bus2ip_rnw_i_reg;
  input \Not_Dual.gpio_Data_In_reg[7]_0 ;
  input s_axi_aclk;
  input \Not_Dual.gpio_Data_In_reg[6]_0 ;
  input \Not_Dual.gpio_Data_In_reg[5]_0 ;
  input \Not_Dual.gpio_Data_In_reg[4]_0 ;
  input \Not_Dual.gpio_Data_In_reg[3]_0 ;
  input \Not_Dual.gpio_Data_In_reg[2]_0 ;
  input \Not_Dual.gpio_Data_In_reg[1]_0 ;
  input [0:0]GPIO_DBus_i;
  input [0:0]SS;
  input bus2ip_rnw;
  input bus2ip_cs;
  input [7:0]gpio_io_i;
  input [0:0]E;
  input [7:0]\MEM_DECODE_GEN[0].cs_out_i_reg[0] ;
  input [0:0]rst_reg;

  wire [7:0]D;
  wire [0:0]E;
  wire [0:0]GPIO_DBus_i;
  wire GPIO_xferAck_i;
  wire [7:0]\MEM_DECODE_GEN[0].cs_out_i_reg[0] ;
  wire \Not_Dual.gpio_Data_In_reg[1]_0 ;
  wire \Not_Dual.gpio_Data_In_reg[2]_0 ;
  wire \Not_Dual.gpio_Data_In_reg[3]_0 ;
  wire \Not_Dual.gpio_Data_In_reg[4]_0 ;
  wire \Not_Dual.gpio_Data_In_reg[5]_0 ;
  wire \Not_Dual.gpio_Data_In_reg[6]_0 ;
  wire \Not_Dual.gpio_Data_In_reg[7]_0 ;
  wire [7:0]Q;
  wire [0:0]SS;
  wire bus2ip_cs;
  wire bus2ip_rnw;
  wire bus2ip_rnw_i_reg;
  wire [7:0]gpio_io_i;
  wire [0:7]gpio_io_i_d2;
  wire [7:0]gpio_io_o;
  wire [7:0]gpio_io_t;
  wire gpio_xferAck_Reg;
  wire iGPIO_xferAck;
  wire ip2bus_rdack_i;
  wire ip2bus_wrack_i_D1_reg;
  wire [0:0]rst_reg;
  wire s_axi_aclk;

  design_led_axi_gpio_0_0_cdc_sync \Not_Dual.INPUT_DOUBLE_REGS3 
       (.gpio_io_i(gpio_io_i),
        .s_axi_aclk(s_axi_aclk),
        .scndry_vect_out({gpio_io_i_d2[0],gpio_io_i_d2[1],gpio_io_i_d2[2],gpio_io_i_d2[3],gpio_io_i_d2[4],gpio_io_i_d2[5],gpio_io_i_d2[6],gpio_io_i_d2[7]}));
  FDRE \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(GPIO_DBus_i),
        .Q(D[7]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\Not_Dual.gpio_Data_In_reg[1]_0 ),
        .Q(D[6]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\Not_Dual.gpio_Data_In_reg[2]_0 ),
        .Q(D[5]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\Not_Dual.gpio_Data_In_reg[3]_0 ),
        .Q(D[4]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\Not_Dual.gpio_Data_In_reg[4]_0 ),
        .Q(D[3]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\Not_Dual.gpio_Data_In_reg[5]_0 ),
        .Q(D[2]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\Not_Dual.gpio_Data_In_reg[6]_0 ),
        .Q(D[1]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\Not_Dual.gpio_Data_In_reg[7]_0 ),
        .Q(D[0]),
        .R(bus2ip_rnw_i_reg));
  FDRE \Not_Dual.gpio_Data_In_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[0]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE \Not_Dual.gpio_Data_In_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[1]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE \Not_Dual.gpio_Data_In_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[2]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE \Not_Dual.gpio_Data_In_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[3]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE \Not_Dual.gpio_Data_In_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[4]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE \Not_Dual.gpio_Data_In_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[5]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE \Not_Dual.gpio_Data_In_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[6]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE \Not_Dual.gpio_Data_In_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i_d2[7]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[0] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [7]),
        .Q(gpio_io_o[7]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[1] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [6]),
        .Q(gpio_io_o[6]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[2] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [5]),
        .Q(gpio_io_o[5]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[3] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [4]),
        .Q(gpio_io_o[4]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[4] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [3]),
        .Q(gpio_io_o[3]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[5] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [2]),
        .Q(gpio_io_o[2]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[6] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [1]),
        .Q(gpio_io_o[1]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \Not_Dual.gpio_Data_Out_reg[7] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [0]),
        .Q(gpio_io_o[0]),
        .R(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[0] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [7]),
        .Q(gpio_io_t[7]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[1] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [6]),
        .Q(gpio_io_t[6]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[2] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [5]),
        .Q(gpio_io_t[5]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[3] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [4]),
        .Q(gpio_io_t[4]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[4] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [3]),
        .Q(gpio_io_t[3]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[5] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [2]),
        .Q(gpio_io_t[2]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[6] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [1]),
        .Q(gpio_io_t[1]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \Not_Dual.gpio_OE_reg[7] 
       (.C(s_axi_aclk),
        .CE(rst_reg),
        .D(\MEM_DECODE_GEN[0].cs_out_i_reg[0] [0]),
        .Q(gpio_io_t[0]),
        .S(SS));
  FDRE gpio_xferAck_Reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(GPIO_xferAck_i),
        .Q(gpio_xferAck_Reg),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h02)) 
    iGPIO_xferAck_i_1
       (.I0(bus2ip_cs),
        .I1(gpio_xferAck_Reg),
        .I2(GPIO_xferAck_i),
        .O(iGPIO_xferAck));
  FDRE iGPIO_xferAck_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(iGPIO_xferAck),
        .Q(GPIO_xferAck_i),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h8)) 
    ip2bus_rdack_i_D1_i_1
       (.I0(GPIO_xferAck_i),
        .I1(bus2ip_rnw),
        .O(ip2bus_rdack_i));
  LUT2 #(
    .INIT(4'h2)) 
    ip2bus_wrack_i_D1_i_1
       (.I0(GPIO_xferAck_i),
        .I1(bus2ip_rnw),
        .O(ip2bus_wrack_i_D1_reg));
endmodule

(* ORIG_REF_NAME = "address_decoder" *) 
module design_led_axi_gpio_0_0_address_decoder
   (\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ,
    E,
    \Not_Dual.gpio_OE_reg[0] ,
    s_axi_arready,
    s_axi_wready,
    GPIO_DBus_i,
    \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ,
    \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ,
    \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ,
    \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ,
    \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ,
    \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ,
    \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ,
    D,
    \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ,
    s_axi_aclk,
    rst_reg,
    bus2ip_rnw_i_reg,
    Q,
    ip2bus_rdack_i_D1,
    is_read,
    \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] ,
    ip2bus_wrack_i_D1,
    is_write_reg,
    \Not_Dual.gpio_Data_In_reg[0] ,
    gpio_io_t,
    s_axi_wdata,
    start2_reg,
    s_axi_aresetn,
    gpio_xferAck_Reg,
    GPIO_xferAck_i);
  output \MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ;
  output [0:0]E;
  output [0:0]\Not_Dual.gpio_OE_reg[0] ;
  output s_axi_arready;
  output s_axi_wready;
  output [0:0]GPIO_DBus_i;
  output \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ;
  output \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ;
  output \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ;
  output \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ;
  output \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ;
  output \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ;
  output \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ;
  output [7:0]D;
  output \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ;
  input s_axi_aclk;
  input rst_reg;
  input bus2ip_rnw_i_reg;
  input [2:0]Q;
  input ip2bus_rdack_i_D1;
  input is_read;
  input [3:0]\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] ;
  input ip2bus_wrack_i_D1;
  input is_write_reg;
  input [7:0]\Not_Dual.gpio_Data_In_reg[0] ;
  input [7:0]gpio_io_t;
  input [15:0]s_axi_wdata;
  input start2_reg;
  input s_axi_aresetn;
  input gpio_xferAck_Reg;
  input GPIO_xferAck_i;

  wire [7:0]D;
  wire [0:0]E;
  wire [0:0]GPIO_DBus_i;
  wire GPIO_xferAck_i;
  wire [3:0]\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] ;
  wire \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0 ;
  wire \MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ;
  wire \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ;
  wire \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ;
  wire \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ;
  wire \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ;
  wire \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ;
  wire \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ;
  wire \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ;
  wire \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ;
  wire [7:0]\Not_Dual.gpio_Data_In_reg[0] ;
  wire [0:0]\Not_Dual.gpio_OE_reg[0] ;
  wire [2:0]Q;
  wire bus2ip_rnw_i_reg;
  wire [7:0]gpio_io_t;
  wire gpio_xferAck_Reg;
  wire ip2bus_rdack_i_D1;
  wire ip2bus_wrack_i_D1;
  wire is_read;
  wire is_write_reg;
  wire rst_reg;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire [15:0]s_axi_wdata;
  wire s_axi_wready;
  wire start2_reg;

  LUT5 #(
    .INIT(32'h000000E0)) 
    \MEM_DECODE_GEN[0].cs_out_i[0]_i_1 
       (.I0(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I1(start2_reg),
        .I2(s_axi_aresetn),
        .I3(s_axi_arready),
        .I4(s_axi_wready),
        .O(\MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0 ));
  FDRE \MEM_DECODE_GEN[0].cs_out_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0 ),
        .Q(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i[24]_i_1 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [7]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[7]),
        .O(GPIO_DBus_i));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i[25]_i_1 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [6]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[6]),
        .O(\Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i[26]_i_1 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [5]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[5]),
        .O(\Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i[27]_i_1 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [4]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[4]),
        .O(\Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i[28]_i_1 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [3]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[3]),
        .O(\Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i[29]_i_1 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [2]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[2]),
        .O(\Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i[30]_i_1 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [1]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[1]),
        .O(\Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ));
  LUT4 #(
    .INIT(16'hFFF7)) 
    \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i[31]_i_1 
       (.I0(bus2ip_rnw_i_reg),
        .I1(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I2(gpio_xferAck_Reg),
        .I3(GPIO_xferAck_i),
        .O(\Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ));
  LUT6 #(
    .INIT(64'h000000E000000020)) 
    \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i[31]_i_2 
       (.I0(\Not_Dual.gpio_Data_In_reg[0] [0]),
        .I1(Q[0]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(gpio_io_t[0]),
        .O(\Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAABAA)) 
    \Not_Dual.gpio_Data_Out[0]_i_1 
       (.I0(rst_reg),
        .I1(bus2ip_rnw_i_reg),
        .I2(Q[0]),
        .I3(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I4(Q[2]),
        .I5(Q[1]),
        .O(E));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[0]_i_2 
       (.I0(s_axi_wdata[7]),
        .I1(s_axi_wdata[15]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[7]));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[1]_i_1 
       (.I0(s_axi_wdata[6]),
        .I1(s_axi_wdata[14]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[6]));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[2]_i_1 
       (.I0(s_axi_wdata[5]),
        .I1(s_axi_wdata[13]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[5]));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[3]_i_1 
       (.I0(s_axi_wdata[4]),
        .I1(s_axi_wdata[12]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[4]));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[4]_i_1 
       (.I0(s_axi_wdata[3]),
        .I1(s_axi_wdata[11]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[3]));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[5]_i_1 
       (.I0(s_axi_wdata[2]),
        .I1(s_axi_wdata[10]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[2]));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[6]_i_1 
       (.I0(s_axi_wdata[1]),
        .I1(s_axi_wdata[9]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[1]));
  LUT4 #(
    .INIT(16'hCCAC)) 
    \Not_Dual.gpio_Data_Out[7]_i_1 
       (.I0(s_axi_wdata[0]),
        .I1(s_axi_wdata[8]),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[1]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAABAAAAA)) 
    \Not_Dual.gpio_OE[0]_i_1 
       (.I0(rst_reg),
        .I1(bus2ip_rnw_i_reg),
        .I2(\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 ),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(\Not_Dual.gpio_OE_reg[0] ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAEAAAA)) 
    s_axi_arready_INST_0
       (.I0(ip2bus_rdack_i_D1),
        .I1(is_read),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [2]),
        .I3(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [1]),
        .I4(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [3]),
        .I5(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [0]),
        .O(s_axi_arready));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAEAAAA)) 
    s_axi_wready_INST_0
       (.I0(ip2bus_wrack_i_D1),
        .I1(is_write_reg),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [2]),
        .I3(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [1]),
        .I4(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [3]),
        .I5(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] [0]),
        .O(s_axi_wready));
endmodule

(* C_ALL_INPUTS = "0" *) (* C_ALL_INPUTS_2 = "0" *) (* C_ALL_OUTPUTS = "1" *) 
(* C_ALL_OUTPUTS_2 = "0" *) (* C_DOUT_DEFAULT = "0" *) (* C_DOUT_DEFAULT_2 = "0" *) 
(* C_FAMILY = "zynq" *) (* C_GPIO2_WIDTH = "32" *) (* C_GPIO_WIDTH = "8" *) 
(* C_INTERRUPT_PRESENT = "0" *) (* C_IS_DUAL = "0" *) (* C_S_AXI_ADDR_WIDTH = "9" *) 
(* C_S_AXI_DATA_WIDTH = "32" *) (* C_TRI_DEFAULT = "-1" *) (* C_TRI_DEFAULT_2 = "-1" *) 
(* ORIG_REF_NAME = "axi_gpio" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_group = "LOGICORE" *) 
module design_led_axi_gpio_0_0_axi_gpio
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    ip2intc_irpt,
    gpio_io_i,
    gpio_io_o,
    gpio_io_t,
    gpio2_io_i,
    gpio2_io_o,
    gpio2_io_t);
  (* max_fanout = "10000" *) (* sigis = "Clk" *) input s_axi_aclk;
  (* max_fanout = "10000" *) (* sigis = "Rst" *) input s_axi_aresetn;
  input [8:0]s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [8:0]s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  (* sigis = "INTR_LEVEL_HIGH" *) output ip2intc_irpt;
  input [7:0]gpio_io_i;
  output [7:0]gpio_io_o;
  output [7:0]gpio_io_t;
  input [31:0]gpio2_io_i;
  output [31:0]gpio2_io_o;
  output [31:0]gpio2_io_t;

  wire \<const0> ;
  wire \<const1> ;
  wire AXI_LITE_IPIF_I_n_10;
  wire AXI_LITE_IPIF_I_n_11;
  wire AXI_LITE_IPIF_I_n_12;
  wire AXI_LITE_IPIF_I_n_13;
  wire AXI_LITE_IPIF_I_n_14;
  wire AXI_LITE_IPIF_I_n_15;
  wire AXI_LITE_IPIF_I_n_16;
  wire AXI_LITE_IPIF_I_n_25;
  wire AXI_LITE_IPIF_I_n_6;
  wire AXI_LITE_IPIF_I_n_7;
  wire [0:7]DBus_Reg;
  wire [24:24]GPIO_DBus_i;
  wire GPIO_xferAck_i;
  wire bus2ip_cs;
  wire bus2ip_reset;
  wire bus2ip_rnw;
  wire [0:7]gpio_Data_In;
  wire gpio_core_1_n_11;
  wire [7:0]gpio_io_i;
  wire [7:0]gpio_io_o;
  wire [7:0]gpio_io_t;
  wire gpio_xferAck_Reg;
  wire [24:31]ip2bus_data;
  wire [24:31]ip2bus_data_i_D1;
  wire ip2bus_rdack_i;
  wire ip2bus_rdack_i_D1;
  wire ip2bus_wrack_i_D1;
  (* MAX_FANOUT = "10000" *) (* RTL_MAX_FANOUT = "found" *) (* sigis = "Clk" *) wire s_axi_aclk;
  wire [8:0]s_axi_araddr;
  (* MAX_FANOUT = "10000" *) (* RTL_MAX_FANOUT = "found" *) (* sigis = "Rst" *) wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [8:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [7:0]\^s_axi_rdata ;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire s_axi_wvalid;

  assign gpio2_io_o[31] = \<const0> ;
  assign gpio2_io_o[30] = \<const0> ;
  assign gpio2_io_o[29] = \<const0> ;
  assign gpio2_io_o[28] = \<const0> ;
  assign gpio2_io_o[27] = \<const0> ;
  assign gpio2_io_o[26] = \<const0> ;
  assign gpio2_io_o[25] = \<const0> ;
  assign gpio2_io_o[24] = \<const0> ;
  assign gpio2_io_o[23] = \<const0> ;
  assign gpio2_io_o[22] = \<const0> ;
  assign gpio2_io_o[21] = \<const0> ;
  assign gpio2_io_o[20] = \<const0> ;
  assign gpio2_io_o[19] = \<const0> ;
  assign gpio2_io_o[18] = \<const0> ;
  assign gpio2_io_o[17] = \<const0> ;
  assign gpio2_io_o[16] = \<const0> ;
  assign gpio2_io_o[15] = \<const0> ;
  assign gpio2_io_o[14] = \<const0> ;
  assign gpio2_io_o[13] = \<const0> ;
  assign gpio2_io_o[12] = \<const0> ;
  assign gpio2_io_o[11] = \<const0> ;
  assign gpio2_io_o[10] = \<const0> ;
  assign gpio2_io_o[9] = \<const0> ;
  assign gpio2_io_o[8] = \<const0> ;
  assign gpio2_io_o[7] = \<const0> ;
  assign gpio2_io_o[6] = \<const0> ;
  assign gpio2_io_o[5] = \<const0> ;
  assign gpio2_io_o[4] = \<const0> ;
  assign gpio2_io_o[3] = \<const0> ;
  assign gpio2_io_o[2] = \<const0> ;
  assign gpio2_io_o[1] = \<const0> ;
  assign gpio2_io_o[0] = \<const0> ;
  assign gpio2_io_t[31] = \<const1> ;
  assign gpio2_io_t[30] = \<const1> ;
  assign gpio2_io_t[29] = \<const1> ;
  assign gpio2_io_t[28] = \<const1> ;
  assign gpio2_io_t[27] = \<const1> ;
  assign gpio2_io_t[26] = \<const1> ;
  assign gpio2_io_t[25] = \<const1> ;
  assign gpio2_io_t[24] = \<const1> ;
  assign gpio2_io_t[23] = \<const1> ;
  assign gpio2_io_t[22] = \<const1> ;
  assign gpio2_io_t[21] = \<const1> ;
  assign gpio2_io_t[20] = \<const1> ;
  assign gpio2_io_t[19] = \<const1> ;
  assign gpio2_io_t[18] = \<const1> ;
  assign gpio2_io_t[17] = \<const1> ;
  assign gpio2_io_t[16] = \<const1> ;
  assign gpio2_io_t[15] = \<const1> ;
  assign gpio2_io_t[14] = \<const1> ;
  assign gpio2_io_t[13] = \<const1> ;
  assign gpio2_io_t[12] = \<const1> ;
  assign gpio2_io_t[11] = \<const1> ;
  assign gpio2_io_t[10] = \<const1> ;
  assign gpio2_io_t[9] = \<const1> ;
  assign gpio2_io_t[8] = \<const1> ;
  assign gpio2_io_t[7] = \<const1> ;
  assign gpio2_io_t[6] = \<const1> ;
  assign gpio2_io_t[5] = \<const1> ;
  assign gpio2_io_t[4] = \<const1> ;
  assign gpio2_io_t[3] = \<const1> ;
  assign gpio2_io_t[2] = \<const1> ;
  assign gpio2_io_t[1] = \<const1> ;
  assign gpio2_io_t[0] = \<const1> ;
  assign ip2intc_irpt = \<const0> ;
  assign s_axi_awready = s_axi_wready;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7:0] = \^s_axi_rdata [7:0];
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  design_led_axi_gpio_0_0_axi_lite_ipif AXI_LITE_IPIF_I
       (.D({DBus_Reg[0],DBus_Reg[1],DBus_Reg[2],DBus_Reg[3],DBus_Reg[4],DBus_Reg[5],DBus_Reg[6],DBus_Reg[7]}),
        .E(AXI_LITE_IPIF_I_n_6),
        .GPIO_DBus_i(GPIO_DBus_i),
        .GPIO_xferAck_i(GPIO_xferAck_i),
        .\Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] (AXI_LITE_IPIF_I_n_25),
        .\Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] (AXI_LITE_IPIF_I_n_10),
        .\Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] (AXI_LITE_IPIF_I_n_11),
        .\Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] (AXI_LITE_IPIF_I_n_12),
        .\Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] (AXI_LITE_IPIF_I_n_13),
        .\Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] (AXI_LITE_IPIF_I_n_14),
        .\Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] (AXI_LITE_IPIF_I_n_15),
        .\Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] (AXI_LITE_IPIF_I_n_16),
        .\Not_Dual.gpio_OE_reg[0] (AXI_LITE_IPIF_I_n_7),
        .Q({gpio_Data_In[0],gpio_Data_In[1],gpio_Data_In[2],gpio_Data_In[3],gpio_Data_In[4],gpio_Data_In[5],gpio_Data_In[6],gpio_Data_In[7]}),
        .bus2ip_cs(bus2ip_cs),
        .bus2ip_reset(bus2ip_reset),
        .bus2ip_rnw(bus2ip_rnw),
        .gpio_io_t(gpio_io_t),
        .gpio_xferAck_Reg(gpio_xferAck_Reg),
        .\ip2bus_data_i_D1_reg[24] ({ip2bus_data_i_D1[24],ip2bus_data_i_D1[25],ip2bus_data_i_D1[26],ip2bus_data_i_D1[27],ip2bus_data_i_D1[28],ip2bus_data_i_D1[29],ip2bus_data_i_D1[30],ip2bus_data_i_D1[31]}),
        .ip2bus_rdack_i_D1(ip2bus_rdack_i_D1),
        .ip2bus_wrack_i_D1(ip2bus_wrack_i_D1),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr({s_axi_araddr[8],s_axi_araddr[3:2]}),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr({s_axi_awaddr[8],s_axi_awaddr[3:2]}),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(\^s_axi_rdata ),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata({s_axi_wdata[31:24],s_axi_wdata[7:0]}),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid));
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  design_led_axi_gpio_0_0_GPIO_Core gpio_core_1
       (.D({ip2bus_data[24],ip2bus_data[25],ip2bus_data[26],ip2bus_data[27],ip2bus_data[28],ip2bus_data[29],ip2bus_data[30],ip2bus_data[31]}),
        .E(AXI_LITE_IPIF_I_n_6),
        .GPIO_DBus_i(GPIO_DBus_i),
        .GPIO_xferAck_i(GPIO_xferAck_i),
        .\MEM_DECODE_GEN[0].cs_out_i_reg[0] ({DBus_Reg[0],DBus_Reg[1],DBus_Reg[2],DBus_Reg[3],DBus_Reg[4],DBus_Reg[5],DBus_Reg[6],DBus_Reg[7]}),
        .\Not_Dual.gpio_Data_In_reg[1]_0 (AXI_LITE_IPIF_I_n_10),
        .\Not_Dual.gpio_Data_In_reg[2]_0 (AXI_LITE_IPIF_I_n_11),
        .\Not_Dual.gpio_Data_In_reg[3]_0 (AXI_LITE_IPIF_I_n_12),
        .\Not_Dual.gpio_Data_In_reg[4]_0 (AXI_LITE_IPIF_I_n_13),
        .\Not_Dual.gpio_Data_In_reg[5]_0 (AXI_LITE_IPIF_I_n_14),
        .\Not_Dual.gpio_Data_In_reg[6]_0 (AXI_LITE_IPIF_I_n_15),
        .\Not_Dual.gpio_Data_In_reg[7]_0 (AXI_LITE_IPIF_I_n_16),
        .Q({gpio_Data_In[0],gpio_Data_In[1],gpio_Data_In[2],gpio_Data_In[3],gpio_Data_In[4],gpio_Data_In[5],gpio_Data_In[6],gpio_Data_In[7]}),
        .SS(bus2ip_reset),
        .bus2ip_cs(bus2ip_cs),
        .bus2ip_rnw(bus2ip_rnw),
        .bus2ip_rnw_i_reg(AXI_LITE_IPIF_I_n_25),
        .gpio_io_i(gpio_io_i),
        .gpio_io_o(gpio_io_o),
        .gpio_io_t(gpio_io_t),
        .gpio_xferAck_Reg(gpio_xferAck_Reg),
        .ip2bus_rdack_i(ip2bus_rdack_i),
        .ip2bus_wrack_i_D1_reg(gpio_core_1_n_11),
        .rst_reg(AXI_LITE_IPIF_I_n_7),
        .s_axi_aclk(s_axi_aclk));
  FDRE \ip2bus_data_i_D1_reg[24] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[24]),
        .Q(ip2bus_data_i_D1[24]),
        .R(bus2ip_reset));
  FDRE \ip2bus_data_i_D1_reg[25] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[25]),
        .Q(ip2bus_data_i_D1[25]),
        .R(bus2ip_reset));
  FDRE \ip2bus_data_i_D1_reg[26] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[26]),
        .Q(ip2bus_data_i_D1[26]),
        .R(bus2ip_reset));
  FDRE \ip2bus_data_i_D1_reg[27] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[27]),
        .Q(ip2bus_data_i_D1[27]),
        .R(bus2ip_reset));
  FDRE \ip2bus_data_i_D1_reg[28] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[28]),
        .Q(ip2bus_data_i_D1[28]),
        .R(bus2ip_reset));
  FDRE \ip2bus_data_i_D1_reg[29] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[29]),
        .Q(ip2bus_data_i_D1[29]),
        .R(bus2ip_reset));
  FDRE \ip2bus_data_i_D1_reg[30] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[30]),
        .Q(ip2bus_data_i_D1[30]),
        .R(bus2ip_reset));
  FDRE \ip2bus_data_i_D1_reg[31] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[31]),
        .Q(ip2bus_data_i_D1[31]),
        .R(bus2ip_reset));
  FDRE ip2bus_rdack_i_D1_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_rdack_i),
        .Q(ip2bus_rdack_i_D1),
        .R(bus2ip_reset));
  FDRE ip2bus_wrack_i_D1_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_core_1_n_11),
        .Q(ip2bus_wrack_i_D1),
        .R(bus2ip_reset));
endmodule

(* ORIG_REF_NAME = "axi_lite_ipif" *) 
module design_led_axi_gpio_0_0_axi_lite_ipif
   (bus2ip_reset,
    bus2ip_rnw,
    bus2ip_cs,
    s_axi_rvalid,
    s_axi_bvalid,
    s_axi_arready,
    E,
    \Not_Dual.gpio_OE_reg[0] ,
    s_axi_wready,
    GPIO_DBus_i,
    \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ,
    \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ,
    \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ,
    \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ,
    \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ,
    \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ,
    \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ,
    D,
    \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ,
    s_axi_rdata,
    s_axi_aclk,
    s_axi_arvalid,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_araddr,
    s_axi_awaddr,
    s_axi_aresetn,
    s_axi_rready,
    s_axi_bready,
    ip2bus_rdack_i_D1,
    ip2bus_wrack_i_D1,
    Q,
    gpio_io_t,
    s_axi_wdata,
    gpio_xferAck_Reg,
    GPIO_xferAck_i,
    \ip2bus_data_i_D1_reg[24] );
  output bus2ip_reset;
  output bus2ip_rnw;
  output bus2ip_cs;
  output s_axi_rvalid;
  output s_axi_bvalid;
  output s_axi_arready;
  output [0:0]E;
  output [0:0]\Not_Dual.gpio_OE_reg[0] ;
  output s_axi_wready;
  output [0:0]GPIO_DBus_i;
  output \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ;
  output \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ;
  output \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ;
  output \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ;
  output \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ;
  output \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ;
  output \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ;
  output [7:0]D;
  output \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ;
  output [7:0]s_axi_rdata;
  input s_axi_aclk;
  input s_axi_arvalid;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input [2:0]s_axi_araddr;
  input [2:0]s_axi_awaddr;
  input s_axi_aresetn;
  input s_axi_rready;
  input s_axi_bready;
  input ip2bus_rdack_i_D1;
  input ip2bus_wrack_i_D1;
  input [7:0]Q;
  input [7:0]gpio_io_t;
  input [15:0]s_axi_wdata;
  input gpio_xferAck_Reg;
  input GPIO_xferAck_i;
  input [7:0]\ip2bus_data_i_D1_reg[24] ;

  wire [7:0]D;
  wire [0:0]E;
  wire [0:0]GPIO_DBus_i;
  wire GPIO_xferAck_i;
  wire \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ;
  wire \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ;
  wire \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ;
  wire \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ;
  wire \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ;
  wire \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ;
  wire \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ;
  wire \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ;
  wire [0:0]\Not_Dual.gpio_OE_reg[0] ;
  wire [7:0]Q;
  wire bus2ip_cs;
  wire bus2ip_reset;
  wire bus2ip_rnw;
  wire [7:0]gpio_io_t;
  wire gpio_xferAck_Reg;
  wire [7:0]\ip2bus_data_i_D1_reg[24] ;
  wire ip2bus_rdack_i_D1;
  wire ip2bus_wrack_i_D1;
  wire s_axi_aclk;
  wire [2:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [2:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [7:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [15:0]s_axi_wdata;
  wire s_axi_wready;
  wire s_axi_wvalid;

  design_led_axi_gpio_0_0_slave_attachment I_SLAVE_ATTACHMENT
       (.D(D),
        .E(E),
        .GPIO_DBus_i(GPIO_DBus_i),
        .GPIO_xferAck_i(GPIO_xferAck_i),
        .\MEM_DECODE_GEN[0].cs_out_i_reg[0] (bus2ip_cs),
        .\Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] (\Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ),
        .\Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] (\Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ),
        .\Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] (\Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ),
        .\Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] (\Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ),
        .\Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] (\Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ),
        .\Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] (\Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ),
        .\Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] (\Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ),
        .\Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] (\Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ),
        .\Not_Dual.gpio_Data_Out_reg[0] (bus2ip_rnw),
        .\Not_Dual.gpio_OE_reg[0] (\Not_Dual.gpio_OE_reg[0] ),
        .Q(Q),
        .SR(bus2ip_reset),
        .gpio_io_t(gpio_io_t),
        .gpio_xferAck_Reg(gpio_xferAck_Reg),
        .\ip2bus_data_i_D1_reg[24] (\ip2bus_data_i_D1_reg[24] ),
        .ip2bus_rdack_i_D1(ip2bus_rdack_i_D1),
        .ip2bus_wrack_i_D1(ip2bus_wrack_i_D1),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "cdc_sync" *) 
module design_led_axi_gpio_0_0_cdc_sync
   (scndry_vect_out,
    gpio_io_i,
    s_axi_aclk);
  output [7:0]scndry_vect_out;
  input [7:0]gpio_io_i;
  input s_axi_aclk;

  wire [7:0]gpio_io_i;
  wire s_axi_aclk;
  wire s_level_out_bus_d1_cdc_to_0;
  wire s_level_out_bus_d1_cdc_to_1;
  wire s_level_out_bus_d1_cdc_to_2;
  wire s_level_out_bus_d1_cdc_to_3;
  wire s_level_out_bus_d1_cdc_to_4;
  wire s_level_out_bus_d1_cdc_to_5;
  wire s_level_out_bus_d1_cdc_to_6;
  wire s_level_out_bus_d1_cdc_to_7;
  wire s_level_out_bus_d2_0;
  wire s_level_out_bus_d2_1;
  wire s_level_out_bus_d2_2;
  wire s_level_out_bus_d2_3;
  wire s_level_out_bus_d2_4;
  wire s_level_out_bus_d2_5;
  wire s_level_out_bus_d2_6;
  wire s_level_out_bus_d2_7;
  wire s_level_out_bus_d3_0;
  wire s_level_out_bus_d3_1;
  wire s_level_out_bus_d3_2;
  wire s_level_out_bus_d3_3;
  wire s_level_out_bus_d3_4;
  wire s_level_out_bus_d3_5;
  wire s_level_out_bus_d3_6;
  wire s_level_out_bus_d3_7;
  wire [7:0]scndry_vect_out;

  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_0),
        .Q(s_level_out_bus_d2_0),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_1),
        .Q(s_level_out_bus_d2_1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_2),
        .Q(s_level_out_bus_d2_2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_3),
        .Q(s_level_out_bus_d2_3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_4),
        .Q(s_level_out_bus_d2_4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_5),
        .Q(s_level_out_bus_d2_5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_6),
        .Q(s_level_out_bus_d2_6),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d1_cdc_to_7),
        .Q(s_level_out_bus_d2_7),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_0),
        .Q(s_level_out_bus_d3_0),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_1),
        .Q(s_level_out_bus_d3_1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_2),
        .Q(s_level_out_bus_d3_2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_3),
        .Q(s_level_out_bus_d3_3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_4),
        .Q(s_level_out_bus_d3_4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_5),
        .Q(s_level_out_bus_d3_5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_6),
        .Q(s_level_out_bus_d3_6),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d2_7),
        .Q(s_level_out_bus_d3_7),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_0),
        .Q(scndry_vect_out[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_1),
        .Q(scndry_vect_out[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_2),
        .Q(scndry_vect_out[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_3),
        .Q(scndry_vect_out[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_4),
        .Q(scndry_vect_out[4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_5),
        .Q(scndry_vect_out[5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_6),
        .Q(scndry_vect_out[6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_level_out_bus_d3_7),
        .Q(scndry_vect_out[7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[0].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[0]),
        .Q(s_level_out_bus_d1_cdc_to_0),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[1].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[1]),
        .Q(s_level_out_bus_d1_cdc_to_1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[2].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[2]),
        .Q(s_level_out_bus_d1_cdc_to_2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[3].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[3]),
        .Q(s_level_out_bus_d1_cdc_to_3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[4].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[4]),
        .Q(s_level_out_bus_d1_cdc_to_4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[5].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[5]),
        .Q(s_level_out_bus_d1_cdc_to_5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[6].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[6]),
        .Q(s_level_out_bus_d1_cdc_to_6),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[7].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(gpio_io_i[7]),
        .Q(s_level_out_bus_d1_cdc_to_7),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "slave_attachment" *) 
module design_led_axi_gpio_0_0_slave_attachment
   (SR,
    \Not_Dual.gpio_Data_Out_reg[0] ,
    \MEM_DECODE_GEN[0].cs_out_i_reg[0] ,
    s_axi_rvalid,
    s_axi_bvalid,
    s_axi_arready,
    E,
    \Not_Dual.gpio_OE_reg[0] ,
    s_axi_wready,
    GPIO_DBus_i,
    \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ,
    \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ,
    \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ,
    \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ,
    \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ,
    \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ,
    \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ,
    D,
    \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ,
    s_axi_rdata,
    s_axi_aclk,
    s_axi_arvalid,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_araddr,
    s_axi_awaddr,
    s_axi_aresetn,
    s_axi_rready,
    s_axi_bready,
    ip2bus_rdack_i_D1,
    ip2bus_wrack_i_D1,
    Q,
    gpio_io_t,
    s_axi_wdata,
    gpio_xferAck_Reg,
    GPIO_xferAck_i,
    \ip2bus_data_i_D1_reg[24] );
  output SR;
  output \Not_Dual.gpio_Data_Out_reg[0] ;
  output \MEM_DECODE_GEN[0].cs_out_i_reg[0] ;
  output s_axi_rvalid;
  output s_axi_bvalid;
  output s_axi_arready;
  output [0:0]E;
  output [0:0]\Not_Dual.gpio_OE_reg[0] ;
  output s_axi_wready;
  output [0:0]GPIO_DBus_i;
  output \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ;
  output \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ;
  output \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ;
  output \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ;
  output \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ;
  output \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ;
  output \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ;
  output [7:0]D;
  output \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ;
  output [7:0]s_axi_rdata;
  input s_axi_aclk;
  input s_axi_arvalid;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input [2:0]s_axi_araddr;
  input [2:0]s_axi_awaddr;
  input s_axi_aresetn;
  input s_axi_rready;
  input s_axi_bready;
  input ip2bus_rdack_i_D1;
  input ip2bus_wrack_i_D1;
  input [7:0]Q;
  input [7:0]gpio_io_t;
  input [15:0]s_axi_wdata;
  input gpio_xferAck_Reg;
  input GPIO_xferAck_i;
  input [7:0]\ip2bus_data_i_D1_reg[24] ;

  wire [7:0]D;
  wire [0:0]E;
  wire [0:0]GPIO_DBus_i;
  wire GPIO_xferAck_i;
  wire [3:0]\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 ;
  wire \MEM_DECODE_GEN[0].cs_out_i_reg[0] ;
  wire \Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ;
  wire \Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ;
  wire \Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ;
  wire \Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ;
  wire \Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ;
  wire \Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ;
  wire \Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ;
  wire \Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ;
  wire \Not_Dual.gpio_Data_Out_reg[0] ;
  wire [0:0]\Not_Dual.gpio_OE_reg[0] ;
  wire [7:0]Q;
  wire SR;
  wire [0:6]bus2ip_addr;
  wire \bus2ip_addr_i[2]_i_1_n_0 ;
  wire \bus2ip_addr_i[3]_i_1_n_0 ;
  wire \bus2ip_addr_i[8]_i_1_n_0 ;
  wire \bus2ip_addr_i[8]_i_2_n_0 ;
  wire bus2ip_rnw_i06_out;
  wire clear;
  wire [7:0]gpio_io_t;
  wire gpio_xferAck_Reg;
  wire [7:0]\ip2bus_data_i_D1_reg[24] ;
  wire ip2bus_rdack_i_D1;
  wire ip2bus_wrack_i_D1;
  wire is_read;
  wire is_read_i_1_n_0;
  wire is_write;
  wire is_write_i_1_n_0;
  wire is_write_reg_n_0;
  wire [1:0]p_0_out;
  wire p_1_in;
  wire [3:0]plusOp;
  wire s_axi_aclk;
  wire [2:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [2:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire s_axi_bvalid_i_i_1_n_0;
  wire [7:0]s_axi_rdata;
  wire \s_axi_rdata_i[7]_i_1_n_0 ;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire s_axi_rvalid_i_i_1_n_0;
  wire [15:0]s_axi_wdata;
  wire s_axi_wready;
  wire s_axi_wvalid;
  wire start2;
  wire start2_i_1_n_0;
  wire [1:0]state;
  wire state1__2;
  wire \state[1]_i_3_n_0 ;

  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[0]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [0]),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[1]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [0]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [1]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[2]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [0]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [1]),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [2]),
        .O(plusOp[2]));
  LUT2 #(
    .INIT(4'h9)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_1 
       (.I0(state[0]),
        .I1(state[1]),
        .O(clear));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_2 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [1]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [0]),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [2]),
        .I3(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [3]),
        .O(plusOp[3]));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[0]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [0]),
        .R(clear));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[1]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [1]),
        .R(clear));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[2]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [2]),
        .R(clear));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[3]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 [3]),
        .R(clear));
  design_led_axi_gpio_0_0_address_decoder I_DECODER
       (.D(D),
        .E(E),
        .GPIO_DBus_i(GPIO_DBus_i),
        .GPIO_xferAck_i(GPIO_xferAck_i),
        .\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] (\INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0 ),
        .\MEM_DECODE_GEN[0].cs_out_i_reg[0]_0 (\MEM_DECODE_GEN[0].cs_out_i_reg[0] ),
        .\Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] (\Not_Dual.READ_REG_GEN[0].GPIO_DBus_i_reg[24] ),
        .\Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] (\Not_Dual.READ_REG_GEN[1].GPIO_DBus_i_reg[25] ),
        .\Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] (\Not_Dual.READ_REG_GEN[2].GPIO_DBus_i_reg[26] ),
        .\Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] (\Not_Dual.READ_REG_GEN[3].GPIO_DBus_i_reg[27] ),
        .\Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] (\Not_Dual.READ_REG_GEN[4].GPIO_DBus_i_reg[28] ),
        .\Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] (\Not_Dual.READ_REG_GEN[5].GPIO_DBus_i_reg[29] ),
        .\Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] (\Not_Dual.READ_REG_GEN[6].GPIO_DBus_i_reg[30] ),
        .\Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] (\Not_Dual.READ_REG_GEN[7].GPIO_DBus_i_reg[31] ),
        .\Not_Dual.gpio_Data_In_reg[0] (Q),
        .\Not_Dual.gpio_OE_reg[0] (\Not_Dual.gpio_OE_reg[0] ),
        .Q({bus2ip_addr[0],bus2ip_addr[5],bus2ip_addr[6]}),
        .bus2ip_rnw_i_reg(\Not_Dual.gpio_Data_Out_reg[0] ),
        .gpio_io_t(gpio_io_t),
        .gpio_xferAck_Reg(gpio_xferAck_Reg),
        .ip2bus_rdack_i_D1(ip2bus_rdack_i_D1),
        .ip2bus_wrack_i_D1(ip2bus_wrack_i_D1),
        .is_read(is_read),
        .is_write_reg(is_write_reg_n_0),
        .rst_reg(SR),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .start2_reg(start2));
  LUT5 #(
    .INIT(32'hCCCACCCC)) 
    \bus2ip_addr_i[2]_i_1 
       (.I0(s_axi_araddr[0]),
        .I1(s_axi_awaddr[0]),
        .I2(state[0]),
        .I3(state[1]),
        .I4(s_axi_arvalid),
        .O(\bus2ip_addr_i[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hCCCACCCC)) 
    \bus2ip_addr_i[3]_i_1 
       (.I0(s_axi_araddr[1]),
        .I1(s_axi_awaddr[1]),
        .I2(state[0]),
        .I3(state[1]),
        .I4(s_axi_arvalid),
        .O(\bus2ip_addr_i[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h000000EA)) 
    \bus2ip_addr_i[8]_i_1 
       (.I0(s_axi_arvalid),
        .I1(s_axi_awvalid),
        .I2(s_axi_wvalid),
        .I3(state[1]),
        .I4(state[0]),
        .O(\bus2ip_addr_i[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hCCCACCCC)) 
    \bus2ip_addr_i[8]_i_2 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_awaddr[2]),
        .I2(state[0]),
        .I3(state[1]),
        .I4(s_axi_arvalid),
        .O(\bus2ip_addr_i[8]_i_2_n_0 ));
  FDRE \bus2ip_addr_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[8]_i_1_n_0 ),
        .D(\bus2ip_addr_i[2]_i_1_n_0 ),
        .Q(bus2ip_addr[6]),
        .R(SR));
  FDRE \bus2ip_addr_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[8]_i_1_n_0 ),
        .D(\bus2ip_addr_i[3]_i_1_n_0 ),
        .Q(bus2ip_addr[5]),
        .R(SR));
  FDRE \bus2ip_addr_i_reg[8] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[8]_i_1_n_0 ),
        .D(\bus2ip_addr_i[8]_i_2_n_0 ),
        .Q(bus2ip_addr[0]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h10)) 
    bus2ip_rnw_i_i_1
       (.I0(state[0]),
        .I1(state[1]),
        .I2(s_axi_arvalid),
        .O(bus2ip_rnw_i06_out));
  FDRE bus2ip_rnw_i_reg
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[8]_i_1_n_0 ),
        .D(bus2ip_rnw_i06_out),
        .Q(\Not_Dual.gpio_Data_Out_reg[0] ),
        .R(SR));
  LUT5 #(
    .INIT(32'h3FFA000A)) 
    is_read_i_1
       (.I0(s_axi_arvalid),
        .I1(state1__2),
        .I2(state[0]),
        .I3(state[1]),
        .I4(is_read),
        .O(is_read_i_1_n_0));
  FDRE is_read_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(is_read_i_1_n_0),
        .Q(is_read),
        .R(SR));
  LUT6 #(
    .INIT(64'h0040FFFF00400000)) 
    is_write_i_1
       (.I0(s_axi_arvalid),
        .I1(s_axi_awvalid),
        .I2(s_axi_wvalid),
        .I3(state[1]),
        .I4(is_write),
        .I5(is_write_reg_n_0),
        .O(is_write_i_1_n_0));
  LUT6 #(
    .INIT(64'hF88800000000FFFF)) 
    is_write_i_2
       (.I0(s_axi_rvalid),
        .I1(s_axi_rready),
        .I2(s_axi_bvalid),
        .I3(s_axi_bready),
        .I4(state[0]),
        .I5(state[1]),
        .O(is_write));
  FDRE is_write_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(is_write_i_1_n_0),
        .Q(is_write_reg_n_0),
        .R(SR));
  LUT1 #(
    .INIT(2'h1)) 
    rst_i_1
       (.I0(s_axi_aresetn),
        .O(p_1_in));
  FDRE rst_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_1_in),
        .Q(SR),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h08FF0808)) 
    s_axi_bvalid_i_i_1
       (.I0(s_axi_wready),
        .I1(state[1]),
        .I2(state[0]),
        .I3(s_axi_bready),
        .I4(s_axi_bvalid),
        .O(s_axi_bvalid_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    s_axi_bvalid_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_bvalid_i_i_1_n_0),
        .Q(s_axi_bvalid),
        .R(SR));
  LUT2 #(
    .INIT(4'h2)) 
    \s_axi_rdata_i[7]_i_1 
       (.I0(state[0]),
        .I1(state[1]),
        .O(\s_axi_rdata_i[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [0]),
        .Q(s_axi_rdata[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[1] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [1]),
        .Q(s_axi_rdata[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [2]),
        .Q(s_axi_rdata[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [3]),
        .Q(s_axi_rdata[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [4]),
        .Q(s_axi_rdata[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[5] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [5]),
        .Q(s_axi_rdata[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[6] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [6]),
        .Q(s_axi_rdata[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[7] 
       (.C(s_axi_aclk),
        .CE(\s_axi_rdata_i[7]_i_1_n_0 ),
        .D(\ip2bus_data_i_D1_reg[24] [7]),
        .Q(s_axi_rdata[7]),
        .R(SR));
  LUT5 #(
    .INIT(32'h08FF0808)) 
    s_axi_rvalid_i_i_1
       (.I0(s_axi_arready),
        .I1(state[0]),
        .I2(state[1]),
        .I3(s_axi_rready),
        .I4(s_axi_rvalid),
        .O(s_axi_rvalid_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    s_axi_rvalid_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_rvalid_i_i_1_n_0),
        .Q(s_axi_rvalid),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h000000F8)) 
    start2_i_1
       (.I0(s_axi_awvalid),
        .I1(s_axi_wvalid),
        .I2(s_axi_arvalid),
        .I3(state[1]),
        .I4(state[0]),
        .O(start2_i_1_n_0));
  FDRE start2_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(start2_i_1_n_0),
        .Q(start2),
        .R(SR));
  LUT5 #(
    .INIT(32'h77FC44FC)) 
    \state[0]_i_1 
       (.I0(state1__2),
        .I1(state[0]),
        .I2(s_axi_arvalid),
        .I3(state[1]),
        .I4(s_axi_wready),
        .O(p_0_out[0]));
  LUT5 #(
    .INIT(32'h5FFC50FC)) 
    \state[1]_i_1 
       (.I0(state1__2),
        .I1(\state[1]_i_3_n_0 ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(s_axi_arready),
        .O(p_0_out[1]));
  LUT4 #(
    .INIT(16'hF888)) 
    \state[1]_i_2 
       (.I0(s_axi_bready),
        .I1(s_axi_bvalid),
        .I2(s_axi_rready),
        .I3(s_axi_rvalid),
        .O(state1__2));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \state[1]_i_3 
       (.I0(s_axi_wvalid),
        .I1(s_axi_awvalid),
        .I2(s_axi_arvalid),
        .O(\state[1]_i_3_n_0 ));
  FDRE \state_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_out[0]),
        .Q(state[0]),
        .R(SR));
  FDRE \state_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_out[1]),
        .Q(state[1]),
        .R(SR));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
