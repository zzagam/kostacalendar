package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kostacalendar.model.KCUserDTO;
import org.kostacalendar.model.ListVO;
import org.kostacalendar.model.PagingBean;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class GetBoardController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		String np = request.getParameter("nowPage");
		int nowPage=0;
		if (np==null) {
			nowPage=1;
		}else {
			nowPage = Integer.parseInt(np);
		}
		KCUserDTO dto = (KCUserDTO)session.getAttribute("dto");
		String id = dto.getId(); 
		int totalTodoCount=TodoListDAO.getInstance().getTotalTodoListById(id);
		ListVO list = new ListVO();
		list.setPb(new PagingBean(totalTodoCount, nowPage));
		ArrayList<TodoListDTO> pageTodoList = TodoListDAO.getInstance().getBoardTodoListById(id,list.getPb().getStartRowNumber(), list.getPb().getEndRowNumber());
		list.setList(pageTodoList);
		request.setAttribute("pagingList", list);
		return "alltodolist/board.jsp";
	}

}
