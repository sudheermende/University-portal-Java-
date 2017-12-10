<%@page import="javax.swing.JOptionPane"%>
<%@page import="Classes.SqliteConnectionThread"%>
<%@page import="Classes.UserGuiDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%String userid=request.getParameter("userid"); %>
<title>${userid}Payment</title>

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

ResultSet rs=UserGuiDB.getUserFromDB(connection, userid);
%>

<body>

	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> student </sub>
	</h1>
	<div style="padding-left: 80px; padding-right: 80px;">
		<form method="post" action="HomeLogin">
			<h3 style="color: #378fa1; text-align: right;">
				Hello &nbsp;&nbsp;${userid}
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %></a>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="HomeLogin.jsp">Logout</a>
			</h3>
		</form>
		<form
			style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">
			<h3 style="color: #b70a01; text-align: right">
				<span><a href="Student.jsp?userid=${userid}">Student Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="AccountSettings.jsp?userid=${userid}">Account
						Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="Registration.jsp?userid=${userid}">Registration</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="StudentCourseList.jsp?userid=${userid} ">My
						Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="PaymentsList.jsp?userid=${userid}">Financial issues</a></span>
			</h3>
		</form>
	</div>

	<form action="Payment" method="post">
		<div
			style="padding-left: 80px; padding-right: 80px; padding-bottom: 40px;">
			<fieldset">
				<legend>
					<h4>Payment</h4>
				</legend>
				<br>
				<div
					style="padding-left: 50px; padding-right: 50px; padding-bottom: 30px;">
					<nav id="bold"> Paying in the credit of : ${userid} <br>
					<br>
					Student Id &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;:<%=rs.getString(15) %> <%connection.close();%> <br>
					<br>
					Amount &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
						name="amount" value=${amount } required readonly> <br>
					<br>

					Card number &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text"
						name="cardNumber" pattern="[0-9999999999999999]{16}"
						title="card number must be 16 numbers only" maxlength="16"
						size="16" required> <br>
					<br>
					Name on card &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
						name="nameOnCard" required> <br>
					<br>
					CVV &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
						type="text" name="cvv" pattern="[0-999]{3}"
						title="cvv must be 3 numbers only" maxlength="3" size="3" required>
					<br>
					<br>
					<h4>Billing Address</h4>

					Address &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="address" required>
					<br>
					<br>
					City &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="text" name="city" required> <br>
					<br>
					State &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
						name="state" required> <br>
					<br>
					Country
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;<input type="text" name="country" required>
					<br>
					<br>
					ZIP
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
						name="zip" required> <br>
					<br>
					</nav>
					<br>
					<br> <input type="hidden" name="userid" value="${userid}">
					<input style="color: white; background-color: #378fa1"
						type="submit" name="pay" value="   pay  	  ">
				</div>
			</fieldset>
		</div>

	</form>
	<%connection.close(); %>
</body>
</html>