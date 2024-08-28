package controllers.quiz;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import model.Player;
import model.Question;
import model.Quiz;
import model.QuizDatabaseService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

@ServerEndpoint("/quiz")
public class QuizWebSocketServer {

	private static Set<Player> players = new CopyOnWriteArraySet<>();
	private static Set<Player> admins = new CopyOnWriteArraySet<>();
	private static Set<Session> inProcess = new CopyOnWriteArraySet<>();
	private static String adminpin = "";
	private static AtomicInteger playersConnected = new AtomicInteger(0);
	private static Integer quizID;
	private static QuizDatabaseService service;
	private static Quiz quiz;
	private static Integer questionNumber = -1;
	private static List<Question> questions;
	private static AtomicBoolean isSent = new AtomicBoolean(false);
	private static AtomicInteger playersServe = new AtomicInteger(0);
	private static boolean isQuizFinished = false;
	private static boolean isQuizStarted = false;

	private static final BlockingQueue<MessageWrapper> messageQueue = new LinkedBlockingQueue<>();
	private static ExecutorService executorService = Executors.newSingleThreadExecutor();

	private static class MessageWrapper {
		private final Session session;
		private final String message;

		public MessageWrapper(Session session, String message) {
			this.session = session;
			this.message = message;
		}

		public Session getSession() {
			return session;
		}

		public String getMessage() {
			return message;
		}
	}

