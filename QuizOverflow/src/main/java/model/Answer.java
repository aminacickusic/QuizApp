package model;
import java.lang.Override;

public class Answer {
	private Integer id;
	private Integer questionID;
	private String answer;
	private boolean isTrue;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getQuestionID() {
		return questionID;
	}
	public void setQuestionID(Integer questionID) {
		this.questionID = questionID;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public boolean isTrue() {
		return isTrue;
	}
	public void setTrue(boolean isTrue) {
		this.isTrue = isTrue;
	}
	@Override
	public String toString() {
		return "Answer [id=" + id + ", questionID=" + questionID + ", answer=" + answer + ", isTrue=" + isTrue + "]";
	}
	public Answer(Integer id, Integer questionID, String answer, boolean isTrue) {
		super();
		this.id = id;
		this.questionID = questionID;
		this.answer = answer;
		this.isTrue = isTrue;
	}
	
	public Answer(String answer, boolean isTrue) {
		super();
		this.id = null;
		this.questionID = null;
		this.answer = answer;
		this.isTrue = isTrue;
	}
	
	
	public Answer() {
		super();
		this.id = null;
		this.questionID = null;
		this.answer = null;
		this.isTrue = false;
	}
	
	

}
