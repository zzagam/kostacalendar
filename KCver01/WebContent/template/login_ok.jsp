<%@page import="org.kostacalendar.model.KCUserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 성공</title>

<script type="text/javascript">
	function checkLogout(){
		var flag = confirm("로그아웃 하시겠습니까?");
		
		if (flag == false){
			return flag;
		}
		
		return flag;
	}

</script>
</head>
<body>
<div class="w3-sidebar w3-bar-block w3-light-grey w3-card"
				style="width: 160px;">
<a href="${pageContext.request.contextPath}/index.jsp"><input type="button" value="홈으로"></a>
<form action="${pageContext.request.contextPath}/dispatcher" onsubmit="return checkLogout()">
<input type="hidden" name="command" value="logout">
<input type="submit" value="로그아웃">
</form>

${sessionScope.dto.name }님 환영합니다.
</div>
</body>

</html>