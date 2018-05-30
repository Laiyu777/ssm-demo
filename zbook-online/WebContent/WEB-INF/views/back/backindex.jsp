<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath", basePath);
%>
<!DOCTYPE html">
<html>
<head>
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理主页</title>
</head>
<body>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-10 col-md-offset-1" >
		<div class="jumbotron">
			<h2>网上书店管理员后台管理</h2>
		</div>
		<!--第一行-->
			<div class="row" >
				<ul class="nav nav-tabs">
				<li ><a href="backindex.do">首页</a></li>
				  <li ><a href="user.do">用户管理</a></li>
				  <li ><a href="shop.do">店铺管理</a></li>
				  <li ><a href="order.do">用户订单管理</a></li>
				  <li ><a href="book.do">图书管理</a></li>
				</ul>
			</div>
		<!--第二行-->
			<div class="row" style="border: gray" >
			<br>
				<h2>点击上方导航开始管理</h2>
				<div class="col-md-9 col-md-offset-2">
					<h3>截止:${time},网站的基本数据如下</h3>当前时间是:<div id="time"></div>
					<h4>注册用户:<font color="red">${usercount}</font></h4>
					<h4>店铺数量:<font color="red">${shopcount}</font></h4>
					<h4>总共订单数:<font color="red">${ordercount}</font></h4>
					<h4>总共图书数量:<font color="red">${bookcount}</font></h4>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 核心内容结束 -->
	<!-- 底部 --><br><br>
	<div class="container" style="background-color: #d7d7d7;">
 		<div class="row">
 			<div class="col-md-12"><br>
 				<p class="text-center">© 2016-2017 网上书店 — All Rights Reserved. 蜀ICP备15000533号 友情链接 关于本站</p><br>
 			</div>
 		</div>
 	</div>
	<!-- 底部 -->
<script type="text/javascript">
	$(function(){
		getNowTime();
	});

	function getNowTime(){
		var date=new Date();
		var month=date.getMonth()+1;
		var day = date.getDate();
		var hour = date.getHours();
		var min=date.getMinutes();
		var second = date.getSeconds();
		var str = ""+month+"月"+day+"日"+hour+":"+min+":"+second
		$("#time").empty();
		$("#time").append(str);
		this.setTimeout("getNowTime()",1000);
	}
</script>
</body>
</html>