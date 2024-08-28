<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="images/logo.png" type="image/x-icon">
<link href="css/startpage.css" rel="stylesheet" type="text/css">
<link href="css/signup.css" rel="stylesheet" type="text/css">
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
    pointer-events: auto; 
    z-index: 2; 
  }
</style>
</head>
<body onload="clearForm()">
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
								href="${pageContext.request.contextPath}/signup" class="nav-link">SIGN UP</a></li>
						</ul>
					</div>
				</div>
			</nav>
		</div>

	</section>

  <main class="main-content  mt-0">
    <section>
      <div class="page-header min-vh-100">
        <div class="container">
          <div class="row">
            <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 start-0 text-center justify-content-center flex-column">
              <div class="position-relative bg-gradient-primary h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center" style="background-image: url('images/pinksaturn.jpg'); background-size: cover;">
              </div>
            </div>
            <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column ms-auto me-auto ms-lg-auto me-lg-5">
              <div class="card card-plain">
                <div class="card-header">
                  <h4 class="font-weight-bolder">Sign Up</h4>
                  <p class="mb-0">Enter your email and password to register</p>
                </div>
                <div class="card-body">
                  <form id="loginForm" role="form" action="signup" method="POST">
                    <div class="input-group input-group-outline mb-3">
                      <label class="form-label">Name</label>
                      <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="input-group input-group-outline mb-3">
                      <label class="form-label">Email (something@quizoverflow.com)</label>
                      <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="input-group input-group-outline mb-3 input-container">
                     <label class="form-label">Password</label>
                      <input type="password" class="form-control" name="password" id="password" required>
                       
                      <i class="far fa-eye-slash toggle-password" data-toggle="#password"></i>
                    </div>
                    <div class="form-check form-check-info text-start ps-0">
                      <input class="form-check-input" type="checkbox" name="agreeTerms" value="on" id="flexCheckDefault">
                      <label class="form-check-label" for="flexCheckDefault">
                        I agree the <a href="javascript:;" class="text-dark font-weight-bolder" onclick="termsAndConditions()">Terms and Conditions</a>
                      </label>
                    </div>
                    <br>
                    <div id="my-error-message">
                    
                    
                   <% String errorMessage = (String) session.getAttribute("errorMessage"); %>
             <% if (errorMessage != null) { %>
                  <div class="alert alert-danger"><%= errorMessage %></div>
             <% session.removeAttribute("errorMessage"); %>
             <% } %>
             
                   </div>
                    <div class="text-center">
                      <button type="submit" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0">Sign Up</button>
                    </div>
                  </form>
                </div>
                <div class="card-footer text-center pt-0 px-lg-2 px-1">
                  <p class="mb-2 text-sm mx-auto">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login" class="text-primary text-gradient font-weight-bold">Login</a>
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
  
  
  <footer class="footer" style="font-size:14px;">&copy;
		<script>
			document.write(new Date().getFullYear())
		</script>
		    , Friendship-driven, code-powered 💻❤️

	</footer>
	
		<dialog id="terms-dialog"
													class="mdl-dialog my-delete-dialog">
											
											
											
												
													<div class="mdl-dialog__content">
													<main class="wrap">
  <section class="container-t">
    <div class="container__heading-t">
      <h2>Terms & Conditions</h2>
    </div>
    <div class="container__content-t">
      
        <h4>1. Introduction</h4>
        <p>Welcome to our Quiz Application. This app has two parts: an admin section for managing quizzes and a public side for participation. By using this app, you agree to these terms.</p>
        
        <h4>2. Admin Functionality</h4>
        <p>Admin pages require authentication and start with `/admin/`. Admins can manage quizzes and user profiles. Quizzes include titles, images, questions, and answers, and can be rearranged. Admins control quiz flow in real-time and can save results as XLS files.</p>
        
        <h4>3. Public Functionality</h4>
        <p>Participants enter a PIN to join a quiz, provide their name, and answer questions within a set time. Results for the top 10 participants are shown after each question.</p>
        
        <h4>4. User Responsibilities</h4>
        <p>Provide accurate information, keep login details secure, and comply with laws.</p>
        
        <h4>5. Data Privacy</h4>
        <p>Our Privacy Policy explains how we handle your personal information.</p>
        
        <h4>6. Changes</h4>
        <p>We may update these Terms & Conditions. Changes are effective upon posting.</p>
        
        <h4>7. Contact</h4>
        <p>For questions, contact us at [<i style="color: #e53270;"><a target="_blank" rel="noopener noreferrer"  href="mailto:najda.beganovic@fet.ba">najda.beganovic@fet.ba</a> & <a target="_blank" rel="noopener noreferrer" href="mailto:amina.cickusic@fet.ba?subject=QUIZOVERFLOW">amina.cickusic@fet.ba</a></i>].</p>
    </div>
    <div class="container__nav-t">
      <small>By clicking 'Accept' you are agreeing to our terms and conditions.</small>
      <a class="button-t" href="#" id="agree-to-terms">Accept</a>
    </div>
  </section>
</main>
														
													
												</div>
												    
												
												
												
												
												</dialog>
	
	
	
	
	
	
	
	
	
	
  
  <script src="js/popper.min.js"></script>
  <script src="js/perfect-scrollbar.min.js"></script>
  <script src="js/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  
  <script src="js/material-dashboard.min.js?v=3.0.0"></script>
  <script>
   function clearForm() {
       document.getElementById("loginForm").reset();
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

document.querySelectorAll('.input-container input').forEach(input => {
    input.addEventListener('focus', event => {
        let togglePasswordIcon = input.parentElement.querySelector('.toggle-password');
        togglePasswordIcon.style.zIndex = '2';
    });

    input.addEventListener('blur', event => {
        let togglePasswordIcon = input.parentElement.querySelector('.toggle-password');
        togglePasswordIcon.style.zIndex = '1';
    });
});
</script>
<script>
function termsAndConditions() {
	   var dialog = document.getElementById('terms-dialog');
       if (dialog) {
           if (!dialog.showModal) {
               dialogPolyfill.registerDialog(dialog);
           }
           dialog.showModal();

           var closeButton = document.getElementById('agree-to-terms');
           if (closeButton) {
               closeButton.addEventListener('click', function() {
            	   const check = document.getElementById('flexCheckDefault');
            	   check.checked = true;
                   dialog.close();
               });
           }
       }
	
	
	
	
	
	
}

document.getElementById("loginForm").addEventListener("submit", function(event) {
    var emailInput = document.querySelector("input[name='email']");
    var emailPattern = /^[a-zA-Z0-9._%+-]+@quizoverflow\.com$/; 
    var newpassword = document.querySelector("input[name='password']");
   
    
    
    var p1 = /.*\d.*/;
    var p2 = /.*[a-zA-Z].*/; 
    
    
    if (!emailPattern.test(emailInput.value)) {
        event.preventDefault(); 
        var div = document.getElementById('my-error-message');
        div.innerHTML = `
            <div class="alert alert-danger">Email must follow pattern something@quizoverflow.com!</div>`;
    }
    else if (newpassword.value.length<8 || !p1.test(newpassword.value) || !p2.test(newpassword.value)) {
        event.preventDefault(); 
        var div = document.getElementById('my-error-message');
       
        div.innerHTML = `
            <div class="alert alert-danger">New password must be at least 8 characters long, include a number, and a letter.</div>`;
    }
});




</script>
</body>
</html>