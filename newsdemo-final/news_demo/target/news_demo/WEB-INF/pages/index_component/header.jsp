<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/12
  Time: 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header">
    <div class="header-top">
        <div class="header-login">
            <c:if test="${sessionScope.user == null}">
                <form  id="login_form" method="post">
                    <label for="">用户名:</label>
                    <input type="text" name="username" required>
                    <label for="">密码:</label>
                    <input type="password" name="password" required>
                    <button type="button" id="login_btn" >登录</button>
                    <button type="button" id="register_btn">注册</button>
                </form>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <form style="padding: 9px 5px;"> 欢迎你,
                    <a style="text-decoration: none;" href="/user/userInfo" target="_blank">
                            ${sessionScope.user.realName}
                    </a>
                    <a style="text-decoration: none" href="/loginout">退出登录</a>
                </form>
            </c:if>
            <form class="search">
                <input type="text" placeholder="请输入关键词">
                <button type="submit">搜索</button>
            </form>
        </div>
    </div>
    <div class="header-text">国家广播电视总局六四一台</div>
</div>

<!-- 注册模态框 -->
<div class="modal" id="register_modal">
    <div class="modal-content" style="margin-left: -250px">
        <div class="modal-content-header">
            <h3 style="display: inline-block;border-bottom: 2px solid red;height: 29px">注册</h3>
        </div>
        <form action="" id="register_form" method="post">
            <div class="form-row">
                <label for="">用户名</label>
                <input id="register_input_username" type="text" name="username" required pattern="[0-9a-zA-Z]{3,15}" minlength="3" maxlength="15"  placeholder="请输入3-15个英文数字" autofocus>

            </div>
            <div class="form-row">
                <label for="">真实姓名</label>
                <input type="text" name="realName" required pattern="[\u4e00-\u9fa5]{2,8}" placeholder="请输入2-8个中文">
            </div>
            <div class="form-row">
                <label for="">电话</label>
                <input type="text" name="phone" required pattern="[0-9]{7,11}" placeholder="请输入7-11个数字" minlength="7" maxlength="11">
            </div>
            <div class="form-row">
                <label for="">密码</label>
                <input type="password" name="password" required minlength="6" maxlength="20" placeholder="请输入6-20个字符">
            </div>
            <div class="form-row">
                <label for="">密码确认</label>
                <input type="password" name="confirm_password" required placeholder="请确认密码">
            </div>
            <div class="form-row" required>
                <label for="">部门</label>
                <select name="department.departmentId" id="">
                    <option value="1">甲机房</option>
                    <option value="2">乙机房</option>
                    <option value="3">节传机房</option>
                    <option value="4">台办室</option>
                    <option value="5">台领导</option>
                    <option value="6">技办室</option>
                    <option value="7">人事科</option>
                    <option value="8">离退科</option>
                    <option value="9">行政科</option>
                    <option value="10">器材科</option>
                    <option value="11">维修室</option>
                    <option value="12">保卫科</option>
                </select>
            </div>
            <div class="form-row">
                <div class="button-group">
                    <button id="confirm_register_btn">注册</button>
                    <button id="cancel_register">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    //登录验证方法
    $("#login_btn").click(function () {
        var data = $("#login_form").serialize();
        //console.log(data);
        $.ajax({
            url:"/login",
            data:data,
            type:"post",
            success:function (result) {
                if(result.code == 400){
                    $("#login_form label").css("color","red");
                    $("#login_form input").css("border","2px solid red");
                    alert(result.info);
                }else{
                    location.href = "/";
                }
            },
            error:function(){
                alert("服务器繁忙请稍后再试!");
            }
        })
    });
    var height =window.screen.availHeight;//这是除去任务栏的屏幕高度
    //console.log("\""+height+"px\"")
    $("#stay_modal").css("height",height);

    $(".floor-2-header a").click(function(){
        $("#stay_modal").css("display","block");
    })
    //点击外面的时候小时
    $("#stay_modal").click(function(){
        console.log("外面被点击了")
        $(this).css("display","none");
    })
    $('.modal-content').click(function(e){
        console.log("里面被点击了")
        e.stopPropagation();
    })
    //显示注册框
    $("#register_btn").click(function(){
        $('#register_modal').css("height",height);
        $('#register_modal').css("display","block");
    });
    $("#register_modal").click(function(){
        console.log("外面被点击了")
        $(this).css("display","none");
    })

    //表单提交验证
    $("#register_form").submit(function () {
        var password1 = $("#register_form input[name=password]").val();
        var password2 = $("#register_form input[name=confirm_password]").val();
        if(password1!=password2){
            alert("两次输入的密码不一样");
            $("#register_form input[name=password]").val("").focus();
            $("#register_form input[name=confirm_password]").val("");
            return false;
        }else {
            $.ajax({
                url:"/register",
                data:$("#register_form").serialize(),
                type:"post",
                success:function(result){
                    if(result.code == 200){
                        alert("注册成功，请重新登录");
                        location.href = "/";
                    }else {
                        alert(result.info);
                        $("#register_form input[name=username]").val("").focus();
                    }
                },
                error:function(result){
                    alert("服务器繁忙，请稍后再试")
                }
            });
        }
        return false;
    });


    //取消注册按钮
    $("#cancel_register").click(function () {
        $("#register_modal").css("display","none");
    });
</script>
