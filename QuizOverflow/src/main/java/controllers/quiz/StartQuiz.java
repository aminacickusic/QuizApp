package controllers.quiz;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Random;


public class StartQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public StartQuiz() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  Integer min = 100000;
	        Integer max = 999999;
	        Integer gamePin = new Random().nextInt(max - min + 1) + min;
	        String gmPin = gamePin.toString();
	        request.setAttribute("gamePin", gmPin);
	        Integer quizID = Integer.parseInt( (request.getSession().getAttribute("quizID").toString()));
            request.setAttribute("quizID", quizID);

	        RequestDispatcher dispatcher = request.getRequestDispatcher("/quiz/startQuiz.jsp");
	        dispatcher.forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
