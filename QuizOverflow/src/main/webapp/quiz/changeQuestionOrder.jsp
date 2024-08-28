<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, java.util.*, model.UserDatabaseService, model.QuizDatabaseService, model.Quiz, model.Question"%>
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
<link href="<%=request.getContextPath()%>/css/changeorder.css"
	rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dragula/3.7.3/dragula.min.css">
<title>Change question order</title>



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
			<div class="choose-avatar">DRAG & DROP TO CHANGE ORDER OF QUESTIONS: </div>
		</div>
	</section>
		<br> 
		<div class="main-div-container">
	         <%
	         Integer quizID = (Integer) request.getSession().getAttribute("quizID");
	         QuizDatabaseService service = new QuizDatabaseService();
	         Quiz quiz = service.getQuizById(quizID);
	         List<Question> questions = quiz.getQuestionsList();
	         %>
	         
	         <div id="left-container" class="question-container">
	         
	         
	         <%
	         for (int i=0; i<questions.size(); i++) {
	         %>
	         
	    <div style="width: 85%; cursor: move; padding-top: 5px; padding-bottom: 5px;display: flex; 
	    align-items: center; justify-content: center;" id="question<%=questions.get(i).getOrdinalNum()%>">
		<div class="md-outlined-text-field" style="width: 70%;">
		<input type="text" name="txt-<%=questions.get(i).getOrdinalNum()%>" 
		id="txt-<%=questions.get(i).getOrdinalNum()%>"
		 value="<%=questions.get(i).getQuestion()%>"> 
		 <label for="txt-<%=questions.get(i).getOrdinalNum()%>">Question <%=questions.get(i).getOrdinalNum()%></label>
		</div>
	    </div>
			<%
	         }
			%>
				
				
		</div>		
		<div style="width: 100%; display: flex; align-items: center; justify-content: center;">
		<div style="padding-left: 5px;">
		                        <form action="<%=request.getContextPath()%>/admin/savequizchanges" method="POST" id="order-change-form">
		                        <input type="hidden" name="phase" value="save-order-changes">
		                         <input type="hidden" name="quizID" value="<%=quiz.getQuizID()%>" id="quizID">
		                          
								<button type="button" class="pushable-button"
							style="padding-left: 30px; padding-right: 30px;" onclick="saveOrderChanges()">Save changes</button>
							
							
							
							</form>
								</div>
		<div style="padding-left: 5px;">  
		                       <form action="<%=request.getContextPath()%>/admin/savequizchanges" method="post"> 
		                         <input type="hidden" name="phase" value="discard-order-changes">
		                         <input type="hidden" name="quizID" value="<%=quiz.getQuizID()%>" id="quizID">               
								<button type="submit" class="pushable-button"
							style="padding-left: 30px; padding-right: 30px;" >Discard changes</button>
								
								</form>
								
								
								</div>
		
		</div>
		
			
		</div>								
	<br>
	<br>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/dragula/3.7.3/dragula.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
           
            dragula([document.getElementById('left-container')])
                .on('drag', function (el) {
                  
                   
                })
                .on('drop', function (el, target, source, sibling) {
                  
                 
                });
        });
    </script>
	<script>
  function saveOrderChanges() {
   
    const container = document.getElementById('left-container');

   
    const questions = container.querySelectorAll('[id^="question"]');

    
    let order = [];

    
    questions.forEach((question, index) => {
      const questionId = question.id.replace('question', '');
      order.push(questionId);
    });

    
    const orderInput = document.createElement('input');
    orderInput.type = 'hidden';
    orderInput.name = 'order';
    orderInput.value = order.join(',');

   
    const form = document.getElementById('order-change-form');
    form.appendChild(orderInput);

   
    form.submit();
  }
</script>
	
	
</body>
</html>
