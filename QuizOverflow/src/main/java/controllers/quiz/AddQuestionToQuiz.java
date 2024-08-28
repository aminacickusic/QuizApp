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

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddQuestionToQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddQuestionToQuiz() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer quizID = (Integer) request.getSession().getAttribute("quizID");
		request.setAttribute("quizID", quizID);
		QuizDatabaseService service = null;
		try {
			service = new QuizDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
		}

		List<String> colorsList = service.getColors();
		request.getSession().setAttribute("colors", colorsList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/quiz/addQuestionToQuiz.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("quit") != null) {

			request.getSession().setAttribute("quizID", request.getParameter("quizID"));
			response.sendRedirect(request.getContextPath() + "/admin/editquiz");

		} else {

			String questionText = request.getParameter("question");
			Integer numOfAnswers = Integer.parseInt(request.getParameter("total-num-answers"));
			Integer time = Integer.parseInt(request.getParameter("time"));
			Integer points = Integer.parseInt(request.getParameter("points"));
			Integer quizID = Integer.parseInt(request.getParameter("quizID"));
			QuizDatabaseService service = null;
			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
			Quiz quiz = service.getQuizById(quizID);

			String phase = request.getParameter("question-phase");
			Integer ordinalNum = quiz.getQuizQuestionNumber() + 1;
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
			if (phase.equals("save-quiz")) {

				Integer qid = service.createQuestion(question);
				for (int k = 0; k < question.getNumOfAnswers(); ++k) {
					question.getAnswersList().get(k).setQuestionID(qid);
					service.createAnswer(question.getAnswersList().get(k));
				}

				quiz.setQuizQuestionNumber(ordinalNum);

				service.updateQuestionNumber(quiz);
				request.getSession().removeAttribute("currentQuiz");
				request.getSession().setAttribute("currentQuiz", quiz);
				request.getSession().setAttribute("quizID", quizID.toString());
				response.sendRedirect(request.getContextPath() + "/admin/editquiz");

			}
		}
	}

}
