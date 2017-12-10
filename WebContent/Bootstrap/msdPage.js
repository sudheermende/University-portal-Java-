// this is for login and HomeLogin pages
function doCall(id)
{
sessionStorage.setItem("position",id);
}
//this is for login and HomeLogin pages
function fillPosition(){
	
	var position=sessionStorage.getItem("position");
	if(position==null||position.length==0)
		{
		 window.location.href = "http://localhost:8085/S_University/HomeLogin.jsp";
		}
	document.getElementById("position").innerHTML=position+" ";
}


// after login successfully userName will be created in sessionStorage
function setUserName(name)
{
	sessionStorage.setItem("userName",name);
}

// getting the userName of logedin person
function getUserName()
{
sessionStorage.getItem("userName");
}