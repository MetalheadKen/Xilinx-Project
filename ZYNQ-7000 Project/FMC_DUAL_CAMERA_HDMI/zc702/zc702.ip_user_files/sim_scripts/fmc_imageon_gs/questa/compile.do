vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/axi_lite_ipif_v3_0_3
vlib msim/v_tc_v6_1_6
vlib msim/v_cfa_v7_0_7
vlib msim/v_cresample_v4_0_7
vlib msim/v_rgb2ycrcb_v7_1_6
vlib msim/lib_pkg_v1_0_2
vlib msim/lib_cdc_v1_0_2
vlib msim/interrupt_control_v3_1_3
vlib msim/axi_iic_v2_0_10
vlib msim/generic_baseblocks_v2_1_0
vlib msim/axi_infrastructure_v1_1_0
vlib msim/axi_register_slice_v2_1_7
vlib msim/fifo_generator_v13_0_1
vlib msim/axi_data_fifo_v2_1_6
vlib msim/axi_crossbar_v2_1_8
vlib msim/proc_sys_reset_v5_0_8
vlib msim/v_vid_in_axi4s_v4_0_1
vlib msim/v_axi4s_vid_out_v4_0_1
vlib msim/axi_protocol_converter_v2_1_7

vmap xil_defaultlib msim/xil_defaultlib
vmap axi_lite_ipif_v3_0_3 msim/axi_lite_ipif_v3_0_3
vmap v_tc_v6_1_6 msim/v_tc_v6_1_6
vmap v_cfa_v7_0_7 msim/v_cfa_v7_0_7
vmap v_cresample_v4_0_7 msim/v_cresample_v4_0_7
vmap v_rgb2ycrcb_v7_1_6 msim/v_rgb2ycrcb_v7_1_6
vmap lib_pkg_v1_0_2 msim/lib_pkg_v1_0_2
vmap lib_cdc_v1_0_2 msim/lib_cdc_v1_0_2
vmap interrupt_control_v3_1_3 msim/interrupt_control_v3_1_3
vmap axi_iic_v2_0_10 msim/axi_iic_v2_0_10
vmap generic_baseblocks_v2_1_0 msim/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 msim/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_7 msim/axi_register_slice_v2_1_7
vmap fifo_generator_v13_0_1 msim/fifo_generator_v13_0_1
vmap axi_data_fifo_v2_1_6 msim/axi_data_fifo_v2_1_6
vmap axi_crossbar_v2_1_8 msim/axi_crossbar_v2_1_8
vmap proc_sys_reset_v5_0_8 msim/proc_sys_reset_v5_0_8
vmap v_vid_in_axi4s_v4_0_1 msim/v_vid_in_axi4s_v4_0_1
vmap v_axi4s_vid_out_v4_0_1 msim/v_axi4s_vid_out_v4_0_1
vmap axi_protocol_converter_v2_1_7 msim/axi_protocol_converter_v2_1_7

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr_4.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd_4.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp2_3.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp0_1.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ssw_hp.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_sparse_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_reg_map.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocm_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_wr_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_rd_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_fmsw_gp.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_regc.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocmc.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_interconnect_model.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_reset.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_clock.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ddrc.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_slave.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_master.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_afi_slave.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_processing_system7_bfm.v" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_processing_system7_0_0/sim/fmc_imageon_gs_processing_system7_0_0.v" \

vcom -work axi_lite_ipif_v3_0_3 -64 \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/ipif_pkg.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/pselect_f.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/address_decoder.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/axi_lite_ipif.vhd" \

vcom -work v_tc_v6_1_6 -64 \
"../../../ipstatic/v_tc_v6_1/hdl/v_tc_v6_1_vh_rfs.vhd" \

vcom -work v_cfa_v7_0_7 -64 \
"../../../ipstatic/v_cfa_v7_0/hdl/v_cfa_v7_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_0/sim/fmc_imageon_gs_v_cfa_0_0.vhd" \

vcom -work v_cresample_v4_0_7 -64 \
"../../../ipstatic/v_cresample_v4_0/hdl/v_cresample_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_0/sim/fmc_imageon_gs_v_cresample_0_0.vhd" \

vcom -work v_rgb2ycrcb_v7_1_6 -64 \
"../../../ipstatic/v_rgb2ycrcb_v7_1/hdl/v_rgb2ycrcb_v7_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_0/sim/fmc_imageon_gs_v_rgb2ycrcb_0_0.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_tc_0_0/sim/fmc_imageon_gs_v_tc_0_0.vhd" \

vcom -work lib_pkg_v1_0_2 -64 \
"../../../ipstatic/lib_pkg_v1_0/hdl/src/vhdl/lib_pkg.vhd" \

vcom -work lib_cdc_v1_0_2 -64 \
"../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \

vcom -work interrupt_control_v3_1_3 -64 \
"../../../ipstatic/interrupt_control_v3_1/hdl/src/vhdl/interrupt_control.vhd" \

