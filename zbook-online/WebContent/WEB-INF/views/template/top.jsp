<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 顶部容器 -->
<div class="container" >
	<!--第一行-->
	<div class="row" style="margin: 40px" >
	<!--第一行第1列-->
		<div class="col-md-3" style="">
			<a href="index.do"><img src="${basePath}static/images/logo.jpg"></a>
		</div>
		<!--第一行第2列-->
		<div class="col-md-5" style="padding-top: 40px;
    padding-left: 100px;">
			<form action="searchbook.do" method="post">
				<div class="input-group">
					<input id="input" required="required" name="key" type="text" class="form-control" aria-label="...">
			      <div class="input-group-btn">
			        <button type="submit" class="btn btn-default">搜索图书</button>
			      </div>    
    			</div>
			</form>	
			<table id="table" class="table table-hover table-bordered">
				
			</table>		
		</div>
		<!--第一行第3列-->
		<div class="col-md-3">
			<c:choose>
				<c:when test="${user==null}">
					<a href="login.do" class="btn btn-primary" style="margin-left: 20px;margin-top: 40px;">
		<span class="glyphicon glyphicon-user"></span>
			&nbsp;登录
		</a>
			<a href="register.do" class="btn btn-primary" style="margin-left: 20px;margin-top: 40px;"><span class="glyphicon glyphicon-pencil"></span>&nbsp;注册</a>
				</c:when>
				<c:otherwise>
					<label style="margin-top: 50px">欢迎你，<strong><a href="userinfo.do">${user.name}</a>!</strong>
					<a href="loginout.do">退出登录</a>
					</label>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	</div>
	
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.js"></script>
	<script>
		$(function(){
			$('#input').keyup(function(){
			
				var str1 = $('#input').val();
				var str=$.trim(str1);
				if(str.length<=0){
					$('#table').empty();
				}
				if(str.length>0){
					$.ajax({
						type:"POST",
						url:"${pageContext.request.contextPath}/autoDown.do",
						data:{
							key:str
						},
						dataType:"json",
						success:function(data1){
							$('#table').empty();
							var data=eval(data1);//传回一个List
							if(data.length<=0){
								var $tr=$('<tr></tr>');
								var $td=$("<td></td>");
								$td.append("没有相关图书");
								$('#table').append($tr);
								$tr.append($td);
							}else{
							for(var i=0;i<data.length;i++){
								var $tr=$('<tr></tr>');
								var $td=$('<td></td>');
								$td.append(data[i]);
								$tr.append($td);
								$('#table').append($tr);
								
								$td.click(function(){
									$('#input').val($(this).text());
								});
								$td.mouseover(function(){
									$(this).css("background-color","#ebebeb");
								});
								$td.mouseout(function(){
									$(this).removeAttr("style");
								});
							}
							var $tr=$('<tr></tr>');
							var $td=$("<td style='text-align:right'></td>");
							$('#table').append($tr);
							$tr.append($td);
							$td.append("关闭");
							$td.click(function(){
								$('#table').empty();
							});
							} 
						}
					});
				}
			});
		});
	</script>