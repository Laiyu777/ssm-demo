<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
<base href="<%=basePath%>">
	<title>网上书店</title>
	<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
	<style>	
		.carousel{
			height: 400px;
			margin-bottom: 30px;
		}
		.carousel .item{
			height: 400px;
		}
		.carousel .item img{
			width: 100%;
		}
	</style>
	
</head>
<body>
<%=basePath%><a href="<%=basePath%>backlogin.jsp">后台管理登录</a>

<!--aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-->


 

<!--aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-->
：<jsp:include page="WEB-INF/views/template/top.jsp" flush="true" /> 

		<!--第二个容器第2行-->
		<div class="container">
		<div class="row">
			<!--第二个容器第1行第1列（只有一列）-->
			<div class="col-md-12"> 
				<ul class="nav nav-tabs " style="font-size: x-large;">
				  <li><a href="allbook.do">所有图书</a></li>
				  <li class="dropdown">
				 	 <a class="dropdown-toggle" data-toggle="dropdown" href="#">个人中心<span class="caret"></span></a>
				 	 	<ul class="dropdown-menu">
				 	 	<li><a href="mycart.do">查看购物车</a></li>
					       <li class="divider"></li>
					      <li><a href="updateuser.do">修改个人信息</a></li>
					       <li class="divider"></li>
					      <li><a href="addmoneyview.do">账户充值</a></li>
					       <li class="divider"></li>
					      <li><a href="ordercenter.do">查看购买订单</a></li>
					       <li class="divider"></li>
					      <li><a href="ordercenterseller.do">查看店铺订单</a></li>
					      <li class="divider"></li>
					    </ul>
				  </li>
				  <li><a href="openshopView.do">快速开店/店铺管理</a></li>
				  <li ><a href="showkillbook.do">秒杀商品信息</a></li>
				  <li style="float: right;margin-right: 100px;"><a href="mycart.do" class="btn btn-primary"><span class="glyphicon glyphicon-shopping-cart">&nbsp;</span>查看我的购物车</a>
				</ul>
			</div>
		
		</div>
		<div class="row">
		<!--第二个容器第2行第1列-->
			<div class="col-md-12">
				<!--轮播图片-->
				<div id="myCarousel" class="carousel slide">
    			<!-- 轮播（Carousel）指标 -->
				    <ol class="carousel-indicators">
				        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				        <li data-target="#myCarousel" data-slide-to="1"></li>
				        <li data-target="#myCarousel" data-slide-to="2"></li>
				    </ol>   
				    <!-- 轮播（Carousel）项目 -->
				    <div class="carousel-inner">
				        <div class="item active">
				            <img src="<%= basePath%>static/images/roll1.jpg" alt="First slide">
				        </div>
				        <div class="item">
				            <img src="<%= basePath%>static/images/roll2.jpg" alt="Second slide">
				        </div>
				        <div class="item">
				            <img src="<%= basePath%>static/images/roll3.jpg" alt="Third slide">
				        </div>
				    </div>
					<!-- 轮播（Carousel）导航 -->
					<a class="carousel-control left" style="padding-top: 170px;" href="#myCarousel" 
						data-slide="prev">&lsaquo;
					</a>
					<a class="carousel-control right" style="padding-top: 170px;" href="#myCarousel" 
						data-slide="next">&rsaquo;
					</a>
				</div>
			</div>
		</div>

 	</div>

