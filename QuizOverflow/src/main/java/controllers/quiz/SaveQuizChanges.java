package controllers.quiz;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Answer;
import model.Question;
import model.Quiz;
import model.QuizDatabaseService;
import model.UserDatabaseService;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@MultipartConfig
public class SaveQuizChanges extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SaveQuizChanges() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/quiz/editQuiz.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("phase").equals("updating-image")) {
			Part file = request.getPart("quizImage");
			String imageFileName = file.getSubmittedFileName();
			String message = "";

			String projectPath = System.getProperty("user.dir");
			String uploadPath = projectPath
					+ "/eclipse-workspace/RI601-projekat-najdabeganovic-aminacickusic/src/main/webapp/images/quizImages/"
					+ imageFileName;

			boolean uploadSuccess = false;

			if (imageFileName != null && !imageFileName.isEmpty()) {
				try (InputStream is = file.getInputStream()) {
					Path filePath = Paths.get(uploadPath);
					Files.copy(is, filePath, StandardCopyOption.REPLACE_EXISTING);
					uploadSuccess = true;
				} catch (Exception e) {
					message = "Error while uploading image.";
					e.printStackTrace();
				}
			}

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			if (uploadSuccess) {
				String jsonResponse = String.format("{\"success\": true, \"imagePath\": \"%s\"}", imageFileName);
				response.getWriter().write(jsonResponse);
			} else {
				String jsonResponse = "{\"success\": false}";
				response.getWriter().write(jsonResponse);
			}
		} else if (request.getParameter("phase").equals("delete-question")) {
			Integer questionID = Integer.parseInt(request.getParameter("questionToDelete"));
			Integer questionOrdinalNumber = Integer.parseInt(request.getParameter("questionOrdinalNumber"));
			QuizDatabaseService service = null;
			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			}

			Integer quizID = Integer.parseInt(request.getParameter("quizID"));
			Integer quizNum = Integer.parseInt(request.getParameter("numOfQuestions"));
			service.deleteQuestionById(questionID);
			service.updateQuestionNumber(quizID, quizNum - 1);
			for (int i = questionOrdinalNumber; i <= quizNum; i++) {
				service.updateOrdinalNumber(quizID, i + 1, i);

			}

			
			request.getSession().setAttribute("quizID", quizID.toString());
			
			response.sendRedirect(request.getContextPath() + "/admin/editquiz");
		}

		else if (request.getParameter("phase").equals("go-back")) {
			response.sendRedirect(request.getContextPath() + "/admin/quizmanagement");
		}

		else if (request.getParameter("phase").equals("save-edit-changes")) {
			String newName = request.getParameter("newName");
			String newAuthor = request.getParameter("newAuthor");
			String newTheme = request.getParameter("newTheme");
			String newImg = request.getParameter("newImg");
			Integer quizID = Integer.parseInt(request.getParameter("quizID"));
			String errorMessage2 = "";
			String message2 = "";
			QuizDatabaseService service = null;
			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			}

			try {
				service.updateQuizInformation(quizID, newName, newAuthor, newTheme, newImg);
			} catch (Exception e) {
				errorMessage2 = "Something went wrong while updating. Please try again.";
				request.getSession().setAttribute("errorMessage2", errorMessage2);
				request.getSession().setAttribute("quizID", quizID.toString());
				response.sendRedirect(request.getContextPath() + "/admin/editquiz");
			}
			
			message2 = "Successfully updated.";
			request.getSession().setAttribute("message2", message2);
			request.getSession().setAttribute("quizID", quizID.toString());
			response.sendRedirect(request.getContextPath() + "/admin/editquiz");

		} else if (request.getParameter("phase").equals("edit-question")) {
			Integer questionID = Integer.parseInt(request.getParameter("questionID"));
			request.getSession().setAttribute("questionID", questionID);
			response.sendRedirect(request.getContextPath() + "/admin/editquestion");
		} else if (request.getParameter("phase").equals("question-phase")) {
			String questionText = request.getParameter("question");
			Integer numOfAnswers = Integer.parseInt(request.getParameter("total-num-answers"));
			Integer time = Integer.parseInt(request.getParameter("time"));
			Integer points = Integer.parseInt(request.getParameter("points"));
			Integer questionID = Integer.parseInt(request.getParameter("questionID"));

			
			QuizDatabaseService service = null;
			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			}
			List<Answer> answersList = new ArrayList<Answer>();
			Question q = service.getQuestionById(questionID);
			Question question = new Question(q.getOrdinalNum(), q.getQuizID(), questionText, time, points, numOfAnswers,
					answersList);
			Integer i;
			for (i = 1; i <= numOfAnswers; i++) {
				String answerID = "answer" + i;
				String isTrueID = "isCorrect" + i;
				String answerText = request.getParameter(answerID);
				boolean isTrue = (request.getParameter(isTrueID) != null) ? true : false;
				Answer answer = new Answer(answerText, isTrue);
				question.getAnswersList().add(answer);
			}


			service.deleteAnswersForQuestion(questionID);
			service.updateQuestion(question, questionID);

			request.getSession().setAttribute("quizID", q.getQuizID().toString());

			response.sendRedirect(request.getContextPath() + "/admin/editquiz");

		} else if (request.getParameter("phase").equals("change-question-order")) {
			Integer quizID = Integer.parseInt(request.getParameter("quizID"));
			request.getSession().setAttribute("quizID", quizID);
			response.sendRedirect(request.getContextPath() + "/admin/changequestionorder");

		} else if (request.getParameter("phase").equals("discard-order-changes")) {
			Integer quizID = Integer.parseInt(request.getParameter("quizID"));
			request.getSession().setAttribute("quizID", quizID.toString());
			response.sendRedirect(request.getContextPath() + "/admin/editquiz");
		} else if (request.getParameter("phase").equals("save-order-changes")) {
			String order = request.getParameter("order");
			Integer quizID = Integer.parseInt(request.getParameter("quizID"));
			String[] orderArray = null;
			
			if (order != null && !order.isEmpty()) {
				orderArray = order.split(",");

				
			}

			QuizDatabaseService service = null;
			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			}

			Quiz quiz = service.getQuizById(quizID);
			List<Integer> integerList = Arrays.stream(orderArray).map(Integer::parseInt).collect(Collectors.toList());
			List<Integer> list = service.getQuestionIDsForSwap(quiz.getQuizID(), integerList);
			service.changeOrdinalNumber(list);

			request.getSession().setAttribute("quizID", quizID.toString());
			response.sendRedirect(request.getContextPath() + "/admin/editquiz");
		} else if (request.getParameter("phase").equals("start-quiz")) {
			Integer quizID = Integer.parseInt(request.getParameter("quizID"));
			request.getSession().setAttribute("quizID", quizID.toString());
			response.sendRedirect(request.getContextPath() + "/admin/quiz");

		} else if (request.getParameter("phase").equals("delete-quiz-anyway")) {
			Integer quizID = Integer.parseInt(request.getParameter("quizID"));

			QuizDatabaseService service = null;

			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
			Quiz quiz = service.getQuizById(quizID);
			service.deleteQuiz(quizID);
			service.decrementNumOfQuizzesPerUser(quiz.getQuizAuthor());
			UserDatabaseService userService = null;
			try {
				userService = new UserDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			}
			LocalDateTime time = LocalDateTime.now();
			List<String> admins = userService.getAllUsers();
			for (int j = 0; j < admins.size(); j++) {
				String message = "A new quiz, " + quiz.getQuizName() + " exploring the theme of, " + quiz.getQuizTheme()
						+ " has been removed.";
				userService.insertInboxMessage(admins.get(j), message, time);
			}

			response.sendRedirect(request.getContextPath() + "/admin/quizmanagement");

		}

	}

}
