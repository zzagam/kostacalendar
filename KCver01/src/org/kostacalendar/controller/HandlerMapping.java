package org.kostacalendar.controller;

public class HandlerMapping {
	private static HandlerMapping instance=new HandlerMapping();
	private HandlerMapping(){}
	public static HandlerMapping getInstance(){
		return instance;
	}
	public Controller create(String command){
		Controller c=null;
		if (command.equals("login")) {
			c=new LoginController();
		}else if (command.equals("readCalendar")) {
			c=new ReadCalendarController();
		}else if (command.equals("readCategory")) {
			c=new ReadCategoryController();
		}else if (command.equals("readToday")) {
			c=new ReadTodayController();
		}else if (command.equals("readDetail")) {
			c=new ReadDetailController();
		}else if (command.equals("logout")) {
			c=new LogoutController();
		}else if (command.equals("createUser")) {
			c=new CreateUserController();
		}else if (command.equals("idcheck")) {
			c=new IdCheckController();
		}else if (command.equals("getCategoryCount")) {
			c=new ReadCountController();
		}else if (command.equals("updateView")) {
			c=new UpdateViewController();
		}else if (command.equals("updateTodo")) {
			c=new UpdateTodoController();
		}else if (command.equals("createSchedule")) {
			c=new CreateScheduleController();
		}else if (command.equals("getCategory")) {
			c=new ReadCategoryController() ;
		}else if (command.equals("deleteSchedule")) {
			c=new DeleteScheduleController() ;
		}else if (command.equals("readCountDetail")) {
			c=new ReadCountDetailController();
		}else if (command.equals("ajaxId")) {
			c=new AjaxCheckIdController();
		}else if (command.equals("getBoard")) {
			c=new GetBoardController();
		}
		return c;
	}
}










