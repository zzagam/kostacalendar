package org.kostacalendar.model;

public class KCUserDTO {
	private String id;
	private String password;
	private String name;
	private int grade;
	public KCUserDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public KCUserDTO(String id, String password, String name, int grade) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.grade = grade;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	

}
