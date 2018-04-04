package org.kostacalendar.model;

public class TodoListDTO {
	private int todoNo;
	private KCUserDTO user;
	private CategoryDTO category;
	private String title;
	private String content;
	private String startDate;
	private String endDate;
	private int count;
	public TodoListDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TodoListDTO(int todoNo, KCUserDTO user, CategoryDTO category, String title, String content,
			String startDate, String endDate) {
		super();
		this.todoNo = todoNo;
		this.user = user;
		this.category = category;
		this.title = title;
		this.content = content;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getTodoNo() {
		return todoNo;
	}
	public void setTodoNo(int todoNo) {
		this.todoNo = todoNo;
	}
	public KCUserDTO getUser() {
		return user;
	}
	public void setUser(KCUserDTO user) {
		this.user = user;
	}
	public CategoryDTO getCategory() {
		return category;
	}
	public void setCategory(CategoryDTO category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
