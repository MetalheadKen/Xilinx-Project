webtalk_init -webtalk_dir D:\\Xilinx_Project\\FMC_DUAL_CAMERA\\project_1\\project_1.sdk\\webtalk
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "星期五 二月 17 15:26:46 2017" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "SDK v2015.4" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2015.4" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "amd64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "SDK" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "false" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "n4u843vf1j3piavl5thqdn5gh" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "2015.4_7" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "7" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "" -context "user_environment"
webtalk_add_data -client project -key os_release -value "" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "" -context "user_environment"
webtalk_register_client -client sdk
webtalk_add_data -client sdk -key uid -value "1487234707607" -context "sdk\\\\hardware/1487234707607"
webtalk_add_data -client sdk -key isZynq -value "true" -context "sdk\\\\hardware/1487234707607"
webtalk_add_data -client sdk -key Processors -value "2" -context "sdk\\\\hardware/1487234707607"
webtalk_add_data -client sdk -key VivadoVersion -value "2015.4" -context "sdk\\\\hardware/1487234707607"
webtalk_add_data -client sdk -key Arch -value "zynq" -context "sdk\\\\hardware/1487234707607"
webtalk_add_data -client sdk -key Device -value "7z020" -context "sdk\\\\hardware/1487234707607"
webtalk_add_data -client sdk -key IsHandoff -value "true" -context "sdk\\\\hardware/1487234707607"
webtalk_transmit -clientid 457266256 -regid "" -xml D:\\Xilinx_Project\\FMC_DUAL_CAMERA\\project_1\\project_1.sdk\\webtalk\\usage_statistics_ext_sdk.xml -html D:\\Xilinx_Project\\FMC_DUAL_CAMERA\\project_1\\project_1.sdk\\webtalk\\usage_statistics_ext_sdk.html -wdm D:\\Xilinx_Project\\FMC_DUAL_CAMERA\\project_1\\project_1.sdk\\webtalk\\sdk_webtalk.wdm -intro "<H3>SDK Usage Report</H3><BR>"
webtalk_terminate
