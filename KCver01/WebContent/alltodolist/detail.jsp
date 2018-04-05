<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
function update(){
	var submit_check=confirm("게시글을 수정하시겠습니까?");
	return submit_check;
	//if(confirm("게시글을 수정하시겠습니까?")){
		//${pageContext.request.contextPath}/
	//location.href="dispatcher?command=updateView&todoNo="+${requestScope.tdto.todoNo};
	
	//}
}
function deleteCategory(){
	if(confirm("게시글을 삭제하시겠습니까?")){
		//${pageContext.request.contextPath}/
	location.href="dispatcher?command=deleteSchedule&todoNo="+${requestScope.tdto.todoNo};
	}
}
</script>


<h2>일정 상세보기</h2><hr>

<div class="update-form">
    제목
     <div class="form-control">
     	${requestScope.tdto.title}
      </div><br>
    분류
     <div class="form-control">
     	${requestScope.tdto.category.categoryName}
      </div><br>
 	시작일시
     <div class="form-control">
     	${requestScope.tdto.startDate}
      </div><br>
	종료일시
     <div class="form-control">
     	${requestScope.tdto.endDate}
	</div><br>
	내용
	<div class="form-control">
     	${requestScope.tdto.content}
	</div><br>
</div>

<form action="dispatcher" method="post">
<input type="hidden" name="command" value="updateView">
<input type="hidden" name="todoNo" value="${requestScope.tdto.todoNo}">
<input type="submit" value="수정" class="btn btn-default" onclick="update()">
<input type="button" value="삭제" class="btn btn-default" onclick="deleteCategory()">
</form>

