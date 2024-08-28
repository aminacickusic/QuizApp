package model;
import java.util.ArrayList;
import java.util.List;

public class Quiz {
	private Integer quizID;
	private String quizName;
	private String quizImg;
	private String quizAuthor;
	private String quizTheme;
	private Integer quizQuestionNumber;
	private List<Question> questionsList;
	
	public Integer getQuizID() {
		return quizID;
	}
	public List<Question> getQuestionsList() {
		return questionsList;
	}
	public void setQuestionsList(List<Question> questionsList) {
		this.questionsList = questionsList;
	}
	public void setQuizID(Integer quizID) {
		this.quizID = quizID;
	}
	public String getQuizName() {
		return quizName;
	}
	public void setQuizName(String quizName) {
		this.quizName = quizName;
	}
	public String getQuizImg() {
		return quizImg;
	}
	public void setQuizImg(String quizImg) {
		this.quizImg = quizImg;
	}
	public String getQuizAuthor() {
		return quizAuthor;
	}
	public void setQuizAuthor(String quizAuthor) {
		this.quizAuthor = quizAuthor;
	}
	public String getQuizTheme() {
		return quizTheme;
	}
	public void setQuizTheme(String quizTheme) {
		this.quizTheme = quizTheme;
	}
	public Integer getQuizQuestionNumber() {
		return quizQuestionNumber;
	}
	public void setQuizQuestionNumber(Integer quizQuestionNumber) {
		this.quizQuestionNumber = quizQuestionNumber;
	}
	public Quiz(Integer quizID, String quizName, String quizImg, String quizAuthor, String quizTheme,
			Integer quizQuestionNumber, List<Question> list) {
		super();
		this.quizID = quizID;
		this.quizName = quizName;
		this.quizImg = quizImg;
		this.quizAuthor = quizAuthor;
		this.quizTheme = quizTheme;
		this.quizQuestionNumber = quizQuestionNumber;
		this.questionsList = list;
	}
	
	public Quiz(String quizName, String quizImg, String quizAuthor, String quizTheme,
			Integer quizQuestionNumber, List<Question> list) {
		super();
		this.quizID = null;
		this.quizName = quizName;
		this.quizImg = quizImg;
		this.quizAuthor = quizAuthor;
		this.quizTheme = quizTheme;
		this.quizQuestionNumber = quizQuestionNumber;
		this.questionsList = list;
	}
	
	
	
	public Quiz() {
		super();
		this.quizID = null;
		this.quizName = null;
		this.quizImg = null;
		this.quizAuthor = null;
		this.quizTheme = null;
		this.quizQuestionNumber = null;
		this.questionsList = new ArrayList<Question>();
	}
	@Override
	public String toString() {
		return "Quiz [quizID=" + quizID + ", quizName=" + quizName + ", quizImg=" + quizImg + ", quizAuthor="
				+ quizAuthor + ", quizTheme=" + quizTheme + ", quizQuestionNumber=" + quizQuestionNumber;
	}
	

}
