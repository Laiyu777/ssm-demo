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
<title>编辑图书</title>
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
		<!-- 夜幕 -->
		<div class="jumbotron">
  					<h2>更新图书</h2>
		</div>
		
		<!--第一行-->
			<div class="row" style="border-bottom: solid;">
				<div class="col-md-9 col-md-offset-1">				
						<div class="row">
					
<form class="form-horizontal" action ="uploadimg.do?id=${book.id}" method="post" enctype="multipart/form-data">
	<div class="form-group">
		<label class="col-sm-2 control-label">已经上传的图片：</label>
		<div class="col-sm-10">
     		<img height="300px" width="300px" src="<%= basePath%>static/images/bookimg/${book.id}.jpg">
   		</div>
	</div>
	
	<div class="form-group">
	<label  class="col-sm-2 control-label">选择图片：</label>
    <div class="col-sm-10">
      <input name="file" type="file"   >
   </div>
   </div>
   
   <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">上传图片</button>
    </div>
  </div>
</form>
<hr>


						
<form class="form-horizontal" action="updatebook.do" method="post">
  <div class="form-group">
    <label  class="col-sm-2 control-label">图书名称：</label>
    <div class="col-sm-10">
      <input value="${book.name}" required="required" name="name" type="text" class="form-control"  placeholder="请输入图书名称">
    </div>
  </div>
  
  <div class="form-group">
    <label  class="col-sm-2 control-label">价格：</label>
    <div class="col-sm-10">
      <input value="${book.price}" required="required" name="price" type="number" class="form-control"  placeholder="请输入图书价格">
    </div>
  </div>
  
  <div class="form-group">
    <label  class="col-sm-2 control-label">库存：</label>
    <div class="col-sm-10">
      <input value="${book.stock}" required="required" name="stock" type="number" class="form-control"  placeholder="请输入图书库存">
    </div>
  </div>
  
   <div class="form-group">
    <label class="col-sm-2 control-label">关键字：</label>
    <div class="col-sm-10">
    	<input type="text" required="required" name="key" value="${book.key}" class="form-control">
    </div>
  </div>
  
   <div class="form-group">
    <label class="col-sm-2 control-label">类别：</label>
    <div class="col-sm-4">
    	<select name="kind" class="form-control">
    		<option value="计算机技术">计算机技术</option>
    		<option value="小说">小说</option>
    		<option value="童书">童书</option>
    		<option value="教育">教育</option>
    		<option value="生活">生活</option>
    		<option value="其他">其他</option>
    	</select>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label">图书描述：</label>
    <div class="col-sm-10">
      <textarea required="required" rows="9" cols="60" name="description">${book.description}</textarea>
    </div>
  </div>
 
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary btn-lg">更新图书</button>
    <a href="index.do">返回首页</a>
    </div>
  </div>
</form>
					
					
					
						</div>				
					</div>
				</div>	
				<!-- 第二行 -->
				
				
				
					
			</div>			
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$("select>option").each(function(){
				if($(this).attr("value")=="${book.kind}"){
					$(this).attr("selected","selected");
				}
			});
		});
	</script>
  
</body>
<%@include file="../template/bottom.jsp" %>
</html>