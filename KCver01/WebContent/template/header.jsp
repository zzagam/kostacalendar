<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE>
<html>
<head>
	<title>KCScheduler</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mystyle.css?ver11"/>
	<link href='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.min.css' rel='stylesheet' />
	<link href='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
	<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/lib/moment.min.js'></script>
	<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/lib/jquery.min.js'></script>
	<script src='${pageContext.request.contextPath}/css/fullcalendar-3.9.0/fullcalendar.min.js'></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
	<script type="text/javascript">
	
		function checkLogout(){
			var flag = confirm("로그아웃 하시겠습니까??????");
			if (flag){
				location.href="${pageContext.request.contextPath}/dispatcher?command=logout";
			
			}
		};
	</script>
</head>
<body class="calendar-body">
	<nav id="myNavbar"
		class="navbar navbar-default navbar-inverse navbar-fixed-top"
		role="navigation">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#navbarCollapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<h3 style="color: white;cursor: pointer;" onclick="goHomeBtn()">MyScheduler</h3>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<ul class="nav navbar-nav navbar-right">
			      <li onclick="checkLogout()"><a style="cursor: pointer;"><span class="glyphicon glyphicon-log-out" ></span> Logout</a></li>
			    </ul>
			    
			</div>
		</div>
	</nav>   
	

	
	
				
			
