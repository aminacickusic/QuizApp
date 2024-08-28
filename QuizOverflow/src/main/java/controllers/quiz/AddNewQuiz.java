package controllers.quiz;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Answer;
import model.Question;
import model.Quiz;
import model.QuizDatabaseService;
import model.User;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
public class AddNewQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddNewQuiz() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		QuizDatabaseService service=null;
		try {
		   service = new QuizDatabaseService();
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		List<String> colorsList = new ArrayList<String>();
		colorsList = service.getColors();
		request.getSession().setAttribute("colors", colorsList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/quiz/addNewQuiz.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("phase").equals("selecting-image")) {
		    Part file = request.getPart("quizImage");
		    String imageFileName = file.getSubmittedFileName();
		    String message = "";

		    String projectPath = System.getProperty("user.dir");
		    String uploadPath = projectPath
		            + "/eclipse-workspace/RI601-projekat-najdabeganovic-aminacickusic/src/main/webapp/images/quizImages/"
		            + imageFileName;
		    
		    boolean uploadSuccess = false;

		    if (imageFileName != null && !imageFileName.isEmpty()) {
		        try (InputStream is = file.getInputStream()) {
		            Path filePath = Paths.get(uploadPath);
		            Files.copy(is, filePath, StandardCopyOption.REPLACE_EXISTING);
		            uploadSuccess = true;
		        } catch (Exception e) {
		            message = "Error while uploading image.";
		            e.printStackTrace();
		        }
		    }
		   
		  
		    response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			if (uploadSuccess) {
				String jsonResponse = String.format("{\"success\": true, \"imagePath\": \"%s\"}", imageFileName);
				response.getWriter().write(jsonResponse);
			} else {
				String jsonResponse = "{\"success\": false}";
				response.getWriter().write(jsonResponse);
			}
		}
		else if (request.getParameter("phase").equals("create")) {
			String image = request.getParameter("image");
			String name = request.getParameter("quizname");
			String theme = request.getParameter("theme");

			if (image.equals("") || image == null) {
				image = "defaultQuiz.png";
			}
			User user = (User) request.getSession().getAttribute("currentUser");
			List<Question> questionsList = new ArrayList<Question>();

			Quiz quiz = new Quiz(name, image, user.getEmail(), theme, 0, questionsList);
			QuizDatabaseService service = null;
			try {
				service = new QuizDatabaseService();
			} catch (ClassNotFoundException | SQLException e) {

				e.printStackTrace();
			}
			Integer id = service.createQuiz(quiz);
			quiz.setQuizID(id);
			request.getSession().setAttribute("currentQuiz", quiz);
			request.getSession().setAttribute("ordinalNumber", 1);
			response.sendRedirect(request.getContextPath() + "/admin/addquestion");

		} else if (request.getParameter("phase").equals("go-back")) {
			response.sendRedirect(request.getContextPath() + "/admin/quizmanagement");

		}
	}

}
