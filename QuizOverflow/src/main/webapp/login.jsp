<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>



<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="images/logo.png" type="image/x-icon">
<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700'
	rel='stylesheet' type='text/css'>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">

<link href="css/nucleo-icons.css" rel="stylesheet" />
<link href="css/nucleo-svg.css" rel="stylesheet" />
<link id="pagestyle" href="css/material-dashboard.css?v=3.0.0"
	rel="stylesheet" />
<link href="css/startpage.css" rel="stylesheet" type="text/css">
<script src="js/material-dashboard.min.js?v=3.0.0"></script>
<title>Login</title>
<style>
.input-container {
    position: relative;
  }

  .input-container input {
    width: 100%;
    padding-right: 30px; 
  }

  .input-container .toggle-password {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
  }
</style>
</head>
<body
	style="background-image: url('images/skyy.png'); background-size: cover;">
	<section class="ftco-section">
		<div class="container">
			<nav class="navbar navbar-expand-lg ftco_navbar ftco-navbar-light"
				id="ftco-navbar">
				<div class="container">
					<img src="images/logo-color.png" alt="logo-image"
						class="logo-image-navbar">
					<div class="social-media order-lg-last">
						<p class="mb-0 d-flex">
							<a href="https://www.facebook.com"
								class="d-flex align-items-center justify-content-center" target="_blank" rel="noopener noreferrer"><span
								class="fa fa-facebook"><i class="sr-only">Facebook</i></span></a> <a
								href="https://www.twitter.com"
								class="d-flex align-items-center justify-content-center" target="_blank" rel="noopener noreferrer"><span
								class="fa fa-twitter"><i class="sr-only">Twitter</i></span></a> <a
								href="https://www.instagram.com"
								class="d-flex align-items-center justify-content-center" target="_blank" rel="noopener noreferrer"><span
								class="fa fa-instagram"><i class="sr-only">Instagram</i></span></a>
						</p>
					</div>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#ftco-nav" aria-controls="ftco-nav"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="fa fa-bars"></span> Menu
					</button>
					<div class="collapse navbar-collapse" id="ftco-nav">
						<ul class="navbar-nav ml-auto mr-md-3">
							<li class="nav-item"><a
								href="${pageContext.request.contextPath}/startPage"
								class="nav-link">HOME</a></li>
							<li class="nav-item"><a href="${pageContext.request.contextPath}/howtoplay" class="nav-link">HOW TO
									PLAY?</a></li>
							<li class="nav-item active"><a
								href="${pageContext.request.contextPath}/login" class="nav-link">LOGIN</a></li>
						</ul>
					</div>
				</div>
			</nav>
		</div>

	</section>



	<main class="main-content  mt-0">
		<div class="page-header align-items-start min-vh-100">
			<div class="container" id="login-form">
				<div class="row">
					<div class="col-lg-4 col-md-8 col-12 mx-auto">
						<div class="card z-index-0 fadeIn3 fadeInBottom">
							<div
								class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
								<div
									class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
									<h5 class="text-white font-weight-bolder text-center mt-2 mb-0">Login</h5>
									<br>
								</div>
							</div>
							<div class="card-body">
								<form role="form" class="text-start" action="login"
									method="POST">
									<div class="input-group input-group-outline my-3">
										<label class="form-label">Email</label> <input type="email"
											class="form-control" name="email" required  pattern="[a-zA-Z0-9._%+-]+@quizoverflow\.com" 
       title="Please enter a valid email address in the format: something@quizoverflow.com">
									</div>
									<div class="input-group input-group-outline mb-3 input-container">
										<label class="form-label">Password</label> <input
											type="password" class="form-control" name="password" id="password" required>
											<i class="far fa-eye-slash toggle-password" data-toggle="#password"></i>
									</div>
									
									<%
									String errorMessage = (String) session.getAttribute("errorMessage");
									%>
									<%
									if (errorMessage != null) {
									%>
									<div class="alert alert-danger"><%=errorMessage%></div>
									<%
									session.removeAttribute("errorMessage");
									%>
									<%
									}
									%>
									
									<div class="text-center">
										<button type="submit"
											class="btn bg-gradient-primary w-100 my-4 mb-2">Login
											</button>
									</div>
									<p class="mt-4 text-sm text-center">
										Don't have an account? <a
											href="${pageContext.request.contextPath}/signup"
											class="text-primary text-gradient font-weight-bold">Sign
											up</a>
									</p>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<footer class="footer" style="font-size: 14px;">
		&copy;
		<script>
			document.write(new Date().getFullYear())
		</script>
		    , Friendship-driven, code-powered 💻❤️

	</footer>
	
	<script src="js/popper.min.js"></script>
	<script src="js/perfect-scrollbar.min.js"></script>
	<script src="js/smooth-scrollbar.min.js"></script>
	<script>
		var win = navigator.platform.indexOf('Win') > -1;
		if (win && document.querySelector('#sidenav-scrollbar')) {
			var options = {
				damping : '0.5'
			}
			Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
					options);
		}
	</script>
	<script>
		
		document.querySelectorAll('.toggle-password').forEach(item => {
			item.addEventListener('click', event => {
				let input = document.querySelector(item.getAttribute('data-toggle'));
				if (input.getAttribute('type') === 'password') {
					input.setAttribute('type', 'text');
					item.classList.remove('fa-eye-slash');
					item.classList.add('fa-eye');
				} else {
					input.setAttribute('type', 'password');
					item.classList.remove('fa-eye');
					item.classList.add('fa-eye-slash');
				}
			});
		});
	</script>
	<script async defer src="https://buttons.github.io/buttons.js"></script>
	
</body>
</html>