vcom -work axi_iic_v2_0_10 -64 \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/soft_reset.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/srl_fifo.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/upcnt_n.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/shift8.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/iic_pkg.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/debounce.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/reg_interface.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/iic_control.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/filter.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/dynamic_master.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/axi_ipif_ssp1.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/iic.vhd" \
"../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/axi_iic.vhd" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_fmc_imageon_iic_0_0/sim/fmc_imageon_gs_fmc_imageon_iic_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_0 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \

vlog -work axi_infrastructure_v1_1_0 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \

vlog -work axi_register_slice_v2_1_7 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
"../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \

vcom -work fifo_generator_v13_0_1 -64 \
"../../../ipstatic/fifo_generator_v13_0/simulation/fifo_generator_vhdl_beh.vhd" \
"../../../ipstatic/fifo_generator_v13_0/hdl/fifo_generator_v13_0_rfs.vhd" \

vlog -work axi_data_fifo_v2_1_6 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \

vlog -work axi_crossbar_v2_1_8 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_si_transactor.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_splitter.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_router.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_xbar_1/sim/fmc_imageon_gs_xbar_1.v" \

vcom -work proc_sys_reset_v5_0_8 -64 \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_0/sim/fmc_imageon_gs_rst_processing_system7_0_76M_0.vhd" \

vlog -work v_vid_in_axi4s_v4_0_1 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/v_vid_in_axi4s_v4_0/hdl/verilog/v_vid_in_axi4s_v4_0_coupler.v" \
"../../../ipstatic/v_vid_in_axi4s_v4_0/hdl/verilog/v_vid_in_axi4s_v4_0_formatter.v" \
"../../../ipstatic/v_vid_in_axi4s_v4_0/hdl/verilog/v_vid_in_axi4s_v4_0.v" \

vlog -work v_axi4s_vid_out_v4_0_1 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0.v" \
"../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0_coupler.v" \
"../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0_sync.v" \
"../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0_formatter.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_axi4s_vid_out_0_0/sim/fmc_imageon_gs_v_axi4s_vid_out_0_0.v" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_0/sim/fmc_imageon_gs_v_vid_in_axi4s_0_0.v" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/ipshared/xilinx.com/xlconstant_v1_1/xlconstant.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_xlconstant_0_0/sim/fmc_imageon_gs_xlconstant_0_0.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_xlconstant_1_0/sim/fmc_imageon_gs_xlconstant_1_0.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_1/sim/fmc_imageon_gs_v_cfa_0_1.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_1/sim/fmc_imageon_gs_v_cresample_0_1.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_1/sim/fmc_imageon_gs_v_rgb2ycrcb_0_1.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_1/sim/fmc_imageon_gs_v_vid_in_axi4s_0_1.v" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/hdl/fmc_imageon_gs.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_fmc_imageon_iic_0_1/sim/fmc_imageon_gs_fmc_imageon_iic_0_1.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_axi4s_vid_out_0_1/sim/fmc_imageon_gs_v_axi4s_vid_out_0_1.v" \

vcom -work xil_defaultlib -64 \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_tc_0_1/sim/fmc_imageon_gs_v_tc_0_1.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_2/sim/fmc_imageon_gs_rst_processing_system7_0_76M_2.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M1_0/sim/fmc_imageon_gs_rst_processing_system7_0_76M1_0.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/onsemi_vita_cam_v3_1_S00_AXI.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/onsemi_vita_cam_v3_1.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/pck_crc10_d10.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/pulse_regen.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_core.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/correct_column_fpn_prnu_dsp48e.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/syncchanneldecoder.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/triggergenerator.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_mux.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/videosyncgen.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/afifo_64i_16o.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/crc_calc.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/onsemi_vita_cam_core.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_idelayctrl.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/pck_crc8_d8.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_datadeser.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_interface_s6.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_control.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_datadeser_s6.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_sync.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_interface.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/crc_check.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_compare.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_clocks.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/remapper.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/crc_comp.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_cam_0_0/sim/fmc_imageon_gs_onsemi_vita_cam_0_0.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_cam_L_0_0/sim/fmc_imageon_gs_onsemi_vita_cam_L_0_0.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/avnet_hdmi_out_v3_1/hdl/vhdl/adv7511_embed_syncs.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/avnet_hdmi_out_v3_1/hdl/vhdl/avnet_hdmi_out.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_avnet_hdmi_out_0_0/sim/fmc_imageon_gs_avnet_hdmi_out_0_0.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_avnet_hdmi_out_0_1/sim/fmc_imageon_gs_avnet_hdmi_out_0_1.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/onsemi_vita_spi_v3_1_S00_AXI.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/onsemi_vita_spi_v3_1.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/afifo_32.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/spi_top.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/spi_seq.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/onsemi_vita_spi_core.vhd" \
"../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/spi_lowlevel.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_spi_0_0/sim/fmc_imageon_gs_onsemi_vita_spi_0_0.vhd" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_spi_0_1/sim/fmc_imageon_gs_onsemi_vita_spi_0_1.vhd" \

vlog -work axi_protocol_converter_v2_1_7 -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
"../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_auto_pc_0/sim/fmc_imageon_gs_auto_pc_0.v" \

vlog -work xil_defaultlib "glbl.v"

