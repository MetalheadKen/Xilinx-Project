#Definitional proc to organize widgets for parameters.
proc create_gui { ipview } {
	set Page0 [ ipgui::add_page $ipview  -name "Page 0" -layout vertical]
	set Component_Name [ ipgui::add_param  $ipview  -parent  $Page0  -name Component_Name ]
	set C_DATA_WIDTH [ipgui::add_param $ipview -parent $Page0 -name C_DATA_WIDTH]
}

proc C_DATA_WIDTH_updated {ipview} {
	# Procedure called when C_DATA_WIDTH is updated
	return true
}

proc validate_C_DATA_WIDTH {ipview} {
	# Procedure called to validate C_DATA_WIDTH
	return true
}


proc updateModel_C_DATA_WIDTH {ipview} {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property modelparam_value [get_property value [ipgui::get_paramspec C_DATA_WIDTH -of $ipview ]] [ipgui::get_modelparamspec C_DATA_WIDTH -of $ipview ]

	return true
}

