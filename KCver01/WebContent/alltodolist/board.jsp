<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mystyle.css?ver11"/>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<style>
.thead1{
	width: 70px;
}
.thead2{
	width: 50px;
}
.thead3{

}
.thead4{
	width: 130px;
}
.thead5{
	width: 130px;
}
</style>

<body class="calendar-body">
<h1 style="text-align: center;">전체 일정 목록 게시판</h1>
<table class="table table-bordered" style="text-align: center;">
	<thead style="text-align: center;">
	<tr>
		<th class="thead1">일정번호</th>
		<th class="thead2">종류</th>
		<th class="thead3">제목</th>
		<th class="thead4">	시작일시</th>
		<th class="thead5">	종료일시</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${requestScope.pagingList.list}" var="list">
		<tr>
			<td>${list.todoNo}</td>
			<td>${list.category.categoryName}</td>
			<td>${list.title}</td>
			<td>${list.startDate}</td>
			<td>${list.endDate}</td>
		</tr>
	
	
	</c:forEach>
	</tbody>
</table>
<div style="text-align:center;">
	<c:forEach begin="${requestScope.pagingList.pb.startPageOfPageGroup}" 
				end="${requestScope.pagingList.pb.endPageOfPageGroup}" var="page">
		<ul class="pagination">
			<c:choose>
				<c:when test="${requestScope.pagingList.pb.nowPage!=page}">
					<li><a href="${pageContext.request.contextPath}/dispatcher?command=getBoard&nowPage=${page}">${page}</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="active"><a href="#">${page}</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</c:forEach>
	<ul class="pager">
		<c:if test="${requestScope.pagingList.pb.previousPageGroup==true}">
			<li><a href="${pageContext.request.contextPath}/dispatcher?command=getBoard&nowPage=${requestScope.pagingList.pb.startPageOfPageGroup-1}">Previous</a>
			</li>
		</c:if>
		<c:if test="${requestScope.pagingList.pb.nextPageGroup==true}">
			<li><a href="${pageContext.request.contextPath}/dispatcher?command=getBoard&nowPage=${requestScope.pagingList.pb.endPageOfPageGroup+1}">Next</a>
			</li>
		</c:if>
	</ul>
</div>	


</body>
</html>