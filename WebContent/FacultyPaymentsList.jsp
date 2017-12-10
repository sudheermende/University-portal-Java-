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
String sql="Select * from '"+userid+"Payments'";
Statement st=connection.createStatement();
int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

ResultSet rs=st.executeQuery(sql);

%>
<title>Faculty : <%=userid%> Payments List
</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

</head>
<body>

	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> faculty </sub>
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
						<th>Amount</th>
						<th>Added date</th>
						<th>Payment type</th>
						<th>Card number</th>
						<th>Paid Date</th>
						<th>Paid amount</th>
						<th>Due amount</th>
					</tr>
					<%
int i=1;
while(rs.next())
{
%>
					<tr>
						<td><%=i	 %></td>
						<td><font size="2"><%=rs.getString(1)%></font></td>
						<td><font size="2"><%="$ "+rs.getString(2)%></font></td>
						<td><font size="2"><%=rs.getString(4)%></font></td>
						<td><font size="2"><%=rs.getString(5)%></font></td>
						<td><font size="2">
								<%
			if(rs.getString(7).length()==16){
				out.println("************"+rs.getString(7).substring(12));}%>
						</font></td>
						<td><font size="2"><%=rs.getString(10)%></font></td>
						<td><font size="2" color="#b70a01"><%="- $ "+rs.getString(8)%></font></td>
						<td><font size="2" color="#b70a01"><%="$ "+rs.getString(9)%></font></td>
					</tr>
					<%
i++;
}
rs.close();
st.close();
double money=UserGuiDB.getTotalMoney(connection,userid,"student");
connection.close();
st.closeOnCompletion();

%>
					<tr>
						<td colspan=8 align="right" style="padding-right: 30px">Total
							Amount Due :</td>
						<td><%="$ "+money %></td>
					</tr>
				</table>
				<br>
			</form>
		</fieldset>
	</div>


</body>
</html>