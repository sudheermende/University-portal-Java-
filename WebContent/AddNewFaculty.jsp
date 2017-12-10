<%@page import="org.omg.PortableInterceptor.INACTIVE"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="Classes.SqliteConnectionThread"%>
<%@page import="Classes.UserGuiDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%><%@ page language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding new faculty</title>
</head>
<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> admin </sub>
	</h1>
	<div style="padding-left: 60px; padding-right: 60px;">

		<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />


		<%
String userid=(request.getParameter("userid")).toLowerCase();

//JOptionPane.showMessageDialog(null, name.toString());

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


		<form method="post" action=" ">
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
				<span><a
					href="UniversityPaymentsList.jsp?userid=<%= userid%>">Financial
						Issues</a></span>
			</h3>
		</form>
		${notification}${error}
		<fieldset>
			<legend>
				<h3>Adding a new Faculty</h3>
			</legend>
			<form method="post" action="AddingNewMembers"
				style="padding-left: 20px; padding-right: 20px; padding-bottom: 20px;">

				<h4>Enter details</h4>
				User
				name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input size="16" type="text" name="newFaculty"
					placeholder="faculty name" required><br>
				<br>

				email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input size="16" type="email" name="email" placeholder="email"
					required value=${email} ><br>
				<br>

				phone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input size="16" type="tel" name="cell" placeholder="cell" required
					value=${cell}><br>
				<br> Date of
				birth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input
					type="date" name="dob" required value=${dob} ><br>
				<br> Level of study &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <select
					name="level">
					<option value="undergraduate">undergraduate</option>
					<option value="graduate">graduate</option>
					<option value="masters">masters</option>
					<option value="Phd">PHD</option>
				</select> <br>
				<br> Department
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <select
					name="department">

					<option value="Computer Science">computer science</option>
					<option value="Electronics">electronics</option>
					<option value="Communications">communications</option>
					<option value="Civil">civil</option>
					<option value="Mechanical">mechanical</option>
					<option value="Automobile">automobile</option>
					<option value="Business Management">business management</option>
				</select> <br>
				<br> Security Question : <font color="#b70a01">What was
					your high school name?</font><br>
				<br>

				answer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="password" name="answer" size="16" placeholder="answer"
					required title="minimum 7 characters" required value=${answer} ><br>
				<br>

				password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
				<input type="password" name="password" size="16" pattern=".{7,}"
					required title="minimum 7 characters" placeholder="password"
					required value=${password}><br>
				<br> confirm password&nbsp;&nbsp;&nbsp;: <input type="password"
					name="confirmpassword" size="16" pattern=".{7,}"
					placeholder="re-password" required value=${confirmpassword} ><br>
				<br> <input type="hidden" name="userid" value=<%=userid %>>
				<button style="color: white; background-color: #378fa1"
					type="submit" name="source" value="AddFaculty">Add faculty</button>
				<br>
				<br>
			</form>
		</fieldset>
	</div>
	<%connection.close(); %>
</body>
</html>