	@OnOpen
	public void onOpen(Session session) {
		if (executorService.isShutdown()) {
			executorService = Executors.newSingleThreadExecutor();
		}
		executorService.submit(() -> {
			while (true) {
				try {
					MessageWrapper messageWrapper = messageQueue.take();
					handleMessage(messageWrapper.getSession(), messageWrapper.getMessage());
				} catch (InterruptedException e) {
					Thread.currentThread().interrupt();
					break;
				} catch (ClassNotFoundException e) {

					e.printStackTrace();
				} catch (IOException e) {

					e.printStackTrace();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
		});
	}

	@OnMessage
	public void onMessage(Session session, String message) {
		messageQueue.offer(new MessageWrapper(session, message));
	}

	public void handleMessage(Session session, String message)
			throws IOException, ClassNotFoundException, SQLException {
		Gson gson = new Gson();

		try {
			JsonObject jsonMessage = gson.fromJson(message, JsonObject.class);

			if (jsonMessage.has("action")) {
				String action = jsonMessage.get("action").getAsString();

				switch (action) {
				case "SUBMIT_ANSWERS":
					JsonArray answersJsonArray = jsonMessage.getAsJsonArray("answers");

					List<String> selectedAnswersList = new ArrayList<>();
					for (JsonElement answerElement : answersJsonArray) {
						selectedAnswersList.add(answerElement.getAsString());
					}

					JsonObject q = checkAnswers(selectedAnswersList);
					Player player = findPlayer(session);
					if (player != null) {

						double score = q.get("score").getAsDouble();

						player.setScore(player.getScore() + score);

					}

					playersServe.getAndIncrement();

					if (playersServe.get() == playersConnected.get() && isSent.compareAndSet(false, true)) {

						List<Player> playerList = getTopPlayers(10);
						JsonObject topTen = new JsonObject();
						Integer i = 0;
						topTen.addProperty("action", "topTen");
						topTen.addProperty("number", playerList.size());
						if (questionNumber == (questions.size() - 1)) {
							topTen.addProperty("lastQuestion", true);
						} else {
							topTen.addProperty("lastQuestion", false);
						}
						for (Player p : playerList) {
							++i;
							JsonObject o = new JsonObject();
							o.addProperty("name", p.getName());
							o.addProperty("lastName", p.getLastName());
							o.addProperty("score", p.getScore());
							o.addProperty("avatar", p.getAvatar());
							topTen.add(i.toString(), o);

						}

						broadcast(gson.toJson(topTen));

					}

					break;
				default:
					return;
				}
			}
		} catch (JsonSyntaxException e) {
			handleNonJsonMessages(session, message);

		}
	}

	private void handleNonJsonMessages(Session session, String message)
			throws IOException, ClassNotFoundException, SQLException {
		Gson gson = new Gson();
		if (message.startsWith("ADMIN:")) {

			String adminName = message.substring(6);
			Player admin = new Player(session, adminName, null, Player.Role.ADMIN, 0);
			admins.add(admin);

			session.getBasicRemote().sendText("ADMIN_OK");
		} else if (message.startsWith("CHECK_PIN:")) {
			String pin = message.substring(10);

			if (isValidPin(pin)) {
				session.getBasicRemote().sendText("PIN_OK");
				inProcess.add(session);
			} else {
				session.getBasicRemote().sendText("PIN_INVALID");
			}
		} else if (message.startsWith("NAME:")) {
			
			String name = message.substring(5);
			String[] parts = name.split("/");
			String playerName = parts[0];
			String playerLastName = parts[1];
			Integer avatar = Integer.parseInt(parts[2]);
			
			Player player = new Player(session, playerName, playerLastName, Player.Role.PLAYER, avatar);
			
			players.add(player);
			removeSession(session);
			session.getBasicRemote().sendText("QUIZNAME:" + quiz.getQuizName());
			JsonObject object = new JsonObject();
			object.addProperty("action", "SIGNUP_SUCCESSFUL");
			object.addProperty("Name", playerName);
			object.addProperty("lastName", playerLastName);
			session.getBasicRemote().sendText(gson.toJson(object));
			playersConnected.getAndIncrement();
			broadcastToAdmins("PLAYERSCONNECTED:" + playersConnected.get());
			broadcastToPlayers("PLAYERSCONNECTED:" + playersConnected.get());

			broadcast("Player " + playerName + " has joined.");

		} else if (message.startsWith("QUESTION:")) {

			Player sender = findPlayerBySession(session);
			if (sender != null && sender.getRole() == Player.Role.ADMIN) {
				String question = message.substring(9);
				broadcast("QUESTION:" + question);
			}
		} else if (message.startsWith("ADMIN_SENT_PIN:")) {
			adminpin = message.substring(15);
			session.getBasicRemote().sendText("ADMIN_PIN " + adminpin);
		} else if (message.startsWith("ADMIN_DISCONNECTED")) {
			broadcastToPlayers(message);
		} else if (message.startsWith("ADMIN_SENT_QUIZ_ID:")) {
			quizID = Integer.parseInt(message.substring(19));
			session.getUserProperties().put("quizID", message.substring(19));
			service = new QuizDatabaseService();
			quiz = service.getQuizById(quizID);
			getQuestions();
		} else if (message.startsWith("TIME_LEFT")) {
			broadcastToPlayers(message);
		} else if (message.startsWith("SEND_NEXT_QUESTION")) {
			if (inProcess.size() != 0 && questionNumber == -1) {
				broadcastToInProcess("QUIZ STARTED, DID NOT JOIN");

			}

			if (playersConnected.get() == 0 && questionNumber == -1) {
				broadcastToAdmins("NO MORE PLAYERS");
			} else {

				isQuizStarted = true;

				if (questionNumber < (questions.size() - 1)) {
					JsonObject q = prepareQuestion();
					isSent.set(false);
					playersServe.set(0);
					session.getBasicRemote().sendText(gson.toJson(q));
					broadcastToPlayers(gson.toJson(q));
				}

			}
		} else if (message.startsWith("QUESTION_TIME_LEFT:")) {
			broadcastToPlayers(message);
		} else if (message.startsWith("COLLECT_QUESTION_RESULTS")) {
			broadcastToPlayers("RETURN_QUESTION_RESULTS");
		} else if (message.startsWith("RESET_PIN")) {
			adminpin = "";
		} else if (message.startsWith("YOU HAVE FINISHED QUIZ")) {
			if (isQuizFinished == false) {
				isQuizFinished = true;
				String author = message.substring(23);
				Player player = maxPoints();
				double avgPoints = getAvgScore();

				LocalDateTime currentDateTime = LocalDateTime.now();
				service.saveQuizResults(quiz.getQuizID(), playersConnected.get(), player.getScore(), avgPoints,
						currentDateTime, author);
				broadcastToPlayers(message);
			}
		}

	}

	private static Player maxPoints() {
		Optional<Player> maxPlayer = players.stream().max(Comparator.comparingDouble(Player::getScore));

		return maxPlayer.orElse(null);
	}

	private static double getAvgScore() {
		return players.stream().mapToDouble(Player::getScore).average().orElse(0.0);
	}

	@OnClose
	public void onClose(Session session) {
		boolean removed1 = false;
		boolean removed2 = false;
		removed1 = admins.removeIf(admin -> admin.getSession().equals(session));

		if (!removed1) {
			removed2 = players.removeIf(player -> player.getSession().equals(session));
		}

		if (removed1 == true) {
			if (isQuizFinished == false) {
				var message = "ADMIN_DISCONNECTED";
				broadcastToPlayers(message);
			}
			isQuizStarted = false;
			questionNumber = -1;
			adminpin = "";
			playersConnected.getAndSet(0);
			isSent.set(false);
			playersServe.set(0);
			questions.clear();
		}
		if (removed2 == true) {
			if (playersConnected.get() != 0) {
				playersConnected.getAndDecrement();
				broadcast("One player disconnected!");
				broadcastToAdmins("PLAYERSCONNECTED:" + playersConnected.get());
				broadcastToPlayers("PLAYERSCONNECTED:" + playersConnected.get());
			}

			if (playersConnected.get() == 0 && isQuizStarted == true && isQuizFinished == false) {
				broadcastToAdmins("NO MORE PLAYERS");
			}

		}

		if (players.isEmpty() && admins.isEmpty()) {
			isQuizFinished = false;
			executorService.shutdown();
		}
	}

	@OnError
	public void onError(Session session, Throwable throwable) {
		throwable.printStackTrace();
	}

	private boolean isValidPin(String pin) {

		if (adminpin.equals(pin)) {
			return true;
		}
		return false;
	}

	private void broadcast(String message) {

		for (Player admin : admins) {
			if (admin.getSession().isOpen()) {
				sendMessage(admin.getSession(), message);
			}
		}

		for (Player p : players) {
			if (p.getSession().isOpen()) {
				sendMessage(p.getSession(), message);
			}
		}

	}

	private void sendMessage(Session session, String message) {
		synchronized (session) {
			try {
				session.getBasicRemote().sendText(message);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void broadcastToInProcess(String message) {
		for (Session s : inProcess) {
			if (s.isOpen()) {
				sendMessage(s, message);
			}
		}

	}

	private void broadcastToPlayers(String message) {

		for (Player p : players) {
			if (p.getSession().isOpen()) {
				sendMessage(p.getSession(), message);
			}
		}

	}

	private void broadcastToAdmins(String message) {

		for (Player admin : admins) {
			if (admin.getSession().isOpen()) {
				sendMessage(admin.getSession(), message);
			}
		}
	}

	private Player findPlayerBySession(Session session) {
		for (Player admin : admins) {
			if (admin.getSession().equals(session)) {
				return admin;
			}
		}
		return null;
	}

	private Player findPlayer(Session session) {
		for (Player p : players) {
			if (p.getSession().equals(session)) {
				return p;
			}
		}
		return null;
	}

	private void removeSession(Session session) {
		inProcess.remove(session);

	}

	private void getQuestions() throws ClassNotFoundException, SQLException {
		questions = new ArrayList<Question>();
		service = new QuizDatabaseService();
		for (int i = 0; i < quiz.getQuizQuestionNumber(); ++i) {
			Question question = service.getQuestionById(quiz.getQuestionsList().get(i).getId());
			questions.add(question);
		}
		questions = questions.stream().sorted(Comparator.comparingInt(Question::getOrdinalNum))
				.collect(Collectors.toList());

	}

	private JsonObject prepareQuestion() throws ClassNotFoundException, SQLException {
		++questionNumber;
		Gson gson = new Gson();
		JsonObject object = gson.toJsonTree(questions.get(questionNumber)).getAsJsonObject();
		object.addProperty("action", "NEXT_QUESTION");
		object.addProperty("quizName", quiz.getQuizName());
		object.addProperty("connectedPlayers", playersConnected);
		service = new QuizDatabaseService();
		List<String> colors = service.getColors();
		String color = colors.get((questionNumber + 1) % colors.size());
		object.addProperty("color", color);
		object.addProperty("quizImage", quiz.getQuizImg());

		return object;

	}

	private JsonObject checkAnswers(List<String> selectedAnswersList) {
		List<String> correctAnswers = new ArrayList<String>();
		for (int i = 0; i < questions.get(questionNumber).getAnswersList().size(); ++i) {
			if (questions.get(questionNumber).getAnswersList().get(i).isTrue())
				correctAnswers.add(questions.get(questionNumber).getAnswersList().get(i).getAnswer());
		}

		Gson gson = new Gson();
		JsonObject object = new JsonObject();
		double score = calculateScore(correctAnswers, selectedAnswersList, questions.get(questionNumber).getPoints());
		object.addProperty("action", "YOUR_SCORE");
		object.addProperty("score", score);
		JsonArray jsonArray = new JsonArray();
		for (String answer : correctAnswers) {
			jsonArray.add(answer);
		}

		object.add("correctAnswers", jsonArray);

		jsonArray = new JsonArray();
		for (String answer : selectedAnswersList) {
			jsonArray.add(answer);
		}

		object.add("yourAnswers", jsonArray);
		boolean isAllCorrect = ((int) score == questions.get(questionNumber).getPoints()) ? true : false;
		object.addProperty("isAllCorrect", isAllCorrect);
		object.addProperty("isNoneSelected", (selectedAnswersList.size() == 0) ? true : false);

		return object;
	}

	public static List<Player> getTopPlayers(int topN) {

		List<Player> playerList = new ArrayList<>(players);

		List<Player> sortedPlayers = playerList.stream().sorted(Comparator.comparingDouble(Player::getScore).reversed())
				.collect(Collectors.toList());

		return sortedPlayers.stream().limit(topN).collect(Collectors.toList());
	}

	public static double calculateScore(List<String> correctAnswers, List<String> playerAnswers, int maxPoints) {
		Set<String> correctSet = new HashSet<>(correctAnswers);
		Set<String> playerSet = new HashSet<>(playerAnswers);

		Set<String> correctProvided = new HashSet<>(playerSet);
		correctProvided.retainAll(correctSet);

		Set<String> incorrectProvided = new HashSet<>(playerSet);
		incorrectProvided.removeAll(correctSet);

		int numCorrectProvided = correctProvided.size();
		int numTotalCorrect = correctSet.size();

		if (playerSet.isEmpty()) {
			return 0;
		} else if (numCorrectProvided == numTotalCorrect && incorrectProvided.isEmpty()) {
			return maxPoints;
		} else if (numCorrectProvided > 0 && incorrectProvided.isEmpty()) {
			return (double) maxPoints * numCorrectProvided / numTotalCorrect;
		} else {
			double penalty = 0.5 * incorrectProvided.size();
			double earnedPoints = (double) maxPoints * numCorrectProvided / numTotalCorrect - penalty;
			return Math.max(0, earnedPoints);
		}
	}

}
