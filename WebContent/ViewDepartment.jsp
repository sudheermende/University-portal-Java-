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

<%
String userid=request.getParameter("userid"); 
String dept=request.getParameter("dept");%>
<title>View <%=dept %></title>
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />


</head>

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
		
		
		int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

		ResultSet rs=st.executeQuery("select * from courses where department='"+dept+"'");
		
%>

<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> admin </sub>
	</h1>
	<div style="padding-left: 60px; padding-right: 60px;">

		<h3 style="color: #378fa1; text-align: right;">
			Hello &nbsp;&nbsp;<%= userid%>
			&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %></a>
			&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="HomeLogin.jsp">Logout</a>
		</h3>

		<h3 style="color: #b70a01; text-align: right">
			<span><a href="Admin.jsp?userid=<%= userid%>">Admin Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
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

		${notification} <br>
		<form method="post" action="registration">
			<fieldset>
				<legend>
					<h3>
						Courses List in
						<%=dept %></h3>
				</legend>
				<div
					style="padding-left: 30px; padding-right: 30px; padding-bottom: 20px; padding-top: 30px;">

					<input type="hidden" name="userid" value="<%=userid%>"> <input
						type="hidden" name="position" value="admin">



					<table align="center" border="1" width="100%">
						<tr style="background: #3a94a8; color: white;">
							<th>S.no</th>
							<th>course name</th>
							<th>course id</th>
							<th>Department</th>
							<th>pre course</th>
							<th>instructor</th>
							<th>credits</th>
							<th>capacity</th>
							<th>Enrolled no. students</th>
							<th>Is open</th>
							<th>level</th>
							</th>
							<th>room</th>
							<th>time</th>
							<th>action</th>
						</tr>
						<% 

int i=1;
while(rs.next())
{
%>
						<tr>
							<td><%=i %></td>
							<td><font size="2" color="black"><%=rs.getString(1)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(2)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(3)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(5)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(6)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(4)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(9)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(10)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(11)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(12)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(8)%></font></td>
							<td><font size="2" color="black"><%=rs.getString(7)%></font></td>
							<td>

								<button style="color: white; background-color: #378fa1"
									type="submit" value="<%=rs.getString(2)%>" name="viewCourse">view
									course</button>
							</td>
						</tr>
						<% i++;} 
%>
					</table>
				</div>
			</fieldset>
		</form>
	</div>

</body>
<%connection.close(); %>
</html>