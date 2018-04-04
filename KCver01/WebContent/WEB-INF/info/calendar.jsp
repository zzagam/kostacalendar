<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mystyle.css?ver6"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script><link href='css/fullcalendar-3.9.0/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/lib/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/lib/jquery.min.js'></script>
<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.min.js'></script>

<script type="text/javascript">
	function checkLogout(){
		var flag = confirm("로그아웃 하시겠습니까?");
		return flag;
	}
	function checkRegister(){
		var flag = confirm("일정을 등록하시겠습니까?");
		return flag;
	}
	$(document).ready(function() {
		$("#getCategoryBtn").click(function() {
			$("#categorySelect").empty();
			$("#categorySelect").append("<option>선택하세요</option>");
			$.ajax({
					type : "post",
					dataType : "json",
					url : "${pageContext.request.contextPath}/dispatcher",
					data : $("#getCategory").serialize(),
					success : function(datas) {									
						for (var i=0 ; i<datas.length ; i++){										
							var options = "<option value="+datas[i].categoryNo+">"+datas[i].categoryName+"</option>";
							$("#categorySelect").append(options); 
						}
					}								
			});							
		});
		
	 	$.ajax({
	 		
			type:"post",
			dataType:"json",
			url:"${pageContext.request.contextPath}/dispatcher",
			data:$("#categoryForm").serialize(),
			success:function(data){
				$("#categoryNo1").html(data[0].category.categoryName+" "+data[0].count);
				
				$("#categoryNo2").html(data[1].category.categoryName+" "+data[1].count);
				
				$("#categoryNo3").html(data[2].category.categoryName+" "+data[2].count);
				
				
					
			}
		}); 
		
		
		
		var todoJson=${requestScope.todo_list}; 
		var events= new Array();
		var todoEvents2 = new Array();
		
		for (var i=0 ; i<todoJson.length ; i++){
			event = new Object();
			event.title = todoJson[i].title;
			event.start = new Date(todoJson[i].startDate);
			event.end = new Date(todoJson[i].endDate);
			event.todoNo=todoJson[i].todoNo;
			event.url="${pageContext.request.contextPath}/dispatcher?command=readDetail&todoNo="+todoJson[i].todoNo+"&userId=${sessionScope.dto.id}";
			
			if (todoJson[i].category.categoryNo==1){
				event.className='category1';	
			}else if (todoJson[i].category.categoryNo==2){
				event.className='category2';
			}else if (todoJson[i].category.categoryNo==3){
				event.className='category3';
			}
			events.push(event);
		}		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title'
			}
		});
		$('#calendar').fullCalendar('addEventSource',events);
	});
	 
</script>
<style type="text/css">

	body {
		margin-top: 40px;
		text-align: left;
		font-size: 14px;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		}

	#calendar {
		width: 500px;
		margin: 0 auto; 
		}

</style>
</head>
<body>
		<div class="row">
		<div class="col-sm-2">
		<form action="${pageContext.request.contextPath}/index.jsp">
			<input type="submit" class="btn btn-default btn-lg" value="홈으로">
		</form><br><hr><br>
			${sessionScope.dto.name }님 환영합니다.<br>
		<form id="categoryForm">
			<input type="hidden" name="command" value="getCategoryCount">
			<input type="hidden" name="userId" value="${sessionScope.dto.id}">
			<span class ="countCategory1" id="categoryNo1"></span><br>
			<span class ="countCategory2" id="categoryNo2"></span><br>
			<span class ="countCategory3" id="categoryNo3"></span><br>
		</form>
		<form action="${pageContext.request.contextPath}/dispatcher" onsubmit="return checkLogout()">
			<input type="hidden" name="command" value="logout">
			<input type="submit" class="btn btn-default btn-lg" value="로그아웃">
		</form>
		<form id="getCategory" method="post">
			<input type="hidden" name="command" value="getCategory">
				<button id="getCategoryBtn"  type="button" class="btn btn-default" data-toggle="modal"
							data-target="#myModal">일정추가</button>						
			</form>
			<form id="registerForm" action="${pageContext.request.contextPath}/dispatcher" method="get" onsubmit="return checkRegister()">
				<input type="hidden" name="command" value="createSchedule">
					<!-- Modal -->
					<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">일정등록</h4>
								</div>
								<div class="modal-body">									
									<div class="form-group">
										<label for="category">카테고리</label> 
										<select class="form-control" id="categorySelect" name="category">
											<option>선택하세요</option>
											
										</select>
									</div>
									<div class="form-group">
										<label for="title">제목</label> <input type="text"
											class="form-control" id="title" name="title">
									</div>
									<div class="row">
										<div class="col-sm-12">
											<div class="form-group">
												<label for="sttdate">시작일시</label> <input type="date"
													class="form-control" id="sttdate" name="sttdate">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<div class="form-group">
												<label for="enddate">종료일시</label> <input type="date"
													class="form-control" id="enddate" name="enddate">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label for="description">설명</label>
										<textarea class="form-control" rows="5" id="description"
											name="description"></textarea>
									</div>
								</div>
								<div class="modal-footer">
									<input type="submit" class="btn btn-default"
										 id="registerBtn" value="바보">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			
		</div>
		<div class="col-sm-7">
			<div id="calendar"></div>			
			
		</div>
		<div class="col-sm-3">
		<c:import url="${url}"/>
				
		</div>
	</div>






</body>
