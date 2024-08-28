<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, java.util.*, model.UserDatabaseService, model.QuizDatabaseService"%>
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
	href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
<link href="<%=request.getContextPath()%>/css/usermanagement.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/inbox.css"
	rel="stylesheet" type="text/css">
<title>User management</title>

</head>
<body>
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
			</div>
			<div class="right">
			<div class="div-container" style="width: 100%; padding-bottom:5px;">
	       <button class="user-pushable-button add-user-btn" data-toggle="tooltip">ADD NEW USER</button>
			<dialog id="dialog-add-user"
													class="mdl-dialog my-dialog">
												
												<div class="mdl-dialog__content">
													<form id="add-user-form" 
													action="<%=request.getContextPath()%>/admin/adduser"
														method="POST">
														<h4>Add new user: </h4>
														<div class="md-outlined-text-field">
														
															<input type="text" name="email"
																id="email"
																placeholder="" required>
															<label for="email">Email</label>
														</div>
														<div class="md-outlined-text-field">
														
															<input type="text" name="username"
																id="username"
																placeholder="" required>
															<label for="username">Username</label>
														</div>
														<div class="md-outlined-text-field input-container">
									<input type="password" name="password" id="password"
										placeholder=""> <label for="password" required>
										Password</label>
									<i class="far fa-eye-slash toggle-password" data-toggle="#password"></i>
								</div>	
					
														<div class="md-outlined-text-field">
														
															<input type="text" name="role"
																id="role"
																placeholder="">
															<label for="role" required>Role</label>
														</div>
													<div id="email-error"></div>	
														<button class="pushable-button" id="add-user-dlg"
									type="submit">Add user</button>
														
													</form>
												</div>
												<div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close" style="margin-right:20px;">Cancel</button>
												</div>
												</dialog>
			
			</div>
				<div class="row">
					<div class="col-12">
						<div class="card my-4">
							<div
								class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
								<div
									class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
									<h5 class="text-white text-capitalize ps-3">LIST OF USERS</h5>
								</div>
							</div>
							<div class="card-body px-0 pb-2">
								<div class="table-responsive p-0">
									<table class="table align-items-center mb-0">
										<thead>
											<tr>
												<th class="text-uppercase font-weight-bolder"
													style="font-size: 16px;">User<img src="<%=request.getContextPath()%>/images/sort.png" alt="sort-icon" class="sort" style="padding-left: 10px;" id="sort-img"></th>
												<th
													class="text-uppercase text-secondary font-weight-bolder ps-2"
													style="font-size: 16px;">Role</th>
												<th
													class="text-center text-uppercase text-secondary font-weight-bolder"
													style="font-size: 16px;">Join Date</th>
												<th
													class="text-center text-uppercase text-secondary font-weight-bolder"
													style="font-size: 16px;">Number of quizzes</th>
												
												<th
													class="text-center text-uppercase text-secondary font-weight-bolder"
													style="font-size: 16px;"></th>
												<th
													class="text-center text-uppercase text-secondary font-weight-bolder"
													style="font-size: 16px;"></th>
											</tr>
										</thead>
										<tbody id="user-table-body">
											<%
											UserDatabaseService service = new UserDatabaseService();
										QuizDatabaseService serviceQuiz = new QuizDatabaseService();
											List<User> usersList = service.getUsers();
											Integer numOfQuizzes;
											for (User user : usersList) {
												numOfQuizzes = serviceQuiz.getNumOfQuizzes(user.getEmail());
												Integer avatarNum = user.getAvatar();
												String avatar = String.valueOf(avatarNum);
											%>
											<tr>
												<td>
													<div class="d-flex px-2 py-1">
														<div>
														<a href="<%=request.getContextPath()%>/admin/updateavatar?id=<%=user.getEmail()%>">
															<img
																src="<%=request.getContextPath()%>/images/avatars/<%=avatar%>.jpg"
																class="avatar avatar-sm me-3" alt="user1">
														</a>
														</div>
														<div class="d-flex flex-column justify-content-center">
															<h6 class="mb-0" style="font-size: 16px;"><%=user.getUsername()%></h6>
															<p class="text-secondary mb-0 font-weight-bolder"><%=user.getEmail()%></p>
														</div>
													</div>
												</td>
												<td>
													<h6 class="mb-0" style="font-size: 15px;"><%=user.getRole()%></h6>
												</td>
												<td class="align-middle text-center">
													<h6 class="mb-0" style="font-size: 15px;"><%=user.getJoinDate()%></h6>
												</td>
												<td class="align-middle text-center">
													<h6 class="mb-0" style="font-size: 15px;"><%=numOfQuizzes%></h6>
												</td>
												

												<td class="align-middle text-center"><a
													class="text-secondary font-weight-bold change-user-btn"
													data-toggle="tooltip" data-original-title="Edit user"
													data-user-id="<%=user.getEmail()%>"> <img
														src="<%=request.getContextPath()%>/images/change-user.png"
														alt="change-user-icon" class="avatar avatar-xs me-3">
												</a></td>
												<dialog id="dialog-<%=user.getEmail()%>"
													class="mdl-dialog my-dialog">
												
												<div class="mdl-dialog__content">
													<form id="edit-form-<%=user.getEmail()%>" 
													action="<%=request.getContextPath()%>/admin/usermanagement"
														method="POST">
														<h4>Change user information: </h4>
														  <input type="hidden" name="id" value="<%=user.getEmail()%>">
														<div class="md-outlined-text-field">
														
															<input type="text" name="email"
																id="email-<%=user.getEmail()%>"
																value="<%=user.getEmail()%>">
															<label for="email-<%=user.getEmail()%>">Email</label>
														</div>
														<div class="md-outlined-text-field">
														
															<input type="text" name="username"
																id="username-<%=user.getEmail()%>"
																value="<%=user.getUsername()%>">
															<label for="username-<%=user.getEmail()%>">Username</label>
														</div>
														<div class="md-outlined-text-field">
														
															<input type="text" name="role"
																id="role-<%=user.getEmail()%>"
																value="<%=user.getRole()%>">
															<label for="role-<%=user.getEmail()%>">Role</label>
														</div>
														
														
														
														<button class="pushable-button"
									type="submit">Save changes</button>
														
													</form>
												</div>
												<div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close" style="margin-right:20px;">Close</button>
												</div>
												</dialog>

												<td class="align-middle text-center"><a
													class="text-secondary font-weight-bold delete-user-btn"
													data-toggle="tooltip" data-original-title="Delete user" data-user-id="<%=user.getEmail()%>">
														<img src="<%=request.getContextPath()%>/images/xIcon.png"
														alt="x-icon" class="avatar avatar-xs me-3">
												</a></td>
                                               	<dialog id="dialog-<%=user.getEmail()%>-delete"
													class="mdl-dialog my-delete-dialog">
												<%
												User currentUser = (User) request.getSession().getAttribute("currentUser");
												if (!user.getEmail().equals(currentUser.getEmail())) {
												
												
												%>
												<form id="delete-form-<%=user.getEmail()%>" 
													action="<%=request.getContextPath()%>/admin/deleteuser"
														method="POST">
												<div class="mdl-dialog__content">
														<h5>Are you sure you want to delete user with email: <%=user.getEmail()%> ? </h5>
														  <input type="hidden" name="userToDelete" value="<%=user.getEmail()%>">
														  	</div>
														 <div class="mdl-dialog__actions">
														<button class="mdl-button confirm"
									type="submit">Yes</button>
														</div>
													</form>
											
												<div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close">No</button>
												</div>
												<%
												}  else {
												%>
													<div class="mdl-dialog__content">
													
														<h5>You can not delete current user. </h5>
													
												</div>
												     <div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close">Ok</button>
												</div>
												
												
												
												<% } %>
						
												</dialog>
											</tr>


											<%
											}
											%>
										</tbody>
									</table>
									<div class="pagination-container">
    <ul id="pagination" class="pagination"></ul>
