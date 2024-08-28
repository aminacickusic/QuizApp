package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.PasswordUtils;
import model.User;
import model.UserDatabaseService;

import java.io.IOException;
import java.sql.SQLException;

public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String errorMessage = "";

		UserDatabaseService service = null;
		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
		}

		User user = service.getUserByEmail(email);

		if (user != null) {

			boolean res = PasswordUtils.checkPassword(password, user.getHashedPassword());
			if (res) {
				if (user.getRole().equals("admin") || user.getRole().equals("editor")) {
					HttpSession session = request.getSession();
					session.setAttribute("currentUser", user);
					response.sendRedirect(request.getContextPath() + "/admin/main");
				} else {
					errorMessage = "Access forbidden: You do not have permission to access the resource.";
					request.getSession().setAttribute("errorMessage", errorMessage);
					response.sendRedirect(request.getContextPath() + "/login");
				}
			} else {
				errorMessage = "Wrong password.";
				request.getSession().setAttribute("errorMessage", errorMessage);
				response.sendRedirect(request.getContextPath() + "/login");
			}

		} else {
			errorMessage = "User with that email does not exist.";
			request.getSession().setAttribute("errorMessage", errorMessage);
			response.sendRedirect(request.getContextPath() + "/login");

		}
	}

}
