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
<title>Creating new message</title>

<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />

<%
String userid=request.getParameter("userid");
String newOrView=request.getParameter("newOrView");

int msgNo=0;
if(request.getParameter("msgNo")!=null)
{
	msgNo=Integer.parseInt(request.getParameter("msgNo"));
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

	
	String position=st.executeQuery("select position from users where username='"+userid+"'").getString(1);
	
	ResultSet rsMsg=null;
	String boxType=null;
	
	if(request.getParameter("msgNo")!=null)
	{
	 rsMsg=st.executeQuery("select * from "+userid+"Messages where no="+msgNo+"");
	 boxType=rsMsg.getString("boxType");
	}
	
String fromOrToLabel="To";
String legendLebel="Create a new message";


String readOnlyTo="";
String readOnlySub="";
String readOnlyMsg="";
String newTypeButton="";
String viewTypeButton="";


if(newOrView==null || newOrView.equalsIgnoreCase("new"))
{
viewTypeButton="style='visibility:hidden;'";
}

if(newOrView!=null && newOrView.equalsIgnoreCase("view"))
{
	readOnlyTo="readonly";
	readOnlySub="readonly";
	readOnlyMsg="readonly";
	newTypeButton="style='visibility:hidden;'"; 
}


if(boxType!= null)
{
	if(boxType.equalsIgnoreCase("inbox"))
	{
	fromOrToLabel="From";
	legendLebel="viewing a inbox message";
	}
	else if(boxType.equalsIgnoreCase("sent"))
		legendLebel="Viewing a sent message";
	else if(boxType.equalsIgnoreCase("draft"))
	{
		legendLebel="Viewing a draft message";
		
		viewTypeButton="style='visibility:hidden;'";
		readOnlyTo="";
		readOnlySub="";
		readOnlyMsg="";
		newTypeButton=""; 


	}
	
	}

%>


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
					href="Messages.jsp?userid=<%=userid%>">Messages<%out.print(" ( "+ msgCount+" )"); %>
				</a> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a
					href="HomeLogin.jsp">Logout</a>
			</h3>
		</form>
		<h4 align="right">
			<a href="Messages.jsp?userid=<%=userid%>"><< back</a>
		</h4>
	</div>
	<div style="width: 700px; margin: 0 auto;">
		${notification}
		<fieldset>
			<legend>
				<h3>
					<%=legendLebel %></h3>
			</legend>

			<div
				style="padding-left: 120px; padding-right: 120px; padding-bottom: 30px; padding-top: 20px;">
				<fieldset>
					<br>
					<br>
					<form action="Messages" method="post">
						<input type="hidden" name="userid" value=<%=userid %>>

						<%=fromOrToLabel %>
						: <input type="text" name="fromOrTo"
							placeholder="enter valid user name" required
							value=<% if(rsMsg!=null)
	out.print(rsMsg.getString("fromOrTo")); %>
							${fromOrTo} <%=readOnlyTo %>> <br>
						<br> Subject : <input type="text" name="subject"
							placeholder="enter subject" required
							value=<%if(rsMsg!=null)	
	out.print(rsMsg.getString("sub")); %>
							${subject} <%=readOnlySub %>> <br>
						<br> Message : <br>
						<textarea rows="6" cols="50" name="message"
							placeholder="enter your message" required <%=readOnlyMsg%>>
							<%if(rsMsg!=null)out.print(rsMsg.getString("msg"));%>${message}</textarea>
						<br>
						<br> <input type="hidden" name="msgNumberForDraftOnly"
							value=<%=msgNo%>> <input type="hidden"
							name="boxTypeForSendingIssue" value=<%=boxType %>>

						<button type="submit" name="source" value="send"
							<%=newTypeButton %>>Send</button>
						<button type="submit" name="source" value="save"
							<%=newTypeButton %>>Save</button>
						<br>
						<button type="submit" name="source" value="reply"
							<%=viewTypeButton %>>Reply</button>
						<button type="submit" name="source" value="forward"
							<%=viewTypeButton %>>Forward</button>


					</form>
				</fieldset>
			</div>
		</fieldset>
	</div>




	<%connection.close();%>
</body>
</html>