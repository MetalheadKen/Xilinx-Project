/*
//----------------------------------------------------------------
//      _____
//     /     \
//    /____   \____
//   / \===\   \==/
//  /___\===\___\/  AVNET
//       \======/
//        \====/
//---------------------------------------------------------------
//
// This design is the property of Avnet.  Publication of this
// design is not authorized without written consent from Avnet.
//
// Please direct any questions to:  technical.support@avnet.com
//
// Disclaimer:
//    Avnet, Inc. makes no warranty for the use of this code or design.
//    This code is provided  "As Is". Avnet, Inc assumes no responsibility for
//    any errors, which may appear in this code, nor does it make a commitment
//    to update the information contained herein. Avnet, Inc specifically
//    disclaims any implied warranties of fitness for a particular purpose.
//                     Copyright(c) 2012 Avnet, Inc.
//                             All rights reserved.
//
//----------------------------------------------------------------
//
// Create Date:         Apr 09, 2012
// Design Name:         ZVIK Camera
// Module Name:         zvik_camera_linux_webserver.js
// Project Name:        ZVIK Camera
//
// Tool versions:       Vivado 2013.2
//
// Description:         Java script for 
//                      Web Page for ZVIK Camera control
//
// Dependencies:
//
// Revision:            Apr 09, 2012: 1.01 Initial version
//                      Jul 06, 2012: 1.02 Candidate for release
//                      Aug 14, 2012: 1.03 Nomenclature change from "EPP" to "AP SoC"
//                      Aug 15, 2012: 1.04 Add sliders target illumination
//                      Sep 17, 2012: 1.05 Nomenclature change from "cold" to "cool"
//                                         Remove sliders for multiplexers
//                                         Add slider for gamma equalization strength
//                      Aug 16, 2013: 1.04 Updated for new Image Enhancement core
//
//----------------------------------------------------------------
*/

    var SLIDER_TPL = {
        'b_vertical' : false,
        'b_watch': true,
        'n_controlWidth': 100,
        'n_controlHeight': 16,
        'n_sliderWidth': 17,
        'n_sliderHeight': 16,
        'n_pathLeft' : 0,
        'n_pathTop' : 0,
        'n_pathLength' : 83,
        's_imgControl': 'images/slider/background.gif',
        's_imgSlider': 'images/slider/handle.gif',
        'n_zIndex': 1
    }

    /*
     * VITA Controls
     */
    function target_level_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_target_level();
        }
    }
    var TARGET_LEVEL_INIT = {
        's_name': 'target_level_id',
        'n_minValue' : 1.0,
        'n_maxValue' : 1000.0,
        'n_value' : 200.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : target_level_slider_notify_cb
    }
    function vaec_level_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_vaec();
        }
    }
    var VAEC_LEVEL_INIT = {
        's_name': 'vaec_level_id',
        'n_minValue' : 1.0,
        'n_maxValue' : 1000.0,
        'n_value' : 184.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : vaec_level_slider_notify_cb
    }
    function vita_exposure_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_vita_exposure();
        }
    }
    var VITA_EXPOSURE_INIT = {
        's_name': 'vita_exposure_id',
        'n_minValue' : 1.0,
        'n_maxValue' : 99.0,
        'n_value' : 90.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : vita_exposure_slider_notify_cb
    }
    function vita_again_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_vita_again();
        }
    }
    var VITA_AGAIN_INIT = {
        's_name': 'vita_again_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 10.0,
        'n_value' : 0.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : vita_again_slider_notify_cb
    }
    function vita_dgain_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_vita_dgain();
        }
    }
    var VITA_DGAIN_INIT = {
        's_name': 'vita_dgain_id',
        'n_minValue' : 0.0078125,
        'n_maxValue' : 31.9921875,
        'n_value' : 1.0,
        'n_step' : 0.0078125,
        'f_update_notify_cb' : vita_dgain_slider_notify_cb
    }

    /*
     * DEMO Controls
     */
    function demo_interval_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_demo_interval();
        }
    }
    var DEMO_INTERVAL_INIT = {
        's_name': 'demo_interval_id',
        'n_minValue' : 1000,
        'n_maxValue' : 5000,
        'n_value' : 5000,
        'n_step' : 1.0,
        'f_update_notify_cb' : demo_interval_slider_notify_cb
    }

    /*
     * DPC Controls
     */
    function dpc_age_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_dpc_age();
        }
    }
    var DPC_AGE_INIT = {
        's_name': 'dpc_age_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 127.0,
        'n_value' : 0.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : dpc_age_slider_notify_cb
    }
    function dpc_spatial_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_dpc_spatial();
        }
    }
    var DPC_SPATIAL_INIT = {
        's_name': 'dpc_spatial_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 16384.0,
        'n_value' : 6000.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : dpc_spatial_slider_notify_cb
    }
    function dpc_temporal_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_dpc_temporal();
        }
    }
    var DPC_TEMPORAL_INIT = {
        's_name': 'dpc_temporal_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 15.0,
        'n_value' : 2.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : dpc_temporal_slider_notify_cb
    }

    /*
     * CCM Controls
     */
    function ccm_contrast_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_ccm_contrast();
        }
    }
    var CCM_CONTRAST_INIT = {
        's_name': 'ccm_contrast_id',
        'n_minValue' : -100.0,
        'n_maxValue' : +100.0,
        'n_value' : 0.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : ccm_contrast_slider_notify_cb
    }
    function ccm_brightness_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_ccm_brightness();
        }
    }
    var CCM_BRIGHTNESS_INIT = {
        's_name': 'ccm_brightness_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 100.0,
        'n_value' : 100.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : ccm_brightness_slider_notify_cb
    }
    function ccm_saturation_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_ccm_saturation();
        }
    }
    var CCM_SATURATION_INIT = {
        's_name': 'ccm_saturation_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 100.0,
        'n_value' : 100.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : ccm_saturation_slider_notify_cb
    }

    /*
     * ENHANCE Controls
     */
    function noise_strength_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_noise_strength();
        }
    }
    var NOISE_STRENGTH_INIT = {
        's_name': 'noise_strength_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 255.0,
        'n_value' : 0.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : noise_strength_slider_notify_cb
    }
    function enhance_strength_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_enhance_strength();
        }
    }
    var ENHANCE_STRENGTH_INIT = {
        's_name': 'enhance_strength_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 32768.0,
        'n_value' : 0.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : enhance_strength_slider_notify_cb
    }
    function halo_suppress_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_halo_suppress();
        }
    }
    var HALO_SUPPRESS_INIT = {
        's_name': 'halo_suppress_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 32768.0,
        'n_value' : 0.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : halo_suppress_slider_notify_cb
    }

    /*
     * GAMMA Controls
     */
    function geq_strength_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_geq_strength();
        }
    }
    var GEQ_STRENGTH_INIT = {
        's_name': 'geq_strength_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 100.0,
        'n_value' : 50.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : geq_strength_slider_notify_cb
    }
   

    /*
     * IMSTATS Controls
     */
    function imstats_interval_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_imstats_interval();
        }
    }
    var IMSTATS_INTERVAL_INIT = {
        's_name': 'imstats_interval_id',
        'n_minValue' : 500,
        'n_maxValue' : 5000,
        'n_value' : 2000,
        'n_step' : 1.0,
        'f_update_notify_cb' : imstats_interval_slider_notify_cb
    }
    function imstats_histscale_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_imstats_histscale();
        }
    }
    var IMSTATS_HISTSCALE_INIT = {
        's_name': 'imstats_histscale_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 20.0,
        'n_value' : 9.0,
        'n_step' : 1.0,
        'f_update_notify_cb' : imstats_histscale_slider_notify_cb
    }
    function imstats_underexp_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_imstats_underexp();
        }
    }
    var IMSTATS_UNDEREXP_INIT = {
        's_name': 'imstats_underexp_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 4.0,
        'n_value' : 0.5,
        'n_step' : 0.1,
        'f_update_notify_cb' : imstats_underexp_slider_notify_cb
    }
    function imstats_overexp_slider_notify_cb() {
        /* The slider has moved; send the values to our peer */
        if (outstanding_ajax_req < 20) {
            set_imstats_overexp();
        }
    }
    var IMSTATS_OVEREXP_INIT = {
        's_name': 'imstats_overexp_id',
        'n_minValue' : 0.0,
        'n_maxValue' : 8.0,
        'n_value' : 3.0,
        'n_step' : 0.1,
        'f_update_notify_cb' : imstats_overexp_slider_notify_cb
    }

