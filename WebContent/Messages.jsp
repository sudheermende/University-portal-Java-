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
	String msgBox=request.getParameter("msgBox");

	String sqlMsgTable=" CREATE TABLE IF NOT EXISTS '"+userid+"Messages' ('no' INTEGER,'boxType' VARCHAR,'fromOrTo' VARCHAR,'sub' VARCHAR,"+
			"'msg' VARCHAR, 'date' DATETIME, 'status' VARCHAR NOT NULL  DEFAULT unread)";
	
	
	
	
	if(msgBox==null)
		msgBox="Inbox";
	
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

  	
  	String position=st.executeQuery("select position from users where username='"+userid+"'").getString(1);
    
	st.execute(sqlMsgTable);
  	
  	String menu="";

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

  		
  		
  	}

  	else 	if(position.equalsIgnoreCase("admin"))
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
  		
  	}

  	else if(position.equalsIgnoreCase("applicant"))
  	{
  		menu="<form method='post' action='HomeLogin' style='padding-left:20px; padding-bottom:20px;'>"+
  		  		"<h3 style=' color:#b70a01; text-align: right'>"+
  		  			  "<span><a href='Applicant.jsp?userid="+userid+"'>Applicant Home</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;"+
  		  				"<span><a href='AccountSettings.jsp?userid="+userid+"'>Account Setting</a></span>"+
  		    		"</h3></form>";

  	}
  	
  	String fromOrTo="";
	String buttonVisibility="";
  	
  if(msgBox.equalsIgnoreCase("inbox"))
    fromOrTo="From";
  else if(msgBox.equalsIgnoreCase("sent"))
  {
	    fromOrTo="To";
	    buttonVisibility="style='visibility:hidden;'";
  }
 else if(msgBox.equalsIgnoreCase("draft"))
 {
	 fromOrTo="To";
	 buttonVisibility="style='visibility:hidden;'";
}
String sql="select * from  "+userid+"Messages where boxType='"+msgBox.toLowerCase()+"' order by no desc";

%>
<title><%=userid %> messages</title>
</head>
<body>
	<h1 style="color: #b70a01;">
		&nbsp;&nbsp;S University<sub> <%=position.toLowerCase() %>
		</sub>
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
		${notification} <br>
		<fieldset>
			<legend>
				<h3>Messages</h3>
			</legend>

			<form action="Messages" method="post">
				<input type="hidden" name="userid" value=<%=userid %>>

				<p>
					Action :
					<button style="color: white; background-color: #378fa1"
						type="submit" name="source" value="Inbox">In box</button>
					&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
					<button style="color: white; background-color: #378fa1"
						type="submit" name="source" value="Sent">Sent box</button>
					&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
					<button style="color: white; background-color: #378fa1"
						type="submit" name="source" value="Draft">Draft</button>
					&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
					<button style="color: white; background-color: #378fa1"
						type="submit" name="source" value="NewMsg">New Message
						>></button>
				</p>

			</form>

			<fieldset>
				<legend>
					<h4><%=msgBox %></h4>
				</legend>
				<form action="Messages" method="post">
					<input type="hidden" name="userid" value=<%=userid%>>

					<table align="center" border="1" width="100%">
						<tr style="background: #3a94a8; color: white;">
							<th>s.no</th>
							<th><%=fromOrTo %></th>
							<th>Sub</th>
							<th>Msg</th>
							<th>Date</th>
							<th>Action</th>
						</tr>

						<%
ResultSet rsMsg=st.executeQuery(sql);
int i=1;
while(rsMsg.next())
{
	
String style="";
if(rsMsg.getString("status").equalsIgnoreCase("unread") && msgBox.equalsIgnoreCase("inbox"))
{
style="style='font-weight: bold; color:#2566c6;'";

}

%>

						<tr <%=style %>>
							<td><%=i %></td>
							<td><%=rsMsg.getString(3) %></td>

							<td>
								<%if(rsMsg.getString("sub").length()>15)
{
out.println(rsMsg.getString("sub").substring(0,15)+"...");
}
else
out.println(rsMsg.getString("sub"));%>
							</td>

							<td>
								<%
if(rsMsg.getString("msg").length()>35)
{
out.println(rsMsg.getString("msg").substring(0,35)+"...");
}
else
out.println(rsMsg.getString("msg"));%>
							</td>
							<td><%=rsMsg.getString("date")%></td>
							<td align="center"><input type="hidden" name="boxType"
								value=<%=msgBox %>>
								<button type="submit" name="deleteMsgNo"
									value=<%=rsMsg.getString(1) %>>Delete</button>
								&nbsp;&nbsp;|&nbsp;&nbsp;
								<button type="submit" name="viewMsgNo"
									value=<%=rsMsg.getString(1) %>>View</button>
								&nbsp;&nbsp;|&nbsp;&nbsp;
								<button type="submit" name="makeReadMsgNo"
									value=<%=rsMsg.getString(1) %> <%=buttonVisibility %>>make
									as read</button></td>

						</tr>


						<%
i++;
}
%>

					</table>

				</form>

			</fieldset>


		</fieldset>
	</div>
	<%connection.close();


%>
</body>
</html>