</div>
									
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<footer class="footer" id="inbox-footer">
			&copy;
			<script>
				document.write(new Date().getFullYear())
			</script>
			  , Friendship-driven, code-powered 💻❤️

		</footer>
	</div>


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
		document.addEventListener('DOMContentLoaded', function() {
			
			document.querySelectorAll('.change-user-btn').forEach(
					function(button) {
						button.addEventListener('click', function() {
							var userId = this.getAttribute('data-user-id');
							var dialog = document.getElementById('dialog-'
									+ userId);
							if (!dialog.showModal) {
								dialogPolyfill.registerDialog(dialog);
							}
							dialog.showModal();

							
							dialog.querySelector('.close').addEventListener(
									'click', function() {
										dialog.close();
									});
						});
					});
			
		});
		
	</script>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			
			document.querySelectorAll('.delete-user-btn').forEach(
					function(button) {
						button.addEventListener('click', function() {
							var userId = this.getAttribute('data-user-id');
							var dialog = document.getElementById('dialog-'
									+ userId +'-delete');
							if (!dialog.showModal) {
								dialogPolyfill.registerDialog(dialog);
							}
							dialog.showModal();

							
							dialog.querySelector('.close').addEventListener(
									'click', function() {
										dialog.close();
									});
						});
					});
			
		});
		
	</script>
	<script>
    document.addEventListener('DOMContentLoaded', function() {
        var button = document.querySelector('.add-user-btn');
        if (button) {
            button.addEventListener('click', function() {
                var dialog = document.getElementById('dialog-add-user');
                if (dialog) {
                    if (!dialog.showModal) {
                        dialogPolyfill.registerDialog(dialog);
                    }
                    dialog.showModal();

                    var closeButton = dialog.querySelector('.close');
                    if (closeButton) {
                        closeButton.addEventListener('click', function() {
                            dialog.close();
                        });
                    }
                }
            });
        }
    });