function httpPost(strURL, postData, handlerFunction)
{
	var xmlHttpReq = false;

	// Mozilla/Safari
	if (window.XMLHttpRequest) 
	{
		xmlHttpReq = new XMLHttpRequest();
	}
	// IE
	else if (window.ActiveXObject) 
	{
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlHttpReq.open('POST', strURL, true);
	xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlHttpReq.onreadystatechange = function() 
	{
		if (xmlHttpReq.readyState == 4)
		{
			handlerFunction(xmlHttpReq.responseText);
		}
	}
	xmlHttpReq.send(postData);
}

// Replace the inner html of a dom element by id
function updatepage(resultAreaName, html)
{
	var element = document.getElementById(resultAreaName)
	element.innerHTML = html;	
}

function parseXML(xmlText)
{
	// The result of detectInput is an xml document.   Parse the document to determine
	// if input was detected and the values associated with the input...			
	var xmlDoc = false;
	if (window.DOMParser)
	{
		parser=new DOMParser();
		xmlDoc=parser.parseFromString(xmlText,"text/xml");
	}
	else // Internet Explorer
	{
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async=false;
		xmlDoc.loadXML(xmlText); 
	}
	return xmlDoc;
}

function loadVersionInfo()
{
	httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=version                ", function(postResponse)
		{
			updatepage("versionInfoResult", postResponse);
		});
}

