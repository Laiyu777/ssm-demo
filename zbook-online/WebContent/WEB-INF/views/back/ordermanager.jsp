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
<title>订单管理界面</title>
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
			
			<h3>订单列表</h3>
			<div class="row">
			<div class="col-md-5">
			<form action="searchorder.do" method="post">
				请输入订单编号:<input name="key" placeholder="请输入订单编号" required="required">
					<button type="submit" class="btn btn-primary">搜索</button>
			</form>
			</div>
			<div class="col-md-7">
			<form action="searchorderbybookname.do" method="POST">
				请输入图书名称:<input name="key" required="required" placeholder="请输出图书名称">
				<button type="submit" class="btn btn-primary">搜索</button>
				<font color="red"><small>(查出包含图书的订单)</small></font>
			</form>
			</div>
			</div>
		<!--第二行-->
			<div class="row" style="border-bottom: solid;">
				<table class="table">
					<tr>
						<th>订单编号</th>
						<th>购买用户id</th>
						<th>销售用户id</th>
						<th>订单状态</th>
						<th>订单总额</th>
						<th>订单创建时间</th>
						<th colspan="2">操作</th>
					</tr>
					<c:forEach items="${page}" var="order">
						<tr>
							<td>${order.id}</td>
							<td>${order.buyerid}</td>
							<td>${order.sellerid}</td>
							<td>${order.state}</td>
							<td>${order.amount}</td>
							<td>${order.date}</td>
							<td><a class="btn btn-primary" href="backorderdetail.do?id=${order.id}">查看详情</a>
							<a class="btn btn-danger" href="deleteorder.do?id=${order.id}">删除</a></td>
							
						</tr>
					</c:forEach>
				</table>
				<label>总记录数：${pagetotal}，总共${pages}页，当前页数:${pageNum}</label>
				<div style="text-align: center">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				    <li>
				      <c:if test="${key!=null}">
				      <a href="order.do?pn=${pageNum-1}&key=${key}" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a></c:if>
				        <c:if test="${key==null}">
				      <a href="order.do?pn=${pageNum-1}" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a></c:if>
				    </li>
				    <c:forEach items="${pagenavigatepages}" var="num">
					  <c:if test="${key==null}">
					    <c:if test="${num==pageNum}">
					    	<li class="active"><a href="order.do?pn=${num}">${num}</a></li>
					    </c:if>
					    <c:if test="${num!=pageNum}">
					    	<li><a href="order.do?pn=${num}">${num}</a></li>
					    </c:if>
					  </c:if>
					   <c:if test="${key!=null}">
					    <c:if test="${num==pageNum}">
					    	<li class="active"><a href="order.do?pn=${num}&key=${key}">${num}</a></li>
					    </c:if>
					    <c:if test="${num!=pageNum}">
					    	<li><a href="order.do?pn=${num}&key=${key}">${num}</a></li>
					    </c:if>
					  </c:if>
				    </c:forEach>
				    
				    <li>
				    <c:if test="${key!=null}">
				      <a href="order.do?pn=${pageNum+1}&key=${key}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a></c:if>
				      <c:if test="${key==null}">
				      <a href="order.do?pn=${pageNum+1}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a></c:if>
				    </li>
				  </ul>
				</nav></div>
				
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
</body>
</html>