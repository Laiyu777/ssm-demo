<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
<title>个人中心</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<!--第一行-->
			<div class="row" style="border: solid;border-color: gray;">
			
				<div class="jumbotron">
					<h2>用户信息</h2>
				</div>
				
				<table class="table table-hover" >
					<thead>
						<tr><td></td></tr>
					</thead>
					<tbody align="center" style="font-size: 20px">
						<tr>
							<td>
								<label>账号：</label>
							</td>
							<td align="left">
								<label>${user.id}</label>
							</td>
						</tr>
						<tr>
							<td>
								<label>昵称：</label>
							</td>
							<td align="left">
								<label>${user.name}</label>
							</td>
						</tr>
						<tr>
							<td>
								<label>年龄：</label>
							</td>
							<td align="left">
								<label>${user.age}</label>
							</td>
						</tr>
						<tr>
							<td>
								<label>性别：</label>
							</td>
							<td align="left">
								<label>${user.sex}</label>
							</td>
						</tr>
						<tr>
							<td>
								<label>邮箱：</label>
							</td>
							<td align="left">
								<label>${user.email}</label>
							</td>
						</tr>
						<tr>
							<td>
								<label>账户余额：</label>
							</td>
							<td align="left">
								<label>${user.blance}<a href="addmoneyview.do">(马上充值)</a></label>
							</td>
						</tr>
						<tr>
							<td>
								<label>积分：</label>
							</td>
							<td align="left">
								<label>${user.integral}</label>
							</td>
						</tr>
						<tr>
							<td>
								<label>注册时间：</label>
							</td>
							<td align="left">
								<label>${user.date}</label>
							</td>
						</tr>
						<tr>
							<td align="right">
								<a href="updateuser.do" class="btn btn-primary btn-lg">修改个人信息</a>
							</td>
							<td align="left" >
								<a href="address.do" class="btn btn-primary btn-lg">管理收货地址</a>
								<a href="index.do">返回首页</a>
							</td>
						</tr>
					</tbody>
				</table>
				
			</div>
		</div>
	</div>
</div><br>
<!-- 核心内容结束 -->
	
	<%@include file="../template/bottom.jsp" %>
</body>
</html>