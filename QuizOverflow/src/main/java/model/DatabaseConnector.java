package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DatabaseConnector {
	private static final String jdbcUrl = "jdbc:postgresql://localhost:5432/rwaquizzes";
	private static final String username = "myuser";
	private static final String password = "rwa123";

	public static Connection getConnection() throws ClassNotFoundException, SQLException {

		Class.forName("org.postgresql.Driver");

		Connection conn = DriverManager.getConnection(jdbcUrl, username, password);
		return conn;
	}

}