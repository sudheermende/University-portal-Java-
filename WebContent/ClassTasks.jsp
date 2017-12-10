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
<% 
	String userid=request.getParameter("userid");
    String course=request.getParameter("course");
   	String singleOrAll=request.getParameter("singleOrAll");
   	
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

  	Statement st=connection.createStatement();
  	int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);

  	
  	UserGuiDB.createCourseListTable(connection, course);
  	
  String position=st.executeQuery("select position from users where username='"+userid+"'").getString(1);
  String courseCheck="select instructor from courses where courseId='"+course+"'";	
  String instructor=st.executeQuery(courseCheck).getString(1);
  
  
  
  if((position.equalsIgnoreCase("faculty") && userid.equalsIgnoreCase(instructor))==false && (position.equalsIgnoreCase("admin")==false) )
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


<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />


</head>

<% 

String menu="";

String addingUrl="";

String editButton="";
String readOnly="readonly";
String editAnswerButton="";

String gradingStatus=st.executeQuery("select grading from courses where courseId='"+course+"'").getString(1);



if(position.equalsIgnoreCase("student"))
{
	menu=
			
	"<form method='post' action='HomeLogin' style='padding-left:20px; padding-bottom:20px;'>"+
	"<h3 style=' color:#b70a01; text-align: right'>"+ 
	" <span><a href='Student.jsp?userid="+userid+"'>Student Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='AccountSettings.jsp?userid="+userid+"'>Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='Registration.jsp?userid="+userid+"'>Registration</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='StudentCourseList.jsp?userid="+userid+"'>My Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='PaymentsList.jsp?userid="+userid+"'>Financial issues</a></span> </h3>"+
	"</form>";
			
}

else if(position.equalsIgnoreCase("faculty"))
{
	menu=
			
	"<form method='post' action='HomeLogin' style='padding-left:20px; padding-bottom:20px;'>"+
	"<h3 style=' color:#b70a01; text-align: right'>"+ 
	" <span><a href='Faculty.jsp?userid="+userid+"'>Faculty Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='AccountSettings.jsp?userid="+userid+"'>Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='FacultyCourseList.jsp?userid="+userid+"'>Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='FacultyPaymentsList.jsp?userid="+userid+"'>Payments</a></span> </h3>"+
	"</form>";

	
	if(userid.equalsIgnoreCase(instructor))
	{
		addingUrl=
				" <a href='CreateNewTask.jsp?userid="+userid+"&course="+course+"' > Add +>> </a> ";
		readOnly="";
				
	if(gradingStatus.equalsIgnoreCase("finished"))
	{
		addingUrl="";
		readOnly="readonly";
		
		editButton="disabled";	
		editAnswerButton="disabled";	
	}
	
	}
	else
	{
		editButton="disabled";
		
	}
}

if(position.equalsIgnoreCase("admin"))
{
	menu=
			
	"<form method='post' action='HomeLogin' style='padding-left:20px; padding-bottom:20px;'>"+
	"<h3 style=' color:#b70a01; text-align: right'>"+ 
	"<span><a href='Admin.jsp?userid="+userid+"'>Admin Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='AccountSettings.jsp?userid="+userid+"'>Account Setting</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='ApplicantsList.jsp?userid="+userid+"'>Applicant List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+		
	"<span><a href='StudentsList.jsp?userid="+userid+"'>Student List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='FacultyList.jsp?userid="+userid+"'>Faculty List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='CourseList.jsp?userid="+userid+"'>Course List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='DepartmentList.jsp?userid="+userid+"'>Department List</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
	"<span><a href='UniversityPaymentsList.jsp?userid="+userid+"'>Financial Issues</a></span>"+
			
			"</h3></form>";
	editButton="disabled";
	
}

%>

<h1 style="color: #b70a01;">
	&nbsp;&nbsp;S University<sub><%=position %></sub>
</h1>
<div style="padding-left: 80px; padding-right: 80px;">
	<form method="post" action="HomeLogin">
		<h3 style="color: #378fa1; text-align: right;">
			Hello &nbsp;&nbsp;<%= userid%>
			&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="Messages.jsp?userid=<%=userid%>"> Messages<%out.print(" ( "+ msgCount+" )"); %>
			</a> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="HomeLogin.jsp">Logout</a>
		</h3>
	</form>
	<%=menu %>
</div>
<div style="padding-left: 80px; padding-right: 80px;">
	${error}${notification} <br>

	<%

ResultSet rsTasks=st.executeQuery("select * from "+course+"Details");
%>

	<ul class="pagination">

		<% 

