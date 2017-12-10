<%@page import="java.util.LinkedList"%>
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
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />


<% 
	String userid=request.getParameter("userid");
    String course=request.getParameter("course");

    int taskPage=0;
   	
  	if(request.getParameter("no")!=null)
   	{
  		taskPage=Integer.parseInt(request.getParameter("no"));
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

  	String position=st.executeQuery("select position from users where username='"+userid+"'").getString(1);
  String courseCheck="select instructor from courses where courseId='"+course+"'";	
  String instructor=st.executeQuery(courseCheck).getString(1);
  
  
  
  if(position.equalsIgnoreCase("faculty")  || position.equalsIgnoreCase("admin") || position.equalsIgnoreCase("applicant") )
	{
	request.getRequestDispatcher("HomeLogin.jsp").forward(request,response);
	}

 

  
%>
<title><%=course %> task view</title>

<style>
ul.pagination {
	display: inline-block;
	padding: 0;
	margin: 0;
}

ul.pagination li {
	display: inline;
}

ul.pagination li a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
	border-radius: 5px;
}

ul.pagination li a.active {
	background-color: #378fa1;
	color: white;
	border: 1px solid #4CAF50;
	border-radius: 5px;
}

ul.pagination li a:hover:not (.active ) {
	background-color: #ddd;
}
</style>



</head>

<% 

String menu="";
String editButton="";
String readOnly="readonly";


%>

<h1 style="color: #b70a01;">
	&nbsp;&nbsp;S University<sub><%=position %></sub>
</h1>
<div style="padding-left: 80px; padding-right: 80px;">
	<form method="post" action="HomeLogin">
		<h3 style="color: #378fa1; text-align: right;">
			Hello &nbsp;&nbsp;<%= userid%>
			&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="Messages.jsp?userid=<%=userid%>"> Messages<%out.print(" ( "+ msgCount+" )"); %></a>
			&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="HomeLogin.jsp">Logout</a>
		</h3>
	</form>

	<form method="post" action="HomeLogin"
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
	</form>

</div>

<div style="padding-left: 80px; padding-right: 80px;">
	${error}${notification} <br>
	<%

ResultSet rsTasks=st.executeQuery("select * from "+course+"Details");
%>

	<ul class="pagination">

		<% 

String url="StudentActivities.jsp?userid="+userid+"&course="+course+"";

int i=0;
while(rsTasks.next())
{
	String active="";
	if(i==taskPage)
	{
		active="class='active'";
	}
%>
		<li><a <%=active %> href="<%=url%>&no=<%=i%>"> <%=rsTasks.getString("task")%>
		</a></li>

		<%
i++;} 
%>
	</ul>



	<fieldset>
		<legend>
			<h3>
				<%=course %>
				activities
			</h3>
		</legend>
		<%

String courseName=st.executeQuery("select course from courses where courseId='"+course+"'").getString(1); 
String gradingStatus=st.executeQuery("select grading from courses where courseId='"+course+"'").getString(1);


%>

		<h3 align="center" style="color: #b70a01;">
			<%=courseName %>
		</h3>
		<h4 align="center">
			Grading status :<%=gradingStatus %></h4>
		<h4>
			Task
			<%=taskPage+1%></h4>



		<form action="ClassTasks" method="post">

			<%

ResultSet rsDetails=st.executeQuery("select * from "+course+"Details where task='Task"+(taskPage+1)+"'");

String taskDetails=rsDetails.getString("details");
%>

			<h4>Details :</h4>
			<textarea rows="8" cols="100" readonly><%=taskDetails %></textarea>

			<%  int maxMarks=rsDetails.getInt(5); %>
			<h4>
				Max Marks :
				<%=rsDetails.getInt(5) %></h4>


			<p style="color: #b20023";>
				Posted Date :
				<%=rsDetails.getString(3)%>
				<br>
				<br> Last Submission Date (yyyy/mm/dd hh:mm ):
				<%=rsDetails.getString(4)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


			</p>

		</form>
	</fieldset>
</div>
<br>
<div
	style="padding-left: 80px; padding-right: 80px; padding-bottom: 30px;">
	<fieldset>
		<legend>
			<h4>
				Work on your Task
				<%=taskPage+1%></h4>
		</legend>
		<br>

		<%

String answer="";
String marks="";
String buttonStatus="";
String readOnly2="";
String answeredDate="";

String editable="";
String submitButtonType="submitAnswer";
String allowUpdate="";

int answeredOrNot=st.executeQuery("select count(answer) from MarksList where studentName='"+userid+"' and courseId='"+course+"' and task='Task"+(taskPage+1)+"'").getInt(1);


if(answeredOrNot>0)
{

String	sql="select * from MarksList where studentName='"+userid+"' and courseId='"+course+"' and task='Task"+(taskPage+1)+"'";
	
	
	
	ResultSet rsStudentTask=st.executeQuery(sql);
	answer=rsStudentTask.getString("answer");
	marks=rsStudentTask.getString("scoredMarks");
	buttonStatus="disabled";
	readOnly2="readonly";
	answeredDate="Submitted date : "+rsStudentTask.getString("submittedDate");

	editable=rsStudentTask.getString("editable");
	submitButtonType="submitAnswer";
	allowUpdate="";

	if(answer==null )
	{
		answer="";
		marks="";
		buttonStatus="";
		readOnly2="";
		answeredDate="";
	}

	if(editable.equalsIgnoreCase("true") )
	{
		marks="";
		buttonStatus="";
		readOnly2="";
		answeredDate="";
		submitButtonType="updateAnswer";
		allowUpdate="you are allowed to Update your answer now!";
	}

	
	
}



if(gradingStatus.equalsIgnoreCase("finished"))
{
	readOnly2="readonly";
	buttonStatus="disabled";
}

%>
		<h4 align="center"><%=allowUpdate %></h4>
		<form action="UpdateTasks" method="post">
			<h4>
				Task
				<%=taskPage+1 %>
				Answer :
			</h4>
			<div style="padding-left: 80px; padding-right: 80px;">
				<textarea rows="10" cols="70" name="answer"
					placeholder="your answer here" required <%=readOnly2 %>><%=answer %></textarea>
			</div>


			<h4>
				Max Marks &nbsp;:<%=maxMarks %><br> Your Marks :<%=marks %>
			</h4>

			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			<input type="hidden" name="userid" value=<%=userid %>> <input
				type="hidden" name="course" value=<%=course %>> <input
				type="hidden" name="taskNumber" value=<%=taskPage+1 %>> <input
				type="hidden" name="maxMarks" value=<%=maxMarks %>>

			<button type="submit" name="source" value="<%=submitButtonType%>"
				<%=buttonStatus %>>
				submit answer as
				<%=userid %></button>

			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=answeredDate %><br> <br>
			<br>
		</form>
	</fieldset>
</div>

<body>
	<%connection.close(); %>
</body>
</html>