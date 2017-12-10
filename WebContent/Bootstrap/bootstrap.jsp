<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>sudheer bootstrap project</title>

<!-- Bootstrap -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="style.css"></link>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="msdPage.js"></script>

</head>
<body>



	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#"><span
					class="glyphicon glyphicon-home" aria-hidden="true"></span> S
					UNIVERSITY</a>
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>
			<div class="collapse navbar-collapse " id="myNavbar">
				<ul class="nav navbar-nav">
					<li><a href="#admissions">ADMISSIONS</a></li>
					<li><a href="#">LIMITED</a></li>
					<li><a href="#">FILTERS BY MAIL</a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">OUR STORY <span class="caret"></span></a>
						<ul class="dropdown-menu" id="dropdownMenu">
							<li><a href="#">Company</a></li>
							<li><a href="#">Giving</a></li>
							<li><a href="#">Sustainability</a></li>
							<li><a href="#">Blog</a></li>
						</ul></li>
					<li><a href="#">SUPPORT</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="glyphicon glyphicon-user"></span>
							Sign Up</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-log-in"></span>
							Login</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div id="carousel-example-generic" class="carousel slide"
		data-ride="carousel">
		<!-- Indicators -->

		<ol class="carousel-indicators">
			<li data-target="#carousel-example-generic" data-slide-to="0"
				class="active"></li>
			<li data-target="#carousel-example-generic" data-slide-to="1"></li>
			<li data-target="#carousel-example-generic" data-slide-to="2"></li>
			<li data-target="#carousel-example-generic" data-slide-to="3"></li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">

			<div class="item active">
				<img src="univ(1).jpg">
				<div class="carousel-caption hidden-xs hidde-sm">
					<h4>university Main building</h4>
				</div>
			</div>

			<div class="item">
				<img src="univ(2).jpg" alt="University image 1">
				<div class="carousel-caption">
					<h4>university library</h4>
				</div>
			</div>
			<div class="item">
				<img src="univ(3).jpg" alt="University image 1">
				<div class="carousel-caption">
					<h4>computer science block</h4>
				</div>
			</div>
			<div class="item">
				<img src="univ(4).jpg" alt="University image 1">
				<div class="carousel-caption">
					<h4>San Fransisco</h4>
				</div>
			</div>
		</div>

		<!-- Controls -->
		<a class="left carousel-control" href="#carousel-example-generic"
			role="button" data-slide="prev"> <span
			class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#carousel-example-generic"
			role="button" data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>

	<!---->

	<!-- circled items in a row -->
	<div class="row container">

		<div class="col-lg-4  col-md-4 col-sm-6 col-xs-12 totalItem ">
			<a href="#" title="Olympus"> <img id="rcorners1" src="1.jpg">
				<div class="rowItem">
					<h4 class="itemName">Olympus</h4>
					<h3 class="itemPrice">Price $1000</h3>
				</div></a>
		</div>

		<div class="col-lg-4  col-md-4  col-sm-6  col-xs-12 totalItem ">
			<a href="#" title="Canon"> <img id="rcorners1" src="2.png">
				<div class="rowItem">
					<h4 class="itemName">Canon</h4>
					<h3 class="itemPrice">Price $1200</h3>

				</div></a>
		</div>

		<div class="col-lg-4  col-md-4 col-sm-6 col-xs-12 totalItem">
			<a href="#" title="Painting"> <img id="rcorners1" src="3.jpg">
				<div class="rowItem">
					<h4 class="itemName">Painting</h4>
					<h3 class="itemPrice">Price $200</h3>

				</div></a>
		</div>

		<div class="col-lg-4  col-md-4 col-sm-6 col-xs-12 totalItem">
			<a href="#" title="Olympus"> <img id="rcorners1" src="4.jpg">
				<div class="rowItem">
					<h4 class="itemName">Nikon</h4>
					<h3 class="itemPrice">Price $1500</h3>
				</div></a>
		</div>

		<div class="col-lg-4  col-md-4 col-sm-6 col-xs-12 totalItem">
			<a href="#" title="Canon"> <img id="rcorners1" src="5.jpg">
				<div class="rowItem">
					<h4 class="itemName">Toy</h4>
					<h3 class="itemPrice">Price $100</h3>
				</div></a>
		</div>

		<div class="col-lg-4  col-md-4 col-sm-6 col-xs-12 totalItem">
			<a href="#" title="Nikon"> <img id="rcorners1" src="6.jpg">
				<div class="rowItem">
					<h4 class="itemName">Camera Lense</h4>
					<h3 class="itemPrice">Price $800</h3>

				</div></a>
		</div>

	</div>

	<div id="admissions" class="">Admissions</div>


	<div class="newOffers container">

		<h1 align="center">Latest Offers</h1>

		<div class="col-lg-4  col-md-4 col-sm-6 col-xs-12 totalItem">
			<a href="#" title="Olympus"> <img src="1.jpg">
				<div class="item">
					<h4 class="itemName">Olympus</h4>
					<h3 class="itemPrice">Price $1000</h3>
				</div></a>
		</div>

		<div class="col-lg-4  col-md-4 col-sm-6  col-xs-12 totalItem ">
			<a href="#" title="Canon"> <img src="2.png">
				<div class="item">
					<h4 class="itemName">Canon</h4>
					<h3 class="itemPrice">Price $1200</h3>

				</div></a>
		</div>

		<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12   totalItem">
			<a href="#" title="Painting"> <img src="3.jpg">
				<div class="item">
					<h4 class="itemName">Painting</h4>
					<h3 class="itemPrice">Price $200</h3>

				</div></a>
		</div>
	</div>

	<div class="footerList container">

		<div class="explore hidden-xs">
			<h3>Explore</h3>
			<p>
				<a href="#">Products</a>
			</p>
			<p>
				<a href="#">Carafe</a>
			</p>
			<p>
				<a href="#">10-Cup Pitcher</a>
			</p>
			<p>
				<a href="#">6-Cup Pitcher</a>
			</p>
			<p>
				<a href="#">Glass Water Bottle</a>
			</p>
			<p>
				<a href="#">Filters By Mail</a>
			</p>
		</div>

		<div class="explore hidden-xs" id="ourStory">
			<h3>OUR STORY</h3>
			<p>
				<a href="#">Company</a>
			</p>
			<p>
				<a href="#">Giving</a>
			</p>
			<p>
				<a href="#">Sustainability</a>
			</p>
			<p>
				<a href="#">Blog</a>
			</p>
		</div>

		<div class="explore hidden-xs" id="support">
			<h3>SUPPORT</h3>
			<p>
				<a href="#">FAQ</a>
			</p>
		</div>

		<div class="signup">
			<h3>SIGN UP FOR OUR NEWSLETTER</h3>
			<form>

				<label for="exampleInputEmail1">Sign up to get promotions,
					news and more!</label>
				<div class="form-inline">
					<input type="email" class="form-control" id="exampleInputEmail1"
						placeholder="Email">
					<button type="submit" class="btn btn-info" id="sendReq"
						onclick="doCall(this.id)">Submit</button>
				</div>
			</form>
		</div>
	</div>


	<footer>
		<p>
			<a href="#">© sudheer</a> &nbsp;&nbsp;<font
				class="footerNote hidden-xs"><a href="#"> Terms of
					Service </a></font>&nbsp;&nbsp; <font class="footerNote hidden-xs"><a
				href="#"> Privacy Policy</a></font>
		</p>
	</footer>
</body>
</html>