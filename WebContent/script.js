
function showHint(str,str2) {
	
// we can use str2 any where for implementation 	
  var xhttp;
  console.log("open from add course :"+str);
  
  
  if (str.length == 0 || str.trim().length==0) { 
    document.getElementById("txtHint").innerHTML = "<option>search result</option>";
   	disableBt();
    
    return;
  }

 enableBt();
  xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
    	
    	var resp=this.responseText;
    	
    	console.log(" resp : "+resp);
    	console.log(" cond : <option value='' > no match </option>");
    	if(resp.trim()=="<option value='' > no match </option>".trim())
    		{
    		disableBt();
    		console.log("only one")
    	      document.getElementById("txtHint").innerHTML = this.responseText;
    		}
    	else{
    		enableBt();
    		
      document.getElementById("txtHint").innerHTML = this.responseText;
    	}
    }
  };
  
  
  // it is accessing gethint.java servlet using get method and 
  xhttp.open("GET", "gethint?id="+str.trim()+"&source="+str2+"", true);
  xhttp.send(); 
  
}

function disableBt()
{
    document.getElementById("hintOpenButton").setAttribute("disabled","");
}

function enableBt()
{
	 document.getElementById("hintOpenButton").removeAttribute("disabled");
	 
}





