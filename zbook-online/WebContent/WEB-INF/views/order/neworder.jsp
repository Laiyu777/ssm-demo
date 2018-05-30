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
<title>订单界面</title>
</head>
<body>
<jsp:include page="../template/top.jsp"></jsp:include>
<jsp:include page="../template/navleft.jsp"></jsp:include>


	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h2>订单界面</h2>
		</div>
		<!--第一行-->
		<form action="orderandpay.do" method="post">
		<div class="row" >
			
			<div class="col-md-8 col-md-offset-1" >
			
			<div class="row" style="border-bottom: gray;">
				<h3>订单信息<small>用户:${user.name}&nbsp;店铺名：${shop.name }</small></h3>
				<table class="table">
					<thead></thead>	
					<tbody>
						<tr>
							<td>图书名称</td>
							<td>图书价格</td>
							<td>购买数量</td>
						</tr>
						
						<tr>
							<td>${book.name }</td>
							<td>
								<c:choose>
									<c:when test="${book.ifkill==1 }">
									${book.price2}
									</c:when>
									<c:otherwise>
										${book.price }
									</c:otherwise>
								</c:choose>
							</td>
							<c:if test="${count==null}">
								<% session.setAttribute("count", 1); %>
							</c:if>
							<td>${count}</td>
						</tr>
						
					</tbody>
					<h3>总价：<input name="amount" value="${book.ifkill==1?book.price2*count:book.price*count}" readonly="readonly"></h3>
				</table>
			</div>
			
			<div class="row">
	
			<h3>请选择收货地址</h3>
			<table class="table">
				<thead></thead>
				<tbody>
				<c:forEach items="${adlist }" var="ad" varStatus="index">
					<tr><td>
						<input type="radio" name="addressid" value="${ad.id }">${index.count}:</td><td>${ad.realname}</td>&nbsp;<td>${ad.addressdetail}</td>&nbsp;<td>${ad.phone}
					</td></tr></c:forEach>
				</tbody>
			</table></div></div>
			
		</div>
		<% 
			List list =(List)session.getAttribute("adlist");
			if(list.size()==0||null==list){%>
			<h3>您还没有收货地址哦，请先添加在进行购买</h3>
			<a class="btn" href="address.do">点击进行添加</a>	
          <%}%>
		<!--第二行-->
			<div class="row" >
			<div class="col-md-5 col-md-offset-3">
				<button class="btn btn-primary btn-lg" type="submit">生成订单,去付款</button>
				<a href="bookdetail.do?id=${book.id }" class="btn btn-primary btn-lg">取消</a>
			</div>
			</div></form>
		<!--第三行-->
			<div class="row" ></div>
		</div>
	</div>
</div>

<br><br>
<%@include file="../template/bottom.jsp" %>
</body>
</html>