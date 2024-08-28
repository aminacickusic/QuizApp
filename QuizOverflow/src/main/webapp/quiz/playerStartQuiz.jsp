<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Quiz</title>
<link href="<%=request.getContextPath()%>/css/admineditprofile.css"
	rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Lexend:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link rel="icon" href="<%=request.getContextPath()%>/images/logo.png"
	type="image/x-icon">
<link href="<%=request.getContextPath()%>/css/admineditprofile.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link href="<%=request.getContextPath()%>/css/nucleo-icons.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/nucleo-svg.css"
	rel="stylesheet" />
<link id="pagestyle"
	href="<%=request.getContextPath()%>/css/material-dashboard.css?v=3.0.0"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/otp-input.css" />
<link href="<%=request.getContextPath()%>/css/startpage.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/chooseavatar.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/otp-input.css" />
<script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<style>
.active-border {
border: 4px solid #e53270; 


}



</style>

</head>
<body>

	<input type="hidden" id="quiz-id-value" value="" name="quiz-id-value">



	<div class="main-content-container" id="main1">
		<div style="width: 70%;">
			<img src="<%=request.getContextPath()%>/images/logo-color.png"
				alt="logo-image" class="logo-image-navbar">


		</div>

		<br>
		<div class="text-container">

			<div class="choose-avatar">Enter Quiz PIN</div>
		</div>
		<br>
		<div id="otp-input" class="font-h2-strong">
			<input class="font-h2-strong" placeholder="_" type="number" step="1"
				min="0" max="9" autocomplete="no" pattern="\d*" id="pin1" /> <input
				class="font-h2-strong" placeholder="_" type="number" step="1"
				min="0" max="9" autocomplete="no" pattern="\d*" id="pin2" /> <input
				class="font-h2-strong" placeholder="_" type="number" step="1"
				min="0" max="9" autocomplete="no" pattern="\d*" id="pin3" /> <input
				class="font-h2-strong" placeholder="_" type="number" step="1"
				min="0" max="9" autocomplete="no" pattern="\d*" id="pin4" /> <input
				class="font-h2-strong" placeholder="_" type="number" step="1"
				min="0" max="9" autocomplete="no" pattern="\d*" id="pin5" /> <input
				class="font-h2-strong" placeholder="_" type="number" step="1"
				min="0" max="9" autocomplete="no" pattern="\d*" id="pin6" /> <input
				id="otp-value" placeholder="_" type="hidden" name="otp" />
		</div>
		<br>
		<button id="submit">Submit</button>
		<a href="<%=request.getContextPath()%>/startPage">
			<h2 class="font-text-large-1" class="go-back">Go back</h2>
		</a> <br>
		<div>
			<footer class="footer">
				&copy;
				<script>
				document.write(new Date().getFullYear())
			</script>
				, Friendship-driven, code-powered 💻❤️

			</footer>
		</div>


	</div>
	<div class="main-content-container" id="main2" style="display: none;">
		<div style="height: 100%; width: 100%; background-color: pink;">

		</div>
	</div>
	<div class="main-content-container" id="main3" style="display: none;">
		<div
			style="height: 100%; width: 100%; background-color: pink; display: flex; flex-direction: column; justify-content: center; align-items: center;">



			<h2 id="h2-start-soon">
				THE <span id="quiz-name"
					style="font-size: 2rem; font-weight: bold; color: #e53270;"></span> QUIZ WILL
				START SOON... 
			</h2>
			<br>
			<br>
			<div id="waiting-gif-div">
			<img src="<%=request.getContextPath()%>/images/medo.gif" alt="bear-gif" style="width: 200px; height:200px;">
			
			</div>
			<br>
			<br>
			

			<div id="p2"
				class="mdl-progress mdl-js-progress mdl-progress__indeterminate"></div>
			<div id="timer" class="font-text-large-1" style="display: none; color: black; font-size: 20px;">
				Time Left: <span id="time-left"></span>
			</div>

			<br>
			<h2 class="font-text-large-1" id="quit" style="cursor: pointer;">QUIT</h2>

		</div>
	</div>
	  <div class="my-content-container" style="width: 100%; display: none; align-items: center;" id="main4">
   
      
      </div>



	<dialog id="dialog-add-player" class="mdl-dialog my-dialog"
		style="width: 60%;">

	<div class="mdl-dialog__content">

		<h4 class="header-dlg">Enter your first and last name to
			continue...</h4>

		<div class="md-outlined-text-field">

			<input type="text" name="first-name" id="first-name" placeholder=""
				required> <label for="first-name">First name</label>
		</div>
		<div class="md-outlined-text-field">

			<input type="text" name="last-name" id="last-name" placeholder=""
				required> <label for="last-name">Last name</label>
		</div>
		<p>Choose your avatar</p>
		<div style="width: 100%; display: flex; align-items: center; justify-content: space-between;">
		<input type="hidden" name="chosenPlayerImage" value="1" id="chosenPlayerImage">
		   <%
		   for (int i=0; i<8; i++) {
			   if (i==0) {
			%>
			<div style="width: 60px; height: 60px; border: 1px solid black;">
			<img class="player-icon active-border" id="<%=i+1%>" style="width: 60px; height: 60px;" src="<%=request.getContextPath()%>/images/players/<%=i+1%>.png">   
			</div>
			<%} else { %>
			<div style="width: 60px; height: 60px; border: 1px solid black;">
			<img class="player-icon" id="<%=i+1%>" style="width: 60px; height: 60px;" src="<%=request.getContextPath()%>/images/players/<%=i+1%>.png">   
			</div>
			
			<%
			}
			%>
			
			   
			   
	    <% 
		   }
	    %>		   
		   
		   
		
		
		
		
		</div>

        <br>
        <br>
		<button class="pushable-button" id="add-player-btn" type="button">START</button>
		<br>
		<br>
		<h2 class="font-text-large-1" id="quit-from-dialog" style="cursor: pointer;">QUIT</h2>
	</div>
	</dialog>
	<dialog id="dialog-invalid-pin" class="mdl-dialog my-dialog">


	<div class="mdl-dialog__content">

		<h5>There is no active quiz corresponding to entered pin.</h5>

	</div>
	<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button close">Ok</button>
	</div>





	</dialog>
	<dialog id="dialog-disconnect" class="mdl-dialog my-dialog">


	<div class="mdl-dialog__content">

		<h5>It seems your host has ended quiz &#128546;. Hope to see you
			again!</h5>

	</div>
	<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button" id="close-disconnect">Ok</button>
	</div>

	</dialog>

   
   	<dialog id="dialog-did-not-join" class="mdl-dialog my-dialog">
	<div class="mdl-dialog__content">

		<h5>Quiz already started! Join us in next round! &#128522;</h5>

	</div>
	<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button" id="close-not-join">Ok</button>
	</div>

	</dialog>


	<dialog id="dialog-finished-quiz" class="mdl-dialog my-dialog">
	<div class="mdl-dialog__content">

		<h5 id="finish-quiz-h5"></h5>

	</div>
	<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button" id="close-finished-quiz">Ok</button>
	</div>

	</dialog>



	<script src="<%=request.getContextPath()%>/js/otp-input.js"></script>
	<script>
        const socket = new WebSocket("ws://localhost:8080/RI601-projekat-najdabeganovic-aminacickusic/quiz");
        let selectedAnswers = new Set();
        
        let name = "";
        let lastName = "";
        let myRank = 0;
        let firstTimer=true;
        socket.onopen = function(event) {
            document.getElementById('submit').addEventListener('click', function () {
                
                event.preventDefault();
                 var pin1 = (document.getElementById('pin1').value).toString();
                 var pin2 = (document.getElementById('pin2').value).toString();
                 var pin3 = (document.getElementById('pin3').value).toString();
                 var pin4 = (document.getElementById('pin4').value).toString();
                 var pin5 = (document.getElementById('pin5').value).toString();
                 var pin6 = (document.getElementById('pin6').value).toString();
                 var pin = pin1+pin2+pin3+pin4+pin5+pin6;
                
          
                
                
                var a = "CHECK_PIN:" + pin;
                
                socket.send(a);
                  
                 
                 
                  
                });
            
            
            
           
          
         
        };
        
        
        
        
          
        socket.onmessage = function(event) {
            var message = event.data;
            try {
            	messageData = JSON.parse(message);
            	switch (messageData.action) {
            	case 'NEXT_QUESTION':
            	
            	  renderQuestion(messageData);
                 
            	break;
            	case 'topTen':
            		
            		renderTopTenTable(messageData);
            		selectedAnswers = new Set();
            		
            		break;
            	case 'YOUR_SCORE':
            		
            		
            		
            		
            		break;
            	case 'SIGNUP_SUCCESSFUL':
            		name = messageData.Name;
            		lastName = messageData.lastName;
            		
            		waitForQuizToStart();
            	
            		break;
            	}
            	
            	
            }
            catch (e) {
            if (message.startsWith("PIN_INVALID")) {
                invalidPin();
            } else if (message.startsWith("PIN_OK")) {
                validPin();
            } else if (message.startsWith("ADMIN_DISCONNECTED")) {
            	hostDisconnected();
            } else if (message.startsWith("QUIZNAME:")) {
            	
            	document.getElementById('quiz-name').innerText = message.substring(9);
            } else if (message.startsWith("TIME_LEFT:")) {
                const timeLeft = parseInt(message.split(":")[1]);
                if (firstTimer===true) {
                	firstTimer=false;
                	updateScene();
                }
               
                
                updateTimer(timeLeft);
            } else if (message.startsWith("QUESTION_TIME_LEFT:")) {
            	 const timeLeft = parseInt(message.split(":")[1]);
            	 document.getElementById("current-time").innerText = timeLeft;
                 
            } else if (message.startsWith("RETURN_QUESTION_RESULTS")) {
            	const selectedAnswersArray = Array.from(selectedAnswers);
                
              
                const message = JSON.stringify({
                    action: "SUBMIT_ANSWERS",
                    answers: selectedAnswersArray
                });
                
               
                
                socket.send(message);
                
                
            	
            	
            	
            } else if (message.startsWith("PLAYERSCONNECTED:")) {
            	var el = document.getElementById('connected-players-q');
            	if (el) {
                 el.innerText = message.substring(17);
            	}
            } else if (message.startsWith("QUIZ STARTED, DID NOT JOIN"))  {
            	didNotJoin();
            	
            	
            	
            } else if (message.startsWith("YOU HAVE FINISHED QUIZ")) {
            	youFinishedQuiz();
            	
            	
            }
            }
            
        };
        
        
        
        socket.onerror = function(event) {
            console.error("WebSocket error observed:", event);
        };

        socket.onclose = function(event) {
            
        };
        
        
        function updateScene() {
        	 document.getElementById('p2').style.display = 'none';
             document.getElementById('timer').style.display = 'block';
             document.getElementById('h2-start-soon').innerText = 'THE QUIZ IS ABOUT TO START... GET READY!';
             document.getElementById('waiting-gif-div').innerHTML =  `
            		<img src="<%=request.getContextPath()%>/images/walking_medo.gif" alt="bear-gif" style="width: 200px; height:200px;">`;
        	 
        }
        
        
        
        
        
        

      function invalidPin() {
    	  document.getElementById('pin1').value ="";
          document.getElementById('pin2').value ="";
          document.getElementById('pin3').value ="";
          document.getElementById('pin4').value ="";
          document.getElementById('pin5').value ="";
          document.getElementById('pin6').value ="";
    	  
          var dialog = document.getElementById('dialog-invalid-pin');
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
    	  
      }

      function validPin() {
    	  document.getElementById('main1').style.display = 'none';
          document.getElementById('main2').style.display = 'block';
   
                      var dialog = document.getElementById('dialog-add-player');
                      if (dialog) {
                          if (!dialog.showModal) {
                              dialogPolyfill.registerDialog(dialog);
                          }
                          dialog.showModal();

                      }
      }
      
      document.getElementById('add-player-btn').addEventListener('click', function () {
    	  var avatar = document.getElementById('chosenPlayerImage').value;
    	  var firstName = document.getElementById('first-name').value;
    	  var lastName = document.getElementById('last-name').value;
    	  var name = firstName + "/" + lastName + "/" + avatar;
    	  
    	 
    	  socket.send("NAME:"+name);
    	  
      });
      
      
      function waitForQuizToStart() {
    	  var dialog = document.getElementById('dialog-add-player');
    	  if (dialog) {
    		  dialog.close();
    	  }
    	  document.getElementById('main2').style.display = 'none';
    	  document.getElementById('main3').style.display = 'block';
    	 

    	  
      }
      
      function hostDisconnected() {
    	  var dialog = document.getElementById('dialog-disconnect');
          if (dialog) {
              if (!dialog.showModal) {
                  dialogPolyfill.registerDialog(dialog);
              }
              dialog.showModal();

              
        
              
          }
      }
      
      
     
      
      document.getElementById('close-disconnect').addEventListener('click', function() {
	        document.getElementById('dialog-disconnect').close();
	        window.location.href = "<%=request.getContextPath()%>/startPage";
	});
      
      document.getElementById('quit-from-dialog').addEventListener('click', function() {
	        document.getElementById('dialog-add-player').close();
	        window.location.href = "<%=request.getContextPath()%>/startPage";
	});  
      
      
      function didNotJoin() {
    	  var dialog = document.getElementById('dialog-did-not-join');
          if (dialog) {
              if (!dialog.showModal) {
                  dialogPolyfill.registerDialog(dialog);
              }
              dialog.showModal();

              
        
              
          }
      }
      
      
      
  function youFinishedQuiz() {
	  document.getElementById('finish-quiz-h5').innerHTML =`
	  <h5>Congratulations! You have finished
	  <span id="myRank"></span>  
	  ! Thanks for participating. Join us in next journey. &#128522; </h5>`;
	 document.getElementById('myRank').innerText = myRank;
	  var dialog = document.getElementById('dialog-finished-quiz');
      if (dialog) {
          if (!dialog.showModal) {
              dialogPolyfill.registerDialog(dialog);
          }
          dialog.showModal();

          
    
          
      }
	  
	  
	  
  }

      
      
     
      
      document.getElementById('close-not-join').addEventListener('click', function() {
	        document.getElementById('dialog-did-not-join').close();
	        window.location.href = "<%=request.getContextPath()%>/startPage";
	});
      
      
      
      document.getElementById('close-finished-quiz').addEventListener('click', function() {
	        document.getElementById('dialog-finished-quiz').close();
	        window.location.href = "<%=request.getContextPath()%>/startPage";
	});
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      

		function updateTimer(timeLeft) {
			const timerElement = document.getElementById('time-left');
			timerElement.innerText = timeLeft;

			if (timeLeft <= 0) {
				
				document.getElementById('timer').style.display = 'none';
				
			}
		}
		
		
	
		

		function handleAnswerClick(event) {
		    const divElement = event.currentTarget;
		    const answerText = divElement.querySelector('.host-answer-text').innerText;
		   

		    
		   
		    if (divElement.style.borderColor === 'rgb(229, 50, 112)') {
		       
		        divElement.style.borderColor = '';
		        divElement.style.borderWidth = '1px';
		        selectedAnswers.delete(answerText);
		    } else {
		        
		        divElement.style.borderColor = 'rgb(229, 50, 112)';
		        divElement.style.borderWidth = '4px';
		        selectedAnswers.add(answerText);
		    }

		    
		}
		
		function addClickEventToAnswers() {
		    const answerDivs = document.querySelectorAll('.host-answer');
		    answerDivs.forEach(div => {
		    
		        div.addEventListener('click', handleAnswerClick);
		    });
		}
		
		
		
		  function renderQuestion(question) {
	            document.getElementById('main3').style.display = 'none';
	            document.getElementById('main4').style.display = 'flex';
	            document.getElementById('main4').innerHTML = `
	            	<div id="render-question-div"></div>`;
	            document.getElementById('render-question-div').innerHTML = `
	                <div id="part-left">
	                   <div class="image-quiz-left">
	                 
	                   	<img alt="quiz-image-icon" id="quiz-image-left">
	                   
	                   </div>
	                  
	                   <div>
	                   <h2 class="choose-avatar" style="width: 90%; text-align: center; font-size: 25px; color: dark grey;" id="host-quiz-name"></h2>
	                  </div>
	                  
	                  
	                  <div class="circular-points">
	                  	 <span id="points-to-achieve"></span>
	                   	 <span id="span-text">POINTS</span>
	                   </div>
	                  
	                  
	                </div>
	               
	                <div id="part-middle">
	                    <div id="question-number" class="choose-avatar" style="font-size: 25px;  "></div>
	                    <br>
	                    <br>
	                    <br>
	                	<div id="middle-part"></div>
                         <br>
	                	<div id="end-part"></div>
	                </div>
	                <br>
	                <div id="part-right">
	                    <div id="connected-pl-div">
	                        <img src="<%=request.getContextPath()%>/images/quizImages/pl-connected.png" alt="active-players" id="active-players">
	            			<div id="connected-players-q" style="height: 20vh; color: black; font-size: 35px; padding-top: 10px; font-weight: 500; margin-left: 10px;"></div>
	            		</div>
	            		<div class="span-btn-div">
	            		    <div class="circular-timer">
	                 		<span style="font-size: 35px;" id="current-time"></span>
	                 		</div>
	                 		<br>
	                		<button id="terminate-quiz-btn" class="terminate-quiz-btn" onclick="terminateQuiz()">QUIT</button>
	                	</div>
	                </div>
	                
	              
	            `;
	            
	  
	  document.getElementById('host-quiz-name').style.color = 'darkgrey';    
	  document.getElementById('host-quiz-name').innerText =  question.quizName;
	  document.getElementById('middle-part').style.borderBottomWidth = '4px';
	  document.getElementById('middle-part').style.borderBottomStyle = 'solid';
	  document.getElementById('middle-part').style.borderBottomColor = 'pink'; 
	  document.getElementById('middle-part').innerText = question.question;
	  document.getElementById('connected-players-q').innerText = question.connectedPlayers;      
	  document.getElementById('current-time').innerText = question.time;      
	  document.getElementById('quiz-image-left').src = "<%=request.getContextPath()%>/images/quizImages/"+ question.quizImage;  
	  document.getElementById('question-number').innerText = "QUESTION " + question.ordinalNum;      
	  document.getElementById('question-number').style.color = 'black';   
      document.getElementById('points-to-achieve').innerText = question.points;
  
	           for (var m=0; m<question.numOfAnswers; ++m) { 	  
	           
	            	  
	            	  const newDiv = document.createElement('div');
	            	  newDiv.className = 'host-answer';
	            	  const middle = document.createElement('div');
	            	  middle.className = 'host-answer-text';
	            	  middle.innerText = question.answersList[m].answer;
	                  newDiv.appendChild(middle);
	                  document.getElementById('end-part').appendChild(newDiv);
	                  middle.style.color = 'black';
	                  const spaceDiv = document.createElement('div');
	                  spaceDiv.style.height = '15px';
	                  document.getElementById('end-part').appendChild(spaceDiv); 
	                  
	        	 

	           }
	       
	          
	           addClickEventToAnswers();
	        }
		
		  function renderTopTenTable(topTenList) {
	           
	            document.getElementById('main3').style.display = 'none';
	            document.getElementById('main4').innerHTML = '';
	            document.getElementById('main4').style.display = 'flex';

	           
	            const mainDiv = document.createElement('div');
	            mainDiv.id = 'top-ten-table-div';
	            mainDiv.style.width = '90%';

	            mainDiv.innerHTML = `
	            	<br>
	            	<br>
	                <div class="row">
	                    <div class="col-12">
	                        <div class="card my-4">
	                            <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
	                                <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
	                                    <h5 class="text-white text-capitalize ps-3">TOP TEN PLAYERS</h5>
	                                </div>
	                            </div>
	                            <div class="card-body px-0 pb-2">
	                                <div class="table-responsive p-0">
	                                    <table class="table align-items-center mb-0">
	                                        <thead>
	                                            <tr>
	                                                <th class="text-center text-uppercase text-secondary font-weight-bolder" style="font-size: 16px;">RANK</th>
	                                                <th class="text-center text-uppercase text-secondary font-weight-bolder"
														style="font-size: 16px;"></th>
	                                                <th class="text-uppercase text-secondary font-weight-bolder ps-2" style="font-size: 16px;">FIRST NAME</th>
	                                                <th class="text-center text-uppercase text-secondary font-weight-bolder" style="font-size: 16px;">LAST NAME</th>
	                                                <th class="text-center text-uppercase text-secondary font-weight-bolder" style="font-size: 16px;">SCORE</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody id="topten-table-body">
	                                        </tbody>
	                                    </table>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            `;
	            document.getElementById('main4').appendChild(mainDiv);

	            const body = document.getElementById('topten-table-body');

	            
	            for (let i = 1; i <= topTenList.number; ++i) {
	                const player = topTenList[i];
	               
	                if (player) { 
	                    const tr = document.createElement('tr');

	                    if (player.name === name && player.lastName === lastName) {
	                    	tr.style.backgroundColor = 'pink';
	                        myRank = i;
	                    }
	                    const tdIndex = document.createElement('td');
	                    tdIndex.className = 'align-middle text-center';
	                   

	                   

	                    const h6Index = document.createElement('h6');
	                    h6Index.className = 'mb-0 align-middle text-center';
	                    h6Index.style.fontSize = '18px';
	                    h6Index.style.fontWeight = 'bold';
	                   
	                    h6Index.id = "rank" + i;

	                    
	                    tdIndex.appendChild(h6Index);
	                    
	                    const tdImg = document.createElement('td');
	                    tdImg.className = 'align-middle text-center';
	                  
	                 
	                    const avatarImg = document.createElement('img');
                        avatarImg.className = 'avatar avatar-sm me-3';
                        const path = '<%=request.getContextPath()%>/images/players/'+ player.avatar + '.png';
                        avatarImg.src = path;
                        tdImg.appendChild(avatarImg);
                        
	                    
	                    
	                    
	                    
	                    
	                    
	                    const tdName = document.createElement('td');
	                    const h6Name = document.createElement('h6');
	                    h6Name.className = 'mb-0';
	                    h6Name.style.fontSize = '15px';
	                    h6Name.id = "name"+i;
	                    tdName.appendChild(h6Name);

	                    const tdLastName = document.createElement('td');
	                    tdLastName.className = 'align-middle text-center';
	                    const h6LastName = document.createElement('h6');
	                    h6LastName.className = 'mb-0';
	                    h6LastName.style.fontSize = '15px';
	                    h6LastName.id = "lastName" + i;
	                    tdLastName.appendChild(h6LastName);

	                    const tdScore = document.createElement('td');
	                    tdScore.className = 'align-middle text-center';
	                    const h6Score = document.createElement('h6');
	                    h6Score.className = 'mb-0';
	                    h6Score.style.fontSize = '15px';
	                    h6Score.id = "score"+i;
	                    tdScore.appendChild(h6Score);

	                    tr.appendChild(tdIndex);
	                    tr.appendChild(tdImg);
	                    tr.appendChild(tdName);
	                    tr.appendChild(tdLastName);
	                    tr.appendChild(tdScore);

	                    body.appendChild(tr);
	                    
	                    document.getElementById('rank'+i).innerText = i;
	                    document.getElementById('name'+i).innerText = player.name;
	                    document.getElementById('lastName'+i).innerText = player.lastName;
	                    document.getElementById('score'+i).innerText = player.score;

                    
	                }
	               
	            }
	            
	           
	            
	            const button = document.createElement('button');
	            button.onclick = terminateQuiz;
	            button.className = 'terminate-quiz-btn';
	            button.innerText = 'QUIT';
	            const bDiv = document.createElement('div');
	            bDiv.style.width = '100%';
	            bDiv.style.display = 'flex';
	            bDiv.style.justifyContent = 'flex-end';
	            bDiv.style.paddingRight = '15px';
	            bDiv.appendChild(button);
	            document.getElementById('main4').appendChild(bDiv);
	        }
		  
		  
		  
		  function terminateQuiz() {
        	  window.location.href = "<%=request.getContextPath()%>/startPage";
        }
		
	</script>
								
		<script>
function handlePlayerImageClick(event) {
	const allImages = document.querySelectorAll('.player-icon');
	allImages.forEach(img => img.classList.remove('active-border'));

	const clickedImage = event.target;
	if (clickedImage && clickedImage.classList.contains('player-icon')) {
		clickedImage.classList.add('active-border');

		const chosenAvatarInput = document.getElementById('chosenPlayerImage');
		
		chosenAvatarInput.value = clickedImage.id;
	}
}


const avatarImages = document.querySelectorAll('.player-icon');
avatarImages.forEach(img => {
	img.addEventListener('click', handlePlayerImageClick);
});
	</script>						
	
	
	
	
	
</body>
</html>