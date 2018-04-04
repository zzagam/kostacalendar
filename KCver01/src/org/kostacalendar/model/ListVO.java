package org.kostacalendar.model;

import java.util.ArrayList;

public class ListVO {
	private ArrayList<TodoListDTO> list;
	private PagingBean pb;
	public ListVO(ArrayList<TodoListDTO> list, PagingBean pb) {
		super();
		this.list = list;
		this.pb = pb;
	}
	public ListVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ArrayList<TodoListDTO> getList() {
		return list;
	}
	public void setList(ArrayList<TodoListDTO> list) {
		this.list = list;
	}
	public PagingBean getPb() {
		return pb;
	}
	public void setPb(PagingBean pb) {
		this.pb = pb;
	}
	@Override
	public String toString() {
		return "ListVO [list=" + list + ", pb=" + pb + "]";
	}

}
