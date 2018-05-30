<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
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
<title>充值界面</title>
</head>
<body>
	<jsp:include page="../template/top.jsp"></jsp:include>
	<jsp:include page="../template/navleft.jsp"></jsp:include>
<!-- 核心内容开始 -->	
	<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-3" >
		<!--第一行-->
		<div class="jumbotron">
			<h3>用户充值</h3>
		</div>
		<!--第一行-->
			<div class="row" >
			 <div class="col-md-8 col-md-offset-1">
<form id="form" class="form-horizontal" action="addmoney.do" method="post">
  <div class="form-group">
    <label class="col-sm-2 control-label">当前余额</label>
    <div class="col-sm-10">
      <input readonly="readonly" type="text" class="form-control" value="${user.blance }">
    </div>
  </div>

  <div class="form-group">
    <label class="col-sm-2 control-label">充值金额</label>
    <div class="col-sm-10">
      <input required="required" type="number" class="form-control" name="money"><small>请输入一个整数</small>
    </div>
  </div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button id="button" type="submit" class="btn btn-primary">充值</button>
    </div>
  </div>
</form>
			 </div>
			</div>
		</div>
	</div>
</div>
<!-- 核心内容结束 --><br><br>
	<!-- 底部 -->
	<%@include file="../template/bottom.jsp" %>
	<!-- 底部 -->
	<script type="text/javascript">
		$(function(){
			var  flag;
			$("input[name='money']").change(function(){
				var money = $("input[name='money']").val();
				money=Number(money);
				if(money<=0){
					flag=false;
					alert('不能输入比0小的数字！');
				}else{
					flag=true;
				}
			});
			
			$('#button').click(function(){
				if(flag==true){
					alert('充值成功！');
					$('#form').submit();
				}else{
					return false;
				}
			});
			
			$(function(){
	            $('input[name=money]').keypress(function(e) {
	              if (!String.fromCharCode(e.keyCode).match(/[0-9]/)) {
	                return false;
	              }
	            });
	        });
			
		});
	</script>
</body>
</html>