<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath", basePath);
%>   
<!DOCTYPE html >
<html>
<head>
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
<script  src="<%=basePath%>static/js/jquery.min.js"></script>
<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书详情</title>
</head>
<body>
<jsp:include page="../template/top.jsp"></jsp:include>
<jsp:include page="../template/navleft.jsp"></jsp:include>

<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<!--第一行-->
			<div class="row" style="border-bottom: solid;">
				<div class="col-md-5">
				 	<img width="300px" height="250px" alt="" src="<%= basePath %>static/images/bookimg/${book.id}.jpg">
				</div>
				
				<div class="col-md-6 col-md-offset-1">
				
				<form action="buy.do" method="post">
				<table class="table">
					<thead>
						<tr><td><h3>${book.name }<small>浏览量：${book.clickcount}</small></h3></td></tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<label style="font-size:15px"></label>
								<!--   <strong style="font-size:20px">${book.price }</strong> -->
								<c:choose>
									<c:when test="${book.ifkill==1}">
										<strong style="font-size:20px">现价：${book.price2 }</strong>
										<strong style="font-size:15px;color: gray">原价：<del>${book.price }</del></strong>
									</c:when>
									<c:otherwise>
										价格：<strong style="font-size:20px">${book.price }</strong>
									</c:otherwise>										
								</c:choose>
							<td>						
						</tr>
						<tr>
							<td>
								<label style="font-size:15px">购买数量:</label>
								<input name="count" type="number" value="1" id="input1">
								<br><span>（库存数量：${book.stock}）
									<c:if test="${book.stock le 0}"><strong style="color: red">缺货</strong></c:if>
								</span>
							<td>						
						</tr>
						<tr>
							<td>
								<button type="submit" class="btn btn-primary btn-lg">立即购买</button>
								<a class="btn btn-primary btn-lg" onclick="get()">加入购物车</a>
								<input type="hidden" value="${book.id }" id="id1">
							</td>
						</tr>
					</tbody>
					
				</table></form>
				
				<form id="myform" action="addcart.do" method="post" style="display: none;">
					<input type="text" name="id" id="id2">					
					<input type="number" name="count" id="input2">
					<input id="submit2" type="submit">
				</form>
				</div>
				
			</div>
		<!--第二行-->
			<div class="row" style="border-bottom: solid;">
				<h3>详细信息：</h3>
				<p>${book.description}</p>
			</div>
			<!-- 第三行 -->
			<div class="row" style="border-bottom: solid;">
				<h3>评价详情</h3>
				<c:forEach items="${listComment.list}" var="comment">
				<h4>用户昵称：${comment.user_id}</h4>
				<p>${comment.comment }</p>
				<hr>
				</c:forEach>
				总页数:${listComment.pages } ,总评价数目:${listComment.total}
				<a href="bookdetail.do?id=${book.id}&pn=${listComment.pageNum-1}">上一页</a>&nbsp;&nbsp;
				<a href="bookdetail.do?id=${book.id}&pn=${listComment.pageNum+1}">下一页</a>
			</div>
			
			<c:if test="${ifbuy==false or ifbuy==null}">
			<div class="row">
				<h2>您还没有购买或者登陆，不能进行评价哦！</h2>
			</div>
			</c:if>
			
			
			<c:if test="${ifbuy==true}">
			<div class="row" style="border-bottom: solid;">
			<h3>发表评价</h3>
				<form action="addcomment.do" method="POST">
					<textarea required="required" name="comment" rows="10" cols="50"></textarea>
					<button type="submit" class="btn btn-primary">提交评论</button><br>
				</form>
			</div>
			</c:if>
			
		</div>
	</div>
</div>
<br><br>
<%@include file="../template/bottom.jsp" %>
<script type="text/javascript">
	function get(){
		if(Number(document.getElementById("input1").value)<1){
			alert('不能输入比1小的数字！');
			return false;
		}
		document.getElementById("input2").value=document.getElementById("input1").value;
		document.getElementById("id2").value=document.getElementById("id1").value;
		document.getElementById("myform").submit();
	}
	

</script>
</body>
</html>