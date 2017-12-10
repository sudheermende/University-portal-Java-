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
</head>

<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> admin </sub>
	</h1>
	<div style="padding-left: 60px; padding-right: 60px;">

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



%>
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
			<span><a href="UniversityPaymentsList.jsp?userid=<%= userid%>">Financial
					Issues</a></span>
		</h3>

		${notification} <br>
		<fieldset>
			<legend>
				<h3>Department List</h3>
			</legend>
			<div
				style="padding-left: 30px; padding-right: 30px; padding-bottom: 20px;">
				<h4 align="right">
					<a href="AddNewDept.jsp?userid=<%=userid%>">Add new Department</a>
				</h4>

				<form method="post" action="ViewDeptList">
					<input type="hidden" name="userid" value=<%=userid %>>
					<table align="center" border="1" width="100%">
						<tr style="background: #3a94a8; color: white;">
							<th>No</th>
							<th>Department name</th>
							<th>no.of courses in department</th>
							<th>action</th>
						</tr>
						<% 

ResultSet rs=UserGuiDB.getDepartmentListFromDB(connection);

int i=1;
while(rs.next())
{
%>
						<tr>
							<td style="padding-left: 20px;"><font size="3" color="black"><%=i%></font></td>
							<td style="padding-left: 20px;"><font size="3" color="black"><%=rs.getString(1)%></font></td>
							<td style="padding-left: 20px;"><font size="3" color="black"><%=rs.getString(2)%></font></td>
							<td style="padding-left: 20px;">
								<button style="color: white; background-color: #378fa1"
									type="submit" value="<%=rs.getString(1)%>" name="source">view
									all classes in dept</button>
							</td>
						</tr>
						<% i++;
} 


%>

					</table>
				</form>
			</div>
		</fieldset>

	</div>

</body>
<%connection.close(); %>
</html>