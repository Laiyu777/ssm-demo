<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<link href="<%= basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%= basePath%>static/js/jquery.min.js"></script>
	<script src="<%= basePath%>static/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container" style="height: 150px;background-color: #d7d7d7">
		<h1 style="margin-top: 60px;">网上书店注册</h1>
	</div>
		
	<br><br>
<div class="container">
	<div class="row">
		<div class="col-md-5 col-md-offset-3">
		<p class="text-center"><label>${message}</label></p>
			<form class="form-horizontal" action="register.do" method="post">
			  <div class="form-group">
			    <label  class="col-sm-3 control-label">账号：</label>
			    <div class="col-sm-9">
			      <input value="${user.id}" name="id" type="text" class="form-control"  placeholder="请输入您的账号">
			    </div>
			  </div>
			   <div class="form-group">
			    <label  class="col-sm-3 control-label">昵称：</label>
			    <div class="col-sm-9">
			      <input value="${user.name}" name="name" type="text" class="form-control" placeholder="请输入您的昵称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-3 control-label">密码：</label>
			    <div class="col-sm-9">
			      <input name="password" type="password" class="form-control" placeholder="请输入您的密码">
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-3 control-label" style="float: left;">密码确认：</label>
			    <div class="col-sm-9">
			      <input name="password2" type="password" class="form-control" placeholder="请再次输入密码">
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-3 control-label">年龄：</label>
			    <div class="col-sm-9">
			      <input value="${user.age}" name="age" type="number" title="必须输入数字" class="form-control" placeholder="请输入您的年龄">
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-3 control-label">邮箱：</label>
			    <div class="col-sm-9">
			      <input value="${user.email}"  name="email" type="email" title="必须输入正确的邮箱格式" class="form-control" placeholder="请输入您的邮箱">
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-3 control-label">性别：</label>
			    <div class="col-sm-9">
			      <label class="radio-inline">
				  <input checked="checked" name="sex" type="radio" value="男"> 男
				</label>
				<label class="radio-inline">
				  <input name="sex" type="radio" value="女"> 女
				</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="submit" class="btn btn-info btn-lg">注册</button>
			      &nbsp;&nbsp;&nbsp;
			      <a href="index.do">返回首页</a>
			    </div>
			  </div>
		</form>
		</div>
	</div>
</div>

 <script type="text/javascript">
        $(function(){
            $('input[name=age]').keypress(function(e) {
              if (!String.fromCharCode(e.keyCode).match(/[0-9]/)) {
                return false;
              }
            });
        });
    </script>
		
	</body>
</html>