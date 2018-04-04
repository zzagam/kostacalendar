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
		HttpSession session = request.getSession(false);
		
		//아이디
		KCUserDTO dto = (KCUserDTO) session.getAttribute("dto");
		
		//카테고리번호
		CategoryDTO category = new CategoryDTO(Integer.parseInt(request.getParameter("category")), null);
		
		//제목
		String title=request.getParameter("title");	
		
		//시작일자
		String sttdate=request.getParameter("sttdate").replace("-", "");
		System.out.println(sttdate);
		String stttime = request.getParameter("stttime").replace(":", "");
		System.err.println(stttime);
		String start = sttdate + stttime;
		System.out.println(start);
		//끝나는 일자
		String enddate=request.getParameter("enddate").replace("-", "");
		String endtime=request.getParameter("endtime").replace(":", "");
		String end = enddate + endtime;
		
		//설명
		String description=request.getParameter("description");		
		
		TodoListDTO td =new TodoListDTO();
		td.setUser(dto);
		td.setCategory(category);
		td.setTitle(title);
		td.setStartDate(start);
		td.setEndDate(end);
		td.setContent(description);
		TodoListDAO.getInstance().createSchedule(td);
		return "redirect:index.jsp";
	}

}
