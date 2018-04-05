package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.kostacalendar.model.KCUserDTO;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class ReadCalendarController implements Controller {
	/**
	 * 현재 날짜의 달을 입력받아 그 달에 로그인한 사용자의 
	 * 일정을 달력에 표시한다. 일정들은 일정번호, 일정제목만을 받아와서
	 * ArrayList로 입력한다
	 */
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession(false);
		if (session==null || session.getAttribute("dto")==null) {
			return "/index.jsp";
		}
		KCUserDTO dto = (KCUserDTO)session.getAttribute("dto");
		String id = dto.getId();
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().getTodoListById(id);
		
		JSONArray json = new JSONArray(list);
		//out.print(json.toString());
		request.setAttribute("todo_list", json);
		request.setAttribute("url", "right.jsp");
		return "template/calendar.jsp";
	}

}
