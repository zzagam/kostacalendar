package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.kostacalendar.model.KCUserDTO;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class UpdateViewController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		int todoNo = Integer.parseInt(request.getParameter("todoNo"));
		System.out.println("업데이트 뷰 : " + todoNo);
		if (session == null || session.getAttribute("dto") == null) {
			System.out.println("세션 없음");
			return "redirect:/template/home.jsp";
		}
		KCUserDTO id = (KCUserDTO)session.getAttribute("dto");
		TodoListDTO tdListDTO = TodoListDAO.getInstance().getPostingByNo(todoNo);
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().getTodoListById(id.getId());
		
		for (int i=0 ; i<list.size() ; i++) {
			System.out.println(list.get(i).getTitle());
		}
		JSONArray json = new JSONArray(list);
		System.out.println("$$$$$$4"+json.toString());
		request.setAttribute("todo_list", json);
		request.setAttribute("tdListDTO", tdListDTO);
		request.setAttribute("todoNo", todoNo);
		request.setAttribute("url", "../alltodolist/update.jsp");
		System.out.println(tdListDTO.getCategory().getCategoryNo());
		return "template/calendar.jsp";
	}

}

/*
 * HttpServletResponse response) throws Exception { HttpSession
 * session=request.getSession(false);
 * if(session==null||session.getAttribute("mvo")==null){ return
 * "redirect:index.jsp"; } int no=Integer.parseInt(request.getParameter("no"));
 * PostVO vo = BoardDAO.getInstance().getPostingByNo(no); request.setAttribute(
 * "pvo", vo); request.setAttribute("url", "/board/update.jsp"); return
 * "/template/home.jsp";
 * 
 */