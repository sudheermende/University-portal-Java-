<%@page import="java.util.LinkedList"%>
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
<title>Change Faculty</title>

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
Statement st=connection.createStatement();

int msgCount=st.executeQuery("select count(msg) from "+userid+"Messages where boxType='inbox' and status='unread'").getInt(1);


ResultSet rsPre=st.executeQuery("select courseId from courses where department=(select department from courses where courseid='"+course+"')");

LinkedList<String> preList= new LinkedList<String> ();

while(rsPre.next())
{
preList.add(rsPre.getString(1));
}



String sql="select * from courses where courseid='"+course+"'";
ResultSet rs=st.executeQuery(sql);

%>


<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub>&nbsp;admin</sub>
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
		<h4 style="text-align: right;";>
			<a href="CourseList.jsp?userid=<%=userid%>">&lt&lt &nbsp back</a>
		</h4>
	</div>

	<div
		style="padding-left: 80px; padding-right: 80px; padding-bottom: 40px;">
		<fieldset>
			<legend>
				<h3>
					Edit
					<%= course%>
					details
				</h3>
			</legend>
			<div
				style="padding-left: 30x; padding-right: 30px; padding-bottom: 30px;">
				<form action="EditCourse" method="post">
					<h3 align="center"><%=rs.getString(1)%>&nbsp;&nbsp;(<%= course %>
						)
					</h3>

					<input type="hidden" name="course" value=<%=course%>> <input
						type="hidden" name="userid" value=<%=userid%>>


					credits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
					<input type="text" name="credits" placeholder="credits"
						pattern="[1-3]{1}" title="credits must be between 1-3 "
						maxlength="1" size="1" required value=<%=rs.getString("credits")%>><br>
					<br> Pre Req
					subject&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <select
						name="preReq">
						<option value="">select--</option>

						<% for(int i=0;i<preList.size();i++)
{
%>
						<option value=<%=preList.get(i)%>
							<%
 String selected=null;
 
 if(preList.get(i).equalsIgnoreCase(rs.getString("prerequisite")))
 {
	 selected="selected='selected'";
}
 
 %>
							<%=selected%>><%=preList.get(i)%>
						</option>
						<%} %>

					</select> <br>
					<br> Max Students
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <input
						type="text" name="capacity" placeholder="capacity"
						pattern="[10-60]{2}" title="min 10 max capacity 60 " maxlength="2"
						size="2" required value=<%=rs.getString("maxStudents") %>>

					<br>
					<br> Time
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
					<input type="time" name="time" placeholder="time" required
						value=<%=rs.getString("time") %>> <br>
					<br> Room
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
					<input type="text" name="room" placeholder="room" required
						value=<%=rs.getString("room") %>> <br>
					<br> Cost
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
					$<input type="text" name="cost" placeholder="cost" required
						value=<%=rs.getString("cost") %>> <br>
					<br>

					<% String faculty=rs.getString(6); %>
					<input type="hidden" name="oldFaculty" value=<%=rs.getString(6) %>>

					New Instructor name : <select name="newFaculty" required>
						<option value="">select--</option>

						<% 
String sql2="select username from users where position='faculty'";
ResultSet rs2=st.executeQuery(sql2);

LinkedList<String> list=new LinkedList<String>();

while(rs2.next())
{
	list.add(rs2.getString("username"));
}


for(int i=0;i<list.size();i++)
{
%>
						<option value=<%=list.get(i)%>
							<%
 String selected2=null;
 
 if(list.get(i).equalsIgnoreCase(faculty))
 {
	 selected2="selected='selected'";
 }
 
 %>
							<%=selected2%>><%=list.get(i)%>
						</option>
						<% } %>

					</select> <br>
					<br>
					<button style="color: white; background-color: #378fa1"
						type="submit" name="source" value="editCourse">save
						changes</button>

				</form>
			</div>
		</fieldset>
	</div>


	<%
rs.close();
rs2.close();
st.close();
connection.close(); %>
</body>


</html>