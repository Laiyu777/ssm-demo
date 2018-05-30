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
<title>修改用户信息</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<!--第一行-->
			<div class="row" >
				<form id="info" action="updateuser.do" method="post">
				<table class="table table-border">
					<thead >
						<h3>修改用户信息</h3>
					</thead>
					<tbody>
						<tr>
							<td>账号：</td>
							<td><label>${user.id}</label></td>
						<tr>
						<tr>
							<td>昵称：</td>
							<td><input required="required" type="text" name="name" value="${user.name}"></td>
						<tr>
						<tr>
							<td>年龄：</td>
							<td><input  required="required" type="number" name="age" value="${user.age}"></td>
						<tr>
						<tr>
							<td>性别：</td>
							<td><label>${user.sex}</label></td>
						<tr>
						<tr>
							<td>邮箱：</td>
							<td><input required="required"  type="email" name="email" value="${user.email}"></td>
						<tr>
					</tbody>
				</table>
					<input id="submitinfo" type="submit" class="btn btn-primary btn-lg" value="确认修改">
					<a  class="btn btn-primary btn-lg" onclick="show()">修改密码</a>
					<a href="index.do">返回首页</a>
				</form>
			
				<form id="pas" style="display:none;" action="updatepassword.do" method="post">
						
					<table class="table table-border">
					<thead>
						<h3>修改用户密码<small style="color: red">：${message}</small></h3>
					</thead>
					<tbody>
						<tr>
							<td>账号：</td>
							<td><label>${user.id}</label></td>
						<tr>
						<tr>
							<td>原密码：</td>
							<td><input required="required"  type="password" name="oldPassword"></td>
						<tr>
						<tr>
							<td>新密码：</td>
							<td><input required="required"  type="password" name="newPassword1"></td>
						<tr>
						<tr>
							<td>新密码确认：</td>
							<td><input required="required"  type="password" name="newPassword2"></td>
						<tr>
					</tbody>
				</table>
				<button class="btn btn-primary btn-lg" type="submit">确认修改</button>
				<button class="btn btn-primary btn-lg" onclick="hide()">返回上一级</button>
				
				</form>
				
			</div></div>
	</div>
</div>
<!-- 核心内容结束 -->
	
	<%@include file="../template/bottom.jsp" %>
	
	
	<script type="text/javascript">
		function show(){
			document.getElementById('pas').style.display='';
			document.getElementById("info").style.display="none";
		}
		function hide(){
			document.getElementById('pas').style.display='none';
			document.getElementById("info").style.display="";
		}
		
		 $(function(){
			var flag;
			/* $("input[name='age']").change(function(){
				var count=$("input[name='age']").val();
				count = Number(count);
				if(count<=0){
					flag=false;
					alert("年龄必须大于0！");
				}else{
					flag=true;
				}
			}); */
			$("#submitinfo").click(function(){
				var count=$("input[name='age']").val();
				count = Number(count);
				if(count<=0){
					alert("年龄必须大于0！");
					return false;
				}
			});
		}); 
	</script>
</body>
</html>