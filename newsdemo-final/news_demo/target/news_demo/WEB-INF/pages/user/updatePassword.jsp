<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/3
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改密码</title>
    <%@include file="../back_component/import.jsp"%>
</head>
<body>
    <div class="container-fluid">
        <%@include file="../back_component/top.jsp"%>
        <div class="row">
            <%@include file="../back_component/menu.jsp"%>
            <div class="col-md-10" style="margin-top: 82px;">
                <div class="page-header">
                    <h3>修改密码 <small>Modify Password</small></h3>
                </div>

                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <form id="update_password_form" action="/user/updatePassword" class="form-horizontal" method="post">
                            <div class="form-group form-group-lg">
                                <label class="col-md-2 control-label">原密码</label>
                                <div class="col-md-7">
                                    <input type="password" name="oldPassword" class="form-control" required autofocus placeholder="请输入原密码">
                                </div>
                            </div>
                            <div class="form-group form-group-lg">
                                <label class="col-md-2 control-label">新密码</label>
                                <div class="col-md-7">
                                    <input  type="password" name="newPassword" class="form-control" required minlength="6" max="16" placeholder="请输入新密码6-16个字符">
                                </div>
                            </div>
                            <div class="form-group form-group-lg">
                                <label class="col-md-2 control-label">新密码确认</label>
                                <div class="col-md-7">
                                    <input type="password" name="confirmPassword" class="form-control" required minlength="6" max="16" placeholder="请再次输入新密码">
                                </div>
                            </div>
                            <div class="form-group form-group-lg">
                               <div class="col-md-7 col-md-offset-2">
                                   <button  class="btn btn-default btn-lg">修改</button>
                                   <button type="reset" class="btn btn-default btn-lg">重置</button>
                               </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>

    </div>

<script>
    $("#update_password_form").submit(function(){
        var data = $(this).serialize();
        $.ajax({
            url:$(this).attr("action"),
            method:"post",
            data:data,
            async:false,
            success:function(result){
                //alert(result.info);

                if(result.info == "两次输入的密码不一样"){
                    alert(result.info)
                    $("#update_password_form input[name=newPassword]").val("");
                    $("#update_password_form input[name=confirmPassword]").val("")
                    $("#update_password_form input[name=newPassword]").focus();
                }
                if(result.info == "与原密码不同"){
                    alert(result.info)
                    $("#update_password_form input[name=oldPassword]").val("");
                    $("#update_password_form input[name=oldPassword]").focus();
                }
                if(result.info == '修改成功'){
                    alert(result.info)
                    location.href = "updatePassword";
                }
            },
            error:function(result){
                alert("服务器繁忙，请稍后再试")
            }
        });
        return false;
    });
    //选中当前菜单选项
    $("#user_info_ul").css("display","block");
    $("#user_info_ul > li:nth-child(2)  a").addClass("menu-selected");
//    $(".aside > ul > li:nth-child(1) > a > span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
</script>
</body>
</html>
