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
<!-- 针对用户订单管理中还没付款的订单 选择付款 -->
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
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h3>付款界面</h3>
		</div>
		<!--第一行-->
			<div class="row" >
				<h3>订单总价：${amount}</h3>
				<h3>账户余额：${blance}</h3>
				<a href="okpay.do" class="btn btn-primary btn-lg">确认无误，付款</a>
			</div>
		</div>
	</div>
</div>
<!-- 核心内容结束 --><br><br>
	<!-- 底部 -->
	<%@include file="../template/bottom.jsp" %>
	<!-- 底部 -->
</body>
</html>
