package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class QuizDatabaseService {
	private Connection connect_ = null;
	private PreparedStatement preparedStatement_ = null;
	private String query_ = null;

	public QuizDatabaseService(Connection conn) {
		this.connect_ = conn;
	}

	public QuizDatabaseService() throws SQLException, ClassNotFoundException {
		this.connect_ = DatabaseConnector.getConnection();
	}

	public Integer getNewQuizzes() {
		query_ = "SELECT COUNT(*) AS numberOfQuizzes FROM quizDate WHERE createDate >= CURRENT_DATE - INTERVAL '7 days';";
		ResultSet result;
		Integer num = 0;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);

			result = preparedStatement_.executeQuery();

			while (result.next()) {
				num = result.getInt("numberOfQuizzes");

			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	public Integer createQuiz(Quiz quiz) {
		query_ = "INSERT INTO quizzes (name, image, author, theme, questionNum) VALUES (?,?,?,?,?) RETURNING id;";
		int generatedId = -1;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, quiz.getQuizName());
			preparedStatement_.setString(2, quiz.getQuizImg());
			preparedStatement_.setString(3, quiz.getQuizAuthor());
			preparedStatement_.setString(4, quiz.getQuizTheme());
			preparedStatement_.setInt(5, quiz.getQuizQuestionNumber());

			ResultSet resultSet = preparedStatement_.executeQuery();

			if (resultSet.next()) {
				generatedId = resultSet.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return generatedId;
	}

	public Integer createQuestion(Question question) {
		query_ = "INSERT INTO multipleChoiceQuestions (ordinalNum,quizID,question,time, points, numberOfAnswers) VALUES (?,?,?,?,?,?) RETURNING id;";
		int generatedId = -1;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, question.getOrdinalNum());
			preparedStatement_.setInt(2, question.getQuizID());
			preparedStatement_.setString(3, question.getQuestion());
			preparedStatement_.setInt(4, question.getTime());
			preparedStatement_.setInt(5, question.getPoints());
			preparedStatement_.setInt(6, question.getNumOfAnswers());

			ResultSet resultSet = preparedStatement_.executeQuery();

			if (resultSet.next()) {
				generatedId = resultSet.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return generatedId;
	}

	public void addCreateDate(Integer quizID, LocalDate date) {
		query_ = "INSERT INTO quizDate (quizID, createDate) VALUES (?,?);";

		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, quizID);
			preparedStatement_.setDate(2, Date.valueOf(date));
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void saveQuizResults(Integer quizID, Integer numOfPlayers, double maxScore, double avgScore,
			LocalDateTime dateTime, String author) {
		query_ = "INSERT INTO quizResults (quizID, numOfPlayers, maxPoints, avgPoints, dateAndTime, host) VALUES (?,?,?,?,?,?) RETURNING id;";
		int generatedId = -1;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, quizID);
			preparedStatement_.setInt(2, numOfPlayers);
			preparedStatement_.setDouble(3, maxScore);
			preparedStatement_.setDouble(4, avgScore);
			preparedStatement_.setTimestamp(5, Timestamp.valueOf(dateTime));
			preparedStatement_.setString(6, author);

			ResultSet resultSet = preparedStatement_.executeQuery();

			if (resultSet.next()) {
				generatedId = resultSet.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public Double getAvgPoints() {
		query_ = "SELECT AVG(avgPoints) AS avgScore FROM quizResults";
		ResultSet result;
		Double num = 0.0;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);

			result = preparedStatement_.executeQuery();

			while (result.next()) {
				num = result.getDouble("avgScore");

			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	public Double getMaxPoints() {
		query_ = "SELECT MAX(maxPoints) AS maxScore FROM quizResults";
		ResultSet result;
		Double num = 0.0;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);

			result = preparedStatement_.executeQuery();

			while (result.next()) {
				num = result.getDouble("maxScore");

			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	public Integer getAvgPlayers() {
		query_ = "SELECT AVG(numOfPlayers) AS avgPlayers FROM quizResults";
		ResultSet result;
		Integer num = 0;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);

			result = preparedStatement_.executeQuery();

			while (result.next()) {
				num = result.getInt("avgPlayers");

			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	public Integer getMaxPlayers() {
		query_ = "SELECT MAX(numOfPlayers) AS maxPlayers FROM quizResults";
		ResultSet result;
		Integer num = 0;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);

			result = preparedStatement_.executeQuery();

			while (result.next()) {
				num = result.getInt("maxPlayers");

			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	public Integer createAnswer(Answer answer) {
		query_ = "INSERT INTO answers (questionID, answer, isTrue) VALUES (?,?,?) RETURNING id;";
		int generatedId = -1;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, answer.getQuestionID());
			preparedStatement_.setString(2, answer.getAnswer());
			preparedStatement_.setBoolean(3, answer.isTrue());

			ResultSet resultSet = preparedStatement_.executeQuery();

			if (resultSet.next()) {
				generatedId = resultSet.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return generatedId;
	}

	public void updateQuestionNumber(Quiz quiz) {
		query_ = "UPDATE quizzes  SET questionNum=? WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, quiz.getQuizQuestionNumber());
			preparedStatement_.setInt(2, quiz.getQuizID());

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void updateQuizInformation(Integer quizID, String newName, String newAuthor, String newTheme,
			String newImg) {
		query_ = "UPDATE quizzes  SET name=?, author=?, image=?, theme=? WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, newName);
			preparedStatement_.setString(2, newAuthor);
			preparedStatement_.setString(3, newImg);
			preparedStatement_.setString(4, newTheme);
			preparedStatement_.setInt(5, quizID);

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updateQuestionNumber(Integer qid, Integer num) {
		query_ = "UPDATE quizzes  SET questionNum=? WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, num);
			preparedStatement_.setInt(2, qid);

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void updateNumOfQuizzesPerUser(String email) {
		Integer num = 0;
		query_ = "SELECT numOfQuizzes FROM quizzesPerUser WHERE userID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);

			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				num = result.getInt("numOfQuizzes");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "UPDATE quizzesPerUser  SET numOfQuizzes=? WHERE userID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, num + 1);
			preparedStatement_.setString(2, email);

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void decrementNumOfQuizzesPerUser(String email) {
		Integer num = 0;
		query_ = "SELECT numOfQuizzes FROM quizzesPerUser WHERE userID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);

			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				num = result.getInt("numOfQuizzes");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (num > 0) {
			query_ = "UPDATE quizzesPerUser  SET numOfQuizzes=? WHERE userID=?";
			try {
				preparedStatement_ = connect_.prepareStatement(query_);
				preparedStatement_.setInt(1, num - 1);
				preparedStatement_.setString(2, email);

				preparedStatement_.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public Quiz getQuizById(Integer quizID) {
		Quiz quiz = new Quiz();
		query_ = "SELECT * FROM quizzes WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, quizID);
			ResultSet result = preparedStatement_.executeQuery();

			while (result.next()) {

				quiz.setQuizID(result.getInt("id"));
				quiz.setQuizName(result.getString("name"));
				quiz.setQuizImg(result.getString("image"));
				quiz.setQuizAuthor(result.getString("author"));
				quiz.setQuizTheme(result.getString("theme"));
				quiz.setQuizQuestionNumber(result.getInt("questionNum"));

			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "SELECT * FROM multipleChoiceQuestions WHERE quizID=? order by ordinalNum";

		try {

			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, quizID);

			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				Question question = new Question();
				question.setId(result.getInt("id"));
				question.setOrdinalNum(result.getInt("ordinalNum"));
				question.setQuizID(result.getInt("quizID"));
				question.setQuestion(result.getString("question"));
				question.setTime(result.getInt("time"));
				question.setPoints(result.getInt("points"));
				question.setNumOfAnswers(result.getInt("numberOfAnswers"));
				quiz.getQuestionsList().add(question);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return quiz;
	}

	public Question getQuestionById(Integer questionID) {
		Question question = new Question();
		query_ = "SELECT * FROM multipleChoiceQuestions WHERE id=?";

		try {

			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, questionID);

			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				question.setId(result.getInt("id"));
				question.setOrdinalNum(result.getInt("ordinalNum"));
				question.setQuizID(result.getInt("quizID"));
				question.setQuestion(result.getString("question"));
				question.setTime(result.getInt("time"));
				question.setPoints(result.getInt("points"));
				question.setNumOfAnswers(result.getInt("numberOfAnswers"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "SELECT * FROM answers WHERE questionID=?";

		try {

			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, questionID);

			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				Answer answer = new Answer();
				answer.setId(result.getInt("id"));
				answer.setQuestionID(result.getInt("questionID"));
				answer.setAnswer(result.getString("answer"));
				answer.setTrue(result.getBoolean("isTrue"));
				question.getAnswersList().add(answer);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return question;

	}

	public Integer getNumOfQuizzes(String email) {
		Integer num = 0;
		query_ = "SELECT numOfQuizzes FROM quizzesPerUser WHERE userID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);

			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				num = result.getInt("numOfQuizzes");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	public void deleteQuiz(Quiz quiz) {
		query_ = "DELETE FROM quizzes WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, quiz.getQuizID());

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "DELETE FROM quizDate WHERE quizID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, quiz.getQuizID());

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void deleteQuiz(Integer idQuiz) {
		query_ = "SELECT id FROM multipleChoiceQuestions WHERE quizID=?";
		List<Integer> questionsID = null;
		try {

			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, idQuiz);

			questionsID = new ArrayList<Integer>();
			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				Integer id = result.getInt("id");
				questionsID.add(id);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		for (int i = 0; i < questionsID.size(); ++i) {
			query_ = "DELETE FROM answers WHERE questionID=?";
			try {
				preparedStatement_ = connect_.prepareStatement(query_);
				preparedStatement_.setInt(1, questionsID.get(i));
				preparedStatement_.execute();

			} catch (SQLException e) {
				e.printStackTrace();

			}

			query_ = "DELETE FROM multipleChoiceQuestions WHERE id=?";
			try {
				preparedStatement_ = connect_.prepareStatement(query_);
				preparedStatement_.setInt(1, questionsID.get(i));
				preparedStatement_.execute();

			} catch (SQLException e) {
				e.printStackTrace();

			}
		}

		query_ = "DELETE FROM quizzes WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, idQuiz);

			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "DELETE FROM quizDate WHERE quizID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, idQuiz);

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void updateOrdinalNumber(Integer quizID, Integer which, Integer toWhat) {
		query_ = "UPDATE multipleChoiceQuestions  SET ordinalNum=? WHERE quizID=? AND ordinalNum=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, toWhat);
			preparedStatement_.setInt(2, quizID);
			preparedStatement_.setInt(3, which);

			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public List<Integer> getQuestionIDsForSwap(Integer quizID, List<Integer> numbers) {
		List<Integer> list = new ArrayList<Integer>();
		for (Integer s : numbers) {
			query_ = "SELECT id FROM multipleChoiceQuestions WHERE quizID=? AND ordinalNum=?";
			try {
				preparedStatement_ = connect_.prepareStatement(query_);
				preparedStatement_.setInt(1, quizID);
				preparedStatement_.setInt(2, s);

				ResultSet result = preparedStatement_.executeQuery();
				while (result.next()) {
					Integer id = result.getInt("id");
					list.add(id);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return list;
	}

	public void changeOrdinalNumber(List<Integer> list) {
		Integer k = 1;
		for (Integer s : list) {
			query_ = "UPDATE multipleChoiceQuestions SET ordinalNum=? WHERE id=?";
			try {
				preparedStatement_ = connect_.prepareStatement(query_);
				preparedStatement_.setInt(1, k);
				preparedStatement_.setInt(2, s);

				preparedStatement_.executeUpdate();
				k++;

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public void updateQuestion(Question question, Integer questionID) {
		query_ = "UPDATE multipleChoiceQuestions  SET ordinalNum=?, question=?, time=?, points=?, numberOfAnswers=?  WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, question.getOrdinalNum());
			preparedStatement_.setString(2, question.getQuestion());
			preparedStatement_.setInt(3, question.getTime());
			preparedStatement_.setInt(4, question.getPoints());
			preparedStatement_.setInt(5, question.getNumOfAnswers());
			preparedStatement_.setInt(6, questionID);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		for (int i = 0; i < question.getNumOfAnswers(); i++) {
			Answer answer = question.getAnswersList().get(i);
			answer.setQuestionID(questionID);
			createAnswer(answer);
		}

	}

	public void deleteAnswersForQuestion(Integer qid) {
		query_ = "DELETE FROM answers WHERE questionID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, qid);
			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();

		}

	}

	public void deleteQuestionById(Integer qid) {

		query_ = "DELETE FROM answers WHERE questionID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, qid);
			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();

		}

		query_ = "DELETE FROM multipleChoiceQuestions WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, qid);
			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();

		}

	}

	public List<String> getColors() {
		List<String> colorsList = null;
		query_ = "SELECT code FROM pastelColors";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);

			colorsList = new ArrayList<String>();
			ResultSet result = preparedStatement_.executeQuery();
			while (result.next()) {
				String color = result.getString("code");
				colorsList.add(color);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return colorsList;

	}

	public List<Quiz> getQuizzes() {

		ResultSet result;
		List<Quiz> list = new ArrayList<>();

		query_ = "SELECT * FROM quizzes";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			result = preparedStatement_.executeQuery();

			while (result.next()) {
				Quiz quiz = new Quiz();
				quiz.setQuizID(result.getInt("id"));
				quiz.setQuizName(result.getString("name"));
				quiz.setQuizImg(result.getString("image"));
				quiz.setQuizAuthor(result.getString("author"));
				quiz.setQuizTheme(result.getString("theme"));
				quiz.setQuizQuestionNumber(result.getInt("questionNum"));
				list.add(quiz);
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

}
