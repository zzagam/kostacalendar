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
	   })
})




function checkForm(){
   var f=document.registerForm;   
   if(f.password.value!=f.repeatPassword.value){
      alert("패스워드와 패스워드 확인이 일치하지 않습니다");
      return false;
   }
   if(f.flag.value!=f.id.value){
      alert("인증받은 아이디가 아닙니다\n아이디 중복확인을 하세요");
      return false;                                                 
   }   
}

   function checkId() {
      var str = document.registerForm.id.value;
      if (str == "") {
         alert("아이디를 입력하세요!");
      } else {
         window.open("dispatcher?command=idcheck&id=" + str, "popup",
               "width=200,height=200,top=150,left=400");
      }
   }
</script>
</head>
<body class="login-body">

<div class="image-main">
<img src="${pageContext.request.contextPath}/img/mainImg2.png" width="10%">
</div>

<div class="login-form">
<form method="post" name="registerForm" id="idForm" action="dispatcher" onsubmit="return checkForm()">
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