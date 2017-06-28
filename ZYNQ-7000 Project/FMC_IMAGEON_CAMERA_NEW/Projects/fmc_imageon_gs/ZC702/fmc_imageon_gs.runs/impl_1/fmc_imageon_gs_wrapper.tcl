proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part xilinx.com:zc702:part0:1.2 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir D:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.cache/wt [current_project]
  set_property parent.project_path D:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.xpr [current_project]
  set_property ip_repo_paths {
  d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.cache/ip
  D:/fmc_imageon_camera/ip/onsemi_vita_cam_l
  D:/FMC_IMAGEON_CAMERA/IP
} [current_project]
  set_property ip_output_repo d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.cache/ip [current_project]
  add_files -quiet D:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.runs/synth_1/fmc_imageon_gs_wrapper.dcp
  read_xdc -ref fmc_imageon_gs_processing_system7_0_0 -cells inst d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_processing_system7_0_0/fmc_imageon_gs_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_processing_system7_0_0/fmc_imageon_gs_processing_system7_0_0.xdc]
  read_xdc -ref fmc_imageon_gs_axi_vdma_0_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_0_0/fmc_imageon_gs_axi_vdma_0_0.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_0_0/fmc_imageon_gs_axi_vdma_0_0.xdc]
  read_xdc -ref fmc_imageon_gs_axi_vdma_1_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_1_0/fmc_imageon_gs_axi_vdma_1_0.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_1_0/fmc_imageon_gs_axi_vdma_1_0.xdc]
  read_xdc -prop_thru_buffers -ref fmc_imageon_gs_fmc_imageon_iic_0_0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_fmc_imageon_iic_0_0/fmc_imageon_gs_fmc_imageon_iic_0_0_board.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_fmc_imageon_iic_0_0/fmc_imageon_gs_fmc_imageon_iic_0_0_board.xdc]
  read_xdc -prop_thru_buffers -ref fmc_imageon_gs_rst_processing_system7_0_148_5M_0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_0/fmc_imageon_gs_rst_processing_system7_0_148_5M_0_board.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_0/fmc_imageon_gs_rst_processing_system7_0_148_5M_0_board.xdc]
  read_xdc -ref fmc_imageon_gs_rst_processing_system7_0_148_5M_0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_0/fmc_imageon_gs_rst_processing_system7_0_148_5M_0.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_0/fmc_imageon_gs_rst_processing_system7_0_148_5M_0.xdc]
  read_xdc -prop_thru_buffers -ref fmc_imageon_gs_rst_processing_system7_0_149M_0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_149M_0/fmc_imageon_gs_rst_processing_system7_0_149M_0_board.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_149M_0/fmc_imageon_gs_rst_processing_system7_0_149M_0_board.xdc]
  read_xdc -ref fmc_imageon_gs_rst_processing_system7_0_149M_0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_149M_0/fmc_imageon_gs_rst_processing_system7_0_149M_0.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_149M_0/fmc_imageon_gs_rst_processing_system7_0_149M_0.xdc]
  read_xdc -prop_thru_buffers -ref fmc_imageon_gs_rst_processing_system7_0_76M_0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_0/fmc_imageon_gs_rst_processing_system7_0_76M_0_board.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_0/fmc_imageon_gs_rst_processing_system7_0_76M_0_board.xdc]
  read_xdc -ref fmc_imageon_gs_rst_processing_system7_0_76M_0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_0/fmc_imageon_gs_rst_processing_system7_0_76M_0.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_76M_0/fmc_imageon_gs_rst_processing_system7_0_76M_0.xdc]
  read_xdc -prop_thru_buffers -ref fmc_imageon_gs_rst_processing_system7_0_148_5M_1 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_1/fmc_imageon_gs_rst_processing_system7_0_148_5M_1_board.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_1/fmc_imageon_gs_rst_processing_system7_0_148_5M_1_board.xdc]
  read_xdc -ref fmc_imageon_gs_rst_processing_system7_0_148_5M_1 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_1/fmc_imageon_gs_rst_processing_system7_0_148_5M_1.xdc
  set_property processing_order EARLY [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_rst_processing_system7_0_148_5M_1/fmc_imageon_gs_rst_processing_system7_0_148_5M_1.xdc]
  read_xdc D:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/constrs_1/imports/fmc_imageon_gs/zc702_fmc_imageon_gs.xdc
  read_xdc -ref fmc_imageon_gs_v_cfa_0_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_0/fmc_imageon_gs_v_cfa_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_0/fmc_imageon_gs_v_cfa_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_cresample_0_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_0/fmc_imageon_gs_v_cresample_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_0/fmc_imageon_gs_v_cresample_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_osd_0_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_osd_0_0/fmc_imageon_gs_v_osd_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_osd_0_0/fmc_imageon_gs_v_osd_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_rgb2ycrcb_0_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_0/fmc_imageon_gs_v_rgb2ycrcb_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_0/fmc_imageon_gs_v_rgb2ycrcb_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_tc_0_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_tc_0_0/fmc_imageon_gs_v_tc_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_tc_0_0/fmc_imageon_gs_v_tc_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_axi_vdma_0_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_0_0/fmc_imageon_gs_axi_vdma_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_0_0/fmc_imageon_gs_axi_vdma_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_axi_vdma_1_0 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_1_0/fmc_imageon_gs_axi_vdma_1_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_axi_vdma_1_0/fmc_imageon_gs_axi_vdma_1_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_axi4s_vid_out_0_0 -cells inst d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_axi4s_vid_out_0_0/fmc_imageon_gs_v_axi4s_vid_out_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_axi4s_vid_out_0_0/fmc_imageon_gs_v_axi4s_vid_out_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_vid_in_axi4s_0_0 -cells inst d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_0/fmc_imageon_gs_v_vid_in_axi4s_0_0_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_0/fmc_imageon_gs_v_vid_in_axi4s_0_0_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_cfa_0_1 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_1/fmc_imageon_gs_v_cfa_0_1_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cfa_0_1/fmc_imageon_gs_v_cfa_0_1_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_cresample_0_1 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_1/fmc_imageon_gs_v_cresample_0_1_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_cresample_0_1/fmc_imageon_gs_v_cresample_0_1_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_rgb2ycrcb_0_1 -cells U0 d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_1/fmc_imageon_gs_v_rgb2ycrcb_0_1_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_rgb2ycrcb_0_1/fmc_imageon_gs_v_rgb2ycrcb_0_1_clocks.xdc]
  read_xdc -ref fmc_imageon_gs_v_vid_in_axi4s_0_1 -cells inst d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_1/fmc_imageon_gs_v_vid_in_axi4s_0_1_clocks.xdc
  set_property processing_order LATE [get_files d:/FMC_IMAGEON_CAMERA/Projects/fmc_imageon_gs/ZC702/fmc_imageon_gs.srcs/sources_1/bd/fmc_imageon_gs/ip/fmc_imageon_gs_v_vid_in_axi4s_0_1/fmc_imageon_gs_v_vid_in_axi4s_0_1_clocks.xdc]
  link_design -top fmc_imageon_gs_wrapper -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force fmc_imageon_gs_wrapper_opt.dcp
  report_drc -file fmc_imageon_gs_wrapper_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file fmc_imageon_gs_wrapper.hwdef}
  place_design 
  write_checkpoint -force fmc_imageon_gs_wrapper_placed.dcp
  report_io -file fmc_imageon_gs_wrapper_io_placed.rpt
  report_utilization -file fmc_imageon_gs_wrapper_utilization_placed.rpt -pb fmc_imageon_gs_wrapper_utilization_placed.pb
  report_control_sets -verbose -file fmc_imageon_gs_wrapper_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force fmc_imageon_gs_wrapper_routed.dcp
  report_drc -file fmc_imageon_gs_wrapper_drc_routed.rpt -pb fmc_imageon_gs_wrapper_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file fmc_imageon_gs_wrapper_timing_summary_routed.rpt -rpx fmc_imageon_gs_wrapper_timing_summary_routed.rpx
  report_power -file fmc_imageon_gs_wrapper_power_routed.rpt -pb fmc_imageon_gs_wrapper_power_summary_routed.pb
  report_route_status -file fmc_imageon_gs_wrapper_route_status.rpt -pb fmc_imageon_gs_wrapper_route_status.pb
  report_clock_utilization -file fmc_imageon_gs_wrapper_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force fmc_imageon_gs_wrapper.mmi }
  write_bitstream -force fmc_imageon_gs_wrapper.bit 
  catch { write_sysdef -hwdef fmc_imageon_gs_wrapper.hwdef -bitfile fmc_imageon_gs_wrapper.bit -meminfo fmc_imageon_gs_wrapper.mmi -file fmc_imageon_gs_wrapper.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

