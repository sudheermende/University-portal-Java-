<%@page import="javax.swing.JOptionPane"%>
<%@page import="Classes.SqliteConnectionThread"%>
<%@page import="Classes.UserGuiDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
String userid=(request.getParameter("userid")).toLowerCase();

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

ResultSet rs=UserGuiDB.getUserFromDB(connection, userid.toLowerCase());
%>


<title>Faculty: <%=userid%> portal
</title>
<style>
#image {
	float: left;
	border: 1px solid black;
	max-width: 180px;
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
		&nbsp;&nbsp;S University<sub> faculty </sub>
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
				<span><a href="Faculty.jsp?userid=<%= userid%>">Faculty
						Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="AccountSettings.jsp">Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="FacultyCourseList.jsp?userid=<%= userid%>">My
						Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="FacultyPaymentsList.jsp?userid=<%= userid%>">Payments</a></span>
		</form>
	</div>
	${error}${notification}
	<div style="padding-left: 80px; padding-right: 80px;">
		<fieldset>
			<legend>
				<h3>Faculty info</h3>
			</legend>
			<br>

			<nav id="image"> <%
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


%> <img src=<%=fileName%> alt="<%=userid %>" title=<%=userid %>
				style="width: 170px; height: 200px;"> </nav>

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

	<%connection.close(); %>
</body>
</html>