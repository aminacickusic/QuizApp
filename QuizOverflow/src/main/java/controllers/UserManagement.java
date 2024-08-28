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

import javax.swing.JOptionPane;

public class UserManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UserManagement() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/usermanagement.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("id");
		String formEmail = request.getParameter("email");
		String role = request.getParameter("role");
		String username = request.getParameter("username");
		UserDatabaseService service = null;

		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		User user = (User) service.getUserByEmail(formEmail);

		if (user != null) {
			if (!formEmail.equals(email)) {
				JOptionPane.showMessageDialog(null, "Can't change email. Email already in use.", "Error",
						JOptionPane.ERROR_MESSAGE);
				response.sendRedirect(request.getContextPath() + "/admin/usermanagement");
			} else {
				service.editUser(email, role, username, formEmail);
				if (((User)request.getSession().getAttribute("currentUser")).getEmail().equals(email)) {
				User userTemp = (User) 	request.getSession().getAttribute("currentUser");
				userTemp.setEmail(formEmail);
				userTemp.setUsername(username);
				userTemp.setRole(role);
				request.getSession().setAttribute("currentUser", userTemp);
				}
				response.sendRedirect(request.getContextPath() + "/admin/usermanagement");

			}

		} else {
			service.editUser(email, role, username, formEmail);
			
			if (((User)request.getSession().getAttribute("currentUser")).getEmail().equals(email)) {
				User userTemp = (User) 	request.getSession().getAttribute("currentUser");
				userTemp.setEmail(formEmail);
				userTemp.setUsername(username);
				userTemp.setRole(role);
				request.getSession().setAttribute("currentUser", userTemp);
				}
			response.sendRedirect(request.getContextPath() + "/admin/usermanagement");

		}
	}

}