function getXMLElementContentByName(parent, name)
{
	var elements = parent.getElementsByTagName(name);
	if (elements && elements.length >= 1)
	{
		var element = elements[0];
		if (element)
		{
			if (element.childNodes && element.childNodes.length > 0 && element.childNodes[0])
			{
				return element.childNodes[0].nodeValue;
			}
		}
	}
	return '';
}

function zvik_camera_init()
{
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=#zvik_camera_init                ", function(postResponse) {});

   //
   set_vaec();
   set_target_level();
   set_agc();
   set_aec();
   set_geq();
   //
   set_vita_exposure();
   set_vita_again();
   set_vita_dgain();
   //
   set_dpc_age();
   set_dpc_spatial();
   set_dpc_temporal();
   //
   set_cfa_bayer();
   //
   set_noise_strength();
   set_enhance_strength();
   set_halo_suppress();
   //
   set_ccm_select();
   set_ccm_contrast();
   set_ccm_brightness();
   set_ccm_saturation();
   //
   set_geq_strength();
   set_gamma_table();
   //
   set_imstats_histscale();
   set_imstats_underexp();
   set_imstats_overexp();
   //
   setTimeout(function () { set_imstats(); }, 250 );
   setTimeout(function () { set_webshot(); }, 500 );
}

function zvik_camera_general_reset()
{
   location.reload(true);
   //
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=#zvik_camera_reset                ", function(postResponse) {});
}

var zvik_camera_demo_timer;
var zvik_camera_demo_active = 0;
var zvik_camera_demo_id     = 0;

function zvik_camera_demo_start()
{
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=#zvik_camera_demo_start                ", function(postResponse) {});

   // Start Interval timer
   if ( !zvik_camera_demo_active )
   {
      zvik_camera_demo_active = 1;
      zvik_camera_demo_automation();
   }
}

function zvik_camera_demo_stop()
{
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=#zvik_camera_demo_stop                ", function(postResponse) {});

   // Stop Interval timer
   clearTimeout( zvik_camera_demo_timer );
   zvik_camera_demo_active = 0;
   zvik_camera_demo_id     = 0;
   document.getElementById("demo_status_id").value = "off";
}

