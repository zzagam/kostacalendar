package org.kostacalendar.model;

public class CategoryDTO {
	private int categoryNo;
	private String categoryName;
	public CategoryDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CategoryDTO(int category_no, String categoryName) {
		super();
		this.categoryNo = category_no;
		this.categoryName = categoryName;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
}
