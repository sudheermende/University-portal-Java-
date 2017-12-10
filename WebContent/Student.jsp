<%@page import="Classes.EncriptedFormat"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="Classes.SqliteConnectionThread"%>
<%@page import="Classes.UserGuiDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Classes.User"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />
<script type="text/javascript" src="Bootstrap/msdPage.js"></script>


<% 

String userid=request.getParameter("userid");
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
session.setAttribute("userName",userid);

int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

ResultSet rs=UserGuiDB.getUserFromDB(connection,userid.toLowerCase());
%>

<title>Student: <%=rs.getString(1) %> portal
</title>

<style>
#image {
	float: left;
	max-width: 170px;
	border: 1px solid black;
	margin: 0;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

#info {
	float: center;
	margin-left: 450px;
	padding: 1em;
	overflow: hidden;
}
</style>

</head>
<body onload="setUserName('<%=userid%>')">
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> student </sub>
	</h1>
	<div style="padding-left: 80px; padding-right: 80px;">
		<form method="post" action="HomeLogin">
			<h3 style="color: #378fa1; text-align: right;">
				Hello &nbsp;&nbsp;<%= userid%>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %></a>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="HomeLogin.jsp">Logout</a>
			</h3>
		</form>


		<form method="post" action="HomeLogin"
			style="padding-left: 20px; padding-bottom: 20px;">
			<h3 style="color: #b70a01; text-align: right">
				<span><a href="Student.jsp?userid=<%= userid%>">Student
						Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="AccountSettings.jsp">Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="Registration.jsp?userid=<%= userid%>">Registration</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="StudentCourseList.jsp?userid=<%= userid%> ">My
						Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="PaymentsList.jsp?userid=<%= userid%>">Financial issues</a></span>
			</h3>
		</form>
	</div>
	${error}${notification}
	<br>

	<div style="padding-left: 80px; padding-right: 80px;">
		<fieldset>
			<legend>
				<h3>Student info</h3>
			</legend>
			<br>

			<nav id="image">

			<form action="changePic" method="post">
				<%
String fileName="G:\\Masters\\Java\\Java Mars\\S_University\\WebContent\\images\\"+userid+".jpg";
File f=null;
f=new File(fileName);
if(f.exists())
{
	fileName="images/"+userid+".jpg";
}
else
{
	fileName="images/user.png";
}


%>

				<img src=<%=fileName%> alt="<%=userid %>" title=<%=userid %>
					style="width: 170px; height: 200px;">

			</form>
			</nav>
			<nav id="info"> Name
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
			<%=rs.getString(1) %> <br>
			<br>

			Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
			<%=rs.getString(10) %> <br>
			<br>

			Phone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
			<%=rs.getString(9)%><br>
			<br>

			Date of
			birth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%=rs.getString(11) %>
			<br>
			<br>

			Level of study &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=rs.getString(12)%>
			<br>
			<br>

			Course
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
			<%=rs.getString(13) %> <br>
			<br>
			Department
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=rs.getString(14) %>
			<br>
			<br>


			ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
			<font style="color: #b70a01"><%=rs.getString(15) %>&nbsp;&nbsp;</font>
			</nav>
		</fieldset>
	</div>
	<br>
	<br>
	<div style="padding-left: 80px; padding-right: 80px;">
		<fieldset>
			<legend>
				<h3>Grading & Financial details</h3>
			</legend>
			<br> CGPA
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
			<font style="color: #b70a01"><%=Float.parseFloat(rs.getString(17))%></font>
			<br>
			<br> Financial Pending &nbsp;&nbsp;&nbsp;&nbsp;: <font
				style="color: #b70a01"><%=rs.getFloat(18) %></font> <br>
			<br>


		</fieldset>
	</div>
	<% connection.close(); 

%>

</body>
</html>