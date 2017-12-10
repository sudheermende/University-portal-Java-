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
<title>Faculty Course List</title>

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
String sql="Select * from courses where instructor='"+userid+"'";
Statement st=connection.createStatement();

int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);


ResultSet rs=st.executeQuery(sql);
%>

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
		<form style="padding-left: 20px; padding-bottom: 20px;">
			<h3 style="color: #b70a01; text-align: right">
				<span><a href="Faculty.jsp?userid=<%= userid%>">Faculty
						Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="AccountSettings.jsp?userid=<%= userid%>">Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="FacultyCourseList.jsp?userid=<%= userid%>">My
						Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="FacultyPaymentsList.jsp?userid=<%= userid%>">Payments</a></span>
		</form>
	</div>


	<div style="padding-left: 80px; padding-right: 80px;">

		<fieldset>
			<legend>
				<h3>Course List</h3>
			</legend>

			<div style="padding-left: 80px; padding-right: 80px;">


				<fieldset>
					<legend>
						<h3>My Course List</h3>
					</legend>
					<h3 align="center">
						Classes by
						<%=userid%>
					</h3>
					<div
						style="padding-left: 30px; padding-right: 30px; padding-bottom: 30px; padding-top: 5px;">
						<form method="post" action="registration">
							<input type="hidden" name="userid" value="<%=userid%>"> <input
								type="hidden" name="position" value="faculty">

							<table align="center" border="1" width="100%">
								<tr style="background: #3a94a8; color: white;">
									<th>S.no</th>
									<th>Course name</th>
									<th>Course id</th>
									<th>Department</th>
									<th>Grading</th>
									<th>Time</th>
									<th>Action</th>
								</tr>
								<%
int i=1;
while(rs.next())
{
%>
								<tr>
									<td><%=i %></td>
									<td><font size="2"><%=rs.getString(1)%></font></td>
									<td><font size="2"><%=rs.getString(2)%></font></td>
									<td><font size="2"><%=rs.getString(3)%></font></td>
									<td><font size="2"><%=rs.getString("grading")%></font></td>
									<td><font size="2" color="black"><%=rs.getString(7)%></font></td>
									<td style="padding-left: 20px;"><input type="hidden"
										name="userid" value="<%= userid%>">


										<button type="submit" value="<%=rs.getString(2)%>"
											name="viewCourse">View course</button></td>
								</tr>
								<% i++; }
rs.close();
%>

							</table>
						</form>
					</div>
				</fieldset>
			</div>
			<br>

			<div style="padding-left: 80px; padding-right: 80px;">

				<form method="post" action="registration">
					<fieldset>
						<legend>
							<h3>Total Course List</h3>
						</legend>
						<div
							style="padding-left: 30px; padding-right: 30px; padding-bottom: 20px;">

							<input type="hidden" name="userid" value="<%=userid%>"> <input
								type="hidden" name="position" value="faculty">



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
									<th>level</th>
									</th>
									<th>room</th>
									<th>time</th>
									<th>action</th>
								</tr>
								<% 
ResultSet rs1=UserGuiDB.getCourseListFromDB(connection);

int j=1;
while(rs1.next())
{
%>
								<tr>
									<td><%=j %></td>
									<td><font size="2" color="black"><%=rs1.getString(1)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(2)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(3)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(5)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(6)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(4)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(9)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(10)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(12)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(8)%></font></td>
									<td><font size="2" color="black"><%=rs1.getString(7)%></font></td>
									<td>

										<button style="color: white; background-color: #378fa1"
											type="submit" value="<%=rs1.getString(2)%>" name="viewCourse">view
											course</button>
									</td>
								</tr>
								<% j++;} 
%>
							</table>
						</div>
					</fieldset>
				</form>
			</div>
		</fieldset>
	</div>
	<%
st.close();
connection.close();%>


</body>
</html>