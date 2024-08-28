package controllers.quiz;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Answer;
import model.Question;
import model.Quiz;
import model.QuizDatabaseService;
import model.UserDatabaseService;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AddQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddQuestion() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/quiz/addQuestion.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("quit")!=null) {
			QuizDatabaseService service=null;
			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {
				
				e.printStackTrace();
			}
			
			service.deleteQuiz((Quiz)request.getSession().getAttribute("currentQuiz"));
			request.getSession().removeAttribute("currentQuiz");
			request.getSession().removeAttribute("ordinalNumber");
			request.getSession().removeAttribute("colors");

            
			response.sendRedirect(request.getContextPath() + "/admin/quizmanagement");

		} else {

			String questionText = request.getParameter("question");
			Integer numOfAnswers = Integer.parseInt(request.getParameter("total-num-answers"));
			Integer time = Integer.parseInt(request.getParameter("time"));
			Integer points = Integer.parseInt(request.getParameter("points"));
			Quiz quiz = (Quiz) request.getSession().getAttribute("currentQuiz");

			String phase = request.getParameter("question-phase");
			Integer ordinalNum = (Integer) request.getSession().getAttribute("ordinalNumber");
			List<Answer> answersList = new ArrayList<Answer>();
			Question question = new Question(ordinalNum, quiz.getQuizID(), questionText, time, points, numOfAnswers,
					answersList);
			Integer i = 1;

			for (i = 1; i <= numOfAnswers; i++) {
				String answerID = "answer" + i;
				String isTrueID = "isCorrect" + i;
				String answerText = request.getParameter(answerID);
				boolean isTrue = (request.getParameter(isTrueID) != null) ? true : false;
				Answer answer = new Answer(answerText, isTrue);
				question.getAnswersList().add(answer);
			}
			quiz.getQuestionsList().add(question);
			if (phase.equals("next-question")) {
				request.getSession().removeAttribute("ordinalNumber");
				ordinalNum++;
				request.getSession().setAttribute("ordinalNumber", ordinalNum);
				response.sendRedirect(request.getContextPath() + "/admin/addquestion");
			} else if (phase.equals("save-quiz")) {
				quiz.setQuizQuestionNumber(ordinalNum);

				QuizDatabaseService service = null;
				try {
					service = new QuizDatabaseService();
				} catch (ClassNotFoundException | SQLException e) {
					e.printStackTrace();
				}

				for (int l = 0; l < quiz.getQuizQuestionNumber(); l++) {
					Question questionNew = quiz.getQuestionsList().get(l);
					Integer questionID = service.createQuestion(questionNew);
					quiz.getQuestionsList().get(l).setId(questionID);
					for (int m = 0; m < questionNew.getNumOfAnswers(); m++) {
						Answer answerNew = questionNew.getAnswersList().get(m);
						answerNew.setQuestionID(questionID);
						Integer answerID = service.createAnswer(answerNew);
						answerNew.setId(answerID);
						quiz.getQuestionsList().get(l).getAnswersList().set(m, answerNew);
					}
				}

				service.updateQuestionNumber(quiz);
				service.updateNumOfQuizzesPerUser(quiz.getQuizAuthor());
				service.addCreateDate(quiz.getQuizID(), LocalDate.now());
				request.getSession().removeAttribute("currentQuiz");
				request.getSession().setAttribute("currentQuiz", quiz);
				UserDatabaseService userService=null;
				try {
					userService = new UserDatabaseService();
				} catch (ClassNotFoundException | SQLException e) {
					
					e.printStackTrace();
				}
				LocalDateTime time2 = LocalDateTime.now();
				List<String> admins = userService.getAllUsers();
				for (int j=0; j<admins.size(); j++) {
					String message = "A new quiz, " + quiz.getQuizName() + " exploring the theme of, " + quiz.getQuizTheme() + " has been created by " + quiz.getQuizAuthor() + "."; 
					userService.insertInboxMessage(admins.get(j), message, time2);
				}
				response.sendRedirect(request.getContextPath() + "/admin/quizmanagement");

			}
		}
	}

}
