<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>FBConnect</title>
 <style type="text/css">
            .gm-style .gm-style-cc span,.gm-style .gm-style-cc a,.gm-style .gm-style-mtc div{font-size:10px}
        </style>
        
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/bootstrap.min.css">

</head>
<body>
 <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script>
$(document).ready(function(){
	var paging="";

	$("#fbsubmit").click(function(){
		var inputtext= $("#inptext").val();
		//https://www.facebook.com/CUSATAlumni
		var start= inputtext.lastIndexOf("/");
		var url = inputtext.substring(start,inputtext.lenght)+"/posts/";
		console.log(url);
		//inputtext
	    FB.api(url, function(response) {
	    	  console.log(response);
	    	  console.log(response.paging.next);
	    	  paging =response.paging.next;
	    	  $.ajax({
			  	    type: 'post', // it's easier to read GET request parameters
			  	    url: 'facebook',
			  	    dataType: 'JSON',
			  	    data: { 
			  	      loadProds: 1,
			  	      fb: JSON.stringify(response) // look here!
			  	    },
			  	    success: function(data) {
						console.log("sucess"); 	
			  	    },
			  	    error: function(data) {
			  	        alert('fail');
			  	    }
			  	});

	    	  callrec(paging);
	   	});
	});

});
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '554398744642573',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.2' // use version 2.2
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "http://connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
    }); 
    
  }
  
  function callrec(paging) {
	    FB.api(paging,function(response) {
		  	console.log(response);
		  	
		  	$.ajax({
		  	    type: 'post', // it's easier to read GET request parameters
		  	    url: 'facebook',
		  	    dataType: 'JSON',
		  	    data: { 
		  	      loadProds: 1,
		  	      fb: JSON.stringify(response) // look here!
		  	    },
		  	    success: function(data) {
					console.log("sucess"); 	
		  	    },
		  	    error: function(data) {
		  	        alert('fail');
		  	    }
		  	});

		  	paging =response.paging.next;
		  	callrec(paging);
		  	
		});
	  }
  
  </script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
</fb:login-button>

<div id="status">

</div>
<br>
<br>
<div id="inputdiv">
	<input id="inptext" type="text" class="form-control" placeholder="Text input">
	<button id="fbsubmit" type="submit" class="btn btn-primary">Submit</button>
</div>


</body>
</html>