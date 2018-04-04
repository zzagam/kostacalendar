package org.kostacalendar.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kostacalendar.model.KCUserDAO;
import org.kostacalendar.model.KCUserDTO;

public class CreateUserController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * HttpSession session=request.getSession();
		 * if(session==null||session.getAttribute("KCUserDTO")==null) { return
		 * "redirect:index.jsp"; }else {
		 */
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		KCUserDTO dto = new KCUserDTO(id, password, name,0);
		KCUserDAO.getInstance().register(dto);
		return "redirect:index.jsp";
	}
}
