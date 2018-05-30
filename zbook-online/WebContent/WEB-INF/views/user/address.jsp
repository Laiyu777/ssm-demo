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
			<h2>管理收货地址</h2>
			<p><a class="btn btn-primary btn-lg"  onclick="show()">添加收货地址</a></p>
			<p><div class="row"><div class="col-md-8">
				<form class="form-horizontal" style="display: none" id="addfm" action="addAddress.do" method="post">
				  <div class="form-group">
				    <label class="col-sm-4 control-label">收货人姓名：</label>
				    <div class="col-sm-8">
				      <input name="realname" required="required" required="required" type="text" class="form-control" >
				   	 </div>
				 	 </div>
				
				  <div class="form-group">
					 <label class="col-sm-4 control-label">收货人具体地址：</label>
					  <div class="col-sm-8">
				     	<input name="addressdetail" required="required" type="text" class="form-control">
				    </div>
				  </div>
				  
				  <div class="form-group">
					 <label class="col-sm-4 control-label">收货人电话：</label>
					  <div class="col-sm-8">
				     	<input name="phone" required="required" type="number" class="form-control">
				    </div>
				  </div>
				  
				  <div class="form-group">
    					<div class="col-sm-offset-2 col-sm-10">
     					 <button type="submit" class="btn btn-primary">添加</button>
     					 <a onclick="hide()" class="btn btn-primary">取消</a>
    				</div>
  				</div>
				</form>
			</div></div></p>
		</div>
		<!--第一行-->
			<div class="row"  >
				<c:forEach items="${adlist}" var="ad" varStatus="index">
					<div class="col-md-8 col-md-offset-1" style="border-bottom: solid;">
						<table class="table" id="showtable">
							<thead>
								<tr>
									<h3>地址信息${index.count}<small><a href="updateaddress.do?id=${ad.id}" class="btn btn-primary">修改</a>&nbsp;&nbsp;&nbsp;
									<a href="deleteAddress.do?id=${ad.id}" class="btn btn-primary">删除</a></small></h3>
									
								</tr></thead>
							<tbody>
								<tr>
									<td>收货人姓名：</td>
									<td>${ad.realname}</td>
								</tr>
								<tr>
									<td>收货人具体地址：</td>
									<td>${ad.addressdetail}</td>
								</tr>
								<tr>
									<td>收货人电话：</td>
									<td>${ad.phone}</td>
								</tr>
								
							</tbody>
						</table>
					</div>
					
					
					
				</c:forEach>
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
	
	<script type="text/javascript">
		function show(){
			document.getElementById('addfm').style.display='';
		}
		function hide(){
			document.getElementById('addfm').style.display='none';
		}
	</script>
</body>
</html>