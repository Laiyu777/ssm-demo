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
<title>编辑店铺</title>
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
			<div class="row">
				<div class="col-md-6 col-md-offset-3">
					<div class="row">
						<form action="updateShop.do" method="post">
						<h3>店铺详细信息</h3>
							<table class="table">
								<tr>
									<td><label>店铺编号</label></td>
									<td><input type="text" name="id" readonly="readonly" value="${shop.id}"></td>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>用户编号</label></td>
									<td><input value="${shop.user_id }" readonly="readonly" required="required"></td>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>用户名称</label></td>
									<td><input value="${username }" readonly="readonly"  required="required"></td>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>店铺名称</label></td>
									<td><input value="${shop.name }" name="name" required="required"></td>
								<tr>
								<tr>
									<td><label>店铺描述</label></td>
									<td><input value="${shop.description }" name="description" required="required"></td>
								<tr>
						
								<tr>
									<td><label>店铺积分</label></td>
									<td><input value="${shop.integral }" readonly="readonly" required="required" ></td>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>店铺注册时间</label></td>
									<td><input value="${shop.date }" readonly="readonly"  required="required"></td>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								
									<td><button type="submit" class="btn btn-primary btn-lg">保存修改</button></td>
									<td><a href="user.do"  class="btn btn-primary btn-lg">返回首页</a></td></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			
			</div>
		<!--第三行-->
			<div class="row" style="border: solid;"></div>
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