function set_demo_interval()
{
   // nothing to do ...
}

function zvik_camera_demo_automation()
{
   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=#zvik_demo_automation_" + zvik_camera_demo_id + "                ";
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse) {});

   zvik_camera_demo_id = zvik_camera_demo_id + 1;
   if ( zvik_camera_demo_id > 15 )
   {
      zvik_camera_demo_id = 0;
   }

   var demo_status = "";
   if ( zvik_camera_demo_id == 0 )
   {
      demo_status = "Normal Image";
      document.getElementById("ccm_select_id").selectedIndex = 0;
      set_ccm_select();
      document.getElementById("awb_id").checked = false;
   }
   else if ( zvik_camera_demo_id == 1 )
   {
      demo_status = "White Balance = Daylight";
      document.getElementById("ccm_select_id").selectedIndex = 1;
      set_ccm_select();
      document.getElementById("awb_id").checked = false;
   }
   else if ( zvik_camera_demo_id == 2 )
   {
      demo_status = "White Balance = Automatic (preliminary)";
      document.getElementById("ccm_select_id").selectedIndex = 0;
      set_ccm_select();
      document.getElementById("awb_id").checked = true;
      set_awb();
   }
   else if ( zvik_camera_demo_id == 3 )
   {
      demo_status = "White Balance = OFF";
      document.getElementById("ccm_select_id").selectedIndex = 0;
      set_ccm_select();
      document.getElementById("awb_id").checked = false;
      set_awb();
   }
   else if ( zvik_camera_demo_id == 4 )
   {
      demo_status = "Gamma = Compression 1/1.6";
      document.getElementById("gamma_table_id").selectedIndex = 2;
      set_gamma_table();
   }
   else if ( zvik_camera_demo_id == 5 )
   {
      demo_status = "Gamma = Expansion 1.6";
      document.getElementById("gamma_table_id").selectedIndex = 3;
      set_gamma_table();
   }
   else if ( zvik_camera_demo_id == 6 )
   {
      demo_status = "Gamma = Linear";
      document.getElementById("gamma_table_id").selectedIndex = 0;
      set_gamma_table();
   }
   else if ( zvik_camera_demo_id == 7 )
   {
      demo_status = "Defect Pixel Correction = off";
      document.getElementById("dpc_age_id").value = 100;
      set_dpc_age();
   }
   else if ( zvik_camera_demo_id == 8 )
   {
      demo_status = "Defect Pixel Correction = on";
      document.getElementById("dpc_age_id").value = 0;
      set_dpc_age();
   }
   else if ( zvik_camera_demo_id == 9 )
   {
      demo_status = "Edge Enhance = ON(2)";
      document.getElementById("enhance_strength_id").value = 2;
      set_enhance_strength();
   }
   else if ( zvik_camera_demo_id == 10 )
   {
      demo_status = "Edge Enhance = ON(16384)";
      document.getElementById("enhance_strength_id").value = 16384;
      set_enhance_strength();
   }
   else if ( zvik_camera_demo_id == 11 )
   {
      demo_status = "Edge Enhance = ON(32768)";
      document.getElementById("enhance_strength_id").value = 32768;
      set_enhance_strength();
   }
   else if ( zvik_camera_demo_id == 12 )
   {
      demo_status = "Edge Enhance = OFF";
      document.getElementById("enhance_strength_id").value = 0;
      set_enhance_strength();
   }
   else if ( zvik_camera_demo_id == 13 )
   {
      demo_status = "Noise Reduction = ON(1)";
      document.getElementById("noise_strength_id").value = 1;
      set_noise_strength();
   }
   else if ( zvik_camera_demo_id == 14 )
   {
      demo_status = "Noise Reduction = ON(255)";
      document.getElementById("noise_strength_id").value = 255;
      set_noise_strength();
   }
   else if ( zvik_camera_demo_id == 15 )
   {
      demo_status = "Noise Reduction = OFF";
      document.getElementById("noise_strength_id").value = 0;
      set_noise_strength();
   }
   document.getElementById("demo_status_id").value = demo_status;

   // Set Interval Timer for user specified interval
   var demo_interval = document.getElementById("demo_interval_id").value;
   zvik_camera_demo_timer = setTimeout(function () { zvik_camera_demo_automation(); }, demo_interval );

   // Update webshot after 0.5sec delay 
   // NOTE: demo interval must be larger than 0.5sec
   setTimeout(function () { set_webshot(); }, 500 );
}

