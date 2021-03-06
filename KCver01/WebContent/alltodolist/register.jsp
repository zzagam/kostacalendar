<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mystyle.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

<script type="text/javascript">
$(document).ready(function() {
	   $("#id").keyup(function() {
		   var id = $("#id").val();
		   if(id.length<4||id.length>10){
	            $("#checkResult").html(
	                  "아이디는 4자이상 10자이하만 가능!").css("color","pink");
	         }else{
		   
			    $.ajax({
					type : "post",
					dataType : "json",
					url : "/KCver01/dispatcher",
					data : "command=ajaxId&userId="+id,
					success : function(data) {
						$("#checkResult").html("");
						if (data.flag=="fail"){
							$("#checkResult").html("사용할 수 없는 아이디입니다.");
							$("#checkResult").css("color", "red");
						}		
					}											
				});
	         }
	   })
})




function checkForm(){
    var f=document.registerForm;
    var str_space = /\s/;  // 공백체크
    if(str_space.exec(f.id.value)) { //공백 체크
        alert("해당 항목에는 공백을 사용할 수 없습니다.\n\n공백은 자동적으로 제거 됩니다.");
        f.id.focus();
        f.id.value = f.id.value.replace(' ',''); // 공백제거
        return false;
    }if(f.password.value!=f.repeatPassword.value){
      alert("패스워드와 패스워드 확인이 일치하지 않습니다");
      return false;
   }if(f.flag.value!=f.id.value){
      alert("인증받은 아이디가 아닙니다\n아이디 중복확인을 하세요");
      return false;                                                 
   }if(f.id.value.length<4 || f.id.value.length>10){
	   alert("아이디는 4자 이상 10자 이하여야 합니다.");
	   return false;
   }
   
   alert("회원가입을 축하합니다\n로그인해주세요");
   return true;
   

   
  	
}

   function checkId() {
      var str = document.registerForm.id.value;
      if (str == "") {
         alert("아이디를 입력하세요!");
      } else {
         window.open("${pageContext.request.contextPath}/dispatcher?command=idcheck&id=" + str, "popup",
               "width=270,height=200,top=150,left=400");
      }
   }
</script>
</head>
<body class="login-body">

<div class="image-main">
<a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/img/mainImg2.png" width="10%"></a>
</div>

<div class="login-form">
<form method="post" name="registerForm" id="idForm" action="${pageContext.request.contextPath}/dispatcher" onsubmit="return checkForm()">
   <input type="hidden" name="command" value="createUser">
   <h2 class="text-center">회원가입</h2>   
        <div class="form-group has-error">
           <input type="text" class="form-control" name="id" id="id" placeholder="아이디" required="required"><br>
           <span id="checkResult"></span>
        </div>   
   <div class="form-group">
           <input type="button" class="btn btn-primary btn-lg btn-block" value="중복확인" onclick="checkId()">
        </div>
   <div class="form-group">
            <input type="password" class="form-control" name="password" placeholder="비밀번호" required="required">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" name="repeatPassword" placeholder="비밀번호 확인" required="required">   
        </div>
   <div class="form-group">
         <input type="text" class="form-control" name="name" placeholder="이름" required="required">   
         <input type="hidden" name="flag"  value="">
    </div>
   <div class="form-group">
            <button type="submit" class="btn btn-primary btn-lg btn-block">Sign Up</button>
    </div>
</form>
</div>
</body>
</html>