<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, java.util.*, model.UserDatabaseService"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=request.getContextPath()%>/css/startpage.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/adminmainpage.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/admineditprofile.css"
	rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700'
	rel='stylesheet' type='text/css'>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">

<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link href="<%=request.getContextPath()%>/css/nucleo-icons.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/nucleo-svg.css"
	rel="stylesheet" />
<link id="pagestyle"
	href="<%=request.getContextPath()%>/css/material-dashboard.css?v=3.0.0"
	rel="stylesheet" />
<link rel="icon" href="<%=request.getContextPath()%>/images/logo.png"
	type="image/x-icon">

<title>Admin profile</title>

</head>
<body>
	<%
	User user = (User) request.getSession().getAttribute("currentUser");
	UserDatabaseService service = new UserDatabaseService();
	user = service.getUserByEmail(user.getEmail());
	request.getSession().setAttribute("currentUser", user);
	Integer avatarNum = user.getAvatar();
	String avatar = String.valueOf(avatarNum);
	String activeTab = (String) session.getAttribute("activeTab");
	if (activeTab == null) {
	    activeTab = "info-panel"; 
	}
	session.removeAttribute("activeTab"); 
	%>
	<section class="ftco-section">
		<div class="container">
			<nav class="navbar navbar-expand-lg ftco_navbar ftco-navbar-light"
				id="ftco-navbar">
				<div class="container">
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
			<% if (user.getRole().equals("admin")) { %>
			
				<nav id="left-navbar">
					<ul>
						<li><a href="<%=request.getContextPath()%>/admin/editprofile">
								<div class="icon">
									<i class="fa fa-user"></i>
								</div>
						</a></li>
						<li>
						<a href="<%=request.getContextPath()%>/admin/usermanagement">
							<div class="icon">
								<img src="<%=request.getContextPath()%>/images/users.png"
									alt="Users Line Icon">
							</div>
							</a>
						</li>
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
				<% } else if (user.getRole().equals("editor")) { %>
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

				<div class="mdl-tabs mdl-js-tabs">
					<div class="mdl-tabs__tab-bar">
						<a href="#info-panel" class="mdl-tabs__tab"
							id="info-tab">PERSONAL INFO</a> <a href="#password-panel"
							class="mdl-tabs__tab" id="password-tab">CHANGE PASSWORD</a>
					</div>
				</div>
				<br>
				<div class="profile-content">
					<div id="info-panel" class="tab-panel" style="display: none;">
						<div class="profile-avatar-change">

							<button class="btn-circle">
								<i><img
									src="<%=request.getContextPath()%>/images/avatars/<%=avatar%>.jpg"
									alt="avatar-image" class="avatar-icon" id="1"></i>
							</button>
							<br>
							<form action="<%=request.getContextPath()%>/changeavatar">
								<button type="submit" class="pushable-button"
									id="change-avatar-edit-btn">Change avatar</button>
							</form>
						</div>
						<div class="profile-username-change">
							<form id="username-form"
								action="<%=request.getContextPath()%>/admin/editprofile?changedField=username"
								method="POST">
								  <input type="hidden" name="activeTab" value="info-panel">
								   <input type="hidden" name="email" value="<%=user.getEmail()%>">
								<div class="md-outlined-text-field">
									<input type="text" name="username" id="username"
										value="<%=user.getUsername()%>"> <label
										for="username">Username</label>
								</div>
								<% if (user.getRole().equals("admin")) { %>
								<div class="md-outlined-text-field">
									<input type="text" id="email-to-change" name="email-to-change" value="<%=user.getEmail()%>"
										> <label for="email-to-change">Email
										</label>
								</div>
								<% } else { %>
								<div class="md-outlined-text-field">
									<input type="text" id="email-to-change" name="email-to-change" value="<%=user.getEmail()%>"
									readonly> <label for="email-to-change">Email
										</label>
								</div>
								
								
								<%
								}
								%>
							
                                
                                <div id="my-error-message">
                                <%
								String errorMessage1 = (String) session.getAttribute("errorMessage1");
								String message1 = (String) session.getAttribute("message1");
								if (errorMessage1 != null) {
								%>
								<div class="alert alert-danger"><%=errorMessage1%></div>
								<%
								session.removeAttribute("errorMessage1");
								} else if (message1 != null) {
								%>
                                <div class="alert alert-success"><%=message1%></div>
                                <%
                                session.removeAttribute("message1");
								}
                                %>
                             </div>

								<button class="pushable-button" id="save-username-changes"
									type="submit">Save changes</button>
							</form>
						</div>
					</div>
					<div id="password-panel" class="tab-panel" style="display: none;">
						<div class="profile-password-change">
							<form id="password-form"
								action="<%=request.getContextPath()%>/admin/editprofile?changedField=password"
								method="POST">
								<input type="hidden" name="activeTab" value="password-panel">
								<div class="md-outlined-text-field input-container">
									<input type="password" name="oldpassword" id="oldpassword"
										placeholder=""> <label for="oldpassword" required>Current
										password</label>
									<i class="far fa-eye-slash toggle-password" data-toggle="#oldpassword"></i>
								</div>
								<div class="md-outlined-text-field input-container">
									<input type="password" name="newpassword" id="newpassword"
										placeholder=""> <label for="newpassword" required>New
										password</label>
									<i class="far fa-eye-slash toggle-password" data-toggle="#newpassword"></i>
								</div>

								<div class="md-outlined-text-field input-container">
									<input type="password" name="confirmpassword"
										id="confirmpassword" placeholder="" required> <label
										for="confirmpassword">Confirm password</label>
									<i class="far fa-eye-slash toggle-password" data-toggle="#confirmpassword"></i>
								</div>


								<br>
								<%
								String errorMessage = (String) session.getAttribute("errorMessage");
								String message = (String) session.getAttribute("message");
								if (errorMessage != null) {
								%>
								<div class="alert alert-danger"><%=errorMessage%></div>
								<%
								session.removeAttribute("errorMessage");
								} else if (message != null) {
								%>
                                <div class="alert alert-success"><%=message%></div>
                                <%
                                session.removeAttribute("message");
								}
                                %>

								<button class="pushable-button" id="save-password-changes"
									type="submit">Save changes</button>
								
							</form>



						</div>
					</div>
				</div>

			</div>
		</div>
		<br> <br> <br>
		<footer class="footer" style="position: absolute; bottom: 0;">
			&copy;
			<script>
				document.write(new Date().getFullYear())
			</script>
	  , Friendship-driven, code-powered 💻❤️

		</footer>
	</div>

	
	<script>
		
		const infoTab = document.getElementById("info-tab");
		const passwordTab = document.getElementById("password-tab");
		const infoPanel = document.getElementById("info-panel");
		const passwordPanel = document.getElementById("password-panel");

		
		const activeTab = "<%= activeTab %>";
		if (activeTab === "password-panel") {
			passwordTab.classList.add("is-active");
			passwordPanel.style.display = "flex";
		} else {
			infoTab.classList.add("is-active");
			infoPanel.style.display = "flex";
		}

		
		infoTab.addEventListener("click", function() {
			setActiveTab(infoTab, infoPanel);
			
		});

		passwordTab.addEventListener("click", function() {
			setActiveTab(passwordTab, passwordPanel);
			
		});

		function setActiveTab(tab, panel) {
			infoTab.classList.remove("is-active");
			passwordTab.classList.remove("is-active");
			infoPanel.style.display = "none";
			passwordPanel.style.display = "none";

			tab.classList.add("is-active");
			panel.style.display = "flex";
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









<script>
document.getElementById("username-form").addEventListener("submit", function(event) {
    var emailInput = document.getElementById('email-to-change');
    var emailPattern = /^[a-zA-Z0-9._%+-]+@quizoverflow\.com$/;
    
    
    
    
    
    if (!emailPattern.test(emailInput.value)) {
        event.preventDefault(); 
        var div = document.getElementById('my-error-message');
        div.innerHTML = `
            <div class="alert alert-danger">Email must follow pattern something@quizoverflow.com!</div>`;
    }
});


</script>






</body>
</html>
