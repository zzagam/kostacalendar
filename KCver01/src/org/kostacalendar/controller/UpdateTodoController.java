package org.kostacalendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.kostacalendar.model.CategoryDTO;
import org.kostacalendar.model.KCUserDTO;
import org.kostacalendar.model.TodoListDAO;
import org.kostacalendar.model.TodoListDTO;

public class UpdateTodoController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("dto")==null){
			return "redirect:index.jsp";
		}
		KCUserDTO kcUserdto = (KCUserDTO) session.getAttribute("dto");
		int todoNo=Integer.parseInt(request.getParameter("todoNo"));
		String category_no = request.getParameter("category_no");
		String title = request.getParameter("title");
		String content = request.getParameter("contents");
		String start_date=request.getParameter("start_date").replace("-", "");
		System.out.println(start_date);
		String starttime = request.getParameter("starttime").replace(":", "");
		System.err.println(starttime);	
		String start = start_date + starttime;
		String end_date=request.getParameter("end_date").replace("-", "");
		String endtime=request.getParameter("endtime").replace(":", "");
		String end = end_date + endtime;
		System.out.println(start);
		System.out.println(end);
		
		TodoListDTO tdListDTO=new TodoListDTO();
		tdListDTO.setTodoNo(todoNo);
		tdListDTO.setCategory(new CategoryDTO(Integer.parseInt(category_no),null));
		tdListDTO.setStartDate(start);
		tdListDTO.setEndDate(end);
		tdListDTO.setTitle(title);
		tdListDTO.setContent(content);
		tdListDTO.setUser(new KCUserDTO(kcUserdto.getId(), null, null, 0));
		TodoListDAO.getInstance().updatePosting(tdListDTO);
		
		
		ArrayList<TodoListDTO> list = TodoListDAO.getInstance().getTodoListById(kcUserdto.getId());
		System.out.println("****");
		JSONArray json = new JSONArray(list);
		//out.print(json.toString());
		request.setAttribute("todo_list", json);
		TodoListDTO todo=TodoListDAO.getInstance().getReadDetail(todoNo);
		request.setAttribute("tdto", todo);
		request.setAttribute("todoNo", todoNo);
		request.setAttribute("url", "right.jsp");
		return "index.jsp";
		
		
	}

}