String url="ClassTasks.jsp?userid="+userid+"&course="+course+"";
if(singleOrAll!=null)
{
	url=url+"&singleOrAll="+singleOrAll+"";

}


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
		<li><%=addingUrl %></li>
	</ul>



	<fieldset>
		<legend>
			<h3>
				<%=course %>
				activities
			</h3>
		</legend>

		<%String courseName=st.executeQuery("select course from courses where courseId='"+course+"'").getString(1); %>

		<h3 align="center" style="color: #b70a01;">
			<%=courseName %>
		</h3>
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

			<h4>
				Max Marks :
				<%=rsDetails.getInt(5) %></h4>
			<% int maxMarks= rsDetails.getInt(5);%>

			<p style="color: #b20023;">
				Posted Date :
				<%=rsDetails.getString(3)%>
				<br>
				<br> Last Submission Date (yyyy/mm/dd hh:mm ):
				<%=rsDetails.getString("postedDate") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

				<input type="hidden" name="userid" value=<%=userid %>> <input
					type="hidden" name="course" value=<%=course %>> <input
					type="hidden" name="taskNumber" value=<%=taskPage+1 %>>

				<button type="submit" name="source" value="editTask"
					<%=editButton %>>Edit Task</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

				Grading :<%=gradingStatus %>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="submit" name="source" value="gradeCourse"
					<%=editButton %>>Give Grades</button>

			</p>

		</form>
	</fieldset>
</div>
<br>

<div style="padding-left: 80px; padding-right: 80px;">
	<fieldset>
		<legend>
			<h3>
				Task<%=taskPage+1%>
				Students scores
			</h3>
		</legend>
		<br>
		<%
ResultSet rsStudentTask=null;

if(singleOrAll==null)
{
rsStudentTask=UserGuiDB.getAllStudentsTasks(connection, course, "Task"+(taskPage+1),"all"); 
}
else
{
rsStudentTask=UserGuiDB.getAllStudentsTasks(connection, course, "Task"+(taskPage+1),singleOrAll);
}

%>

		<table align="center" border="1" width="100%">
			<tr style="background: #3a94a8; color: white;">
				<th width="2">S.no</th>
				<th>Student</th>
				<th>Submitted answer</th>
				<th>Date</th>
				<th>Marks</th>
			</tr>

			<%
int k=1;
while(rsStudentTask.next())
{
%>
			<tr>
				<td><%=k %></td>
				<td>
					<%if(rsStudentTask.getString(1)==null)
	out.write("");
	else
	out.write(rsStudentTask.getString(1));%>
				</td>

				<td>
					<form action="UpdateTasks" method="post">

						<textarea rows="3" cols="80" readonly>
							<%if(rsStudentTask.getString("answer")==null)
	out.write("");
	else
	out.write(rsStudentTask.getString(2));%>
						</textarea>
						<%
String editable="";
String btnName="";
String editableStatus=rsStudentTask.getString("editable");

if(rsStudentTask.getString("answer")!=null && userid.equalsIgnoreCase(instructor))
{
editable="<br><br>Editable staus : "+rsStudentTask.getString("editable");	

  if(editableStatus.equalsIgnoreCase("false"))
	{
	btnName="<button type='submit' name='source' value='changeEditable' "+editAnswerButton+" >Allow student to sumbit answer again</button>";
	
	}
	else if(editableStatus.equalsIgnoreCase("true"))
	{
	btnName="<button type='submit' name='source' value='changeEditable'>Cancel submitting the answer again</button>";
	}
}
%>
						<input type="hidden" name="userid" value=<%=userid %>> <input
							type="hidden" name="course" value=<%=course %>> <input
							type="hidden" name="student"
							value=<%=rsStudentTask.getString(1) %>> <input
							type="hidden" name="taskNumber" value=<%=taskPage+1 %>> <input
							type="hidden" name="editable" value=<%=editableStatus%>>

						<%=editable %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=btnName %>
					</form>
				</td>


				<td>
					<%if(rsStudentTask.getString("submittedDate")==null)
	out.write("");
	else
	out.write(rsStudentTask.getString("submittedDate"));%>
				</td>
				<td>
					<form action="UpdateTasks" method="post">

						<%
String update="";

if(rsStudentTask.getString(2)==null || rsStudentTask.getString(2).length()==0)
{
	update="disabled";
}
%>

						<input type="number" name="marks" maxlength="3" min=0
							max=<%=maxMarks%>
							value="<%


if(rsStudentTask.getString("scoredMarks")==null)
	out.write("");
	else
	out.write(rsStudentTask.getString("scoredMarks"));%>"
							<%=readOnly %> required> <br> <input type="hidden"
							name="userid" value=<%=userid %>> <input type="hidden"
							name="course" value=<%=course %>> <input type="hidden"
							name="student" value=<%=rsStudentTask.getString(1) %>> <input
							type="hidden" name="taskNumber" value=<%=taskPage+1 %>>

						<button type="submit" name="source" value="updateMarks"
							<%=update %> <%=editButton %>>update marks</button>
					</form>
				</td>

			</tr>
			<%k++;
} 
%>

		</table>
	</fieldset>
</div>




<body>
	<%connection.close(); %>
</body>
</html>