</script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const rowsPerPage = 5;
    const tableBody = document.getElementById('user-table-body');
    let rows = Array.from(tableBody.querySelectorAll('tr'));
    const paginationContainer = document.getElementById('pagination');

    function displayRows(page) {
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        rows.forEach((row, index) => {
            row.style.display = (index >= start && index < end) ? '' : 'none';
        });
    }

    function setupPagination() {
        const pageCount = Math.ceil(rows.length / rowsPerPage);
        paginationContainer.innerHTML = '';

        for (let i = 1; i <= pageCount; i++) {
            const li = document.createElement('li');
            li.className = 'page-item';
            const a = document.createElement('a');
            a.className = 'page-link';
            a.href = '#';
            a.innerText = i;

            a.addEventListener('click', (e) => {
                e.preventDefault();
                displayRows(i);
                document.querySelectorAll('.page-item').forEach(item => item.classList.remove('active'));
                li.classList.add('active');
            });

            li.appendChild(a);
            paginationContainer.appendChild(li);
        }

       
        if (paginationContainer.firstChild) {
            paginationContainer.firstChild.classList.add('active');
        }
    }

    function sortRows() {
        rows.sort((a, b) => {
            const userA = a.querySelector('td:nth-child(1) h6').innerText.toLowerCase();
            const userB = b.querySelector('td:nth-child(1) h6').innerText.toLowerCase();
            return userA.localeCompare(userB);
        });

        rows.forEach(row => tableBody.appendChild(row));
    }

    
   
    setupPagination();
    displayRows(1);

   
    const sortImg = document.getElementById('sort-img');
    sortImg.addEventListener('click', () => {
        sortRows();
        setupPagination();
        displayRows(1);
    });
});
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

	<script src="<%=request.getContextPath()%>/js/popper.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/perfect-scrollbar.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/smooth-scrollbar.min.js"></script>
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
document.getElementById("add-user-form").addEventListener("submit", function(event) {
    var emailInput = document.getElementById('email');
    var emailPattern = /^[a-zA-Z0-9._%+-]+@quizoverflow\.com$/;
    
   
    
    
    
    if (!emailPattern.test(emailInput.value)) {
        event.preventDefault(); 
        var div = document.getElementById('email-error');
        div.innerHTML = `
            <div class="alert alert-danger">Email must follow pattern something@quizoverflow.com!</div>`;
    }
});


</script>
	
	
	
	
	
	
</body>
</html>
