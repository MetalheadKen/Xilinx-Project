#!/bin/bash -f
# Vivado (TM) v2015.4 (64-bit)
#
# Filename    : fmc_imageon_gs.sh
# Simulator   : Cadence Incisive Enterprise Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do/prj' file, execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Sat Feb 18 19:16:10 +0800 2017
# IP Build 1412160 on Tue Nov 17 13:47:24 MST 2015 
#
# usage: fmc_imageon_gs.sh [-help]
# usage: fmc_imageon_gs.sh [-lib_map_path]
# usage: fmc_imageon_gs.sh [-noclean_files]
# usage: fmc_imageon_gs.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'fmc_imageon_gs.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
# ********************************************************************************************************

# Script info
echo -e "fmc_imageon_gs.sh - Script generated by export_simulation (Vivado v2015.4 (64-bit)-id)\n"

# Script usage
usage()
{
  msg="Usage: fmc_imageon_gs.sh [-help]\n\
Usage: fmc_imageon_gs.sh [-lib_map_path]\n\
Usage: fmc_imageon_gs.sh [-reset_run]\n\
Usage: fmc_imageon_gs.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

if [[ ($# == 1 ) && ($1 != "-lib_map_path" && $1 != "-noclean_files" && $1 != "-reset_run" && $1 != "-help" && $1 != "-h") ]]; then
  echo -e "ERROR: Unknown option specified '$1' (type \"./fmc_imageon_gs.sh -help\" for more information)\n"
  exit 1
fi

if [[ ($1 == "-help" || $1 == "-h") ]]; then
  usage
fi

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./fmc_imageon_gs.sh -help\" for more information)\n"
        exit 1
      fi
      # precompiled simulation library directory path
     create_lib_mappings $2
     touch hdl.var
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
     create_lib_mappings $2
     touch hdl.var
  esac

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Remove generated data from the previous run and re-create setup files/library mappings
reset_run()
{
  files_to_remove=(ncsim.key irun.key ncvlog.log ncvhdl.log compile.log elaborate.log simulate.log run.log waves.shm INCA_libs)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done
}

# Main steps
run()
{
  setup $1 $2
  compile
  elaborate
  simulate
}

# Create design library directory paths and define design library mappings in cds.lib
create_lib_mappings()
{
  libs=(xil_defaultlib axi_lite_ipif_v3_0_3 v_tc_v6_1_6 v_cfa_v7_0_7 v_cresample_v4_0_7 v_rgb2ycrcb_v7_1_6 lib_pkg_v1_0_2 lib_cdc_v1_0_2 interrupt_control_v3_1_3 axi_iic_v2_0_10 generic_baseblocks_v2_1_0 axi_infrastructure_v1_1_0 axi_register_slice_v2_1_7 fifo_generator_v13_0_1 axi_data_fifo_v2_1_6 axi_crossbar_v2_1_8 proc_sys_reset_v5_0_8 v_vid_in_axi4s_v4_0_1 v_axi4s_vid_out_v4_0_1 axi_protocol_converter_v2_1_7)
  file="cds.lib"
  dir="ies"

  if [[ -e $file ]]; then
    rm -f $file
  fi

  if [[ -e $dir ]]; then
    rm -rf $dir
  fi

  touch $file
  lib_map_path="<SPECIFY_COMPILED_LIB_PATH>"
  if [[ ($1 != "" && -e $1) ]]; then
    lib_map_path="$1"
  else
    echo -e "ERROR: Compiled simulation library directory path not specified or does not exist (type "./top.sh -help" for more information)\n"
  fi
  incl_ref="INCLUDE $lib_map_path/cds.lib"
  echo $incl_ref >> $file

  for (( i=0; i<${#libs[*]}; i++ )); do
    lib="${libs[i]}"
    lib_dir="$dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
      mapping="DEFINE $lib $dir/$lib"
      echo $mapping >> $file
    fi
  done
}


# RUN_STEP: <compile>
compile()
{
  # Directory path for design sources and include directories (if any) wrt this path
  ref_dir="."
  # Command line options
  opts_ver="-64bit -messages -logfile ncvlog.log -append_log"
  opts_vhd="-64bit -V93 -RELAX -logfile ncvhdl.log -append_log"

  # Compile design files
  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr_4.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd_4.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp2_3.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp0_1.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ssw_hp.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_sparse_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_reg_map.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocm_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_wr_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_rd_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_fmsw_gp.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_regc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocmc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_interconnect_model.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_reset.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_clock.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ddrc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_slave.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_master.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_afi_slave.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_processing_system7_bfm.v" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_processing_system7_0_0/sim/fmc_imageon_gs_processing_system7_0_0.v" \

  ncvhdl -work axi_lite_ipif_v3_0_3 $opts_vhd \
    "$ref_dir/../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/ipif_pkg.vhd" \
    "$ref_dir/../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/pselect_f.vhd" \
    "$ref_dir/../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/address_decoder.vhd" \
    "$ref_dir/../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd" \
    "$ref_dir/../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/axi_lite_ipif.vhd" \

  ncvhdl -work v_tc_v6_1_6 $opts_vhd \
    "$ref_dir/../../../ipstatic/v_tc_v6_1/hdl/v_tc_v6_1_vh_rfs.vhd" \

  ncvhdl -work v_cfa_v7_0_7 $opts_vhd \
    "$ref_dir/../../../ipstatic/v_cfa_v7_0/hdl/v_cfa_v7_0_vh_rfs.vhd" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_0/sim/fmc_imageon_gs_v_cfa_0_0.vhd" \

  ncvhdl -work v_cresample_v4_0_7 $opts_vhd \
    "$ref_dir/../../../ipstatic/v_cresample_v4_0/hdl/v_cresample_v4_0_vh_rfs.vhd" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_0/sim/fmc_imageon_gs_v_cresample_0_0.vhd" \

  ncvhdl -work v_rgb2ycrcb_v7_1_6 $opts_vhd \
    "$ref_dir/../../../ipstatic/v_rgb2ycrcb_v7_1/hdl/v_rgb2ycrcb_v7_1_vh_rfs.vhd" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_0/sim/fmc_imageon_gs_v_rgb2ycrcb_0_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_tc_0_0/sim/fmc_imageon_gs_v_tc_0_0.vhd" \

  ncvhdl -work lib_pkg_v1_0_2 $opts_vhd \
    "$ref_dir/../../../ipstatic/lib_pkg_v1_0/hdl/src/vhdl/lib_pkg.vhd" \

  ncvhdl -work lib_cdc_v1_0_2 $opts_vhd \
    "$ref_dir/../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \

  ncvhdl -work interrupt_control_v3_1_3 $opts_vhd \
    "$ref_dir/../../../ipstatic/interrupt_control_v3_1/hdl/src/vhdl/interrupt_control.vhd" \

  ncvhdl -work axi_iic_v2_0_10 $opts_vhd \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/soft_reset.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/srl_fifo.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/upcnt_n.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/shift8.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/iic_pkg.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/debounce.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/reg_interface.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/iic_control.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/filter.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/dynamic_master.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/axi_ipif_ssp1.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/iic.vhd" \
    "$ref_dir/../../../ipstatic/axi_iic_v2_0/hdl/src/vhdl/axi_iic.vhd" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_fmc_imageon_iic_0_0/sim/fmc_imageon_gs_fmc_imageon_iic_0_0.vhd" \

  ncvlog -work generic_baseblocks_v2_1_0 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \

  ncvlog -work axi_infrastructure_v1_1_0 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \

  ncvlog -work axi_register_slice_v2_1_7 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
    "$ref_dir/../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \

  ncvhdl -work fifo_generator_v13_0_1 $opts_vhd \
    "$ref_dir/../../../ipstatic/fifo_generator_v13_0/simulation/fifo_generator_vhdl_beh.vhd" \
    "$ref_dir/../../../ipstatic/fifo_generator_v13_0/hdl/fifo_generator_v13_0_rfs.vhd" \

  ncvlog -work axi_data_fifo_v2_1_6 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \

  ncvlog -work axi_crossbar_v2_1_8 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_si_transactor.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_splitter.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_router.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_xbar_1/sim/fmc_imageon_gs_xbar_1.v" \

  ncvhdl -work proc_sys_reset_v5_0_8 $opts_vhd \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_0/sim/fmc_imageon_gs_rst_processing_system7_0_76M_0.vhd" \

  ncvlog -work v_vid_in_axi4s_v4_0_1 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/v_vid_in_axi4s_v4_0/hdl/verilog/v_vid_in_axi4s_v4_0_coupler.v" \
    "$ref_dir/../../../ipstatic/v_vid_in_axi4s_v4_0/hdl/verilog/v_vid_in_axi4s_v4_0_formatter.v" \
    "$ref_dir/../../../ipstatic/v_vid_in_axi4s_v4_0/hdl/verilog/v_vid_in_axi4s_v4_0.v" \

  ncvlog -work v_axi4s_vid_out_v4_0_1 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0.v" \
    "$ref_dir/../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0_coupler.v" \
    "$ref_dir/../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0_sync.v" \
    "$ref_dir/../../../ipstatic/v_axi4s_vid_out_v4_0/hdl/verilog/v_axi4s_vid_out_v4_0_formatter.v" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_axi4s_vid_out_0_0/sim/fmc_imageon_gs_v_axi4s_vid_out_0_0.v" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_0/sim/fmc_imageon_gs_v_vid_in_axi4s_0_0.v" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/xilinx.com/xlconstant_v1_1/xlconstant.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_xlconstant_0_0/sim/fmc_imageon_gs_xlconstant_0_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_xlconstant_1_0/sim/fmc_imageon_gs_xlconstant_1_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_1/sim/fmc_imageon_gs_v_cfa_0_1.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_1/sim/fmc_imageon_gs_v_cresample_0_1.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_1/sim/fmc_imageon_gs_v_rgb2ycrcb_0_1.vhd" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_1/sim/fmc_imageon_gs_v_vid_in_axi4s_0_1.v" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/hdl/fmc_imageon_gs.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_fmc_imageon_iic_0_1/sim/fmc_imageon_gs_fmc_imageon_iic_0_1.vhd" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_axi4s_vid_out_0_1/sim/fmc_imageon_gs_v_axi4s_vid_out_0_1.v" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_tc_0_1/sim/fmc_imageon_gs_v_tc_0_1.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_2/sim/fmc_imageon_gs_rst_processing_system7_0_76M_2.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M1_0/sim/fmc_imageon_gs_rst_processing_system7_0_76M1_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/onsemi_vita_cam_v3_1_S00_AXI.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/onsemi_vita_cam_v3_1.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/pck_crc10_d10.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/pulse_regen.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_core.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/correct_column_fpn_prnu_dsp48e.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/syncchanneldecoder.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/triggergenerator.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_mux.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/videosyncgen.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/afifo_64i_16o.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/crc_calc.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/onsemi_vita_cam_core.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_idelayctrl.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/pck_crc8_d8.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_datadeser.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_interface_s6.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_control.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_datadeser_s6.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_sync.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_interface.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/crc_check.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_compare.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/iserdes_clocks.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/remapper.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_cam_v3_2/hdl/crc_comp.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_cam_0_0/sim/fmc_imageon_gs_onsemi_vita_cam_0_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_cam_L_0_0/sim/fmc_imageon_gs_onsemi_vita_cam_L_0_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/avnet_hdmi_out_v3_1/hdl/vhdl/adv7511_embed_syncs.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/avnet_hdmi_out_v3_1/hdl/vhdl/avnet_hdmi_out.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_avnet_hdmi_out_0_0/sim/fmc_imageon_gs_avnet_hdmi_out_0_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_avnet_hdmi_out_0_1/sim/fmc_imageon_gs_avnet_hdmi_out_0_1.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/onsemi_vita_spi_v3_1_S00_AXI.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/onsemi_vita_spi_v3_1.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/afifo_32.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/spi_top.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/spi_seq.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/onsemi_vita_spi_core.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ipshared/avnet/onsemi_vita_spi_v3_2/hdl/spi_lowlevel.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_spi_0_0/sim/fmc_imageon_gs_onsemi_vita_spi_0_0.vhd" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_onsemi_vita_spi_0_1/sim/fmc_imageon_gs_onsemi_vita_spi_0_1.vhd" \

  ncvlog -work axi_protocol_converter_v2_1_7 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" \
    "$ref_dir/../../../bd/fmc_imageon_gs/ip/fmc_imageon_gs_auto_pc_0/sim/fmc_imageon_gs_auto_pc_0.v" \


  ncvlog $opts_ver -work xil_defaultlib \
    "glbl.v"

}

# RUN_STEP: <elaborate>
elaborate()
{
  opts="-loadvpi "E:/Xilinx/Vivado/2015.4/lib/win64.o/libxil_ncsim.dll:xilinx_register_systf" -64bit -relax -access +rwc -messages -logfile elaborate.log -timescale 1ps/1ps"
  libs="-libname unisims_ver -libname unimacro_ver -libname secureip -libname xil_defaultlib -libname axi_lite_ipif_v3_0_3 -libname v_tc_v6_1_6 -libname v_cfa_v7_0_7 -libname v_cresample_v4_0_7 -libname v_rgb2ycrcb_v7_1_6 -libname lib_pkg_v1_0_2 -libname lib_cdc_v1_0_2 -libname interrupt_control_v3_1_3 -libname axi_iic_v2_0_10 -libname generic_baseblocks_v2_1_0 -libname axi_infrastructure_v1_1_0 -libname axi_register_slice_v2_1_7 -libname fifo_generator_v13_0_1 -libname axi_data_fifo_v2_1_6 -libname axi_crossbar_v2_1_8 -libname proc_sys_reset_v5_0_8 -libname v_vid_in_axi4s_v4_0_1 -libname v_axi4s_vid_out_v4_0_1 -libname axi_protocol_converter_v2_1_7"
  ncelab $opts xil_defaultlib.fmc_imageon_gs xil_defaultlib.glbl $libs
}

# RUN_STEP: <simulate>
simulate()
{
  opts="-64bit -logfile simulate.log"
  ncsim $opts xil_defaultlib.fmc_imageon_gs -input simulate.do
}
# Script usage
usage()
{
  msg="Usage: fmc_imageon_gs.sh [-help]\n\
Usage: fmc_imageon_gs.sh [-lib_map_path]\n\
Usage: fmc_imageon_gs.sh [-reset_run]\n\
Usage: fmc_imageon_gs.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}


# Launch script
run $1 $2
