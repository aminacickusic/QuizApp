package model;

import java.sql.Date;
import java.lang.Override;

import java.sql.SQLException;

public class User {
	private String email;
	private String username;
	private String hashedPassword;
	private String role;
	private Integer avatar;
	
	public User() {
		super();
		this.email = null;
		this.username = null;
		this.hashedPassword = null;
		this.role = null;
		this.avatar = null;
	}

	public User(String email, String username, String hashedPassword, String role, Integer avatar) {
		super();
		this.email = email;
		this.username = username;
		this.hashedPassword = hashedPassword;
		this.role = role;
		this.avatar = avatar;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getHashedPassword() {
		return hashedPassword;
	}

	public void setHashedPassword(String hashedPassword) {
		this.hashedPassword = hashedPassword;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Integer getAvatar() {
		return avatar;
	}

	public void setAvatar(Integer avatar) {
		this.avatar = avatar;
	}

	@Override
	public String toString() {
		return "User [email=" + email + ", username=" + username + ", hashedPassword=" + hashedPassword + ", role="
				+ role + ", avatar=" + avatar + "]";
	}

	
	public Date getJoinDate() throws ClassNotFoundException, SQLException {
		UserDatabaseService service = new UserDatabaseService();
		Date date = service.getDate(this.email);
		return date;
		
	}
	


}
