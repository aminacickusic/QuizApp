<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User, model.InboxMessage, java.util.*, model.UserDatabaseService, model.QuizDatabaseService, java.time.format.DateTimeFormatter"%>
    
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
	<link href="<%=request.getContextPath()%>/css/adminquiz.css"
	rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/css/inbox.css"
	rel="stylesheet" type="text/css">
<title>Inbox</title>
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
			<%
			User user = (User) request.getSession().getAttribute("currentUser");
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
		
				<div class="row">
					<div class="col-12">
						<div class="card my-4">
							<div
								class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
								<div
									class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
									<h5 class="text-white text-capitalize ps-3">INBOX MESSAGES</h5>
								</div>
							</div>
							<div class="card-body px-0 pb-2">
								<div class="table-responsive p-0">
									<table class="table align-items-center mb-0">
										<thead>
											<tr>
												<th class="text-uppercase font-weight-bolder"
													style="font-size: 16px;"></th>
											
											<th
													class="text-center text-uppercase text-secondary font-weight-bolder"
													style="font-size: 16px;"></th>
											
												<th
													class="text-center text-uppercase text-secondary font-weight-bolder"
													style="font-size: 16px;"></th>
											</tr>
										</thead>
										<tbody id="inbox-table-body">
									<%
									UserDatabaseService service = new UserDatabaseService();
									List<InboxMessage> messages = service.getMyMessages((String)request.getAttribute("userID"));
									
									
									for (InboxMessage message : messages) {
										
									%>
												<tr>
												<td>
													<div class="d-flex px-2 py-1">
														
														<div class="d-flex flex-column justify-content-center" style="cursor: pointer;">
														<a class="read-msg-btn" data-toogle="tooltip" data-read-msg-id="<%=message.getId()%>">
														<%
														if (message.isRead()==true) { 
														%>
															<h6 class="mb-0" style="font-size: 16px; font-weight: 200;"><%=message.getMessageText()%></h6>
															
														<% } else {
														%>
															
														
														<h6 class="mb-0" style="font-size: 16px;"><%=message.getMessageText()%></h6>
															
														<%
														}
														%>
														</a>
						                                 
															
															
															
															
														</div>
													</div>
												</td>
													<dialog id="dialog-<%=message.getId()%>-read" class="mdl-dialog my-delete-dialog" style="width: 50%;">
												
												<form id="read-form-<%=message.getId()%>" 
													action="<%=request.getContextPath()%>/admin/inbox"
														method="POST">
												<input type="hidden" name="phase" value="read-msg">
												<div class="mdl-dialog__content">
														<p style="color: black; font-size: 16px;"><%=message.getMessageText()%></p>
														
														
														  <input type="hidden" name="msgToRead" value="<%=message.getId()%>">
														  	</div>
														 <div class="mdl-dialog__actions">
														<button class="mdl-button confirm" id="read-msg-dlg"
									type="submit">Close</button>
														</div>
													</form>
										
												</dialog>
												<td class="align-middle text-center">
												<%
												DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy 'at' HH:mm");

												
												String formattedDateTime = message.getDateTime().format(formatter);
		
												%>
												
													<h6 class="text-secondary font-weight-bold"><%=formattedDateTime%></h6>
												</td>
												<td class="align-middle text-center"><a
													class="text-secondary font-weight-bold delete-msg-btn"
													data-toggle="tooltip" data-original-title="Delete message" data-msg-id="<%=message.getId()%>">
														<img src="<%=request.getContextPath()%>/images/xIcon.png"
														alt="x-icon" class="avatar avatar-xs me-3">
												</a></td>
                                               	<dialog id="dialog-<%=message.getId()%>-delete"
													class="mdl-dialog my-delete-dialog">
												
												<form id="delete-form-<%=message.getId()%>" 
													action="<%=request.getContextPath()%>/admin/inbox"
														method="POST">
												<input type="hidden" name="phase" value="delete-msg">
												<div class="mdl-dialog__content">
														<h5>Are you sure you want to permanently delete this message? </h5>
														  <input type="hidden" name="msgToDelete" value="<%=message.getId()%>">
														  	</div>
														 <div class="mdl-dialog__actions">
														<button class="mdl-button confirm" id="delete-msg-dlg"
									type="submit">Yes</button>
														</div>
													</form>
											
												<div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close">No</button>
												</div>
												
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
		document.addEventListener('DOMContentLoaded', function() {
			
			document.querySelectorAll('.delete-msg-btn').forEach(
					function(button) {
						button.addEventListener('click', function() {
							var msgId = this.getAttribute('data-msg-id');
							var dialog = document.getElementById('dialog-'
									+ msgId +'-delete');
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
			
			document.querySelectorAll('.read-msg-btn').forEach(
					function(button) {
						button.addEventListener('click', function() {
							var msgId = this.getAttribute('data-read-msg-id');
							var dialog = document.getElementById('dialog-'
									+ msgId +'-read');
							if (!dialog.showModal) {
								dialogPolyfill.registerDialog(dialog);
							}
							dialog.showModal();

							
						
						});
					});
			
		});
		
	</script>
	
	
	
	
	
	
	
	
	
	

<script>
document.addEventListener('DOMContentLoaded', function() {
    const rowsPerPage = 5;
    const tableBody = document.getElementById('inbox-table-body');
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

   

    
   
    setupPagination();
    displayRows(1);

   
    
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
</body>
</html>