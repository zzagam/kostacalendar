package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class ReadDetailController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int todoNo=Integer.parseInt(request.getParameter("todoNo"));
		String id = request.getParameter("userId");
		//PrintWriter out = response.getWriter();
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().getTodoListById(id);
		System.out.println("######");
		JSONArray json = new JSONArray(list);
		//out.print(json.toString());
		request.setAttribute("todo_list", json);
		TodoListDTO todo=TodoListDAO.getInstance().getReadDetail(todoNo);
		request.setAttribute("tdto", todo);
		request.setAttribute("url", "/alltodolist/detail.jsp");
		return "template/calendar.jsp";
	}
}
