
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="javax.swing.JOptionPane"%>
<%@ page import="java.util.Date,java.util.List"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>S University Login</title>
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />
<script src="Bootstrap/msdPage.js"></script>

</head>


<body onload="fillPosition()">

	<h1 style="color: #b70a01;">&nbsp;&nbsp;S University</h1>
	<div style="padding-left: 80px; padding-right: 80px;">
		<p style="color: #378fa1; text-align: right;">
			<a href="HomeLogin.jsp">Back</a> &nbsp;&nbsp;|&nbsp;&nbsp;<a
				href="Signup.jsp">Sign up</a>
		</p>
		<font color="red">${error }</font> <br>
		<br>
		<fieldset>
			<legend>
				<h3>
					<span id="position"></span>Login
				</h3>
			</legend>


			<form method="post" action="index"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">
				<h4>Enter your details</h4>
				user Id &nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;<input type="text"
					name="userid" placeholder="user id" required></br>
				</br> password :&nbsp;<input type="password" name="password"
					placeholder="password" required> </br>
				</br>
				</br> <input type="hidden" value=<%=request.getParameter("position") %>
					name="position">
				<button style="color: white; background-color: #378fa1"
					type="submit" value="login" name="login">Login</button>
				<br> <br> <a href="ForgotPassword.jsp"
					style="color: #378fa1;"> Forgot password </a>
			</form>
		</fieldset>




	</div>

</body>
</html>