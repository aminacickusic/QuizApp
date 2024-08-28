package model;

import java.time.LocalDateTime;

public class InboxMessage {
	private Integer id;
	private String email;
	private String messageText;
	private boolean isRead;
	private LocalDateTime dateTime;
	
	public LocalDateTime getDateTime() {
		return dateTime;
	}
	public void setDateTime(LocalDateTime dateTime) {
		this.dateTime = dateTime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	
	@Override
	public String toString() {
		return "InboxMessage [id=" + id + ", email=" + email + ", messageText=" + messageText + ", isRead=" + isRead
				+ ", dateTime=" + dateTime + "]";
	}
	public InboxMessage(Integer id, String email, String messageText, boolean isRead, LocalDateTime date) {
		super();
		this.id = id;
		this.email = email;
		this.messageText = messageText;
		this.isRead = isRead;
		this.dateTime = date;
	}
	
	public InboxMessage() {
		super();
		this.id = null;
		this.email = null;
		this.messageText = null;
		this.isRead = false;
		this.dateTime = null;
	}
	
	
	
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMessageText() {
		return messageText;
	}
	public void setMessageText(String messageText) {
		this.messageText = messageText;
	}
	public boolean isRead() {
		return isRead;
	}
	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}

}
