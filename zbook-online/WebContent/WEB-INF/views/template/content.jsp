<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath", basePath);
%>   
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
</head>
<body>
  <jsp:include page="../template/top.jsp"></jsp:include>
  <jsp:include page="../template/navleft.jsp"></jsp:include>
  
  <!--店铺管理界面-->

<div class="container">
	<div class="row">
		<div class="col-md-9 col-md-offset-3" >
		<!--第一行-->
			<div class="row" style="border-bottom: solid;">
				<div class="col-md-9 col-md-offset-3">
					
					<div class="row">
						------内容
					</div>
					<div class="row">
						------内容
					</div>
					<div class="row">
						------内容
					</div>
					
					
					
				</div>
			</div>
		
	
			
			
		
			
		
			
			
			
			
			
			</div>
			
		</div>
	</div>

  
</body>
<%@include file="bottom.jsp" %>
</html>