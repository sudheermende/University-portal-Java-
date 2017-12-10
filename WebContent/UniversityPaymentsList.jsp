<%@page import="Classes.EncriptedFormat"%>
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
<%String userid=request.getParameter("userid"); %>
<title><%=userid %> Financial details</title>

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

String sql="select * from universityPayments";
ResultSet rs=st.executeQuery(sql);


%>

	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> admin </sub>
	</h1>
	<div style="padding-left: 60px; padding-right: 60px;">

		<form method="post" action="HomeLogin">
			<h3 style="color: #378fa1; text-align: right;">
				Hello &nbsp;&nbsp;<%= userid%>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %></a>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="HomeLogin.jsp">Logout</a>
			</h3>
		</form>
		<form>
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
	${error}
	<br>
	<div style="padding-left: 80px; padding-right: 80px;">
		<fieldset>
			<legend>
				<h3>Payments History</h3>
			</legend>
			<form action="Payment" method="get"
				style="padding-left: 30px; padding-right: 30px; padding-top: 30px; padding-bottom: 30px;">

				<input type="hidden" name="userid" value=<%=userid%>>

				<table align="center" border="1" width="100%">
					<tr style="background: #3a94a8; color: white;">
						<th>S.no.</th>
						<th>Task</th>
						<th>Status</th>
						<th>Paid date</th>
						<th>Payment type</th>
						<th>Card number</th>
						<th>Amount Out</th>
						<th>Amount In</th>
					</tr>
					<%
int i=1;
while(rs.next())
{
%>
					<tr>
						<td><%=i	 %></td>
						<td><font size="2"><%=rs.getString(1)%></font></td>
						<td><font size="2"><%=rs.getString(2)%></font></td>
						<td><font size="2"><%=rs.getString(3)%></font></td>
						<td><font size="2"><%=rs.getString(4)%></font></td>
						<td><font size="2"><%="************"+rs.getString(6).substring(12)%></font></td>
						<td><font size="2" color="#b70a01"><%="- $ "+rs.getString(9)%></font></td>
						<td><font size="2" color="#b70a01"><%="$ "+rs.getString(8)%></font></td>
					</tr>
					<%
i++;
}
rs.close();
st.close();
double money=UserGuiDB.getTotalMoney(connection,"university","admin");
connection.close();
st.closeOnCompletion();
%>
					<tr>
						<td colspan=7 align="right" style="padding-right: 30px">Total
							Amount :</td>
						<td><%="$ "+money %></td>
					</tr>
				</table>

			</form>
		</fieldset>
	</div>
</body>
</html>