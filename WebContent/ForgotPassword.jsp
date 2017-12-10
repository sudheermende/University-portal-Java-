<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>forgot password</title>
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

</head>
<body>
	<h1 style="color: #b70a01;">&nbsp;&nbsp;S University</h1>

	<div style="padding-left: 80px; padding-right: 80px;">
		<p style="color: #378fa1; text-align: right;">
			<a href="HomeLogin.jsp">Login</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="Signup.jsp">Signup</a>
		</p>
		<font color="#b70a01" text-align="center">${error }</font> <br>
		<br>
		<fieldset>
			<legend>
				<h3>Forgot password</h3>
			</legend>

			<form action="forgotpassword" method="post"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">
				<h4>Enter your details</h4>
				<p>Username :</p>
				<input type="text" placeholder="user" name="userid" required
					value=${userid} ><br>
				<br> <input type="submit" value="search account"
					style="color: white; background-color: #378fa1">

			</form>

		</fieldset>
	</div>
</body>
</html>