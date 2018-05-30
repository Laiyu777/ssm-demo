<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@page import="java.util.*" %>
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
<title>购物车详情</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h3>我的购物车</h3>
		</div>
		<!--第一行-->
			<div class="row">
			<%
				List list = (List)session.getAttribute("cartBookHelpList");
				if(list.size()!=0){%>
		
				<form action="neworderfromcart.do" method="post">
				<div class="col-md-12">
					<h3>商品详情</h3>
					<table class="table">
						<tr>
							<td></td>
							<td></td>
							<td>图书名称</td>
							<td>图书价格</td>
							<td>当前图书库存</td>
							<td>图书数量</td>
							<td></td>
						</tr>
						<c:forEach items="${cartBookHelpList}" var="bookHelp" varStatus="index">
							<tr>
								<td><input name="book_id" checked="checked" type="checkbox" value="${bookHelp.book.id}"></td>
								<td>${index.count }</td>
								<td>${bookHelp.book.name}</td>
								<td>
									<c:choose>
										<c:when test="${bookHelp.book.ifkill==1}">
											${bookHelp.book.price2}<del>原价:${bookHelp.book.price}</del>
										</c:when>
										<c:otherwise>
											${bookHelp.book.price}
										</c:otherwise>
									</c:choose>
								</td>
								<td>${bookHelp.book.stock}</td>
								<td>
									<div class="count" style="float: left" >${bookHelp.count}</div>&nbsp;&nbsp;&nbsp;
									<a href="addcount.do?book_id=${bookHelp.book.id}"><span class="glyphicon glyphicon-plus"></span></a>
									<a id="reduce" class="reduce"  href="reducecount.do?book_id=${bookHelp.book.id}"><span  class="glyphicon glyphicon-minus"></span></a>
								</td>
								<td><a href="removecart.do?bookid=${bookHelp.book.id}&userid=${user.id}">移除</a></td>
							<tr>
						</c:forEach>
						<tr>
						<td></td>
						<td></td>
						<td></td>
						<td>订单总价：${cartTotal}</td>
						</tr>
						
					</table>
					<h3>请选择收货地址<small><a href="address.do">点击添加</a></small></h3>
						<table class="table">
						<tr>
						<td></td>
							<td></td>
							<td>收货人姓名</td>
							<td>收货人地址</td>
							<td>收货人电话</td>
						</tr>
						<c:forEach items="${adlist}" var="ad" varStatus="index">
							<tr>
								<td><input type="radio" value="${ad.id}" name="address_id"></td>
								<td>${index.count }</td>
								<td>${ad.realname}</td>
								<td>${ad.addressdetail}</td>
								<td>${ad.phone}</td>
							<tr>
						</c:forEach>
						<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						</tr>
						
					</table>
					<button class="btn btn-primary btn-lg" type="submit">生成订单,前去付款</button>
					<a class="btn btn-lg" href="allbook.do" class="btn"> 返回所有图书</a>
				</div></form>
					<% }%>
				<%
				List list2 = (List)session.getAttribute("cartBookHelpList");
				if(list.size()==0){%>
					<h3>您的购物车里还没有商品哦！</h3>
				
				<% }%>
			</div>
		</div>
	</div>
</div>
<!-- 核心内容结束 -->
	<!-- 底部 --><br><br>
	<%@include file="../template/bottom.jsp" %>
	<!-- 底部 -->
	<script type="text/javascript">
	$(function(){
		var as = $('.reduce');
		var counts = $('.count');
		var array = new Array();
		counts.each(function(i){
			array[i]=Number($(this).html());
		});
		//alert(array[2]);
		as.each(function(i){
			$(this).click(function(){
				if(array[i]<=1){
					alert("不能再减少了！");
					return false;
				}
			});
		});
		
	});
	
</script>
	
</body>
</html>