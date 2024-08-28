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
<link href="<%=request.getContextPath()%>/css/usermanagement.css"
	rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/css/chooseavatar.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/addnewquiz.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Add new quiz</title>
<script>
function uploadImage() {
    var formData = new FormData();
    var fileInput = $('#quizImage')[0];
    formData.append('quizImage', fileInput.files[0]);
    formData.append('phase', 'selecting-image');

    $.ajax({
        url: '<%=request.getContextPath()%>/admin/addnewquiz',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(response) {
            if (response.success) {
                var imgElement = $('.btn-circle-quiz img');
                imgElement.attr('src', '<%=request.getContextPath()%>/images/quizImages/' + response.imagePath);
                var img = $('#hidden-image');
                img.attr('value', response.imagePath);
            } else {
                alert('Image upload failed.');
            }
        },
        error: function() {
            alert('Image upload failed.');
        }
    });
}
</script>

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
				</div>
			</nav>
			<div class="choose-avatar">ADD NEW QUIZ: </div>
		</div>
	</section>
		<div style="padding-left: 15px; padding-top: 10px;">
	
	                            <form action="<%=request.getContextPath()%>/admin/addnewquiz" method="POST" id="go-back-form">
	                            <input type="hidden" name="phase" value="go-back">
	                            
								<button type="submit" class="pushable-button"
							style="padding-left: 30px; padding-right: 30px;">Go back</button>
							</form>
								</div>
							<div style="display: flex; width: 100%;">
						<div class="choose-quiz-img">


                            <div style="display: flex; width: 50%; justify-content: center; align-items: center;">
							<button class="btn-circle-quiz">
								<i><%
								String path;
								
								if (request.getSession().getAttribute("imagePath")!=null) {
									path = request.getContextPath() + "/images/quizImages/"+request.getSession().getAttribute("imagePath");
									
									
								} else {
									
									path = request.getContextPath() + "/images/defaultQuiz.png";
									
								}
								
								%>
								<img
									src="<%=path%>"
									alt="quiz-image" class="quiz-icon">
								</i>
							</button>
							</div>
							<div style="width: 50%; display: flex; flex-direction: column; justify-content: center;">
							
    
    <input type="file" id="quizImage" name="quizImage" /><br/>
    
    <br> 
                                <div style="padding-left: 5px;">
								<button type="button" class="pushable-button" id="upload-image" onclick="uploadImage()"
							style="padding-left: 30px; padding-right: 30px;">Upload image</button>
								</div>
							
							
							
							</div>
						</div>
						<div class="quiz-setup">
						<form id="create-quiz-form"
								action="<%=request.getContextPath()%>/admin/addnewquiz"
								method="POST" style="width: 70%;">
								  <input type="hidden" name="image" value="" id="hidden-image">
								  <input type="hidden" name="phase" value="create">
								<div class="md-outlined-text-field">
									<input type="text" name="quizname" id="quizname"
										placeholder="" required> <label
										for="quizname">Quiz Name</label>
								</div>
								<div class="md-outlined-text-field">
									<input type="text" id="theme" placeholder="" name="theme" required>
										 <label for="theme">Theme
										</label>
								</div>
								
								
								<button class="pushable-button" id="create-quiz-btn"
									type="submit">Create quiz</button>
									</form>
								</div>
							
						</div>
					
	
		<footer class="footer" style="position: absolute; bottom: 0;">
			&copy;
			<script>
				document.write(new Date().getFullYear())
			</script>
			 , Friendship-driven, code-powered 💻❤️

		</footer>
	</div>
</body>
</html>
