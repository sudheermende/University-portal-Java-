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
<title>S university Admin</title>
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




%>

		<form action="post" action="HomeLogin">
			<h3 style="color: #378fa1; text-align: right;">
				Hello &nbsp;&nbsp;<%= userid%>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %>
				</a> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a href="">Logout</a>
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

		${notification} <br>
		<fieldset>
			<legend>
				<h3>Students List</h3>
			</legend>
			<div
				style="padding-left: 30px; padding-right: 30px; padding-bottom: 20px; padding-top: 20px;">

				<p>
					search student : <input name="applicantName" id="applicantName"
						type="text" placeholder="search name"
						onkeyup="showHint(this.value,'student')"> <select
						id="txtHint">
						<option>search result</option>
					</select>
					<button onclick="" type="button" id="hintOpenButton" disabled>open</button>
				</p>


				<form method="post" action="confirmAdmission">
					<input type="hidden" name="position" value="student">

					<% 
ResultSet rs=st.executeQuery("select * from users where position='student' and status='active' order by id");
%>

					<fieldset>
						<legend> Active students List</legend>
						<table align="center" border="1" width="100%">
							<tr style="background: #3a94a8; color: white;">
								<th>S.no</th>
								<th>Name</th>
								<th>Level</th>
								<th>Department</th>
								<th>Student id</th>
								<th>Email</th>
								<th>Position</th>
								<th>Action</th>
							</tr>

							<%
int i=1;
while(rs.next())
{
%>
							<tr>
								<td><%=i %></td>
								<td><font size="2" color="black"><%=rs.getString(1)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(13)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(14)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(15)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(10)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(12)%></font></td>
								<td style="padding-left: 20px;"><input type="hidden"
									name="userid" value="<%= request.getParameter("userid")%>">
									<button style="color: white; background-color: #378fa1"
										type="submit" value="<%=rs.getString(1)%>" name="view">View
										Details</button></td>
							</tr>
							<% i++;} 
%>
						</table>
					</fieldset>
					<br>
					<br>

					<fieldset>
						<legend> Blocked students List</legend>
						<table align="center" border="1" width="100%">
							<tr style="background: #3a94a8; color: white;">
								<th>S.no</th>
								<th>Name</th>
								<th>Level</th>
								<th>Department</th>
								<th>Student id</th>
								<th>Email</th>
								<th>Position</th>
								<th>Action</th>
							</tr>

							<%
ResultSet rsBlocked=st.executeQuery("select * from users where position='student' and status='blocked'");

int j=1;
while(rsBlocked.next())
{
%>
							<tr>
								<td><%=j %></td>
								<td><font size="2" color="black"><%=rsBlocked.getString(1)%></font></td>
								<td><font size="2" color="black"><%=rsBlocked.getString(13)%></font></td>
								<td><font size="2" color="black"><%=rsBlocked.getString(14)%></font></td>
								<td><font size="2" color="black"><%=rsBlocked.getString(15)%></font></td>
								<td><font size="2" color="black"><%=rsBlocked.getString(10)%></font></td>
								<td><font size="2" color="black"><%=rsBlocked.getString(12)%></font></td>
								<td style="padding-left: 20px;"><input type="hidden"
									name="userid" value="<%= request.getParameter("userid")%>">
									<button style="color: white; background-color: #378fa1"
										type="submit" value="<%=rsBlocked.getString(1)%>" name="view">View
										Details</button></td>
							</tr>
							<% j++;} 
%>
						</table>
					</fieldset>


				</form>
			</div>
		</fieldset>


	</div>

</body>
<%connection.close(); %>
</html>