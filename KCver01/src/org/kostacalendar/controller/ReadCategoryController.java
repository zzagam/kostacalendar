package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.kostacalendar.model.CategoryDTO;
import org.kostacalendar.model.TodoListDAO;

public class ReadCategoryController implements Controller {
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<CategoryDTO> list = TodoListDAO.getInstance().getCategoryList();
		JSONArray json = new JSONArray(list);
	
		request.setAttribute("responseBody", json);
		return "AjaxView";
		
		
		
		
	}

}
