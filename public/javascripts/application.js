// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//use jQuery’s ajaxSetup method to set the request header so that it only accepts JavaScript. Used for sending js POSTS to controllers
// jQuery.ajaxSetup({  
//     'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
// });



	
	function afterSubmit(r, data, action) {
	  if(r.responseText != "") { // If a message is returned
	    alert(r.responseText);  	
      return false; // Don't remove this!
    }
    return true; // Don't remove this!
	}
