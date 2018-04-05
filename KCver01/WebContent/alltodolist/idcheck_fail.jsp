<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mystyle.css?ver11"/>
<title>Insert title here</title>
<script type="text/javascript">
	var of = opener.document.registerForm;
	of.id.value = "";
	of.flag.value = "";
	function closeWindow() {
		of.id.focus();
		self.close();
	}
</script>
</head>
<body bgcolor="white" class="calendar-body" onunload="closeWindow()">
	<%=request.getParameter("id")%> 는 이미 <span style="color: red;">사용중인 아이디</span>입니다.
	<br>
	<br>
	<input type="button" class="btn btn-default" onclick="closeWindow()" value="확인">
	</body>
</html>