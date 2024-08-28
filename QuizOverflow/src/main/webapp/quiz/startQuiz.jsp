<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Quiz, model.QuizDatabaseService, model.Question, java.util.ArrayList, java.util.List, model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Quiz</title>

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="<%=request.getContextPath()%>/css/nucleo-icons.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/nucleo-svg.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link id="pagestyle"
	href="<%=request.getContextPath()%>/css/material-dashboard.css?v=3.0.0"
	rel="stylesheet" />
	<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Lexend:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet"
        />
        
        <link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
       <link href="<%=request.getContextPath()%>/css/addnewquiz.css"
	rel="stylesheet" type="text/css">
	
       <link rel="stylesheet" href="<%=request.getContextPath()%>/css/otp-input.css" />
       <link rel="icon" href="<%=request.getContextPath()%>/images/logo.png"
	type="image/x-icon">
 <link href="<%=request.getContextPath()%>/css/startpage.css" rel="stylesheet" type="text/css">
 <link href="<%=request.getContextPath()%>/css/adminquiz.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/chooseavatar.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/admineditprofile.css"
	rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

    </head>
    <body>
    <%
    Integer quizID = (Integer) request.getAttribute("quizID");
    Integer ordinalNumOfQuestion=0;
   
    QuizDatabaseService service = new QuizDatabaseService();
    Quiz quiz = service.getQuizById(quizID);
    List<Question> questions = new ArrayList<Question>();
    List<String> colorsList = service.getColors();
    for (int i=0; i<quiz.getQuizQuestionNumber(); ++i) {
    	Question q = service.getQuestionById(quiz.getQuestionsList().get(i).getId());
    	questions.add(q);
    }
    
    
    
    %>
        <div class="main-content-container" style="flex-direction: row; width: 100%;" id="main1">
     
        <div class="left-part" style="width: 40%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
        <div style="width: 95%; height: 50%; border-radius: 17px;">
				<img src="<%=request.getContextPath()%>/images/quizImages/<%=quiz.getQuizImg()%>" alt="quiz-img" style="width: 100%; height: 100%; border-radius: 17px;">			
		</div>
       
       
        
        </div>
      
        <div style="width: 60%; display: flex; flex-direction: column; justify-content: center; align-items: center; flex-grow: 1; row-gap: 29px;">
         <div style="height: 10vh;"></div>
         
         <div class="choose-avatar" style="width: 80%; font-size: 35px;"><%=quiz.getQuizName()%> </div>
            <div class="text-container">
               
                <h3 class="font-h2-strong">QUIZ PIN</h3>
            </div>

             <%
             User currentUser = (User) request.getSession().getAttribute("currentUser");
             Integer randomPin = Integer.parseInt( (String)  request.getAttribute("gamePin"));
             Integer adminPin = randomPin;
             Integer[] numbers = new Integer[6];
             Integer i=10;
             for (int k=5; k>=0; k--) {
            	 numbers[k]=randomPin%i;
            	 randomPin=(Integer) randomPin/10;
             }
             
             
             
             %>


             <div id="otp-input" class="font-h2-strong">
                <input class="font-h2-strong" value="<%=numbers[0] %>" type="number" step="1" min="0" max="9" autocomplete="no" pattern="\d*" readonly />
                <input class="font-h2-strong" value="<%=numbers[1]%>" type="number" step="1" min="0" max="9" autocomplete="no" pattern="\d*" readonly />
                <input class="font-h2-strong" value="<%=numbers[2] %>" type="number"    step="1" min="0" max="9" autocomplete="no" pattern="\d*" />
                <input class="font-h2-strong" value="<%=numbers[3] %>" type="number"              step="1" min="0" max="9" autocomplete="no" pattern="\d*" readonly/>
                <input class="font-h2-strong" value="<%=numbers[4] %>" type="number" step="1" min="0" max="9" autocomplete="no" pattern="\d*" readonly/>
                <input class="font-h2-strong" value="<%=numbers[5]%>" type="number" step="1" min="0" max="9" autocomplete="no" pattern="\d*" readonly/>
                <input id="otp-value" placeholder="_" type="hidden" name="otp" />
            </div>

            <div style="height: 20vh;" class="connected-pl">Players connected: 
            <br>
            <h1 id="connected-players" class="connected-num-of-players" style="text-align: center;">0</h1>
            
            
            
            </div> 
            
            
             <button id="start-quiz">START QUIZ</button>
               <div id="timer" class="font-text-large-1" style="display: none;">Time Left: <span id="time-left"></span></div>
            <a href="#"> <h2 class="font-text-large-1" id="cancel">Cancel</h2> </a> 
             
       
               <div class="container-footer">
	<footer class="footer">&copy;
		<script>
			document.write(new Date().getFullYear())
		</script>
	, Friendship-driven, code-powered 💻❤️
	</footer>
	</div>
            
            </div>
        </div>
        
      <div class="my-content-container" style="width: 100%; display: none;" id="main2">
   
      
      </div>
       <div class="my-content-container" style="width: 100%; display: none; align-items: center;" id="main3">
   
      
      </div>
      
      
      <dialog id="dialog-no-players" class="mdl-dialog my-dialog">


	<div class="mdl-dialog__content">

		<h5>Sorry, there are no players connected. &#128546;.</h5>

	</div>
	<div class="mdl-dialog__actions">
		<button type="button" class="mdl-button" id="close-no-players">Ok</button>
	</div>

	</dialog>
         <script>
         let count = 0;

         function createCounter() {
             return function() {
                 return ++count;
             }
         }

         const counter = createCounter();
    
        const socket = new WebSocket("ws://localhost:8080/RI601-projekat-najdabeganovic-aminacickusic/quiz");
       
      
        socket.onopen = function(event) {
           
           
            socket.send("ADMIN:admin");
            var pin = "ADMIN_SENT_PIN:" + <%=adminPin%>;
           
            socket.send(pin);
            var message = "ADMIN_SENT_QUIZ_ID:"+ <%=quiz.getQuizID()%>;
            socket.send(message);
        };
        
        
        
        
        socket.onmessage = function(event) {
            var message = event.data;
           
            try {
            	messageData = JSON.parse(message);
            	switch (messageData.action) {
            	case 'NEXT_QUESTION':
            	
            	  renderQuestion(messageData);
            	setQuestionTime(messageData.time);
            	break;
            	case 'topTen':
            		
            		renderTopTenTable(messageData);
            		
            		
            		break;
            	}
            	
            	
            } catch (e) {         
            
            
            
            
            if (message.startsWith("PLAYERSCONNECTED:")) {
                var el1 = document.getElementById('connected-players');
                if (el1) {
                el1.innerText = message.substring(17);
                }
                
                var el2 = document.getElementById('connected-players-q');
                if (el2) {
                el2.innerText = message.substring(17);
                }
                
                
            } else if (message.startsWith("NO MORE PLAYERS")) {
            	
            	noMorePlayers();
            	
            	
            	
            } 
         
        }
            
        };
        
        
        
        socket.onerror = function(event) {
            console.error("WebSocket error observed:", event);
        };

        socket.onclose = function(event) {
           
        };
      
        document.getElementById('cancel').addEventListener('click', function () {
        	
        	  window.location.href = "<%=request.getContextPath()%>/admin/quizmanagement";
              
            });
        
        function noMorePlayers() {
      	  var dialog = document.getElementById('dialog-no-players');
            if (dialog) {
                if (!dialog.showModal) {
                    dialogPolyfill.registerDialog(dialog);
                }
                dialog.showModal();

                
          
                
            }
        }
        
        
       
        
        document.getElementById('close-no-players').addEventListener('click', function() {
  	        document.getElementById('dialog-no-players').close();
  	        window.location.href = "<%=request.getContextPath()%>/admin/quizmanagement";
  	});
        
        
        
        
        
        let adminTimer;
        let timeLeft = 10;

        function startQuiz() {
            adminTimer = setInterval(() => {
                timeLeft--;
              
                
                const timerElement = document.getElementById('time-left');
        	    timerElement.innerText = timeLeft;

                socket.send("TIME_LEFT:" + timeLeft); 
                if (timeLeft <= 0) {
                    clearInterval(adminTimer);
                    startQuizQuestions();
                    document.getElementById('timer').style.display = 'none';
                    
                }
            }, 1000);
        }
        
        let questionTimer;
        function setQuestionTime(timeLeftToAns) {
            questionTimer = setInterval(() => {
                timeLeftToAns--;
              
                
                const timerElement = document.getElementById('current-time');
        	    timerElement.innerText = timeLeftToAns;

                socket.send("QUESTION_TIME_LEFT:" + timeLeftToAns); 
                if (timeLeftToAns <= 0) {
                    clearInterval(questionTimer);
                    socket.send("COLLECT_QUESTION_RESULTS");
                    
                }
            }, 1000);
        }
        

       
        
        document.getElementById('start-quiz').addEventListener('click', function() {
        	 document.getElementById('start-quiz').style.display = 'none';
             document.getElementById('timer').style.display = 'block';
             
             const timerElement = document.getElementById('time-left');
             socket.send("RESET_PIN");
     	    timerElement.innerText = timeLeft;
     	    startQuiz();
     	   

	    });
        
        
        
        
        
        function startQuizQuestions() {
     	   
     	 
     	        socket.send("SEND_NEXT_QUESTION:");
     	     
     	   
     	   
        }
        
      
        
        function renderQuestion(question) {
            document.getElementById('main1').style.display = 'none';
            document.getElementById('main3').style.display = 'none';
            document.getElementById('main2').style.display = 'flex';
            document.getElementById('main2').innerHTML =` <div id="render-question-div"></div>`;
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
                  const last = document.createElement('div');
                  last.className = 'host-answer-check';
                  const spanTrue = document.createElement('span');
                  const spanFalse = document.createElement('span');
                  spanTrue.className = 'badge badge-sm bg-gradient-success';
                  spanFalse.className = 'badge badge-sm bg-gradient-danger';
                  spanTrue.style.marginRight = '5px';
                  spanTrue.style.borderRadius = '10px';
                  spanFalse.style.marginRight = '5px';
                  spanFalse.style.borderRadius = '10px';
                  
                  spanTrue.innerText = 'Correct';
                  spanFalse.innerText = 'Incorrect';
                  if (question.answersList[m].isTrue===true) {
                	  last.appendChild(spanTrue);
                  } else {
                	  last.appendChild(spanFalse);
                  }
                  newDiv.appendChild(last);
                  document.getElementById('end-part').appendChild(newDiv);
                  const spaceDiv = document.createElement('div');
                  spaceDiv.style.height = '15px';
                  document.getElementById('end-part').appendChild(spaceDiv); 
                  
          
           }
       
        
        }
        
        
        function renderTopTenTable(topTenList) {
           
            document.getElementById('main2').style.display = 'none';
            document.getElementById('main1').style.display = 'none';
            document.getElementById('main3').style.display = 'flex';
            document.getElementById('main3').innerHTML ='';

          
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
            document.getElementById('main3').appendChild(mainDiv);

            const body = document.getElementById('topten-table-body');

            
            for (let i = 1; i <= topTenList.number; ++i) {
                const player = topTenList[i];
               
                if (player) { 
                    const tr = document.createElement('tr');

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
            if (topTenList.lastQuestion===false) {
            button.onclick = startQuizQuestions;
            button.className = 'pushable-button';
            button.innerText = 'NEXT QUESTION';
            button.id = 'next-q-btn';
            button.style.marginRight = '5px';
            const bDiv = document.createElement('div');
            bDiv.style.width = '100%';
            bDiv.style.display = 'flex';
            bDiv.style.justifyContent = 'center';
            
            bDiv.appendChild(button);
            
            
            
            const button1 = document.createElement('button');
            button1.onclick = terminateQuiz;
            button1.className = 'pushable-button';
            button1.innerText = 'QUIT';
           
            bDiv.appendChild(button1);
            
            
            
            
            
            document.getElementById('main3').appendChild(bDiv);
            } else {
            	 button.onclick = finishQuiz;
                 button.className = 'pushable-button';
                 button.style.marginRight = '5px';
                 button.innerText = 'FINISH QUIZ';
                 button.id = 'finish-q-btn';
                 const bDiv = document.createElement('div');
                 bDiv.style.width = '100%';
                 bDiv.style.display = 'flex';
                 bDiv.style.justifyContent = 'center';
                 const buttonDownload = document.createElement('button');
                 buttonDownload.onclick = function() {
                	    downloadQuizResults(topTenList); 
                 };
                 buttonDownload.className = 'pushable-button';
                 buttonDownload.innerText = 'SAVE RESULTS';
                 buttonDownload.style.marginRight = '5px';
                 buttonDownload.id = 'download-results-btn';
                 
                 
                 const buttonQuit = document.createElement('button');
                 buttonQuit.onclick = finishAndQuit;
                 buttonQuit.className = 'pushable-button';
                 buttonQuit.innerText = 'QUIT';
                 buttonQuit.id = 'quit-quiz-btn';
                 
                 
                 
                 bDiv.appendChild(button);
                 bDiv.appendChild(buttonDownload);
                 bDiv.appendChild(buttonQuit);
                 document.getElementById('main3').appendChild(bDiv);
            }
        }

        function terminateQuiz() {
        	  window.location.href = "<%=request.getContextPath()%>/admin/quizmanagement";
        }
        
        function finishQuiz() {
        	
        	socket.send("YOU HAVE FINISHED QUIZ:" + "<%=currentUser.getEmail()%>");
        }
        
        
        function downloadQuizResults(topTenList) {
        	const data = [
                ['Rank', 'First Name', 'Last Name', 'Score'] 
            ];

         
            for (let i = 1; i <= topTenList.number; ++i) {
                const player = topTenList[i];
                if (player) {
                    data.push([i, player.name, player.lastName, player.score]);
                }
            }

          
            const worksheet = XLSX.utils.aoa_to_sheet(data);

          
            const workbook = XLSX.utils.book_new();

           
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Top Ten Players');

          
            XLSX.writeFile(workbook, 'TopTenPlayersResults.xls');
            
               
                
                
        }
        
        function finishAndQuit() {
        	window.location.href = "<%=request.getContextPath()%>/admin/quizmanagement";
        }

    
        </script> 
        
        
    
    </body>
</html>