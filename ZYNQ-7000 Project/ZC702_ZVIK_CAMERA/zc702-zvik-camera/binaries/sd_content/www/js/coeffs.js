/*
 * Brian Hill
 * July, 2009
 *
 * Javascript to handle sending FIR coefficients to the embedded board
 */

var total_ajax_req = 0;
var outstanding_ajax_req = 0;

// Create a new connection to the server
function ajaxRequest()
{
    //activeX versions to check for in IE
    var activexmodes=["Msxml2.XMLHTTP", "Microsoft.XMLHTTP"];

    total_ajax_req++;
    outstanding_ajax_req++;

    //Test for support for ActiveXObject in IE first
    //(as XMLHttpRequest in IE7 is broken)
    if (window.ActiveXObject) {
        for (var i=0; i<activexmodes.length; i++){
            try{
                return new ActiveXObject(activexmodes[i]);
            } catch(e) {
                //suppress error
            }
        }
    }

    else if (window.XMLHttpRequest) // if Mozilla, Safari etc
        return new XMLHttpRequest();
    else
        return false;
}

// Send (POST) the selected FIR coefficients to the embedded webserver
function SendCoeff()
{
    var row, col;
    var parameters;
    var myrequest;

    // Nothing to send yet
    if (! document.getElementById("c11").value) {
        return;
    }

    myrequest = new ajaxRequest();

    // Set the callback function to cope with errors and peer response.
    myrequest.onreadystatechange = function()
    {
        var sts_string;

        // 4 = complete
        if (myrequest.readyState == 4) {

            outstanding_ajax_req--;

            // HTTP 200 = "OK"
            if (myrequest.status == 200 ||
                window.location.href.indexOf("http") == -1) {

                sts_string = myrequest.responseText;
                sts_string = sts_string + " total:  " + String(total_ajax_req);
                sts_string = sts_string + " outstanding: " +
                             String(outstanding_ajax_req);

                // Display the (successful) results provided by our peer
                document.getElementById("result").innerHTML =
                    sts_string;
            } else {

                // Failure, I.E. "404 Not Found"

                sts_string = "An error has occured making the request: " +
                             String(myrequest.status);
                sts_string = sts_string + " " + String(outstanding_ajax_req);
                document.getElementById("result").innerHTML = sts_string;
            }
        }
    }

    // Build and send the request

    // Assemble the coefficients into a single string
    parameters = "";
    for (row=0; row < 3; row++) {
        for (col=0; col < 3; col++) {
            parameters += document.getElementById("c"+(row+1)+(col+1)).value;
            parameters +="&";
        }
    }

    // Lastly, the gain.
    parameters += parseInt(document.getElementById("gain").value * 131072.0);

    myrequest.open("POST", "set_coefficients", true);
    myrequest.setRequestHeader("Content-type",
                               "application/x-www-form-urlencoded");
    myrequest.send(parameters);
}

// Take the current value of the "CoefName" selection list box and
// and update the form fields with the correspoinding coefficient values.
// This function is called on page load and whenever the user changes the
// value in the list box.
function SelCoeff()
{
  var mylist;
  var row, col;
  var theArray;
  var theGain;

  var IdentityArray = [  0,  0,  0, 
                         0,  1,  0,  
                         0,  0,  0  ];
  var IdentityGain = 131072;

  var EdgeArray = [  -1, -1, -1,  
                     -1,  8, -1, 
                     -1, -1, -1  ];
  var EdgeGain = 131072;

  var BlurArray = [  1,  1, 1,
                     1,  0, 1,
                     1,  1, 1 ];
//  var BlurGain = 8192;
  var BlurGain = 16384;

  var SmoothArray = [ 1, 2, 1,
                      2, 4, 2,
                      1, 2, 1 ];
//  var SmoothGain = 1310;
  var SmoothGain = 8192;

  var SharpenArray = [ -2, -2, -2,
                       -2, 32, -2, 
                       -2, -2, -2  ]; 
  var SharpenGain = 8192;

  var GaussArray = [ 2,  4,  2, 
                     4,  8,  4,
                     2,  4,  2 ];
//  var GaussGain = 2521;
  var GaussGain = 4096;

  mylist = document.getElementById("CoefName");
  theArray = 0;
  if (mylist.options[mylist.selectedIndex].text == "Identity") {
      theArray = IdentityArray;
      theGain = IdentityGain;
  } else if (mylist.options[mylist.selectedIndex].text == "Edge Detect") {
      theArray = EdgeArray;
      theGain = EdgeGain;
  } else if (mylist.options[mylist.selectedIndex].text == "Blur") {
      theArray = BlurArray;
      theGain = BlurGain;
  } else if (mylist.options[mylist.selectedIndex].text == "Smooth") {
      theArray = SmoothArray;
      theGain = SmoothGain;
  } else if (mylist.options[mylist.selectedIndex].text == "Sharpen") {
      theArray = SharpenArray;
      theGain = SharpenGain;
  } else if (mylist.options[mylist.selectedIndex].text == "Gaussian") {
      theArray = GaussArray;
      theGain = GaussGain;
  } else {
      // If the user has chosen "User Defined", change the selected
      // display to the last item, which is blank.
      mylist.selectedIndex = mylist.options.length - 1;
  }

  if (theArray) {
      for (row=0; row < 3; row++) {
          for (col=0; col < 3; col++) {
              document.getElementById("c"+(row+1)+(col+1)).value =
                  theArray[(row*3)+col];
          }
      }
  }
  // Fill in the form fields with the pre-defined values
  if (theGain) {
      // Set the slider position to reflect the pre-defined gain
      A_SLIDERS[0].f_setValue(theGain / 131072.0, 1, 1);
      // Show the chosen gain
      document.getElementById("gain").value = theGain / 131072.0;
  } 

  // Send the selected coefficients to the embedded web server
  SendCoeff();
}

// Send the designated bitmap image to the embedded host
function SetMyImage ()
{
    var imgfilename, ext;

    imagefilename = document.getElementById("imagefile").value;
    ext = (imagefilename.slice(imagefilename.length - 3)).toLowerCase();
    // verify that it is a BMP
    if (ext != "bmp") {
       // Update status
       document.getElementById("result").innerHTML = imagefilename +
           " is not a Windows Bitmap (.BMP) file.";
    } else {
       document.getElementById("result").innerHTML = imagefilename +
           " selected";
       document.getElementById("imagefile").form.submit();
    }
}


