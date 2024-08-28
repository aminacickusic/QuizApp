<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, model.QuizDatabaseService, model.UserDatabaseService"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="<%=request.getContextPath()%>/images/logo.png"
	type="image/x-icon">
<link href="<%=request.getContextPath()%>/css/startpage.css"
	rel="stylesheet" type="text/css">

<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700'
	rel='stylesheet' type='text/css'>


	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/solid.min.css"
 rel="stylesheet">
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/nucleo-icons.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/nucleo-svg.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/ruang-admin.min.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">


<link id="pagestyle"
	href="<%=request.getContextPath()%>/css/inbox.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/adminmainpage.css"
	rel="stylesheet" type="text/css">
<link id="pagestyle"
	href="<%=request.getContextPath()%>/css/material-dashboard.css?v=3.0.0"
	rel="stylesheet" />
	
<title>Admin Main Page</title>
</head>
<body>
	<section class="ftco-section">
		<div class="container">
			<nav class="navbar navbar-expand-lg ftco_navbar ftco-navbar-light"
				id="ftco-navbar">
				<div class="container">
					<!--  	<a class="navbar-brand" href="#">QuizOverflow</a> -->
					<img src="<%=request.getContextPath()%>/images/logo-color.png"
						alt="logo-image" class="logo-image-navbar">
					
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#ftco-nav" aria-controls="ftco-nav"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="fa fa-bars"></span> Menu
					</button>
					<div class="collapse navbar-collapse" id="ftco-nav">
						<ul class="navbar-nav ml-auto mr-md-3">
							<li class="nav-item"><a
								href="${pageContext.request.contextPath}/admin/main"
								class="nav-link">HOME</a></li>
							<li class="nav-item"><a
								href="${pageContext.request.contextPath}/admin/logout"
								class="nav-link">LOGOUT</a></li>
						</ul>
					</div>
				</div>
			</nav>
		</div>
	</section>
	<div>
			<br> <br>
		<div class="profile-outer-div">
			<div class="left">
			<% 
						User user = (User) request.getAttribute("currentUser");
						if (user.getRole().equals("admin")) {
						
			%>
				<nav id="left-navbar">
					<ul>
						<li><a href="<%=request.getContextPath()%>/admin/editprofile">
								<div class="icon">
									<i class="fa fa-user"></i>
								</div>
						</a></li>
						
						<li><a
							href="<%=request.getContextPath()%>/admin/usermanagement">
								<div class="icon">
									<img src="<%=request.getContextPath()%>/images/users.png"
										alt="Users Line Icon">
								</div>
						</a></li>
					
						<li><a
							href="<%=request.getContextPath()%>/admin/quizmanagement">
								<div class="icon">
									<img src="<%=request.getContextPath()%>/images/quizWhite.png"
										alt="Users Line Icon">
								</div>
						</a></li>
						<li>
						<a href="<%=request.getContextPath()%>/admin/inbox">
							<div class="icon">
								<i class="fa fa-envelope"></i>
							</div>
						</a>
						</li>
					</ul>
				</nav>
				
			<%} else if (user.getRole().equals("editor")) { %>
			<nav id="left-navbar-e">
					<ul>
						<li><a href="<%=request.getContextPath()%>/admin/editprofile">
								<div class="icon">
									<i class="fa fa-user"></i>
								</div>
						</a></li>
						
					
						<li><a
							href="<%=request.getContextPath()%>/admin/quizmanagement">
								<div class="icon">
									<img src="<%=request.getContextPath()%>/images/quizWhite.png"
										alt="Users Line Icon">
								</div>
						</a></li>
						<li>
						<a href="<%=request.getContextPath()%>/admin/inbox">
							<div class="icon">
								<i class="fa fa-envelope"></i>
							</div>
						</a>
						</li>
					</ul>
				</nav>
			
			
			
			
			
			
			
			
			<%
			}
			%>
			</div>
			<div class="right">
			
               <div class="container-fluid" id="container-wrapper">
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                 <h1 class="h3 mb-0 text-gray-800" id="welcome">Welcome <i style="color: #e53270;"><%=user.getUsername()%>! </i>&#129303;</h1> 
                </div>
                <br>
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800" id="dashboard">Dashboard</h1>
            
          </div>
          <br>
