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
<title>Adding new course</title>


<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

<script type="text/javascript" src="script.js"></script>

</head>
<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> admin </sub>
	</h1>
	<div style="padding-left: 60px; padding-right: 60px;">

		<%String userid=request.getParameter("userid"); 
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

ResultSet rs=st.executeQuery("select * from departmentList");
 
%>
		<form method="post" action=" ">
			<h3 style="color: #378fa1; text-align: right;">
				Hello &nbsp;&nbsp;<%= userid%>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %>
				</a> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="HomeLogin.jsp">Logout</a>
			</h3>
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
				<span><a
					href="UniversityPaymentsList.jsp?userid=<%= userid%>">Financial
						Issues</a></span>
			</h3>
		</form>
		${notification}${error}
		<fieldset>
			<legend>
				<h3>Adding a new Course</h3>
			</legend>
			<form method="post" action="AddingNewMembers"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">

				<h4>Enter details</h4>
				Course
				name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="text" name="newCourse" placeholder="course name"
					required><br>
				<br> Course
				id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="text" name="courseId" placeholder="courseid" required><br>
				<br>

				credits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="text" name="credits" placeholder="credits"
					pattern="[1-3]{1}" title="credits must be between 1-3 "
					maxlength="1" size="1" required><br>
				<br> Department
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<select name="department" onchange="showHint(this.value,'preReq')"
					required>

					<% while(rs.next()) 
 {
 %>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(1) %></option>

					<%} %>
				</select> <br>
				<br> Pre Req
				subject&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<select
					name="preReq" placeholder="preReq" id="txtHint">
					<option>pre req</option>
				</select> <br>
				<br> Level of study
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <select
					name="level">
					<option value="undergraduate">undergraduate</option>
					<option value="graduate">graduate</option>
					<option value="masters">masters</option>
				</select> <br>
				<br> Max Students
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input
					type="text" name="capacity" placeholder="capacity"
					pattern="[10-60]{2}" title="min 10 max capacity 60 " maxlength="2"
					size="2" required> <br>
				<br> Time
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="time" name="time" placeholder="time" required>
				<br>
				<br> Room
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="text" name="room" placeholder="room" required>
				<br>
				<br> <input type="hidden" name="userid" value=<%=userid %>>
				<button style="color: white; background-color: #378fa1"
					type="submit" name="source" value="AddCourse">Add course</button>
				<br>
				<br>
			</form>
		</fieldset>
	</div>

	<%connection.close(); 

%>
</body>
</html>