library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity fmc1_imageon_hdmio_rgb_imp_1U767LV is
  port (
    axi4lite_aresetn : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi4lite_clk : in STD_LOGIC;
    axi4s_clk : in STD_LOGIC;
    hdmio_audio_spdif : in STD_LOGIC;
    hdmio_axi4s_video_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    hdmio_axi4s_video_tlast : in STD_LOGIC;
    hdmio_axi4s_video_tready : out STD_LOGIC;
    hdmio_axi4s_video_tuser : in STD_LOGIC;
    hdmio_axi4s_video_tvalid : in STD_LOGIC;
    hdmio_clk : in STD_LOGIC;
    hdmio_io_clk : out STD_LOGIC;
    hdmio_io_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    hdmio_io_spdif : out STD_LOGIC;
    video_vtiming_active_video : in STD_LOGIC;
    video_vtiming_hblank : in STD_LOGIC;
    video_vtiming_vblank : in STD_LOGIC;
    vtc_ctrl_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    vtc_ctrl_arready : out STD_LOGIC;
    vtc_ctrl_arvalid : in STD_LOGIC;
    vtc_ctrl_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    vtc_ctrl_awready : out STD_LOGIC;
    vtc_ctrl_awvalid : in STD_LOGIC;
    vtc_ctrl_bready : in STD_LOGIC;
    vtc_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vtc_ctrl_bvalid : out STD_LOGIC;
    vtc_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vtc_ctrl_rready : in STD_LOGIC;
    vtc_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vtc_ctrl_rvalid : out STD_LOGIC;
    vtc_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    vtc_ctrl_wready : out STD_LOGIC;
    vtc_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vtc_ctrl_wvalid : in STD_LOGIC
  );
end fmc1_imageon_hdmio_rgb_imp_1U767LV;

