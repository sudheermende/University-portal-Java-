<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="Classes.SqliteConnectionThread"%>
<%@page import="Classes.UserGuiDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>S University Reg</title>
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />
<script src=""></script>


<% 

SqliteConnectionThread sqlthrd=new SqliteConnectionThread();
sqlthrd.start();
try 
{
	
	sqlthrd.join();
} catch (InterruptedException e) 
{
	e.printStackTrace();
}
Connection connection =sqlthrd.getConn();
Statement st=connection.createStatement();

String sql="select  departmentName from departmentList order by departmentName";
ResultSet rs=st.executeQuery(sql);

%>
</head>
<body>
	<h1 style="color: #b70a01;">&nbsp;&nbsp;S University</h1>

	<div style="padding-left: 80px; padding-right: 80px;">
		<p style="color: black; text-align: right;">
			<a href="HomeLogin.jsp"> Login</a>&nbsp;&nbsp;<a
				href="ForgotPassword.jsp"> Reset password</a>
		</p>
		<font color="#b70a01">${error }</font>

		<fieldset>
			<legend>
				<h3>Application</h3>
			</legend>
			<form method="post" action="SignUp"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">
				<h4>Enter your details</h4>
				User
				name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input size="16" type="text" name="userid" placeholder="userid"
					required value=${userid}><br>
				<br>

				email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input size="16" type="email" name="email" placeholder="email"
					required value=${email} ><br>
				<br>

				phone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input size="16" type="tel" name="cell" placeholder="cell" required
					value=${cell}><br>
				<br> Date of
				birth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input
					type="date" name="dob" required value=${dob} ><br>
				<br> Level of study &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <select
					name="level">
					<option value="undergraduate">undergraduate</option>
					<option value="graduate">graduate</option>
					<option value="masters">masters</option>

				</select> <br>
				<br> Course
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<select name="department">
					<%
while(rs.next())
{
%>
					<option value='<%=rs.getString(1).toLowerCase() %>'>
						<%=rs.getString(1) %>
					</option>

					<%
}
%>
				</select> <br>
				<br> Security Question : <font color="#b70a01">What was
					your high school name?</font><br>
				<br>

				answer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="password" name="answer" size="16" placeholder="answer"
					required title="minimum 7 characters" required value=${answer} ><br>
				<br>

				password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="password" name="password" size="16" pattern=".{7,}"
					required title="minimum 7 characters" placeholder="password"
					required value=${password}><br>
				<br> confirm password&nbsp;&nbsp;&nbsp;: <input type="password"
					name="confirmpassword" size="16" pattern=".{7,}"
					placeholder="re-password" required value=${confirmpassword} ><br>
				<br>

				<button style="color: white; background-color: #378fa1"
					type="submit" name="source" value="signup">Sign up</button>
				<br>
				<br>
			</form>
		</fieldset>
	</div>
	<% connection.close(); 

%>

</body>
</html>