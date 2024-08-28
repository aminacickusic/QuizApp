<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, java.util.*, model.UserDatabaseService, model.QuizDatabaseService, model.Question"%>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Edit question</title>
<script>
let count = 0;

function createCounter() {
    return function() {
        return ++count;
    }
}

const counter = createCounter();

function updateIDs() {
    const answerDivs = document.querySelectorAll('.answer');
    count = answerDivs.length;
    answerDivs.forEach((div, index) => {
        const newCount = index + 1;
        div.id = 'answer' + newCount;
        
        const inputName = div.querySelector('input[type="text"]');
        inputName.id = 'answer' + newCount;
        inputName.name = 'answer' + newCount;
        inputName.setAttribute('for', 'answer' + newCount);

        const inputCheckbox = div.querySelector('input[type="checkbox"]');
        inputCheckbox.id = 'isCorrect' + newCount;
        inputCheckbox.name = 'isCorrect' + newCount;

        const deleteButton = div.querySelector('img');
        deleteButton.id = 'img' + newCount;
        deleteButton.setAttribute('data-index', newCount);
    });
    document.getElementById('total-num-answers').value = count;
}




function deleteAnswer(event) {
    const img = event.target;
    const answerDiv = img.closest('.answer');
    if (answerDiv) {
        answerDiv.remove();
        updateIDs();
    } else {
        console.error("Answer div not found");
    }
}



function checkAtLeastOneTrue() {
    const checkboxes = document.querySelectorAll('.answer input[type="checkbox"]');
    for (const checkbox of checkboxes) {
        if (checkbox.checked) {
            return true;
        }
    }
    return false;
}


function isAnyFieldEmpty() {
    const questionField = document.getElementById('question').value.trim();
    if (questionField === '') {
        return true;
    }

    const answerDivs = document.querySelectorAll('.answer input[type="text"]');
    for (const input of answerDivs) {
        if (input.value.trim() === '') {
            return true;
        }
    }

    return false;
}


function numOfAnswers() {
    var answersDiv = document.getElementById('answer-div');
    if (answersDiv) {
        return answersDiv.children.length;
    } else {
        return 0; 
    }
}




