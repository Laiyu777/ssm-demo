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
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成为秒杀商品</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h3>成为秒杀商品</h3>
			<p>价格必须低于六折</p>
			<table class="table table-border">
						<tr>
							<td>图书名称</td>
							<td>图书价格</td>
							<td>图书库存</td>
						</tr>
						<tr>
							<td>${book.name}</td>
							<td>${book.price}</td>
							<td>${book.stock}</td>
						</tr>
					</table>
					<form action="beacomekill.do" method="post">
						<font size="5px">请输入秒杀价格:</font><input name="price" type="text"><font>小于等于${book.price*0.6}元</font><font color="red">${message}</font><br><br>
						<button type="submit" class="btn btn-primary btn-lg" id="button">成为秒杀商品！</button>
						<a href="openshopView.do" class="btn btn-lg">取消</a>
					</form>
		</div>
		<!--第一行-->
			<div class="row" style="border: solid;">
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
			$('#button').click(function(){
				var price = $("input[name='price']").val();
				price = Number(price);
				if(price<=0){
					alert("价格不能小于0！");
					return false;
				}
			});
		});
	</script>
</body>
</html>