architecture STRUCTURE of fmc1_imageon_hdmio_rgb_imp_1U767LV is
  component tutorial_fmc_imageon_hdmi_out_0_0 is
  port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    oe : in STD_LOGIC;
    embed_syncs : in STD_LOGIC;
    audio_spdif : in STD_LOGIC;
    video_vblank : in STD_LOGIC;
    video_hblank : in STD_LOGIC;
    video_de : in STD_LOGIC;
    video_data : in STD_LOGIC_VECTOR ( 15 downto 0 );
    io_hdmio_spdif : out STD_LOGIC;
    io_hdmio_video : out STD_LOGIC_VECTOR ( 15 downto 0 );
    io_hdmio_clk : out STD_LOGIC
  );
  end component tutorial_fmc_imageon_hdmi_out_0_0;
  component tutorial_gnd_2 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_gnd_2;
  component tutorial_v_axi4s_vid_out_0_0 is
  port (
    aclk : in STD_LOGIC;
    rst : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    fid : in STD_LOGIC;
    vid_io_out_clk : in STD_LOGIC;
    vid_io_out_ce : in STD_LOGIC;
    vid_active_video : out STD_LOGIC;
    vid_vsync : out STD_LOGIC;
    vid_hsync : out STD_LOGIC;
    vid_vblank : out STD_LOGIC;
    vid_hblank : out STD_LOGIC;
    vid_field_id : out STD_LOGIC;
    vid_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    vtg_vsync : in STD_LOGIC;
    vtg_hsync : in STD_LOGIC;
    vtg_vblank : in STD_LOGIC;
    vtg_hblank : in STD_LOGIC;
    vtg_active_video : in STD_LOGIC;
    vtg_field_id : in STD_LOGIC;
    vtg_ce : out STD_LOGIC;
    locked : out STD_LOGIC;
    wr_error : out STD_LOGIC;
    empty : out STD_LOGIC
  );
  end component tutorial_v_axi4s_vid_out_0_0;
  component tutorial_v_cresample_0_0 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC
  );
  end component tutorial_v_cresample_0_0;
  component tutorial_v_rgb2ycrcb_0_0 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    s_axis_video_tuser_sof : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    m_axis_video_tuser_sof : out STD_LOGIC
  );
  end component tutorial_v_rgb2ycrcb_0_0;
  component tutorial_v_tc_0_0 is
  port (
    clk : in STD_LOGIC;
    clken : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aclken : in STD_LOGIC;
    det_clken : in STD_LOGIC;
    gen_clken : in STD_LOGIC;
    hblank_in : in STD_LOGIC;
    vblank_in : in STD_LOGIC;
    active_video_in : in STD_LOGIC;
    hsync_out : out STD_LOGIC;
    hblank_out : out STD_LOGIC;
    vsync_out : out STD_LOGIC;
    vblank_out : out STD_LOGIC;
    active_video_out : out STD_LOGIC;
    resetn : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    irq : out STD_LOGIC;
    fsync_in : in STD_LOGIC;
    fsync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_v_tc_0_0;
  component tutorial_vcc_3 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_vcc_3;
  signal Conn1_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_ARREADY : STD_LOGIC;
  signal Conn1_ARVALID : STD_LOGIC;
  signal Conn1_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_AWREADY : STD_LOGIC;
  signal Conn1_AWVALID : STD_LOGIC;
  signal Conn1_BREADY : STD_LOGIC;
  signal Conn1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_BVALID : STD_LOGIC;
  signal Conn1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_RREADY : STD_LOGIC;
  signal Conn1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_RVALID : STD_LOGIC;
  signal Conn1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_WREADY : STD_LOGIC;
  signal Conn1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_WVALID : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal clk_1 : STD_LOGIC;
  signal fmc_imageon_hdmi_in_0_audio_spdif : STD_LOGIC;
  signal fmc_imageon_hdmi_out_0_io_hdmio_CLK : STD_LOGIC;
  signal fmc_imageon_hdmi_out_0_io_hdmio_DATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal fmc_imageon_hdmi_out_0_io_hdmio_SPDIF : STD_LOGIC;
  signal gnd_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal hdmio_axi4s_video_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal hdmio_axi4s_video_1_TLAST : STD_LOGIC;
  signal hdmio_axi4s_video_1_TREADY : STD_LOGIC;
  signal hdmio_axi4s_video_1_TUSER : STD_LOGIC;
  signal hdmio_axi4s_video_1_TVALID : STD_LOGIC;
  signal processing_system7_0_fclk_clk1 : STD_LOGIC;
  signal s_axi_aclk_1 : STD_LOGIC;
  signal s_axi_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal v_axi4s_vid_out_0_vid_io_out_ACTIVE_VIDEO : STD_LOGIC;
  signal v_axi4s_vid_out_0_vid_io_out_DATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal v_axi4s_vid_out_0_vid_io_out_HBLANK : STD_LOGIC;
  signal v_axi4s_vid_out_0_vid_io_out_VBLANK : STD_LOGIC;
  signal v_axi4s_vid_out_0_vtg_ce : STD_LOGIC;
  signal v_cresample_0_video_out_TDATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal v_cresample_0_video_out_TLAST : STD_LOGIC;
  signal v_cresample_0_video_out_TREADY : STD_LOGIC;
  signal v_cresample_0_video_out_TUSER : STD_LOGIC;
  signal v_cresample_0_video_out_TVALID : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal v_rgb2ycrcb_0_video_out_TLAST : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TREADY : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TUSER : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TVALID : STD_LOGIC;
  signal v_tc_0_vtiming_out_ACTIVE_VIDEO : STD_LOGIC;
  signal v_tc_0_vtiming_out_HBLANK : STD_LOGIC;
  signal v_tc_0_vtiming_out_HSYNC : STD_LOGIC;
  signal v_tc_0_vtiming_out_VBLANK : STD_LOGIC;
  signal v_tc_0_vtiming_out_VSYNC : STD_LOGIC;
  signal vcc_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal video_vtiming_1_ACTIVE_VIDEO : STD_LOGIC;
  signal video_vtiming_1_HBLANK : STD_LOGIC;
  signal video_vtiming_1_VBLANK : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_locked_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_vid_field_id_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_vid_hsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_vid_vsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_wr_error_UNCONNECTED : STD_LOGIC;
  signal NLW_v_tc_0_irq_UNCONNECTED : STD_LOGIC;
  signal NLW_v_tc_0_fsync_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  Conn1_ARADDR(8 downto 0) <= vtc_ctrl_araddr(8 downto 0);
  Conn1_ARVALID <= vtc_ctrl_arvalid;
  Conn1_AWADDR(8 downto 0) <= vtc_ctrl_awaddr(8 downto 0);
  Conn1_AWVALID <= vtc_ctrl_awvalid;
  Conn1_BREADY <= vtc_ctrl_bready;
  Conn1_RREADY <= vtc_ctrl_rready;
  Conn1_WDATA(31 downto 0) <= vtc_ctrl_wdata(31 downto 0);
  Conn1_WSTRB(3 downto 0) <= vtc_ctrl_wstrb(3 downto 0);
  Conn1_WVALID <= vtc_ctrl_wvalid;
  clk_1 <= hdmio_clk;
  fmc_imageon_hdmi_in_0_audio_spdif <= hdmio_audio_spdif;
  hdmio_axi4s_video_1_TDATA(23 downto 0) <= hdmio_axi4s_video_tdata(23 downto 0);
  hdmio_axi4s_video_1_TLAST <= hdmio_axi4s_video_tlast;
  hdmio_axi4s_video_1_TUSER <= hdmio_axi4s_video_tuser;
  hdmio_axi4s_video_1_TVALID <= hdmio_axi4s_video_tvalid;
  hdmio_axi4s_video_tready <= hdmio_axi4s_video_1_TREADY;
  hdmio_io_clk <= fmc_imageon_hdmi_out_0_io_hdmio_CLK;
  hdmio_io_data(15 downto 0) <= fmc_imageon_hdmi_out_0_io_hdmio_DATA(15 downto 0);
  hdmio_io_spdif <= fmc_imageon_hdmi_out_0_io_hdmio_SPDIF;
  processing_system7_0_fclk_clk1 <= axi4s_clk;
  s_axi_aclk_1 <= axi4lite_clk;
  s_axi_aresetn_1(0) <= axi4lite_aresetn(0);
  video_vtiming_1_ACTIVE_VIDEO <= video_vtiming_active_video;
  video_vtiming_1_HBLANK <= video_vtiming_hblank;
  video_vtiming_1_VBLANK <= video_vtiming_vblank;
  vtc_ctrl_arready <= Conn1_ARREADY;
  vtc_ctrl_awready <= Conn1_AWREADY;
  vtc_ctrl_bresp(1 downto 0) <= Conn1_BRESP(1 downto 0);
  vtc_ctrl_bvalid <= Conn1_BVALID;
  vtc_ctrl_rdata(31 downto 0) <= Conn1_RDATA(31 downto 0);
  vtc_ctrl_rresp(1 downto 0) <= Conn1_RRESP(1 downto 0);
  vtc_ctrl_rvalid <= Conn1_RVALID;
  vtc_ctrl_wready <= Conn1_WREADY;
GND_1: unisim.vcomponents.GND
    port map (
      G => GND_2
    );
fmc_imageon_hdmi_out_0: component tutorial_fmc_imageon_hdmi_out_0_0
    port map (
      audio_spdif => fmc_imageon_hdmi_in_0_audio_spdif,
      clk => clk_1,
      embed_syncs => vcc_const(0),
      io_hdmio_clk => fmc_imageon_hdmi_out_0_io_hdmio_CLK,
      io_hdmio_spdif => fmc_imageon_hdmi_out_0_io_hdmio_SPDIF,
      io_hdmio_video(15 downto 0) => fmc_imageon_hdmi_out_0_io_hdmio_DATA(15 downto 0),
      oe => vcc_const(0),
      reset => gnd_const(0),
      video_data(15 downto 0) => v_axi4s_vid_out_0_vid_io_out_DATA(15 downto 0),
      video_de => v_axi4s_vid_out_0_vid_io_out_ACTIVE_VIDEO,
      video_hblank => v_axi4s_vid_out_0_vid_io_out_HBLANK,
      video_vblank => v_axi4s_vid_out_0_vid_io_out_VBLANK
    );
gnd: component tutorial_gnd_2
    port map (
      const(0) => gnd_const(0)
    );
v_axi4s_vid_out_0: component tutorial_v_axi4s_vid_out_0_0
    port map (
      aclk => processing_system7_0_fclk_clk1,
      aclken => vcc_const(0),
      aresetn => s_axi_aresetn_1(0),
      empty => NLW_v_axi4s_vid_out_0_empty_UNCONNECTED,
      fid => GND_2,
      locked => NLW_v_axi4s_vid_out_0_locked_UNCONNECTED,
      rst => gnd_const(0),
      s_axis_video_tdata(15 downto 0) => v_cresample_0_video_out_TDATA(15 downto 0),
      s_axis_video_tlast => v_cresample_0_video_out_TLAST,
      s_axis_video_tready => v_cresample_0_video_out_TREADY,
      s_axis_video_tuser => v_cresample_0_video_out_TUSER,
      s_axis_video_tvalid => v_cresample_0_video_out_TVALID,
      vid_active_video => v_axi4s_vid_out_0_vid_io_out_ACTIVE_VIDEO,
      vid_data(15 downto 0) => v_axi4s_vid_out_0_vid_io_out_DATA(15 downto 0),
      vid_field_id => NLW_v_axi4s_vid_out_0_vid_field_id_UNCONNECTED,
      vid_hblank => v_axi4s_vid_out_0_vid_io_out_HBLANK,
      vid_hsync => NLW_v_axi4s_vid_out_0_vid_hsync_UNCONNECTED,
      vid_io_out_ce => vcc_const(0),
      vid_io_out_clk => clk_1,
      vid_vblank => v_axi4s_vid_out_0_vid_io_out_VBLANK,
      vid_vsync => NLW_v_axi4s_vid_out_0_vid_vsync_UNCONNECTED,
      vtg_active_video => v_tc_0_vtiming_out_ACTIVE_VIDEO,
      vtg_ce => v_axi4s_vid_out_0_vtg_ce,
      vtg_field_id => GND_2,
      vtg_hblank => v_tc_0_vtiming_out_HBLANK,
      vtg_hsync => v_tc_0_vtiming_out_HSYNC,
      vtg_vblank => v_tc_0_vtiming_out_VBLANK,
      vtg_vsync => v_tc_0_vtiming_out_VSYNC,
      wr_error => NLW_v_axi4s_vid_out_0_wr_error_UNCONNECTED
    );
v_cresample_0: component tutorial_v_cresample_0_0
    port map (
      aclk => processing_system7_0_fclk_clk1,
      aclken => vcc_const(0),
      aresetn => s_axi_aresetn_1(0),
      m_axis_video_tdata(15 downto 0) => v_cresample_0_video_out_TDATA(15 downto 0),
      m_axis_video_tlast => v_cresample_0_video_out_TLAST,
      m_axis_video_tready => v_cresample_0_video_out_TREADY,
      m_axis_video_tuser => v_cresample_0_video_out_TUSER,
      m_axis_video_tvalid => v_cresample_0_video_out_TVALID,
      s_axis_video_tdata(23 downto 0) => v_rgb2ycrcb_0_video_out_TDATA(23 downto 0),
      s_axis_video_tlast => v_rgb2ycrcb_0_video_out_TLAST,
      s_axis_video_tready => v_rgb2ycrcb_0_video_out_TREADY,
      s_axis_video_tuser => v_rgb2ycrcb_0_video_out_TUSER,
      s_axis_video_tvalid => v_rgb2ycrcb_0_video_out_TVALID
    );
v_rgb2ycrcb_0: component tutorial_v_rgb2ycrcb_0_0
    port map (
      aclk => processing_system7_0_fclk_clk1,
      aclken => vcc_const(0),
      aresetn => s_axi_aresetn_1(0),
      m_axis_video_tdata(23 downto 0) => v_rgb2ycrcb_0_video_out_TDATA(23 downto 0),
      m_axis_video_tlast => v_rgb2ycrcb_0_video_out_TLAST,
      m_axis_video_tready => v_rgb2ycrcb_0_video_out_TREADY,
      m_axis_video_tuser_sof => v_rgb2ycrcb_0_video_out_TUSER,
      m_axis_video_tvalid => v_rgb2ycrcb_0_video_out_TVALID,
      s_axis_video_tdata(23 downto 0) => hdmio_axi4s_video_1_TDATA(23 downto 0),
      s_axis_video_tlast => hdmio_axi4s_video_1_TLAST,
      s_axis_video_tready => hdmio_axi4s_video_1_TREADY,
      s_axis_video_tuser_sof => hdmio_axi4s_video_1_TUSER,
      s_axis_video_tvalid => hdmio_axi4s_video_1_TVALID
    );
v_tc_0: component tutorial_v_tc_0_0
    port map (
      active_video_in => video_vtiming_1_ACTIVE_VIDEO,
      active_video_out => v_tc_0_vtiming_out_ACTIVE_VIDEO,
      clk => clk_1,
      clken => vcc_const(0),
      det_clken => vcc_const(0),
      fsync_in => GND_2,
      fsync_out(0) => NLW_v_tc_0_fsync_out_UNCONNECTED(0),
      gen_clken => v_axi4s_vid_out_0_vtg_ce,
      hblank_in => video_vtiming_1_HBLANK,
      hblank_out => v_tc_0_vtiming_out_HBLANK,
      hsync_out => v_tc_0_vtiming_out_HSYNC,
      irq => NLW_v_tc_0_irq_UNCONNECTED,
      resetn => vcc_const(0),
      s_axi_aclk => s_axi_aclk_1,
      s_axi_aclken => vcc_const(0),
      s_axi_araddr(8 downto 0) => Conn1_ARADDR(8 downto 0),
      s_axi_aresetn => s_axi_aresetn_1(0),
      s_axi_arready => Conn1_ARREADY,
      s_axi_arvalid => Conn1_ARVALID,
      s_axi_awaddr(8 downto 0) => Conn1_AWADDR(8 downto 0),
      s_axi_awready => Conn1_AWREADY,
      s_axi_awvalid => Conn1_AWVALID,
      s_axi_bready => Conn1_BREADY,
      s_axi_bresp(1 downto 0) => Conn1_BRESP(1 downto 0),
      s_axi_bvalid => Conn1_BVALID,
      s_axi_rdata(31 downto 0) => Conn1_RDATA(31 downto 0),
      s_axi_rready => Conn1_RREADY,
      s_axi_rresp(1 downto 0) => Conn1_RRESP(1 downto 0),
      s_axi_rvalid => Conn1_RVALID,
      s_axi_wdata(31 downto 0) => Conn1_WDATA(31 downto 0),
      s_axi_wready => Conn1_WREADY,
      s_axi_wstrb(3 downto 0) => Conn1_WSTRB(3 downto 0),
      s_axi_wvalid => Conn1_WVALID,
      vblank_in => video_vtiming_1_VBLANK,
      vblank_out => v_tc_0_vtiming_out_VBLANK,
      vsync_out => v_tc_0_vtiming_out_VSYNC
    );
vcc: component tutorial_vcc_3
    port map (
      const(0) => vcc_const(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity fmc1_imageon_vita_color_imp_6DO8LV is
  port (
    axi4lite_aresetn : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi4lite_clk : in STD_LOGIC;
    axi4s_clk : in STD_LOGIC;
    cfa_ctrl_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    cfa_ctrl_arready : out STD_LOGIC;
    cfa_ctrl_arvalid : in STD_LOGIC;
    cfa_ctrl_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    cfa_ctrl_awready : out STD_LOGIC;
    cfa_ctrl_awvalid : in STD_LOGIC;
    cfa_ctrl_bready : in STD_LOGIC;
    cfa_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    cfa_ctrl_bvalid : out STD_LOGIC;
    cfa_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    cfa_ctrl_rready : in STD_LOGIC;
    cfa_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    cfa_ctrl_rvalid : out STD_LOGIC;
    cfa_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    cfa_ctrl_wready : out STD_LOGIC;
    cfa_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    cfa_ctrl_wvalid : in STD_LOGIC;
    clk200 : in STD_LOGIC;
    dpc_ctrl_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dpc_ctrl_arready : out STD_LOGIC;
    dpc_ctrl_arvalid : in STD_LOGIC;
    dpc_ctrl_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dpc_ctrl_awready : out STD_LOGIC;
    dpc_ctrl_awvalid : in STD_LOGIC;
    dpc_ctrl_bready : in STD_LOGIC;
    dpc_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    dpc_ctrl_bvalid : out STD_LOGIC;
    dpc_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dpc_ctrl_rready : in STD_LOGIC;
    dpc_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    dpc_ctrl_rvalid : out STD_LOGIC;
    dpc_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dpc_ctrl_wready : out STD_LOGIC;
    dpc_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dpc_ctrl_wvalid : in STD_LOGIC;
    vita_axi4s_video_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    vita_axi4s_video_tlast : out STD_LOGIC;
    vita_axi4s_video_tready : in STD_LOGIC;
    vita_axi4s_video_tuser : out STD_LOGIC;
    vita_axi4s_video_tvalid : out STD_LOGIC;
    vita_clk : in STD_LOGIC;
    vita_ctrl_araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    vita_ctrl_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    vita_ctrl_arready : out STD_LOGIC;
    vita_ctrl_arvalid : in STD_LOGIC;
    vita_ctrl_awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    vita_ctrl_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    vita_ctrl_awready : out STD_LOGIC;
    vita_ctrl_awvalid : in STD_LOGIC;
    vita_ctrl_bready : in STD_LOGIC;
    vita_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vita_ctrl_bvalid : out STD_LOGIC;
    vita_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vita_ctrl_rready : in STD_LOGIC;
    vita_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vita_ctrl_rvalid : out STD_LOGIC;
    vita_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    vita_ctrl_wready : out STD_LOGIC;
    vita_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vita_ctrl_wvalid : in STD_LOGIC;
    vita_io_clk_out_n : in STD_LOGIC;
    vita_io_clk_out_p : in STD_LOGIC;
    vita_io_clk_pll : out STD_LOGIC;
    vita_io_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vita_io_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vita_io_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    vita_io_reset_n : out STD_LOGIC;
    vita_io_spi_miso : in STD_LOGIC;
    vita_io_spi_mosi : out STD_LOGIC;
    vita_io_spi_sclk : out STD_LOGIC;
    vita_io_spi_ssel_n : out STD_LOGIC;
    vita_io_sync_n : in STD_LOGIC;
    vita_io_sync_p : in STD_LOGIC;
    vita_io_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    vita_vtiming_active_video : out STD_LOGIC;
    vita_vtiming_hblank : out STD_LOGIC;
    vita_vtiming_vblank : out STD_LOGIC
  );
end fmc1_imageon_vita_color_imp_6DO8LV;

architecture STRUCTURE of fmc1_imageon_vita_color_imp_6DO8LV is
  component tutorial_gnd_0 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_gnd_0;
  component tutorial_v_cfa_0_0 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aclken : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    irq : out STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  end component tutorial_v_cfa_0_0;
  component tutorial_v_spc_0_0 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aclken : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    irq : out STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  end component tutorial_v_spc_0_0;
  component tutorial_v_vid_in_axi4s_0_0 is
  port (
    vid_io_in_clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    vid_io_in_ce : in STD_LOGIC;
    vid_active_video : in STD_LOGIC;
    vid_vblank : in STD_LOGIC;
    vid_hblank : in STD_LOGIC;
    vid_vsync : in STD_LOGIC;
    vid_hsync : in STD_LOGIC;
    vid_field_id : in STD_LOGIC;
    vid_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    fid : out STD_LOGIC;
    vtd_active_video : out STD_LOGIC;
    vtd_vblank : out STD_LOGIC;
    vtd_hblank : out STD_LOGIC;
    vtd_vsync : out STD_LOGIC;
    vtd_hsync : out STD_LOGIC;
    vtd_field_id : out STD_LOGIC;
    wr_error : out STD_LOGIC;
    empty : out STD_LOGIC;
    axis_enable : in STD_LOGIC
  );
  end component tutorial_v_vid_in_axi4s_0_0;
  component tutorial_vcc_1 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_vcc_1;
  component tutorial_fmc_imageon_vita_receiver_0_0 is
  port (
    clk200 : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    oe : in STD_LOGIC;
    io_vita_clk_pll : out STD_LOGIC;
    io_vita_reset_n : out STD_LOGIC;
    io_vita_spi_sclk : out STD_LOGIC;
    io_vita_spi_ssel_n : out STD_LOGIC;
    io_vita_spi_mosi : out STD_LOGIC;
    io_vita_spi_miso : in STD_LOGIC;
    io_vita_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    io_vita_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    io_vita_clk_out_p : in STD_LOGIC;
    io_vita_clk_out_n : in STD_LOGIC;
    io_vita_sync_p : in STD_LOGIC;
    io_vita_sync_n : in STD_LOGIC;
    io_vita_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    io_vita_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    trigger1 : in STD_LOGIC;
    fsync : out STD_LOGIC;
    video_vsync : out STD_LOGIC;
    video_hsync : out STD_LOGIC;
    video_vblank : out STD_LOGIC;
    video_hblank : out STD_LOGIC;
    video_active_video : out STD_LOGIC;
    video_data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC
  );
  end component tutorial_fmc_imageon_vita_receiver_0_0;
  signal Conn1_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_ARREADY : STD_LOGIC;
  signal Conn1_ARVALID : STD_LOGIC;
  signal Conn1_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_AWREADY : STD_LOGIC;
  signal Conn1_AWVALID : STD_LOGIC;
  signal Conn1_BREADY : STD_LOGIC;
  signal Conn1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_BVALID : STD_LOGIC;
  signal Conn1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_RREADY : STD_LOGIC;
  signal Conn1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_RVALID : STD_LOGIC;
  signal Conn1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_WREADY : STD_LOGIC;
  signal Conn1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_WVALID : STD_LOGIC;
  signal Conn2_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn2_ARREADY : STD_LOGIC;
  signal Conn2_ARVALID : STD_LOGIC;
  signal Conn2_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn2_AWREADY : STD_LOGIC;
  signal Conn2_AWVALID : STD_LOGIC;
  signal Conn2_BREADY : STD_LOGIC;
  signal Conn2_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn2_BVALID : STD_LOGIC;
  signal Conn2_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn2_RREADY : STD_LOGIC;
  signal Conn2_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn2_RVALID : STD_LOGIC;
  signal Conn2_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn2_WREADY : STD_LOGIC;
  signal Conn2_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn2_WVALID : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal clk_fpga_0 : STD_LOGIC;
  signal clk_fpga_1 : STD_LOGIC;
  signal clk_fpga_2 : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_ACTIVE_VIDEO : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_DATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fmc_imageon_vita_receiver_0_vid_io_out_HBLANK : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_HSYNC : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_VBLANK : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_VSYNC : STD_LOGIC;
  signal gnd_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal io_vita_1_clk_out_n : STD_LOGIC;
  signal io_vita_1_clk_out_p : STD_LOGIC;
  signal io_vita_1_clk_pll : STD_LOGIC;
  signal io_vita_1_data_n : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal io_vita_1_data_p : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal io_vita_1_monitor : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal io_vita_1_reset_n : STD_LOGIC;
  signal io_vita_1_spi_miso : STD_LOGIC;
  signal io_vita_1_spi_mosi : STD_LOGIC;
  signal io_vita_1_spi_sclk : STD_LOGIC;
  signal io_vita_1_spi_ssel_n : STD_LOGIC;
  signal io_vita_1_sync_n : STD_LOGIC;
  signal io_vita_1_sync_p : STD_LOGIC;
  signal io_vita_1_trigger : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal proc_sys_reset_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_WVALID : STD_LOGIC;
  signal v_cfa_0_video_out_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal v_cfa_0_video_out_TLAST : STD_LOGIC;
  signal v_cfa_0_video_out_TREADY : STD_LOGIC;
  signal v_cfa_0_video_out_TUSER : STD_LOGIC;
  signal v_cfa_0_video_out_TVALID : STD_LOGIC;
  signal v_spc_0_video_out_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal v_spc_0_video_out_TLAST : STD_LOGIC;
  signal v_spc_0_video_out_TREADY : STD_LOGIC;
  signal v_spc_0_video_out_TUSER : STD_LOGIC;
  signal v_spc_0_video_out_TVALID : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal v_vid_in_axi4s_0_video_out_TLAST : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TREADY : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TUSER : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TVALID : STD_LOGIC;
  signal v_vid_in_axi4s_0_vtiming_out_ACTIVE_VIDEO : STD_LOGIC;
  signal v_vid_in_axi4s_0_vtiming_out_HBLANK : STD_LOGIC;
  signal v_vid_in_axi4s_0_vtiming_out_VBLANK : STD_LOGIC;
  signal vcc_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal video_clk_div4 : STD_LOGIC;
  signal NLW_fmc_imageon_vita_receiver_0_fsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_cfa_0_irq_UNCONNECTED : STD_LOGIC;
  signal NLW_v_spc_0_irq_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_fid_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_vtd_field_id_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_vtd_hsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_vtd_vsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_wr_error_UNCONNECTED : STD_LOGIC;
begin
  Conn1_ARADDR(8 downto 0) <= dpc_ctrl_araddr(8 downto 0);
  Conn1_ARVALID <= dpc_ctrl_arvalid;
  Conn1_AWADDR(8 downto 0) <= dpc_ctrl_awaddr(8 downto 0);
  Conn1_AWVALID <= dpc_ctrl_awvalid;
  Conn1_BREADY <= dpc_ctrl_bready;
  Conn1_RREADY <= dpc_ctrl_rready;
  Conn1_WDATA(31 downto 0) <= dpc_ctrl_wdata(31 downto 0);
  Conn1_WSTRB(3 downto 0) <= dpc_ctrl_wstrb(3 downto 0);
  Conn1_WVALID <= dpc_ctrl_wvalid;
  Conn2_ARADDR(8 downto 0) <= cfa_ctrl_araddr(8 downto 0);
  Conn2_ARVALID <= cfa_ctrl_arvalid;
  Conn2_AWADDR(8 downto 0) <= cfa_ctrl_awaddr(8 downto 0);
  Conn2_AWVALID <= cfa_ctrl_awvalid;
  Conn2_BREADY <= cfa_ctrl_bready;
  Conn2_RREADY <= cfa_ctrl_rready;
  Conn2_WDATA(31 downto 0) <= cfa_ctrl_wdata(31 downto 0);
  Conn2_WSTRB(3 downto 0) <= cfa_ctrl_wstrb(3 downto 0);
  Conn2_WVALID <= cfa_ctrl_wvalid;
  cfa_ctrl_arready <= Conn2_ARREADY;
  cfa_ctrl_awready <= Conn2_AWREADY;
  cfa_ctrl_bresp(1 downto 0) <= Conn2_BRESP(1 downto 0);
  cfa_ctrl_bvalid <= Conn2_BVALID;
  cfa_ctrl_rdata(31 downto 0) <= Conn2_RDATA(31 downto 0);
  cfa_ctrl_rresp(1 downto 0) <= Conn2_RRESP(1 downto 0);
  cfa_ctrl_rvalid <= Conn2_RVALID;
  cfa_ctrl_wready <= Conn2_WREADY;
  clk_fpga_0 <= axi4lite_clk;
  clk_fpga_1 <= clk200;
  clk_fpga_2 <= axi4s_clk;
  dpc_ctrl_arready <= Conn1_ARREADY;
  dpc_ctrl_awready <= Conn1_AWREADY;
  dpc_ctrl_bresp(1 downto 0) <= Conn1_BRESP(1 downto 0);
  dpc_ctrl_bvalid <= Conn1_BVALID;
  dpc_ctrl_rdata(31 downto 0) <= Conn1_RDATA(31 downto 0);
  dpc_ctrl_rresp(1 downto 0) <= Conn1_RRESP(1 downto 0);
  dpc_ctrl_rvalid <= Conn1_RVALID;
  dpc_ctrl_wready <= Conn1_WREADY;
  io_vita_1_clk_out_n <= vita_io_clk_out_n;
  io_vita_1_clk_out_p <= vita_io_clk_out_p;
  io_vita_1_data_n(3 downto 0) <= vita_io_data_n(3 downto 0);
  io_vita_1_data_p(3 downto 0) <= vita_io_data_p(3 downto 0);
  io_vita_1_monitor(1 downto 0) <= vita_io_monitor(1 downto 0);
  io_vita_1_spi_miso <= vita_io_spi_miso;
  io_vita_1_sync_n <= vita_io_sync_n;
  io_vita_1_sync_p <= vita_io_sync_p;
  proc_sys_reset_peripheral_aresetn(0) <= axi4lite_aresetn(0);
  processing_system7_0_axi_periph_m01_axi_ARADDR(7 downto 0) <= vita_ctrl_araddr(7 downto 0);
  processing_system7_0_axi_periph_m01_axi_ARPROT(2 downto 0) <= vita_ctrl_arprot(2 downto 0);
  processing_system7_0_axi_periph_m01_axi_ARVALID <= vita_ctrl_arvalid;
  processing_system7_0_axi_periph_m01_axi_AWADDR(7 downto 0) <= vita_ctrl_awaddr(7 downto 0);
  processing_system7_0_axi_periph_m01_axi_AWPROT(2 downto 0) <= vita_ctrl_awprot(2 downto 0);
  processing_system7_0_axi_periph_m01_axi_AWVALID <= vita_ctrl_awvalid;
  processing_system7_0_axi_periph_m01_axi_BREADY <= vita_ctrl_bready;
  processing_system7_0_axi_periph_m01_axi_RREADY <= vita_ctrl_rready;
  processing_system7_0_axi_periph_m01_axi_WDATA(31 downto 0) <= vita_ctrl_wdata(31 downto 0);
  processing_system7_0_axi_periph_m01_axi_WSTRB(3 downto 0) <= vita_ctrl_wstrb(3 downto 0);
  processing_system7_0_axi_periph_m01_axi_WVALID <= vita_ctrl_wvalid;
  v_cfa_0_video_out_TREADY <= vita_axi4s_video_tready;
  video_clk_div4 <= vita_clk;
  vita_axi4s_video_tdata(23 downto 0) <= v_cfa_0_video_out_TDATA(23 downto 0);
  vita_axi4s_video_tlast <= v_cfa_0_video_out_TLAST;
  vita_axi4s_video_tuser <= v_cfa_0_video_out_TUSER;
  vita_axi4s_video_tvalid <= v_cfa_0_video_out_TVALID;
  vita_ctrl_arready <= processing_system7_0_axi_periph_m01_axi_ARREADY;
  vita_ctrl_awready <= processing_system7_0_axi_periph_m01_axi_AWREADY;
  vita_ctrl_bresp(1 downto 0) <= processing_system7_0_axi_periph_m01_axi_BRESP(1 downto 0);
  vita_ctrl_bvalid <= processing_system7_0_axi_periph_m01_axi_BVALID;
  vita_ctrl_rdata(31 downto 0) <= processing_system7_0_axi_periph_m01_axi_RDATA(31 downto 0);
  vita_ctrl_rresp(1 downto 0) <= processing_system7_0_axi_periph_m01_axi_RRESP(1 downto 0);
  vita_ctrl_rvalid <= processing_system7_0_axi_periph_m01_axi_RVALID;
  vita_ctrl_wready <= processing_system7_0_axi_periph_m01_axi_WREADY;
  vita_io_clk_pll <= io_vita_1_clk_pll;
  vita_io_reset_n <= io_vita_1_reset_n;
  vita_io_spi_mosi <= io_vita_1_spi_mosi;
  vita_io_spi_sclk <= io_vita_1_spi_sclk;
  vita_io_spi_ssel_n <= io_vita_1_spi_ssel_n;
  vita_io_trigger(2 downto 0) <= io_vita_1_trigger(2 downto 0);
  vita_vtiming_active_video <= v_vid_in_axi4s_0_vtiming_out_ACTIVE_VIDEO;
  vita_vtiming_hblank <= v_vid_in_axi4s_0_vtiming_out_HBLANK;
  vita_vtiming_vblank <= v_vid_in_axi4s_0_vtiming_out_VBLANK;
GND_1: unisim.vcomponents.GND
    port map (
      G => GND_2
    );
fmc_imageon_vita_receiver_0: component tutorial_fmc_imageon_vita_receiver_0_0
    port map (
      clk => video_clk_div4,
      clk200 => clk_fpga_1,
      fsync => NLW_fmc_imageon_vita_receiver_0_fsync_UNCONNECTED,
      io_vita_clk_out_n => io_vita_1_clk_out_n,
      io_vita_clk_out_p => io_vita_1_clk_out_p,
      io_vita_clk_pll => io_vita_1_clk_pll,
      io_vita_data_n(3 downto 0) => io_vita_1_data_n(3 downto 0),
      io_vita_data_p(3 downto 0) => io_vita_1_data_p(3 downto 0),
      io_vita_monitor(1 downto 0) => io_vita_1_monitor(1 downto 0),
      io_vita_reset_n => io_vita_1_reset_n,
      io_vita_spi_miso => io_vita_1_spi_miso,
      io_vita_spi_mosi => io_vita_1_spi_mosi,
      io_vita_spi_sclk => io_vita_1_spi_sclk,
      io_vita_spi_ssel_n => io_vita_1_spi_ssel_n,
      io_vita_sync_n => io_vita_1_sync_n,
      io_vita_sync_p => io_vita_1_sync_p,
      io_vita_trigger(2 downto 0) => io_vita_1_trigger(2 downto 0),
      oe => vcc_const(0),
      reset => gnd_const(0),
      s00_axi_aclk => clk_fpga_0,
      s00_axi_araddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_ARADDR(7 downto 0),
      s00_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s00_axi_arprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_ARPROT(2 downto 0),
      s00_axi_arready => processing_system7_0_axi_periph_m01_axi_ARREADY,
      s00_axi_arvalid => processing_system7_0_axi_periph_m01_axi_ARVALID,
      s00_axi_awaddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_AWADDR(7 downto 0),
      s00_axi_awprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_AWPROT(2 downto 0),
      s00_axi_awready => processing_system7_0_axi_periph_m01_axi_AWREADY,
      s00_axi_awvalid => processing_system7_0_axi_periph_m01_axi_AWVALID,
      s00_axi_bready => processing_system7_0_axi_periph_m01_axi_BREADY,
      s00_axi_bresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_BRESP(1 downto 0),
      s00_axi_bvalid => processing_system7_0_axi_periph_m01_axi_BVALID,
      s00_axi_rdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_RDATA(31 downto 0),
      s00_axi_rready => processing_system7_0_axi_periph_m01_axi_RREADY,
      s00_axi_rresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_RRESP(1 downto 0),
      s00_axi_rvalid => processing_system7_0_axi_periph_m01_axi_RVALID,
      s00_axi_wdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_WDATA(31 downto 0),
      s00_axi_wready => processing_system7_0_axi_periph_m01_axi_WREADY,
      s00_axi_wstrb(3 downto 0) => processing_system7_0_axi_periph_m01_axi_WSTRB(3 downto 0),
      s00_axi_wvalid => processing_system7_0_axi_periph_m01_axi_WVALID,
      trigger1 => gnd_const(0),
      video_active_video => fmc_imageon_vita_receiver_0_vid_io_out_ACTIVE_VIDEO,
      video_data(7 downto 0) => fmc_imageon_vita_receiver_0_vid_io_out_DATA(7 downto 0),
      video_hblank => fmc_imageon_vita_receiver_0_vid_io_out_HBLANK,
      video_hsync => fmc_imageon_vita_receiver_0_vid_io_out_HSYNC,
      video_vblank => fmc_imageon_vita_receiver_0_vid_io_out_VBLANK,
      video_vsync => fmc_imageon_vita_receiver_0_vid_io_out_VSYNC
    );
gnd: component tutorial_gnd_0
    port map (
      const(0) => gnd_const(0)
    );
v_cfa_0: component tutorial_v_cfa_0_0
    port map (
      aclk => clk_fpga_2,
      aclken => vcc_const(0),
      aresetn => vcc_const(0),
      irq => NLW_v_cfa_0_irq_UNCONNECTED,
      m_axis_video_tdata(23 downto 0) => v_cfa_0_video_out_TDATA(23 downto 0),
      m_axis_video_tlast => v_cfa_0_video_out_TLAST,
      m_axis_video_tready => v_cfa_0_video_out_TREADY,
      m_axis_video_tuser => v_cfa_0_video_out_TUSER,
      m_axis_video_tvalid => v_cfa_0_video_out_TVALID,
      s_axi_aclk => clk_fpga_0,
      s_axi_aclken => vcc_const(0),
      s_axi_araddr(8 downto 0) => Conn2_ARADDR(8 downto 0),
      s_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s_axi_arready => Conn2_ARREADY,
      s_axi_arvalid => Conn2_ARVALID,
      s_axi_awaddr(8 downto 0) => Conn2_AWADDR(8 downto 0),
      s_axi_awready => Conn2_AWREADY,
      s_axi_awvalid => Conn2_AWVALID,
      s_axi_bready => Conn2_BREADY,
      s_axi_bresp(1 downto 0) => Conn2_BRESP(1 downto 0),
      s_axi_bvalid => Conn2_BVALID,
      s_axi_rdata(31 downto 0) => Conn2_RDATA(31 downto 0),
      s_axi_rready => Conn2_RREADY,
      s_axi_rresp(1 downto 0) => Conn2_RRESP(1 downto 0),
      s_axi_rvalid => Conn2_RVALID,
      s_axi_wdata(31 downto 0) => Conn2_WDATA(31 downto 0),
      s_axi_wready => Conn2_WREADY,
      s_axi_wstrb(3 downto 0) => Conn2_WSTRB(3 downto 0),
      s_axi_wvalid => Conn2_WVALID,
      s_axis_video_tdata(7 downto 0) => v_spc_0_video_out_TDATA(7 downto 0),
      s_axis_video_tlast => v_spc_0_video_out_TLAST,
      s_axis_video_tready => v_spc_0_video_out_TREADY,
      s_axis_video_tuser => v_spc_0_video_out_TUSER,
      s_axis_video_tvalid => v_spc_0_video_out_TVALID
    );
v_spc_0: component tutorial_v_spc_0_0
    port map (
      aclk => clk_fpga_2,
      aclken => vcc_const(0),
      aresetn => vcc_const(0),
      irq => NLW_v_spc_0_irq_UNCONNECTED,
      m_axis_video_tdata(7 downto 0) => v_spc_0_video_out_TDATA(7 downto 0),
      m_axis_video_tlast => v_spc_0_video_out_TLAST,
      m_axis_video_tready => v_spc_0_video_out_TREADY,
      m_axis_video_tuser => v_spc_0_video_out_TUSER,
      m_axis_video_tvalid => v_spc_0_video_out_TVALID,
      s_axi_aclk => clk_fpga_0,
      s_axi_aclken => vcc_const(0),
      s_axi_araddr(8 downto 0) => Conn1_ARADDR(8 downto 0),
      s_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s_axi_arready => Conn1_ARREADY,
      s_axi_arvalid => Conn1_ARVALID,
      s_axi_awaddr(8 downto 0) => Conn1_AWADDR(8 downto 0),
      s_axi_awready => Conn1_AWREADY,
      s_axi_awvalid => Conn1_AWVALID,
      s_axi_bready => Conn1_BREADY,
      s_axi_bresp(1 downto 0) => Conn1_BRESP(1 downto 0),
      s_axi_bvalid => Conn1_BVALID,
      s_axi_rdata(31 downto 0) => Conn1_RDATA(31 downto 0),
      s_axi_rready => Conn1_RREADY,
      s_axi_rresp(1 downto 0) => Conn1_RRESP(1 downto 0),
      s_axi_rvalid => Conn1_RVALID,
      s_axi_wdata(31 downto 0) => Conn1_WDATA(31 downto 0),
      s_axi_wready => Conn1_WREADY,
      s_axi_wstrb(3 downto 0) => Conn1_WSTRB(3 downto 0),
      s_axi_wvalid => Conn1_WVALID,
      s_axis_video_tdata(7 downto 0) => v_vid_in_axi4s_0_video_out_TDATA(7 downto 0),
      s_axis_video_tlast => v_vid_in_axi4s_0_video_out_TLAST,
      s_axis_video_tready => v_vid_in_axi4s_0_video_out_TREADY,
      s_axis_video_tuser => v_vid_in_axi4s_0_video_out_TUSER,
      s_axis_video_tvalid => v_vid_in_axi4s_0_video_out_TVALID
    );
v_vid_in_axi4s_0: component tutorial_v_vid_in_axi4s_0_0
    port map (
      aclk => clk_fpga_2,
      aclken => vcc_const(0),
      aresetn => proc_sys_reset_peripheral_aresetn(0),
      axis_enable => vcc_const(0),
      empty => NLW_v_vid_in_axi4s_0_empty_UNCONNECTED,
      fid => NLW_v_vid_in_axi4s_0_fid_UNCONNECTED,
      m_axis_video_tdata(7 downto 0) => v_vid_in_axi4s_0_video_out_TDATA(7 downto 0),
      m_axis_video_tlast => v_vid_in_axi4s_0_video_out_TLAST,
      m_axis_video_tready => v_vid_in_axi4s_0_video_out_TREADY,
      m_axis_video_tuser => v_vid_in_axi4s_0_video_out_TUSER,
      m_axis_video_tvalid => v_vid_in_axi4s_0_video_out_TVALID,
      rst => gnd_const(0),
      vid_active_video => fmc_imageon_vita_receiver_0_vid_io_out_ACTIVE_VIDEO,
      vid_data(7 downto 0) => fmc_imageon_vita_receiver_0_vid_io_out_DATA(7 downto 0),
      vid_field_id => GND_2,
      vid_hblank => fmc_imageon_vita_receiver_0_vid_io_out_HBLANK,
      vid_hsync => fmc_imageon_vita_receiver_0_vid_io_out_HSYNC,
      vid_io_in_ce => vcc_const(0),
      vid_io_in_clk => video_clk_div4,
      vid_vblank => fmc_imageon_vita_receiver_0_vid_io_out_VBLANK,
      vid_vsync => fmc_imageon_vita_receiver_0_vid_io_out_VSYNC,
      vtd_active_video => v_vid_in_axi4s_0_vtiming_out_ACTIVE_VIDEO,
      vtd_field_id => NLW_v_vid_in_axi4s_0_vtd_field_id_UNCONNECTED,
      vtd_hblank => v_vid_in_axi4s_0_vtiming_out_HBLANK,
      vtd_hsync => NLW_v_vid_in_axi4s_0_vtd_hsync_UNCONNECTED,
      vtd_vblank => v_vid_in_axi4s_0_vtiming_out_VBLANK,
      vtd_vsync => NLW_v_vid_in_axi4s_0_vtd_vsync_UNCONNECTED,
      wr_error => NLW_v_vid_in_axi4s_0_wr_error_UNCONNECTED
    );
vcc: component tutorial_vcc_1
    port map (
      const(0) => vcc_const(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity fmc2_imageon_hdmio_rgb_imp_LKNANE is
  port (
    axi4lite_aresetn : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi4lite_clk : in STD_LOGIC;
    axi4s_clk : in STD_LOGIC;
    hdmio_audio_spdif : in STD_LOGIC;
    hdmio_axi4s_video_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    hdmio_axi4s_video_tlast : in STD_LOGIC;
    hdmio_axi4s_video_tready : out STD_LOGIC;
    hdmio_axi4s_video_tuser : in STD_LOGIC;
    hdmio_axi4s_video_tvalid : in STD_LOGIC;
    hdmio_clk : in STD_LOGIC;
    hdmio_io_clk : out STD_LOGIC;
    hdmio_io_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    hdmio_io_spdif : out STD_LOGIC;
    video_vtiming_active_video : in STD_LOGIC;
    video_vtiming_hblank : in STD_LOGIC;
    video_vtiming_vblank : in STD_LOGIC;
    vtc_ctrl_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    vtc_ctrl_arready : out STD_LOGIC;
    vtc_ctrl_arvalid : in STD_LOGIC;
    vtc_ctrl_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    vtc_ctrl_awready : out STD_LOGIC;
    vtc_ctrl_awvalid : in STD_LOGIC;
    vtc_ctrl_bready : in STD_LOGIC;
    vtc_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vtc_ctrl_bvalid : out STD_LOGIC;
    vtc_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vtc_ctrl_rready : in STD_LOGIC;
    vtc_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vtc_ctrl_rvalid : out STD_LOGIC;
    vtc_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    vtc_ctrl_wready : out STD_LOGIC;
    vtc_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vtc_ctrl_wvalid : in STD_LOGIC
  );
end fmc2_imageon_hdmio_rgb_imp_LKNANE;

architecture STRUCTURE of fmc2_imageon_hdmio_rgb_imp_LKNANE is
  component tutorial_fmc_imageon_hdmi_out_0_1 is
  port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    oe : in STD_LOGIC;
    embed_syncs : in STD_LOGIC;
    audio_spdif : in STD_LOGIC;
    video_vblank : in STD_LOGIC;
    video_hblank : in STD_LOGIC;
    video_de : in STD_LOGIC;
    video_data : in STD_LOGIC_VECTOR ( 15 downto 0 );
    io_hdmio_spdif : out STD_LOGIC;
    io_hdmio_video : out STD_LOGIC_VECTOR ( 15 downto 0 );
    io_hdmio_clk : out STD_LOGIC
  );
  end component tutorial_fmc_imageon_hdmi_out_0_1;
  component tutorial_gnd_6 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_gnd_6;
  component tutorial_v_axi4s_vid_out_0_1 is
  port (
    aclk : in STD_LOGIC;
    rst : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    fid : in STD_LOGIC;
    vid_io_out_clk : in STD_LOGIC;
    vid_io_out_ce : in STD_LOGIC;
    vid_active_video : out STD_LOGIC;
    vid_vsync : out STD_LOGIC;
    vid_hsync : out STD_LOGIC;
    vid_vblank : out STD_LOGIC;
    vid_hblank : out STD_LOGIC;
    vid_field_id : out STD_LOGIC;
    vid_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    vtg_vsync : in STD_LOGIC;
    vtg_hsync : in STD_LOGIC;
    vtg_vblank : in STD_LOGIC;
    vtg_hblank : in STD_LOGIC;
    vtg_active_video : in STD_LOGIC;
    vtg_field_id : in STD_LOGIC;
    vtg_ce : out STD_LOGIC;
    locked : out STD_LOGIC;
    wr_error : out STD_LOGIC;
    empty : out STD_LOGIC
  );
  end component tutorial_v_axi4s_vid_out_0_1;
  component tutorial_v_cresample_0_1 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC
  );
  end component tutorial_v_cresample_0_1;
  component tutorial_v_rgb2ycrcb_0_1 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    s_axis_video_tuser_sof : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    m_axis_video_tuser_sof : out STD_LOGIC
  );
  end component tutorial_v_rgb2ycrcb_0_1;
  component tutorial_v_tc_0_1 is
  port (
    clk : in STD_LOGIC;
    clken : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aclken : in STD_LOGIC;
    det_clken : in STD_LOGIC;
    gen_clken : in STD_LOGIC;
    hblank_in : in STD_LOGIC;
    vblank_in : in STD_LOGIC;
    active_video_in : in STD_LOGIC;
    hsync_out : out STD_LOGIC;
    hblank_out : out STD_LOGIC;
    vsync_out : out STD_LOGIC;
    vblank_out : out STD_LOGIC;
    active_video_out : out STD_LOGIC;
    resetn : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    irq : out STD_LOGIC;
    fsync_in : in STD_LOGIC;
    fsync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_v_tc_0_1;
  component tutorial_vcc_7 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_vcc_7;
  signal Conn1_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_ARREADY : STD_LOGIC;
  signal Conn1_ARVALID : STD_LOGIC;
  signal Conn1_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_AWREADY : STD_LOGIC;
  signal Conn1_AWVALID : STD_LOGIC;
  signal Conn1_BREADY : STD_LOGIC;
  signal Conn1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_BVALID : STD_LOGIC;
  signal Conn1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_RREADY : STD_LOGIC;
  signal Conn1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_RVALID : STD_LOGIC;
  signal Conn1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_WREADY : STD_LOGIC;
  signal Conn1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_WVALID : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal clk_1 : STD_LOGIC;
  signal fmc_imageon_hdmi_in_0_audio_spdif : STD_LOGIC;
  signal fmc_imageon_hdmi_out_0_io_hdmio_CLK : STD_LOGIC;
  signal fmc_imageon_hdmi_out_0_io_hdmio_DATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal fmc_imageon_hdmi_out_0_io_hdmio_SPDIF : STD_LOGIC;
  signal gnd_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal hdmio_axi4s_video_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal hdmio_axi4s_video_1_TLAST : STD_LOGIC;
  signal hdmio_axi4s_video_1_TREADY : STD_LOGIC;
  signal hdmio_axi4s_video_1_TUSER : STD_LOGIC;
  signal hdmio_axi4s_video_1_TVALID : STD_LOGIC;
  signal processing_system7_0_fclk_clk1 : STD_LOGIC;
  signal s_axi_aclk_1 : STD_LOGIC;
  signal s_axi_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal v_axi4s_vid_out_0_vid_io_out_ACTIVE_VIDEO : STD_LOGIC;
  signal v_axi4s_vid_out_0_vid_io_out_DATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal v_axi4s_vid_out_0_vid_io_out_HBLANK : STD_LOGIC;
  signal v_axi4s_vid_out_0_vid_io_out_VBLANK : STD_LOGIC;
  signal v_axi4s_vid_out_0_vtg_ce : STD_LOGIC;
  signal v_cresample_0_video_out_TDATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal v_cresample_0_video_out_TLAST : STD_LOGIC;
  signal v_cresample_0_video_out_TREADY : STD_LOGIC;
  signal v_cresample_0_video_out_TUSER : STD_LOGIC;
  signal v_cresample_0_video_out_TVALID : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal v_rgb2ycrcb_0_video_out_TLAST : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TREADY : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TUSER : STD_LOGIC;
  signal v_rgb2ycrcb_0_video_out_TVALID : STD_LOGIC;
  signal v_tc_0_vtiming_out_ACTIVE_VIDEO : STD_LOGIC;
  signal v_tc_0_vtiming_out_HBLANK : STD_LOGIC;
  signal v_tc_0_vtiming_out_HSYNC : STD_LOGIC;
  signal v_tc_0_vtiming_out_VBLANK : STD_LOGIC;
  signal v_tc_0_vtiming_out_VSYNC : STD_LOGIC;
  signal vcc_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal video_vtiming_1_ACTIVE_VIDEO : STD_LOGIC;
  signal video_vtiming_1_HBLANK : STD_LOGIC;
  signal video_vtiming_1_VBLANK : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_locked_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_vid_field_id_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_vid_hsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_vid_vsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_axi4s_vid_out_0_wr_error_UNCONNECTED : STD_LOGIC;
  signal NLW_v_tc_0_irq_UNCONNECTED : STD_LOGIC;
  signal NLW_v_tc_0_fsync_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  Conn1_ARADDR(8 downto 0) <= vtc_ctrl_araddr(8 downto 0);
  Conn1_ARVALID <= vtc_ctrl_arvalid;
  Conn1_AWADDR(8 downto 0) <= vtc_ctrl_awaddr(8 downto 0);
  Conn1_AWVALID <= vtc_ctrl_awvalid;
  Conn1_BREADY <= vtc_ctrl_bready;
  Conn1_RREADY <= vtc_ctrl_rready;
  Conn1_WDATA(31 downto 0) <= vtc_ctrl_wdata(31 downto 0);
  Conn1_WSTRB(3 downto 0) <= vtc_ctrl_wstrb(3 downto 0);
  Conn1_WVALID <= vtc_ctrl_wvalid;
  clk_1 <= hdmio_clk;
  fmc_imageon_hdmi_in_0_audio_spdif <= hdmio_audio_spdif;
  hdmio_axi4s_video_1_TDATA(23 downto 0) <= hdmio_axi4s_video_tdata(23 downto 0);
  hdmio_axi4s_video_1_TLAST <= hdmio_axi4s_video_tlast;
  hdmio_axi4s_video_1_TUSER <= hdmio_axi4s_video_tuser;
  hdmio_axi4s_video_1_TVALID <= hdmio_axi4s_video_tvalid;
  hdmio_axi4s_video_tready <= hdmio_axi4s_video_1_TREADY;
  hdmio_io_clk <= fmc_imageon_hdmi_out_0_io_hdmio_CLK;
  hdmio_io_data(15 downto 0) <= fmc_imageon_hdmi_out_0_io_hdmio_DATA(15 downto 0);
  hdmio_io_spdif <= fmc_imageon_hdmi_out_0_io_hdmio_SPDIF;
  processing_system7_0_fclk_clk1 <= axi4s_clk;
  s_axi_aclk_1 <= axi4lite_clk;
  s_axi_aresetn_1(0) <= axi4lite_aresetn(0);
  video_vtiming_1_ACTIVE_VIDEO <= video_vtiming_active_video;
  video_vtiming_1_HBLANK <= video_vtiming_hblank;
  video_vtiming_1_VBLANK <= video_vtiming_vblank;
  vtc_ctrl_arready <= Conn1_ARREADY;
  vtc_ctrl_awready <= Conn1_AWREADY;
  vtc_ctrl_bresp(1 downto 0) <= Conn1_BRESP(1 downto 0);
  vtc_ctrl_bvalid <= Conn1_BVALID;
  vtc_ctrl_rdata(31 downto 0) <= Conn1_RDATA(31 downto 0);
  vtc_ctrl_rresp(1 downto 0) <= Conn1_RRESP(1 downto 0);
  vtc_ctrl_rvalid <= Conn1_RVALID;
  vtc_ctrl_wready <= Conn1_WREADY;
GND_1: unisim.vcomponents.GND
    port map (
      G => GND_2
    );
fmc_imageon_hdmi_out_0: component tutorial_fmc_imageon_hdmi_out_0_1
    port map (
      audio_spdif => fmc_imageon_hdmi_in_0_audio_spdif,
      clk => clk_1,
      embed_syncs => vcc_const(0),
      io_hdmio_clk => fmc_imageon_hdmi_out_0_io_hdmio_CLK,
      io_hdmio_spdif => fmc_imageon_hdmi_out_0_io_hdmio_SPDIF,
      io_hdmio_video(15 downto 0) => fmc_imageon_hdmi_out_0_io_hdmio_DATA(15 downto 0),
      oe => vcc_const(0),
      reset => gnd_const(0),
      video_data(15 downto 0) => v_axi4s_vid_out_0_vid_io_out_DATA(15 downto 0),
      video_de => v_axi4s_vid_out_0_vid_io_out_ACTIVE_VIDEO,
      video_hblank => v_axi4s_vid_out_0_vid_io_out_HBLANK,
      video_vblank => v_axi4s_vid_out_0_vid_io_out_VBLANK
    );
gnd: component tutorial_gnd_6
    port map (
      const(0) => gnd_const(0)
    );
v_axi4s_vid_out_0: component tutorial_v_axi4s_vid_out_0_1
    port map (
      aclk => processing_system7_0_fclk_clk1,
      aclken => vcc_const(0),
      aresetn => s_axi_aresetn_1(0),
      empty => NLW_v_axi4s_vid_out_0_empty_UNCONNECTED,
      fid => GND_2,
      locked => NLW_v_axi4s_vid_out_0_locked_UNCONNECTED,
      rst => gnd_const(0),
      s_axis_video_tdata(15 downto 0) => v_cresample_0_video_out_TDATA(15 downto 0),
      s_axis_video_tlast => v_cresample_0_video_out_TLAST,
      s_axis_video_tready => v_cresample_0_video_out_TREADY,
      s_axis_video_tuser => v_cresample_0_video_out_TUSER,
      s_axis_video_tvalid => v_cresample_0_video_out_TVALID,
      vid_active_video => v_axi4s_vid_out_0_vid_io_out_ACTIVE_VIDEO,
      vid_data(15 downto 0) => v_axi4s_vid_out_0_vid_io_out_DATA(15 downto 0),
      vid_field_id => NLW_v_axi4s_vid_out_0_vid_field_id_UNCONNECTED,
      vid_hblank => v_axi4s_vid_out_0_vid_io_out_HBLANK,
      vid_hsync => NLW_v_axi4s_vid_out_0_vid_hsync_UNCONNECTED,
      vid_io_out_ce => vcc_const(0),
      vid_io_out_clk => clk_1,
      vid_vblank => v_axi4s_vid_out_0_vid_io_out_VBLANK,
      vid_vsync => NLW_v_axi4s_vid_out_0_vid_vsync_UNCONNECTED,
      vtg_active_video => v_tc_0_vtiming_out_ACTIVE_VIDEO,
      vtg_ce => v_axi4s_vid_out_0_vtg_ce,
      vtg_field_id => GND_2,
      vtg_hblank => v_tc_0_vtiming_out_HBLANK,
      vtg_hsync => v_tc_0_vtiming_out_HSYNC,
      vtg_vblank => v_tc_0_vtiming_out_VBLANK,
      vtg_vsync => v_tc_0_vtiming_out_VSYNC,
      wr_error => NLW_v_axi4s_vid_out_0_wr_error_UNCONNECTED
    );
v_cresample_0: component tutorial_v_cresample_0_1
    port map (
      aclk => processing_system7_0_fclk_clk1,
      aclken => vcc_const(0),
      aresetn => s_axi_aresetn_1(0),
      m_axis_video_tdata(15 downto 0) => v_cresample_0_video_out_TDATA(15 downto 0),
      m_axis_video_tlast => v_cresample_0_video_out_TLAST,
      m_axis_video_tready => v_cresample_0_video_out_TREADY,
      m_axis_video_tuser => v_cresample_0_video_out_TUSER,
      m_axis_video_tvalid => v_cresample_0_video_out_TVALID,
      s_axis_video_tdata(23 downto 0) => v_rgb2ycrcb_0_video_out_TDATA(23 downto 0),
      s_axis_video_tlast => v_rgb2ycrcb_0_video_out_TLAST,
      s_axis_video_tready => v_rgb2ycrcb_0_video_out_TREADY,
      s_axis_video_tuser => v_rgb2ycrcb_0_video_out_TUSER,
      s_axis_video_tvalid => v_rgb2ycrcb_0_video_out_TVALID
    );
v_rgb2ycrcb_0: component tutorial_v_rgb2ycrcb_0_1
    port map (
      aclk => processing_system7_0_fclk_clk1,
      aclken => vcc_const(0),
      aresetn => s_axi_aresetn_1(0),
      m_axis_video_tdata(23 downto 0) => v_rgb2ycrcb_0_video_out_TDATA(23 downto 0),
      m_axis_video_tlast => v_rgb2ycrcb_0_video_out_TLAST,
      m_axis_video_tready => v_rgb2ycrcb_0_video_out_TREADY,
      m_axis_video_tuser_sof => v_rgb2ycrcb_0_video_out_TUSER,
      m_axis_video_tvalid => v_rgb2ycrcb_0_video_out_TVALID,
      s_axis_video_tdata(23 downto 0) => hdmio_axi4s_video_1_TDATA(23 downto 0),
      s_axis_video_tlast => hdmio_axi4s_video_1_TLAST,
      s_axis_video_tready => hdmio_axi4s_video_1_TREADY,
      s_axis_video_tuser_sof => hdmio_axi4s_video_1_TUSER,
      s_axis_video_tvalid => hdmio_axi4s_video_1_TVALID
    );
v_tc_0: component tutorial_v_tc_0_1
    port map (
      active_video_in => video_vtiming_1_ACTIVE_VIDEO,
      active_video_out => v_tc_0_vtiming_out_ACTIVE_VIDEO,
      clk => clk_1,
      clken => vcc_const(0),
      det_clken => vcc_const(0),
      fsync_in => GND_2,
      fsync_out(0) => NLW_v_tc_0_fsync_out_UNCONNECTED(0),
      gen_clken => v_axi4s_vid_out_0_vtg_ce,
      hblank_in => video_vtiming_1_HBLANK,
      hblank_out => v_tc_0_vtiming_out_HBLANK,
      hsync_out => v_tc_0_vtiming_out_HSYNC,
      irq => NLW_v_tc_0_irq_UNCONNECTED,
      resetn => vcc_const(0),
      s_axi_aclk => s_axi_aclk_1,
      s_axi_aclken => vcc_const(0),
      s_axi_araddr(8 downto 0) => Conn1_ARADDR(8 downto 0),
      s_axi_aresetn => s_axi_aresetn_1(0),
      s_axi_arready => Conn1_ARREADY,
      s_axi_arvalid => Conn1_ARVALID,
      s_axi_awaddr(8 downto 0) => Conn1_AWADDR(8 downto 0),
      s_axi_awready => Conn1_AWREADY,
      s_axi_awvalid => Conn1_AWVALID,
      s_axi_bready => Conn1_BREADY,
      s_axi_bresp(1 downto 0) => Conn1_BRESP(1 downto 0),
      s_axi_bvalid => Conn1_BVALID,
      s_axi_rdata(31 downto 0) => Conn1_RDATA(31 downto 0),
      s_axi_rready => Conn1_RREADY,
      s_axi_rresp(1 downto 0) => Conn1_RRESP(1 downto 0),
      s_axi_rvalid => Conn1_RVALID,
      s_axi_wdata(31 downto 0) => Conn1_WDATA(31 downto 0),
      s_axi_wready => Conn1_WREADY,
      s_axi_wstrb(3 downto 0) => Conn1_WSTRB(3 downto 0),
      s_axi_wvalid => Conn1_WVALID,
      vblank_in => video_vtiming_1_VBLANK,
      vblank_out => v_tc_0_vtiming_out_VBLANK,
      vsync_out => v_tc_0_vtiming_out_VSYNC
    );
vcc: component tutorial_vcc_7
    port map (
      const(0) => vcc_const(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity fmc2_imageon_vita_color_imp_1FFB5G9 is
  port (
    axi4lite_aresetn : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi4lite_clk : in STD_LOGIC;
    axi4s_clk : in STD_LOGIC;
    cfa_ctrl_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    cfa_ctrl_arready : out STD_LOGIC;
    cfa_ctrl_arvalid : in STD_LOGIC;
    cfa_ctrl_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    cfa_ctrl_awready : out STD_LOGIC;
    cfa_ctrl_awvalid : in STD_LOGIC;
    cfa_ctrl_bready : in STD_LOGIC;
    cfa_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    cfa_ctrl_bvalid : out STD_LOGIC;
    cfa_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    cfa_ctrl_rready : in STD_LOGIC;
    cfa_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    cfa_ctrl_rvalid : out STD_LOGIC;
    cfa_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    cfa_ctrl_wready : out STD_LOGIC;
    cfa_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    cfa_ctrl_wvalid : in STD_LOGIC;
    clk200 : in STD_LOGIC;
    dpc_ctrl_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dpc_ctrl_arready : out STD_LOGIC;
    dpc_ctrl_arvalid : in STD_LOGIC;
    dpc_ctrl_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dpc_ctrl_awready : out STD_LOGIC;
    dpc_ctrl_awvalid : in STD_LOGIC;
    dpc_ctrl_bready : in STD_LOGIC;
    dpc_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    dpc_ctrl_bvalid : out STD_LOGIC;
    dpc_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dpc_ctrl_rready : in STD_LOGIC;
    dpc_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    dpc_ctrl_rvalid : out STD_LOGIC;
    dpc_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dpc_ctrl_wready : out STD_LOGIC;
    dpc_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dpc_ctrl_wvalid : in STD_LOGIC;
    vita_axi4s_video_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    vita_axi4s_video_tlast : out STD_LOGIC;
    vita_axi4s_video_tready : in STD_LOGIC;
    vita_axi4s_video_tuser : out STD_LOGIC;
    vita_axi4s_video_tvalid : out STD_LOGIC;
    vita_clk : in STD_LOGIC;
    vita_ctrl_araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    vita_ctrl_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    vita_ctrl_arready : out STD_LOGIC;
    vita_ctrl_arvalid : in STD_LOGIC;
    vita_ctrl_awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    vita_ctrl_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    vita_ctrl_awready : out STD_LOGIC;
    vita_ctrl_awvalid : in STD_LOGIC;
    vita_ctrl_bready : in STD_LOGIC;
    vita_ctrl_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vita_ctrl_bvalid : out STD_LOGIC;
    vita_ctrl_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vita_ctrl_rready : in STD_LOGIC;
    vita_ctrl_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vita_ctrl_rvalid : out STD_LOGIC;
    vita_ctrl_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    vita_ctrl_wready : out STD_LOGIC;
    vita_ctrl_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vita_ctrl_wvalid : in STD_LOGIC;
    vita_io_clk_out_n : in STD_LOGIC;
    vita_io_clk_out_p : in STD_LOGIC;
    vita_io_clk_pll : out STD_LOGIC;
    vita_io_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vita_io_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vita_io_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    vita_io_reset_n : out STD_LOGIC;
    vita_io_spi_miso : in STD_LOGIC;
    vita_io_spi_mosi : out STD_LOGIC;
    vita_io_spi_sclk : out STD_LOGIC;
    vita_io_spi_ssel_n : out STD_LOGIC;
    vita_io_sync_n : in STD_LOGIC;
    vita_io_sync_p : in STD_LOGIC;
    vita_io_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    vita_vtiming_active_video : out STD_LOGIC;
    vita_vtiming_hblank : out STD_LOGIC;
    vita_vtiming_vblank : out STD_LOGIC
  );
end fmc2_imageon_vita_color_imp_1FFB5G9;

architecture STRUCTURE of fmc2_imageon_vita_color_imp_1FFB5G9 is
  component tutorial_gnd_4 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_gnd_4;
  component tutorial_v_cfa_0_1 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aclken : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    irq : out STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  end component tutorial_v_cfa_0_1;
  component tutorial_v_spc_0_1 is
  port (
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aclken : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    irq : out STD_LOGIC;
    s_axis_video_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_video_tready : out STD_LOGIC;
    s_axis_video_tvalid : in STD_LOGIC;
    s_axis_video_tlast : in STD_LOGIC;
    s_axis_video_tuser : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  end component tutorial_v_spc_0_1;
  component tutorial_v_vid_in_axi4s_0_1 is
  port (
    vid_io_in_clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    vid_io_in_ce : in STD_LOGIC;
    vid_active_video : in STD_LOGIC;
    vid_vblank : in STD_LOGIC;
    vid_hblank : in STD_LOGIC;
    vid_vsync : in STD_LOGIC;
    vid_hsync : in STD_LOGIC;
    vid_field_id : in STD_LOGIC;
    vid_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    aclk : in STD_LOGIC;
    aclken : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC;
    m_axis_video_tlast : out STD_LOGIC;
    fid : out STD_LOGIC;
    vtd_active_video : out STD_LOGIC;
    vtd_vblank : out STD_LOGIC;
    vtd_hblank : out STD_LOGIC;
    vtd_vsync : out STD_LOGIC;
    vtd_hsync : out STD_LOGIC;
    vtd_field_id : out STD_LOGIC;
    wr_error : out STD_LOGIC;
    empty : out STD_LOGIC;
    axis_enable : in STD_LOGIC
  );
  end component tutorial_v_vid_in_axi4s_0_1;
  component tutorial_vcc_5 is
  port (
    const : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_vcc_5;
  component tutorial_fmc_imageon_vita_receiver_0_1 is
  port (
    clk200 : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    oe : in STD_LOGIC;
    io_vita_clk_pll : out STD_LOGIC;
    io_vita_reset_n : out STD_LOGIC;
    io_vita_spi_sclk : out STD_LOGIC;
    io_vita_spi_ssel_n : out STD_LOGIC;
    io_vita_spi_mosi : out STD_LOGIC;
    io_vita_spi_miso : in STD_LOGIC;
    io_vita_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    io_vita_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    io_vita_clk_out_p : in STD_LOGIC;
    io_vita_clk_out_n : in STD_LOGIC;
    io_vita_sync_p : in STD_LOGIC;
    io_vita_sync_n : in STD_LOGIC;
    io_vita_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    io_vita_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    trigger1 : in STD_LOGIC;
    fsync : out STD_LOGIC;
    video_vsync : out STD_LOGIC;
    video_hsync : out STD_LOGIC;
    video_vblank : out STD_LOGIC;
    video_hblank : out STD_LOGIC;
    video_active_video : out STD_LOGIC;
    video_data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC
  );
  end component tutorial_fmc_imageon_vita_receiver_0_1;
  signal Conn1_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_ARREADY : STD_LOGIC;
  signal Conn1_ARVALID : STD_LOGIC;
  signal Conn1_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn1_AWREADY : STD_LOGIC;
  signal Conn1_AWVALID : STD_LOGIC;
  signal Conn1_BREADY : STD_LOGIC;
  signal Conn1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_BVALID : STD_LOGIC;
  signal Conn1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_RREADY : STD_LOGIC;
  signal Conn1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_RVALID : STD_LOGIC;
  signal Conn1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_WREADY : STD_LOGIC;
  signal Conn1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_WVALID : STD_LOGIC;
  signal Conn2_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn2_ARREADY : STD_LOGIC;
  signal Conn2_ARVALID : STD_LOGIC;
  signal Conn2_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Conn2_AWREADY : STD_LOGIC;
  signal Conn2_AWVALID : STD_LOGIC;
  signal Conn2_BREADY : STD_LOGIC;
  signal Conn2_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn2_BVALID : STD_LOGIC;
  signal Conn2_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn2_RREADY : STD_LOGIC;
  signal Conn2_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn2_RVALID : STD_LOGIC;
  signal Conn2_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn2_WREADY : STD_LOGIC;
  signal Conn2_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn2_WVALID : STD_LOGIC;
  signal GND_2 : STD_LOGIC;
  signal clk_fpga_0 : STD_LOGIC;
  signal clk_fpga_1 : STD_LOGIC;
  signal clk_fpga_2 : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_ACTIVE_VIDEO : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_DATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fmc_imageon_vita_receiver_0_vid_io_out_HBLANK : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_HSYNC : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_VBLANK : STD_LOGIC;
  signal fmc_imageon_vita_receiver_0_vid_io_out_VSYNC : STD_LOGIC;
  signal gnd_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal io_vita_1_clk_out_n : STD_LOGIC;
  signal io_vita_1_clk_out_p : STD_LOGIC;
  signal io_vita_1_clk_pll : STD_LOGIC;
  signal io_vita_1_data_n : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal io_vita_1_data_p : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal io_vita_1_monitor : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal io_vita_1_reset_n : STD_LOGIC;
  signal io_vita_1_spi_miso : STD_LOGIC;
  signal io_vita_1_spi_mosi : STD_LOGIC;
  signal io_vita_1_spi_sclk : STD_LOGIC;
  signal io_vita_1_spi_ssel_n : STD_LOGIC;
  signal io_vita_1_sync_n : STD_LOGIC;
  signal io_vita_1_sync_p : STD_LOGIC;
  signal io_vita_1_trigger : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal proc_sys_reset_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_WVALID : STD_LOGIC;
  signal v_cfa_0_video_out_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal v_cfa_0_video_out_TLAST : STD_LOGIC;
  signal v_cfa_0_video_out_TREADY : STD_LOGIC;
  signal v_cfa_0_video_out_TUSER : STD_LOGIC;
  signal v_cfa_0_video_out_TVALID : STD_LOGIC;
  signal v_spc_0_video_out_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal v_spc_0_video_out_TLAST : STD_LOGIC;
  signal v_spc_0_video_out_TREADY : STD_LOGIC;
  signal v_spc_0_video_out_TUSER : STD_LOGIC;
  signal v_spc_0_video_out_TVALID : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal v_vid_in_axi4s_0_video_out_TLAST : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TREADY : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TUSER : STD_LOGIC;
  signal v_vid_in_axi4s_0_video_out_TVALID : STD_LOGIC;
  signal v_vid_in_axi4s_0_vtiming_out_ACTIVE_VIDEO : STD_LOGIC;
  signal v_vid_in_axi4s_0_vtiming_out_HBLANK : STD_LOGIC;
  signal v_vid_in_axi4s_0_vtiming_out_VBLANK : STD_LOGIC;
  signal vcc_const : STD_LOGIC_VECTOR ( 0 to 0 );
  signal video_clk_div4 : STD_LOGIC;
  signal NLW_fmc_imageon_vita_receiver_0_fsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_cfa_0_irq_UNCONNECTED : STD_LOGIC;
  signal NLW_v_spc_0_irq_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_fid_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_vtd_field_id_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_vtd_hsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_vtd_vsync_UNCONNECTED : STD_LOGIC;
  signal NLW_v_vid_in_axi4s_0_wr_error_UNCONNECTED : STD_LOGIC;
begin
  Conn1_ARADDR(8 downto 0) <= dpc_ctrl_araddr(8 downto 0);
  Conn1_ARVALID <= dpc_ctrl_arvalid;
  Conn1_AWADDR(8 downto 0) <= dpc_ctrl_awaddr(8 downto 0);
  Conn1_AWVALID <= dpc_ctrl_awvalid;
  Conn1_BREADY <= dpc_ctrl_bready;
  Conn1_RREADY <= dpc_ctrl_rready;
  Conn1_WDATA(31 downto 0) <= dpc_ctrl_wdata(31 downto 0);
  Conn1_WSTRB(3 downto 0) <= dpc_ctrl_wstrb(3 downto 0);
  Conn1_WVALID <= dpc_ctrl_wvalid;
  Conn2_ARADDR(8 downto 0) <= cfa_ctrl_araddr(8 downto 0);
  Conn2_ARVALID <= cfa_ctrl_arvalid;
  Conn2_AWADDR(8 downto 0) <= cfa_ctrl_awaddr(8 downto 0);
  Conn2_AWVALID <= cfa_ctrl_awvalid;
  Conn2_BREADY <= cfa_ctrl_bready;
  Conn2_RREADY <= cfa_ctrl_rready;
  Conn2_WDATA(31 downto 0) <= cfa_ctrl_wdata(31 downto 0);
  Conn2_WSTRB(3 downto 0) <= cfa_ctrl_wstrb(3 downto 0);
  Conn2_WVALID <= cfa_ctrl_wvalid;
  cfa_ctrl_arready <= Conn2_ARREADY;
  cfa_ctrl_awready <= Conn2_AWREADY;
  cfa_ctrl_bresp(1 downto 0) <= Conn2_BRESP(1 downto 0);
  cfa_ctrl_bvalid <= Conn2_BVALID;
  cfa_ctrl_rdata(31 downto 0) <= Conn2_RDATA(31 downto 0);
  cfa_ctrl_rresp(1 downto 0) <= Conn2_RRESP(1 downto 0);
  cfa_ctrl_rvalid <= Conn2_RVALID;
  cfa_ctrl_wready <= Conn2_WREADY;
  clk_fpga_0 <= axi4lite_clk;
  clk_fpga_1 <= clk200;
  clk_fpga_2 <= axi4s_clk;
  dpc_ctrl_arready <= Conn1_ARREADY;
  dpc_ctrl_awready <= Conn1_AWREADY;
  dpc_ctrl_bresp(1 downto 0) <= Conn1_BRESP(1 downto 0);
  dpc_ctrl_bvalid <= Conn1_BVALID;
  dpc_ctrl_rdata(31 downto 0) <= Conn1_RDATA(31 downto 0);
  dpc_ctrl_rresp(1 downto 0) <= Conn1_RRESP(1 downto 0);
  dpc_ctrl_rvalid <= Conn1_RVALID;
  dpc_ctrl_wready <= Conn1_WREADY;
  io_vita_1_clk_out_n <= vita_io_clk_out_n;
  io_vita_1_clk_out_p <= vita_io_clk_out_p;
  io_vita_1_data_n(3 downto 0) <= vita_io_data_n(3 downto 0);
  io_vita_1_data_p(3 downto 0) <= vita_io_data_p(3 downto 0);
  io_vita_1_monitor(1 downto 0) <= vita_io_monitor(1 downto 0);
  io_vita_1_spi_miso <= vita_io_spi_miso;
  io_vita_1_sync_n <= vita_io_sync_n;
  io_vita_1_sync_p <= vita_io_sync_p;
  proc_sys_reset_peripheral_aresetn(0) <= axi4lite_aresetn(0);
  processing_system7_0_axi_periph_m01_axi_ARADDR(7 downto 0) <= vita_ctrl_araddr(7 downto 0);
  processing_system7_0_axi_periph_m01_axi_ARPROT(2 downto 0) <= vita_ctrl_arprot(2 downto 0);
  processing_system7_0_axi_periph_m01_axi_ARVALID <= vita_ctrl_arvalid;
  processing_system7_0_axi_periph_m01_axi_AWADDR(7 downto 0) <= vita_ctrl_awaddr(7 downto 0);
  processing_system7_0_axi_periph_m01_axi_AWPROT(2 downto 0) <= vita_ctrl_awprot(2 downto 0);
  processing_system7_0_axi_periph_m01_axi_AWVALID <= vita_ctrl_awvalid;
  processing_system7_0_axi_periph_m01_axi_BREADY <= vita_ctrl_bready;
  processing_system7_0_axi_periph_m01_axi_RREADY <= vita_ctrl_rready;
  processing_system7_0_axi_periph_m01_axi_WDATA(31 downto 0) <= vita_ctrl_wdata(31 downto 0);
  processing_system7_0_axi_periph_m01_axi_WSTRB(3 downto 0) <= vita_ctrl_wstrb(3 downto 0);
  processing_system7_0_axi_periph_m01_axi_WVALID <= vita_ctrl_wvalid;
  v_cfa_0_video_out_TREADY <= vita_axi4s_video_tready;
  video_clk_div4 <= vita_clk;
  vita_axi4s_video_tdata(23 downto 0) <= v_cfa_0_video_out_TDATA(23 downto 0);
  vita_axi4s_video_tlast <= v_cfa_0_video_out_TLAST;
  vita_axi4s_video_tuser <= v_cfa_0_video_out_TUSER;
  vita_axi4s_video_tvalid <= v_cfa_0_video_out_TVALID;
  vita_ctrl_arready <= processing_system7_0_axi_periph_m01_axi_ARREADY;
  vita_ctrl_awready <= processing_system7_0_axi_periph_m01_axi_AWREADY;
  vita_ctrl_bresp(1 downto 0) <= processing_system7_0_axi_periph_m01_axi_BRESP(1 downto 0);
  vita_ctrl_bvalid <= processing_system7_0_axi_periph_m01_axi_BVALID;
  vita_ctrl_rdata(31 downto 0) <= processing_system7_0_axi_periph_m01_axi_RDATA(31 downto 0);
  vita_ctrl_rresp(1 downto 0) <= processing_system7_0_axi_periph_m01_axi_RRESP(1 downto 0);
  vita_ctrl_rvalid <= processing_system7_0_axi_periph_m01_axi_RVALID;
  vita_ctrl_wready <= processing_system7_0_axi_periph_m01_axi_WREADY;
  vita_io_clk_pll <= io_vita_1_clk_pll;
  vita_io_reset_n <= io_vita_1_reset_n;
  vita_io_spi_mosi <= io_vita_1_spi_mosi;
  vita_io_spi_sclk <= io_vita_1_spi_sclk;
  vita_io_spi_ssel_n <= io_vita_1_spi_ssel_n;
  vita_io_trigger(2 downto 0) <= io_vita_1_trigger(2 downto 0);
  vita_vtiming_active_video <= v_vid_in_axi4s_0_vtiming_out_ACTIVE_VIDEO;
  vita_vtiming_hblank <= v_vid_in_axi4s_0_vtiming_out_HBLANK;
  vita_vtiming_vblank <= v_vid_in_axi4s_0_vtiming_out_VBLANK;
GND_1: unisim.vcomponents.GND
    port map (
      G => GND_2
    );
fmc_imageon_vita_receiver_0: component tutorial_fmc_imageon_vita_receiver_0_1
    port map (
      clk => video_clk_div4,
      clk200 => clk_fpga_1,
      fsync => NLW_fmc_imageon_vita_receiver_0_fsync_UNCONNECTED,
      io_vita_clk_out_n => io_vita_1_clk_out_n,
      io_vita_clk_out_p => io_vita_1_clk_out_p,
      io_vita_clk_pll => io_vita_1_clk_pll,
      io_vita_data_n(3 downto 0) => io_vita_1_data_n(3 downto 0),
      io_vita_data_p(3 downto 0) => io_vita_1_data_p(3 downto 0),
      io_vita_monitor(1 downto 0) => io_vita_1_monitor(1 downto 0),
      io_vita_reset_n => io_vita_1_reset_n,
      io_vita_spi_miso => io_vita_1_spi_miso,
      io_vita_spi_mosi => io_vita_1_spi_mosi,
      io_vita_spi_sclk => io_vita_1_spi_sclk,
      io_vita_spi_ssel_n => io_vita_1_spi_ssel_n,
      io_vita_sync_n => io_vita_1_sync_n,
      io_vita_sync_p => io_vita_1_sync_p,
      io_vita_trigger(2 downto 0) => io_vita_1_trigger(2 downto 0),
      oe => vcc_const(0),
      reset => gnd_const(0),
      s00_axi_aclk => clk_fpga_0,
      s00_axi_araddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_ARADDR(7 downto 0),
      s00_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s00_axi_arprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_ARPROT(2 downto 0),
      s00_axi_arready => processing_system7_0_axi_periph_m01_axi_ARREADY,
      s00_axi_arvalid => processing_system7_0_axi_periph_m01_axi_ARVALID,
      s00_axi_awaddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_AWADDR(7 downto 0),
      s00_axi_awprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_AWPROT(2 downto 0),
      s00_axi_awready => processing_system7_0_axi_periph_m01_axi_AWREADY,
      s00_axi_awvalid => processing_system7_0_axi_periph_m01_axi_AWVALID,
      s00_axi_bready => processing_system7_0_axi_periph_m01_axi_BREADY,
      s00_axi_bresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_BRESP(1 downto 0),
      s00_axi_bvalid => processing_system7_0_axi_periph_m01_axi_BVALID,
      s00_axi_rdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_RDATA(31 downto 0),
      s00_axi_rready => processing_system7_0_axi_periph_m01_axi_RREADY,
      s00_axi_rresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_RRESP(1 downto 0),
      s00_axi_rvalid => processing_system7_0_axi_periph_m01_axi_RVALID,
      s00_axi_wdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_WDATA(31 downto 0),
      s00_axi_wready => processing_system7_0_axi_periph_m01_axi_WREADY,
      s00_axi_wstrb(3 downto 0) => processing_system7_0_axi_periph_m01_axi_WSTRB(3 downto 0),
      s00_axi_wvalid => processing_system7_0_axi_periph_m01_axi_WVALID,
      trigger1 => gnd_const(0),
      video_active_video => fmc_imageon_vita_receiver_0_vid_io_out_ACTIVE_VIDEO,
      video_data(7 downto 0) => fmc_imageon_vita_receiver_0_vid_io_out_DATA(7 downto 0),
      video_hblank => fmc_imageon_vita_receiver_0_vid_io_out_HBLANK,
      video_hsync => fmc_imageon_vita_receiver_0_vid_io_out_HSYNC,
      video_vblank => fmc_imageon_vita_receiver_0_vid_io_out_VBLANK,
      video_vsync => fmc_imageon_vita_receiver_0_vid_io_out_VSYNC
    );
gnd: component tutorial_gnd_4
    port map (
      const(0) => gnd_const(0)
    );
v_cfa_0: component tutorial_v_cfa_0_1
    port map (
      aclk => clk_fpga_2,
      aclken => vcc_const(0),
      aresetn => vcc_const(0),
      irq => NLW_v_cfa_0_irq_UNCONNECTED,
      m_axis_video_tdata(23 downto 0) => v_cfa_0_video_out_TDATA(23 downto 0),
      m_axis_video_tlast => v_cfa_0_video_out_TLAST,
      m_axis_video_tready => v_cfa_0_video_out_TREADY,
      m_axis_video_tuser => v_cfa_0_video_out_TUSER,
      m_axis_video_tvalid => v_cfa_0_video_out_TVALID,
      s_axi_aclk => clk_fpga_0,
      s_axi_aclken => vcc_const(0),
      s_axi_araddr(8 downto 0) => Conn2_ARADDR(8 downto 0),
      s_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s_axi_arready => Conn2_ARREADY,
      s_axi_arvalid => Conn2_ARVALID,
      s_axi_awaddr(8 downto 0) => Conn2_AWADDR(8 downto 0),
      s_axi_awready => Conn2_AWREADY,
      s_axi_awvalid => Conn2_AWVALID,
      s_axi_bready => Conn2_BREADY,
      s_axi_bresp(1 downto 0) => Conn2_BRESP(1 downto 0),
      s_axi_bvalid => Conn2_BVALID,
      s_axi_rdata(31 downto 0) => Conn2_RDATA(31 downto 0),
      s_axi_rready => Conn2_RREADY,
      s_axi_rresp(1 downto 0) => Conn2_RRESP(1 downto 0),
      s_axi_rvalid => Conn2_RVALID,
      s_axi_wdata(31 downto 0) => Conn2_WDATA(31 downto 0),
      s_axi_wready => Conn2_WREADY,
      s_axi_wstrb(3 downto 0) => Conn2_WSTRB(3 downto 0),
      s_axi_wvalid => Conn2_WVALID,
      s_axis_video_tdata(7 downto 0) => v_spc_0_video_out_TDATA(7 downto 0),
      s_axis_video_tlast => v_spc_0_video_out_TLAST,
      s_axis_video_tready => v_spc_0_video_out_TREADY,
      s_axis_video_tuser => v_spc_0_video_out_TUSER,
      s_axis_video_tvalid => v_spc_0_video_out_TVALID
    );
v_spc_0: component tutorial_v_spc_0_1
    port map (
      aclk => clk_fpga_2,
      aclken => vcc_const(0),
      aresetn => vcc_const(0),
      irq => NLW_v_spc_0_irq_UNCONNECTED,
      m_axis_video_tdata(7 downto 0) => v_spc_0_video_out_TDATA(7 downto 0),
      m_axis_video_tlast => v_spc_0_video_out_TLAST,
      m_axis_video_tready => v_spc_0_video_out_TREADY,
      m_axis_video_tuser => v_spc_0_video_out_TUSER,
      m_axis_video_tvalid => v_spc_0_video_out_TVALID,
      s_axi_aclk => clk_fpga_0,
      s_axi_aclken => vcc_const(0),
      s_axi_araddr(8 downto 0) => Conn1_ARADDR(8 downto 0),
      s_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s_axi_arready => Conn1_ARREADY,
      s_axi_arvalid => Conn1_ARVALID,
      s_axi_awaddr(8 downto 0) => Conn1_AWADDR(8 downto 0),
      s_axi_awready => Conn1_AWREADY,
      s_axi_awvalid => Conn1_AWVALID,
      s_axi_bready => Conn1_BREADY,
      s_axi_bresp(1 downto 0) => Conn1_BRESP(1 downto 0),
      s_axi_bvalid => Conn1_BVALID,
      s_axi_rdata(31 downto 0) => Conn1_RDATA(31 downto 0),
      s_axi_rready => Conn1_RREADY,
      s_axi_rresp(1 downto 0) => Conn1_RRESP(1 downto 0),
      s_axi_rvalid => Conn1_RVALID,
      s_axi_wdata(31 downto 0) => Conn1_WDATA(31 downto 0),
      s_axi_wready => Conn1_WREADY,
      s_axi_wstrb(3 downto 0) => Conn1_WSTRB(3 downto 0),
      s_axi_wvalid => Conn1_WVALID,
      s_axis_video_tdata(7 downto 0) => v_vid_in_axi4s_0_video_out_TDATA(7 downto 0),
      s_axis_video_tlast => v_vid_in_axi4s_0_video_out_TLAST,
      s_axis_video_tready => v_vid_in_axi4s_0_video_out_TREADY,
      s_axis_video_tuser => v_vid_in_axi4s_0_video_out_TUSER,
      s_axis_video_tvalid => v_vid_in_axi4s_0_video_out_TVALID
    );
v_vid_in_axi4s_0: component tutorial_v_vid_in_axi4s_0_1
    port map (
      aclk => clk_fpga_2,
      aclken => vcc_const(0),
      aresetn => proc_sys_reset_peripheral_aresetn(0),
      axis_enable => vcc_const(0),
      empty => NLW_v_vid_in_axi4s_0_empty_UNCONNECTED,
      fid => NLW_v_vid_in_axi4s_0_fid_UNCONNECTED,
      m_axis_video_tdata(7 downto 0) => v_vid_in_axi4s_0_video_out_TDATA(7 downto 0),
      m_axis_video_tlast => v_vid_in_axi4s_0_video_out_TLAST,
      m_axis_video_tready => v_vid_in_axi4s_0_video_out_TREADY,
      m_axis_video_tuser => v_vid_in_axi4s_0_video_out_TUSER,
      m_axis_video_tvalid => v_vid_in_axi4s_0_video_out_TVALID,
      rst => gnd_const(0),
      vid_active_video => fmc_imageon_vita_receiver_0_vid_io_out_ACTIVE_VIDEO,
      vid_data(7 downto 0) => fmc_imageon_vita_receiver_0_vid_io_out_DATA(7 downto 0),
      vid_field_id => GND_2,
      vid_hblank => fmc_imageon_vita_receiver_0_vid_io_out_HBLANK,
      vid_hsync => fmc_imageon_vita_receiver_0_vid_io_out_HSYNC,
      vid_io_in_ce => vcc_const(0),
      vid_io_in_clk => video_clk_div4,
      vid_vblank => fmc_imageon_vita_receiver_0_vid_io_out_VBLANK,
      vid_vsync => fmc_imageon_vita_receiver_0_vid_io_out_VSYNC,
      vtd_active_video => v_vid_in_axi4s_0_vtiming_out_ACTIVE_VIDEO,
      vtd_field_id => NLW_v_vid_in_axi4s_0_vtd_field_id_UNCONNECTED,
      vtd_hblank => v_vid_in_axi4s_0_vtiming_out_HBLANK,
      vtd_hsync => NLW_v_vid_in_axi4s_0_vtd_hsync_UNCONNECTED,
      vtd_vblank => v_vid_in_axi4s_0_vtiming_out_VBLANK,
      vtd_vsync => NLW_v_vid_in_axi4s_0_vtd_vsync_UNCONNECTED,
      wr_error => NLW_v_vid_in_axi4s_0_wr_error_UNCONNECTED
    );
vcc: component tutorial_vcc_5
    port map (
      const(0) => vcc_const(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m00_couplers_imp_VG7ZLK is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end m00_couplers_imp_VG7ZLK;

architecture STRUCTURE of m00_couplers_imp_VG7ZLK is
  signal m00_couplers_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m00_couplers_to_m00_couplers_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m00_couplers_to_m00_couplers_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_m00_couplers_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_m00_couplers_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_m00_couplers_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  M_AXI_araddr(8 downto 0) <= m00_couplers_to_m00_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid(0) <= m00_couplers_to_m00_couplers_ARVALID(0);
  M_AXI_awaddr(8 downto 0) <= m00_couplers_to_m00_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid(0) <= m00_couplers_to_m00_couplers_AWVALID(0);
  M_AXI_bready(0) <= m00_couplers_to_m00_couplers_BREADY(0);
  M_AXI_rready(0) <= m00_couplers_to_m00_couplers_RREADY(0);
  M_AXI_wdata(31 downto 0) <= m00_couplers_to_m00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m00_couplers_to_m00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid(0) <= m00_couplers_to_m00_couplers_WVALID(0);
  S_AXI_arready(0) <= m00_couplers_to_m00_couplers_ARREADY(0);
  S_AXI_awready(0) <= m00_couplers_to_m00_couplers_AWREADY(0);
  S_AXI_bresp(1 downto 0) <= m00_couplers_to_m00_couplers_BRESP(1 downto 0);
  S_AXI_bvalid(0) <= m00_couplers_to_m00_couplers_BVALID(0);
  S_AXI_rdata(31 downto 0) <= m00_couplers_to_m00_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m00_couplers_to_m00_couplers_RRESP(1 downto 0);
  S_AXI_rvalid(0) <= m00_couplers_to_m00_couplers_RVALID(0);
  S_AXI_wready(0) <= m00_couplers_to_m00_couplers_WREADY(0);
  m00_couplers_to_m00_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m00_couplers_to_m00_couplers_ARREADY(0) <= M_AXI_arready(0);
  m00_couplers_to_m00_couplers_ARVALID(0) <= S_AXI_arvalid(0);
  m00_couplers_to_m00_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m00_couplers_to_m00_couplers_AWREADY(0) <= M_AXI_awready(0);
  m00_couplers_to_m00_couplers_AWVALID(0) <= S_AXI_awvalid(0);
  m00_couplers_to_m00_couplers_BREADY(0) <= S_AXI_bready(0);
  m00_couplers_to_m00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m00_couplers_to_m00_couplers_BVALID(0) <= M_AXI_bvalid(0);
  m00_couplers_to_m00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m00_couplers_to_m00_couplers_RREADY(0) <= S_AXI_rready(0);
  m00_couplers_to_m00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m00_couplers_to_m00_couplers_RVALID(0) <= M_AXI_rvalid(0);
  m00_couplers_to_m00_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m00_couplers_to_m00_couplers_WREADY(0) <= M_AXI_wready(0);
  m00_couplers_to_m00_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m00_couplers_to_m00_couplers_WVALID(0) <= S_AXI_wvalid(0);
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m01_couplers_imp_180AW1Y is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m01_couplers_imp_180AW1Y;

architecture STRUCTURE of m01_couplers_imp_180AW1Y is
  signal m01_couplers_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m01_couplers_to_m01_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m01_couplers_to_m01_couplers_ARREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_ARVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m01_couplers_to_m01_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m01_couplers_to_m01_couplers_AWREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_AWVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_BREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_m01_couplers_BVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_m01_couplers_RREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_m01_couplers_RVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_m01_couplers_WREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m01_couplers_to_m01_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(7 downto 0) <= m01_couplers_to_m01_couplers_ARADDR(7 downto 0);
  M_AXI_arprot(2 downto 0) <= m01_couplers_to_m01_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= m01_couplers_to_m01_couplers_ARVALID;
  M_AXI_awaddr(7 downto 0) <= m01_couplers_to_m01_couplers_AWADDR(7 downto 0);
  M_AXI_awprot(2 downto 0) <= m01_couplers_to_m01_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= m01_couplers_to_m01_couplers_AWVALID;
  M_AXI_bready <= m01_couplers_to_m01_couplers_BREADY;
  M_AXI_rready <= m01_couplers_to_m01_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m01_couplers_to_m01_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m01_couplers_to_m01_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m01_couplers_to_m01_couplers_WVALID;
  S_AXI_arready <= m01_couplers_to_m01_couplers_ARREADY;
  S_AXI_awready <= m01_couplers_to_m01_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m01_couplers_to_m01_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m01_couplers_to_m01_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m01_couplers_to_m01_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m01_couplers_to_m01_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m01_couplers_to_m01_couplers_RVALID;
  S_AXI_wready <= m01_couplers_to_m01_couplers_WREADY;
  m01_couplers_to_m01_couplers_ARADDR(7 downto 0) <= S_AXI_araddr(7 downto 0);
  m01_couplers_to_m01_couplers_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  m01_couplers_to_m01_couplers_ARREADY <= M_AXI_arready;
  m01_couplers_to_m01_couplers_ARVALID <= S_AXI_arvalid;
  m01_couplers_to_m01_couplers_AWADDR(7 downto 0) <= S_AXI_awaddr(7 downto 0);
  m01_couplers_to_m01_couplers_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  m01_couplers_to_m01_couplers_AWREADY <= M_AXI_awready;
  m01_couplers_to_m01_couplers_AWVALID <= S_AXI_awvalid;
  m01_couplers_to_m01_couplers_BREADY <= S_AXI_bready;
  m01_couplers_to_m01_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m01_couplers_to_m01_couplers_BVALID <= M_AXI_bvalid;
  m01_couplers_to_m01_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m01_couplers_to_m01_couplers_RREADY <= S_AXI_rready;
  m01_couplers_to_m01_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m01_couplers_to_m01_couplers_RVALID <= M_AXI_rvalid;
  m01_couplers_to_m01_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m01_couplers_to_m01_couplers_WREADY <= M_AXI_wready;
  m01_couplers_to_m01_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m01_couplers_to_m01_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m02_couplers_imp_WNEIF9 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m02_couplers_imp_WNEIF9;

architecture STRUCTURE of m02_couplers_imp_WNEIF9 is
  signal m02_couplers_to_m02_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m02_couplers_to_m02_couplers_ARREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_ARVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m02_couplers_to_m02_couplers_AWREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_AWVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_BREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_m02_couplers_BVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_m02_couplers_RREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_m02_couplers_RVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_m02_couplers_WREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_m02_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(8 downto 0) <= m02_couplers_to_m02_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid <= m02_couplers_to_m02_couplers_ARVALID;
  M_AXI_awaddr(8 downto 0) <= m02_couplers_to_m02_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid <= m02_couplers_to_m02_couplers_AWVALID;
  M_AXI_bready <= m02_couplers_to_m02_couplers_BREADY;
  M_AXI_rready <= m02_couplers_to_m02_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m02_couplers_to_m02_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m02_couplers_to_m02_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m02_couplers_to_m02_couplers_WVALID;
  S_AXI_arready <= m02_couplers_to_m02_couplers_ARREADY;
  S_AXI_awready <= m02_couplers_to_m02_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m02_couplers_to_m02_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m02_couplers_to_m02_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m02_couplers_to_m02_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m02_couplers_to_m02_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m02_couplers_to_m02_couplers_RVALID;
  S_AXI_wready <= m02_couplers_to_m02_couplers_WREADY;
  m02_couplers_to_m02_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m02_couplers_to_m02_couplers_ARREADY <= M_AXI_arready;
  m02_couplers_to_m02_couplers_ARVALID <= S_AXI_arvalid;
  m02_couplers_to_m02_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m02_couplers_to_m02_couplers_AWREADY <= M_AXI_awready;
  m02_couplers_to_m02_couplers_AWVALID <= S_AXI_awvalid;
  m02_couplers_to_m02_couplers_BREADY <= S_AXI_bready;
  m02_couplers_to_m02_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m02_couplers_to_m02_couplers_BVALID <= M_AXI_bvalid;
  m02_couplers_to_m02_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m02_couplers_to_m02_couplers_RREADY <= S_AXI_rready;
  m02_couplers_to_m02_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m02_couplers_to_m02_couplers_RVALID <= M_AXI_rvalid;
  m02_couplers_to_m02_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m02_couplers_to_m02_couplers_WREADY <= M_AXI_wready;
  m02_couplers_to_m02_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m02_couplers_to_m02_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m03_couplers_imp_16UK5X7 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m03_couplers_imp_16UK5X7;

architecture STRUCTURE of m03_couplers_imp_16UK5X7 is
  signal m03_couplers_to_m03_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m03_couplers_to_m03_couplers_ARREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_ARVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m03_couplers_to_m03_couplers_AWREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_AWVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_BREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_m03_couplers_BVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_RREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_m03_couplers_RVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_WREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m03_couplers_to_m03_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(8 downto 0) <= m03_couplers_to_m03_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid <= m03_couplers_to_m03_couplers_ARVALID;
  M_AXI_awaddr(8 downto 0) <= m03_couplers_to_m03_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid <= m03_couplers_to_m03_couplers_AWVALID;
  M_AXI_bready <= m03_couplers_to_m03_couplers_BREADY;
  M_AXI_rready <= m03_couplers_to_m03_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m03_couplers_to_m03_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m03_couplers_to_m03_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m03_couplers_to_m03_couplers_WVALID;
  S_AXI_arready <= m03_couplers_to_m03_couplers_ARREADY;
  S_AXI_awready <= m03_couplers_to_m03_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m03_couplers_to_m03_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m03_couplers_to_m03_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m03_couplers_to_m03_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m03_couplers_to_m03_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m03_couplers_to_m03_couplers_RVALID;
  S_AXI_wready <= m03_couplers_to_m03_couplers_WREADY;
  m03_couplers_to_m03_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m03_couplers_to_m03_couplers_ARREADY <= M_AXI_arready;
  m03_couplers_to_m03_couplers_ARVALID <= S_AXI_arvalid;
  m03_couplers_to_m03_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m03_couplers_to_m03_couplers_AWREADY <= M_AXI_awready;
  m03_couplers_to_m03_couplers_AWVALID <= S_AXI_awvalid;
  m03_couplers_to_m03_couplers_BREADY <= S_AXI_bready;
  m03_couplers_to_m03_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m03_couplers_to_m03_couplers_BVALID <= M_AXI_bvalid;
  m03_couplers_to_m03_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m03_couplers_to_m03_couplers_RREADY <= S_AXI_rready;
  m03_couplers_to_m03_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m03_couplers_to_m03_couplers_RVALID <= M_AXI_rvalid;
  m03_couplers_to_m03_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m03_couplers_to_m03_couplers_WREADY <= M_AXI_wready;
  m03_couplers_to_m03_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m03_couplers_to_m03_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m04_couplers_imp_XHLMRM is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m04_couplers_imp_XHLMRM;

architecture STRUCTURE of m04_couplers_imp_XHLMRM is
  signal m04_couplers_to_m04_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m04_couplers_to_m04_couplers_ARREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_ARVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m04_couplers_to_m04_couplers_AWREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_AWVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_BREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_m04_couplers_BVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_RREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_m04_couplers_RVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_WREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m04_couplers_to_m04_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(8 downto 0) <= m04_couplers_to_m04_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid <= m04_couplers_to_m04_couplers_ARVALID;
  M_AXI_awaddr(8 downto 0) <= m04_couplers_to_m04_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid <= m04_couplers_to_m04_couplers_AWVALID;
  M_AXI_bready <= m04_couplers_to_m04_couplers_BREADY;
  M_AXI_rready <= m04_couplers_to_m04_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m04_couplers_to_m04_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m04_couplers_to_m04_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m04_couplers_to_m04_couplers_WVALID;
  S_AXI_arready <= m04_couplers_to_m04_couplers_ARREADY;
  S_AXI_awready <= m04_couplers_to_m04_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m04_couplers_to_m04_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m04_couplers_to_m04_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m04_couplers_to_m04_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m04_couplers_to_m04_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m04_couplers_to_m04_couplers_RVALID;
  S_AXI_wready <= m04_couplers_to_m04_couplers_WREADY;
  m04_couplers_to_m04_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m04_couplers_to_m04_couplers_ARREADY <= M_AXI_arready;
  m04_couplers_to_m04_couplers_ARVALID <= S_AXI_arvalid;
  m04_couplers_to_m04_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m04_couplers_to_m04_couplers_AWREADY <= M_AXI_awready;
  m04_couplers_to_m04_couplers_AWVALID <= S_AXI_awvalid;
  m04_couplers_to_m04_couplers_BREADY <= S_AXI_bready;
  m04_couplers_to_m04_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m04_couplers_to_m04_couplers_BVALID <= M_AXI_bvalid;
  m04_couplers_to_m04_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m04_couplers_to_m04_couplers_RREADY <= S_AXI_rready;
  m04_couplers_to_m04_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m04_couplers_to_m04_couplers_RVALID <= M_AXI_rvalid;
  m04_couplers_to_m04_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m04_couplers_to_m04_couplers_WREADY <= M_AXI_wready;
  m04_couplers_to_m04_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m04_couplers_to_m04_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m05_couplers_imp_160OGCC is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m05_couplers_imp_160OGCC;

architecture STRUCTURE of m05_couplers_imp_160OGCC is
  signal m05_couplers_to_m05_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m05_couplers_to_m05_couplers_ARREADY : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_ARVALID : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m05_couplers_to_m05_couplers_AWREADY : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_AWVALID : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_BREADY : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m05_couplers_to_m05_couplers_BVALID : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m05_couplers_to_m05_couplers_RREADY : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m05_couplers_to_m05_couplers_RVALID : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m05_couplers_to_m05_couplers_WREADY : STD_LOGIC;
  signal m05_couplers_to_m05_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m05_couplers_to_m05_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(8 downto 0) <= m05_couplers_to_m05_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid <= m05_couplers_to_m05_couplers_ARVALID;
  M_AXI_awaddr(8 downto 0) <= m05_couplers_to_m05_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid <= m05_couplers_to_m05_couplers_AWVALID;
  M_AXI_bready <= m05_couplers_to_m05_couplers_BREADY;
  M_AXI_rready <= m05_couplers_to_m05_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m05_couplers_to_m05_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m05_couplers_to_m05_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m05_couplers_to_m05_couplers_WVALID;
  S_AXI_arready <= m05_couplers_to_m05_couplers_ARREADY;
  S_AXI_awready <= m05_couplers_to_m05_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m05_couplers_to_m05_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m05_couplers_to_m05_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m05_couplers_to_m05_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m05_couplers_to_m05_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m05_couplers_to_m05_couplers_RVALID;
  S_AXI_wready <= m05_couplers_to_m05_couplers_WREADY;
  m05_couplers_to_m05_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m05_couplers_to_m05_couplers_ARREADY <= M_AXI_arready;
  m05_couplers_to_m05_couplers_ARVALID <= S_AXI_arvalid;
  m05_couplers_to_m05_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m05_couplers_to_m05_couplers_AWREADY <= M_AXI_awready;
  m05_couplers_to_m05_couplers_AWVALID <= S_AXI_awvalid;
  m05_couplers_to_m05_couplers_BREADY <= S_AXI_bready;
  m05_couplers_to_m05_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m05_couplers_to_m05_couplers_BVALID <= M_AXI_bvalid;
  m05_couplers_to_m05_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m05_couplers_to_m05_couplers_RREADY <= S_AXI_rready;
  m05_couplers_to_m05_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m05_couplers_to_m05_couplers_RVALID <= M_AXI_rvalid;
  m05_couplers_to_m05_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m05_couplers_to_m05_couplers_WREADY <= M_AXI_wready;
  m05_couplers_to_m05_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m05_couplers_to_m05_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m06_couplers_imp_YHEOCF is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m06_couplers_imp_YHEOCF;

architecture STRUCTURE of m06_couplers_imp_YHEOCF is
  signal m06_couplers_to_m06_couplers_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m06_couplers_to_m06_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m06_couplers_to_m06_couplers_ARREADY : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_ARVALID : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m06_couplers_to_m06_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m06_couplers_to_m06_couplers_AWREADY : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_AWVALID : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_BREADY : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m06_couplers_to_m06_couplers_BVALID : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m06_couplers_to_m06_couplers_RREADY : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m06_couplers_to_m06_couplers_RVALID : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m06_couplers_to_m06_couplers_WREADY : STD_LOGIC;
  signal m06_couplers_to_m06_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m06_couplers_to_m06_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(7 downto 0) <= m06_couplers_to_m06_couplers_ARADDR(7 downto 0);
  M_AXI_arprot(2 downto 0) <= m06_couplers_to_m06_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= m06_couplers_to_m06_couplers_ARVALID;
  M_AXI_awaddr(7 downto 0) <= m06_couplers_to_m06_couplers_AWADDR(7 downto 0);
  M_AXI_awprot(2 downto 0) <= m06_couplers_to_m06_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= m06_couplers_to_m06_couplers_AWVALID;
  M_AXI_bready <= m06_couplers_to_m06_couplers_BREADY;
  M_AXI_rready <= m06_couplers_to_m06_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m06_couplers_to_m06_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m06_couplers_to_m06_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m06_couplers_to_m06_couplers_WVALID;
  S_AXI_arready <= m06_couplers_to_m06_couplers_ARREADY;
  S_AXI_awready <= m06_couplers_to_m06_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m06_couplers_to_m06_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m06_couplers_to_m06_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m06_couplers_to_m06_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m06_couplers_to_m06_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m06_couplers_to_m06_couplers_RVALID;
  S_AXI_wready <= m06_couplers_to_m06_couplers_WREADY;
  m06_couplers_to_m06_couplers_ARADDR(7 downto 0) <= S_AXI_araddr(7 downto 0);
  m06_couplers_to_m06_couplers_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  m06_couplers_to_m06_couplers_ARREADY <= M_AXI_arready;
  m06_couplers_to_m06_couplers_ARVALID <= S_AXI_arvalid;
  m06_couplers_to_m06_couplers_AWADDR(7 downto 0) <= S_AXI_awaddr(7 downto 0);
  m06_couplers_to_m06_couplers_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  m06_couplers_to_m06_couplers_AWREADY <= M_AXI_awready;
  m06_couplers_to_m06_couplers_AWVALID <= S_AXI_awvalid;
  m06_couplers_to_m06_couplers_BREADY <= S_AXI_bready;
  m06_couplers_to_m06_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m06_couplers_to_m06_couplers_BVALID <= M_AXI_bvalid;
  m06_couplers_to_m06_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m06_couplers_to_m06_couplers_RREADY <= S_AXI_rready;
  m06_couplers_to_m06_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m06_couplers_to_m06_couplers_RVALID <= M_AXI_rvalid;
  m06_couplers_to_m06_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m06_couplers_to_m06_couplers_WREADY <= M_AXI_wready;
  m06_couplers_to_m06_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m06_couplers_to_m06_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m07_couplers_imp_14XJU69 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m07_couplers_imp_14XJU69;

architecture STRUCTURE of m07_couplers_imp_14XJU69 is
  signal m07_couplers_to_m07_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m07_couplers_to_m07_couplers_ARREADY : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_ARVALID : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m07_couplers_to_m07_couplers_AWREADY : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_AWVALID : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_BREADY : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m07_couplers_to_m07_couplers_BVALID : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m07_couplers_to_m07_couplers_RREADY : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m07_couplers_to_m07_couplers_RVALID : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m07_couplers_to_m07_couplers_WREADY : STD_LOGIC;
  signal m07_couplers_to_m07_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m07_couplers_to_m07_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(8 downto 0) <= m07_couplers_to_m07_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid <= m07_couplers_to_m07_couplers_ARVALID;
  M_AXI_awaddr(8 downto 0) <= m07_couplers_to_m07_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid <= m07_couplers_to_m07_couplers_AWVALID;
  M_AXI_bready <= m07_couplers_to_m07_couplers_BREADY;
  M_AXI_rready <= m07_couplers_to_m07_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m07_couplers_to_m07_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m07_couplers_to_m07_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m07_couplers_to_m07_couplers_WVALID;
  S_AXI_arready <= m07_couplers_to_m07_couplers_ARREADY;
  S_AXI_awready <= m07_couplers_to_m07_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m07_couplers_to_m07_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m07_couplers_to_m07_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m07_couplers_to_m07_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m07_couplers_to_m07_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m07_couplers_to_m07_couplers_RVALID;
  S_AXI_wready <= m07_couplers_to_m07_couplers_WREADY;
  m07_couplers_to_m07_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m07_couplers_to_m07_couplers_ARREADY <= M_AXI_arready;
  m07_couplers_to_m07_couplers_ARVALID <= S_AXI_arvalid;
  m07_couplers_to_m07_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m07_couplers_to_m07_couplers_AWREADY <= M_AXI_awready;
  m07_couplers_to_m07_couplers_AWVALID <= S_AXI_awvalid;
  m07_couplers_to_m07_couplers_BREADY <= S_AXI_bready;
  m07_couplers_to_m07_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m07_couplers_to_m07_couplers_BVALID <= M_AXI_bvalid;
  m07_couplers_to_m07_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m07_couplers_to_m07_couplers_RREADY <= S_AXI_rready;
  m07_couplers_to_m07_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m07_couplers_to_m07_couplers_RVALID <= M_AXI_rvalid;
  m07_couplers_to_m07_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m07_couplers_to_m07_couplers_WREADY <= M_AXI_wready;
  m07_couplers_to_m07_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m07_couplers_to_m07_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m08_couplers_imp_RCGVF0 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m08_couplers_imp_RCGVF0;

architecture STRUCTURE of m08_couplers_imp_RCGVF0 is
  signal m08_couplers_to_m08_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m08_couplers_to_m08_couplers_ARREADY : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_ARVALID : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m08_couplers_to_m08_couplers_AWREADY : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_AWVALID : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_BREADY : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m08_couplers_to_m08_couplers_BVALID : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m08_couplers_to_m08_couplers_RREADY : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m08_couplers_to_m08_couplers_RVALID : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m08_couplers_to_m08_couplers_WREADY : STD_LOGIC;
  signal m08_couplers_to_m08_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m08_couplers_to_m08_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(8 downto 0) <= m08_couplers_to_m08_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid <= m08_couplers_to_m08_couplers_ARVALID;
  M_AXI_awaddr(8 downto 0) <= m08_couplers_to_m08_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid <= m08_couplers_to_m08_couplers_AWVALID;
  M_AXI_bready <= m08_couplers_to_m08_couplers_BREADY;
  M_AXI_rready <= m08_couplers_to_m08_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m08_couplers_to_m08_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m08_couplers_to_m08_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m08_couplers_to_m08_couplers_WVALID;
  S_AXI_arready <= m08_couplers_to_m08_couplers_ARREADY;
  S_AXI_awready <= m08_couplers_to_m08_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m08_couplers_to_m08_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m08_couplers_to_m08_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m08_couplers_to_m08_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m08_couplers_to_m08_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m08_couplers_to_m08_couplers_RVALID;
  S_AXI_wready <= m08_couplers_to_m08_couplers_WREADY;
  m08_couplers_to_m08_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m08_couplers_to_m08_couplers_ARREADY <= M_AXI_arready;
  m08_couplers_to_m08_couplers_ARVALID <= S_AXI_arvalid;
  m08_couplers_to_m08_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m08_couplers_to_m08_couplers_AWREADY <= M_AXI_awready;
  m08_couplers_to_m08_couplers_AWVALID <= S_AXI_awvalid;
  m08_couplers_to_m08_couplers_BREADY <= S_AXI_bready;
  m08_couplers_to_m08_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m08_couplers_to_m08_couplers_BVALID <= M_AXI_bvalid;
  m08_couplers_to_m08_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m08_couplers_to_m08_couplers_RREADY <= S_AXI_rready;
  m08_couplers_to_m08_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m08_couplers_to_m08_couplers_RVALID <= M_AXI_rvalid;
  m08_couplers_to_m08_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m08_couplers_to_m08_couplers_WREADY <= M_AXI_wready;
  m08_couplers_to_m08_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m08_couplers_to_m08_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity m09_couplers_imp_137EGXE is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m09_couplers_imp_137EGXE;

architecture STRUCTURE of m09_couplers_imp_137EGXE is
  signal m09_couplers_to_m09_couplers_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m09_couplers_to_m09_couplers_ARREADY : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_ARVALID : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m09_couplers_to_m09_couplers_AWREADY : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_AWVALID : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_BREADY : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m09_couplers_to_m09_couplers_BVALID : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m09_couplers_to_m09_couplers_RREADY : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m09_couplers_to_m09_couplers_RVALID : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m09_couplers_to_m09_couplers_WREADY : STD_LOGIC;
  signal m09_couplers_to_m09_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m09_couplers_to_m09_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(8 downto 0) <= m09_couplers_to_m09_couplers_ARADDR(8 downto 0);
  M_AXI_arvalid <= m09_couplers_to_m09_couplers_ARVALID;
  M_AXI_awaddr(8 downto 0) <= m09_couplers_to_m09_couplers_AWADDR(8 downto 0);
  M_AXI_awvalid <= m09_couplers_to_m09_couplers_AWVALID;
  M_AXI_bready <= m09_couplers_to_m09_couplers_BREADY;
  M_AXI_rready <= m09_couplers_to_m09_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m09_couplers_to_m09_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m09_couplers_to_m09_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m09_couplers_to_m09_couplers_WVALID;
  S_AXI_arready <= m09_couplers_to_m09_couplers_ARREADY;
  S_AXI_awready <= m09_couplers_to_m09_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m09_couplers_to_m09_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m09_couplers_to_m09_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m09_couplers_to_m09_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m09_couplers_to_m09_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m09_couplers_to_m09_couplers_RVALID;
  S_AXI_wready <= m09_couplers_to_m09_couplers_WREADY;
  m09_couplers_to_m09_couplers_ARADDR(8 downto 0) <= S_AXI_araddr(8 downto 0);
  m09_couplers_to_m09_couplers_ARREADY <= M_AXI_arready;
  m09_couplers_to_m09_couplers_ARVALID <= S_AXI_arvalid;
  m09_couplers_to_m09_couplers_AWADDR(8 downto 0) <= S_AXI_awaddr(8 downto 0);
  m09_couplers_to_m09_couplers_AWREADY <= M_AXI_awready;
  m09_couplers_to_m09_couplers_AWVALID <= S_AXI_awvalid;
  m09_couplers_to_m09_couplers_BREADY <= S_AXI_bready;
  m09_couplers_to_m09_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m09_couplers_to_m09_couplers_BVALID <= M_AXI_bvalid;
  m09_couplers_to_m09_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m09_couplers_to_m09_couplers_RREADY <= S_AXI_rready;
  m09_couplers_to_m09_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m09_couplers_to_m09_couplers_RVALID <= M_AXI_rvalid;
  m09_couplers_to_m09_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m09_couplers_to_m09_couplers_WREADY <= M_AXI_wready;
  m09_couplers_to_m09_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m09_couplers_to_m09_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity s00_couplers_imp_156Q4UY is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_156Q4UY;

architecture STRUCTURE of s00_couplers_imp_156Q4UY is
  component tutorial_auto_pc_7 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component tutorial_auto_pc_7;
  signal auto_pc_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s00_couplers_ARREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_ARVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s00_couplers_AWREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_AWVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_BREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s00_couplers_BVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s00_couplers_RREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s00_couplers_RVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s00_couplers_WREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s00_couplers_WVALID : STD_LOGIC;
  signal s00_couplers_to_auto_pc_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_auto_pc_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_pc_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_pc_ARID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal s00_couplers_to_auto_pc_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_pc_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_pc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_pc_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_pc_ARREADY : STD_LOGIC;
  signal s00_couplers_to_auto_pc_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_pc_ARVALID : STD_LOGIC;
  signal s00_couplers_to_auto_pc_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_auto_pc_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_pc_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_pc_AWID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal s00_couplers_to_auto_pc_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_pc_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_pc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_pc_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_pc_AWREADY : STD_LOGIC;
  signal s00_couplers_to_auto_pc_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_pc_AWVALID : STD_LOGIC;
  signal s00_couplers_to_auto_pc_BID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal s00_couplers_to_auto_pc_BREADY : STD_LOGIC;
  signal s00_couplers_to_auto_pc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_pc_BVALID : STD_LOGIC;
  signal s00_couplers_to_auto_pc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_auto_pc_RID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal s00_couplers_to_auto_pc_RLAST : STD_LOGIC;
  signal s00_couplers_to_auto_pc_RREADY : STD_LOGIC;
  signal s00_couplers_to_auto_pc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_pc_RVALID : STD_LOGIC;
  signal s00_couplers_to_auto_pc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_auto_pc_WID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal s00_couplers_to_auto_pc_WLAST : STD_LOGIC;
  signal s00_couplers_to_auto_pc_WREADY : STD_LOGIC;
  signal s00_couplers_to_auto_pc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_pc_WVALID : STD_LOGIC;
  signal s_aclk_1 : STD_LOGIC;
  signal s_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  M_AXI_araddr(31 downto 0) <= auto_pc_to_s00_couplers_ARADDR(31 downto 0);
  M_AXI_arprot(2 downto 0) <= auto_pc_to_s00_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= auto_pc_to_s00_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= auto_pc_to_s00_couplers_AWADDR(31 downto 0);
  M_AXI_awprot(2 downto 0) <= auto_pc_to_s00_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= auto_pc_to_s00_couplers_AWVALID;
  M_AXI_bready <= auto_pc_to_s00_couplers_BREADY;
  M_AXI_rready <= auto_pc_to_s00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_pc_to_s00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= auto_pc_to_s00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_pc_to_s00_couplers_WVALID;
  S_AXI_arready <= s00_couplers_to_auto_pc_ARREADY;
  S_AXI_awready <= s00_couplers_to_auto_pc_AWREADY;
  S_AXI_bid(11 downto 0) <= s00_couplers_to_auto_pc_BID(11 downto 0);
  S_AXI_bresp(1 downto 0) <= s00_couplers_to_auto_pc_BRESP(1 downto 0);
  S_AXI_bvalid <= s00_couplers_to_auto_pc_BVALID;
  S_AXI_rdata(31 downto 0) <= s00_couplers_to_auto_pc_RDATA(31 downto 0);
  S_AXI_rid(11 downto 0) <= s00_couplers_to_auto_pc_RID(11 downto 0);
  S_AXI_rlast <= s00_couplers_to_auto_pc_RLAST;
  S_AXI_rresp(1 downto 0) <= s00_couplers_to_auto_pc_RRESP(1 downto 0);
  S_AXI_rvalid <= s00_couplers_to_auto_pc_RVALID;
  S_AXI_wready <= s00_couplers_to_auto_pc_WREADY;
  auto_pc_to_s00_couplers_ARREADY <= M_AXI_arready;
  auto_pc_to_s00_couplers_AWREADY <= M_AXI_awready;
  auto_pc_to_s00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_pc_to_s00_couplers_BVALID <= M_AXI_bvalid;
  auto_pc_to_s00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_pc_to_s00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_pc_to_s00_couplers_RVALID <= M_AXI_rvalid;
  auto_pc_to_s00_couplers_WREADY <= M_AXI_wready;
  s00_couplers_to_auto_pc_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  s00_couplers_to_auto_pc_ARBURST(1 downto 0) <= S_AXI_arburst(1 downto 0);
  s00_couplers_to_auto_pc_ARCACHE(3 downto 0) <= S_AXI_arcache(3 downto 0);
  s00_couplers_to_auto_pc_ARID(11 downto 0) <= S_AXI_arid(11 downto 0);
  s00_couplers_to_auto_pc_ARLEN(3 downto 0) <= S_AXI_arlen(3 downto 0);
  s00_couplers_to_auto_pc_ARLOCK(1 downto 0) <= S_AXI_arlock(1 downto 0);
  s00_couplers_to_auto_pc_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s00_couplers_to_auto_pc_ARQOS(3 downto 0) <= S_AXI_arqos(3 downto 0);
  s00_couplers_to_auto_pc_ARSIZE(2 downto 0) <= S_AXI_arsize(2 downto 0);
  s00_couplers_to_auto_pc_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_auto_pc_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  s00_couplers_to_auto_pc_AWBURST(1 downto 0) <= S_AXI_awburst(1 downto 0);
  s00_couplers_to_auto_pc_AWCACHE(3 downto 0) <= S_AXI_awcache(3 downto 0);
  s00_couplers_to_auto_pc_AWID(11 downto 0) <= S_AXI_awid(11 downto 0);
  s00_couplers_to_auto_pc_AWLEN(3 downto 0) <= S_AXI_awlen(3 downto 0);
  s00_couplers_to_auto_pc_AWLOCK(1 downto 0) <= S_AXI_awlock(1 downto 0);
  s00_couplers_to_auto_pc_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s00_couplers_to_auto_pc_AWQOS(3 downto 0) <= S_AXI_awqos(3 downto 0);
  s00_couplers_to_auto_pc_AWSIZE(2 downto 0) <= S_AXI_awsize(2 downto 0);
  s00_couplers_to_auto_pc_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_auto_pc_BREADY <= S_AXI_bready;
  s00_couplers_to_auto_pc_RREADY <= S_AXI_rready;
  s00_couplers_to_auto_pc_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  s00_couplers_to_auto_pc_WID(11 downto 0) <= S_AXI_wid(11 downto 0);
  s00_couplers_to_auto_pc_WLAST <= S_AXI_wlast;
  s00_couplers_to_auto_pc_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  s00_couplers_to_auto_pc_WVALID <= S_AXI_wvalid;
  s_aclk_1 <= S_ACLK;
  s_aresetn_1(0) <= S_ARESETN(0);
auto_pc: component tutorial_auto_pc_7
    port map (
      aclk => s_aclk_1,
      aresetn => s_aresetn_1(0),
      m_axi_araddr(31 downto 0) => auto_pc_to_s00_couplers_ARADDR(31 downto 0),
      m_axi_arprot(2 downto 0) => auto_pc_to_s00_couplers_ARPROT(2 downto 0),
      m_axi_arready => auto_pc_to_s00_couplers_ARREADY,
      m_axi_arvalid => auto_pc_to_s00_couplers_ARVALID,
      m_axi_awaddr(31 downto 0) => auto_pc_to_s00_couplers_AWADDR(31 downto 0),
      m_axi_awprot(2 downto 0) => auto_pc_to_s00_couplers_AWPROT(2 downto 0),
      m_axi_awready => auto_pc_to_s00_couplers_AWREADY,
      m_axi_awvalid => auto_pc_to_s00_couplers_AWVALID,
      m_axi_bready => auto_pc_to_s00_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_pc_to_s00_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_pc_to_s00_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_pc_to_s00_couplers_RDATA(31 downto 0),
      m_axi_rready => auto_pc_to_s00_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_pc_to_s00_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_pc_to_s00_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_pc_to_s00_couplers_WDATA(31 downto 0),
      m_axi_wready => auto_pc_to_s00_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_pc_to_s00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_pc_to_s00_couplers_WVALID,
      s_axi_araddr(31 downto 0) => s00_couplers_to_auto_pc_ARADDR(31 downto 0),
      s_axi_arburst(1 downto 0) => s00_couplers_to_auto_pc_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => s00_couplers_to_auto_pc_ARCACHE(3 downto 0),
      s_axi_arid(11 downto 0) => s00_couplers_to_auto_pc_ARID(11 downto 0),
      s_axi_arlen(3 downto 0) => s00_couplers_to_auto_pc_ARLEN(3 downto 0),
      s_axi_arlock(1 downto 0) => s00_couplers_to_auto_pc_ARLOCK(1 downto 0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_auto_pc_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => s00_couplers_to_auto_pc_ARQOS(3 downto 0),
      s_axi_arready => s00_couplers_to_auto_pc_ARREADY,
      s_axi_arsize(2 downto 0) => s00_couplers_to_auto_pc_ARSIZE(2 downto 0),
      s_axi_arvalid => s00_couplers_to_auto_pc_ARVALID,
      s_axi_awaddr(31 downto 0) => s00_couplers_to_auto_pc_AWADDR(31 downto 0),
      s_axi_awburst(1 downto 0) => s00_couplers_to_auto_pc_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => s00_couplers_to_auto_pc_AWCACHE(3 downto 0),
      s_axi_awid(11 downto 0) => s00_couplers_to_auto_pc_AWID(11 downto 0),
      s_axi_awlen(3 downto 0) => s00_couplers_to_auto_pc_AWLEN(3 downto 0),
      s_axi_awlock(1 downto 0) => s00_couplers_to_auto_pc_AWLOCK(1 downto 0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_auto_pc_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => s00_couplers_to_auto_pc_AWQOS(3 downto 0),
      s_axi_awready => s00_couplers_to_auto_pc_AWREADY,
      s_axi_awsize(2 downto 0) => s00_couplers_to_auto_pc_AWSIZE(2 downto 0),
      s_axi_awvalid => s00_couplers_to_auto_pc_AWVALID,
      s_axi_bid(11 downto 0) => s00_couplers_to_auto_pc_BID(11 downto 0),
      s_axi_bready => s00_couplers_to_auto_pc_BREADY,
      s_axi_bresp(1 downto 0) => s00_couplers_to_auto_pc_BRESP(1 downto 0),
      s_axi_bvalid => s00_couplers_to_auto_pc_BVALID,
      s_axi_rdata(31 downto 0) => s00_couplers_to_auto_pc_RDATA(31 downto 0),
      s_axi_rid(11 downto 0) => s00_couplers_to_auto_pc_RID(11 downto 0),
      s_axi_rlast => s00_couplers_to_auto_pc_RLAST,
      s_axi_rready => s00_couplers_to_auto_pc_RREADY,
      s_axi_rresp(1 downto 0) => s00_couplers_to_auto_pc_RRESP(1 downto 0),
      s_axi_rvalid => s00_couplers_to_auto_pc_RVALID,
      s_axi_wdata(31 downto 0) => s00_couplers_to_auto_pc_WDATA(31 downto 0),
      s_axi_wid(11 downto 0) => s00_couplers_to_auto_pc_WID(11 downto 0),
      s_axi_wlast => s00_couplers_to_auto_pc_WLAST,
      s_axi_wready => s00_couplers_to_auto_pc_WREADY,
      s_axi_wstrb(3 downto 0) => s00_couplers_to_auto_pc_WSTRB(3 downto 0),
      s_axi_wvalid => s00_couplers_to_auto_pc_WVALID
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity tutorial_processing_system7_0_axi_periph_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M00_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M00_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M01_ACLK : in STD_LOGIC;
    M01_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M01_AXI_araddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M01_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M01_AXI_arready : in STD_LOGIC;
    M01_AXI_arvalid : out STD_LOGIC;
    M01_AXI_awaddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M01_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M01_AXI_awready : in STD_LOGIC;
    M01_AXI_awvalid : out STD_LOGIC;
    M01_AXI_bready : out STD_LOGIC;
    M01_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_bvalid : in STD_LOGIC;
    M01_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_rready : out STD_LOGIC;
    M01_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_rvalid : in STD_LOGIC;
    M01_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_wready : in STD_LOGIC;
    M01_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M01_AXI_wvalid : out STD_LOGIC;
    M02_ACLK : in STD_LOGIC;
    M02_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M02_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M02_AXI_arready : in STD_LOGIC;
    M02_AXI_arvalid : out STD_LOGIC;
    M02_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M02_AXI_awready : in STD_LOGIC;
    M02_AXI_awvalid : out STD_LOGIC;
    M02_AXI_bready : out STD_LOGIC;
    M02_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_bvalid : in STD_LOGIC;
    M02_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_rready : out STD_LOGIC;
    M02_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_rvalid : in STD_LOGIC;
    M02_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_wready : in STD_LOGIC;
    M02_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_wvalid : out STD_LOGIC;
    M03_ACLK : in STD_LOGIC;
    M03_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M03_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M03_AXI_arready : in STD_LOGIC;
    M03_AXI_arvalid : out STD_LOGIC;
    M03_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M03_AXI_awready : in STD_LOGIC;
    M03_AXI_awvalid : out STD_LOGIC;
    M03_AXI_bready : out STD_LOGIC;
    M03_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_bvalid : in STD_LOGIC;
    M03_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_rready : out STD_LOGIC;
    M03_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_rvalid : in STD_LOGIC;
    M03_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_wready : in STD_LOGIC;
    M03_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M03_AXI_wvalid : out STD_LOGIC;
    M04_ACLK : in STD_LOGIC;
    M04_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M04_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M04_AXI_arready : in STD_LOGIC;
    M04_AXI_arvalid : out STD_LOGIC;
    M04_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M04_AXI_awready : in STD_LOGIC;
    M04_AXI_awvalid : out STD_LOGIC;
    M04_AXI_bready : out STD_LOGIC;
    M04_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_bvalid : in STD_LOGIC;
    M04_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_rready : out STD_LOGIC;
    M04_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_rvalid : in STD_LOGIC;
    M04_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_wready : in STD_LOGIC;
    M04_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M04_AXI_wvalid : out STD_LOGIC;
    M05_ACLK : in STD_LOGIC;
    M05_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M05_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M05_AXI_arready : in STD_LOGIC;
    M05_AXI_arvalid : out STD_LOGIC;
    M05_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M05_AXI_awready : in STD_LOGIC;
    M05_AXI_awvalid : out STD_LOGIC;
    M05_AXI_bready : out STD_LOGIC;
    M05_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M05_AXI_bvalid : in STD_LOGIC;
    M05_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M05_AXI_rready : out STD_LOGIC;
    M05_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M05_AXI_rvalid : in STD_LOGIC;
    M05_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M05_AXI_wready : in STD_LOGIC;
    M05_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M05_AXI_wvalid : out STD_LOGIC;
    M06_ACLK : in STD_LOGIC;
    M06_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M06_AXI_araddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M06_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M06_AXI_arready : in STD_LOGIC;
    M06_AXI_arvalid : out STD_LOGIC;
    M06_AXI_awaddr : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M06_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M06_AXI_awready : in STD_LOGIC;
    M06_AXI_awvalid : out STD_LOGIC;
    M06_AXI_bready : out STD_LOGIC;
    M06_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M06_AXI_bvalid : in STD_LOGIC;
    M06_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M06_AXI_rready : out STD_LOGIC;
    M06_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M06_AXI_rvalid : in STD_LOGIC;
    M06_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M06_AXI_wready : in STD_LOGIC;
    M06_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M06_AXI_wvalid : out STD_LOGIC;
    M07_ACLK : in STD_LOGIC;
    M07_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M07_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M07_AXI_arready : in STD_LOGIC;
    M07_AXI_arvalid : out STD_LOGIC;
    M07_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M07_AXI_awready : in STD_LOGIC;
    M07_AXI_awvalid : out STD_LOGIC;
    M07_AXI_bready : out STD_LOGIC;
    M07_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M07_AXI_bvalid : in STD_LOGIC;
    M07_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M07_AXI_rready : out STD_LOGIC;
    M07_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M07_AXI_rvalid : in STD_LOGIC;
    M07_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M07_AXI_wready : in STD_LOGIC;
    M07_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M07_AXI_wvalid : out STD_LOGIC;
    M08_ACLK : in STD_LOGIC;
    M08_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M08_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M08_AXI_arready : in STD_LOGIC;
    M08_AXI_arvalid : out STD_LOGIC;
    M08_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M08_AXI_awready : in STD_LOGIC;
    M08_AXI_awvalid : out STD_LOGIC;
    M08_AXI_bready : out STD_LOGIC;
    M08_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M08_AXI_bvalid : in STD_LOGIC;
    M08_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M08_AXI_rready : out STD_LOGIC;
    M08_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M08_AXI_rvalid : in STD_LOGIC;
    M08_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M08_AXI_wready : in STD_LOGIC;
    M08_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M08_AXI_wvalid : out STD_LOGIC;
    M09_ACLK : in STD_LOGIC;
    M09_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M09_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M09_AXI_arready : in STD_LOGIC;
    M09_AXI_arvalid : out STD_LOGIC;
    M09_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M09_AXI_awready : in STD_LOGIC;
    M09_AXI_awvalid : out STD_LOGIC;
    M09_AXI_bready : out STD_LOGIC;
    M09_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M09_AXI_bvalid : in STD_LOGIC;
    M09_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M09_AXI_rready : out STD_LOGIC;
    M09_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M09_AXI_rvalid : in STD_LOGIC;
    M09_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M09_AXI_wready : in STD_LOGIC;
    M09_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M09_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_wlast : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC
  );
end tutorial_processing_system7_0_axi_periph_0;

architecture STRUCTURE of tutorial_processing_system7_0_axi_periph_0 is
  component tutorial_xbar_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 319 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 29 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 319 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 19 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 319 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 29 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 319 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 19 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  end component tutorial_xbar_1;
  signal m00_aclk_1 : STD_LOGIC;
  signal m00_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m01_aclk_1 : STD_LOGIC;
  signal m01_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m01_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m01_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m02_aclk_1 : STD_LOGIC;
  signal m02_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m02_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m03_aclk_1 : STD_LOGIC;
  signal m03_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m03_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m03_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m04_aclk_1 : STD_LOGIC;
  signal m04_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m04_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m04_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m05_aclk_1 : STD_LOGIC;
  signal m05_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m05_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m05_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m06_aclk_1 : STD_LOGIC;
  signal m06_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m06_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m06_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m07_aclk_1 : STD_LOGIC;
  signal m07_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m07_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m07_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m08_aclk_1 : STD_LOGIC;
  signal m08_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m08_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m08_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal m09_aclk_1 : STD_LOGIC;
  signal m09_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_ARREADY : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_ARVALID : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_AWREADY : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_AWVALID : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_BREADY : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_BVALID : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_RREADY : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_RVALID : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_WREADY : STD_LOGIC;
  signal m09_couplers_to_processing_system7_0_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m09_couplers_to_processing_system7_0_axi_periph_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_ACLK_net : STD_LOGIC;
  signal processing_system7_0_axi_periph_ARESETN_net : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_BID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_RID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_RLAST : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_WID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_WLAST : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_to_s00_couplers_WVALID : STD_LOGIC;
  signal s00_aclk_1 : STD_LOGIC;
  signal s00_aresetn_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_WVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_ARPROT : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal xbar_to_m01_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_ARVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_AWPROT : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal xbar_to_m01_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_AWVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m01_couplers_RREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_WSTRB : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal xbar_to_m01_couplers_WVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m02_couplers_ARADDR : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal xbar_to_m02_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_ARVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_AWADDR : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal xbar_to_m02_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_AWVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_BREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m02_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m02_couplers_RREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m02_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m02_couplers_WDATA : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal xbar_to_m02_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_WSTRB : STD_LOGIC_VECTOR ( 11 downto 8 );
  signal xbar_to_m02_couplers_WVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m03_couplers_ARADDR : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal xbar_to_m03_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_ARVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_AWADDR : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal xbar_to_m03_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_AWVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_BREADY : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m03_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m03_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m03_couplers_RREADY : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m03_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m03_couplers_WDATA : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal xbar_to_m03_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_WSTRB : STD_LOGIC_VECTOR ( 15 downto 12 );
  signal xbar_to_m03_couplers_WVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m04_couplers_ARADDR : STD_LOGIC_VECTOR ( 159 downto 128 );
  signal xbar_to_m04_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_ARVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_AWADDR : STD_LOGIC_VECTOR ( 159 downto 128 );
  signal xbar_to_m04_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_AWVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_BREADY : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m04_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m04_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m04_couplers_RREADY : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m04_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m04_couplers_WDATA : STD_LOGIC_VECTOR ( 159 downto 128 );
  signal xbar_to_m04_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_WSTRB : STD_LOGIC_VECTOR ( 19 downto 16 );
  signal xbar_to_m04_couplers_WVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m05_couplers_ARADDR : STD_LOGIC_VECTOR ( 191 downto 160 );
  signal xbar_to_m05_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m05_couplers_ARVALID : STD_LOGIC_VECTOR ( 5 to 5 );
  signal xbar_to_m05_couplers_AWADDR : STD_LOGIC_VECTOR ( 191 downto 160 );
  signal xbar_to_m05_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m05_couplers_AWVALID : STD_LOGIC_VECTOR ( 5 to 5 );
  signal xbar_to_m05_couplers_BREADY : STD_LOGIC_VECTOR ( 5 to 5 );
  signal xbar_to_m05_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m05_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m05_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m05_couplers_RREADY : STD_LOGIC_VECTOR ( 5 to 5 );
  signal xbar_to_m05_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m05_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m05_couplers_WDATA : STD_LOGIC_VECTOR ( 191 downto 160 );
  signal xbar_to_m05_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m05_couplers_WSTRB : STD_LOGIC_VECTOR ( 23 downto 20 );
  signal xbar_to_m05_couplers_WVALID : STD_LOGIC_VECTOR ( 5 to 5 );
  signal xbar_to_m06_couplers_ARADDR : STD_LOGIC_VECTOR ( 223 downto 192 );
  signal xbar_to_m06_couplers_ARPROT : STD_LOGIC_VECTOR ( 20 downto 18 );
  signal xbar_to_m06_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m06_couplers_ARVALID : STD_LOGIC_VECTOR ( 6 to 6 );
  signal xbar_to_m06_couplers_AWADDR : STD_LOGIC_VECTOR ( 223 downto 192 );
  signal xbar_to_m06_couplers_AWPROT : STD_LOGIC_VECTOR ( 20 downto 18 );
  signal xbar_to_m06_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m06_couplers_AWVALID : STD_LOGIC_VECTOR ( 6 to 6 );
  signal xbar_to_m06_couplers_BREADY : STD_LOGIC_VECTOR ( 6 to 6 );
  signal xbar_to_m06_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m06_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m06_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m06_couplers_RREADY : STD_LOGIC_VECTOR ( 6 to 6 );
  signal xbar_to_m06_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m06_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m06_couplers_WDATA : STD_LOGIC_VECTOR ( 223 downto 192 );
  signal xbar_to_m06_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m06_couplers_WSTRB : STD_LOGIC_VECTOR ( 27 downto 24 );
  signal xbar_to_m06_couplers_WVALID : STD_LOGIC_VECTOR ( 6 to 6 );
  signal xbar_to_m07_couplers_ARADDR : STD_LOGIC_VECTOR ( 255 downto 224 );
  signal xbar_to_m07_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m07_couplers_ARVALID : STD_LOGIC_VECTOR ( 7 to 7 );
  signal xbar_to_m07_couplers_AWADDR : STD_LOGIC_VECTOR ( 255 downto 224 );
  signal xbar_to_m07_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m07_couplers_AWVALID : STD_LOGIC_VECTOR ( 7 to 7 );
  signal xbar_to_m07_couplers_BREADY : STD_LOGIC_VECTOR ( 7 to 7 );
  signal xbar_to_m07_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m07_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m07_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m07_couplers_RREADY : STD_LOGIC_VECTOR ( 7 to 7 );
  signal xbar_to_m07_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m07_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m07_couplers_WDATA : STD_LOGIC_VECTOR ( 255 downto 224 );
  signal xbar_to_m07_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m07_couplers_WSTRB : STD_LOGIC_VECTOR ( 31 downto 28 );
  signal xbar_to_m07_couplers_WVALID : STD_LOGIC_VECTOR ( 7 to 7 );
  signal xbar_to_m08_couplers_ARADDR : STD_LOGIC_VECTOR ( 287 downto 256 );
  signal xbar_to_m08_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m08_couplers_ARVALID : STD_LOGIC_VECTOR ( 8 to 8 );
  signal xbar_to_m08_couplers_AWADDR : STD_LOGIC_VECTOR ( 287 downto 256 );
  signal xbar_to_m08_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m08_couplers_AWVALID : STD_LOGIC_VECTOR ( 8 to 8 );
  signal xbar_to_m08_couplers_BREADY : STD_LOGIC_VECTOR ( 8 to 8 );
  signal xbar_to_m08_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m08_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m08_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m08_couplers_RREADY : STD_LOGIC_VECTOR ( 8 to 8 );
  signal xbar_to_m08_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m08_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m08_couplers_WDATA : STD_LOGIC_VECTOR ( 287 downto 256 );
  signal xbar_to_m08_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m08_couplers_WSTRB : STD_LOGIC_VECTOR ( 35 downto 32 );
  signal xbar_to_m08_couplers_WVALID : STD_LOGIC_VECTOR ( 8 to 8 );
  signal xbar_to_m09_couplers_ARADDR : STD_LOGIC_VECTOR ( 319 downto 288 );
  signal xbar_to_m09_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m09_couplers_ARVALID : STD_LOGIC_VECTOR ( 9 to 9 );
  signal xbar_to_m09_couplers_AWADDR : STD_LOGIC_VECTOR ( 319 downto 288 );
  signal xbar_to_m09_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m09_couplers_AWVALID : STD_LOGIC_VECTOR ( 9 to 9 );
  signal xbar_to_m09_couplers_BREADY : STD_LOGIC_VECTOR ( 9 to 9 );
  signal xbar_to_m09_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m09_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m09_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m09_couplers_RREADY : STD_LOGIC_VECTOR ( 9 to 9 );
  signal xbar_to_m09_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m09_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m09_couplers_WDATA : STD_LOGIC_VECTOR ( 319 downto 288 );
  signal xbar_to_m09_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m09_couplers_WSTRB : STD_LOGIC_VECTOR ( 39 downto 36 );
  signal xbar_to_m09_couplers_WVALID : STD_LOGIC_VECTOR ( 9 to 9 );
  signal NLW_xbar_m_axi_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_xbar_m_axi_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
begin
  M00_AXI_araddr(8 downto 0) <= m00_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M00_AXI_arvalid(0) <= m00_couplers_to_processing_system7_0_axi_periph_ARVALID(0);
  M00_AXI_awaddr(8 downto 0) <= m00_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M00_AXI_awvalid(0) <= m00_couplers_to_processing_system7_0_axi_periph_AWVALID(0);
  M00_AXI_bready(0) <= m00_couplers_to_processing_system7_0_axi_periph_BREADY(0);
  M00_AXI_rready(0) <= m00_couplers_to_processing_system7_0_axi_periph_RREADY(0);
  M00_AXI_wdata(31 downto 0) <= m00_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M00_AXI_wstrb(3 downto 0) <= m00_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M00_AXI_wvalid(0) <= m00_couplers_to_processing_system7_0_axi_periph_WVALID(0);
  M01_AXI_araddr(7 downto 0) <= m01_couplers_to_processing_system7_0_axi_periph_ARADDR(7 downto 0);
  M01_AXI_arprot(2 downto 0) <= m01_couplers_to_processing_system7_0_axi_periph_ARPROT(2 downto 0);
  M01_AXI_arvalid <= m01_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M01_AXI_awaddr(7 downto 0) <= m01_couplers_to_processing_system7_0_axi_periph_AWADDR(7 downto 0);
  M01_AXI_awprot(2 downto 0) <= m01_couplers_to_processing_system7_0_axi_periph_AWPROT(2 downto 0);
  M01_AXI_awvalid <= m01_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M01_AXI_bready <= m01_couplers_to_processing_system7_0_axi_periph_BREADY;
  M01_AXI_rready <= m01_couplers_to_processing_system7_0_axi_periph_RREADY;
  M01_AXI_wdata(31 downto 0) <= m01_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M01_AXI_wstrb(3 downto 0) <= m01_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M01_AXI_wvalid <= m01_couplers_to_processing_system7_0_axi_periph_WVALID;
  M02_AXI_araddr(8 downto 0) <= m02_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M02_AXI_arvalid <= m02_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M02_AXI_awaddr(8 downto 0) <= m02_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M02_AXI_awvalid <= m02_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M02_AXI_bready <= m02_couplers_to_processing_system7_0_axi_periph_BREADY;
  M02_AXI_rready <= m02_couplers_to_processing_system7_0_axi_periph_RREADY;
  M02_AXI_wdata(31 downto 0) <= m02_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M02_AXI_wstrb(3 downto 0) <= m02_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M02_AXI_wvalid <= m02_couplers_to_processing_system7_0_axi_periph_WVALID;
  M03_AXI_araddr(8 downto 0) <= m03_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M03_AXI_arvalid <= m03_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M03_AXI_awaddr(8 downto 0) <= m03_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M03_AXI_awvalid <= m03_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M03_AXI_bready <= m03_couplers_to_processing_system7_0_axi_periph_BREADY;
  M03_AXI_rready <= m03_couplers_to_processing_system7_0_axi_periph_RREADY;
  M03_AXI_wdata(31 downto 0) <= m03_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M03_AXI_wstrb(3 downto 0) <= m03_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M03_AXI_wvalid <= m03_couplers_to_processing_system7_0_axi_periph_WVALID;
  M04_AXI_araddr(8 downto 0) <= m04_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M04_AXI_arvalid <= m04_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M04_AXI_awaddr(8 downto 0) <= m04_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M04_AXI_awvalid <= m04_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M04_AXI_bready <= m04_couplers_to_processing_system7_0_axi_periph_BREADY;
  M04_AXI_rready <= m04_couplers_to_processing_system7_0_axi_periph_RREADY;
  M04_AXI_wdata(31 downto 0) <= m04_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M04_AXI_wstrb(3 downto 0) <= m04_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M04_AXI_wvalid <= m04_couplers_to_processing_system7_0_axi_periph_WVALID;
  M05_AXI_araddr(8 downto 0) <= m05_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M05_AXI_arvalid <= m05_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M05_AXI_awaddr(8 downto 0) <= m05_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M05_AXI_awvalid <= m05_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M05_AXI_bready <= m05_couplers_to_processing_system7_0_axi_periph_BREADY;
  M05_AXI_rready <= m05_couplers_to_processing_system7_0_axi_periph_RREADY;
  M05_AXI_wdata(31 downto 0) <= m05_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M05_AXI_wstrb(3 downto 0) <= m05_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M05_AXI_wvalid <= m05_couplers_to_processing_system7_0_axi_periph_WVALID;
  M06_AXI_araddr(7 downto 0) <= m06_couplers_to_processing_system7_0_axi_periph_ARADDR(7 downto 0);
  M06_AXI_arprot(2 downto 0) <= m06_couplers_to_processing_system7_0_axi_periph_ARPROT(2 downto 0);
  M06_AXI_arvalid <= m06_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M06_AXI_awaddr(7 downto 0) <= m06_couplers_to_processing_system7_0_axi_periph_AWADDR(7 downto 0);
  M06_AXI_awprot(2 downto 0) <= m06_couplers_to_processing_system7_0_axi_periph_AWPROT(2 downto 0);
  M06_AXI_awvalid <= m06_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M06_AXI_bready <= m06_couplers_to_processing_system7_0_axi_periph_BREADY;
  M06_AXI_rready <= m06_couplers_to_processing_system7_0_axi_periph_RREADY;
  M06_AXI_wdata(31 downto 0) <= m06_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M06_AXI_wstrb(3 downto 0) <= m06_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M06_AXI_wvalid <= m06_couplers_to_processing_system7_0_axi_periph_WVALID;
  M07_AXI_araddr(8 downto 0) <= m07_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M07_AXI_arvalid <= m07_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M07_AXI_awaddr(8 downto 0) <= m07_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M07_AXI_awvalid <= m07_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M07_AXI_bready <= m07_couplers_to_processing_system7_0_axi_periph_BREADY;
  M07_AXI_rready <= m07_couplers_to_processing_system7_0_axi_periph_RREADY;
  M07_AXI_wdata(31 downto 0) <= m07_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M07_AXI_wstrb(3 downto 0) <= m07_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M07_AXI_wvalid <= m07_couplers_to_processing_system7_0_axi_periph_WVALID;
  M08_AXI_araddr(8 downto 0) <= m08_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M08_AXI_arvalid <= m08_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M08_AXI_awaddr(8 downto 0) <= m08_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M08_AXI_awvalid <= m08_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M08_AXI_bready <= m08_couplers_to_processing_system7_0_axi_periph_BREADY;
  M08_AXI_rready <= m08_couplers_to_processing_system7_0_axi_periph_RREADY;
  M08_AXI_wdata(31 downto 0) <= m08_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M08_AXI_wstrb(3 downto 0) <= m08_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M08_AXI_wvalid <= m08_couplers_to_processing_system7_0_axi_periph_WVALID;
  M09_AXI_araddr(8 downto 0) <= m09_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0);
  M09_AXI_arvalid <= m09_couplers_to_processing_system7_0_axi_periph_ARVALID;
  M09_AXI_awaddr(8 downto 0) <= m09_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0);
  M09_AXI_awvalid <= m09_couplers_to_processing_system7_0_axi_periph_AWVALID;
  M09_AXI_bready <= m09_couplers_to_processing_system7_0_axi_periph_BREADY;
  M09_AXI_rready <= m09_couplers_to_processing_system7_0_axi_periph_RREADY;
  M09_AXI_wdata(31 downto 0) <= m09_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0);
  M09_AXI_wstrb(3 downto 0) <= m09_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0);
  M09_AXI_wvalid <= m09_couplers_to_processing_system7_0_axi_periph_WVALID;
  S00_AXI_arready <= processing_system7_0_axi_periph_to_s00_couplers_ARREADY;
  S00_AXI_awready <= processing_system7_0_axi_periph_to_s00_couplers_AWREADY;
  S00_AXI_bid(11 downto 0) <= processing_system7_0_axi_periph_to_s00_couplers_BID(11 downto 0);
  S00_AXI_bresp(1 downto 0) <= processing_system7_0_axi_periph_to_s00_couplers_BRESP(1 downto 0);
  S00_AXI_bvalid <= processing_system7_0_axi_periph_to_s00_couplers_BVALID;
  S00_AXI_rdata(31 downto 0) <= processing_system7_0_axi_periph_to_s00_couplers_RDATA(31 downto 0);
  S00_AXI_rid(11 downto 0) <= processing_system7_0_axi_periph_to_s00_couplers_RID(11 downto 0);
  S00_AXI_rlast <= processing_system7_0_axi_periph_to_s00_couplers_RLAST;
  S00_AXI_rresp(1 downto 0) <= processing_system7_0_axi_periph_to_s00_couplers_RRESP(1 downto 0);
  S00_AXI_rvalid <= processing_system7_0_axi_periph_to_s00_couplers_RVALID;
  S00_AXI_wready <= processing_system7_0_axi_periph_to_s00_couplers_WREADY;
  m00_aclk_1 <= M00_ACLK;
  m00_aresetn_1(0) <= M00_ARESETN(0);
  m00_couplers_to_processing_system7_0_axi_periph_ARREADY(0) <= M00_AXI_arready(0);
  m00_couplers_to_processing_system7_0_axi_periph_AWREADY(0) <= M00_AXI_awready(0);
  m00_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M00_AXI_bresp(1 downto 0);
  m00_couplers_to_processing_system7_0_axi_periph_BVALID(0) <= M00_AXI_bvalid(0);
  m00_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M00_AXI_rdata(31 downto 0);
  m00_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M00_AXI_rresp(1 downto 0);
  m00_couplers_to_processing_system7_0_axi_periph_RVALID(0) <= M00_AXI_rvalid(0);
  m00_couplers_to_processing_system7_0_axi_periph_WREADY(0) <= M00_AXI_wready(0);
  m01_aclk_1 <= M01_ACLK;
  m01_aresetn_1(0) <= M01_ARESETN(0);
  m01_couplers_to_processing_system7_0_axi_periph_ARREADY <= M01_AXI_arready;
  m01_couplers_to_processing_system7_0_axi_periph_AWREADY <= M01_AXI_awready;
  m01_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M01_AXI_bresp(1 downto 0);
  m01_couplers_to_processing_system7_0_axi_periph_BVALID <= M01_AXI_bvalid;
  m01_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M01_AXI_rdata(31 downto 0);
  m01_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M01_AXI_rresp(1 downto 0);
  m01_couplers_to_processing_system7_0_axi_periph_RVALID <= M01_AXI_rvalid;
  m01_couplers_to_processing_system7_0_axi_periph_WREADY <= M01_AXI_wready;
  m02_aclk_1 <= M02_ACLK;
  m02_aresetn_1(0) <= M02_ARESETN(0);
  m02_couplers_to_processing_system7_0_axi_periph_ARREADY <= M02_AXI_arready;
  m02_couplers_to_processing_system7_0_axi_periph_AWREADY <= M02_AXI_awready;
  m02_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M02_AXI_bresp(1 downto 0);
  m02_couplers_to_processing_system7_0_axi_periph_BVALID <= M02_AXI_bvalid;
  m02_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M02_AXI_rdata(31 downto 0);
  m02_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M02_AXI_rresp(1 downto 0);
  m02_couplers_to_processing_system7_0_axi_periph_RVALID <= M02_AXI_rvalid;
  m02_couplers_to_processing_system7_0_axi_periph_WREADY <= M02_AXI_wready;
  m03_aclk_1 <= M03_ACLK;
  m03_aresetn_1(0) <= M03_ARESETN(0);
  m03_couplers_to_processing_system7_0_axi_periph_ARREADY <= M03_AXI_arready;
  m03_couplers_to_processing_system7_0_axi_periph_AWREADY <= M03_AXI_awready;
  m03_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M03_AXI_bresp(1 downto 0);
  m03_couplers_to_processing_system7_0_axi_periph_BVALID <= M03_AXI_bvalid;
  m03_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M03_AXI_rdata(31 downto 0);
  m03_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M03_AXI_rresp(1 downto 0);
  m03_couplers_to_processing_system7_0_axi_periph_RVALID <= M03_AXI_rvalid;
  m03_couplers_to_processing_system7_0_axi_periph_WREADY <= M03_AXI_wready;
  m04_aclk_1 <= M04_ACLK;
  m04_aresetn_1(0) <= M04_ARESETN(0);
  m04_couplers_to_processing_system7_0_axi_periph_ARREADY <= M04_AXI_arready;
  m04_couplers_to_processing_system7_0_axi_periph_AWREADY <= M04_AXI_awready;
  m04_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M04_AXI_bresp(1 downto 0);
  m04_couplers_to_processing_system7_0_axi_periph_BVALID <= M04_AXI_bvalid;
  m04_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M04_AXI_rdata(31 downto 0);
  m04_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M04_AXI_rresp(1 downto 0);
  m04_couplers_to_processing_system7_0_axi_periph_RVALID <= M04_AXI_rvalid;
  m04_couplers_to_processing_system7_0_axi_periph_WREADY <= M04_AXI_wready;
  m05_aclk_1 <= M05_ACLK;
  m05_aresetn_1(0) <= M05_ARESETN(0);
  m05_couplers_to_processing_system7_0_axi_periph_ARREADY <= M05_AXI_arready;
  m05_couplers_to_processing_system7_0_axi_periph_AWREADY <= M05_AXI_awready;
  m05_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M05_AXI_bresp(1 downto 0);
  m05_couplers_to_processing_system7_0_axi_periph_BVALID <= M05_AXI_bvalid;
  m05_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M05_AXI_rdata(31 downto 0);
  m05_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M05_AXI_rresp(1 downto 0);
  m05_couplers_to_processing_system7_0_axi_periph_RVALID <= M05_AXI_rvalid;
  m05_couplers_to_processing_system7_0_axi_periph_WREADY <= M05_AXI_wready;
  m06_aclk_1 <= M06_ACLK;
  m06_aresetn_1(0) <= M06_ARESETN(0);
  m06_couplers_to_processing_system7_0_axi_periph_ARREADY <= M06_AXI_arready;
  m06_couplers_to_processing_system7_0_axi_periph_AWREADY <= M06_AXI_awready;
  m06_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M06_AXI_bresp(1 downto 0);
  m06_couplers_to_processing_system7_0_axi_periph_BVALID <= M06_AXI_bvalid;
  m06_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M06_AXI_rdata(31 downto 0);
  m06_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M06_AXI_rresp(1 downto 0);
  m06_couplers_to_processing_system7_0_axi_periph_RVALID <= M06_AXI_rvalid;
  m06_couplers_to_processing_system7_0_axi_periph_WREADY <= M06_AXI_wready;
  m07_aclk_1 <= M07_ACLK;
  m07_aresetn_1(0) <= M07_ARESETN(0);
  m07_couplers_to_processing_system7_0_axi_periph_ARREADY <= M07_AXI_arready;
  m07_couplers_to_processing_system7_0_axi_periph_AWREADY <= M07_AXI_awready;
  m07_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M07_AXI_bresp(1 downto 0);
  m07_couplers_to_processing_system7_0_axi_periph_BVALID <= M07_AXI_bvalid;
  m07_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M07_AXI_rdata(31 downto 0);
  m07_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M07_AXI_rresp(1 downto 0);
  m07_couplers_to_processing_system7_0_axi_periph_RVALID <= M07_AXI_rvalid;
  m07_couplers_to_processing_system7_0_axi_periph_WREADY <= M07_AXI_wready;
  m08_aclk_1 <= M08_ACLK;
  m08_aresetn_1(0) <= M08_ARESETN(0);
  m08_couplers_to_processing_system7_0_axi_periph_ARREADY <= M08_AXI_arready;
  m08_couplers_to_processing_system7_0_axi_periph_AWREADY <= M08_AXI_awready;
  m08_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M08_AXI_bresp(1 downto 0);
  m08_couplers_to_processing_system7_0_axi_periph_BVALID <= M08_AXI_bvalid;
  m08_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M08_AXI_rdata(31 downto 0);
  m08_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M08_AXI_rresp(1 downto 0);
  m08_couplers_to_processing_system7_0_axi_periph_RVALID <= M08_AXI_rvalid;
  m08_couplers_to_processing_system7_0_axi_periph_WREADY <= M08_AXI_wready;
  m09_aclk_1 <= M09_ACLK;
  m09_aresetn_1(0) <= M09_ARESETN(0);
  m09_couplers_to_processing_system7_0_axi_periph_ARREADY <= M09_AXI_arready;
  m09_couplers_to_processing_system7_0_axi_periph_AWREADY <= M09_AXI_awready;
  m09_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0) <= M09_AXI_bresp(1 downto 0);
  m09_couplers_to_processing_system7_0_axi_periph_BVALID <= M09_AXI_bvalid;
  m09_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0) <= M09_AXI_rdata(31 downto 0);
  m09_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0) <= M09_AXI_rresp(1 downto 0);
  m09_couplers_to_processing_system7_0_axi_periph_RVALID <= M09_AXI_rvalid;
  m09_couplers_to_processing_system7_0_axi_periph_WREADY <= M09_AXI_wready;
  processing_system7_0_axi_periph_ACLK_net <= ACLK;
  processing_system7_0_axi_periph_ARESETN_net(0) <= ARESETN(0);
  processing_system7_0_axi_periph_to_s00_couplers_ARADDR(31 downto 0) <= S00_AXI_araddr(31 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARBURST(1 downto 0) <= S00_AXI_arburst(1 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARCACHE(3 downto 0) <= S00_AXI_arcache(3 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARID(11 downto 0) <= S00_AXI_arid(11 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARLEN(3 downto 0) <= S00_AXI_arlen(3 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARLOCK(1 downto 0) <= S00_AXI_arlock(1 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARPROT(2 downto 0) <= S00_AXI_arprot(2 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARQOS(3 downto 0) <= S00_AXI_arqos(3 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARSIZE(2 downto 0) <= S00_AXI_arsize(2 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_ARVALID <= S00_AXI_arvalid;
  processing_system7_0_axi_periph_to_s00_couplers_AWADDR(31 downto 0) <= S00_AXI_awaddr(31 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWBURST(1 downto 0) <= S00_AXI_awburst(1 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWCACHE(3 downto 0) <= S00_AXI_awcache(3 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWID(11 downto 0) <= S00_AXI_awid(11 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWLEN(3 downto 0) <= S00_AXI_awlen(3 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWLOCK(1 downto 0) <= S00_AXI_awlock(1 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWPROT(2 downto 0) <= S00_AXI_awprot(2 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWQOS(3 downto 0) <= S00_AXI_awqos(3 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWSIZE(2 downto 0) <= S00_AXI_awsize(2 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_AWVALID <= S00_AXI_awvalid;
  processing_system7_0_axi_periph_to_s00_couplers_BREADY <= S00_AXI_bready;
  processing_system7_0_axi_periph_to_s00_couplers_RREADY <= S00_AXI_rready;
  processing_system7_0_axi_periph_to_s00_couplers_WDATA(31 downto 0) <= S00_AXI_wdata(31 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_WID(11 downto 0) <= S00_AXI_wid(11 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_WLAST <= S00_AXI_wlast;
  processing_system7_0_axi_periph_to_s00_couplers_WSTRB(3 downto 0) <= S00_AXI_wstrb(3 downto 0);
  processing_system7_0_axi_periph_to_s00_couplers_WVALID <= S00_AXI_wvalid;
  s00_aclk_1 <= S00_ACLK;
  s00_aresetn_1(0) <= S00_ARESETN(0);
m00_couplers: entity work.m00_couplers_imp_VG7ZLK
    port map (
      M_ACLK => m00_aclk_1,
      M_ARESETN(0) => m00_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m00_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready(0) => m00_couplers_to_processing_system7_0_axi_periph_ARREADY(0),
      M_AXI_arvalid(0) => m00_couplers_to_processing_system7_0_axi_periph_ARVALID(0),
      M_AXI_awaddr(8 downto 0) => m00_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready(0) => m00_couplers_to_processing_system7_0_axi_periph_AWREADY(0),
      M_AXI_awvalid(0) => m00_couplers_to_processing_system7_0_axi_periph_AWVALID(0),
      M_AXI_bready(0) => m00_couplers_to_processing_system7_0_axi_periph_BREADY(0),
      M_AXI_bresp(1 downto 0) => m00_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid(0) => m00_couplers_to_processing_system7_0_axi_periph_BVALID(0),
      M_AXI_rdata(31 downto 0) => m00_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready(0) => m00_couplers_to_processing_system7_0_axi_periph_RREADY(0),
      M_AXI_rresp(1 downto 0) => m00_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid(0) => m00_couplers_to_processing_system7_0_axi_periph_RVALID(0),
      M_AXI_wdata(31 downto 0) => m00_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready(0) => m00_couplers_to_processing_system7_0_axi_periph_WREADY(0),
      M_AXI_wstrb(3 downto 0) => m00_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid(0) => m00_couplers_to_processing_system7_0_axi_periph_WVALID(0),
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m00_couplers_ARADDR(8 downto 0),
      S_AXI_arready(0) => xbar_to_m00_couplers_ARREADY(0),
      S_AXI_arvalid(0) => xbar_to_m00_couplers_ARVALID(0),
      S_AXI_awaddr(8 downto 0) => xbar_to_m00_couplers_AWADDR(8 downto 0),
      S_AXI_awready(0) => xbar_to_m00_couplers_AWREADY(0),
      S_AXI_awvalid(0) => xbar_to_m00_couplers_AWVALID(0),
      S_AXI_bready(0) => xbar_to_m00_couplers_BREADY(0),
      S_AXI_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid(0) => xbar_to_m00_couplers_BVALID(0),
      S_AXI_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      S_AXI_rready(0) => xbar_to_m00_couplers_RREADY(0),
      S_AXI_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid(0) => xbar_to_m00_couplers_RVALID(0),
      S_AXI_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      S_AXI_wready(0) => xbar_to_m00_couplers_WREADY(0),
      S_AXI_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid(0) => xbar_to_m00_couplers_WVALID(0)
    );
m01_couplers: entity work.m01_couplers_imp_180AW1Y
    port map (
      M_ACLK => m01_aclk_1,
      M_ARESETN(0) => m01_aresetn_1(0),
      M_AXI_araddr(7 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_ARADDR(7 downto 0),
      M_AXI_arprot(2 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_ARPROT(2 downto 0),
      M_AXI_arready => m01_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m01_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(7 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_AWADDR(7 downto 0),
      M_AXI_awprot(2 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_AWPROT(2 downto 0),
      M_AXI_awready => m01_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m01_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m01_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m01_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m01_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m01_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m01_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m01_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m01_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(7 downto 0) => xbar_to_m01_couplers_ARADDR(39 downto 32),
      S_AXI_arprot(2 downto 0) => xbar_to_m01_couplers_ARPROT(5 downto 3),
      S_AXI_arready => xbar_to_m01_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m01_couplers_ARVALID(1),
      S_AXI_awaddr(7 downto 0) => xbar_to_m01_couplers_AWADDR(39 downto 32),
      S_AXI_awprot(2 downto 0) => xbar_to_m01_couplers_AWPROT(5 downto 3),
      S_AXI_awready => xbar_to_m01_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m01_couplers_AWVALID(1),
      S_AXI_bready => xbar_to_m01_couplers_BREADY(1),
      S_AXI_bresp(1 downto 0) => xbar_to_m01_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m01_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m01_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m01_couplers_RREADY(1),
      S_AXI_rresp(1 downto 0) => xbar_to_m01_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m01_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m01_couplers_WDATA(63 downto 32),
      S_AXI_wready => xbar_to_m01_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m01_couplers_WSTRB(7 downto 4),
      S_AXI_wvalid => xbar_to_m01_couplers_WVALID(1)
    );
m02_couplers: entity work.m02_couplers_imp_WNEIF9
    port map (
      M_ACLK => m02_aclk_1,
      M_ARESETN(0) => m02_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m02_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready => m02_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m02_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(8 downto 0) => m02_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready => m02_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m02_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m02_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m02_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m02_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m02_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m02_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m02_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m02_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m02_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m02_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m02_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m02_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m02_couplers_ARADDR(72 downto 64),
      S_AXI_arready => xbar_to_m02_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m02_couplers_ARVALID(2),
      S_AXI_awaddr(8 downto 0) => xbar_to_m02_couplers_AWADDR(72 downto 64),
      S_AXI_awready => xbar_to_m02_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m02_couplers_AWVALID(2),
      S_AXI_bready => xbar_to_m02_couplers_BREADY(2),
      S_AXI_bresp(1 downto 0) => xbar_to_m02_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m02_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m02_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m02_couplers_RREADY(2),
      S_AXI_rresp(1 downto 0) => xbar_to_m02_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m02_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m02_couplers_WDATA(95 downto 64),
      S_AXI_wready => xbar_to_m02_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m02_couplers_WSTRB(11 downto 8),
      S_AXI_wvalid => xbar_to_m02_couplers_WVALID(2)
    );
m03_couplers: entity work.m03_couplers_imp_16UK5X7
    port map (
      M_ACLK => m03_aclk_1,
      M_ARESETN(0) => m03_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m03_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready => m03_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m03_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(8 downto 0) => m03_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready => m03_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m03_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m03_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m03_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m03_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m03_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m03_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m03_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m03_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m03_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m03_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m03_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m03_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m03_couplers_ARADDR(104 downto 96),
      S_AXI_arready => xbar_to_m03_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m03_couplers_ARVALID(3),
      S_AXI_awaddr(8 downto 0) => xbar_to_m03_couplers_AWADDR(104 downto 96),
      S_AXI_awready => xbar_to_m03_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m03_couplers_AWVALID(3),
      S_AXI_bready => xbar_to_m03_couplers_BREADY(3),
      S_AXI_bresp(1 downto 0) => xbar_to_m03_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m03_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m03_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m03_couplers_RREADY(3),
      S_AXI_rresp(1 downto 0) => xbar_to_m03_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m03_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m03_couplers_WDATA(127 downto 96),
      S_AXI_wready => xbar_to_m03_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m03_couplers_WSTRB(15 downto 12),
      S_AXI_wvalid => xbar_to_m03_couplers_WVALID(3)
    );
m04_couplers: entity work.m04_couplers_imp_XHLMRM
    port map (
      M_ACLK => m04_aclk_1,
      M_ARESETN(0) => m04_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m04_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready => m04_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m04_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(8 downto 0) => m04_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready => m04_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m04_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m04_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m04_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m04_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m04_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m04_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m04_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m04_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m04_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m04_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m04_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m04_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m04_couplers_ARADDR(136 downto 128),
      S_AXI_arready => xbar_to_m04_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m04_couplers_ARVALID(4),
      S_AXI_awaddr(8 downto 0) => xbar_to_m04_couplers_AWADDR(136 downto 128),
      S_AXI_awready => xbar_to_m04_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m04_couplers_AWVALID(4),
      S_AXI_bready => xbar_to_m04_couplers_BREADY(4),
      S_AXI_bresp(1 downto 0) => xbar_to_m04_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m04_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m04_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m04_couplers_RREADY(4),
      S_AXI_rresp(1 downto 0) => xbar_to_m04_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m04_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m04_couplers_WDATA(159 downto 128),
      S_AXI_wready => xbar_to_m04_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m04_couplers_WSTRB(19 downto 16),
      S_AXI_wvalid => xbar_to_m04_couplers_WVALID(4)
    );
m05_couplers: entity work.m05_couplers_imp_160OGCC
    port map (
      M_ACLK => m05_aclk_1,
      M_ARESETN(0) => m05_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m05_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready => m05_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m05_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(8 downto 0) => m05_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready => m05_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m05_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m05_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m05_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m05_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m05_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m05_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m05_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m05_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m05_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m05_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m05_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m05_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m05_couplers_ARADDR(168 downto 160),
      S_AXI_arready => xbar_to_m05_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m05_couplers_ARVALID(5),
      S_AXI_awaddr(8 downto 0) => xbar_to_m05_couplers_AWADDR(168 downto 160),
      S_AXI_awready => xbar_to_m05_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m05_couplers_AWVALID(5),
      S_AXI_bready => xbar_to_m05_couplers_BREADY(5),
      S_AXI_bresp(1 downto 0) => xbar_to_m05_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m05_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m05_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m05_couplers_RREADY(5),
      S_AXI_rresp(1 downto 0) => xbar_to_m05_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m05_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m05_couplers_WDATA(191 downto 160),
      S_AXI_wready => xbar_to_m05_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m05_couplers_WSTRB(23 downto 20),
      S_AXI_wvalid => xbar_to_m05_couplers_WVALID(5)
    );
m06_couplers: entity work.m06_couplers_imp_YHEOCF
    port map (
      M_ACLK => m06_aclk_1,
      M_ARESETN(0) => m06_aresetn_1(0),
      M_AXI_araddr(7 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_ARADDR(7 downto 0),
      M_AXI_arprot(2 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_ARPROT(2 downto 0),
      M_AXI_arready => m06_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m06_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(7 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_AWADDR(7 downto 0),
      M_AXI_awprot(2 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_AWPROT(2 downto 0),
      M_AXI_awready => m06_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m06_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m06_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m06_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m06_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m06_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m06_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m06_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m06_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(7 downto 0) => xbar_to_m06_couplers_ARADDR(199 downto 192),
      S_AXI_arprot(2 downto 0) => xbar_to_m06_couplers_ARPROT(20 downto 18),
      S_AXI_arready => xbar_to_m06_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m06_couplers_ARVALID(6),
      S_AXI_awaddr(7 downto 0) => xbar_to_m06_couplers_AWADDR(199 downto 192),
      S_AXI_awprot(2 downto 0) => xbar_to_m06_couplers_AWPROT(20 downto 18),
      S_AXI_awready => xbar_to_m06_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m06_couplers_AWVALID(6),
      S_AXI_bready => xbar_to_m06_couplers_BREADY(6),
      S_AXI_bresp(1 downto 0) => xbar_to_m06_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m06_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m06_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m06_couplers_RREADY(6),
      S_AXI_rresp(1 downto 0) => xbar_to_m06_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m06_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m06_couplers_WDATA(223 downto 192),
      S_AXI_wready => xbar_to_m06_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m06_couplers_WSTRB(27 downto 24),
      S_AXI_wvalid => xbar_to_m06_couplers_WVALID(6)
    );
m07_couplers: entity work.m07_couplers_imp_14XJU69
    port map (
      M_ACLK => m07_aclk_1,
      M_ARESETN(0) => m07_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m07_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready => m07_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m07_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(8 downto 0) => m07_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready => m07_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m07_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m07_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m07_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m07_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m07_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m07_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m07_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m07_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m07_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m07_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m07_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m07_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m07_couplers_ARADDR(232 downto 224),
      S_AXI_arready => xbar_to_m07_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m07_couplers_ARVALID(7),
      S_AXI_awaddr(8 downto 0) => xbar_to_m07_couplers_AWADDR(232 downto 224),
      S_AXI_awready => xbar_to_m07_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m07_couplers_AWVALID(7),
      S_AXI_bready => xbar_to_m07_couplers_BREADY(7),
      S_AXI_bresp(1 downto 0) => xbar_to_m07_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m07_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m07_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m07_couplers_RREADY(7),
      S_AXI_rresp(1 downto 0) => xbar_to_m07_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m07_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m07_couplers_WDATA(255 downto 224),
      S_AXI_wready => xbar_to_m07_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m07_couplers_WSTRB(31 downto 28),
      S_AXI_wvalid => xbar_to_m07_couplers_WVALID(7)
    );
m08_couplers: entity work.m08_couplers_imp_RCGVF0
    port map (
      M_ACLK => m08_aclk_1,
      M_ARESETN(0) => m08_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m08_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready => m08_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m08_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(8 downto 0) => m08_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready => m08_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m08_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m08_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m08_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m08_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m08_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m08_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m08_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m08_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m08_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m08_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m08_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m08_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m08_couplers_ARADDR(264 downto 256),
      S_AXI_arready => xbar_to_m08_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m08_couplers_ARVALID(8),
      S_AXI_awaddr(8 downto 0) => xbar_to_m08_couplers_AWADDR(264 downto 256),
      S_AXI_awready => xbar_to_m08_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m08_couplers_AWVALID(8),
      S_AXI_bready => xbar_to_m08_couplers_BREADY(8),
      S_AXI_bresp(1 downto 0) => xbar_to_m08_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m08_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m08_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m08_couplers_RREADY(8),
      S_AXI_rresp(1 downto 0) => xbar_to_m08_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m08_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m08_couplers_WDATA(287 downto 256),
      S_AXI_wready => xbar_to_m08_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m08_couplers_WSTRB(35 downto 32),
      S_AXI_wvalid => xbar_to_m08_couplers_WVALID(8)
    );
m09_couplers: entity work.m09_couplers_imp_137EGXE
    port map (
      M_ACLK => m09_aclk_1,
      M_ARESETN(0) => m09_aresetn_1(0),
      M_AXI_araddr(8 downto 0) => m09_couplers_to_processing_system7_0_axi_periph_ARADDR(8 downto 0),
      M_AXI_arready => m09_couplers_to_processing_system7_0_axi_periph_ARREADY,
      M_AXI_arvalid => m09_couplers_to_processing_system7_0_axi_periph_ARVALID,
      M_AXI_awaddr(8 downto 0) => m09_couplers_to_processing_system7_0_axi_periph_AWADDR(8 downto 0),
      M_AXI_awready => m09_couplers_to_processing_system7_0_axi_periph_AWREADY,
      M_AXI_awvalid => m09_couplers_to_processing_system7_0_axi_periph_AWVALID,
      M_AXI_bready => m09_couplers_to_processing_system7_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m09_couplers_to_processing_system7_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m09_couplers_to_processing_system7_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m09_couplers_to_processing_system7_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m09_couplers_to_processing_system7_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m09_couplers_to_processing_system7_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m09_couplers_to_processing_system7_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m09_couplers_to_processing_system7_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m09_couplers_to_processing_system7_0_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => m09_couplers_to_processing_system7_0_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => m09_couplers_to_processing_system7_0_axi_periph_WVALID,
      S_ACLK => processing_system7_0_axi_periph_ACLK_net,
      S_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      S_AXI_araddr(8 downto 0) => xbar_to_m09_couplers_ARADDR(296 downto 288),
      S_AXI_arready => xbar_to_m09_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m09_couplers_ARVALID(9),
      S_AXI_awaddr(8 downto 0) => xbar_to_m09_couplers_AWADDR(296 downto 288),
      S_AXI_awready => xbar_to_m09_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m09_couplers_AWVALID(9),
      S_AXI_bready => xbar_to_m09_couplers_BREADY(9),
      S_AXI_bresp(1 downto 0) => xbar_to_m09_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m09_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m09_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m09_couplers_RREADY(9),
      S_AXI_rresp(1 downto 0) => xbar_to_m09_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m09_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m09_couplers_WDATA(319 downto 288),
      S_AXI_wready => xbar_to_m09_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m09_couplers_WSTRB(39 downto 36),
      S_AXI_wvalid => xbar_to_m09_couplers_WVALID(9)
    );
s00_couplers: entity work.s00_couplers_imp_156Q4UY
    port map (
      M_ACLK => processing_system7_0_axi_periph_ACLK_net,
      M_ARESETN(0) => processing_system7_0_axi_periph_ARESETN_net(0),
      M_AXI_araddr(31 downto 0) => s00_couplers_to_xbar_ARADDR(31 downto 0),
      M_AXI_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arready => s00_couplers_to_xbar_ARREADY(0),
      M_AXI_arvalid => s00_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(31 downto 0) => s00_couplers_to_xbar_AWADDR(31 downto 0),
      M_AXI_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awready => s00_couplers_to_xbar_AWREADY(0),
      M_AXI_awvalid => s00_couplers_to_xbar_AWVALID,
      M_AXI_bready => s00_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      M_AXI_bvalid => s00_couplers_to_xbar_BVALID(0),
      M_AXI_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      M_AXI_rready => s00_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      M_AXI_rvalid => s00_couplers_to_xbar_RVALID(0),
      M_AXI_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wready => s00_couplers_to_xbar_WREADY(0),
      M_AXI_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s00_couplers_to_xbar_WVALID,
      S_ACLK => s00_aclk_1,
      S_ARESETN(0) => s00_aresetn_1(0),
      S_AXI_araddr(31 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARADDR(31 downto 0),
      S_AXI_arburst(1 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARBURST(1 downto 0),
      S_AXI_arcache(3 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARCACHE(3 downto 0),
      S_AXI_arid(11 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARID(11 downto 0),
      S_AXI_arlen(3 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARLEN(3 downto 0),
      S_AXI_arlock(1 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARLOCK(1 downto 0),
      S_AXI_arprot(2 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARPROT(2 downto 0),
      S_AXI_arqos(3 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARQOS(3 downto 0),
      S_AXI_arready => processing_system7_0_axi_periph_to_s00_couplers_ARREADY,
      S_AXI_arsize(2 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_ARSIZE(2 downto 0),
      S_AXI_arvalid => processing_system7_0_axi_periph_to_s00_couplers_ARVALID,
      S_AXI_awaddr(31 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWADDR(31 downto 0),
      S_AXI_awburst(1 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWBURST(1 downto 0),
      S_AXI_awcache(3 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWCACHE(3 downto 0),
      S_AXI_awid(11 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWID(11 downto 0),
      S_AXI_awlen(3 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWLEN(3 downto 0),
      S_AXI_awlock(1 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWLOCK(1 downto 0),
      S_AXI_awprot(2 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWPROT(2 downto 0),
      S_AXI_awqos(3 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWQOS(3 downto 0),
      S_AXI_awready => processing_system7_0_axi_periph_to_s00_couplers_AWREADY,
      S_AXI_awsize(2 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_AWSIZE(2 downto 0),
      S_AXI_awvalid => processing_system7_0_axi_periph_to_s00_couplers_AWVALID,
      S_AXI_bid(11 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_BID(11 downto 0),
      S_AXI_bready => processing_system7_0_axi_periph_to_s00_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => processing_system7_0_axi_periph_to_s00_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_RDATA(31 downto 0),
      S_AXI_rid(11 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_RID(11 downto 0),
      S_AXI_rlast => processing_system7_0_axi_periph_to_s00_couplers_RLAST,
      S_AXI_rready => processing_system7_0_axi_periph_to_s00_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => processing_system7_0_axi_periph_to_s00_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_WDATA(31 downto 0),
      S_AXI_wid(11 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_WID(11 downto 0),
      S_AXI_wlast => processing_system7_0_axi_periph_to_s00_couplers_WLAST,
      S_AXI_wready => processing_system7_0_axi_periph_to_s00_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_to_s00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => processing_system7_0_axi_periph_to_s00_couplers_WVALID
    );
xbar: component tutorial_xbar_1
    port map (
      aclk => processing_system7_0_axi_periph_ACLK_net,
      aresetn => processing_system7_0_axi_periph_ARESETN_net(0),
      m_axi_araddr(319 downto 288) => xbar_to_m09_couplers_ARADDR(319 downto 288),
      m_axi_araddr(287 downto 256) => xbar_to_m08_couplers_ARADDR(287 downto 256),
      m_axi_araddr(255 downto 224) => xbar_to_m07_couplers_ARADDR(255 downto 224),
      m_axi_araddr(223 downto 192) => xbar_to_m06_couplers_ARADDR(223 downto 192),
      m_axi_araddr(191 downto 160) => xbar_to_m05_couplers_ARADDR(191 downto 160),
      m_axi_araddr(159 downto 128) => xbar_to_m04_couplers_ARADDR(159 downto 128),
      m_axi_araddr(127 downto 96) => xbar_to_m03_couplers_ARADDR(127 downto 96),
      m_axi_araddr(95 downto 64) => xbar_to_m02_couplers_ARADDR(95 downto 64),
      m_axi_araddr(63 downto 32) => xbar_to_m01_couplers_ARADDR(63 downto 32),
      m_axi_araddr(31 downto 0) => xbar_to_m00_couplers_ARADDR(31 downto 0),
      m_axi_arprot(29 downto 21) => NLW_xbar_m_axi_arprot_UNCONNECTED(29 downto 21),
      m_axi_arprot(20 downto 18) => xbar_to_m06_couplers_ARPROT(20 downto 18),
      m_axi_arprot(17 downto 6) => NLW_xbar_m_axi_arprot_UNCONNECTED(17 downto 6),
      m_axi_arprot(5 downto 3) => xbar_to_m01_couplers_ARPROT(5 downto 3),
      m_axi_arprot(2 downto 0) => NLW_xbar_m_axi_arprot_UNCONNECTED(2 downto 0),
      m_axi_arready(9) => xbar_to_m09_couplers_ARREADY,
      m_axi_arready(8) => xbar_to_m08_couplers_ARREADY,
      m_axi_arready(7) => xbar_to_m07_couplers_ARREADY,
      m_axi_arready(6) => xbar_to_m06_couplers_ARREADY,
      m_axi_arready(5) => xbar_to_m05_couplers_ARREADY,
      m_axi_arready(4) => xbar_to_m04_couplers_ARREADY,
      m_axi_arready(3) => xbar_to_m03_couplers_ARREADY,
      m_axi_arready(2) => xbar_to_m02_couplers_ARREADY,
      m_axi_arready(1) => xbar_to_m01_couplers_ARREADY,
      m_axi_arready(0) => xbar_to_m00_couplers_ARREADY(0),
      m_axi_arvalid(9) => xbar_to_m09_couplers_ARVALID(9),
      m_axi_arvalid(8) => xbar_to_m08_couplers_ARVALID(8),
      m_axi_arvalid(7) => xbar_to_m07_couplers_ARVALID(7),
      m_axi_arvalid(6) => xbar_to_m06_couplers_ARVALID(6),
      m_axi_arvalid(5) => xbar_to_m05_couplers_ARVALID(5),
      m_axi_arvalid(4) => xbar_to_m04_couplers_ARVALID(4),
      m_axi_arvalid(3) => xbar_to_m03_couplers_ARVALID(3),
      m_axi_arvalid(2) => xbar_to_m02_couplers_ARVALID(2),
      m_axi_arvalid(1) => xbar_to_m01_couplers_ARVALID(1),
      m_axi_arvalid(0) => xbar_to_m00_couplers_ARVALID(0),
      m_axi_awaddr(319 downto 288) => xbar_to_m09_couplers_AWADDR(319 downto 288),
      m_axi_awaddr(287 downto 256) => xbar_to_m08_couplers_AWADDR(287 downto 256),
      m_axi_awaddr(255 downto 224) => xbar_to_m07_couplers_AWADDR(255 downto 224),
      m_axi_awaddr(223 downto 192) => xbar_to_m06_couplers_AWADDR(223 downto 192),
      m_axi_awaddr(191 downto 160) => xbar_to_m05_couplers_AWADDR(191 downto 160),
      m_axi_awaddr(159 downto 128) => xbar_to_m04_couplers_AWADDR(159 downto 128),
      m_axi_awaddr(127 downto 96) => xbar_to_m03_couplers_AWADDR(127 downto 96),
      m_axi_awaddr(95 downto 64) => xbar_to_m02_couplers_AWADDR(95 downto 64),
      m_axi_awaddr(63 downto 32) => xbar_to_m01_couplers_AWADDR(63 downto 32),
      m_axi_awaddr(31 downto 0) => xbar_to_m00_couplers_AWADDR(31 downto 0),
      m_axi_awprot(29 downto 21) => NLW_xbar_m_axi_awprot_UNCONNECTED(29 downto 21),
      m_axi_awprot(20 downto 18) => xbar_to_m06_couplers_AWPROT(20 downto 18),
      m_axi_awprot(17 downto 6) => NLW_xbar_m_axi_awprot_UNCONNECTED(17 downto 6),
      m_axi_awprot(5 downto 3) => xbar_to_m01_couplers_AWPROT(5 downto 3),
      m_axi_awprot(2 downto 0) => NLW_xbar_m_axi_awprot_UNCONNECTED(2 downto 0),
      m_axi_awready(9) => xbar_to_m09_couplers_AWREADY,
      m_axi_awready(8) => xbar_to_m08_couplers_AWREADY,
      m_axi_awready(7) => xbar_to_m07_couplers_AWREADY,
      m_axi_awready(6) => xbar_to_m06_couplers_AWREADY,
      m_axi_awready(5) => xbar_to_m05_couplers_AWREADY,
      m_axi_awready(4) => xbar_to_m04_couplers_AWREADY,
      m_axi_awready(3) => xbar_to_m03_couplers_AWREADY,
      m_axi_awready(2) => xbar_to_m02_couplers_AWREADY,
      m_axi_awready(1) => xbar_to_m01_couplers_AWREADY,
      m_axi_awready(0) => xbar_to_m00_couplers_AWREADY(0),
      m_axi_awvalid(9) => xbar_to_m09_couplers_AWVALID(9),
      m_axi_awvalid(8) => xbar_to_m08_couplers_AWVALID(8),
      m_axi_awvalid(7) => xbar_to_m07_couplers_AWVALID(7),
      m_axi_awvalid(6) => xbar_to_m06_couplers_AWVALID(6),
      m_axi_awvalid(5) => xbar_to_m05_couplers_AWVALID(5),
      m_axi_awvalid(4) => xbar_to_m04_couplers_AWVALID(4),
      m_axi_awvalid(3) => xbar_to_m03_couplers_AWVALID(3),
      m_axi_awvalid(2) => xbar_to_m02_couplers_AWVALID(2),
      m_axi_awvalid(1) => xbar_to_m01_couplers_AWVALID(1),
      m_axi_awvalid(0) => xbar_to_m00_couplers_AWVALID(0),
      m_axi_bready(9) => xbar_to_m09_couplers_BREADY(9),
      m_axi_bready(8) => xbar_to_m08_couplers_BREADY(8),
      m_axi_bready(7) => xbar_to_m07_couplers_BREADY(7),
      m_axi_bready(6) => xbar_to_m06_couplers_BREADY(6),
      m_axi_bready(5) => xbar_to_m05_couplers_BREADY(5),
      m_axi_bready(4) => xbar_to_m04_couplers_BREADY(4),
      m_axi_bready(3) => xbar_to_m03_couplers_BREADY(3),
      m_axi_bready(2) => xbar_to_m02_couplers_BREADY(2),
      m_axi_bready(1) => xbar_to_m01_couplers_BREADY(1),
      m_axi_bready(0) => xbar_to_m00_couplers_BREADY(0),
      m_axi_bresp(19 downto 18) => xbar_to_m09_couplers_BRESP(1 downto 0),
      m_axi_bresp(17 downto 16) => xbar_to_m08_couplers_BRESP(1 downto 0),
      m_axi_bresp(15 downto 14) => xbar_to_m07_couplers_BRESP(1 downto 0),
      m_axi_bresp(13 downto 12) => xbar_to_m06_couplers_BRESP(1 downto 0),
      m_axi_bresp(11 downto 10) => xbar_to_m05_couplers_BRESP(1 downto 0),
      m_axi_bresp(9 downto 8) => xbar_to_m04_couplers_BRESP(1 downto 0),
      m_axi_bresp(7 downto 6) => xbar_to_m03_couplers_BRESP(1 downto 0),
      m_axi_bresp(5 downto 4) => xbar_to_m02_couplers_BRESP(1 downto 0),
      m_axi_bresp(3 downto 2) => xbar_to_m01_couplers_BRESP(1 downto 0),
      m_axi_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      m_axi_bvalid(9) => xbar_to_m09_couplers_BVALID,
      m_axi_bvalid(8) => xbar_to_m08_couplers_BVALID,
      m_axi_bvalid(7) => xbar_to_m07_couplers_BVALID,
      m_axi_bvalid(6) => xbar_to_m06_couplers_BVALID,
      m_axi_bvalid(5) => xbar_to_m05_couplers_BVALID,
      m_axi_bvalid(4) => xbar_to_m04_couplers_BVALID,
      m_axi_bvalid(3) => xbar_to_m03_couplers_BVALID,
      m_axi_bvalid(2) => xbar_to_m02_couplers_BVALID,
      m_axi_bvalid(1) => xbar_to_m01_couplers_BVALID,
      m_axi_bvalid(0) => xbar_to_m00_couplers_BVALID(0),
      m_axi_rdata(319 downto 288) => xbar_to_m09_couplers_RDATA(31 downto 0),
      m_axi_rdata(287 downto 256) => xbar_to_m08_couplers_RDATA(31 downto 0),
      m_axi_rdata(255 downto 224) => xbar_to_m07_couplers_RDATA(31 downto 0),
      m_axi_rdata(223 downto 192) => xbar_to_m06_couplers_RDATA(31 downto 0),
      m_axi_rdata(191 downto 160) => xbar_to_m05_couplers_RDATA(31 downto 0),
      m_axi_rdata(159 downto 128) => xbar_to_m04_couplers_RDATA(31 downto 0),
      m_axi_rdata(127 downto 96) => xbar_to_m03_couplers_RDATA(31 downto 0),
      m_axi_rdata(95 downto 64) => xbar_to_m02_couplers_RDATA(31 downto 0),
      m_axi_rdata(63 downto 32) => xbar_to_m01_couplers_RDATA(31 downto 0),
      m_axi_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      m_axi_rready(9) => xbar_to_m09_couplers_RREADY(9),
      m_axi_rready(8) => xbar_to_m08_couplers_RREADY(8),
      m_axi_rready(7) => xbar_to_m07_couplers_RREADY(7),
      m_axi_rready(6) => xbar_to_m06_couplers_RREADY(6),
      m_axi_rready(5) => xbar_to_m05_couplers_RREADY(5),
      m_axi_rready(4) => xbar_to_m04_couplers_RREADY(4),
      m_axi_rready(3) => xbar_to_m03_couplers_RREADY(3),
      m_axi_rready(2) => xbar_to_m02_couplers_RREADY(2),
      m_axi_rready(1) => xbar_to_m01_couplers_RREADY(1),
      m_axi_rready(0) => xbar_to_m00_couplers_RREADY(0),
      m_axi_rresp(19 downto 18) => xbar_to_m09_couplers_RRESP(1 downto 0),
      m_axi_rresp(17 downto 16) => xbar_to_m08_couplers_RRESP(1 downto 0),
      m_axi_rresp(15 downto 14) => xbar_to_m07_couplers_RRESP(1 downto 0),
      m_axi_rresp(13 downto 12) => xbar_to_m06_couplers_RRESP(1 downto 0),
      m_axi_rresp(11 downto 10) => xbar_to_m05_couplers_RRESP(1 downto 0),
      m_axi_rresp(9 downto 8) => xbar_to_m04_couplers_RRESP(1 downto 0),
      m_axi_rresp(7 downto 6) => xbar_to_m03_couplers_RRESP(1 downto 0),
      m_axi_rresp(5 downto 4) => xbar_to_m02_couplers_RRESP(1 downto 0),
      m_axi_rresp(3 downto 2) => xbar_to_m01_couplers_RRESP(1 downto 0),
      m_axi_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      m_axi_rvalid(9) => xbar_to_m09_couplers_RVALID,
      m_axi_rvalid(8) => xbar_to_m08_couplers_RVALID,
      m_axi_rvalid(7) => xbar_to_m07_couplers_RVALID,
      m_axi_rvalid(6) => xbar_to_m06_couplers_RVALID,
      m_axi_rvalid(5) => xbar_to_m05_couplers_RVALID,
      m_axi_rvalid(4) => xbar_to_m04_couplers_RVALID,
      m_axi_rvalid(3) => xbar_to_m03_couplers_RVALID,
      m_axi_rvalid(2) => xbar_to_m02_couplers_RVALID,
      m_axi_rvalid(1) => xbar_to_m01_couplers_RVALID,
      m_axi_rvalid(0) => xbar_to_m00_couplers_RVALID(0),
      m_axi_wdata(319 downto 288) => xbar_to_m09_couplers_WDATA(319 downto 288),
      m_axi_wdata(287 downto 256) => xbar_to_m08_couplers_WDATA(287 downto 256),
      m_axi_wdata(255 downto 224) => xbar_to_m07_couplers_WDATA(255 downto 224),
      m_axi_wdata(223 downto 192) => xbar_to_m06_couplers_WDATA(223 downto 192),
      m_axi_wdata(191 downto 160) => xbar_to_m05_couplers_WDATA(191 downto 160),
      m_axi_wdata(159 downto 128) => xbar_to_m04_couplers_WDATA(159 downto 128),
      m_axi_wdata(127 downto 96) => xbar_to_m03_couplers_WDATA(127 downto 96),
      m_axi_wdata(95 downto 64) => xbar_to_m02_couplers_WDATA(95 downto 64),
      m_axi_wdata(63 downto 32) => xbar_to_m01_couplers_WDATA(63 downto 32),
      m_axi_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      m_axi_wready(9) => xbar_to_m09_couplers_WREADY,
      m_axi_wready(8) => xbar_to_m08_couplers_WREADY,
      m_axi_wready(7) => xbar_to_m07_couplers_WREADY,
      m_axi_wready(6) => xbar_to_m06_couplers_WREADY,
      m_axi_wready(5) => xbar_to_m05_couplers_WREADY,
      m_axi_wready(4) => xbar_to_m04_couplers_WREADY,
      m_axi_wready(3) => xbar_to_m03_couplers_WREADY,
      m_axi_wready(2) => xbar_to_m02_couplers_WREADY,
      m_axi_wready(1) => xbar_to_m01_couplers_WREADY,
      m_axi_wready(0) => xbar_to_m00_couplers_WREADY(0),
      m_axi_wstrb(39 downto 36) => xbar_to_m09_couplers_WSTRB(39 downto 36),
      m_axi_wstrb(35 downto 32) => xbar_to_m08_couplers_WSTRB(35 downto 32),
      m_axi_wstrb(31 downto 28) => xbar_to_m07_couplers_WSTRB(31 downto 28),
      m_axi_wstrb(27 downto 24) => xbar_to_m06_couplers_WSTRB(27 downto 24),
      m_axi_wstrb(23 downto 20) => xbar_to_m05_couplers_WSTRB(23 downto 20),
      m_axi_wstrb(19 downto 16) => xbar_to_m04_couplers_WSTRB(19 downto 16),
      m_axi_wstrb(15 downto 12) => xbar_to_m03_couplers_WSTRB(15 downto 12),
      m_axi_wstrb(11 downto 8) => xbar_to_m02_couplers_WSTRB(11 downto 8),
      m_axi_wstrb(7 downto 4) => xbar_to_m01_couplers_WSTRB(7 downto 4),
      m_axi_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid(9) => xbar_to_m09_couplers_WVALID(9),
      m_axi_wvalid(8) => xbar_to_m08_couplers_WVALID(8),
      m_axi_wvalid(7) => xbar_to_m07_couplers_WVALID(7),
      m_axi_wvalid(6) => xbar_to_m06_couplers_WVALID(6),
      m_axi_wvalid(5) => xbar_to_m05_couplers_WVALID(5),
      m_axi_wvalid(4) => xbar_to_m04_couplers_WVALID(4),
      m_axi_wvalid(3) => xbar_to_m03_couplers_WVALID(3),
      m_axi_wvalid(2) => xbar_to_m02_couplers_WVALID(2),
      m_axi_wvalid(1) => xbar_to_m01_couplers_WVALID(1),
      m_axi_wvalid(0) => xbar_to_m00_couplers_WVALID(0),
      s_axi_araddr(31 downto 0) => s00_couplers_to_xbar_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arready(0) => s00_couplers_to_xbar_ARREADY(0),
      s_axi_arvalid(0) => s00_couplers_to_xbar_ARVALID,
      s_axi_awaddr(31 downto 0) => s00_couplers_to_xbar_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awready(0) => s00_couplers_to_xbar_AWREADY(0),
      s_axi_awvalid(0) => s00_couplers_to_xbar_AWVALID,
      s_axi_bready(0) => s00_couplers_to_xbar_BREADY,
      s_axi_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      s_axi_bvalid(0) => s00_couplers_to_xbar_BVALID(0),
      s_axi_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      s_axi_rready(0) => s00_couplers_to_xbar_RREADY,
      s_axi_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      s_axi_rvalid(0) => s00_couplers_to_xbar_RVALID(0),
      s_axi_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wready(0) => s00_couplers_to_xbar_WREADY(0),
      s_axi_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wvalid(0) => s00_couplers_to_xbar_WVALID
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity tutorial is
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
    fmc1_hdmio_io_clk : out STD_LOGIC;
    fmc1_hdmio_io_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    fmc1_hdmio_io_spdif : out STD_LOGIC;
    fmc1_imageon_iic_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    fmc1_imageon_iic_scl_i : in STD_LOGIC;
    fmc1_imageon_iic_scl_o : out STD_LOGIC;
    fmc1_imageon_iic_scl_t : out STD_LOGIC;
    fmc1_imageon_iic_sda_i : in STD_LOGIC;
    fmc1_imageon_iic_sda_o : out STD_LOGIC;
    fmc1_imageon_iic_sda_t : out STD_LOGIC;
    fmc1_vita_clk : in STD_LOGIC;
    fmc1_vita_io_clk_out_n : in STD_LOGIC;
    fmc1_vita_io_clk_out_p : in STD_LOGIC;
    fmc1_vita_io_clk_pll : out STD_LOGIC;
    fmc1_vita_io_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    fmc1_vita_io_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    fmc1_vita_io_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    fmc1_vita_io_reset_n : out STD_LOGIC;
    fmc1_vita_io_spi_miso : in STD_LOGIC;
    fmc1_vita_io_spi_mosi : out STD_LOGIC;
    fmc1_vita_io_spi_sclk : out STD_LOGIC;
    fmc1_vita_io_spi_ssel_n : out STD_LOGIC;
    fmc1_vita_io_sync_n : in STD_LOGIC;
    fmc1_vita_io_sync_p : in STD_LOGIC;
    fmc1_vita_io_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 );
    fmc2_hdmio_io_clk : out STD_LOGIC;
    fmc2_hdmio_io_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    fmc2_hdmio_io_spdif : out STD_LOGIC;
    fmc2_imageon_iic_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    fmc2_imageon_iic_scl_i : in STD_LOGIC;
    fmc2_imageon_iic_scl_o : out STD_LOGIC;
    fmc2_imageon_iic_scl_t : out STD_LOGIC;
    fmc2_imageon_iic_sda_i : in STD_LOGIC;
    fmc2_imageon_iic_sda_o : out STD_LOGIC;
    fmc2_imageon_iic_sda_t : out STD_LOGIC;
    fmc2_vita_clk : in STD_LOGIC;
    fmc2_vita_io_clk_out_n : in STD_LOGIC;
    fmc2_vita_io_clk_out_p : in STD_LOGIC;
    fmc2_vita_io_clk_pll : out STD_LOGIC;
    fmc2_vita_io_data_n : in STD_LOGIC_VECTOR ( 3 downto 0 );
    fmc2_vita_io_data_p : in STD_LOGIC_VECTOR ( 3 downto 0 );
    fmc2_vita_io_monitor : in STD_LOGIC_VECTOR ( 1 downto 0 );
    fmc2_vita_io_reset_n : out STD_LOGIC;
    fmc2_vita_io_spi_miso : in STD_LOGIC;
    fmc2_vita_io_spi_mosi : out STD_LOGIC;
    fmc2_vita_io_spi_sclk : out STD_LOGIC;
    fmc2_vita_io_spi_ssel_n : out STD_LOGIC;
    fmc2_vita_io_sync_n : in STD_LOGIC;
    fmc2_vita_io_sync_p : in STD_LOGIC;
    fmc2_vita_io_trigger : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of tutorial : entity is "tutorial,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLanguage=VHDL,numBlks=48,numReposBlks=32,numNonXlnxBlks=4,numHierBlks=16,maxHierDepth=0,da_axi4_cnt=10,da_board_cnt=2,da_ps7_cnt=1}";
end tutorial;

architecture STRUCTURE of tutorial is
  component tutorial_processing_system7_0_0 is
  port (
    TTC0_WAVE0_OUT : out STD_LOGIC;
    TTC0_WAVE1_OUT : out STD_LOGIC;
    TTC0_WAVE2_OUT : out STD_LOGIC;
    TTC0_CLK0_IN : in STD_LOGIC;
    TTC0_CLK1_IN : in STD_LOGIC;
    TTC0_CLK2_IN : in STD_LOGIC;
    USB0_PORT_INDCTL : out STD_LOGIC_VECTOR ( 1 downto 0 );
    USB0_VBUS_PWRSELECT : out STD_LOGIC;
    USB0_VBUS_PWRFAULT : in STD_LOGIC;
    M_AXI_GP0_ARVALID : out STD_LOGIC;
    M_AXI_GP0_AWVALID : out STD_LOGIC;
    M_AXI_GP0_BREADY : out STD_LOGIC;
    M_AXI_GP0_RREADY : out STD_LOGIC;
    M_AXI_GP0_WLAST : out STD_LOGIC;
    M_AXI_GP0_WVALID : out STD_LOGIC;
    M_AXI_GP0_ARID : out STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_AWID : out STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_WID : out STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_GP0_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_GP0_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_GP0_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_ARLEN : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_AWLEN : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_ACLK : in STD_LOGIC;
    M_AXI_GP0_ARREADY : in STD_LOGIC;
    M_AXI_GP0_AWREADY : in STD_LOGIC;
    M_AXI_GP0_BVALID : in STD_LOGIC;
    M_AXI_GP0_RLAST : in STD_LOGIC;
    M_AXI_GP0_RVALID : in STD_LOGIC;
    M_AXI_GP0_WREADY : in STD_LOGIC;
    M_AXI_GP0_BID : in STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_RID : in STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FCLK_CLK0 : out STD_LOGIC;
    FCLK_CLK1 : out STD_LOGIC;
    FCLK_CLK2 : out STD_LOGIC;
    FCLK_RESET0_N : out STD_LOGIC;
    MIO : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    DDR_CAS_n : inout STD_LOGIC;
    DDR_CKE : inout STD_LOGIC;
    DDR_Clk_n : inout STD_LOGIC;
    DDR_Clk : inout STD_LOGIC;
    DDR_CS_n : inout STD_LOGIC;
    DDR_DRSTB : inout STD_LOGIC;
    DDR_ODT : inout STD_LOGIC;
    DDR_RAS_n : inout STD_LOGIC;
    DDR_WEB : inout STD_LOGIC;
    DDR_BankAddr : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_Addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_VRN : inout STD_LOGIC;
    DDR_VRP : inout STD_LOGIC;
    DDR_DM : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQ : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_DQS_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQS : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    PS_SRSTB : inout STD_LOGIC;
    PS_CLK : inout STD_LOGIC;
    PS_PORB : inout STD_LOGIC
  );
  end component tutorial_processing_system7_0_0;
  component tutorial_axi_iic_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    iic2intc_irpt : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    sda_i : in STD_LOGIC;
    sda_o : out STD_LOGIC;
    sda_t : out STD_LOGIC;
    scl_i : in STD_LOGIC;
    scl_o : out STD_LOGIC;
    scl_t : out STD_LOGIC;
    gpo : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_axi_iic_0_0;
  component tutorial_proc_sys_reset_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_proc_sys_reset_0;
  component tutorial_axi_iic_0_2 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    iic2intc_irpt : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    sda_i : in STD_LOGIC;
    sda_o : out STD_LOGIC;
    sda_t : out STD_LOGIC;
    scl_i : in STD_LOGIC;
    scl_o : out STD_LOGIC;
    scl_t : out STD_LOGIC;
    gpo : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component tutorial_axi_iic_0_2;
  signal GND_1 : STD_LOGIC;
  signal VCC_1 : STD_LOGIC;
  signal axi4s_clk_1 : STD_LOGIC;
  signal clk200_1 : STD_LOGIC;
  signal \^fmc1_hdmio_io_clk\ : STD_LOGIC;
  signal \^fmc1_hdmio_io_data\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^fmc1_hdmio_io_spdif\ : STD_LOGIC;
  signal \^fmc1_imageon_iic_scl_i\ : STD_LOGIC;
  signal \^fmc1_imageon_iic_scl_o\ : STD_LOGIC;
  signal \^fmc1_imageon_iic_scl_t\ : STD_LOGIC;
  signal \^fmc1_imageon_iic_sda_i\ : STD_LOGIC;
  signal \^fmc1_imageon_iic_sda_o\ : STD_LOGIC;
  signal \^fmc1_imageon_iic_sda_t\ : STD_LOGIC;
  signal fmc1_imageon_iic_gpo : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^fmc2_hdmio_io_clk\ : STD_LOGIC;
  signal \^fmc2_hdmio_io_data\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^fmc2_hdmio_io_spdif\ : STD_LOGIC;
  signal \^fmc2_imageon_iic_scl_i\ : STD_LOGIC;
  signal \^fmc2_imageon_iic_scl_o\ : STD_LOGIC;
  signal \^fmc2_imageon_iic_scl_t\ : STD_LOGIC;
  signal \^fmc2_imageon_iic_sda_i\ : STD_LOGIC;
  signal \^fmc2_imageon_iic_sda_o\ : STD_LOGIC;
  signal \^fmc2_imageon_iic_sda_t\ : STD_LOGIC;
  signal fmc2_imageon_iic_gpo : STD_LOGIC_VECTOR ( 0 to 0 );
  signal fmc2_imageon_vita_color_vita_axi4s_video_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal fmc2_imageon_vita_color_vita_axi4s_video_TLAST : STD_LOGIC;
  signal fmc2_imageon_vita_color_vita_axi4s_video_TREADY : STD_LOGIC;
  signal fmc2_imageon_vita_color_vita_axi4s_video_TUSER : STD_LOGIC;
  signal fmc2_imageon_vita_color_vita_axi4s_video_TVALID : STD_LOGIC;
  signal fmc2_imageon_vita_color_vita_vtiming_ACTIVE_VIDEO : STD_LOGIC;
  signal fmc2_imageon_vita_color_vita_vtiming_HBLANK : STD_LOGIC;
  signal fmc2_imageon_vita_color_vita_vtiming_VBLANK : STD_LOGIC;
  signal fmc_imageon_vita_color_vita_axi4s_video_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal fmc_imageon_vita_color_vita_axi4s_video_TLAST : STD_LOGIC;
  signal fmc_imageon_vita_color_vita_axi4s_video_TREADY : STD_LOGIC;
  signal fmc_imageon_vita_color_vita_axi4s_video_TUSER : STD_LOGIC;
  signal fmc_imageon_vita_color_vita_axi4s_video_TVALID : STD_LOGIC;
  signal fmc_imageon_vita_color_vita_vtiming_ACTIVE_VIDEO : STD_LOGIC;
  signal fmc_imageon_vita_color_vita_vtiming_HBLANK : STD_LOGIC;
  signal fmc_imageon_vita_color_vita_vtiming_VBLANK : STD_LOGIC;
  signal proc_sys_reset_interconnect_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal proc_sys_reset_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m00_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m00_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m00_axi_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m00_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m00_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m00_axi_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m00_axi_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m00_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m00_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m00_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m00_axi_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m00_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m00_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m00_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m00_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m00_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m00_axi_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m01_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m01_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m02_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m02_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m02_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m02_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m02_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m02_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m02_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m02_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m03_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m03_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m03_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m03_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m03_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m03_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m03_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m03_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m04_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m04_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m04_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m04_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m04_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m04_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m04_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m04_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m05_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m05_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m05_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m05_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m05_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m05_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m05_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m05_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_ARADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_AWADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m06_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m06_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m07_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m07_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m07_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m07_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m07_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m07_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m07_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m07_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m08_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m08_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m08_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m08_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m08_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m08_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m08_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m08_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m09_axi_ARREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_ARVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal processing_system7_0_axi_periph_m09_axi_AWREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_AWVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_BREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m09_axi_BVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m09_axi_RREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_axi_periph_m09_axi_RVALID : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_axi_periph_m09_axi_WREADY : STD_LOGIC;
  signal processing_system7_0_axi_periph_m09_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_axi_periph_m09_axi_WVALID : STD_LOGIC;
  signal processing_system7_0_ddr_ADDR : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal processing_system7_0_ddr_BA : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_ddr_CAS_N : STD_LOGIC;
  signal processing_system7_0_ddr_CKE : STD_LOGIC;
  signal processing_system7_0_ddr_CK_N : STD_LOGIC;
  signal processing_system7_0_ddr_CK_P : STD_LOGIC;
  signal processing_system7_0_ddr_CS_N : STD_LOGIC;
  signal processing_system7_0_ddr_DM : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_ddr_DQ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_ddr_DQS_N : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_ddr_DQS_P : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_ddr_ODT : STD_LOGIC;
  signal processing_system7_0_ddr_RAS_N : STD_LOGIC;
  signal processing_system7_0_ddr_RESET_N : STD_LOGIC;
  signal processing_system7_0_ddr_WE_N : STD_LOGIC;
  signal processing_system7_0_fclk_clk0 : STD_LOGIC;
  signal processing_system7_0_fclk_reset0_n : STD_LOGIC;
  signal processing_system7_0_fixed_io_DDR_VRN : STD_LOGIC;
  signal processing_system7_0_fixed_io_DDR_VRP : STD_LOGIC;
  signal processing_system7_0_fixed_io_MIO : STD_LOGIC_VECTOR ( 53 downto 0 );
  signal processing_system7_0_fixed_io_PS_CLK : STD_LOGIC;
  signal processing_system7_0_fixed_io_PS_PORB : STD_LOGIC;
  signal processing_system7_0_fixed_io_PS_SRSTB : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARREADY : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_m_axi_gp0_ARVALID : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWREADY : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_m_axi_gp0_AWVALID : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_BID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_m_axi_gp0_BREADY : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_m_axi_gp0_BVALID : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_m_axi_gp0_RID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_m_axi_gp0_RLAST : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_RREADY : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_m_axi_gp0_RVALID : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_m_axi_gp0_WID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_m_axi_gp0_WLAST : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_WREADY : STD_LOGIC;
  signal processing_system7_0_m_axi_gp0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_m_axi_gp0_WVALID : STD_LOGIC;
  signal NLW_fmc1_imageon_iic_iic2intc_irpt_UNCONNECTED : STD_LOGIC;
  signal NLW_fmc2_imageon_iic_iic2intc_irpt_UNCONNECTED : STD_LOGIC;
  signal NLW_proc_sys_reset_mb_reset_UNCONNECTED : STD_LOGIC;
  signal NLW_proc_sys_reset_bus_struct_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_proc_sys_reset_peripheral_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_processing_system7_0_TTC0_WAVE0_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_TTC0_WAVE1_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_TTC0_WAVE2_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_USB0_VBUS_PWRSELECT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_USB0_PORT_INDCTL_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
begin
  \^fmc1_imageon_iic_scl_i\ <= fmc1_imageon_iic_scl_i;
  \^fmc1_imageon_iic_sda_i\ <= fmc1_imageon_iic_sda_i;
  \^fmc2_imageon_iic_scl_i\ <= fmc2_imageon_iic_scl_i;
  \^fmc2_imageon_iic_sda_i\ <= fmc2_imageon_iic_sda_i;
  fmc1_hdmio_io_clk <= \^fmc1_hdmio_io_clk\;
  fmc1_hdmio_io_data(15 downto 0) <= \^fmc1_hdmio_io_data\(15 downto 0);
  fmc1_hdmio_io_spdif <= \^fmc1_hdmio_io_spdif\;
  fmc1_imageon_iic_rst_n(0) <= fmc1_imageon_iic_gpo(0);
  fmc1_imageon_iic_scl_o <= \^fmc1_imageon_iic_scl_o\;
  fmc1_imageon_iic_scl_t <= \^fmc1_imageon_iic_scl_t\;
  fmc1_imageon_iic_sda_o <= \^fmc1_imageon_iic_sda_o\;
  fmc1_imageon_iic_sda_t <= \^fmc1_imageon_iic_sda_t\;
  fmc2_hdmio_io_clk <= \^fmc2_hdmio_io_clk\;
  fmc2_hdmio_io_data(15 downto 0) <= \^fmc2_hdmio_io_data\(15 downto 0);
  fmc2_hdmio_io_spdif <= \^fmc2_hdmio_io_spdif\;
  fmc2_imageon_iic_rst_n(0) <= fmc2_imageon_iic_gpo(0);
  fmc2_imageon_iic_scl_o <= \^fmc2_imageon_iic_scl_o\;
  fmc2_imageon_iic_scl_t <= \^fmc2_imageon_iic_scl_t\;
  fmc2_imageon_iic_sda_o <= \^fmc2_imageon_iic_sda_o\;
  fmc2_imageon_iic_sda_t <= \^fmc2_imageon_iic_sda_t\;
GND: unisim.vcomponents.GND
    port map (
      G => GND_1
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => VCC_1
    );
fmc1_imageon_hdmio_rgb: entity work.fmc1_imageon_hdmio_rgb_imp_1U767LV
    port map (
      axi4lite_aresetn(0) => VCC_1,
      axi4lite_clk => processing_system7_0_fclk_clk0,
      axi4s_clk => axi4s_clk_1,
      hdmio_audio_spdif => GND_1,
      hdmio_axi4s_video_tdata(23 downto 0) => fmc_imageon_vita_color_vita_axi4s_video_TDATA(23 downto 0),
      hdmio_axi4s_video_tlast => fmc_imageon_vita_color_vita_axi4s_video_TLAST,
      hdmio_axi4s_video_tready => fmc_imageon_vita_color_vita_axi4s_video_TREADY,
      hdmio_axi4s_video_tuser => fmc_imageon_vita_color_vita_axi4s_video_TUSER,
      hdmio_axi4s_video_tvalid => fmc_imageon_vita_color_vita_axi4s_video_TVALID,
      hdmio_clk => fmc1_vita_clk,
      hdmio_io_clk => \^fmc1_hdmio_io_clk\,
      hdmio_io_data(15 downto 0) => \^fmc1_hdmio_io_data\(15 downto 0),
      hdmio_io_spdif => \^fmc1_hdmio_io_spdif\,
      video_vtiming_active_video => fmc_imageon_vita_color_vita_vtiming_ACTIVE_VIDEO,
      video_vtiming_hblank => fmc_imageon_vita_color_vita_vtiming_HBLANK,
      video_vtiming_vblank => fmc_imageon_vita_color_vita_vtiming_VBLANK,
      vtc_ctrl_araddr(8 downto 0) => processing_system7_0_axi_periph_m02_axi_ARADDR(8 downto 0),
      vtc_ctrl_arready => processing_system7_0_axi_periph_m02_axi_ARREADY,
      vtc_ctrl_arvalid => processing_system7_0_axi_periph_m02_axi_ARVALID,
      vtc_ctrl_awaddr(8 downto 0) => processing_system7_0_axi_periph_m02_axi_AWADDR(8 downto 0),
      vtc_ctrl_awready => processing_system7_0_axi_periph_m02_axi_AWREADY,
      vtc_ctrl_awvalid => processing_system7_0_axi_periph_m02_axi_AWVALID,
      vtc_ctrl_bready => processing_system7_0_axi_periph_m02_axi_BREADY,
      vtc_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m02_axi_BRESP(1 downto 0),
      vtc_ctrl_bvalid => processing_system7_0_axi_periph_m02_axi_BVALID,
      vtc_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m02_axi_RDATA(31 downto 0),
      vtc_ctrl_rready => processing_system7_0_axi_periph_m02_axi_RREADY,
      vtc_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m02_axi_RRESP(1 downto 0),
      vtc_ctrl_rvalid => processing_system7_0_axi_periph_m02_axi_RVALID,
      vtc_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m02_axi_WDATA(31 downto 0),
      vtc_ctrl_wready => processing_system7_0_axi_periph_m02_axi_WREADY,
      vtc_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m02_axi_WSTRB(3 downto 0),
      vtc_ctrl_wvalid => processing_system7_0_axi_periph_m02_axi_WVALID
    );
fmc1_imageon_iic: component tutorial_axi_iic_0_0
    port map (
      gpo(0) => fmc1_imageon_iic_gpo(0),
      iic2intc_irpt => NLW_fmc1_imageon_iic_iic2intc_irpt_UNCONNECTED,
      s_axi_aclk => processing_system7_0_fclk_clk0,
      s_axi_araddr(8 downto 0) => processing_system7_0_axi_periph_m00_axi_ARADDR(8 downto 0),
      s_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s_axi_arready => processing_system7_0_axi_periph_m00_axi_ARREADY,
      s_axi_arvalid => processing_system7_0_axi_periph_m00_axi_ARVALID(0),
      s_axi_awaddr(8 downto 0) => processing_system7_0_axi_periph_m00_axi_AWADDR(8 downto 0),
      s_axi_awready => processing_system7_0_axi_periph_m00_axi_AWREADY,
      s_axi_awvalid => processing_system7_0_axi_periph_m00_axi_AWVALID(0),
      s_axi_bready => processing_system7_0_axi_periph_m00_axi_BREADY(0),
      s_axi_bresp(1 downto 0) => processing_system7_0_axi_periph_m00_axi_BRESP(1 downto 0),
      s_axi_bvalid => processing_system7_0_axi_periph_m00_axi_BVALID,
      s_axi_rdata(31 downto 0) => processing_system7_0_axi_periph_m00_axi_RDATA(31 downto 0),
      s_axi_rready => processing_system7_0_axi_periph_m00_axi_RREADY(0),
      s_axi_rresp(1 downto 0) => processing_system7_0_axi_periph_m00_axi_RRESP(1 downto 0),
      s_axi_rvalid => processing_system7_0_axi_periph_m00_axi_RVALID,
      s_axi_wdata(31 downto 0) => processing_system7_0_axi_periph_m00_axi_WDATA(31 downto 0),
      s_axi_wready => processing_system7_0_axi_periph_m00_axi_WREADY,
      s_axi_wstrb(3 downto 0) => processing_system7_0_axi_periph_m00_axi_WSTRB(3 downto 0),
      s_axi_wvalid => processing_system7_0_axi_periph_m00_axi_WVALID(0),
      scl_i => \^fmc1_imageon_iic_scl_i\,
      scl_o => \^fmc1_imageon_iic_scl_o\,
      scl_t => \^fmc1_imageon_iic_scl_t\,
      sda_i => \^fmc1_imageon_iic_sda_i\,
      sda_o => \^fmc1_imageon_iic_sda_o\,
      sda_t => \^fmc1_imageon_iic_sda_t\
    );
fmc1_imageon_vita_color: entity work.fmc1_imageon_vita_color_imp_6DO8LV
    port map (
      axi4lite_aresetn(0) => proc_sys_reset_peripheral_aresetn(0),
      axi4lite_clk => processing_system7_0_fclk_clk0,
      axi4s_clk => axi4s_clk_1,
      cfa_ctrl_araddr(8 downto 0) => processing_system7_0_axi_periph_m04_axi_ARADDR(8 downto 0),
      cfa_ctrl_arready => processing_system7_0_axi_periph_m04_axi_ARREADY,
      cfa_ctrl_arvalid => processing_system7_0_axi_periph_m04_axi_ARVALID,
      cfa_ctrl_awaddr(8 downto 0) => processing_system7_0_axi_periph_m04_axi_AWADDR(8 downto 0),
      cfa_ctrl_awready => processing_system7_0_axi_periph_m04_axi_AWREADY,
      cfa_ctrl_awvalid => processing_system7_0_axi_periph_m04_axi_AWVALID,
      cfa_ctrl_bready => processing_system7_0_axi_periph_m04_axi_BREADY,
      cfa_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m04_axi_BRESP(1 downto 0),
      cfa_ctrl_bvalid => processing_system7_0_axi_periph_m04_axi_BVALID,
      cfa_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m04_axi_RDATA(31 downto 0),
      cfa_ctrl_rready => processing_system7_0_axi_periph_m04_axi_RREADY,
      cfa_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m04_axi_RRESP(1 downto 0),
      cfa_ctrl_rvalid => processing_system7_0_axi_periph_m04_axi_RVALID,
      cfa_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m04_axi_WDATA(31 downto 0),
      cfa_ctrl_wready => processing_system7_0_axi_periph_m04_axi_WREADY,
      cfa_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m04_axi_WSTRB(3 downto 0),
      cfa_ctrl_wvalid => processing_system7_0_axi_periph_m04_axi_WVALID,
      clk200 => clk200_1,
      dpc_ctrl_araddr(8 downto 0) => processing_system7_0_axi_periph_m03_axi_ARADDR(8 downto 0),
      dpc_ctrl_arready => processing_system7_0_axi_periph_m03_axi_ARREADY,
      dpc_ctrl_arvalid => processing_system7_0_axi_periph_m03_axi_ARVALID,
      dpc_ctrl_awaddr(8 downto 0) => processing_system7_0_axi_periph_m03_axi_AWADDR(8 downto 0),
      dpc_ctrl_awready => processing_system7_0_axi_periph_m03_axi_AWREADY,
      dpc_ctrl_awvalid => processing_system7_0_axi_periph_m03_axi_AWVALID,
      dpc_ctrl_bready => processing_system7_0_axi_periph_m03_axi_BREADY,
      dpc_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m03_axi_BRESP(1 downto 0),
      dpc_ctrl_bvalid => processing_system7_0_axi_periph_m03_axi_BVALID,
      dpc_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m03_axi_RDATA(31 downto 0),
      dpc_ctrl_rready => processing_system7_0_axi_periph_m03_axi_RREADY,
      dpc_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m03_axi_RRESP(1 downto 0),
      dpc_ctrl_rvalid => processing_system7_0_axi_periph_m03_axi_RVALID,
      dpc_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m03_axi_WDATA(31 downto 0),
      dpc_ctrl_wready => processing_system7_0_axi_periph_m03_axi_WREADY,
      dpc_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m03_axi_WSTRB(3 downto 0),
      dpc_ctrl_wvalid => processing_system7_0_axi_periph_m03_axi_WVALID,
      vita_axi4s_video_tdata(23 downto 0) => fmc_imageon_vita_color_vita_axi4s_video_TDATA(23 downto 0),
      vita_axi4s_video_tlast => fmc_imageon_vita_color_vita_axi4s_video_TLAST,
      vita_axi4s_video_tready => fmc_imageon_vita_color_vita_axi4s_video_TREADY,
      vita_axi4s_video_tuser => fmc_imageon_vita_color_vita_axi4s_video_TUSER,
      vita_axi4s_video_tvalid => fmc_imageon_vita_color_vita_axi4s_video_TVALID,
      vita_clk => fmc1_vita_clk,
      vita_ctrl_araddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_ARADDR(7 downto 0),
      vita_ctrl_arprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_ARPROT(2 downto 0),
      vita_ctrl_arready => processing_system7_0_axi_periph_m01_axi_ARREADY,
      vita_ctrl_arvalid => processing_system7_0_axi_periph_m01_axi_ARVALID,
      vita_ctrl_awaddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_AWADDR(7 downto 0),
      vita_ctrl_awprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_AWPROT(2 downto 0),
      vita_ctrl_awready => processing_system7_0_axi_periph_m01_axi_AWREADY,
      vita_ctrl_awvalid => processing_system7_0_axi_periph_m01_axi_AWVALID,
      vita_ctrl_bready => processing_system7_0_axi_periph_m01_axi_BREADY,
      vita_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_BRESP(1 downto 0),
      vita_ctrl_bvalid => processing_system7_0_axi_periph_m01_axi_BVALID,
      vita_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_RDATA(31 downto 0),
      vita_ctrl_rready => processing_system7_0_axi_periph_m01_axi_RREADY,
      vita_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_RRESP(1 downto 0),
      vita_ctrl_rvalid => processing_system7_0_axi_periph_m01_axi_RVALID,
      vita_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_WDATA(31 downto 0),
      vita_ctrl_wready => processing_system7_0_axi_periph_m01_axi_WREADY,
      vita_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m01_axi_WSTRB(3 downto 0),
      vita_ctrl_wvalid => processing_system7_0_axi_periph_m01_axi_WVALID,
      vita_io_clk_out_n => fmc1_vita_io_clk_out_n,
      vita_io_clk_out_p => fmc1_vita_io_clk_out_p,
      vita_io_clk_pll => fmc1_vita_io_clk_pll,
      vita_io_data_n(3 downto 0) => fmc1_vita_io_data_n(3 downto 0),
      vita_io_data_p(3 downto 0) => fmc1_vita_io_data_p(3 downto 0),
      vita_io_monitor(1 downto 0) => fmc1_vita_io_monitor(1 downto 0),
      vita_io_reset_n => fmc1_vita_io_reset_n,
      vita_io_spi_miso => fmc1_vita_io_spi_miso,
      vita_io_spi_mosi => fmc1_vita_io_spi_mosi,
      vita_io_spi_sclk => fmc1_vita_io_spi_sclk,
      vita_io_spi_ssel_n => fmc1_vita_io_spi_ssel_n,
      vita_io_sync_n => fmc1_vita_io_sync_n,
      vita_io_sync_p => fmc1_vita_io_sync_p,
      vita_io_trigger(2 downto 0) => fmc1_vita_io_trigger(2 downto 0),
      vita_vtiming_active_video => fmc_imageon_vita_color_vita_vtiming_ACTIVE_VIDEO,
      vita_vtiming_hblank => fmc_imageon_vita_color_vita_vtiming_HBLANK,
      vita_vtiming_vblank => fmc_imageon_vita_color_vita_vtiming_VBLANK
    );
fmc2_imageon_hdmio_rgb: entity work.fmc2_imageon_hdmio_rgb_imp_LKNANE
    port map (
      axi4lite_aresetn(0) => proc_sys_reset_peripheral_aresetn(0),
      axi4lite_clk => processing_system7_0_fclk_clk0,
      axi4s_clk => axi4s_clk_1,
      hdmio_audio_spdif => GND_1,
      hdmio_axi4s_video_tdata(23 downto 0) => fmc2_imageon_vita_color_vita_axi4s_video_TDATA(23 downto 0),
      hdmio_axi4s_video_tlast => fmc2_imageon_vita_color_vita_axi4s_video_TLAST,
      hdmio_axi4s_video_tready => fmc2_imageon_vita_color_vita_axi4s_video_TREADY,
      hdmio_axi4s_video_tuser => fmc2_imageon_vita_color_vita_axi4s_video_TUSER,
      hdmio_axi4s_video_tvalid => fmc2_imageon_vita_color_vita_axi4s_video_TVALID,
      hdmio_clk => fmc2_vita_clk,
      hdmio_io_clk => \^fmc2_hdmio_io_clk\,
      hdmio_io_data(15 downto 0) => \^fmc2_hdmio_io_data\(15 downto 0),
      hdmio_io_spdif => \^fmc2_hdmio_io_spdif\,
      video_vtiming_active_video => fmc2_imageon_vita_color_vita_vtiming_ACTIVE_VIDEO,
      video_vtiming_hblank => fmc2_imageon_vita_color_vita_vtiming_HBLANK,
      video_vtiming_vblank => fmc2_imageon_vita_color_vita_vtiming_VBLANK,
      vtc_ctrl_araddr(8 downto 0) => processing_system7_0_axi_periph_m07_axi_ARADDR(8 downto 0),
      vtc_ctrl_arready => processing_system7_0_axi_periph_m07_axi_ARREADY,
      vtc_ctrl_arvalid => processing_system7_0_axi_periph_m07_axi_ARVALID,
      vtc_ctrl_awaddr(8 downto 0) => processing_system7_0_axi_periph_m07_axi_AWADDR(8 downto 0),
      vtc_ctrl_awready => processing_system7_0_axi_periph_m07_axi_AWREADY,
      vtc_ctrl_awvalid => processing_system7_0_axi_periph_m07_axi_AWVALID,
      vtc_ctrl_bready => processing_system7_0_axi_periph_m07_axi_BREADY,
      vtc_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m07_axi_BRESP(1 downto 0),
      vtc_ctrl_bvalid => processing_system7_0_axi_periph_m07_axi_BVALID,
      vtc_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m07_axi_RDATA(31 downto 0),
      vtc_ctrl_rready => processing_system7_0_axi_periph_m07_axi_RREADY,
      vtc_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m07_axi_RRESP(1 downto 0),
      vtc_ctrl_rvalid => processing_system7_0_axi_periph_m07_axi_RVALID,
      vtc_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m07_axi_WDATA(31 downto 0),
      vtc_ctrl_wready => processing_system7_0_axi_periph_m07_axi_WREADY,
      vtc_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m07_axi_WSTRB(3 downto 0),
      vtc_ctrl_wvalid => processing_system7_0_axi_periph_m07_axi_WVALID
    );
fmc2_imageon_iic: component tutorial_axi_iic_0_2
    port map (
      gpo(0) => fmc2_imageon_iic_gpo(0),
      iic2intc_irpt => NLW_fmc2_imageon_iic_iic2intc_irpt_UNCONNECTED,
      s_axi_aclk => processing_system7_0_fclk_clk0,
      s_axi_araddr(8 downto 0) => processing_system7_0_axi_periph_m05_axi_ARADDR(8 downto 0),
      s_axi_aresetn => proc_sys_reset_peripheral_aresetn(0),
      s_axi_arready => processing_system7_0_axi_periph_m05_axi_ARREADY,
      s_axi_arvalid => processing_system7_0_axi_periph_m05_axi_ARVALID,
      s_axi_awaddr(8 downto 0) => processing_system7_0_axi_periph_m05_axi_AWADDR(8 downto 0),
      s_axi_awready => processing_system7_0_axi_periph_m05_axi_AWREADY,
      s_axi_awvalid => processing_system7_0_axi_periph_m05_axi_AWVALID,
      s_axi_bready => processing_system7_0_axi_periph_m05_axi_BREADY,
      s_axi_bresp(1 downto 0) => processing_system7_0_axi_periph_m05_axi_BRESP(1 downto 0),
      s_axi_bvalid => processing_system7_0_axi_periph_m05_axi_BVALID,
      s_axi_rdata(31 downto 0) => processing_system7_0_axi_periph_m05_axi_RDATA(31 downto 0),
      s_axi_rready => processing_system7_0_axi_periph_m05_axi_RREADY,
      s_axi_rresp(1 downto 0) => processing_system7_0_axi_periph_m05_axi_RRESP(1 downto 0),
      s_axi_rvalid => processing_system7_0_axi_periph_m05_axi_RVALID,
      s_axi_wdata(31 downto 0) => processing_system7_0_axi_periph_m05_axi_WDATA(31 downto 0),
      s_axi_wready => processing_system7_0_axi_periph_m05_axi_WREADY,
      s_axi_wstrb(3 downto 0) => processing_system7_0_axi_periph_m05_axi_WSTRB(3 downto 0),
      s_axi_wvalid => processing_system7_0_axi_periph_m05_axi_WVALID,
      scl_i => \^fmc2_imageon_iic_scl_i\,
      scl_o => \^fmc2_imageon_iic_scl_o\,
      scl_t => \^fmc2_imageon_iic_scl_t\,
      sda_i => \^fmc2_imageon_iic_sda_i\,
      sda_o => \^fmc2_imageon_iic_sda_o\,
      sda_t => \^fmc2_imageon_iic_sda_t\
    );
fmc2_imageon_vita_color: entity work.fmc2_imageon_vita_color_imp_1FFB5G9
    port map (
      axi4lite_aresetn(0) => proc_sys_reset_peripheral_aresetn(0),
      axi4lite_clk => processing_system7_0_fclk_clk0,
      axi4s_clk => axi4s_clk_1,
      cfa_ctrl_araddr(8 downto 0) => processing_system7_0_axi_periph_m09_axi_ARADDR(8 downto 0),
      cfa_ctrl_arready => processing_system7_0_axi_periph_m09_axi_ARREADY,
      cfa_ctrl_arvalid => processing_system7_0_axi_periph_m09_axi_ARVALID,
      cfa_ctrl_awaddr(8 downto 0) => processing_system7_0_axi_periph_m09_axi_AWADDR(8 downto 0),
      cfa_ctrl_awready => processing_system7_0_axi_periph_m09_axi_AWREADY,
      cfa_ctrl_awvalid => processing_system7_0_axi_periph_m09_axi_AWVALID,
      cfa_ctrl_bready => processing_system7_0_axi_periph_m09_axi_BREADY,
      cfa_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m09_axi_BRESP(1 downto 0),
      cfa_ctrl_bvalid => processing_system7_0_axi_periph_m09_axi_BVALID,
      cfa_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m09_axi_RDATA(31 downto 0),
      cfa_ctrl_rready => processing_system7_0_axi_periph_m09_axi_RREADY,
      cfa_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m09_axi_RRESP(1 downto 0),
      cfa_ctrl_rvalid => processing_system7_0_axi_periph_m09_axi_RVALID,
      cfa_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m09_axi_WDATA(31 downto 0),
      cfa_ctrl_wready => processing_system7_0_axi_periph_m09_axi_WREADY,
      cfa_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m09_axi_WSTRB(3 downto 0),
      cfa_ctrl_wvalid => processing_system7_0_axi_periph_m09_axi_WVALID,
      clk200 => clk200_1,
      dpc_ctrl_araddr(8 downto 0) => processing_system7_0_axi_periph_m08_axi_ARADDR(8 downto 0),
      dpc_ctrl_arready => processing_system7_0_axi_periph_m08_axi_ARREADY,
      dpc_ctrl_arvalid => processing_system7_0_axi_periph_m08_axi_ARVALID,
      dpc_ctrl_awaddr(8 downto 0) => processing_system7_0_axi_periph_m08_axi_AWADDR(8 downto 0),
      dpc_ctrl_awready => processing_system7_0_axi_periph_m08_axi_AWREADY,
      dpc_ctrl_awvalid => processing_system7_0_axi_periph_m08_axi_AWVALID,
      dpc_ctrl_bready => processing_system7_0_axi_periph_m08_axi_BREADY,
      dpc_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m08_axi_BRESP(1 downto 0),
      dpc_ctrl_bvalid => processing_system7_0_axi_periph_m08_axi_BVALID,
      dpc_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m08_axi_RDATA(31 downto 0),
      dpc_ctrl_rready => processing_system7_0_axi_periph_m08_axi_RREADY,
      dpc_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m08_axi_RRESP(1 downto 0),
      dpc_ctrl_rvalid => processing_system7_0_axi_periph_m08_axi_RVALID,
      dpc_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m08_axi_WDATA(31 downto 0),
      dpc_ctrl_wready => processing_system7_0_axi_periph_m08_axi_WREADY,
      dpc_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m08_axi_WSTRB(3 downto 0),
      dpc_ctrl_wvalid => processing_system7_0_axi_periph_m08_axi_WVALID,
      vita_axi4s_video_tdata(23 downto 0) => fmc2_imageon_vita_color_vita_axi4s_video_TDATA(23 downto 0),
      vita_axi4s_video_tlast => fmc2_imageon_vita_color_vita_axi4s_video_TLAST,
      vita_axi4s_video_tready => fmc2_imageon_vita_color_vita_axi4s_video_TREADY,
      vita_axi4s_video_tuser => fmc2_imageon_vita_color_vita_axi4s_video_TUSER,
      vita_axi4s_video_tvalid => fmc2_imageon_vita_color_vita_axi4s_video_TVALID,
      vita_clk => fmc2_vita_clk,
      vita_ctrl_araddr(7 downto 0) => processing_system7_0_axi_periph_m06_axi_ARADDR(7 downto 0),
      vita_ctrl_arprot(2 downto 0) => processing_system7_0_axi_periph_m06_axi_ARPROT(2 downto 0),
      vita_ctrl_arready => processing_system7_0_axi_periph_m06_axi_ARREADY,
      vita_ctrl_arvalid => processing_system7_0_axi_periph_m06_axi_ARVALID,
      vita_ctrl_awaddr(7 downto 0) => processing_system7_0_axi_periph_m06_axi_AWADDR(7 downto 0),
      vita_ctrl_awprot(2 downto 0) => processing_system7_0_axi_periph_m06_axi_AWPROT(2 downto 0),
      vita_ctrl_awready => processing_system7_0_axi_periph_m06_axi_AWREADY,
      vita_ctrl_awvalid => processing_system7_0_axi_periph_m06_axi_AWVALID,
      vita_ctrl_bready => processing_system7_0_axi_periph_m06_axi_BREADY,
      vita_ctrl_bresp(1 downto 0) => processing_system7_0_axi_periph_m06_axi_BRESP(1 downto 0),
      vita_ctrl_bvalid => processing_system7_0_axi_periph_m06_axi_BVALID,
      vita_ctrl_rdata(31 downto 0) => processing_system7_0_axi_periph_m06_axi_RDATA(31 downto 0),
      vita_ctrl_rready => processing_system7_0_axi_periph_m06_axi_RREADY,
      vita_ctrl_rresp(1 downto 0) => processing_system7_0_axi_periph_m06_axi_RRESP(1 downto 0),
      vita_ctrl_rvalid => processing_system7_0_axi_periph_m06_axi_RVALID,
      vita_ctrl_wdata(31 downto 0) => processing_system7_0_axi_periph_m06_axi_WDATA(31 downto 0),
      vita_ctrl_wready => processing_system7_0_axi_periph_m06_axi_WREADY,
      vita_ctrl_wstrb(3 downto 0) => processing_system7_0_axi_periph_m06_axi_WSTRB(3 downto 0),
      vita_ctrl_wvalid => processing_system7_0_axi_periph_m06_axi_WVALID,
      vita_io_clk_out_n => fmc2_vita_io_clk_out_n,
      vita_io_clk_out_p => fmc2_vita_io_clk_out_p,
      vita_io_clk_pll => fmc2_vita_io_clk_pll,
      vita_io_data_n(3 downto 0) => fmc2_vita_io_data_n(3 downto 0),
      vita_io_data_p(3 downto 0) => fmc2_vita_io_data_p(3 downto 0),
      vita_io_monitor(1 downto 0) => fmc2_vita_io_monitor(1 downto 0),
      vita_io_reset_n => fmc2_vita_io_reset_n,
      vita_io_spi_miso => fmc2_vita_io_spi_miso,
      vita_io_spi_mosi => fmc2_vita_io_spi_mosi,
      vita_io_spi_sclk => fmc2_vita_io_spi_sclk,
      vita_io_spi_ssel_n => fmc2_vita_io_spi_ssel_n,
      vita_io_sync_n => fmc2_vita_io_sync_n,
      vita_io_sync_p => fmc2_vita_io_sync_p,
      vita_io_trigger(2 downto 0) => fmc2_vita_io_trigger(2 downto 0),
      vita_vtiming_active_video => fmc2_imageon_vita_color_vita_vtiming_ACTIVE_VIDEO,
      vita_vtiming_hblank => fmc2_imageon_vita_color_vita_vtiming_HBLANK,
      vita_vtiming_vblank => fmc2_imageon_vita_color_vita_vtiming_VBLANK
    );
proc_sys_reset: component tutorial_proc_sys_reset_0
    port map (
      aux_reset_in => VCC_1,
      bus_struct_reset(0) => NLW_proc_sys_reset_bus_struct_reset_UNCONNECTED(0),
      dcm_locked => VCC_1,
      ext_reset_in => processing_system7_0_fclk_reset0_n,
      interconnect_aresetn(0) => proc_sys_reset_interconnect_aresetn(0),
      mb_debug_sys_rst => GND_1,
      mb_reset => NLW_proc_sys_reset_mb_reset_UNCONNECTED,
      peripheral_aresetn(0) => proc_sys_reset_peripheral_aresetn(0),
      peripheral_reset(0) => NLW_proc_sys_reset_peripheral_reset_UNCONNECTED(0),
      slowest_sync_clk => processing_system7_0_fclk_clk0
    );
processing_system7_0: component tutorial_processing_system7_0_0
    port map (
      DDR_Addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_BankAddr(2 downto 0) => DDR_ba(2 downto 0),
      DDR_CAS_n => DDR_cas_n,
      DDR_CKE => DDR_cke,
      DDR_CS_n => DDR_cs_n,
      DDR_Clk => DDR_ck_p,
      DDR_Clk_n => DDR_ck_n,
      DDR_DM(3 downto 0) => DDR_dm(3 downto 0),
      DDR_DQ(31 downto 0) => DDR_dq(31 downto 0),
      DDR_DQS(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_DQS_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_DRSTB => DDR_reset_n,
      DDR_ODT => DDR_odt,
      DDR_RAS_n => DDR_ras_n,
      DDR_VRN => FIXED_IO_ddr_vrn,
      DDR_VRP => FIXED_IO_ddr_vrp,
      DDR_WEB => DDR_we_n,
      FCLK_CLK0 => processing_system7_0_fclk_clk0,
      FCLK_CLK1 => axi4s_clk_1,
      FCLK_CLK2 => clk200_1,
      FCLK_RESET0_N => processing_system7_0_fclk_reset0_n,
      MIO(53 downto 0) => FIXED_IO_mio(53 downto 0),
      M_AXI_GP0_ACLK => processing_system7_0_fclk_clk0,
      M_AXI_GP0_ARADDR(31 downto 0) => processing_system7_0_m_axi_gp0_ARADDR(31 downto 0),
      M_AXI_GP0_ARBURST(1 downto 0) => processing_system7_0_m_axi_gp0_ARBURST(1 downto 0),
      M_AXI_GP0_ARCACHE(3 downto 0) => processing_system7_0_m_axi_gp0_ARCACHE(3 downto 0),
      M_AXI_GP0_ARID(11 downto 0) => processing_system7_0_m_axi_gp0_ARID(11 downto 0),
      M_AXI_GP0_ARLEN(3 downto 0) => processing_system7_0_m_axi_gp0_ARLEN(3 downto 0),
      M_AXI_GP0_ARLOCK(1 downto 0) => processing_system7_0_m_axi_gp0_ARLOCK(1 downto 0),
      M_AXI_GP0_ARPROT(2 downto 0) => processing_system7_0_m_axi_gp0_ARPROT(2 downto 0),
      M_AXI_GP0_ARQOS(3 downto 0) => processing_system7_0_m_axi_gp0_ARQOS(3 downto 0),
      M_AXI_GP0_ARREADY => processing_system7_0_m_axi_gp0_ARREADY,
      M_AXI_GP0_ARSIZE(2 downto 0) => processing_system7_0_m_axi_gp0_ARSIZE(2 downto 0),
      M_AXI_GP0_ARVALID => processing_system7_0_m_axi_gp0_ARVALID,
      M_AXI_GP0_AWADDR(31 downto 0) => processing_system7_0_m_axi_gp0_AWADDR(31 downto 0),
      M_AXI_GP0_AWBURST(1 downto 0) => processing_system7_0_m_axi_gp0_AWBURST(1 downto 0),
      M_AXI_GP0_AWCACHE(3 downto 0) => processing_system7_0_m_axi_gp0_AWCACHE(3 downto 0),
      M_AXI_GP0_AWID(11 downto 0) => processing_system7_0_m_axi_gp0_AWID(11 downto 0),
      M_AXI_GP0_AWLEN(3 downto 0) => processing_system7_0_m_axi_gp0_AWLEN(3 downto 0),
      M_AXI_GP0_AWLOCK(1 downto 0) => processing_system7_0_m_axi_gp0_AWLOCK(1 downto 0),
      M_AXI_GP0_AWPROT(2 downto 0) => processing_system7_0_m_axi_gp0_AWPROT(2 downto 0),
      M_AXI_GP0_AWQOS(3 downto 0) => processing_system7_0_m_axi_gp0_AWQOS(3 downto 0),
      M_AXI_GP0_AWREADY => processing_system7_0_m_axi_gp0_AWREADY,
      M_AXI_GP0_AWSIZE(2 downto 0) => processing_system7_0_m_axi_gp0_AWSIZE(2 downto 0),
      M_AXI_GP0_AWVALID => processing_system7_0_m_axi_gp0_AWVALID,
      M_AXI_GP0_BID(11 downto 0) => processing_system7_0_m_axi_gp0_BID(11 downto 0),
      M_AXI_GP0_BREADY => processing_system7_0_m_axi_gp0_BREADY,
      M_AXI_GP0_BRESP(1 downto 0) => processing_system7_0_m_axi_gp0_BRESP(1 downto 0),
      M_AXI_GP0_BVALID => processing_system7_0_m_axi_gp0_BVALID,
      M_AXI_GP0_RDATA(31 downto 0) => processing_system7_0_m_axi_gp0_RDATA(31 downto 0),
      M_AXI_GP0_RID(11 downto 0) => processing_system7_0_m_axi_gp0_RID(11 downto 0),
      M_AXI_GP0_RLAST => processing_system7_0_m_axi_gp0_RLAST,
      M_AXI_GP0_RREADY => processing_system7_0_m_axi_gp0_RREADY,
      M_AXI_GP0_RRESP(1 downto 0) => processing_system7_0_m_axi_gp0_RRESP(1 downto 0),
      M_AXI_GP0_RVALID => processing_system7_0_m_axi_gp0_RVALID,
      M_AXI_GP0_WDATA(31 downto 0) => processing_system7_0_m_axi_gp0_WDATA(31 downto 0),
      M_AXI_GP0_WID(11 downto 0) => processing_system7_0_m_axi_gp0_WID(11 downto 0),
      M_AXI_GP0_WLAST => processing_system7_0_m_axi_gp0_WLAST,
      M_AXI_GP0_WREADY => processing_system7_0_m_axi_gp0_WREADY,
      M_AXI_GP0_WSTRB(3 downto 0) => processing_system7_0_m_axi_gp0_WSTRB(3 downto 0),
      M_AXI_GP0_WVALID => processing_system7_0_m_axi_gp0_WVALID,
      PS_CLK => FIXED_IO_ps_clk,
      PS_PORB => FIXED_IO_ps_porb,
      PS_SRSTB => FIXED_IO_ps_srstb,
      TTC0_CLK0_IN => GND_1,
      TTC0_CLK1_IN => GND_1,
      TTC0_CLK2_IN => GND_1,
      TTC0_WAVE0_OUT => NLW_processing_system7_0_TTC0_WAVE0_OUT_UNCONNECTED,
      TTC0_WAVE1_OUT => NLW_processing_system7_0_TTC0_WAVE1_OUT_UNCONNECTED,
      TTC0_WAVE2_OUT => NLW_processing_system7_0_TTC0_WAVE2_OUT_UNCONNECTED,
      USB0_PORT_INDCTL(1 downto 0) => NLW_processing_system7_0_USB0_PORT_INDCTL_UNCONNECTED(1 downto 0),
      USB0_VBUS_PWRFAULT => GND_1,
      USB0_VBUS_PWRSELECT => NLW_processing_system7_0_USB0_VBUS_PWRSELECT_UNCONNECTED
    );
processing_system7_0_axi_periph: entity work.tutorial_processing_system7_0_axi_periph_0
    port map (
      ACLK => processing_system7_0_fclk_clk0,
      ARESETN(0) => proc_sys_reset_interconnect_aresetn(0),
      M00_ACLK => processing_system7_0_fclk_clk0,
      M00_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M00_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m00_axi_ARADDR(8 downto 0),
      M00_AXI_arready(0) => processing_system7_0_axi_periph_m00_axi_ARREADY,
      M00_AXI_arvalid(0) => processing_system7_0_axi_periph_m00_axi_ARVALID(0),
      M00_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m00_axi_AWADDR(8 downto 0),
      M00_AXI_awready(0) => processing_system7_0_axi_periph_m00_axi_AWREADY,
      M00_AXI_awvalid(0) => processing_system7_0_axi_periph_m00_axi_AWVALID(0),
      M00_AXI_bready(0) => processing_system7_0_axi_periph_m00_axi_BREADY(0),
      M00_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m00_axi_BRESP(1 downto 0),
      M00_AXI_bvalid(0) => processing_system7_0_axi_periph_m00_axi_BVALID,
      M00_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m00_axi_RDATA(31 downto 0),
      M00_AXI_rready(0) => processing_system7_0_axi_periph_m00_axi_RREADY(0),
      M00_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m00_axi_RRESP(1 downto 0),
      M00_AXI_rvalid(0) => processing_system7_0_axi_periph_m00_axi_RVALID,
      M00_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m00_axi_WDATA(31 downto 0),
      M00_AXI_wready(0) => processing_system7_0_axi_periph_m00_axi_WREADY,
      M00_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m00_axi_WSTRB(3 downto 0),
      M00_AXI_wvalid(0) => processing_system7_0_axi_periph_m00_axi_WVALID(0),
      M01_ACLK => processing_system7_0_fclk_clk0,
      M01_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M01_AXI_araddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_ARADDR(7 downto 0),
      M01_AXI_arprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_ARPROT(2 downto 0),
      M01_AXI_arready => processing_system7_0_axi_periph_m01_axi_ARREADY,
      M01_AXI_arvalid => processing_system7_0_axi_periph_m01_axi_ARVALID,
      M01_AXI_awaddr(7 downto 0) => processing_system7_0_axi_periph_m01_axi_AWADDR(7 downto 0),
      M01_AXI_awprot(2 downto 0) => processing_system7_0_axi_periph_m01_axi_AWPROT(2 downto 0),
      M01_AXI_awready => processing_system7_0_axi_periph_m01_axi_AWREADY,
      M01_AXI_awvalid => processing_system7_0_axi_periph_m01_axi_AWVALID,
      M01_AXI_bready => processing_system7_0_axi_periph_m01_axi_BREADY,
      M01_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_BRESP(1 downto 0),
      M01_AXI_bvalid => processing_system7_0_axi_periph_m01_axi_BVALID,
      M01_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_RDATA(31 downto 0),
      M01_AXI_rready => processing_system7_0_axi_periph_m01_axi_RREADY,
      M01_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m01_axi_RRESP(1 downto 0),
      M01_AXI_rvalid => processing_system7_0_axi_periph_m01_axi_RVALID,
      M01_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m01_axi_WDATA(31 downto 0),
      M01_AXI_wready => processing_system7_0_axi_periph_m01_axi_WREADY,
      M01_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m01_axi_WSTRB(3 downto 0),
      M01_AXI_wvalid => processing_system7_0_axi_periph_m01_axi_WVALID,
      M02_ACLK => processing_system7_0_fclk_clk0,
      M02_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M02_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m02_axi_ARADDR(8 downto 0),
      M02_AXI_arready => processing_system7_0_axi_periph_m02_axi_ARREADY,
      M02_AXI_arvalid => processing_system7_0_axi_periph_m02_axi_ARVALID,
      M02_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m02_axi_AWADDR(8 downto 0),
      M02_AXI_awready => processing_system7_0_axi_periph_m02_axi_AWREADY,
      M02_AXI_awvalid => processing_system7_0_axi_periph_m02_axi_AWVALID,
      M02_AXI_bready => processing_system7_0_axi_periph_m02_axi_BREADY,
      M02_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m02_axi_BRESP(1 downto 0),
      M02_AXI_bvalid => processing_system7_0_axi_periph_m02_axi_BVALID,
      M02_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m02_axi_RDATA(31 downto 0),
      M02_AXI_rready => processing_system7_0_axi_periph_m02_axi_RREADY,
      M02_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m02_axi_RRESP(1 downto 0),
      M02_AXI_rvalid => processing_system7_0_axi_periph_m02_axi_RVALID,
      M02_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m02_axi_WDATA(31 downto 0),
      M02_AXI_wready => processing_system7_0_axi_periph_m02_axi_WREADY,
      M02_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m02_axi_WSTRB(3 downto 0),
      M02_AXI_wvalid => processing_system7_0_axi_periph_m02_axi_WVALID,
      M03_ACLK => processing_system7_0_fclk_clk0,
      M03_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M03_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m03_axi_ARADDR(8 downto 0),
      M03_AXI_arready => processing_system7_0_axi_periph_m03_axi_ARREADY,
      M03_AXI_arvalid => processing_system7_0_axi_periph_m03_axi_ARVALID,
      M03_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m03_axi_AWADDR(8 downto 0),
      M03_AXI_awready => processing_system7_0_axi_periph_m03_axi_AWREADY,
      M03_AXI_awvalid => processing_system7_0_axi_periph_m03_axi_AWVALID,
      M03_AXI_bready => processing_system7_0_axi_periph_m03_axi_BREADY,
      M03_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m03_axi_BRESP(1 downto 0),
      M03_AXI_bvalid => processing_system7_0_axi_periph_m03_axi_BVALID,
      M03_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m03_axi_RDATA(31 downto 0),
      M03_AXI_rready => processing_system7_0_axi_periph_m03_axi_RREADY,
      M03_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m03_axi_RRESP(1 downto 0),
      M03_AXI_rvalid => processing_system7_0_axi_periph_m03_axi_RVALID,
      M03_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m03_axi_WDATA(31 downto 0),
      M03_AXI_wready => processing_system7_0_axi_periph_m03_axi_WREADY,
      M03_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m03_axi_WSTRB(3 downto 0),
      M03_AXI_wvalid => processing_system7_0_axi_periph_m03_axi_WVALID,
      M04_ACLK => processing_system7_0_fclk_clk0,
      M04_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M04_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m04_axi_ARADDR(8 downto 0),
      M04_AXI_arready => processing_system7_0_axi_periph_m04_axi_ARREADY,
      M04_AXI_arvalid => processing_system7_0_axi_periph_m04_axi_ARVALID,
      M04_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m04_axi_AWADDR(8 downto 0),
      M04_AXI_awready => processing_system7_0_axi_periph_m04_axi_AWREADY,
      M04_AXI_awvalid => processing_system7_0_axi_periph_m04_axi_AWVALID,
      M04_AXI_bready => processing_system7_0_axi_periph_m04_axi_BREADY,
      M04_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m04_axi_BRESP(1 downto 0),
      M04_AXI_bvalid => processing_system7_0_axi_periph_m04_axi_BVALID,
      M04_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m04_axi_RDATA(31 downto 0),
      M04_AXI_rready => processing_system7_0_axi_periph_m04_axi_RREADY,
      M04_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m04_axi_RRESP(1 downto 0),
      M04_AXI_rvalid => processing_system7_0_axi_periph_m04_axi_RVALID,
      M04_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m04_axi_WDATA(31 downto 0),
      M04_AXI_wready => processing_system7_0_axi_periph_m04_axi_WREADY,
      M04_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m04_axi_WSTRB(3 downto 0),
      M04_AXI_wvalid => processing_system7_0_axi_periph_m04_axi_WVALID,
      M05_ACLK => processing_system7_0_fclk_clk0,
      M05_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M05_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m05_axi_ARADDR(8 downto 0),
      M05_AXI_arready => processing_system7_0_axi_periph_m05_axi_ARREADY,
      M05_AXI_arvalid => processing_system7_0_axi_periph_m05_axi_ARVALID,
      M05_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m05_axi_AWADDR(8 downto 0),
      M05_AXI_awready => processing_system7_0_axi_periph_m05_axi_AWREADY,
      M05_AXI_awvalid => processing_system7_0_axi_periph_m05_axi_AWVALID,
      M05_AXI_bready => processing_system7_0_axi_periph_m05_axi_BREADY,
      M05_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m05_axi_BRESP(1 downto 0),
      M05_AXI_bvalid => processing_system7_0_axi_periph_m05_axi_BVALID,
      M05_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m05_axi_RDATA(31 downto 0),
      M05_AXI_rready => processing_system7_0_axi_periph_m05_axi_RREADY,
      M05_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m05_axi_RRESP(1 downto 0),
      M05_AXI_rvalid => processing_system7_0_axi_periph_m05_axi_RVALID,
      M05_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m05_axi_WDATA(31 downto 0),
      M05_AXI_wready => processing_system7_0_axi_periph_m05_axi_WREADY,
      M05_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m05_axi_WSTRB(3 downto 0),
      M05_AXI_wvalid => processing_system7_0_axi_periph_m05_axi_WVALID,
      M06_ACLK => processing_system7_0_fclk_clk0,
      M06_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M06_AXI_araddr(7 downto 0) => processing_system7_0_axi_periph_m06_axi_ARADDR(7 downto 0),
      M06_AXI_arprot(2 downto 0) => processing_system7_0_axi_periph_m06_axi_ARPROT(2 downto 0),
      M06_AXI_arready => processing_system7_0_axi_periph_m06_axi_ARREADY,
      M06_AXI_arvalid => processing_system7_0_axi_periph_m06_axi_ARVALID,
      M06_AXI_awaddr(7 downto 0) => processing_system7_0_axi_periph_m06_axi_AWADDR(7 downto 0),
      M06_AXI_awprot(2 downto 0) => processing_system7_0_axi_periph_m06_axi_AWPROT(2 downto 0),
      M06_AXI_awready => processing_system7_0_axi_periph_m06_axi_AWREADY,
      M06_AXI_awvalid => processing_system7_0_axi_periph_m06_axi_AWVALID,
      M06_AXI_bready => processing_system7_0_axi_periph_m06_axi_BREADY,
      M06_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m06_axi_BRESP(1 downto 0),
      M06_AXI_bvalid => processing_system7_0_axi_periph_m06_axi_BVALID,
      M06_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m06_axi_RDATA(31 downto 0),
      M06_AXI_rready => processing_system7_0_axi_periph_m06_axi_RREADY,
      M06_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m06_axi_RRESP(1 downto 0),
      M06_AXI_rvalid => processing_system7_0_axi_periph_m06_axi_RVALID,
      M06_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m06_axi_WDATA(31 downto 0),
      M06_AXI_wready => processing_system7_0_axi_periph_m06_axi_WREADY,
      M06_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m06_axi_WSTRB(3 downto 0),
      M06_AXI_wvalid => processing_system7_0_axi_periph_m06_axi_WVALID,
      M07_ACLK => processing_system7_0_fclk_clk0,
      M07_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M07_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m07_axi_ARADDR(8 downto 0),
      M07_AXI_arready => processing_system7_0_axi_periph_m07_axi_ARREADY,
      M07_AXI_arvalid => processing_system7_0_axi_periph_m07_axi_ARVALID,
      M07_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m07_axi_AWADDR(8 downto 0),
      M07_AXI_awready => processing_system7_0_axi_periph_m07_axi_AWREADY,
      M07_AXI_awvalid => processing_system7_0_axi_periph_m07_axi_AWVALID,
      M07_AXI_bready => processing_system7_0_axi_periph_m07_axi_BREADY,
      M07_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m07_axi_BRESP(1 downto 0),
      M07_AXI_bvalid => processing_system7_0_axi_periph_m07_axi_BVALID,
      M07_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m07_axi_RDATA(31 downto 0),
      M07_AXI_rready => processing_system7_0_axi_periph_m07_axi_RREADY,
      M07_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m07_axi_RRESP(1 downto 0),
      M07_AXI_rvalid => processing_system7_0_axi_periph_m07_axi_RVALID,
      M07_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m07_axi_WDATA(31 downto 0),
      M07_AXI_wready => processing_system7_0_axi_periph_m07_axi_WREADY,
      M07_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m07_axi_WSTRB(3 downto 0),
      M07_AXI_wvalid => processing_system7_0_axi_periph_m07_axi_WVALID,
      M08_ACLK => processing_system7_0_fclk_clk0,
      M08_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M08_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m08_axi_ARADDR(8 downto 0),
      M08_AXI_arready => processing_system7_0_axi_periph_m08_axi_ARREADY,
      M08_AXI_arvalid => processing_system7_0_axi_periph_m08_axi_ARVALID,
      M08_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m08_axi_AWADDR(8 downto 0),
      M08_AXI_awready => processing_system7_0_axi_periph_m08_axi_AWREADY,
      M08_AXI_awvalid => processing_system7_0_axi_periph_m08_axi_AWVALID,
      M08_AXI_bready => processing_system7_0_axi_periph_m08_axi_BREADY,
      M08_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m08_axi_BRESP(1 downto 0),
      M08_AXI_bvalid => processing_system7_0_axi_periph_m08_axi_BVALID,
      M08_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m08_axi_RDATA(31 downto 0),
      M08_AXI_rready => processing_system7_0_axi_periph_m08_axi_RREADY,
      M08_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m08_axi_RRESP(1 downto 0),
      M08_AXI_rvalid => processing_system7_0_axi_periph_m08_axi_RVALID,
      M08_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m08_axi_WDATA(31 downto 0),
      M08_AXI_wready => processing_system7_0_axi_periph_m08_axi_WREADY,
      M08_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m08_axi_WSTRB(3 downto 0),
      M08_AXI_wvalid => processing_system7_0_axi_periph_m08_axi_WVALID,
      M09_ACLK => processing_system7_0_fclk_clk0,
      M09_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      M09_AXI_araddr(8 downto 0) => processing_system7_0_axi_periph_m09_axi_ARADDR(8 downto 0),
      M09_AXI_arready => processing_system7_0_axi_periph_m09_axi_ARREADY,
      M09_AXI_arvalid => processing_system7_0_axi_periph_m09_axi_ARVALID,
      M09_AXI_awaddr(8 downto 0) => processing_system7_0_axi_periph_m09_axi_AWADDR(8 downto 0),
      M09_AXI_awready => processing_system7_0_axi_periph_m09_axi_AWREADY,
      M09_AXI_awvalid => processing_system7_0_axi_periph_m09_axi_AWVALID,
      M09_AXI_bready => processing_system7_0_axi_periph_m09_axi_BREADY,
      M09_AXI_bresp(1 downto 0) => processing_system7_0_axi_periph_m09_axi_BRESP(1 downto 0),
      M09_AXI_bvalid => processing_system7_0_axi_periph_m09_axi_BVALID,
      M09_AXI_rdata(31 downto 0) => processing_system7_0_axi_periph_m09_axi_RDATA(31 downto 0),
      M09_AXI_rready => processing_system7_0_axi_periph_m09_axi_RREADY,
      M09_AXI_rresp(1 downto 0) => processing_system7_0_axi_periph_m09_axi_RRESP(1 downto 0),
      M09_AXI_rvalid => processing_system7_0_axi_periph_m09_axi_RVALID,
      M09_AXI_wdata(31 downto 0) => processing_system7_0_axi_periph_m09_axi_WDATA(31 downto 0),
      M09_AXI_wready => processing_system7_0_axi_periph_m09_axi_WREADY,
      M09_AXI_wstrb(3 downto 0) => processing_system7_0_axi_periph_m09_axi_WSTRB(3 downto 0),
      M09_AXI_wvalid => processing_system7_0_axi_periph_m09_axi_WVALID,
      S00_ACLK => processing_system7_0_fclk_clk0,
      S00_ARESETN(0) => proc_sys_reset_peripheral_aresetn(0),
      S00_AXI_araddr(31 downto 0) => processing_system7_0_m_axi_gp0_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => processing_system7_0_m_axi_gp0_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => processing_system7_0_m_axi_gp0_ARCACHE(3 downto 0),
      S00_AXI_arid(11 downto 0) => processing_system7_0_m_axi_gp0_ARID(11 downto 0),
      S00_AXI_arlen(3 downto 0) => processing_system7_0_m_axi_gp0_ARLEN(3 downto 0),
      S00_AXI_arlock(1 downto 0) => processing_system7_0_m_axi_gp0_ARLOCK(1 downto 0),
      S00_AXI_arprot(2 downto 0) => processing_system7_0_m_axi_gp0_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => processing_system7_0_m_axi_gp0_ARQOS(3 downto 0),
      S00_AXI_arready => processing_system7_0_m_axi_gp0_ARREADY,
      S00_AXI_arsize(2 downto 0) => processing_system7_0_m_axi_gp0_ARSIZE(2 downto 0),
      S00_AXI_arvalid => processing_system7_0_m_axi_gp0_ARVALID,
      S00_AXI_awaddr(31 downto 0) => processing_system7_0_m_axi_gp0_AWADDR(31 downto 0),
      S00_AXI_awburst(1 downto 0) => processing_system7_0_m_axi_gp0_AWBURST(1 downto 0),
      S00_AXI_awcache(3 downto 0) => processing_system7_0_m_axi_gp0_AWCACHE(3 downto 0),
      S00_AXI_awid(11 downto 0) => processing_system7_0_m_axi_gp0_AWID(11 downto 0),
      S00_AXI_awlen(3 downto 0) => processing_system7_0_m_axi_gp0_AWLEN(3 downto 0),
      S00_AXI_awlock(1 downto 0) => processing_system7_0_m_axi_gp0_AWLOCK(1 downto 0),
      S00_AXI_awprot(2 downto 0) => processing_system7_0_m_axi_gp0_AWPROT(2 downto 0),
      S00_AXI_awqos(3 downto 0) => processing_system7_0_m_axi_gp0_AWQOS(3 downto 0),
      S00_AXI_awready => processing_system7_0_m_axi_gp0_AWREADY,
      S00_AXI_awsize(2 downto 0) => processing_system7_0_m_axi_gp0_AWSIZE(2 downto 0),
      S00_AXI_awvalid => processing_system7_0_m_axi_gp0_AWVALID,
      S00_AXI_bid(11 downto 0) => processing_system7_0_m_axi_gp0_BID(11 downto 0),
      S00_AXI_bready => processing_system7_0_m_axi_gp0_BREADY,
      S00_AXI_bresp(1 downto 0) => processing_system7_0_m_axi_gp0_BRESP(1 downto 0),
      S00_AXI_bvalid => processing_system7_0_m_axi_gp0_BVALID,
      S00_AXI_rdata(31 downto 0) => processing_system7_0_m_axi_gp0_RDATA(31 downto 0),
      S00_AXI_rid(11 downto 0) => processing_system7_0_m_axi_gp0_RID(11 downto 0),
      S00_AXI_rlast => processing_system7_0_m_axi_gp0_RLAST,
      S00_AXI_rready => processing_system7_0_m_axi_gp0_RREADY,
      S00_AXI_rresp(1 downto 0) => processing_system7_0_m_axi_gp0_RRESP(1 downto 0),
      S00_AXI_rvalid => processing_system7_0_m_axi_gp0_RVALID,
      S00_AXI_wdata(31 downto 0) => processing_system7_0_m_axi_gp0_WDATA(31 downto 0),
      S00_AXI_wid(11 downto 0) => processing_system7_0_m_axi_gp0_WID(11 downto 0),
      S00_AXI_wlast => processing_system7_0_m_axi_gp0_WLAST,
      S00_AXI_wready => processing_system7_0_m_axi_gp0_WREADY,
      S00_AXI_wstrb(3 downto 0) => processing_system7_0_m_axi_gp0_WSTRB(3 downto 0),
      S00_AXI_wvalid => processing_system7_0_m_axi_gp0_WVALID
    );
end STRUCTURE;
