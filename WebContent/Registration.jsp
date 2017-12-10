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
<title>Course Registration</title>

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

ResultSet rs=UserGuiDB.getCourseListFromDB(connection);
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
		<div method="post" action="HomeLogin"
			style="padding-left: 20px; padding-bottom: 20px;">
			<h3 style="color: #b70a01; text-align: right">
				<span><a href="Student.jsp?userid=<%= userid%>">Student
						Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="AccountSettings.jsp?userid=<%= userid%>">Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="Registration.jsp?userid=<%= userid%>">Registration</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="StudentCourseList.jsp?userid=<%= userid%> ">My
						Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="PaymentsList.jsp?userid=<%= userid%>">Financial issues</a></span>
			</h3>
		</div>
	</div>

	<div
		style="padding-left: 80px; padding-right: 80px; padding-right: 80px;">
		<font color="#b70a01" text-align="center">${error }</font> <br>
		<fieldset>
			<legend>
				<h3>Course Registration</h3>
			</legend>
			<div
				style="padding-left: 30px; padding-right: 30px; padding-top: 30px;">

				<%ResultSet rsTemp=UserGuiDB.getTempTable(connection, userid); 
//JOptionPane.showMessageDialog(null, userid);
%>

				<form action="registration" method="post">
					<fieldset>
						<legend> Course Cart</legend>

						<input type="hidden" name="userid" value="<%= userid%>">

						<table align="center" border="1" width="100%">
							<!-- <tr style="background:#3a94a8; color:white;"><th>course name</th><th>course id</th><th>Department</th><th>pre course</th><th>instructor</th><th>credits</th><th>capacity</th>
<th>Enrolled no. students</th><th>level</th><th>action</th></tr>
 -->

							<tr style="background: #3a94a8; color: white;">
								<th>S.no</th>
								<th>course id</th>
								<th>action</th>
							</tr>

							<%
int i=1;
while(rsTemp.next()) 
{ 
%>
							<tr>
								<td><%=i %></td>
								<td><font size="2" color="black"><%=rsTemp.getString(1)%></font></td>

								<td>
									<button type="submit" value="<%= rsTemp.getString(1)%>"
										name="dropCourse">Drop</button>
								</td>
							</tr>

							<%
i++;
}
rsTemp.close();
%>
						</table>
						<br> <input type=hidden name="tableSize" value <%=i %>>
						<button type="submit" value="<%= userid%>" name="checkOut"
							style="float: right; color: white; background-color: #378fa1"">proceed
							to check out</button>

					</fieldset>

					<h4>Add courses to the cart from list below</h4>

					<fieldset>
						<legend> List of courses </legend>
						<input type="hidden" name="userid" value="<%= userid%>"> <input
							type="hidden" name="position" value="student">


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
								<th>available</th>
								<th>level</th>
								<th>action</th>
							</tr>



							<%
int j=1;
while(rs.next())
{
 %>
							<tr>
								<td><%=j %></td>
								<td><font size="2" color="black"><%=rs.getString(1)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(2)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(3)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(5)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(6)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(4)%></font></td>
								<td><font size="2" color="black"><%=rs.getString(9)%></font></td>
								<td><font size="2" color="black"><%=Integer.parseInt(rs.getString(9))-Integer.parseInt(rs.getString(10))%></font></td>
								<td><font size="2" color="black"><%=rs.getString(12)%></font></td>
								<td>
									<button type="submit"
										style="color: white; background-color: #378fa1"
										value="<%= rs.getString(2)%>" name="addCourse">Add</button> |
									<button type="submit"
										style="color: white; background-color: #378fa1"
										value="<%= rs.getString(2)%>" name="viewCourse">View</button>
								</td>
							</tr>
							<% j++;
}
rs.close();
connection.close();
%>
						</table>
					</fieldset>

				</form>
			</div>
		</fieldset>
	</div>
</body>
</html>