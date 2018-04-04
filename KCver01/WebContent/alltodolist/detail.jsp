<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
function update(){
	if(confirm("게시글을 수정하시겠습니까?")){
		//${pageContext.request.contextPath}/
	location.href="dispatcher?command=updateView&todoNo="+${requestScope.tdto.todoNo};
	}
}
function deleteCategory(){
	if(confirm("게시글을 삭제하시겠습니까?")){
		//${pageContext.request.contextPath}/
	location.href="dispatcher?command=deleteSchedule&todoNo="+${requestScope.tdto.todoNo};
	}
}
</script>


<h3>Detail View</h3><hr>

<div class="panel panel-success">
    <div class="panel-heading">분류</div>
    <div class="panel-body">${requestScope.tdto.category.categoryName}</div>
  </div>
  <div class="panel panel-success">
    <div class="panel-heading">제목</div>
    <div class="panel-body">${requestScope.tdto.title}</div>
  </div>
  <div class="panel panel-success">
    <div class="panel-heading">시작일</div>
    <div class="panel-body">${requestScope.tdto.startDate}</div>
  </div>
  <div class="panel panel-success">
    <div class="panel-heading">종료일</div>
    <div class="panel-body">${requestScope.tdto.endDate}</div>
  </div>
  <div class="panel panel-success">
    <div class="panel-heading">내용</div>
    <div class="panel-body"><pre>${requestScope.tdto.content}</pre></div>
  </div>


<form>
<input type="button" value="수정" onclick="update()">
<input type="button" value="삭제" onclick="deleteCategory()">
</form>

