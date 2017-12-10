<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${userid} portal</title>
</head>

<h4 align="right">
	<a href="HomeLogin.jsp" class="current"> Logout !</a>
	&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="ChangePasswordFromAc.jsp?userid=${userid}" class="current">
		Change Password </a>
</h4>
<h1>Hello ${userid }</h1>

<p>password : ${password}</p>
inbox : ${position} : ${level} :${department}
</body>
</html>