function set_webshot()
{
   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=rec_/mnt/www/webshot.bmp                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});

   // Invalidate the webshot image after 250msec delay 
   setTimeout(function () { update_webshot(); }, 250 );
}

function update_webshot()
{
   // Invalidate webshot image to force reload
   document.getElementById("webshot_id").src = "webshot.bmp?time=" + new Date();
}


var zvik_camera_imstats_timer;
var zvik_camera_imstats_active = 0;

function zvik_camera_imstats_start()
{
   // Start Interval timer
   if ( !zvik_camera_imstats_active )
   {
      zvik_camera_imstats_active = 1;
      zvik_camera_imstats_automation();
   }
}

function zvik_camera_imstats_stop()
{
   // Stop Interval timer
   clearTimeout( zvik_camera_imstats_timer );
   zvik_camera_imstats_active = 0;
}

function set_imstats_interval()
{
   // nothing to do ...
}

function zvik_camera_imstats_automation()
{
   // Set Interval Timer for user specified interval
   var imstats_interval = document.getElementById("imstats_interval_id").value;
   zvik_camera_imstats_timer = setTimeout(function () { zvik_camera_imstats_automation(); }, imstats_interval );

   // Update webshot after 0.5sec delay 
   // NOTE: demo interval must be larger than 0.5sec
   setTimeout(function () { set_imstats(); }, 500 );
}


function set_imstats()
{
   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=stats_log_/mnt/www/imstats.bmp                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});

   // Invalidate the webshot image after 250msec delay 
   setTimeout(function () { update_imstats(); }, 250 );
}

function update_imstats()
{
   // Invalidate imstats image to force reload
   document.getElementById("imstats_id").src = "imstats.bmp?time=" + new Date();
}


function zvik_vdma_start()
{
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=vdma_start                ", function(postResponse) {} );
}

function zvik_vdma_stop_slide1()
{
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=play_/mnt/www/slide1.bmp                ", function(postResponse) {} );
}

function zvik_vdma_stop_slide2()
{
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=play_/mnt/www/slide2.bmp                ", function(postResponse) {} );
}

function zvik_vdma_fill()
{
   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=vdma_fill                ", function(postResponse) {} );
}

