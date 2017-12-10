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
<title>Student course list</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

</head>

<body>

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

int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

ResultSet rsPursuing=UserGuiDB.getStudentCourseList(connection,userid,"pursuing");
ResultSet rsFinished=UserGuiDB.getStudentCourseList(connection,userid,"finished");

%>


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

		<form style="padding-left: 20px; padding-bottom: 20px;">
			<h3 style="color: #b70a01; text-align: right">
				<span><a href="Student.jsp?userid=<%= userid%>">Student
						Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="AccountSettings.jsp?userid=<%= userid%>">Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="Registration.jsp?userid=<%= userid%>">Registration</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="StudentCourseList.jsp?userid=<%= userid%> ">My
						Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="PaymentsList.jsp?userid=<%= userid%>">Financial issues</a></span>
			</h3>
		</form>
	</div>

	<div
		style="padding-left: 80px; padding-right: 80px; padding-right: 80px;">
		<fieldset>
			<legend>
				<h3>Course List</h3>
			</legend>
			<div
				style="padding-left: 30px; padding-right: 30px; padding-top: 30px;">
				<fieldset>
					<legend> Current courses</legend>
					<table align="center" border="1" width="100%">
						<tr style="background: #3a94a8; color: white;">
							<th>S.no</th>
							<th>Course name</th>
							<th>Course id</th>
							<th>Department</th>
							<th>Faculty</th>
							<th>Grade</th>
							<th>Action</th>
						</tr>
						<%
int i=1;
while(rsPursuing.next())
{
%>
						<tr>
							<td><%=i %></td>
							<td><font size="2"><%=rsPursuing.getString(2)%></font></td>
							<td><font size="2"><%=rsPursuing.getString(1)%></font></td>
							<td><font size="2"><%=rsPursuing.getString(3)%></font></td>
							<td><font size="2"><%=rsPursuing.getString(4)%></font></td>
							<td><font size="2" color="black"><%=rsPursuing.getString(5)%></font></td>
							<td style="padding-left: 20px;">

								<form action="ClassTasks" method="post">

									<%
			String courseid=rsPursuing.getString(1);
			UserGuiDB.createCourseListTable(connection,courseid );

			int tasksInCourse=st.executeQuery("select count(*) from "+courseid+"Details").getInt(1);
			
			String buttonStatus="";

			if(tasksInCourse<=0)
			{
			buttonStatus="disabled";
			}

			 %>


									<input type="hidden" name="userid" value="<%= userid%>">
									<input type="hidden" name="course"
										value="<%=rsPursuing.getString(1)%>">
									<button type="submit" value="viewPerformance" name="source"
										<%=buttonStatus %>>View Activities</button>
								</form>
							</td>
						</tr>
						<% i++;} 
%>

					</table>
				</fieldset>
			</div>
			<br>
			<br>

			<div
				style="padding-left: 30px; padding-right: 30px; padding-bottom: 30px;">
				<fieldset>
					<legend> Finished courses</legend>
					<table align="center" border="1" width="100%">
						<tr style="background: #3a94a8; color: white;">
							<th>S.no</th>
							<th>Course name</th>
							<th>Course id</th>
							<th>Department</th>
							<th>Faculty</th>
							<th>Grade</th>
							<th>GPA</th>
							<th>Action</th>
						</tr>
						<% 
int j=1;
while(rsFinished.next())
{
%>
						<tr>
							<td><%=j %></td>
							<td><font size="2" color="black"><%=rsFinished.getString(2)%></font></td>
							<td><font size="2" color="black"><%=rsFinished.getString(1)%></font></td>
							<td><font size="2" color="black"><%=rsFinished.getString(3)%></font></td>
							<td><font size="2" color="black"><%=rsFinished.getString(4)%></font></td>
							<td><font size="2" color="black"><%=rsFinished.getString(5)%></font></td>
							<td><font size="2" color="black"><%=rsFinished.getString(6)%></font></td>
							<td style="padding-left: 20px;">

								<form action="ClassTasks" method="post">

									<%
			String courseid=rsFinished.getString(1);
			UserGuiDB.createCourseListTable(connection,courseid );

			int tasksInCourse=st.executeQuery("select count(*) from "+courseid+"Details").getInt(1);
			
			String buttonStatus="";

			if(tasksInCourse<=0)
			{
			buttonStatus="disabled";
			}

			 %>


									<input type="hidden" name="userid" value="<%= userid%>">
									<input type="hidden" name="course"
										value="<%=rsFinished.getString(1)%>">
									<button type="submit" value="viewPerformance" name="source"
										<%=buttonStatus %>>View Activities</button>
								</form>
							</td>
						</tr>
						<% j++;} 

connection.close();

%>

					</table>
				</fieldset>
			</div>
		</fieldset>
	</div>

</body>
</html>








