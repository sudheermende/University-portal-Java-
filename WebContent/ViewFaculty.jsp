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


<% 
String userid=(request.getParameter("userid")).toLowerCase();
String faculty=request.getParameter("faculty").toLowerCase();

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


ResultSet rs=UserGuiDB.getUserFromDB(connection, faculty.toLowerCase());
%>

<title>View faculty info</title>
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
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %>
				</a> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="HomeLogin.jsp">Logout</a>
			</h3>
		</form>
		<form method="post" action="HomeLogin">
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
	</div>

	${error}${notification}

	<div style="padding-left: 80px; padding-right: 80px;">
		<fieldset>
			<legend>
				<h3>Faculty info</h3>
			</legend>
			<br>

			<nav id="image"> <%
String fileName="G:\\Masters\\Java\\Java Mars\\S_University\\WebContent\\images\\"+faculty+".jpg";
File f=null;
f=new File(fileName);
if(f.exists())
{
	fileName="images/"+faculty+".jpg";
}
else
{
	fileName="images/user.png";
}


%> <img src=<%=fileName%> alt="<%=faculty %>" title=<%=faculty %>
				style="width: 100px; height: 130px;"> </nav>




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
	<br>
	<div
		style="padding-left: 80px; padding-right: 80px; padding-bottom: 20px;">
		<fieldset>
			<legend>
				<h3>
					Classes By
					<%=faculty %></h3>
			</legend>

			<div
				style="padding-left: 30px; padding-right: 30px; padding-bottom: 20px; padding-top: 5px;">
				<form method="post" action="registration">
					<input type="hidden" name="userid" value="<%=userid%>"> <input
						type="hidden" name="position" value="admin">

					<table align="center" border="1" width="100%">
						<tr style="background: #3a94a8; color: white;">
							<th>S.no</th>
							<th>Course name</th>
							<th>Course id</th>
							<th>Department</th>
							<th>Faculty</th>
							<th>Time</th>
							<th>Action</th>
						</tr>
						<%
UserGuiDB.CreatingTablesIfNotCreated(connection,faculty,"faculty");
String sql="Select * from courses where instructor='"+faculty+"'";
ResultSet rs1=st.executeQuery(sql);

int i=1;
while(rs1.next())
{
%>
						<tr>
							<td><%=i%></td>
							<td><font size="2"><%=rs1.getString(1)%></font></td>
							<td><font size="2"><%=rs1.getString(2)%></font></td>
							<td><font size="2"><%=rs1.getString(3)%></font></td>
							<td><font size="2"><%=rs1.getString(6)%></font></td>
							<td><font size="2" color="black"><%=rs1.getString(7)%></font></td>
							<td style="padding-left: 20px;">
								<button type="submit" value="<%=rs1.getString(2)%>"
									name="viewCourse">View course</button>
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
	<%
connection.close(); %>
</body>
</html>