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
<!-- 针对用户从图书链接中获取图书购买付款的的按钮 -->
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>付款页面</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<form action="pay.do" method="post">
		<div class="col-md-8 col-md-offset-3" >
		<!--第一行-->
			<div class="row" >
			<div class="jumbotron">
				<h2>付款页面</h2>
			</div>
				<div class="col-md-8 col-md-offset-1">
					<h3>订单详情</h3>

<table class="table" >
	<thead>
		<tr>
			<th>图书名称</th>
			<th>图书数量</th>
			<th>图书总价</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>${book.name }</td>
			<td>${count}</td>
			<td>${amount}</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<h4>当前账户余额：${user.blance}</h4>
			</td>
			<td>
				<h4>总价：${amount}<small>
				<c:if test="${user.blance lt amount }">余额不足</c:if></small></h4>
			</td>
		</tr>
	</tbody>
</table>

<h3>收货详情</h3>

<table class="table">
	<thead>
		<tr>
			<th>收货人姓名</th>
			<th>收货人地址</th>
			<th>收货人电话</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>${address.realname }</td>
			<td>${address.addressdetail }</td>
			<td>${address.phone}</td>
		</tr>		
	</tbody>
</table>
<button class="btn btn-primary btn-lg" type="submit">确认信息无误,付款</button>
&nbsp;&nbsp;&nbsp;<a class="btn btn-primary btn-lg" href="">返回上一页</a>
				</div>
			</div>
		</div></form>
	</div>
</div>
<!-- 核心内容结束 -->
	<!-- 底部 --><br><br>
	<%@include file="../template/bottom.jsp" %>
	<!-- 底部 -->
</body>
</html>