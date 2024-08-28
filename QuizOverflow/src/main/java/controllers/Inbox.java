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


public class Inbox extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Inbox() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/inbox.jsp");
		User user = (User) request.getSession().getAttribute("currentUser");
		request.setAttribute("userID", user.getEmail());
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	     UserDatabaseService service=null;
	     try {
			service = new UserDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		
		
	 	User user = (User) request.getSession().getAttribute("currentUser");
		request.setAttribute("userID", user.getEmail());

		if (request.getParameter("phase").equals("delete-msg")) {
			Integer id = Integer.parseInt(request.getParameter("msgToDelete"));
			service.deleteMessage(id);
			response.sendRedirect(request.getContextPath() + "/admin/inbox");
			
			
			
		} else if (request.getParameter("phase").equals("read-msg")) {
			Integer id = Integer.parseInt(request.getParameter("msgToRead"));
			service.changeReadMessage(id, true);
			response.sendRedirect(request.getContextPath() + "/admin/inbox");
			
			
		}
		
		
		
	}

}
