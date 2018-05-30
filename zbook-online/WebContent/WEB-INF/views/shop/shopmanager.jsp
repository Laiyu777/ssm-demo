<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
  <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath", basePath);
%>   
    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>店铺管理中心</title>
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
				<div class="col-md-8 col-md-offset-2">
					<table class="table table-hover">
						<thead><h2>店铺信息</h2></thead>
						<tbody>
							<tr>
								<td>名称</td>
								<td>${shop.name}</td>
							</tr>
							<tr>
								<td>店铺描述</td>
								<td>${shop.description}</td>
							</tr>
							<tr>
								<td>开设时间</td>
								<td>${shop.date}</td>
							</tr>
							<tr>
								<td>完成订单量</td>
								<td>${shop.integral/10}</td>
							</tr>
							<tr>
								<td>店铺销量</td>
								<td>${shop.salecount}本</td>
								
							</tr>
							<tr><td>店铺发布图书数量</td>
								<td>${list.total }本</td></tr>
							<tr>
								<td >
								<a href="updateshop.do" class="btn btn-primary btn-lg">修改店铺信息</a>
								</td>
								<td >
								<a href="echart.do" class="btn btn-primary btn-lg">查看店铺销售情况</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 第1.5行 为了加上按钮 -->
			
			<br><div class="row">
			<div class="col-md-2">
			<a href="addbook.do" class="btn btn-primary btn-lg">发布图书</a>
			</div>
			<div class="col-md-2">
				<a href="showkillbookinshop.do" class="btn btn-primary btn-lg">秒杀图书管理</a>
			</div>
			<div class="col-md-6 col-md-offset-2">
				<form action="searchbookinshop.do" method="post">
					<label>搜索图书：</label><input required="required" name="key" type="text" placeholder="请输入图书名称">
					<button class="btn btnprimary">搜索</button>
				</form><br><br>
			</div>
			<br><br>
		<!--第二行-->
			<div class="row" style="border-bottom: solid;">
			<!--第二行第一列-->
			
			<c:forEach items="${list.list}" var="book">
			<div class="col-md-4" style="border:solid;border-width:0.5px;border-color:gray;height: 400px">
				 <br>
			    <img src="<%= basePath%>static/images/bookimg/${book.id}.jpg"  height="200px" width="260px">
			 	<h3>
			 	<a href="bookdetail.do?id=${book.id}">${book.name}<c:if test="${book.ifkill==1}"><br><small>（秒杀中）</small></c:if></a><c:if test="${book.bookdown==1}"><label>已经下架</label></c:if><br><br>
				<a href="updatebook.do?id=${book.id}" class="btn btn-primary">编辑</a>
				<c:if test="${book.bookdown==0}">
					<a href="bookdown.do?id=${book.id}" class="btn btn-primary">下架</a>
				</c:if>
				<c:if test="${book.bookdown==1}">
					<a href="bookup.do?id=${book.id}" class="btn btn-primary">上架</a>
				</c:if>
				
				<c:if test="${book.ifkill==0}"><a href="addkillpriceview.do?id=${book.id}" class="btn btn-danger">成为秒杀商品</a></c:if>
				<c:if test="${book.ifkill==1}"><a href="cancelkill.do?id=${book.id}" class="btn btn-danger">取消秒杀</a></c:if>
			 	</h3>
			</div>	
			</c:forEach></div>	
			<div class="row">
			<c:if test="${shopbook=='all'}">
			<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="openshopView.do?pn=${list.prePage}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}"> 	
					    	<li><a href="openshopView.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index == list.pageNum}"> 	
					    	<li class="active"><a href="openshopView.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="openshopView.do?pn=${list.nextPage}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
				</c:if>
			
			<c:if test="${shopbook=='kill'}">
			<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="showkillbookinshop.do?pn=${list.prePage}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}"> 	
					    	<li><a href="showkillbookinshop.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index == list.pageNum}"> 	
					    	<li class="active"><a href="showkillbookinshop.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="showkillbookinshop.do?pn=${list.nextPage}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
				</c:if>
			
			<c:if test="${shopbook=='search'}">
			<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="searchbookinshop.do?pn=${list.prePage}&key=${key}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}"> 	
					    	<li><a href="searchbookinshop.do?pn=${index}&key=${key}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index == list.pageNum}"> 	
					    	<li class="active"><a href="searchbookinshop.do?pn=${index}&key=${key}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="searchbookinshop.do?pn=${list.nextPage}&key=${key}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
				</c:if>
			</div>
			</div>
			
		</div>
	</div>
</div><br>
<%@include file="../template/bottom.jsp" %>
  
</body>
</html>