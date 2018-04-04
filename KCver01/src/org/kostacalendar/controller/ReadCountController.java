package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class ReadCountController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("userId");
		
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().getEachCategoryCount(id);
		
		JSONArray json = new JSONArray(list);
		request.setAttribute("responseBody", json);
		return "AjaxView";
	}

}
