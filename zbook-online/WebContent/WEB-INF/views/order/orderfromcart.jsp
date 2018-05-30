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
<title>订单详情</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h3>订单详情</h3>
		</div>
		<!--第一行-->
			<div class="row" >
				<div class="col-md-8 col-md-offset-1">
					<h3>商品详细信息</h3>
					<table class="table">
						<tr>
							<td>序号</td>
							<td>图片名称</td>
							<td>图书数量</td>
							<td>图书价格</td>
						</tr>
						<c:forEach items="${bookHelpListOrder}" var="bh" varStatus="index">
							<tr>
							<td>${index.count }</td>
							<td>${bh.book.name}</td>
							<td>${bh.count}</td>
							<td>
								<c:choose>
									<c:when test="${bh.book.ifkill==1}">
										${bh.book.price2}
									</c:when>
									<c:otherwise>
										${bh.book.price}
									</c:otherwise>
								</c:choose>
							</td>
							<tr>
						</c:forEach>
						<tr>
							<td></td>
							<td></td>
							<td><h4>我的余额:${user.blance}</h4></td>
							<td><h4>总价:${amount}</h4>
								<c:if test="${user.blance<amount}">
									<small>余额不足</small>
								</c:if>
							</td>
						</tr>
					</table>
					<h3>收货地址信息</h3>
					<table class="table">
						<tr>
							<td>收货人姓名</td>
							<td>收货人地址</td>
							<td>收货人电话</td>
						</tr>
						<tr>
							<td>${address.realname }</td>
							<td>${address.addressdetail }</td>
							<td>${address.phone }</td>
						</tr>
					</table>
					
					<a href="payforcartorder.do" class="btn btn-primary btn-lg">确认订单,去付款</a>
					<a href="#" class="btn btn-lg">取消订单</a>
				</div>
			</div>
			
			
			
			
			
			
			
	
		</div>
	</div>
</div>
<!-- 核心内容结束 -->
	<!-- 底部 --><br><br>
	<%@include file="../template/bottom.jsp" %>
	<!-- 底部 -->
</body>
</html>