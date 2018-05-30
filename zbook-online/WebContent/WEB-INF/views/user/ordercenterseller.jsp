<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.List" %>
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
<title>店铺订单管理中心</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h3>店铺订单管理中心</h3>
		</div>
		<!--第一行-->
			<div class="row" >
				<c:forEach items="${listOrderHelpSeller}" var="o" varStatus="index">
					<div class="col-md-4" style="border: groove ;height: 330px">	
					<h3>序号${index.count}&nbsp;&nbsp;订单编号:${o.order.id }</h3>
					<table>
					<tr><td align="center">图书名</td><td align="center">图书数量<td></tr>
					<c:forEach items="${o.listBookHelp}" var="bookhelp">
						<tr><td align="center">${bookhelp.book.name}</td><td align="center">${bookhelp.count }</td></tr>
					</c:forEach></table>
				<hr>
					收货人姓名：${o.address.realname}<br>
					收货人地址:${o.address.addressdetail}<br>
					收货人电话:${o.address.phone }	<br>
					订单状态:${o.order.state }
					<h4>总价:${o.total}</h4>
					<c:choose>
						<c:when test="${o.order.state=='已付款，等待发货'}">
							<a href="sendgoods.do?id=${o.order.id }" class="btn btn-primary">确认发货</a>
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
					</c:choose>	
				</div>	
				</c:forEach>
					<% 
					List list =(List)session.getAttribute("listOrderHelpSeller");
				if(list.size()==0){%>
					<h3>您还没有店铺订单哦</h3>	
				
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