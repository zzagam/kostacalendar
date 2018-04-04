<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script>
  var jb = jQuery.noConflict();
</script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	
	jb(document).ready(function() {
		jb("#category").val("${requestScope.tdListDTO.category.categoryNo}").prop("selected", true);
		jb("#datepicker1").datepicker({
			dateFormat: "yy-mm-dd",
			numberOfMonths: 1,
			
			onSelect: function(selected) {
				jb("#datepicker2").datepicker("option","minDate", selected)
			}
			});
		
		jb("#datepicker2").datepicker({
			numberOfMonths: 1,
			dateFormat: "yy-mm-dd",
			onSelect: function(selected) {
				jb("#datepicker1").datepicker("option","maxDate", selected)
			}
			});
		
		
	})
	function cancel() {
		if(confirm("수정을 취소하시겠습니까?")){
			location.href="${pageContext.request.contextPath}/dispatcher?command=readCalendar&userId=${sessionScope.dto.id}";
		}
	}


</script>


<div class="update-form">
    <form action="dispatcher" method="post">
    <input type="hidden" name="command" value="updateTodo">
    <input type="hidden" name= "todoNo" value="${requestScope.todoNo}">
        <h2 class="text-center">Update</h2>   
        
        <div class="form-group">
        	<select class="form-control" id="category_no" name="category_no" >
				<option value="1">공부</option>
				<option value="2">업무</option>
				<option value="3">약속</option>
			</select>
		</div>
		<div class="form-group">
            <input type="text" class="form-control" name="title" value="${requestScope.tdListDTO.title}" required="required">
        </div>
        <div class="form-group">
            <input type="text" id="datepicker1" name="start_date" readonly="readonly" class="form-control" required="required" placeholder="시작일" value="${requestScope.tdListDTO.startDate}">
        </div>   
        <div class="form-group">
            <input type="text" id="datepicker2" name="end_date" readonly="readonly"  class="form-control" required="required" placeholder="종료일" value="${requestScope.tdListDTO.endDate}">
        </div>
        <div class="form-group">
        <textarea class="form-control" rows="15" name="contents" required="required">${requestScope.tdListDTO.content}</textarea>
        </div>  
        <div class="form-group">
            <input type="submit" class="btn btn-primary btn-size" value="수정" >&emsp;
            <input type="button" class="btn btn-primary btn-size" value="취소" onclick="cancel()">
        </div>
        
        
    </form>


</div>

