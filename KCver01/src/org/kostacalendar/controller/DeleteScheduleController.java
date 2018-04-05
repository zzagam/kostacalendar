package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.kostacalendar.model.KCUserDTO;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class DeleteScheduleController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		HttpSession session=request.getSession(false);
		KCUserDTO kcUserdto = (KCUserDTO) session.getAttribute("dto");
		System.out.println("*******");
		int todoNo=Integer.parseInt(request.getParameter("todoNo"));
		TodoListDAO.getInstance().deleteSchedule(kcUserdto.getId(), todoNo);
		
		
		
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().getTodoListById(kcUserdto.getId());
		JSONArray json = new JSONArray(list);
		//out.print(json.toString());
		request.setAttribute("todo_list", json);
		TodoListDTO todo=TodoListDAO.getInstance().getReadDetail(todoNo);
		request.setAttribute("tdto", todo);
		request.setAttribute("todoNo", todoNo);
		request.setAttribute("url", "right.jsp");
		return "redirect:index.jsp";
	}

}