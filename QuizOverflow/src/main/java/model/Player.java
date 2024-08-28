package model;

import jakarta.websocket.Session;

public class Player {
	private Session session;
    private String name;
    private Double score;
    private Role role;
    private String lastName;
    private Integer avatar;
   

	public Integer getAvatar() {
		return avatar;
	}

	public void setAvatar(Integer avatar) {
		this.avatar = avatar;
	}

	public enum Role {
        ADMIN, PLAYER
    }

    public Player(Session session, String name, String lastName, Role role, Integer avatar) {
        this.session = session;
        this.name = name;
        this.score = (double) 0;
        this.role = role;
        this.lastName = lastName;
        this.avatar = avatar;
    }
    
    @Override
	public String toString() {
		return "Player [session=" + session + ", name=" + name + ", score=" + score + ", role=" + role + ", lastName="
				+ lastName + ", avatar=" + avatar + "]";
	}

	public Player() {
        this.session = null;
        this.name = null;
        this.score = (double) 0;
        this.role = null;
        this.lastName = null;
        this.avatar = 1;
    }
    
    
    

	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

  
}