<!--第三个容器-->
 	<div class="container">
 	<!--第三个容器第一行-->
 		<div class="row">
 			<div class="col-md-4 col-md-offset-1" style="background-color:#e1e1e1; ">
 				<h2><span class="glyphicon glyphicon-time"></span>最新书目</h2>
 			</div>
 		</div>

 		<!--第三个容器第二行-->
 		<div class="row">	<br>		
 			<div class="col-md-8 col-md-offset-2">
		 		<div class="row">
		 		<!--  -->
		 		<c:forEach items="${indexbooks}" var="book" begin="0" end="5">
		 		   <div class="col-md-4" style="height: 400px">
				 	<div class="thumbnail">
				      <img src="<%= basePath%>static/images/bookimg/${book.id}.jpg" >
				      <div class="caption">
				        <h3><a href="bookdetail.do?id=${book.id}">${book.name}</a>
				        <c:if test="${book.ifkill==1}"><small>（秒杀中）</small></c:if>
				        </h3>
				       
				        <p><a href="buybookfromlist.do?id=${book.id}" class="btn btn-primary" role="button">购买</a> 
				        <a href="addcart.do?id=${book.id}" class="btn btn-default" role="button">加入购物车</a></p>
				      </div>
				    </div>
				   </div> 
				   </c:forEach>
				   <!--  -->
 				</div>
 			</div>
 			
 			
 		</div>
 	</div>
 	
 	<div class="container">
 		<div class="row">
 			<div class="col-md-9 col-md-offset-1"  style="background-color:#e1e1e1; ">
 				<h2><span class="glyphicon glyphicon-signal"></span>图书销量排行榜</h2>
 			</div>
 		</div>
 		
 		<div class="row">
 			<div class="col-md-9 col-md-offset-1" >
 				<c:forEach items="${rankbook}" var="book" begin="0" end="2">
 					<div class="col-md-4" style="height: 450px">
 						<div class="thumbnail">
				      <img src="<%= basePath%>static/images/bookimg/${book.id}.jpg" >
				      <div class="caption">
				        <h3><a href="bookdetail.do?id=${book.id}">${book.name}</a>
				        <c:if test="${book.ifkill==1}"><small>（秒杀中）</small></c:if>
				        <small>销售量: ${book.salecount }本</small>
				        </h3>
				       
				        <p><a href="buybookfromlist.do?id=${book.id}" class="btn btn-primary" role="button">购买</a> 
				        <a href="addcart.do?id=${book.id}" class="btn btn-default" role="button">加入购物车</a></p>
				      </div>
				    </div>
 					</div>
 				</c:forEach>
 			</div>
 		</div>
 		
 	
 	</div>
 	
 	<div class="container">
 	<!--第三个容器第一行-->
 		<div class="row">
 			<div class="col-md-9 col-md-offset-1" style="background-color:#e1e1e1; ">
 				<h2><span class="glyphicon glyphicon-heart"></span>为你推荐<span><small><c:if test="${user!=null}">根据经常输入的关键字
 					<%-- <c:forEach items="${userKeys}" var="userkey" begin="0" end="3">
 						${userkey.user_key},
 					</c:forEach> --%>
 					和你浏览过的书目进行推荐
 				</c:if></small></span></h2>
 			</div>
 		</div>
 		
 		<div class="row">
 			<div class="col-md-8 col-md-offset-2">
 			<c:if test="${user==null}"><h2>你还没有登录哦！<a href="login.do" class="btn">登录</a></h2></c:if>
 				<div class="row">
 				<c:if test="${please==true}">
 					<h2>请多多使用我们系统吧！</h2>
 				</c:if>
 				<c:if test="${user!=null}">
 				<c:forEach items="${booksForUser}" var="book" begin="0" end="2">
 				<div class="col-md-4">
 					<div class="thumbnail">
				      <img src="<%= basePath%>static/images/bookimg/${book.id}.jpg" >
				      <div class="caption">
				        <h3><a href="bookdetail.do?id=${book.id}">${book.name}</a>
				        <c:if test="${book.ifkill==1}"><small>（秒杀中）</small></c:if>
				        </h3>
				       
				        <p><a href="buybookfromlist.do?id=${book.id}" class="btn btn-primary" role="button">购买</a> 
				        <a href="addcart.do?id=${book.id}" class="btn btn-default" role="button">加入购物车</a></p>
				      </div>
				    </div>
 					</div>
 				</c:forEach>
 				</c:if>
 				</div>
 			</div>
 		</div>
 	</div>

<!--第四个容器（底部）-->
 	<%@include file="WEB-INF/views/template/bottom.jsp"%>
</body>
</html>