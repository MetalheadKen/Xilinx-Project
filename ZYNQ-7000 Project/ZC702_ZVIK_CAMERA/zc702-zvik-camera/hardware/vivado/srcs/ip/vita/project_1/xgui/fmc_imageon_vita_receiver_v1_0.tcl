#Definitional proc to organize widgets for parameters.
proc create_gui { ipview } {
	set Page0 [ ipgui::add_page $ipview  -name "Page 0" -layout vertical]
	set Component_Name [ ipgui::add_param  $ipview  -parent  $Page0  -name Component_Name ]
	set C_SLV_DWIDTH [ipgui::add_param $ipview -parent $Page0 -name C_SLV_DWIDTH]
	set C_SLV_AWIDTH [ipgui::add_param $ipview -parent $Page0 -name C_SLV_AWIDTH]
	set C_NUM_MEM [ipgui::add_param $ipview -parent $Page0 -name C_NUM_MEM]
	set C_NUM_REG [ipgui::add_param $ipview -parent $Page0 -name C_NUM_REG]
	set C_HIGHADDR [ipgui::add_param $ipview -parent $Page0 -name C_HIGHADDR]
	set C_BASEADDR [ipgui::add_param $ipview -parent $Page0 -name C_BASEADDR]
	set C_DPHASE_TIMEOUT [ipgui::add_param $ipview -parent $Page0 -name C_DPHASE_TIMEOUT]
	set C_USE_WSTRB [ipgui::add_param $ipview -parent $Page0 -name C_USE_WSTRB]
	set C_S_AXI_MIN_SIZE [ipgui::add_param $ipview -parent $Page0 -name C_S_AXI_MIN_SIZE]
	set C_S_AXI_ADDR_WIDTH [ipgui::add_param $ipview -parent $Page0 -name C_S_AXI_ADDR_WIDTH]
	set C_S_AXI_DATA_WIDTH [ipgui::add_param $ipview -parent $Page0 -name C_S_AXI_DATA_WIDTH]
	set C_XSVI_USE_SYNCGEN [ipgui::add_param $ipview -parent $Page0 -name C_XSVI_USE_SYNCGEN]
	set C_XSVI_DIRECT_OUTPUT [ipgui::add_param $ipview -parent $Page0 -name C_XSVI_DIRECT_OUTPUT]
	set C_XSVI_DATA_WIDTH [ipgui::add_param $ipview -parent $Page0 -name C_XSVI_DATA_WIDTH]
}

proc C_SLV_DWIDTH_updated {ipview} {
	# Procedure called when C_SLV_DWIDTH is updated
	return true
}

proc validate_C_SLV_DWIDTH {ipview} {
	# Procedure called to validate C_SLV_DWIDTH
	return true
}

proc C_SLV_AWIDTH_updated {ipview} {
	# Procedure called when C_SLV_AWIDTH is updated
	return true
}

proc validate_C_SLV_AWIDTH {ipview} {
	# Procedure called to validate C_SLV_AWIDTH
	return true
}

proc C_NUM_MEM_updated {ipview} {
	# Procedure called when C_NUM_MEM is updated
	return true
}

proc validate_C_NUM_MEM {ipview} {
	# Procedure called to validate C_NUM_MEM
	return true
}

proc C_NUM_REG_updated {ipview} {
	# Procedure called when C_NUM_REG is updated
	return true
}

proc validate_C_NUM_REG {ipview} {
	# Procedure called to validate C_NUM_REG
	return true
}

proc C_HIGHADDR_updated {ipview} {
	# Procedure called when C_HIGHADDR is updated
	return true
}

proc validate_C_HIGHADDR {ipview} {
	# Procedure called to validate C_HIGHADDR
	return true
}

proc C_BASEADDR_updated {ipview} {
	# Procedure called when C_BASEADDR is updated
	return true
}

proc validate_C_BASEADDR {ipview} {
	# Procedure called to validate C_BASEADDR
	return true
}

proc C_DPHASE_TIMEOUT_updated {ipview} {
	# Procedure called when C_DPHASE_TIMEOUT is updated
	return true
}

proc validate_C_DPHASE_TIMEOUT {ipview} {
	# Procedure called to validate C_DPHASE_TIMEOUT
	return true
}

proc C_USE_WSTRB_updated {ipview} {
	# Procedure called when C_USE_WSTRB is updated
	return true
}

proc validate_C_USE_WSTRB {ipview} {
	# Procedure called to validate C_USE_WSTRB
	return true
}

proc C_S_AXI_MIN_SIZE_updated {ipview} {
	# Procedure called when C_S_AXI_MIN_SIZE is updated
	return true
}

