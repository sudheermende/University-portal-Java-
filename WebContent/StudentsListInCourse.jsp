<%@page import="javax.swing.JOptionPane"%>
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
<% String courseid=request.getParameter("course"); 
	String userid=request.getParameter("userid");
	String position=request.getParameter("position");
	
%>
<title><%=courseid%> students list</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

</head>
<body>

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

String sql1="select course from courses where courseid='"+courseid+"'";
String course=(st.executeQuery(sql1).getString("course"));

int tasksInCourse=st.executeQuery("select count(*) from "+courseid+"Details").getInt(1);


String sql="select '"+courseid+"List'.*,users.id from '"+courseid+"List' , users where '"+courseid+"List'.studentName=users.username" ;
ResultSet rs=st.executeQuery(sql);

%>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub>&nbsp;<%=position %></sub>
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


		<%

String url;
if(position.equalsIgnoreCase("student"))
{ 
	url="Registration.jsp?userid="+userid;
}
else if(position.equalsIgnoreCase("applicant"))
{ 
	url="Applicant.jsp?userid="+userid;
} else if(position.equalsIgnoreCase("faculty"))
{ 
	url="FacultyCourseList.jsp?userid="+userid;
} else if(position.equalsIgnoreCase("admin"))
{ 
	url="CourseList.jsp?userid="+userid;
}

else
	url="HomeLogin.jsp";


%>




		<h4 style="text-align: right;";>
			<a href="<%=url%>">&lt&lt &nbsp back</a>
		</h4>
	</div>

	<div
		style="padding-left: 80px; padding-right: 80px; padding-bottom: 40px;">
		<fieldset>
			<legend>
				<h3>
					List of students in '
					<%=course %>
					'
				</h3>
			</legend>
			<div
				style="padding-left: 30x; padding-right: 30px; padding-bottom: 30px;">
				<h3 align="center"><%=course%></h3>
				<table align="center" border="1" width="50%">
					<tr style="background: #3a94a8; color: white;">
						<th>S.no</th>
						<th>Student name</th>
						<th>Student id</th>
						<th>Action</th>
					</tr>
					<%
int i=1;
while(rs.next())
{
%>
					<tr>
						<td align="center"><%=i %></td>
						<td align="center"><%=rs.getString(1) %></td>
						<td align="center"><%=rs.getString(2) %></td>
						<td align="center">

							<form action="ClassTasks" method="post">
								<input type="hidden" name="userid" value="<%= userid%>">
								<input type="hidden" name="student"
									value="<%= rs.getString(1)%>"> <input type="hidden"
									name="course" value="<%=courseid%>">

								<%
String buttonStatus="";

System.out.println("error 1  @116");

UserGuiDB.createCourseListTable(connection, courseid);

System.out.println("error 3 @120");

if(tasksInCourse<=0)
{
buttonStatus="disabled";
}


%>

								<button type="submit" value="viewActivities" name="source"
									<%=buttonStatus %>>View Activities</button>

							</form>

						</td>
					</tr>

					<% i++;
} %>
				</table>

			</div>
			<p align="center">* View Button will be disabled if there is no
				task in course</p>

		</fieldset>
	</div>

	<%
connection.close(); %>
</body>

</html>