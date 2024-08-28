<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QuizOverflow</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="<%=request.getContextPath()%>/images/logo.png" type="image/x-icon">
<link href="css/startpage.css" rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"> 



</head>
<body>
<section class="ftco-section">
		<div class="container">
			<nav class="navbar navbar-expand-lg ftco_navbar ftco-navbar-light" id="ftco-navbar">
		    <div class="container">
		   <img src="images/logo-color.png" alt="logo-image" class="logo-image-navbar">
		    	<div class="social-media order-lg-last">
		    		<p class="mb-0 d-flex">
		    			<a href="https://www.facebook.com" class="d-flex align-items-center justify-content-center" target="_blank" rel="noopener noreferrer"><span class="fa fa-facebook"><i class="sr-only">Facebook</i></span></a>
		    			<a href="https://www.twitter.com" class="d-flex align-items-center justify-content-center" target="_blank" rel="noopener noreferrer"><span class="fa fa-twitter"><i class="sr-only">Twitter</i></span></a>
		    			<a href="https://www.instagram.com" class="d-flex align-items-center justify-content-center" target="_blank" rel="noopener noreferrer"><span class="fa fa-instagram"><i class="sr-only">Instagram</i></span></a>
		    		</p>
	        </div>
		      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
		        <span class="fa fa-bars"></span> Menu
		      </button>
		      <div class="collapse navbar-collapse" id="ftco-nav">
		        <ul class="navbar-nav ml-auto mr-md-3">
		        	<li class="nav-item active"><a href="${pageContext.request.contextPath}/startPage" class="nav-link">HOME</a></li>
		        	<li class="nav-item"><a href="${pageContext.request.contextPath}/howtoplay" class="nav-link">HOW TO PLAY?</a></li>
		        	<li class="nav-item"><a href="${pageContext.request.contextPath}/login" class="nav-link">LOGIN</a></li>
		        </ul>
		      </div>
		    </div>
		  </nav>
  </div>

	</section>
	
	
	
	<div class="trivia-time-container">
	<div class="left-div">
	<div class="start-page-text"><p class="main-text"><b>Welcome, <i>Brave Quiz Challenger!</i></b><br><br>

Dare to Defy the Quiz? <br>
Embark on a journey where every question is a riddle, and every answer could unlock a new challenge—or 
trap you in a web of second guesses. The quiz is waiting. The clock is ticking. Will you conquer the challenge, 
or will the challenge conquer you? Step up and find out! <p></div>
	<div class="lets-start-div">
	<form action="<%=request.getContextPath()%>/startPage" method="post">
	<button class="button-82-pushable" role="button" type="submit">
  <span class="button-82-shadow"></span>
  <span class="button-82-edge"></span>
  <span class="button-82-front text">
	Let's start !
  </span>
</button>
</form>
    </div>
	</div>
    <img src="images/triviaTime.png" alt="Trivia Time" class="trivia-time"> 
</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<div>
	<footer class="footer">&copy;
		<script>
			document.write(new Date().getFullYear())
		</script>
		    , Friendship-driven, code-powered 💻❤️
	</footer>
	</div>

  <script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/main.js"></script>

</body>
</html>