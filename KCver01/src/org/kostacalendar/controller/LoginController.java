package org.kostacalendar.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kostacalendar.model.KCUserDAO;
import org.kostacalendar.model.KCUserDTO;

public class LoginController implements Controller {

	/**
	 *	index창에서 아이디와 비밀번호를 받아와
	 *	그 아이디와 비밀번호를 DAO로 넘겨 있으면 로그인 처리 후 
	 *	세션을 열어준다
	 *
	 *	리턴되는 곳은	home.jsp이다
	 */
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("userId");
		String password=request.getParameter("userPassword");
		KCUserDTO dto=KCUserDAO.getInstance().login(new KCUserDTO(id,password,null,0));
		String url=null;
		if(dto!=null) {
			HttpSession session=request.getSession(true);
			session.setAttribute("dto", dto);
			url="template/home.jsp";
			
			
		}else {
			url="alltodolist/login_fail.jsp";
		}
		return "redirect:"+url;
		
	}

}
