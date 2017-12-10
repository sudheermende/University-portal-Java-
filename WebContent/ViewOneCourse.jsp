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
<title>view ${course}</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

</head>
<%
String userid=request.getParameter("userid");
String course=request.getParameter("course");

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

String position=st.executeQuery("select position from users where username='"+userid+"'").getString(1);

int tasksInCourse=st.executeQuery("select count(*) from "+course+"Details").getInt(1);

String instructor=st.executeQuery("select instructor from courses where courseId='"+course+"'").getString(1);
 


String sql="select * from courses where courseid='"+course+"'";
ResultSet rs=st.executeQuery(sql);



%>

<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub>&nbsp;<%= position %></sub>
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
			<a href="<%=url %>">&lt&lt &nbsp back</a>
		</h4>
	</div>

	<div
		style="padding-left: 80px; padding-right: 80px; padding-bottom: 40px;">
		<fieldset>
			<legend>
				<h3><%= rs.getString(1) %>
					Course details
				</h3>
			</legend>
			<div
				style="padding-left: 30x; padding-right: 30px; padding-bottom: 30px;">
				<h3 align="center"><%=rs.getString(1)%></h3>
				<p>
					Course Id :
					<%= course %></p>
				<p>
					Department :
					<%= rs.getString(3)%></p>
				<p>
					Credits :
					<%= rs.getString(4)%></p>
				<p>
					Pre Reqs :
					<%= rs.getString(5) %></p>
				<p>
					Room number :
					<%= rs.getString(8) %></p>
				<p>
					Class capacity :
					<%= rs.getString(9)%></p>

				<p>
					Enrolled Students :
					<%= rs.getString(10) %></p>
				<p>
					Level :
					<%= rs.getString(12)%></p>
				<p>
					Faculty Name :
					<%= rs.getString(6)%></p>
				<p>
					Cost :
					<%= rs.getString(13) %></p>

				<% 

String gradingStatus=rs.getString("grading");
String studentsListLink="";
String changeFaculty="";
String classTask="";
String addTask="";
String allowReGrade="";

request.setAttribute("position","working position");
String url2="StudentsListInCourse.jsp?course="+course+"&userid="+userid+"&position="+position;
String url3="ChangeFaculty.jsp?course="+course+"&userid="+userid+"&position="+position;
String url4="ClassTasks.jsp?userid="+userid+"&course="+course;
String url5="CreateNewTask.jsp?userid="+userid+"&course="+course;


if((position.equalsIgnoreCase("admin")||   ((position.equalsIgnoreCase("faculty"))) &&  (userid.equalsIgnoreCase(instructor)) ) )
{

	
	if((rs.getInt(10))>0)
	{
	studentsListLink="<a href='"+url2+"'> click here to view Students List </a>"+"&nbsp;&nbsp;|&nbsp;&nbsp; ";   
	}
	
	
	
	if(position.equalsIgnoreCase("admin"))
	{
		
		changeFaculty="<a href='"+url3+"'>  Edit Course </a>"+"&nbsp;&nbsp;|&nbsp;&nbsp; ";
			
		allowReGrade="<button type='sumbit' name='source' value='changeGradingStatus' > change Status </button>";

		if((tasksInCourse>0)){
		classTask="<a href='"+url4+"'> View Tasks </a>"+"&nbsp;&nbsp;|&nbsp;&nbsp; "; 
		}
	}	
	
	
	if(( (position.equalsIgnoreCase("faculty")) && (userid.equalsIgnoreCase(instructor)) )  )
	{
		
		if((tasksInCourse>0)){
		classTask="<a href='"+url4+"'> View Tasks </a>"+"&nbsp;&nbsp;|&nbsp;&nbsp; "; 
		}
		
		if(gradingStatus.equalsIgnoreCase("pending"))
		{
	addTask="<a href='"+url5+"'> Add new Tasks </a>"+"&nbsp;&nbsp;|&nbsp;&nbsp; ";
		}
		
	}
	
	
	
}



%>

				<form action="UpdateTasks" method="post">
					<input type="hidden" name="userid" value=<%=userid %>> <input
						type="hidden" name="course" value=<%=course %>> <input
						type="hidden" name="status" value=<%=rs.getString("grading")%>>
					<p>
						Grading :
						<%= rs.getString("grading") %>
						&nbsp;&nbsp;&nbsp;
						<%=allowReGrade %></p>
					<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="4px"><%=studentsListLink %><%=changeFaculty %><%=classTask %>
						<%=addTask %><a href="<%=url %>"> Back</a></font>
				</form>


			</div>
		</fieldset>
	</div>

	<%connection.close(); %>
</body>
</html>