package model;

import java.util.ArrayList;
import java.util.List;
import java.lang.Override;


public class Question {
	private Integer id;
	private Integer ordinalNum;
	private Integer quizID;
	private String question;
	private Integer time;
	private Integer points;
	private Integer numOfAnswers;
	private List<Answer> answersList;

	public List<Answer> getAnswersList() {
		return answersList;
	}

	public void setAnswersList(List<Answer> answersList) {
		this.answersList = answersList;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrdinalNum() {
		return ordinalNum;
	}

	public void setOrdinalNum(Integer ordinalNum) {
		this.ordinalNum = ordinalNum;
	}

	public Integer getQuizID() {
		return quizID;
	}

	public void setQuizID(Integer quizID) {
		this.quizID = quizID;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public Integer getTime() {
		return time;
	}

	public void setTime(Integer time) {
		this.time = time;
	}

	public Integer getPoints() {
		return points;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}

	public Integer getNumOfAnswers() {
		return numOfAnswers;
	}

	public void setNumOfAnswers(Integer numOfAnswers) {
		this.numOfAnswers = numOfAnswers;
	}

	@Override
	public String toString() {
		return "Question [id=" + id + ", ordinalNum=" + ordinalNum + ", quizID=" + quizID + ", question=" + question
				+ ", time=" + time + ", points=" + points + ", numOfAnswers=" + numOfAnswers + "]";
	}

	public Question(Integer id, Integer ordinalNum, Integer quizID, String question, Integer time, Integer points,
			Integer numOfAnswers, List<Answer> list) {
		super();
		this.id = id;
		this.ordinalNum = ordinalNum;
		this.quizID = quizID;
		this.question = question;
		this.time = time;
		this.points = points;
		this.numOfAnswers = numOfAnswers;
		this.answersList = list;
	}
	
	
	public Question(Integer ordinalNum, Integer quizID, String question, Integer time, Integer points,
			Integer numOfAnswers, List<Answer> list) {
		super();
		this.id = null;
		this.ordinalNum = ordinalNum;
		this.quizID = quizID;
		this.question = question;
		this.time = time;
		this.points = points;
		this.numOfAnswers = numOfAnswers;
		this.answersList = list;
	}
	
	
	public Question() {
		super();
		this.id = null;
		this.ordinalNum = null;
		this.quizID = null;
		this.question = null;
		this.time = null;
		this.points = null;
		this.numOfAnswers = null;
		this.answersList = new ArrayList<Answer>();
	}

}
