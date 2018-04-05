package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class ReadTodayController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("userId");
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().getTodayTodoList(id);
		request.setAttribute("todayList", list);
		if (list.isEmpty()) {
			return "alltodolist/todayTodo_no.jsp";
		}
		
		
		return "alltodolist/todayTodo.jsp";

	}

}
