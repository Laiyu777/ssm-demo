<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath", basePath);
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html">
<html>
<head>
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理收货地址</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<div class="jumbotron">
			<h2>修改收货地址</h2>		
		</div>
		<!--第一行-->
			<div class="row"  >
				
					<div class="col-md-8 col-md-offset-1" style="border-bottom: solid;">
						
						<form action="updateaddress.do" method="post">
						<table class="table" >
					
							<thead>
								<tr>
									<h3>地址信息</h3>							
								</tr>
								</thead>
							<tbody>
								<tr>
									<td>收货人姓名：</td>
									<td><input required="required" name="realname" type="text" value="${ad.realname}"></td>
								</tr>
								<tr>
									<td>收货人具体地址：</td>
									<td><input required="required" name="addressdetail" type="text" value="${ad.addressdetail}"></td>
								</tr>
								<tr>
									<td>收货人电话：</td>
									<td><input required="required" name="phone" type="number" value="${ad.phone}"></td>
								</tr>
								<tr>
									<td>
										<button type="submit" class="btn btn-primary">保存</button>
									</td>
								</tr>
								
							</tbody>
						</table>
						
						</form>
					</div>
					
					
					
				
			</div>
			<!-- 第二行 -->
			<div class="row">
			<div class="col-md-5">
				
			</div>
			</div>
		</div>
	</div>
</div>
<!-- 核心内容结束 -->
	
	<%@include file="../template/bottom.jsp" %>
	

</body>
</html>