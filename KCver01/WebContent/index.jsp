<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Simple Login Form with Blue Background</title>
<link rel="stylesheet" type="text/css" href="css/mystyle.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

</head>
<body class="login-body">
<c:choose>
<c:when test="${sessionScope.dto==null}">

<div class="image-main">
<img src="${pageContext.request.contextPath}/img/mainImg.png" width="10%">
</div>

<div class="logo-style">
<h1>Kosta Calendar!</h1>
</div>
<div class="login-form">
    <form action="${pageContext.request.contextPath}/dispatcher" method="post">
    <input type="hidden" name="command" value="login">
        <h2 class="text-center">Login</h2>   
        <div class="form-group has-error">
        	<input type="text" class="form-control" name="userId" placeholder="아이디" required="required">
        </div>
		<div class="form-group">
            <input type="password" class="form-control" name="userPassword" placeholder="비밀번호" required="required">
        </div>        
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-lg btn-block">Log in</button>
        </div>
    </form>
    <p class="text-center small">회원이 아니세요? 지금 당장 가입하세요! <a href="register.jsp">회원가입하기!</a></p>
</div>
</c:when>
<c:otherwise>
	<jsp:forward page="dispatcher?command=readCalendar&userId=${sessionScope.dto.id}"/>
</c:otherwise>

</c:choose>
</body>
</html>                         
