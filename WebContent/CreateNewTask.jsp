<%@page import="javax.swing.JOptionPane"%>
<%@page import="Classes.SqliteConnectionThread"%>
<%@page import="Classes.UserGuiDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Creating new task</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />


<% String userid=request.getParameter("userid");
   String course=request.getParameter("course");
   String no=request.getParameter("no");
   String newOrUpdate=request.getParameter("update");
   
   if(request.getParameter("update")==null)
   {
	   newOrUpdate="new";
   }
   
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

 	UserGuiDB.createCourseListTable(connection, course);
 	
 	Statement st=connection.createStatement();
 	int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

 	
 ResultSet rsInitial=st.executeQuery("select instructor,course from courses where courseId='"+course+"'");
 String instructor=rsInitial.getString(1);
 String courseName=rsInitial.getString(2);
 
 
 if(userid.equalsIgnoreCase(instructor)==false)
 {
	request.getRequestDispatcher("HomeLogin.jsp").forward(request,response); 
 }

 int taskNumber=0;
 if(no==null)
 { 
taskNumber=st.executeQuery("select count(task) from '"+course+"Details'").getInt(1);
	taskNumber++; 
 
 }
 else
 {
	 taskNumber=Integer.parseInt(no);
 }
 %>
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
		<form method="post" action="HomeLogin"
			style="padding-left: 20px; padding-bottom: 20px;">
			<h3 style="color: #b70a01; text-align: right">
				<span><a href="Faculty.jsp?userid=<%= userid%>">Faculty
						Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="AccountSettings.jsp?userid=<%= userid%>">Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
				<span><a href="FacultyCourseList.jsp?userid=<%= userid%>">Course
						List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp; <span><a
					href="FacultyPaymentsList.jsp?userid=<%= userid%>">Payments</a></span>
		</form>
	</div>
	${error}${notification}

	<form action="ClassTasks" method="post">
		<div style="padding-left: 150px; padding-right: 150px;">
			<input type="hidden" name="userid" value=<%=userid %>> <input
				type="hidden" name="course" value=<%=course %>> <input
				type="hidden" name="taskNumber" value=<%=taskNumber%>>

			<fieldset>
				<%
String taskLegend="";
String buttonName="";
String buttonValue="";

String details="";
String date="";
String time="";
String marks="";
String editNotification="";
if(newOrUpdate.equalsIgnoreCase("new"))
{
	taskLegend="Add new Task to "+course;
	buttonName="Post a Task";
	buttonValue="postTask";
}
else
{
	taskLegend="Edit Task"+(taskNumber)+" of "+course;
	buttonName="Update this Task";
	buttonValue="updateTask";
	editNotification="* Delete Last Edited Date : ' TIME STAMP ' in task details";	
	ResultSet rs=st.executeQuery("select * from "+course+"Details where task='Task"+(taskNumber)+"'");
	details=rs.getString(2);
	date=rs.getString(4);
	marks=rs.getString(5);

}	
	
%>


				<legend>
					<h3><%=taskLegend%></h3>
				</legend>
				<h3 align="center" style="color: #b20023;">
					<%=courseName %></h3>
				<h4>
					Task Title : <input type="text" name="taskName"
						placeholder="task title" value="Task<%=taskNumber%>" required
						readonly>
				</h4>
				<h4>Task Details :</h4>
				<p>
					<textarea rows="5" cols="100" maxlength="350" required
						name="taskDetails"><%=details %></textarea>
				</p>
				<p style="color: #b20023;"><%=editNotification %></p>
				<h4>
					Last Date :<input type="datetime-local" name="lastDate"
						value=<%=date %> required>
				</h4>
				( make sure last date should be greater than today)
				<h4>
					Max Marks : <input type="number" name="maxMarks" min="10" max="100"
						value=<%=marks %> required>
				</h4>



				<button style="color: white; background-color: #378fa1;"
					type="submit" name="source" value=<%=buttonValue %>>
					<%=buttonName %>
				</button>

			</fieldset>
		</div>
	</form>

	<%connection.close(); %>

</body>
</html>