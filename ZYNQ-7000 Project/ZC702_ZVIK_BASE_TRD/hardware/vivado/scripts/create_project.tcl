# set directory names
set project_dir "project"
set ip_dir "srcs/ip"
set hdl_dir "srcs/hdl"
set ui_dir "srcs/ui"
set constrs_dir "constrs"
set scripts_dir "scripts"

# select target platform and set board/part - use zc702 as default
if { $argc > 1 } {
   puts "ERROR: Specify target platform: '-tclargs zc702' or '-tclargs zc706'"
   exit
}
if { $argc == 0 || $argv eq "zc702" } {
   set platform "zc702"
   set part "xc7z020clg484-1"
   set board_part "xilinx.com:zc702:part0:1.2"
} elseif { $argv eq "zc706" } {
   set platform "zc706"
   set part "xc7z045ffg900-2"
   set board_part "xilinx.com:zc706:part0:1.2"
} else {
   puts "ERROR: Incorrect or unknown target platform selected: '$argv'"
   exit
}
puts "INFO: Target platform selected: '$platform'"

# set variable names
set design_name "${platform}_base_trd"
set pin_xdc_file "pin_${platform}.xdc"
set ps7_config_file "ps7_config_${platform}.tcl"

# set up project
create_project $design_name $project_dir -part $part -force
set_property board_part $board_part [current_project]

# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild
update_ip_catalog -add_ip $ip_dir/xilinx_com_hls_image_filter_1_0.zip -repo_path $ip_dir

# set up bd design
create_bd_design $design_name
source $scripts_dir/$ps7_config_file
source $scripts_dir/build_bd_design.tcl
regenerate_bd_layout -layout_file $scripts_dir/bd_layout.tcl
validate_bd_design
save_bd_design

# add hdl sources and xdc constraints to project
make_wrapper -files [get_files $project_dir/$design_name.srcs/sources_1/bd/$design_name/$design_name.bd] -top
add_files -fileset sources_1 -norecurse $project_dir/$design_name.srcs/sources_1/bd/$design_name/hdl/${design_name}_wrapper.v
add_files -fileset constrs_1 -norecurse [list $constrs_dir/timing.xdc $constrs_dir/$pin_xdc_file]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# Implementation Strategy config
set_property strategy Performance_Explore [get_runs impl_1]