document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('add-answer').addEventListener('click', function(event) {
    	
        event.preventDefault();
        const countNum = numOfAnswers()+1;
        const count = countNum.toString();
        
        const newDiv = document.createElement('div');
        newDiv.className = 'answer';
        newDiv.id = 'answer' + count;
        newDiv.style.width = '100%'; 
        newDiv.style.display='flex';
        newDiv.style.justifyContent = 'center';
        newDiv.style.alignItems = 'center';
        const mdDiv = document.createElement('div');
        mdDiv.className = 'md-outlined-text-field';
        mdDiv.style.width = '80%';
        
        const inputName = document.createElement('input');
        inputName.type = 'text';
        inputName.id = 'answer' + count;
        inputName.name = 'answer' + count;
        inputName.required = true;
        
        const nlabel = document.createElement('label');
        nlabel.setAttribute('for', 'answer' + count);
        nlabel.textContent = 'Answer';
        
        mdDiv.appendChild(inputName);
        mdDiv.appendChild(nlabel);
        newDiv.appendChild(mdDiv);
        
        const cDiv = document.createElement('div');
        cDiv.style.width="20%";
        cDiv.style.paddingLeft="15px";
        cDiv.style.paddingTop="5px";
        
        const clabel = document.createElement('label');
        clabel.className = 'mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect';
        clabel.style.width = '35px';
        clabel.setAttribute('for', 'isCorrect' + count);
        
        const inputCheckbox = document.createElement('input');
        inputCheckbox.type = 'checkbox';
        inputCheckbox.id = 'isCorrect' + count;
        inputCheckbox.name = 'isCorrect' + count;
        inputCheckbox.className = 'mdl-checkbox__input checkbox';
        inputCheckbox.value = 'true';
        inputCheckbox.style.width = '35px';
        clabel.appendChild(inputCheckbox);
        cDiv.appendChild(clabel);
        
        const img = document.createElement('img');
        img.src = '<%=request.getContextPath()%>/images/quizImages/deleteAnswer.svg';
        img.style.width = '30px';
        img.style.height = '30px';
        img.style.paddingBottom = '5px';
        img.id = 'img' + count;
        img.setAttribute('data-index', count);
        img.addEventListener('click', deleteAnswer);

        const a = document.createElement('a');
        a.style.width = '60px';
        a.style.height = '30px';
        a.style.paddingLeft = '20px';
        a.appendChild(img);
        cDiv.appendChild(a);
        
        newDiv.appendChild(cDiv);
        
        document.getElementById('answer-div').appendChild(newDiv);
        document.getElementById('total-num-answers').value = countNum;
    });
    


    document.getElementById('save-question-changes-btn').addEventListener('click', function(event) {
        event.preventDefault();
        const answerDiv = document.getElementById('answer-div');
        if (isAnyFieldEmpty()) {
        	event.preventDefault();
            document.getElementById('dialog-empty-fields').showModal();
        } else if (answerDiv.children.length === 0) {
            event.preventDefault();
            document.getElementById('dialog-no-answer').showModal();
        } else if (!checkAtLeastOneTrue()) {
            event.preventDefault();
            document.getElementById('dialog-no-true-answer').showModal();
        } else {
        	 document.getElementById('phase').value = 'question-phase';
             document.getElementById('save-question-changes-form').submit();
        }
    });
    
    
    
    
});
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
			<div class="choose-avatar">EDIT QUESTION: </div>
		</div>
	</section>
		<br> 
		<div class="main-div" >
		<%
				
				
				
			    
				Integer questionID = (Integer) request.getSession().getAttribute("questionID");
				QuizDatabaseService service = new QuizDatabaseService();
				Question question = service.getQuestionById(questionID);
				List<String> colorsList = service.getColors();
				Integer i=0;
				Integer answersNumber = question.getNumOfAnswers();
				%>
		
		
		
				<div class="buttons-div">
				<div style="width: 20%; padding-left: 8%;">
				
				
				
				

		      <button class="color-button question-number-btn" style="background-color: <%=colorsList.get(i)%>"><%=question.getOrdinalNum()%></button>
				</div>
			
				</div>	
				<br>
				<form action="<%=request.getContextPath()%>/admin/savequizchanges" id="save-question-changes-form" method="POST" style="width: 100%;">
			    <input type="hidden" name="phase" value="" id="phase">
			    <input type="hidden" name="questionID" value="<%=question.getId()%>" id="questionID">
				<div class="question-txt-div">
				<div class="md-outlined-text-field" style="width: 80%;">
				<input type="text" name="question" id="question" value="<%=question.getQuestion()%>" required> 
				<label for="question">Question</label>
				</div>
				</div>
				<br>
				<div class="time-and-points">
				<div class="md-outlined-text-field" style="width: 35%;">
				<input type="number" name="points" id="points" value="<%=question.getPoints()%>"> 
				<label for="points">Points</label>
				</div>
				
				<div class="md-outlined-text-field" style="width: 35%;">
				<input type="number" name="time" id="time" value="<%=question.getTime()%>" min="10" max="60"> 
				<label for="time">Time in seconds (max 60s)</label>
				</div>
				
				</div>
				
				<div style="padding-left: 8%;">
				<button class="pushable-button" id="add-answer">Add answer</button>
				</div>
				<div class="answer-div" id="answer-div">
				<%
				for (int j=0; j<question.getNumOfAnswers(); j++) {
					
				%>
				<div class="answer" id="answer<%=j+1%>" style="width: 100%; display: flex; justify-content: center; align-items: center;">
				   <div class="md-outlined-text-field" style="width: 80%;">
				   <input type="text" id="answer<%=j+1%>" name="answer<%=j+1%>" value="<%=question.getAnswersList().get(j).getAnswer()%>">
				   <label for="answer<%=j+1%>">Answer</label>
				   </div>
				   <div style="width: 20%; padding-left: 15px; padding-top: 5px;">
				 <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" style="width: 35px;" for="isCorrect<%=j+1%>">
				   <%
				   if (question.getAnswersList().get(j).isTrue()) {
				   %>   
				   <input type="checkbox" id="isCorrect<%=j+1%>" name="isCorrect<%=j+1%>" class="mdl-checkbox__input checkbox" value="true" style="width: 35px;" checked>
				   <%
				   } else {
				   
				   %>
				      <input type="checkbox" id="isCorrect<%=j+1%>" name="isCorrect<%=j+1%>" class="mdl-checkbox__input checkbox" value="true" style="width: 35px;">
				   <%
				   
				   }
				   %>
				   </label>
				   <a style="width: 60px; height: 30px; padding-left: 20px;">
				   <img src="<%=request.getContextPath()%>/images/quizImages/deleteAnswer.svg" style="width: 30px; height: 30px; padding-bottom: 5px;" 
				   id="img<%=j+1%>" data-index="<%=j+1%>" onclick="deleteAnswer(event)">
				   
				   
				   </a>
				   
				   </div>
				</div>
				
				
				
				<%
				}
				%>
				
				</div>
				 <input type="hidden" name="total-num-answers" value="<%=question.getNumOfAnswers() %>" id="total-num-answers">
				 </form>
				 <br>
				<div class="next-question-btn">
				
			   
			   
			    <div style="display: flex; justify-content: flex-end;">
			    <button class="pushable-button" id="save-question-changes-btn" style="padding-left: 30px; padding-right: 30px;">Save changes</button>
			   
			    </div>
			    <br>
			    <div style="display: flex; justify-content: flex-end;">
			    	<form id="discard-changes-form" action="<%=request.getContextPath()%>/admin/editquiz" method="post">
			    	<input type="hidden" name="quizID" id="edit-quiz-id" value="<%=question.getQuizID()%>">
			    <button class="pushable-button" id="discard-changes" type="submit">Discard changes</button>
			    </form>
			    </div>
			    
				 
				</div>
				
				
							
		</div>
						<dialog id="dialog-no-answer"
													class="mdl-dialog my-delete-dialog">
												
												<div class="mdl-dialog__content">
														<h5>You need to add at least one answer before proceeding. </h5>
														  	</div>
												<div
													class="mdl-dialog__actions">
													<button type="button" class="mdl-button close" id="close">Ok</button>
												</div>
												</dialog>
												
												
												
		<dialog id="dialog-no-true-answer" class="mdl-dialog my-delete-dialog">
												
	       <div class="mdl-dialog__content">
          <h5>You need to have at least one true answer before proceeding. </h5>
		</div>
		<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button close" id="close1">Ok</button>
		</div>
	   </dialog>
												
		<dialog id="dialog-empty-fields" class="mdl-dialog my-delete-dialog">
												
	       <div class="mdl-dialog__content">
          <h5>Question/answer text can not be empty. </h5>
		</div>
		<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button close" id="close2">Ok</button>
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
	
	  document.getElementById('close').addEventListener('click', function() {
	        document.getElementById('dialog-no-answer').close();
	    });
	  
	  document.getElementById('close1').addEventListener('click', function() {
	        document.getElementById('dialog-no-true-answer').close();
	    });
	  document.getElementById('close2').addEventListener('click', function() {
	        document.getElementById('dialog-empty-fields').close();
	    });
	  
	  
	  document.getElementById('time').addEventListener('input', function() {
		    const value = parseInt(this.value, 10);

		    if (value < 0) {
		        this.value = 0;
		    } else if (value > 60) {
		        this.value = 60;
		    }
		});
	
	</script>
	
</body>
</html>
