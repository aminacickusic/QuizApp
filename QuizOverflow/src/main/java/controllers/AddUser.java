package controllers;

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

import javax.swing.JOptionPane;


public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public AddUser() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		String errorMessage = "";
		String hashedPassword = PasswordUtils.hashPassword(password);
		
		UserDatabaseService service=null;
		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		
		User user = service.getUserByEmail(email);
		
		
		if (user!=null) {
			errorMessage = "Email already in use.";
			JOptionPane.showMessageDialog(null, errorMessage, "Error", JOptionPane.ERROR_MESSAGE);
        	response.sendRedirect(request.getContextPath() + "/admin/usermanagement");
			
		} else {
			User newUser = new User(email,username,hashedPassword, role, 13);
			service.addUser(newUser);
			LocalDateTime time = LocalDateTime.now();
			service.setJoinDate(email, LocalDate.now());
			List<String> admins = service.getAdmins();
			for (int i=0; i<admins.size(); i++) {
				String message = "New player " + username + ", with email " + email + " has been added."; 
				service.insertInboxMessage(admins.get(i), message, time);
			}
			response.sendRedirect(request.getContextPath() + "/admin/usermanagement");
		}
		
	}

}
