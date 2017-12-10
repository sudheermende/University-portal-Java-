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
<title>Account settings</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

</head>

<% 
String userid=(String) session.getAttribute("userName");

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


ResultSet rs=UserGuiDB.getUserFromDB(connection, userid);
String position=rs.getString("position");

%>

<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub>&nbsp;<%= position %></sub>
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

		<%
String url;
if(position.equalsIgnoreCase("student"))
{ 
	url="Student.jsp?userid="+userid;
}
else if(position.equalsIgnoreCase("applicant"))
{ 
	url="Applicant.jsp?userid="+userid;
} else if(position.equalsIgnoreCase("faculty"))
{ 
	url="Faculty.jsp?userid="+userid;
} else if(position.equalsIgnoreCase("admin"))
{ 
	url="Admin.jsp?userid="+userid;
}

else
	url="HomeLogin.jsp";

%>





		<h4 style="text-align: right;";>
			<a href="<%=url %>">&lt&lt &nbsp back</a>
		</h4>
	</div>

	<div
		style="padding-top: 70px; padding-left: 200px; padding-right: 200px;">

		<fieldset>
			<legend>
				<h3>Account settings</h3>
			</legend>
			<ul>
				<li><h3>
						<a
							href="ChangePasswordFromAc.jsp?userid=<%=userid%>&position=<%=position%>">
							Change the password </a>
					</h3></li>
				<li><h3>
						<a
							href="ChangePersonalInfo.jsp?userid=<%=userid%>&position=<%=position%>">Change
							personal info</a>
					</h3></li>
				<li><h3>
						<a
							href="ChangeProfilePic.jsp?userid=<%=userid%>&position=<%=position%>">Change
							profile picture</a>
					</h3></li>
			</ul>

		</fieldset>

	</div>
	<%connection.close(); %>

</body>
</html>