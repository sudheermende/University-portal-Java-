<%@page import="org.omg.PortableInterceptor.INACTIVE"%>
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
<title>S University admin</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />
<script type="text/javascript" src="Bootstrap/msdPage.js"></script>


</head>
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

<%
String userid=(request.getParameter("userid")).toLowerCase();

//JOptionPane.showMessageDialog(null, name.toString());

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

%>


<body onload="setUserName('<%=userid%>')">


	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> admin </sub>
	</h1>
	<div style="padding-left: 60px; padding-right: 60px;">

		<%
int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);
ResultSet rs=UserGuiDB.getUserFromDB(connection, userid.toLowerCase());

%>




		<h3 style="color: #378fa1; text-align: right;">
			Hello &nbsp;&nbsp;<%= userid%>
			&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %>
			</a> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="HomeLogin.jsp">Logout</a>
		</h3>
		<form method="post" action="HomeLogin">
			<h3 style="color: #b70a01; text-align: right">
				<span><a href="Admin.jsp?userid=<%= userid%>">Admin Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="AccountSettings.jsp">Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="ApplicantsList.jsp?userid=<%= userid%>">Applicant
						List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="StudentsList.jsp?userid=<%= userid%>">Student List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="FacultyList.jsp?userid=<%= userid%>">Faculty
						List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="CourseList.jsp?userid=<%= userid%>">Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="DepartmentList.jsp?userid=<%= userid%>">Department
						List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="UniversityPaymentsList.jsp?userid=<%= userid%>">Financial
						Issues</a></span>
			</h3>
		</form>
	</div>
	${notification}${error}
	<br>
	<div style="padding-left: 60px; padding-right: 60px;">
		<fieldset>
			<legend>
				<h3>Admin info</h3>
			</legend>
			<br>


			<nav id="image">

			<form action="changePic" method="post">
				<%
String fileName="G:\\Masters\\Java\\Java Mars\\Classes\\WebContent\\images\\"+userid+".jpg";
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


	<%connection.close(); 


%>


</body>
</html>