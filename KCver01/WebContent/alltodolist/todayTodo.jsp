<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${requestScope.todayList != null}">
		<h2>오늘의 할일 목록</h2><hr>
		<c:forEach items="${requestScope.todayList}" var="todo">
			<div class="update-form">
			    제목
			     <div class="form-control">
			     	${todo.title}
			      </div><br>
			    분류
			     <div class="form-control">
			     	${todo.category.categoryName}
			      </div><br>
			 	시작일시
			     <div class="form-control">
			     	${todo.startDate}
			      </div><br>
				종료일시
			     <div class="form-control">
			     	${todo.endDate}
				</div><br>
				내용
				<div class="form-control">
			     	${todo.content}
				</div><br>
			</div>	
			<hr><hr>
		</c:forEach>
			
	</c:when>
	
	<c:otherwise>
		오늘 할일이 없음
	</c:otherwise>
</c:choose>