<%
UserDatabaseService userService = new UserDatabaseService();
QuizDatabaseService service = new QuizDatabaseService();
Integer numOfUsers = userService.getUsers().size();
Integer newUsers = userService.getNewUsers();
Integer numOfQuizzes = service.getQuizzes().size();
Double avgPoints = service.getAvgPoints();
Double maxPoints = service.getMaxPoints();
Integer avgPlayers = service.getAvgPlayers();
Integer maxPlayers = service.getMaxPlayers();
Integer newQuizzes = service.getNewQuizzes();
%>
          <div class="row mb-3">
           
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">TOTAL NUMBER OF USERS</div>
                      <br>
                      
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%=numOfUsers%></div>
                      <br>
                      <div class="mt-2 mb-0 text-muted text-xs">
                        <span class="text-success mr-2"><i class="fa fa-plus"></i><%=newUsers%></span>
                        <span>Since last week</span>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-users fa-2x text-primary"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
           
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">TOTAL NUMBER OF QUIZZES</div>
                      <br>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%=numOfQuizzes%></div>
                      <br>
                      <div class="mt-2 mb-0 text-muted text-xs">
                        <span class="text-success mr-2"><i class="fas fa-plus"></i><%=newQuizzes%></span>
                        <span>Since last week</span>
                      </div>
                    </div>
                    <div class="col-auto">
                    
                   <img src="<%=request.getContextPath()%>/images/home-q-icon.svg" alt="question-with-list" id="q-img">
                    </div>
                  </div>
                </div>
              </div>
            </div>
           
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">AVERAGE POINTS PER QUIZ</div>
                      <br>
                      <%
                      String avg = String.format("%.2f", avgPoints);
                      String max = String.format("%.2f", maxPoints);

                      %>
                      
                      <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><%=avg%></div>
                      <br>
                      <div class="mt-2 mb-0 text-muted text-xs">
                      
                        <span class="text-success mr-2"><i class="fa-solid fa-arrow-trend-up"></i><%=max%></span>
                        <span>Max points</span>
                      </div>
                    </div>
                    <div class="col-auto">
                    <img src="<%=request.getContextPath()%>/images/avg-points.png" alt="question-with-list" id="q-img-2">
                    
                    </div>
                  </div>
                </div>
              </div>
            </div>
           
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">AVERAGE PLAYERS PER QUIZ</div>
                      <br>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%=avgPlayers %></div>
                      <br>
                      <div class="mt-2 mb-0 text-muted text-xs">
                        <span class="text-success mr-2"><i  class="fa-solid fa-arrow-trend-up"></i><%=maxPlayers %></span>
                        <span>Max players</span>
                      </div>
                    </div>
                    <div class="col-auto">
                      <img src="<%=request.getContextPath()%>/images/avg-users.png" alt="question-with-list" id="q-img-2">
                    </div>
                  </div>
                </div>
              </div>
            </div>



        

			</div>
		</div>
		
	
	
	
	
	
	
	</div>
	
	<footer class="footer footer-new" id="inbox-footer">
			&copy;
			<script>
				document.write(new Date().getFullYear())
			</script>
			  , Friendship-driven, code-powered 💻❤️

		</footer>
	<script>
    document.querySelectorAll('#left-navbar ul li').forEach(function(li) {
        li.addEventListener('click', function() {
            var link = li.querySelector('a');
            if (link) {
                window.location.href = link.href;
            }
        });
    });
</script>
	<script>
    document.querySelectorAll('#left-navbar-e ul li').forEach(function(li) {
        li.addEventListener('click', function() {
            var link = li.querySelector('a');
            if (link) {
                window.location.href = link.href;
            }
        });
    });
</script>









</body>
</html>