package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.UserDatabaseService;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import javax.swing.JOptionPane;


public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public DeleteUser() {
        super();
    }

	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        	throws ServletException, IOException {
   	
	}



	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	User currentUser = (User) request.getSession().getAttribute("currentUser");
    	String email = request.getParameter("userToDelete");
    
    	UserDatabaseService service=null;
		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		User userToDelete = service.getUserByEmail(email);
    	if(currentUser.getEmail().equals(email))
    	{
        	JOptionPane.showMessageDialog(null, "You can not delete current user/yourself", "Error", JOptionPane.ERROR_MESSAGE);
        	response.sendRedirect(request.getContextPath() + "/admin/usermanagement");
    	}
    	else{
        	service.deleteUser(email);
        	List<String> admins = service.getAdmins();
        	LocalDateTime time = LocalDateTime.now();
			for (int i=0; i<admins.size(); i++) {
				String message = "New player " + userToDelete.getUsername() + ", with email " + email + " has been removed."; 
				service.insertInboxMessage(admins.get(i), message, time);
			}
        	response.sendRedirect(request.getContextPath() + "/admin/usermanagement");
    	}
	}

}