function set_vaec()
{
   var vita_aec_value = document.getElementById("vaec_id").checked;
   var vaec_level_value = document.getElementById("vaec_level_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command;
   if ( vita_aec_value == true )
   {
      command = "command=vaec_on_" + vaec_level_value + "                ";

      // disable manual exposure
      document.getElementById("vita_exposure_label").disabled = true;
      document.getElementById("sl2slider").disabled = true;
      document.getElementById("vita_exposure_id").disabled = true;
      // disable manual analog gain
      document.getElementById("vita_again_label").disabled = true;
      document.getElementById("sl3slider").disabled = true;
      document.getElementById("vita_again_id").disabled = true;
      // disable manual digital gain
      document.getElementById("vita_dgain_label").disabled = true;
      document.getElementById("sl4slider").disabled = true;
      document.getElementById("vita_dgain_id").disabled = true;
      // disable processor controls
      document.getElementById("agc_label").disabled = true;
      document.getElementById("agc_id").disabled = true;
      document.getElementById("aec_label").disabled = true;
      document.getElementById("aec_id").disabled = true;
      // force processor controls off
      document.getElementById("agc_id").checked = false;
      document.getElementById("aec_id").checked = false;
      httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=agc_off               ", function(postResponse){});
      httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", "command=aec_off               ", function(postResponse){});
   }
   else
   {
      command = "command=vaec_off               ";

      // enable manual exposure
      document.getElementById("vita_exposure_label").disabled = false;
      document.getElementById("sl2slider").disabled = false;
      document.getElementById("vita_exposure_id").disabled = false;
      // enable manual analog gain
      document.getElementById("vita_again_label").disabled = false;
      document.getElementById("sl3slider").disabled = false;
      document.getElementById("vita_again_id").disabled = false;
      // enable manual digital gain
      document.getElementById("vita_dgain_label").disabled = false;
      document.getElementById("sl4slider").disabled = false;
      document.getElementById("vita_dgain_id").disabled = false;
      // enable processor controls
      document.getElementById("agc_label").disabled = false;
      document.getElementById("agc_id").disabled = false;
      document.getElementById("aec_label").disabled = false;
      document.getElementById("aec_id").disabled = false;
   }

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_vita_exposure()
{
   var vita_exposure_value = document.getElementById("vita_exposure_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=exposure_" + vita_exposure_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_vita_again()
{
   var vita_again_value = document.getElementById("vita_again_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=again_" + vita_again_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_vita_dgain()
{
   var vita_dgain_value = document.getElementById("vita_dgain_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=dgain_" + (vita_dgain_value*128) + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_dpc_age()
{
   var dpc_age_value = document.getElementById("dpc_age_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=dpc_age_" + dpc_age_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_dpc_spatial()
{
   var dpc_spatial_value = document.getElementById("dpc_spatial_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=dpc_svar_" + dpc_spatial_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_dpc_temporal()
{
   var dpc_temporal_value = document.getElementById("dpc_temporal_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=dpc_tvar_" + dpc_temporal_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_cfa_bayer()
{
   var cfa_bayer_value = document.getElementById("cfa_bayer_id").selectedIndex;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=cfa_bayer_" + cfa_bayer_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_ccm_select()
{
   var ccm_select_list = document.getElementById("ccm_select_id");
   var ccm_select_idx = document.getElementById("ccm_select_id").selectedIndex;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=ccm_help                ";
   if ( ccm_select_list[ccm_select_idx].text == "Bypass")
   {
      command = "command=ccm_bypass                ";
   }
   else if ( ccm_select_list[ccm_select_idx].text == "Daylight")
   {
      command = "command=ccm_day                ";
   }
   else if ( ccm_select_list[ccm_select_idx].text == "Cool White Fluorescent")
   {
      command = "command=ccm_cwf                ";
   }
   else if ( ccm_select_list[ccm_select_idx].text == "Hot Fluorescent")
   {
      command = "command=ccm_u30                ";
   }
   else if ( ccm_select_list[ccm_select_idx].text == "Incandescent")
   {
      command = "command=ccm_inc                ";
   }

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_ccm_contrast()
{
   var ccm_contrast_value = document.getElementById("ccm_contrast_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=ccm_contrast_" + ccm_contrast_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_ccm_brightness()
{
   var ccm_brightness_value = document.getElementById("ccm_brightness_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=ccm_brightness_" + ccm_brightness_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_ccm_saturation()
{
   var ccm_saturation_value = document.getElementById("ccm_saturation_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=ccm_saturation_" + ccm_saturation_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_noise_strength()
{
   var noise_strength_value = document.getElementById("noise_strength_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=noise_set_" + noise_strength_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_enhance_strength()
{
   var enhance_strength_value = document.getElementById("enhance_strength_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=enhance_set_" + enhance_strength_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_halo_suppress()
{
   var halo_suppress_value = document.getElementById("halo_suppress_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=halo_set_" + halo_suppress_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_geq_strength()
{
   var geq_strength_value = document.getElementById("geq_strength_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=geq_strength_" + geq_strength_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_gamma_table()
{
   var gamma_table_value = document.getElementById("gamma_table_id").selectedIndex;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=gamma_set_" + gamma_table_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_output_select()
{
   var output_select_value = document.getElementById("output_select_id").selectedIndex;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=outsel_" + output_select_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_adv7511_csc0()
{
   var csc_id_value = document.getElementById("adv7511_csc0_id").selectedIndex;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=adv7511_csc0_" + csc_id_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_adv7511_csc1()
{
   var csc_id_value = document.getElementById("adv7511_csc1_id").selectedIndex;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=adv7511_csc1_" + csc_id_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_awb()
{
   var awb_value = document.getElementById("awb_id").checked;

   // Build command for text-based console (underscores will be replaced by space)
   var command;
   if ( awb_value == true )
   {
      command = "command=awb_on                ";
      // disable manual white balance
      document.getElementById("ccm_select_label").disabled = true;
      document.getElementById("ccm_select_id").disabled = true;
   }
   else
   {
      command = "command=awb_off                ";
      // enable manual white balance
      document.getElementById("ccm_select_label").disabled = false;
      document.getElementById("ccm_select_id").disabled = false;
   }

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_target_level()
{
   var target_level_value = document.getElementById("target_level_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command;
   command = "command=agc_level_" + target_level_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_agc()
{
   var agc_value = document.getElementById("agc_id").checked;

   // Build command for text-based console (underscores will be replaced by space)
   var command;
   if ( agc_value == true )
   {
      command = "command=agc_on                ";

      // disable manual analog gain
      //document.getElementById("vita_again_label").disabled = true;
      //document.getElementById("sl3slider").disabled = true;
      //document.getElementById("vita_again_id").disabled = true;
      // disable manual digital gain
      document.getElementById("vita_dgain_label").disabled = true;
      document.getElementById("sl4slider").disabled = true;
      document.getElementById("vita_dgain_id").disabled = true;
   }
   else
   {
      command = "command=agc_off               ";

      // enable manual analog gain
      //document.getElementById("vita_again_label").disabled = false;
      //document.getElementById("sl3slider").disabled = false;
      //document.getElementById("vita_again_id").disabled = false;
      // enable manual digital gain
      document.getElementById("vita_dgain_label").disabled = false;
      document.getElementById("sl4slider").disabled = false;
      document.getElementById("vita_dgain_id").disabled = false;
   }

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_aec()
{
   var aec_value = document.getElementById("aec_id").checked;

   // Build command for text-based console (underscores will be replaced by space)
   var command;
   if ( aec_value == true )
   {
      command = "command=aec_on                ";

      // disable manual exposure
      document.getElementById("vita_exposure_label").disabled = true;
      document.getElementById("sl2slider").disabled = true;
      document.getElementById("vita_exposure_id").disabled = true;
   }
   else
   {
      command = "command=aec_off               ";

      // enable manual exposure
      document.getElementById("vita_exposure_label").disabled = false;
      document.getElementById("sl2slider").disabled = false;
      document.getElementById("vita_exposure_id").disabled = false;
   }

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_geq()
{
   var geq_value = document.getElementById("geq_id").checked;

   // Build command for text-based console (underscores will be replaced by space)
   var command;
   if ( geq_value == true )
   {
      command = "command=geq_on                ";

      // disable manual gamma control
      document.getElementById("gamma_table_label").disabled = true;
      document.getElementById("gamma_table_id").disabled = true;
   }
   else
   {
      command = "command=geq_off                ";

      // enable manual gamma control
      document.getElementById("gamma_table_label").disabled = false;
      document.getElementById("gamma_table_id").disabled = false;
   }

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_imstats_histscale()
{
   var imstats_histscale_value = document.getElementById("imstats_histscale_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=stats_set_scale_" + imstats_histscale_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_imstats_underexp()
{
   var imstats_underexp_value = document.getElementById("imstats_underexp_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=stats_set_underexp_" + imstats_underexp_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}

function set_imstats_overexp()
{
   var imstats_overexp_value = document.getElementById("imstats_overexp_id").value;

   // Build command for text-based console (underscores will be replaced by space)
   var command = "command=stats_set_overexp_" + imstats_overexp_value + "                ";

   httpPost("/cgi-bin/zvik_camera_linux_webserver.elf", command, function(postResponse)
		{
		});
}


