<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="images/logo.png" type="image/x-icon">
<title>How to play?</title>
<link href="css/startpage.css" rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"> 
<link href="css/howToPlay.css" rel="stylesheet" type="text/css">
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
		        	<li class="nav-item"><a href="${pageContext.request.contextPath}/startPage" class="nav-link">HOME</a></li>
		        	<li class="nav-item active"><a href="${pageContext.request.contextPath}/howtoplay" class="nav-link">HOW TO PLAY?</a></li>
		        	<li class="nav-item"><a href="${pageContext.request.contextPath}/login" class="nav-link">LOGIN</a></li>
		        </ul>
		      </div>
		    </div>
		  </nav>
  </div>

	</section>
<br>
<div id="how-to-play-container">

<div class="header-instructions"><i>Instructions</i></div>
<br>
<div class="text-how-to-play">
<h4>Welcome to the Quiz Challenge!</h4>
Try to beat the quiz by answering all of the questions. It's as simple as that! Or is it...?
</div>
<div class="text-how-to-play">


The questions are far from easy. Some require insane logic, others are completely down to guessing. It's hard,
 but it's NOT impossible!
 
 
</div>
<div class="text-how-to-play">
<h5>Your Key to the Quiz: The PIN</h5>

Before you can dive into the quiz, you’ll need a special code—the quiz PIN. This unique PIN connects you to the game, 
giving you access to the questions and the thrill of the challenge. 
Just enter the PIN when prompted, and you’re in! <span>&#128526;</span>

</div>
<h5 class="naslov">Time is of the Essence</h5>

<div class="gif-div">
<img src="<%=request.getContextPath()%>/images/roziSat.gif" alt="sat">
<div class="text-how-to-play">

<br>
<br>
Every question is timed. You'll need to think fast and act even faster. Make sure your answer is locked in before the timer hits zero. 
The time limits vary, ranging from a generous 60 seconds to a nerve-wracking 1 second. Keep your wits about you!
</div>
</div>

<h5 class="naslov">Multiple Choice with a Twist</h5>
<div class="gif-div">
<div class="text-how-to-play">
<br>
<br>
All the questions are multiple-choice, but don't let that fool you into thinking it's easy. 
 Sometimes, more than one answer might be correct. Pay close attention, and choose wisely!  <span>&#128521;</span>

</div>
<img src="<%=request.getContextPath()%>/images/questionMark.png" alt="question_mark" id="question_mark">

</div>
<br>
<br>
<div class="text-how-to-play" >
<span style="color: black;">Want to create your own quizzes?</span> <i><a href="${pageContext.request.contextPath}/signup">Sign up</a> and become an editor! 
As an editor, you’ll have the power to craft your own quizzes, manage questions, and challenge others.
 It’s simple—just register, and once your account is approved, you can start creating and sharing your quizzes 
 with the world. </i>



</div>


</div>


<br>
<br>


<footer class="footer" style="font-size: 14px;">
		&copy;
		<script>
			document.write(new Date().getFullYear())
		</script>
		
		    , Friendship-driven, code-powered 💻❤️

	</footer>

</body>
</html>