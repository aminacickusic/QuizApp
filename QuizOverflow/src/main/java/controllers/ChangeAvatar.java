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


public class ChangeAvatar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public ChangeAvatar() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/changeAvatar.jsp");
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer avatar;
		if (request.getParameter("chosenAvatar")==null || request.getParameter("chosenAvatar").equals("")) {
			avatar=13;
		}
		
		else {
		
	    avatar = Integer.parseInt(request.getParameter("chosenAvatar"));
		}
		
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		
		UserDatabaseService service=null;
		try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		service.addAvatar(currentUser, avatar);
		currentUser.setAvatar(avatar);
		request.getSession().setAttribute("currentUser", currentUser);
		
		if (currentUser.getRole().equals("admin") || currentUser.getRole().equals("editor")) {
			response.sendRedirect(request.getContextPath() + "/admin/editprofile");
			
		} 
		
		
		
			
	}

}
