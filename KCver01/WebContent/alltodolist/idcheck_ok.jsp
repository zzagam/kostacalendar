<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mystyle.css?ver11"/>
<title>아이디중복확인</title>
<script type="text/javascript">
	var of=opener.document.registerForm;
	of.flag.value="<%=request.getParameter("id") %>";	
	function closeWindow(){			
		of.password.focus();			
		self.close();
	}
</script>
</head>
<body class="calendar-body" bgcolor="white" onunload="closeWindow()">
	<%=request.getParameter("id") %> 는 <span style="color: green;">중복되지 않는 아이디</span>입니다!
	
	<br>
	<br>
	<input type="button" class="btn btn-default" onclick="closeWindow()" value="확인">
	
</body>
</html>