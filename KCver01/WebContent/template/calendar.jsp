<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
	<div class="container-fluid">
		<div class="col-sm-2 leftSide" style="padding-top: 100px">
			<h2>${sessionScope.dto.name }님</h2>
			<h2> 환영합니다.</h2><br>
			<form id="categoryForm">
				<input type="hidden" name="command" value="getCategoryCount">
				<input type="hidden" name="userId" value="${sessionScope.dto.id}">
				<a href="${pageContext.request.contextPath}/dispatcher?command=readCountDetail&categoryNo=1">
					<span class="countCategory1" id="categoryNo1"></span>
				</a><br>
				<a href="${pageContext.request.contextPath}/dispatcher?command=readCountDetail&categoryNo=2">
					<span class="countCategory2" id="categoryNo2"></span>
				</a><br>
				<a href="${pageContext.request.contextPath}/dispatcher?command=readCountDetail&categoryNo=3">
					<span class="countCategory3" id="categoryNo3"></span>
				</a><br>
			</form>
			<form id="getCategory" method="post">
				<input type="hidden" name="command" value="getCategory">
				<button id="getCategoryBtn"  
						type="button" 
						class="btn btn-default" 
						data-toggle="modal"
						data-target="#myModal">
						일정추가
				</button>						
			</form>
					<!-- Modal -->
	   	</div>
   		<div class="col-sm-7">
   			<div id="calendar" style="padding-top: 100px"></div>
   		</div>
    	<div class="col-sm-3 rightSide" style="padding-top: 100px">
    		<c:import url="${url}"/>
    	</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<form id="registerForm" action="${pageContext.request.contextPath}/dispatcher" method="post" onsubmit="return checkRegister()">
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
								<div class="row">
									<div class="col-sm-6">
                                   		<div class="form-group">
                                       		<label for="sttdate">시작일시</label>
                                       		<input type="date" class="form-control" name="sttdate" id="sttdate">
                                  	 		</div>
                               		</div>
                             		 <div class="col-sm-6">
                                  		<div class="form-group">
                                      		<label for="stttime">&nbsp;</label>
                                      		<input type="time" class="form-control" name="stttime" id="stttime">
                                  		</div>
                              		</div>
								</div>
								<div class="row">
									<div class="col-sm-6">
                                   		<div class="form-group">
                                      	 	<label for="enddate">종료일시</label>
                                       		<input type="date" class="form-control" name="enddate" id="enddate">
                                   		</div>
                               		</div>
                               		<div class="col-sm-6">
                                   		<div class="form-group">
                                       		<label for="endtime">&nbsp;</label>
                                       		<input type="time" class="form-control" name="endtime" id="endtime">
                                   		</div>
                               		</div>
								</div>
								<div class="form-group">
									<label>설명</label>
									<textarea class="form-control" rows="5" id="newDescription" name="description"></textarea>
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
	function checkRegister(){
		var flag = confirm("일정을 등록하시겠습니까?");
		return flag;
	};
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#registerBtn").click(function () {
	         if ($("#newtitle").val().length > 8 || $("#newtitle").val().length == 0) {
	            alert('제목은 8글자 이내로 작성해주세요'); 
	            $("#newtitle").val("");      
	            return false;
	         }
	         /* var start = $("#sttdateVal").val();
	         var end = $("#enddateVal").val();
	         if (!moment(start).isSame(end) && !moment(start).isBefore(end)) {
	            alert("끝나는 날짜를 다시 지정하여 주세요"); 
	            return false;
	         } */
	         
	         var start = new Number($('#sttdate').val().replace(/\-/g, '') + $('#stttime').val().replace(/\:/g, ''));
				var end = new Number($('#enddate').val().replace(/\-/g, '') + $('#endtime').val().replace(/\:/g, ''));
				alert($("#sttdate").val()+" "+$("#stttime").val()+ " "+$("#enddate").val()+ " "+ $("#endtime").val());
				console.log($('#sttdate').val().replace(/\-/g, '') + $('#stttime').val().replace(/\:/g, ''));
				console.log($('#enddate').val().replace(/\-/g, '') + $('#endtime').val().replace(/\:/g, ''));
				if (start > end) {
					alert('끝나는 날짜를 다시 지정하여 주세요'); 
					$('#sttdate').focus;
				}
	      });
	})
</script>
<script type="text/javascript">

function goHomeBtn(){
	location.href="${pageContext.request.contextPath}/index.jsp";
};

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
				event.backgroundColor='#FA5882';
				event.borderColor='#FA5882';
				
			}else if (todoJson[i].category.categoryNo==2){
				event.backgroundColor='#81DAF5';
				event.borderColor='#81DAF5';
			}else if (todoJson[i].category.categoryNo==3){
				event.backgroundColor='#c5f0a2';
				event.borderColor='#c5f0a2';
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
						$("#categoryNo1").html(data[0].category.categoryName+" "+data[0].count);		
					}else if (data[i].category.categoryNo=="2"){
						$("#categoryNo2").html(data[1].category.categoryName+" "+data[1].count);		
					}else if (data[i].category.categoryNo=="3"){
						$("#categoryNo3").html(data[2].category.categoryName+" "+data[2].count);		
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
</html>