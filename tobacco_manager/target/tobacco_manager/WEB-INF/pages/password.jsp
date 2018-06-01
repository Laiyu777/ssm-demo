<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/7
  Time: 7:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>修改密码</title>

    <link rel="stylesheet" type="text/css" href="static/assets/css/amazeui.min.css">
    <script type="text/javascript" src="static/assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/assets/js/amazeui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="static/assets/css/admin.css">
</head>
<body>

<!--顶部页面-->
<%@include file="parts/top.jsp"%>

<div class="am-cf admin-main">
    <!--导航条-->
    <%@include file="parts/nav.jsp"%>
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">修改密码</strong> / <small>Modify password</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-9 am-u-md-centered">
                    <form id="form" class="am-form am-form-horizontal"    data-am-validator>
                        <div class="am-form-group">
                            <label for="doc-ipt-3"  class="am-u-sm-2 am-form-label">旧密码：</label>
                            <div class="am-u-sm-10">
                                <input type="password" name="password" placeholder="输入你的旧密码" required>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="doc-ipt-3" class="am-u-sm-2 am-form-label">新密码</label>
                            <div class="am-u-sm-10">
                                <input type="password"  id="doc-ipt-3" placeholder="输入你的新密码" minlength="8" required>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="doc-ipt-3" class="am-u-sm-2 am-form-label">新密码确认</label>
                            <div class="am-u-sm-10">
                                <input id="input1" name="newpassword" data-equal-to="#doc-ipt-3" type="password" placeholder="再次输入你的新密码" minlength="8" required>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-10 am-u-sm-offset-2">
                                <button id="confirmBtn"  class="am-btn am-btn-default">确认修改</button>
                                <strong class="am-text-danger am-text-lg">${msg}</strong>
                            </div>
                        </div>
                    </form>
                </div>
            </div>


            <!--页脚-->
            <%@include file="parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->

<script type="text/javascript">
    $(function () {
        $('#confirmBtn').click(function () {
            //获取旧密码、新密码
            var inputs = $('#form input');
            var oldPassword = $(inputs[0]).val();
            var newPassword = $(inputs[1]).val();
            var conFirmPassword = $(inputs[2]).val();
            //使用js提交表单，会使html5的验证失效
            //验证不能为空
            if(oldPassword.length==0||newPassword.length==0||conFirmPassword==0){
                alert('输入的不能为空')
                return false
            }
            //验证密码的长度
            if(conFirmPassword.length<8||newPassword.length<8){
                alert('新密码的长度必须大于等于8位')
                return false
            }
            //验证两次输入的密码
            if(newPassword!=conFirmPassword){
                alert("两次输入的新密码不同");
                //加上css样式
                //$(inputs[1]).removeClass("am-active am-field-valid").addClass("am-field-error am-active");
                return false;
            }
            else {
                $.ajax({
                    url:"updatePassword",
                    type:"post",
                    data:{
                        "password":oldPassword,"newpassword":newPassword
                    },
                    success:function (result) {
                        if(result=='修改成功'){
                            alert('修改成功，请重新登录')
                            $(window).attr("location","${path}/login.jsp");
                        }else{
                            alert('修改失败,与原密码不同');
                            //添加css
                            $('#form div:first').removeClass("am-form-success").addClass("am-form-error");
                            $(inputs[0]).removeClass("am-active am-field-valid").addClass("am-field-error am-active");
                        }
                    }
                });
            }
            return false;
        });
    })
</script>
</body>
</html>
