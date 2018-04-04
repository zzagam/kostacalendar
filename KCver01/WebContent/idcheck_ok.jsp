<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디중복확인</title>
<script type="text/javascript">
	var of=opener.document.registerForm;
	of.flag.value="<%=request.getParameter("id")%>";	
	function closeWindow(){			
		of.password.focus();			
		self.close();
	}
</script>
</head>
<body bgcolor="yellow" onunload="closeWindow()">
	<%=request.getParameter("id")%>는 사용가능!
	<br>
	<br>
	<input type="button" onclick="closeWindow()" value="확인">
	
</body>
</html>