package controllers.quiz;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EditQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditQuiz() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer quizID = Integer.parseInt(request.getSession().getAttribute("quizID").toString());
		request.getSession().setAttribute("quizID", quizID.toString());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/quiz/editQuiz.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().setAttribute("quizID", request.getParameter("quizID").toString());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/quiz/editQuiz.jsp");
		dispatcher.forward(request, response);
	}

}
