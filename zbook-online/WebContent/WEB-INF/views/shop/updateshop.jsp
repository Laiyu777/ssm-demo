<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>店铺开设</title>
	<link href="<%= basePath %>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%= basePath %>static/js/jquery.min.js"></script>
	<script src="<%= basePath %>static/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container" style="height: 150px;background-color: #d7d7d7">
	
		<h1 style="margin-top: 60px;margin-left: 20px;">开设店铺</h1>
	</div>
		
	<br><br><jsp:include page="../template/navleft.jsp"></jsp:include>
<div class="container" style="height:350px">
	<div class="row">
		<div class="col-md-5 col-md-offset-3">
			<form class="form-horizontal" action="updateshop.do" method="post">
			  <div class="form-group">
			    <label  class="col-sm-3 control-label">店铺名称：</label>
			    <div class="col-sm-9">
			      <input value="${shop.name}" name="name" required="required" type="text" class="form-control" >
			    </div>
			  </div>
			   <div class="form-group">
			    <label  class="col-sm-3 control-label">店铺描述:</label>
			    <div class="col-sm-9">
			      <textarea  name="description" required="required" class="form-control" rows="5" >
			      	${shop.description}
			      </textarea>
			    </div>
			  </div>
			 
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="submit" class="btn btn-info btn-lg">确认修改</button>
			      &nbsp;&nbsp;&nbsp;
			      <a href="index.do">返回首页</a>
			    </div>
			  </div>
		</form>
		</div>
	</div>
</div>

		<%@include file="../template/bottom.jsp" %>
	</body>
</html>