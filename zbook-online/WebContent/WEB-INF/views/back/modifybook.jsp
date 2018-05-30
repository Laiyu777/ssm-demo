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
<title>编辑图书</title>
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
						<form action="updateBook.do" method="post">
						<h3>图书详细信息</h3>
							<table class="table">
								<tr>
									<td><label>图书编号</label></td>
									<td><input type="text" name="id" readonly="readonly" value="${book.id}"><font color="red">(不可修改)</font></td>
								<tr>
								
								
								<tr>
									<td><label>图书名称</label></td>
									<td><input value="${book.name }" name="name" required="required"></td>
								<tr>
								
						
								<tr>
									<td><label>图书库存</label></td>
									<td><input name="stock" value="${book.stock}" type="number" required="required" ></td>
								<tr>
								<tr>
									<td><label>图书价格</label></td>
									<td><input name="price" value="${book.price}" type="number" required="required"></td>
								<tr>
								<input type="hidden" name="ifkill" value="${book.price2==0?0:1 }">
								<input type="hidden" name="shop_id" value="${book.shop_id }">
								<tr>
									<td><label>图书秒杀价格</label></td>
									<td><input name="price2" value="${book.price2}" type="number"  required="required"></td>
								<tr>
								<tr>
									<td><label>图书发布时间</label></td>
									<td><input name="date" value="${book.date}" readonly="readonly"   required="required"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>图书描述</label></td>
									<td><textarea cols="50" rows="10" name="description" required="required">${book.description }</textarea></td>
								<tr>
								
									<td><button type="submit" class="btn btn-primary btn-lg">保存修改</button></td>
									<td><a href="book.do"  class="btn btn-primary btn-lg">返回上一页</a></td></td>
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