package org.kostacalendar.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.kostacalendar.model.KCUserDAO;

public class AjaxCheckIdController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("userId");
		
		boolean checkDup = KCUserDAO.getInstance().checkIdDup(id);
		JSONObject json = new JSONObject();
		
		if (checkDup==false) {
			json.put("flag", "fail");
		}
		
		request.setAttribute("responseBody", json);
		
		return "AjaxView";
	}

}
