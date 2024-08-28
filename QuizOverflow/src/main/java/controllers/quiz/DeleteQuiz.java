package controllers.quiz;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Quiz;
import model.QuizDatabaseService;
import model.UserDatabaseService;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;



public class DeleteQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteQuiz() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer quizID = Integer.parseInt(request.getParameter("quizToDelete"));
		QuizDatabaseService service = null;

		try {
			service = new QuizDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		Quiz quiz = service.getQuizById(quizID);
		service.deleteQuiz(quizID);
		service.decrementNumOfQuizzesPerUser(request.getParameter("author"));
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
