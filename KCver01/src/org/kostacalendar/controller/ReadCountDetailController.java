package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.kostacalendar.model.KCUserDTO;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class ReadCountDetailController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int categoryNo=Integer.parseInt(request.getParameter("categoryNo"));
		
		HttpSession session = request.getSession(false);
		KCUserDTO user = (KCUserDTO)session.getAttribute("dto");
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().readCountDetail(categoryNo, user.getId());
		JSONArray json = new JSONArray(list);
		
		request.setAttribute("todo_list", json);
		request.setAttribute("url", "right.jsp");
		return "template/calendar.jsp";
	}

}
