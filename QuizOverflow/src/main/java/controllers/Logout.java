package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Logout() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session != null) {
			session.removeAttribute("currentUser");
			session.invalidate();
		}

		response.sendRedirect(request.getContextPath() + "/startPage");

	}

}
