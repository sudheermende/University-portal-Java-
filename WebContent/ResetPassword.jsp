<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset password</title>
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

</head>
<body>
	<h1 style="color: #b70a01;">&nbsp;&nbsp;S University</h1>

	<div style="padding-left: 80px; padding-right: 80px;">
		<p style="color: #378fa1; text-align: right;">
			<a href="HomeLogin.jsp"> Login</a> &nbsp;&nbsp;<a href="Signup.jsp">Signup</a>
		</p>

		<font color="#b70a01" text-align="center">${error }</font> <br>
		<br>
		<fieldset>
			<legend>
				<h3>Reset password from out</h3>
			</legend>

			<form action="resetpassword" method="post"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">
				<h4>Enter your details</h4>
				Username&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				: <input type="text" placeholder="user" name="userid" readonly
					value=${userid} ><br>
				<br> Security Question : <font color="#b70a01">What was
					your high school name?</font><br>
				<br>

				answer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="password" name="answer" size="16" placeholder="answer"
					required value=${answer} ></input><br>
				<br> new password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <input
					type="password" placeholder="new password" name="password"
					pattern=".{7,}" required title="minimum 7 characters"
					value=${password} ><br>
				<br> confirm password : <input type="password"
					placeholder="re-password" name="confirmpassword" pattern=".{7,}"
					required title="minimum 7 characters" value=${confirmpassword}><br>
				<br>

				<button type="submit" value="resetPassword" name="source"
					style="color: white; background-color: #378fa1">Change
					password</button>

			</form>

		</fieldset>
	</div>
</body>

</html>