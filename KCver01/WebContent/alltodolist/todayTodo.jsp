<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${requestScope.todayList==null}">
	오늘 할 일이 없습니다.
</c:if>



<c:forEach items="${requestScope.todayList}" var="todo">
 <div class="panel panel-danger">
    <div class="panel-heading">${todo.startDate}</div>
    <div class="panel-body">
    		<div class="panel panel-success">
    			<div class="panel-heading">분류</div>
    			<div class="panel-body">${todo.category.categoryName}</div>
    			<div class="panel-heading">제목</div>
    			<div class="panel-body">${todo.title}</div>
    			<div class="panel-heading">시작일</div>
    			<div class="panel-body">${todo.startDate}</div>
    			<div class="panel-heading">종료일</div>
    			<div class="panel-body">${todo.endDate}</div>
    			<div class="panel-heading">내용</div>
    			<div class="panel-body"><pre>${todo.content}</pre></div>
    		</div>
    </div>
</div>
	
<hr>
</c:forEach>
