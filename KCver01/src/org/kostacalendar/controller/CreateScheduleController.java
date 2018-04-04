package org.kostacalendar.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kostacalendar.model.CategoryDTO;
import org.kostacalendar.model.KCUserDTO;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class CreateScheduleController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		KCUserDTO dto = (KCUserDTO) session.getAttribute("dto");
		CategoryDTO category = new CategoryDTO(Integer.parseInt(request.getParameter("category")), null);
	
		String title=request.getParameter("title");		
		String sttdate=request.getParameter("sttdate");
		String enddate=request.getParameter("enddate");
		String description=request.getParameter("description");		
		
		TodoListDTO td =new TodoListDTO();
		td.setUser(dto);
		td.setCategory(category);
		td.setTitle(title);
		td.setStartDate(sttdate);
		td.setEndDate(enddate);
		td.setContent(description);
		TodoListDAO.getInstance().createSchedule(td);
		return "index.jsp";
	}

}