proc validate_C_S_AXI_MIN_SIZE {ipview} {
	# Procedure called to validate C_S_AXI_MIN_SIZE
	return true
}

proc C_S_AXI_ADDR_WIDTH_updated {ipview} {
	# Procedure called when C_S_AXI_ADDR_WIDTH is updated
	return true
}

proc validate_C_S_AXI_ADDR_WIDTH {ipview} {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc C_S_AXI_DATA_WIDTH_updated {ipview} {
	# Procedure called when C_S_AXI_DATA_WIDTH is updated
	return true
}

proc validate_C_S_AXI_DATA_WIDTH {ipview} {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc C_XSVI_USE_SYNCGEN_updated {ipview} {
	# Procedure called when C_XSVI_USE_SYNCGEN is updated
	return true
}

proc validate_C_XSVI_USE_SYNCGEN {ipview} {
	# Procedure called to validate C_XSVI_USE_SYNCGEN
	return true
}

proc C_XSVI_DIRECT_OUTPUT_updated {ipview} {
	# Procedure called when C_XSVI_DIRECT_OUTPUT is updated
	return true
}

proc validate_C_XSVI_DIRECT_OUTPUT {ipview} {
	# Procedure called to validate C_XSVI_DIRECT_OUTPUT
	return true
}

proc C_XSVI_DATA_WIDTH_updated {ipview} {
	# Procedure called when C_XSVI_DATA_WIDTH is updated
	return true
}

proc validate_C_XSVI_DATA_WIDTH {ipview} {
	# Procedure called to validate C_XSVI_DATA_WIDTH
	return true
}


proc updateModel_C_XSVI_DATA_WIDTH {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_XSVI_DATA_WIDTH -of $ipview ]] [ipgui::get_modelparamspec C_XSVI_DATA_WIDTH -of $ipview ]

	return true
}

proc updateModel_C_XSVI_DIRECT_OUTPUT {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_XSVI_DIRECT_OUTPUT -of $ipview ]] [ipgui::get_modelparamspec C_XSVI_DIRECT_OUTPUT -of $ipview ]

	return true
}

proc updateModel_C_XSVI_USE_SYNCGEN {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_XSVI_USE_SYNCGEN -of $ipview ]] [ipgui::get_modelparamspec C_XSVI_USE_SYNCGEN -of $ipview ]

	return true
}

proc updateModel_C_S_AXI_DATA_WIDTH {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_S_AXI_DATA_WIDTH -of $ipview ]] [ipgui::get_modelparamspec C_S_AXI_DATA_WIDTH -of $ipview ]

	return true
}

proc updateModel_C_S_AXI_ADDR_WIDTH {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_S_AXI_ADDR_WIDTH -of $ipview ]] [ipgui::get_modelparamspec C_S_AXI_ADDR_WIDTH -of $ipview ]

	return true
}

proc updateModel_C_S_AXI_MIN_SIZE {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_S_AXI_MIN_SIZE -of $ipview ]] [ipgui::get_modelparamspec C_S_AXI_MIN_SIZE -of $ipview ]

	return true
}

proc updateModel_C_USE_WSTRB {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_USE_WSTRB -of $ipview ]] [ipgui::get_modelparamspec C_USE_WSTRB -of $ipview ]

	return true
}

proc updateModel_C_DPHASE_TIMEOUT {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_DPHASE_TIMEOUT -of $ipview ]] [ipgui::get_modelparamspec C_DPHASE_TIMEOUT -of $ipview ]

	return true
}

proc updateModel_C_BASEADDR {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_BASEADDR -of $ipview ]] [ipgui::get_modelparamspec C_BASEADDR -of $ipview ]

	return true
}

proc updateModel_C_HIGHADDR {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_HIGHADDR -of $ipview ]] [ipgui::get_modelparamspec C_HIGHADDR -of $ipview ]

	return true
}

proc updateModel_C_NUM_REG {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_NUM_REG -of $ipview ]] [ipgui::get_modelparamspec C_NUM_REG -of $ipview ]

	return true
}

proc updateModel_C_NUM_MEM {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_NUM_MEM -of $ipview ]] [ipgui::get_modelparamspec C_NUM_MEM -of $ipview ]

	return true
}

proc updateModel_C_SLV_AWIDTH {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_SLV_AWIDTH -of $ipview ]] [ipgui::get_modelparamspec C_SLV_AWIDTH -of $ipview ]

	return true
}

proc updateModel_C_SLV_DWIDTH {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_SLV_DWIDTH -of $ipview ]] [ipgui::get_modelparamspec C_SLV_DWIDTH -of $ipview ]

	return true
}

