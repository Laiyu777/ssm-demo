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
<title>图书列表</title>
<link href="<%=basePath%>static/css/bootstrap.min.css" rel="stylesheet">
	<script  src="<%=basePath%>static/js/jquery.min.js"></script>
	<script src="<%=basePath%>static/js/bootstrap.min.js"></script>
</head>
<body>
  <jsp:include page="../template/top.jsp"></jsp:include>
  <jsp:include page="../template/navleft.jsp"></jsp:include>
  
  
 <div style="top:250px;left:1100px;position: absolute;width: 200px;text-align: left;">
	<h4>销售排行榜</h4>
	<table class="table table-hover">
		 <c:forEach items="${rightsale}" varStatus="index" var="book" begin="0" end="4">
			<tr><td><a href="bookdetail.do?&id=${book.id}">${index.count}.${book.name}</a></td><tr>
		</c:forEach>
	</table>
	<h4>点击量排行榜</h4>
	<table class="table table-hover">
		 <c:forEach items="${rightclick}" varStatus="index" var="book" begin="0" end="4">
			<tr><td><a href="bookdetail.do?&id=${book.id}">${index.count}.${book.name}</a></td></tr>
		</c:forEach>
	</table>
</div>



<div class="container">
	<div class="row">
		<div class="col-md-9 col-md-offset-2" >
		<!--第一行-->
			<div class="row" style="border-bottom: solid;">
			<ul class="nav nav-tabs">
			  <li ><a href="allbook.do">所有商品</a></li>
			  <li ><a href="showcommonbook.do">普通商品</a></li>
			  <li ><a href="showkillbook.do">秒杀商品</a></li>
			</ul><br>
			<a href="getbookbyclick.do" class="btn" style="border-color: #5bc0de">按点击量查看</a>&nbsp;
			<a href="getbookbysalecount.do" class="btn" style="border-color: #5bc0de">按最销售量查看</a>&nbsp;
			<select onchange="javascript:window.location=this.value;" style="width:160px;height:30px">
				<option>按类别查看</option>
				<option value="allbook.do">全部</option>
				<option value="allbook.do?kind=计算机技术">计算机技术</option>
				<option value="allbook.do?kind=小说">小说</option>
				<option value="allbook.do?kind=童书">童书</option>
				<option value="allbook.do?kind=教育">教育</option>
				<option value="allbook.do?kind=生活">生活</option>
				<option value="allbook.do?kind=其他">其他</option>
			</select>
			<br>
			<c:if test="${ifsearchbook}"><label>${result }</label></c:if><br>
				<div class="col-md-10 ">
				<div class="row">
					<c:forEach items="${list.list}" var="book">
						
						<div class="col-md-4" style="border:solid;border-width:0.5px;border-color:gray;height: 380px" >
							<br> 
						    <img src="<%= basePath%>static/images/bookimg/${book.id}.jpg" height="200px" width="200px">
						 	<h3>
						 	<a href="bookdetail.do?id=${book.id}">${book.name}</a><small>(销售量:${book.salecount}本)</small><c:if test="${book.ifkill==1}"><small><font color="red">(秒杀中）</font></small></c:if><br><br>
							<a href="buybookfromlist.do?id=${book.id}" class="btn btn-primary">购买</a>&nbsp;&nbsp;&nbsp;
							<a href="addcart.do?id=${book.id}" class="btn btn-primary">加入购物车</a>&nbsp;&nbsp;&nbsp;
							
						 	</h3>
						</div>
						
						
						
						
					</c:forEach>
				</div>
				<div class="row">
					<div class="col-md-offset-4">
					<c:if test="${showwhat=='all'}">
						<c:if test="${kind==null}">
							<nav aria-label="Page navigation">
							  <ul class="pagination">
							    <li>
							      <a href="allbook.do?pn=${list.prePage}" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							      </a>
							    </li>
							    <c:forEach items="${list.navigatepageNums }" var="index">
							    	<c:if test="${index ne list.pageNum}"> 
							    	<li><a href="allbook.do?pn=${index}">${index}</a></li>
							    	</c:if>
							    	<c:if test="${index == list.pageNum}"> 
							    	<li class="active"><a href="allbook.do?pn=${index}">${index}</a></li>
							    	</c:if>
							    </c:forEach>
							    <li>
							      <a href="allbook.do?pn=${list.nextPage}" aria-label="Next">
							        <span aria-hidden="true">&raquo;</span>
							      </a>
							    </li>
							  </ul>
							</nav>
						</c:if>
						
						<c:if test="${kind != null }">
							<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="allbook.do?pn=${list.prePage}&kind=${kind}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}"> 
					    	<li><a href="allbook.do?pn=${index}&kind=${kind}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index == list.pageNum}"> 
					    	<li class="active"><a href="allbook.do?pn=${index}&kind=${kind}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="allbook.do?pn=${list.nextPage}&kind=${kind}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
						</c:if>
					</c:if>
					
					<c:if test="${showwhat=='common'}">
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="showcommonbook.do?pn=${list.prePage}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}"> 	
					    	<li><a href="showcommonbook.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index == list.pageNum}"> 	
					    	<li class="active"><a href="showcommonbook.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="showcommonbook.do?pn=${list.nextPage}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
					</c:if>
					
					<c:if test="${showwhat=='kill'}">
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="showkillbook.do?pn=${list.prePage}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					   		<c:if test="${index ne list.pageNum}"> 	
					    	<li><a href="showkillbook.do?pn=${index}">${index}</a></li>
					   		</c:if>
					   		<c:if test="${index == list.pageNum}"> 	
					    	<li class="active"><a href="showkillbook.do?pn=${index}">${index}</a></li>
					   		</c:if>
					    </c:forEach>
					    <li>
					      <a href="showkillbook.do?pn=${list.nextPage}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
					</c:if>
					
					<c:if test="${showwhat=='search'}">
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="searchbook.do?pn=${list.prePage}&key=${key1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}">
					    		<li><a href="searchbook.do?pn=${index}&key=${key1}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index==list.pageNum}">
					    		<li class="active"><a href="searchbook.do?pn=${index}&key=${key1}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="searchbook.do?pn=${list.nextPage}&key=${key1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
					</c:if>
					
					<c:if test="${showwhat=='allbyclick'}">
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="getbookbyclick.do?pn=${list.prePage}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}">
					    		<li><a href="getbookbyclick.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index==list.pageNum}">
					    		<li class="active"><a href="getbookbyclick.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="getbookbyclick.do?pn=${list.nextPage}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					  </ul>
					</nav>
					</c:if>
					
					<c:if test="${showwhat=='allbysalecount'}">
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li>
					      <a href="getbookbysalecount.do?pn=${list.prePage}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					    <c:forEach items="${list.navigatepageNums }" var="index">
					    	<c:if test="${index ne list.pageNum}">
					    		<li><a href="getbookbysalecount.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    	<c:if test="${index==list.pageNum}">
					    		<li class="active"><a href="getbookbysalecount.do?pn=${index}">${index}</a></li>
					    	</c:if>
					    </c:forEach>
					    <li>
					      <a href="getbookbysalecount.do?pn=${list.nextPage}" aria-label="Next">
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
		</div>
		
	</div>
</div><br>
<%@include file="../template/bottom.jsp" %>
  
</body>
</html>