package org.kostacalendar.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kostacalendar.model.KCUserDAO;

public class IdCheckController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		boolean flag=KCUserDAO.getInstance().idcheck(id);
		if(flag)
			return "/alltodolist/idcheck_fail.jsp";
		else
			return "/alltodolist/idcheck_ok.jsp";
	}
}
