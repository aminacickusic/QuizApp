package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.UserDatabaseService;

import java.io.IOException;
import java.sql.SQLException;

public class UpdateAvatar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateAvatar() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/updateAvatar.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer avatar = Integer.parseInt(request.getParameter("chosenAvatar"));
		String email = request.getParameter("email");

		UserDatabaseService service = null;
		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		User currentUser = service.getUserByEmail(email);
		if (currentUser != null)
			service.addAvatar(currentUser, avatar);
		if (((User) request.getSession().getAttribute("currentUser")).getEmail().equals(email)) {
			User userTemp = (User) request.getSession().getAttribute("currentUser");
			userTemp.setAvatar(avatar);
			request.getSession().setAttribute("currentUser", userTemp);
		}

		response.sendRedirect(request.getContextPath() + "/admin/usermanagement");
	}

}
