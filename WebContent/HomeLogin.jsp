<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>S university portal</title>
<link rel="shortcut icon" type="image/x-icon" href="images/icon.jpg" />


<!-- Bootstrap -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="Bootstrap/style.css"></link>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="Bootstrap/msdPage.js"></script>

</head>


<body>



	<!-- 
2nd format



<h1 style=" color:#b70a01; text-align:center;"> &nbsp;&nbsp;<a href="index.jsp"> S University </a></h1>
<div class=" row container" >
<h6 style=" color:#378fa1;text-align:center;"> <a href="Signup.jsp">Apply online</a></h6>

        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 totalItem ">
        <a href="Login.jsp" onclick="doCall('Student')" title="Student login">
      <img alt="Student login" class="rcorners1" src="images/student.jpg"   title="student login" >
        <div class="rowItem">
            <h6 class="itemPrice"> Student Login </h6> 
        </div></a>
        </div>

        <div class="col-lg-6  col-md-6  col-sm-12 col-xs-12 totalItem ">
        <a href="Login.jsp" title="Faculty login" onclick="doCall('Faculty')">
        <img alt="Faculty login"  class="rcorners1" src="images/faculty1.jpg" title="faculty login">
            <div class="rowItem">  
            <h6 class="itemPrice"> Faculty Login </h6> 
            </div></a>
        </div>

        <div class="col-lg-6  col-md-6 col-sm-12 col-xs-12 totalItem">
           <a href="Login.jsp" title="Applicant login" onclick="doCall('Applicant')">
        <img alt="Applicant login"  class="rcorners1"  src="images/applicant.jpg"  title="faculty login">
                <div class="rowItem">  
            <h6 class="itemPrice"> Applicant Login </h6> 
                </div></a>
        </div>

        <div class="col-lg-6  col-md-6 col-sm-12 col-xs-12 totalItem">
        <a href="Login.jsp" title="Admin login" onclick="doCall('Admin')">
        <img alt="Admin login" class="rcorners1"  src="images/AdminPage.jpg"   title="faculty login">
                <div class="rowItem">
            <h6 class="itemPrice"> Admin Login </h6> 
                </div></a>
        </div>


        </div>




 -->


	<h1 class="HomeLogin">
		<a class="HomeLogin" href="index.jsp"><span
			class="glyphicon glyphicon-home" aria-hidden="true"></span> S
			University</a>
	</h1>
	<h6 class="HomeLogin">
		<a class="HomeLogin" href="Signup.jsp">Apply online</a>
	</h6>

	<br>
	<br>
	<div style="width: 570px; height: 500px;" class="container well">

		<table>
			<tr>
				<td style="padding-right: 30px;"><a href="Login.jsp"
					onclick="doCall('Student')"> <img alt="student login"
						src="images/student.jpg" height="200" width="250"
						title="student login"></a><br>
				<br></td>
				<td><a href="Login.jsp" onclick="doCall('Faculty')"> <img
						alt="faculty login" src="images/faculty1.jpg" height="200"
						width="250" title="faculty login"></a><br>
				<br></td>
			</tr>

			<tr>

				<td style="padding-right: 30px;"><a href="Login.jsp"
					onclick="doCall('Applicant')"> <img alt="Applicant login"
						src="images/applicant.jpg" height="200" width="250"
						title="applicant login"></a><br>
				<br></td>

				<td><a href="Login.jsp" onclick="doCall('Admin')"> <img
						alt="Admin Login" src="images/AdminPage.jpg" height="200"
						width="250" title="admin login"></a><br>
				<br></td>

			</tr>

		</table>



	</div>





</body>
</html>