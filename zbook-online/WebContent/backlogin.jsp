<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>

<html>
<head>
	<base href="<%=basePath%>">
	<title>登录界面</title>
	<link href="<%=basePath%>/static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
	<style type="text/css">
		body{
			background-color: #e1e1e1;
		}
	</style>
</head>
<body>
<div class="container" >
<br><br>
	<p class="text-center">
		<h1>管理员登录</h1>
	</p>
</div>

<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<p class="text-center">
			<label>${message }</label>
				<form class="form-horizontal" action="admin/login.do" method="post">
					<div class="form-group">
						<label>用户名：</label>
						<input type="text" name="id" class="form-control" value="${id}">
					</div>
					<div class="form-group">
						<label>密码：</label>
						<input type="password" name="password" class="form-control">
					</div>
					<div class="form-group">			
						<button class="btn btn-primary btn-lg" type="submit">登录</button>
						&nbsp;&nbsp;&nbsp;
					</div>
				</form>
			</p>
		</div>
	</div>
</div>
</body>
</html>