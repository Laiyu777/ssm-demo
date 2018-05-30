<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@page import="java.util.List" %>  
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
<title>订单管理中心</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h3>购买订单管理中心</h3>
		</div>
		<!--第一行-->
			<div class="row" >
				<!-- IndexController 77行放入 -->
				<c:forEach items="${listOrderHelp}" var="o" varStatus="index">
					<div class="col-md-4" style="border: groove ;height: 330px">	
					<h3>序号${index.count}&nbsp;&nbsp;订单编号:${o.order.id }</h3>
					<table>
					<tr><td align="center">图书名</td><td align="center">图书数量<td></tr>
					<c:forEach items="${o.listBookHelp}" var="bookhelp">
						<tr>
						<td align="center"><a href="bookdetail.do?id=${bookhelp.book.id}">${bookhelp.book.name}</a></td>
						<td align="center">${bookhelp.count }</td>
						</tr>
					</c:forEach></table>
				<hr>
					收货人姓名：${o.address.realname}<br>
					收货人地址:${o.address.addressdetail}<br>
					收货人电话:${o.address.phone }	<br>
					订单状态:${o.order.state }
					<h4>总价:${o.total}</h4>
					<c:choose>
						<c:when test="${o.order.state=='等待付款'}">
							<a href="gotoPay.do?id=${o.order.id }" class="btn btn-primary">去付款</a>
							<a href="cancelorder.do?id=${o.order.id }" class="btn btn-primary">取消订单</a>
						</c:when>
						<c:when test="${o.order.state=='已经发货'}">
							<a href="confirmget.do?id=${o.order.id }" class="btn btn-primary">确认收货</a>
						</c:when>
						<c:when test="${o.order.state=='订单完成'}">
							<b>您可以点击订单中的图书链接去图书详情里评价</b>
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
					</c:choose>
				</div>	
				</c:forEach>
				<% 
					List list =(List)session.getAttribute("listOrderHelp");
				if(list.size()==0){%>
					<h3>您还没有购买订单哦</h3>	
				
				<%}%>
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