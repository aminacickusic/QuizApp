<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Quiz, java.util.*, model.UserDatabaseService, model.QuizDatabaseService, model.Question"%>
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
<link href="<%=request.getContextPath()%>/css/addnewquestion.css"
	rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/css/addnewquiz.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/editQuiz.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Edit quiz</title>
<script>
function uploadImage() {
    var formData = new FormData();
    var fileInput = $('#quizImage')[0];
    formData.append('quizImage', fileInput.files[0]);
    formData.append('phase', 'updating-image');

    $.ajax({
        url: '<%=request.getContextPath()%>/admin/savequizchanges',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(response) {
            if (response.success) {
                var imgElement = $('.btn-circle-quiz-edit img');
                imgElement.attr('src', '<%=request.getContextPath()%>/images/quizImages/' + response.imagePath);
                var img = $('#hidden-image');
                img.attr('value', response.imagePath);
                var newImg = $('#newImg');
                newImg.attr('value', response.imagePath);
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
			
		</div>
	</section>
	<div style="padding-left: 15px; padding-top: 10px;">
	
	                            <form action="<%=request.getContextPath()%>/admin/savequizchanges" method="POST" id="go-back-form">
	                            <input type="hidden" name="phase" value="go-back">
	                            
								<button type="button" class="pushable-button"
							style="padding-left: 30px; padding-right: 30px;" onclick="goBack()">Go back</button>
							</form>
								</div>
		<br> 
		<div class="main-div" >
		<div class="choose-avatar">EDIT QUIZ INFORMATION: </div>
		<%
	
		
		
		
		Integer quizID = Integer.parseInt( ( (String)request.getSession().getAttribute("quizID") ));
		
		
		
		
		QuizDatabaseService service = new QuizDatabaseService();
		
		
		
		Quiz quiz = service.getQuizById(quizID);
		
		
		%>
		<div class="upper-div">
			<div class="choose-edit-quiz-img" style="height: 25vh; width:30%;">


                            <div style="display: flex; width: 50%; justify-content: center; align-items: center;">
							<button class="btn-circle-quiz-edit">
								<i><%
								String path;
								if (request.getSession().getAttribute("imagePath")!=null) {
					path = request.getContextPath() + "/images/quizImages/"+request.getSession().getAttribute("imagePath");
									
									
								} else {
									
									path = request.getContextPath() + "/images/quizImages/"+quiz.getQuizImg();
									
								}
	
								%>
								<img
									src="<%=path%>"
									alt="quiz-image" class="quiz-edit-icon" id="edit-quiz-image">
								</i>
							</button>
							</div>
							<div style="width: 50%; display: flex; flex-direction: column; justify-content: center;">
							
    
    <input type="file" id="quizImage" name="quizImage" /><br/>
    
    <br> 
                                <div style="padding-left: 5px;">
								<button type="button" class="pushable-button" id="upload-image-edit" onclick="uploadImage()"
							style="padding-left: 30px; padding-right: 30px;">Upload image</button>
								</div>
							
							
							
							</div>
						</div>
		<div class="edit-quiz-name-div">
		   	<div class="md-outlined-text-field" style="width: 80%;">
					<input type="text" name="edit-quiz-name" id="edit-quiz-name" value="<%=quiz.getQuizName()%>" required> <label
				for="edit-quiz-name">Quiz Name</label>
			</div>
		
		</div>
		
		<div class="edit-author-and-theme">
		 	<div class="md-outlined-text-field" style="width: 80%;">
					<input type="text" name="edit-quiz-author" id="edit-quiz-author" value="<%=quiz.getQuizAuthor()%>" required readonly> <label
				for="edit-quiz-author">Quiz Author</label>
			</div>
			
			 	<div class="md-outlined-text-field" style="width: 80%;">
					<input type="text" name="edit-quiz-theme" id="edit-quiz-theme" value="<%=quiz.getQuizTheme()%>" required> <label
				for="edit-quiz-theme">Quiz Theme</label>
			</div>
		</div>
		</div>
		<br>
		<div style="width: 100%; display: flex; justify-content: center; align-items: center;">
								<%
								String errorMessage = (String) session.getAttribute("errorMessage2");
								String message = (String) session.getAttribute("message2");
								if (errorMessage != null) {
								%>
								<div class="alert alert-danger"><%=errorMessage%></div>
								<%
								session.removeAttribute("errorMessage2");
								} else if (message != null) {
								%>
                                <div class="alert alert-success"><%=message%></div>
                                <%
                                session.removeAttribute("message2");
								}
                                %>
         </div>
		<div style="width: 100%; display: flex; align-items: center; justify-content: center;">
		<div style="padding-left: 5px;">
		                        <form action="<%=request.getContextPath()%>/admin/savequizchanges" method="POST" id="information-change-form">
		                        <input type="hidden" name="phase" value="save-edit-changes">
		                         <input type="hidden" name="newName" value="" id="newName" required>
		                         <input type="hidden" name="newAuthor" value="" id="newAuthor" required>
		                         <input type="hidden" name="newTheme" value="" id="newTheme" required>
		                         <input type="hidden" name="quizID" value="<%=quiz.getQuizID()%>" id="quizID">
		                          <input type="hidden" name="newImg" value="<%=quiz.getQuizImg()%>" id="newImg">
								<button type="button" class="pushable-button"
							style="padding-left: 30px; padding-right: 30px;" onclick="saveInformationChanges()">Save changes</button>
							
							
							
							</form>
								</div>
		<div style="padding-left: 5px;">                  
								<button type="button" class="pushable-button"
							style="padding-left: 30px; padding-right: 30px;" onclick="discardChanges()">Discard changes</button>
								</div>
		
		</div>
		<br>
		<br>
		<div class="choose-avatar">EDIT QUESTION: </div>
		<div style="padding-left: 6%;">
		        <form action="<%=request.getContextPath()%>/admin/addquestiontoquiz" method="GET" style="width: 100%;">
		        <input type="hidden" name="quizID" value="<%=quiz.getQuizID()%>">
		        <%
		        request.getSession().setAttribute("quizID", quiz.getQuizID());
		        
		        
		        
		        %>
				<button class="pushable-button" id="add-question" type="submit">Add question</button>
				</form>
		</div>
		<br>
		<div class="lower-div">
		<%
		List<Question> questionList = quiz.getQuestionsList();
		for (Question question : questionList) {
		%>
		<div class="question" id="question<%=question.getOrdinalNum()%>">
		<div class="md-outlined-text-field" style="width: 80%;">
		<input type="text" name="question-txt-<%=question.getOrdinalNum()%>" id="question-txt-<%=question.getOrdinalNum()%>"
		 value="<%=question.getQuestion()%>" readonly> 
		 <label for="question-txt-<%=question.getOrdinalNum()%>">Question <%=question.getOrdinalNum()%></label>
		</div>
		
        <a style="width: 60px; height: 30px; padding-left: 20px;" class="edit-question-btn" data-question-id="<%=question.getId()%>">
		<img src="<%=request.getContextPath()%>/images/quizImages/editQuiz.svg" style="width: 30px; height: 30px;
		 padding-bottom: 5px;" id="edit-img<%=question.getOrdinalNum()%>" data-index="<%=question.getOrdinalNum()%>">
		
		</a>
		<a style="width: 60px; height: 30px; padding-left: 20px;" class="delete-question-btn" data-toggle="tooltip" data-question-id="<%=question.getId()%>">
		<img src="<%=request.getContextPath()%>/images/quizImages/deleteAnswer.svg" style="width: 30px; height: 30px;
		 padding-bottom: 5px;" id="delete-img<%=question.getId()%>" data-index="<%=question.getOrdinalNum()%>">
		</a>
		</div>
		
		
		
		
		
				 	<dialog id="dialog-<%=question.getId()%>-delete"
													class="mdl-dialog my-delete-dialog">
											
												<form id="delete-form-<%=question.getId()%>" 
													action="<%=request.getContextPath()%>/admin/savequizchanges"
														method="POST">
												
								<div class="mdl-dialog__content">
					<h5>Question will be permanently deleted. Are you sure that you want to proceed? </h5>
										<input type="hidden" name="questionToDelete" value="<%=question.getId()%>">
										<input type="hidden" name="phase" value="delete-question">
										<input type="hidden" name="quizID" value="<%=question.getQuizID()%>">
										<input type="hidden" name="questionOrdinalNumber" value="<%=question.getOrdinalNum()%>">
								<input type="hidden" name="numOfQuestions" value="<%=quiz.getQuizQuestionNumber()%>">
										
												</div>
														 <div class="mdl-dialog__actions">
														<button class="mdl-button confirm" id="delete-question-dlg"
									onclick="deleteQuestion(<%=question.getId()%>, <%=question.getOrdinalNum()%>)">Yes</button>
														</div>
													</form>
											
												<div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close">No</button>
												</div>
												</dialog>
	<form id="edit-question-form" action="<%=request.getContextPath()%>/admin/savequizchanges" method="POST">
		<input type="hidden" name="questionID" id="edit-question-id" value="">
		<input type="hidden" name="phase" value="edit-question">							
									
									
      </form>

	   <%
		}
		%>		
		</div>
		<div style="width: 100%; align-items: center; justify-content: center; display: flex;">
		<form action="<%=request.getContextPath()%>/admin/savequizchanges" method="post" >
		<input type="hidden" name="quizID" value="<%=quiz.getQuizID()%>">
		<input type="hidden" name="phase" value="change-question-order">
		  <button class="pushable-button" id="change-question-order-btn">Change order</button>
		</form>
		
		</div>		
		</div>
				<dialog id="dialog-empty-fields" class="mdl-dialog my-delete-dialog">
												
	       <div class="mdl-dialog__content">
          <h5>Fields can not be empty. </h5>
		</div>
		<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button close" id="close2">Ok</button>
		</div>
	   </dialog>		
	   
	   
	   
	   	<dialog id="dialog-no-question"
													class="mdl-dialog my-dialog">
												
												<div class="mdl-dialog__content">
													<form id="delete-anyway-form" 
													action="<%=request.getContextPath()%>/admin/savequizchanges"
														method="POST">
												<input type="hidden" name="quizID" value="<%=quiz.getQuizID()%>">
												 <input type="hidden" name="phase" value="delete-quiz-anyway">
												 <h5>There are no questions in this quiz. To proceed, please add at least one question or delete entire quiz.</h5>
														
														<div class="mdl-dialog__actions">
														<button type="button" class="mdl-button confirm ok">Delete quiz</button>
														</div>
													</form>
												</div>
												<div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close" style="margin-right:20px;">Cancel</button>
												</div>
												</dialog>
	   
																				
	<br>
	<br>
		<footer class="footer">
			&copy;
			<script>
				document.write(new Date().getFullYear())
			</script>
			 , Friendship-driven, code-powered 💻❤️

		</footer>
<script>
		document.addEventListener('DOMContentLoaded', function() {
			
			document.querySelectorAll('.delete-question-btn').forEach(
					function(button) {
						button.addEventListener('click', function() {
							var questionId = this.getAttribute('data-question-id');
							var dialog = document.getElementById('dialog-'
									+ questionId +'-delete');
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
	function deleteQuestion(questionId, ordinalNum) {
	    
	    var questionDiv = document.getElementById('question' + ordinalNum);
	    if (questionDiv) {
	        questionDiv.remove();
	    }
	    
	  
	    var form = document.getElementById('delete-form-' + questionId);
	    if (form) {
	        form.submit();
	    }
	}
	
	function isAnyFieldEmpty() {

	    const at = document.querySelectorAll('.edit-author-and-theme input[type="text"]');
	    for (const input of at) {
	        if (input.value.trim() === '') {
	            return true;
	        }
	    }

	    const name = document.querySelectorAll('.edit-quiz-name-div input[type="text"]');
	    for (const input of name) {
	        if (input.value.trim() === '') {
	            return true;
	        }
	    }

	    return false;
	}
	
	
	function goBack() {
		if (<%=questionList.size()%>==0) {
			var dialog = document.getElementById('dialog-no-question');
			if (!dialog.showModal) {
				dialogPolyfill.registerDialog(dialog);
			}
			dialog.showModal();

			
			dialog.querySelector('.close').addEventListener(
					'click', function() {
						dialog.close();
					});
			
			dialog.querySelector('.ok').addEventListener(
					'click', function() {
						document.getElementById('delete-anyway-form').submit()
					});
		} else {
			document.getElementById('go-back-form').submit();
		}
		
		
		
		
		
	}
	
	
	
	
	function discardChanges() {
	    document.getElementById('edit-quiz-name').value = '<%=quiz.getQuizName()%>';
	    document.getElementById('edit-quiz-author').value = '<%=quiz.getQuizAuthor()%>';
	    document.getElementById('edit-quiz-theme').value = '<%=quiz.getQuizTheme()%>';
	    document.getElementById('edit-quiz-image').src = '<%=request.getContextPath()%>/images/quizImages/<%=quiz.getQuizImg()%>';
	}
	
	
	function saveInformationChanges() {
		document.getElementById('newName').value = document.getElementById('edit-quiz-name').value;
	    document.getElementById('newAuthor').value = document.getElementById('edit-quiz-author').value;
	    document.getElementById('newTheme').value = document.getElementById('edit-quiz-theme').value;
	    if (isAnyFieldEmpty()) {
        	event.preventDefault();
            document.getElementById('dialog-empty-fields').showModal();
        } else {
	    document.getElementById('information-change-form').submit();
        }
	     
	 
	}
	
	
	 document.getElementById('close2').addEventListener('click', function() {
	        document.getElementById('dialog-empty-fields').close();
	    });
	
	
	</script>
	<script>
		$(document).ready(function() {
			$('.edit-question-btn').on('click', function() {
				var questionID = $(this).data('question-id');
				$('#edit-question-id').val(questionID);
				$('#edit-question-form').submit();
			});
		});
	</script>
	
	
</body>
</html>