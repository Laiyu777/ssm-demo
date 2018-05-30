<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
			<div class="row" style="border-bottom: solid;">
				<div class="col-md-6 col-md-offset-2">
					<h3>订单条目</h3>
					<table class="table table-hover">
						<tr>
							<th>图书编号</th>
							<th>图书名称</th>
							<th>图书数量</th>
							<th>图书价格</th>
							<th>合计</th>
						</tr>
						<c:forEach items="${orderitems}" var="book">
							<tr>
								<td>${book.book.id }</td>
								<td>${book.book.name }</td>
								<td>${book.count }</td>
								<td>${book.book.price }</td>
								<td>${book.book.price*book.count }</td>
							</tr>
						</c:forEach>
					</table>
					<h3>总价：${order.amount}</h3>
					<h3>收货信息</h3>
						<table class="table table-hover  table-bordered">
							<tr>
								<th>收货人姓名</th>
								<th>收货人电话</th>
								<th>收货人地址</th>
							</tr>
							<tr>
								<td>${address.realname}</td>
								<td>${address.phone}</td>
								<td>${address.addressdetail}</td>
							</tr>
						</table>
				</div>
			</div>
		<!--第三行-->
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
</body>
</html>