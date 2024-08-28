import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import model.DatabaseConnector;
import model.PasswordUtils;
import model.User;
import model.UserDatabaseService;

public class Init {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		Connection conn = DatabaseConnector.getConnection();

		User user = new User();
		user.setEmail("admin@quizoverflow.com");
		user.setUsername("admin");
		user.setHashedPassword(PasswordUtils.hashPassword("rwa12345"));
		user.setRole("admin");
		user.setAvatar(13);

		UserDatabaseService service = new UserDatabaseService();
		service.addUser(user);
		service.setJoinDate(user.getEmail(), LocalDate.now());

	}

}
