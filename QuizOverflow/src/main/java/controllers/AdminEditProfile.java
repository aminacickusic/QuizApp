package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PasswordUtils;
import model.User;
import model.UserDatabaseService;

import java.io.IOException;
import java.sql.SQLException;

import javax.swing.JOptionPane;

public class AdminEditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminEditProfile() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/adminprofile.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("currentUser");
		String role = user.getRole();
		String activeTab = request.getParameter("activeTab");
		request.getSession().setAttribute("activeTab", activeTab);
		String email = user.getEmail();
		UserDatabaseService service = null;
		String errorMessage = "";
		String message = "";
		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		if (request.getParameter("changedField").equals("username")) {
			service.changeUsername(email, request.getParameter("username"));
			
			if (user.getRole().equals("admin")) {
				String formEmail = request.getParameter("email-to-change");
				User user1 = (User) service.getUserByEmail(formEmail);
				
				if (user1 != null) {
					if (!formEmail.equals(email)) {
						errorMessage = "Can't change email. Email already in use.";
						request.getSession().setAttribute("errorMessage1", errorMessage);
						response.sendRedirect(request.getContextPath() + "/admin/editprofile");
					} else {
					
					
						service.changeEmail(email, formEmail);
						message = "Username & email succesfully updated.";
					
					user.setEmail(formEmail);
					user.setUsername(request.getParameter("username"));
					request.getSession().setAttribute("currentUser", user);
					request.getSession().setAttribute("message1", message);
					response.sendRedirect(request.getContextPath() + "/admin/editprofile");
				}

				} else {
					
					
						service.changeEmail(email, formEmail);
						message = "Username & email succesfully updated.";
					
					user.setEmail(formEmail);
					user.setUsername(request.getParameter("username"));
					request.getSession().setAttribute("currentUser", user);
					request.getSession().setAttribute("message1", message);
					response.sendRedirect(request.getContextPath() + "/admin/editprofile");
				}
				
			} else if (user.getRole().equals("editor")) {
				message = "Username succesfully updated.";
				user.setUsername(request.getParameter("username"));
				request.getSession().setAttribute("currentUser", user);
				request.getSession().setAttribute("message1", message);
				response.sendRedirect(request.getContextPath() + "/admin/editprofile");
				
				
			}
			
			

		}

		else {
			String oldpassword = request.getParameter("oldpassword");
			String newpassword = request.getParameter("newpassword");
			String confirmpassword = request.getParameter("confirmpassword");

			if (!PasswordUtils.checkPassword(oldpassword, user.getHashedPassword())) {
				errorMessage = "Old password is incorrect.";
				request.getSession().setAttribute("errorMessage", errorMessage);
				response.sendRedirect(request.getContextPath() + "/admin/editprofile");

			}

			else if (!newpassword.equals(confirmpassword)) {
				errorMessage = "New password and confirmation password do not match.";
				request.getSession().setAttribute("errorMessage", errorMessage);
				response.sendRedirect(request.getContextPath() + "/admin/editprofile");
			}

			else if (PasswordUtils.checkPassword(newpassword, user.getHashedPassword())) {
				errorMessage = "New password cannot be the same as the old password.";
				request.getSession().setAttribute("errorMessage", errorMessage);
				response.sendRedirect(request.getContextPath() + "/admin/editprofile");
			} else if (newpassword.length() < 8 || !newpassword.matches(".*\\d.*")
					|| !newpassword.matches(".*[a-zA-Z].*")) {
				errorMessage = "New password must be at least 8 characters long, include a number, and a letter.";
				request.getSession().setAttribute("errorMessage", errorMessage);
				response.sendRedirect(request.getContextPath() + "/admin/editprofile");
			} else {
				String hashedNewPassword = PasswordUtils.hashPassword(newpassword);
				service.changePassword(email, hashedNewPassword);
				message = "Password succesfully changed.";
				user.setHashedPassword(hashedNewPassword);
				request.getSession().setAttribute("currentUser", user);
				request.getSession().setAttribute("message", message);
				response.sendRedirect(request.getContextPath() + "/admin/editprofile");
			}
		}

	}

}
