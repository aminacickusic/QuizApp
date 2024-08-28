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
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class UserDatabaseService {

	private Connection connect_ = null;
	private PreparedStatement preparedStatement_ = null;
	private String query_ = null;

	public UserDatabaseService(Connection conn) {
		this.connect_ = conn;
	}

	public UserDatabaseService() throws SQLException, ClassNotFoundException {
		this.connect_ = DatabaseConnector.getConnection();
	}

	public void changeReadMessage(Integer id, boolean value) {
		query_ = "UPDATE inbox SET isRead=? WHERE id=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setBoolean(1, value);
			preparedStatement_.setInt(2, id);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void setJoinDate(String email, LocalDate date) {
		Date dateDB = Date.valueOf(date);
		query_ = "INSERT INTO joinDate VALUES(?,?)";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			preparedStatement_.setDate(2, dateDB);
			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Integer getNewUsers() {
		query_ = "SELECT COUNT(*) AS numberOfUsers FROM joinDate WHERE joinDate >= CURRENT_DATE - INTERVAL '7 days';";
		ResultSet result;
		Integer num = 0;
		try {
			preparedStatement_ = connect_.prepareStatement(query_);

			result = preparedStatement_.executeQuery();

			while (result.next()) {
				num = result.getInt("numberOfUsers");

			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	public List<String> getAdmins() {
		List<String> list = new ArrayList<String>();
		ResultSet result;
		query_ = "SELECT email FROM users  WHERE role=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, "admin");
			result = preparedStatement_.executeQuery();

			while (result.next()) {

				list.add(result.getString("email"));
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<String> getAllUsers() {
		List<String> list = new ArrayList<String>();
		ResultSet result;
		query_ = "SELECT email FROM users";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			result = preparedStatement_.executeQuery();

			while (result.next()) {

				list.add(result.getString("email"));
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public void insertInboxMessage(String email, String message, LocalDateTime time) {
		query_ = "INSERT INTO inbox (email, messageText, isRead, dateAndTime) VALUES (?,?,?,?);";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			preparedStatement_.setString(2, message);
			preparedStatement_.setBoolean(3, false);
			preparedStatement_.setTimestamp(4, Timestamp.valueOf(time));
			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<InboxMessage> getMyMessages(String email) {
		List<InboxMessage> messages = new ArrayList<InboxMessage>();
		ResultSet result;
		query_ = "SELECT * FROM inbox where email = ?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			result = preparedStatement_.executeQuery();

			while (result.next()) {
				InboxMessage message = new InboxMessage();
				message.setEmail(result.getString("email"));
				message.setId(result.getInt("id"));
				message.setMessageText(result.getString("messageText"));
				message.setRead(result.getBoolean("isRead"));
				Timestamp timestamp = result.getTimestamp("dateAndTime");
				LocalDateTime localDateTime = timestamp.toLocalDateTime();
				message.setDateTime(localDateTime);
				messages.add(message);
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		Collections.sort(messages, new Comparator<InboxMessage>() {
			@Override
			public int compare(InboxMessage m1, InboxMessage m2) {
				return m2.getDateTime().compareTo(m1.getDateTime());
			}
		});

		return messages;
	}

	public void deleteMessage(Integer id) {
		query_ = "DELETE FROM inbox WHERE id=?;";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setInt(1, id);
			preparedStatement_.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void changeUsername(String email, String username) {
		query_ = "UPDATE users SET username=? WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(2, email);
			preparedStatement_.setString(1, username);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void changeEmail(String email, String formEmail) {
		query_ = "UPDATE users SET email=? WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(2, email);
			preparedStatement_.setString(1, formEmail);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "UPDATE quizzes SET author=? WHERE author=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(2, email);
			preparedStatement_.setString(1, formEmail);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "UPDATE quizzesPerUser SET userID=? WHERE userID=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(2, email);
			preparedStatement_.setString(1, formEmail);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "UPDATE joinDate SET email=? WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(2, email);
			preparedStatement_.setString(1, formEmail);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void changePassword(String email, String newPassword) {
		query_ = "UPDATE users SET password=? WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(2, email);
			preparedStatement_.setString(1, newPassword);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public User getUserByEmail(String email) {

		ResultSet result;
		List<User> list = new ArrayList<>();

		query_ = "SELECT * FROM users  WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			result = preparedStatement_.executeQuery();

			while (result.next()) {
				User user = new User();

				user.setEmail(email);
				user.setUsername(result.getString("username"));
				user.setHashedPassword(result.getString("password"));
				user.setRole(result.getString("role"));
				user.setAvatar(result.getInt("avatar"));
				list.add(user);
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (list.isEmpty())
			return null;
		else
			return list.get(0);

	}

	public List<User> getUsers() {

		ResultSet result;
		List<User> list = new ArrayList<>();

		query_ = "SELECT * FROM users";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			result = preparedStatement_.executeQuery();

			while (result.next()) {
				User user = new User();
				user.setEmail(result.getString("email"));
				user.setUsername(result.getString("username"));
				user.setHashedPassword(result.getString("password"));
				user.setRole(result.getString("role"));
				user.setAvatar(result.getInt("avatar"));
				list.add(user);
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<User> getUsersSortedByUsername() {

		ResultSet result;
		List<User> list = new ArrayList<>();

		query_ = "SELECT * FROM users ORDER BY username";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			result = preparedStatement_.executeQuery();

			while (result.next()) {
				User user = new User();
				user.setEmail(result.getString("email"));
				user.setUsername(result.getString("username"));
				user.setHashedPassword(result.getString("password"));
				user.setRole(result.getString("role"));
				user.setAvatar(result.getInt("avatar"));
				list.add(user);
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public void deleteUser(String email) {
		query_ = "DELETE FROM users WHERE email=?;";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			preparedStatement_.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "DELETE FROM joinDate WHERE email=?;";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			preparedStatement_.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "DELETE FROM quizzesPerUser WHERE userID=?;";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			preparedStatement_.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "DELETE FROM inbox WHERE email=?;";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			preparedStatement_.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public Date getDate(String email) {
		ResultSet result;
		List<Date> list = new ArrayList<>();

		query_ = "SELECT joinDate FROM joinDate  WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, email);
			result = preparedStatement_.executeQuery();

			while (result.next()) {
				Date date = result.getDate("joinDate");

				list.add(date);
			}

			result.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (list.isEmpty())
			return null;
		else
			return list.get(0);
	}

	public void addUser(User user) {
		query_ = "INSERT INTO users VALUES (?,?,?,?,?);";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, user.getEmail());
			preparedStatement_.setString(2, user.getUsername());
			preparedStatement_.setString(3, user.getHashedPassword());
			preparedStatement_.setString(4, user.getRole());
			preparedStatement_.setInt(5, user.getAvatar());
			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		query_ = "INSERT INTO quizzesPerUser (userID, numOfQuizzes) VALUES (?,?);";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, user.getEmail());
			preparedStatement_.setInt(2, 0);
			preparedStatement_.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void addAvatar(User user, Integer avatar) {
		query_ = "UPDATE users SET avatar=? WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(2, user.getEmail());
			preparedStatement_.setInt(1, avatar);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void editUser(String email, String role, String username, String newEmail) {
		query_ = "UPDATE users SET username=?, role=? WHERE email=?";
		try {
			preparedStatement_ = connect_.prepareStatement(query_);
			preparedStatement_.setString(1, username);
			preparedStatement_.setString(2, role);
			preparedStatement_.setString(3, email);
			preparedStatement_.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		changeEmail(email, newEmail);

	}

}
