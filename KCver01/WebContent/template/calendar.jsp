<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mystyle.css?ver10"/>
<link href='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/lib/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/lib/jquery.min.js'></script>
<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.min.js'></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#registerBtn").click(function () {
	         if ($("#newtitle").val().length > 8 || $("#newtitle").val().length == 0) {
	            alert('제목은 8글자 이내로 작성해주세요'); 
	            $("#newtitle").val("");      
	            return false;
	         }
	         var start = $("#sttdateVal").val();
	         var end = $("#enddateVal").val();
	         if (!moment(start).isSame(end) && !moment(start).isBefore(end)) {
	            alert("끝나는 날짜를 다시 지정하여 주세요"); 
	            return false;
	         } 
	      });
	})
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var todoJson=${requestScope.todo_list}; 
		var events= new Array();
		var todoEvents2 = new Array();
		for (var i=0 ; i<todoJson.length ; i++){
			event = new Object();
			event.title = todoJson[i].title;
			event.start = new Date(todoJson[i].startDate);
			var endDate = new Date(todoJson[i].endDate);
			event.end = endDate+1;
			event.todoNo=todoJson[i].todoNo;
			event.url="${pageContext.request.contextPath}/dispatcher?command=readDetail&todoNo="+todoJson[i].todoNo+"&userId=${sessionScope.dto.id}";
			
			 if (todoJson[i].category.categoryNo==1){
				event.backgroundColor='#FF0040';
				event.borderColor='#FF0040';
				
			}else if (todoJson[i].category.categoryNo==2){
				event.backgroundColor='#04B45F';
				event.borderColor='#04B45F';
			}else if (todoJson[i].category.categoryNo==3){
				event.backgroundColor='#FF8000';
				event.borderColor='#FF8000';
			}  
			events.push(event);
		}
		$('#calendar').fullCalendar({
			  header: {
				left: 'prev,next today',
				center: 'title'
			}, displayEventTime: false
		});
		$('#calendar').fullCalendar('addEventSource',events);
		
		$.ajax({
			type:"post",
			dataType:"json",
			url:"${pageContext.request.contextPath}/dispatcher",
			data:$("#categoryForm").serialize(),
			success:function(data){
				for (var i=0 ; i<data.length ; i++){
					
					if (data[i].category.categoryNo=="1"){
						$("#categoryNo1").html(data[i].category.categoryName+" "+data[i].count);
					}else if(data[i].category.categoryNo=="2"){
						$("#categoryNo2").html(data[i].category.categoryName+" "+data[i].count);		
					}else if(data[i].category.categoryNo=="3"){
						$("#categoryNo3").html(data[i].category.categoryName+" "+data[i].count);
					}
				}			
			}
		});
		$("#getCategoryBtn").click(function() {
			$("#categorySelect").html("<option>선택하세요</option>");
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
	});
</script>
</head>
<body>

<div class="container-fluid">
	<div class="col-sm-2 leftSide">
   		<form action="${pageContext.request.contextPath}/index.jsp">
			<input type="submit" class="btn btn-default btn-lg" value="홈으로">
		</form><br><hr><br>
		<h2>${sessionScope.dto.name }님</h2>
		<h2> 환영합니다.</h2><br>
		<form id="categoryForm">
			<input type="hidden" name="command" value="getCategoryCount">
			<input type="hidden" name="userId" value="${sessionScope.dto.id}">
			<a href="${pageContext.request.contextPath}/dispatcher?command=readCountDetail&categoryNo=1">
				<span class="label countCategory1" id="categoryNo1"></span>
			</a><br>
			<a href="${pageContext.request.contextPath}/dispatcher?command=readCountDetail&categoryNo=2">
				<span class="label countCategory2" id="categoryNo2"></span>
			</a><br>
			<a href="${pageContext.request.contextPath}/dispatcher?command=readCountDetail&categoryNo=3">
				<span class="label countCategory3" id="categoryNo3"></span>
			</a><br>
		</form>
		<form id="getCategory" method="post">
			<input type="hidden" name="command" value="getCategory">
			<button id="getCategoryBtn"  
					type="button" 
					class="btn btn-default btn-lg" 
					data-toggle="modal"
					data-target="#myModal">
					일정추가
			</button>						
		</form>	
		<form action="${pageContext.request.contextPath}/dispatcher" onsubmit="return checkLogout()">
			<input type="hidden" name="command" value="logout">
			<input type="submit" class="btn btn-default btn-lg" value="로그아웃">
		</form>
   	</div>
   	<div class="col-sm-7">
   		<div id="calendar"></div>
   	</div>
    	<div class="col-sm-3 rightSide">
    		<c:import url="${url}"/>
    	</div>
</div>

	<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<form id="registerForm" 
				action="${pageContext.request.contextPath}/dispatcher" 
				method="post" 
				onsubmit="return checkRegister()">
			<input type="hidden" name="command" value="createSchedule">
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
						<label for="title">제목</label> 
						<input type="text"class="form-control" id="newtitle" name="title">
					</div>
                   		<div class="form-group">
                       		<label for="sttdate">시작일시</label>
                       		<input type="date" class="form-control" id="sttdateVal">
                  	 	</div>
					<div class="form-group">
						<label for="enddate">종료일시</label>
						<input type="date" class="form-control" id="enddateVal">
					</div>
					<div class="form-group">
						<label>설명</label>
						<textarea class="form-control" rows="5" id="newDescription" name="description">
						</textarea>
					</div>
				</div>
				<div class="modal-footer">
					<input type="submit" class="btn btn-default"	id="registerBtn" value="등록">
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</form>
	</div>
</div>


</body>
<script type="text/javascript">
	function checkLogout(){
		var flag = confirm("로그아웃 하시겠습니까?");
		return flag;
	};
	function checkRegister(){
		var flag = confirm("일정을 등록하시겠습니까?");
		return flag;
	};
</script>

</html>