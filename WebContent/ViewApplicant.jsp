
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
<title>View applicant info</title>
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />


<% 
String applicant=(request.getParameter("applicant")).toLowerCase(); 
String userid="admin";//(request.getParameter("userid")).toLowerCase(); 
SqliteConnectionThread sqlthrd=new SqliteConnectionThread();
sqlthrd.start();

System.out.println("2 Usrname : "+userid+" applicant : "+applicant);
try 
{
	
	sqlthrd.join();
} catch (InterruptedException e) 
{
	e.printStackTrace();
}
Connection connection =sqlthrd.getConn();

Statement st=connection.createStatement();
int msgCount=0;
//st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

ResultSet rs=UserGuiDB.getUserFromDB(connection,applicant.toLowerCase());
%>


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
<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> admin </sub>
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
		<h3 style="color: #b70a01; text-align: right">
			<span><a href="Admin.jsp?userid=<%= userid%>">Admin Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<span><a href="AccountSettings.jsp?userid=<%= userid%>">Account
					Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
				href="ApplicantsList.jsp?userid=<%= userid%>">Applicant List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<span><a href="StudentsList.jsp?userid=<%= userid%>">Student
					List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
				href="FacultyList.jsp?userid=<%= userid%>">Faculty List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<span><a href="CourseList.jsp?userid=<%= userid%>">Course
					List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
				href="DepartmentList.jsp?userid=<%= userid%>">Department List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<span><a href="UniversityPaymentsList.jsp?userid=<%= userid%>">Financial
					Issues</a></span>
		</h3>
		</h3>


		${notification}${error} <br>
		<fieldset>
			<legend>
				<h3>Applicant info</h3>
			</legend>
			<br>
			<form method="post" action="confirmAdmission"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">
				<input type="hidden" name="userid" value=<%=userid%>>
				<nav id="image"> <%
String fileName="G:\\Masters\\Java\\Java Mars\\S_University\\WebContent\\images\\"+applicant+".jpg";
File f=null;
f=new File(fileName);
if(f.exists())
{
	fileName="images/"+applicant+".jpg";
	
}
else
{
	
	fileName="images/user.png";
}

%> <img src="<%=fileName%>" alt="<%=applicant %>" title=<%=applicant %>
					style="width: 100px; height: 130px;"> </nav>


				<nav id="info">
				<h4>
					<%=applicant %>
					details
				</h4>
				User
				name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<%=rs.getString("username") %><br>
				<br>

				email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<%=rs.getString("email") %> <br>
				<br>

				phone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<%=rs.getString("cell") %><br>
				<br>

				Date of
				birth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%=rs.getString("dateofbirth") %>
				<br>
				<br>

				Level of study &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=rs.getString("level") %>
				<br>
				<br>

				Department
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=rs.getString("department") %>
				<br>
				<br>


				Applicant
				Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <font
					style="color: #b70a01"><%=rs.getString("id") %> </font>
				<br>
				<br>


				Status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<font style="color: #b70a01"><%=rs.getString("position").toUpperCase() %>&nbsp;&nbsp;</font>
				<br>
				<br>
				<br>

				<button style="color: white; background-color: #378fa1"
					type="submit" value="<%=applicant %>" name="confirmaction">Confirm
					Admission</button>
				|
				<button style="color: white; background-color: #378fa1"
					type="submit" value="<%=applicant %>" name="cancelaction">Cancel
					Admission</button>

				</nav>

			</form>
		</fieldset>



		<%
connection.close();
%>
	</div>
</body>
</html>










