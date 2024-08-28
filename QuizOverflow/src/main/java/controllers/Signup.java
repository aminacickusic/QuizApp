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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;


public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Signup() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
		dispatcher.forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String errorMessage = "";
		String hashedPassword = PasswordUtils.hashPassword(password);
		
		UserDatabaseService service=null;
		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		
		User user = service.getUserByEmail(email);
		
		
		String agreeTerms = request.getParameter("agreeTerms");
	    if (agreeTerms == null || !agreeTerms.equals("on")) {
	        errorMessage = "You must agree to the terms and conditions.";
	        request.getSession().setAttribute("errorMessage", errorMessage);
	        response.sendRedirect(request.getContextPath() + "/signup");
	        return; 
	    }
		
		
		if (user!=null) {
			errorMessage = "Email already in use.";
			request.getSession().setAttribute("errorMessage", errorMessage);
			response.sendRedirect(request.getContextPath() + "/signup");
		} else {
			User newUser = new User(email,username,hashedPassword, "editor", 13);
			service.addUser(newUser);
			service.setJoinDate(email, LocalDate.now());
			LocalDateTime time = LocalDateTime.now();
			List<String> admins = service.getAdmins();
			for (int i=0; i<admins.size(); i++) {
				String message = "New player " + username + ", with email " + email + " has joined our team."; 
				service.insertInboxMessage(admins.get(i), message, time);
			}
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", newUser);
			response.sendRedirect(request.getContextPath() + "/chooseAvatar");
		}
		
	}

}
