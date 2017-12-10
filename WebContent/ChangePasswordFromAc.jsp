<%@page import="javax.swing.JOptionPane"%>
<%@page import="Classes.SqliteConnectionThread"%>
<%@page import="Classes.UserGuiDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
	<%
String userid=request.getParameter("userid");
String position=request.getParameter("position");

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
int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

%>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub>&nbsp;<%= position%>
		</sub>
	</h1>
	<div style="padding-left: 80px; padding-right: 80px;">
		<form method="post" action="HomeLogin">
			<h3 style="color: #378fa1; text-align: right;">
				Hello &nbsp;&nbsp;<%= userid%>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %>
				</a> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="HomeLogin.jsp">Logout</a>
			</h3>
		</form>
		<h4 style="text-align: right;";>
			<a href="AccountSettings.jsp?userid=<%=userid %>">&lt&lt &nbsp
				back</a>
		</h4>

	</div>

	<div style="padding-left: 80px; padding-right: 80px;">
		<font color="#b70a01" text-align="center">${error }</font>
		<fieldset>
			<legend>
				<h3>Change password</h3>
			</legend>

			<form action="resetpassword" method="post"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">
				<h4>Enter your details</h4>
				Username&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				: <input type="text" placeholder="user" name="userid" readonly
					value=<%= request.getParameter("userid")%>><br>
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

				<button type="submit" value="changePassword" name="source"
					style="color: white; background-color: #378fa1">Change
					password</button>

			</form>

		</fieldset>
	</div>
	<%connection.close();%>
</body>

</html>