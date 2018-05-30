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
<title>编辑用户</title>
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
						<form action="updateUser.do" method="post">
						<h3>用户详细信息</h3>
							<table class="table">
								<tr>
									<td><label>用户id</label></td>
									<td><input type="text" name="id" readonly="readonly" value="${user.id}"></td>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>用户昵称</label></td>
									<td><input value="${user.name }" name="name" required="required"></td>
								<tr>
								<tr>
									<td><label>用户密码</label></td>
									<td><input value="${user.password }" readonly="readonly" name="password" required="required"></td>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>用户年龄</label></td>
									<td><input value="${user.age }" name="age" type="number" required="required"></td>
								<tr>
								<tr>
									<td><label>用户邮箱</label></td>
									<td><input value="${user.email }" name="email" required="required" type="email"></td>
								<tr>
								<tr>
									<td><label>用户性别</label></td>
									<td><input value="${user.sex }" name="sex" required="required"></td>
								<tr>
								<tr>
									<td><label>用户积分</label></td>
									<td><input value="${user.integral }" type="number" name="integral" required="required"></td>
								<tr>
								<tr>
									<td><label>用户余额</label></td>
									<td><input value="${user.blance }" type="number" name="blance" required="required"></td>
								<tr>
								<tr>
									<td><label>用户店铺id</label></td>
									<c:if test="${user.shop_id!=null}">
										<td><input readonly="readonly" value="${user.shop_id}"  name="shop_id" required="required"></td>
									</c:if>
									<c:if test="${user.shop_id==null}">
										<td><input readonly="readonly" value="未开设"   required="required"></td>
									</c:if>
									<td align="left"><font color="red">(不可修改)</font></td>
								<tr>
								<tr>
									<td><label>用户注册时间</label></td>
									<td><input value="${user.date }" readonly="readonly" name="date" required="required"></td>
									<td align="left"><font color="red">(不可修改)</font></td>											
								<tr>
									<td><button type="submit" clas="btn btn-primary btn-lg">保存修改</button></td>
									<td><a href="user.do"  clas="btn btn-primary btn-lg">返回首页</a></td></td>
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