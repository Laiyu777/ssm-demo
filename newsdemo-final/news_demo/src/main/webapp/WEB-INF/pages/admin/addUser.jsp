<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<html>
<head>
    <title>添加用户</title>
    <%@include file="../back_component/import.jsp"%>
</head>
<body>
<div class="container-fluid">
    <%@include file="../back_component/top.jsp"%>
    <div class="row">
        <%@include file="../back_component/menu.jsp"%>

        <div class="col-md-10" style="padding-top: 82px;">
            <div class="page-header">
                <h3>添加用户 <small>Add User</small></h3>
            </div>

            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    <form id="add_form"  class="form-horizontal" method="post">
                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">用户名</label>
                            <div class="col-md-7">
                                <input class="form-control" id="register_input_username" type="text" name="username" required pattern="[0-9a-zA-Z]{3,15}" minlength="3" maxlength="15"  placeholder="请输入用户名 3-15个英文数字" autofocus>
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">密码</label>
                            <div class="col-md-7">
                                <input  type="password" name="password" class="form-control" required minlength="6" max="16" placeholder="请输入密码 6-16个字符">
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">真实姓名</label>
                            <div class="col-md-7">
                                <input  type="text" name="realName" class="form-control" required pattern="[\u4e00-\u9fa5]{2,8}" placeholder="请输入真实姓名 2-8个中文">
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">电话</label>
                            <div class="col-md-7">
                                <input  type="text" name="phone" class="form-control" required pattern="[0-9]{7,11}" placeholder="请输入电话号码 7-11个数字">
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">角色</label>
                            <div class="col-md-5">
                                <select class="form-control" name="role.roleId">
                                    <option value="0">管理员</option>
                                    <option value="1">部门用户</option>
                                    <option value="2">普通用户</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">部门</label>
                            <div class="col-md-5">
                                <select class="form-control" name="department.departmentId">
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
                        </div>
                        <div class="form-group form-group-lg">
                            <div class="col-md-7 col-md-offset-2">
                                <button  class="btn btn-default btn-lg">添加</button>
                                <button type="reset" class="btn btn-default btn-lg">重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div><!--row结束-->





</div><!--container-fluid结束-->


<script>
   $("#add_form").submit(function () {
       var data = $(this).serialize();
       console.log("数据："+data);
       $.ajax({
           url:"/admin/manageUser/addUser",
           data:data,
           method:"post",
           success:function (result) {
               alert(result.info);
               location.href = "/admin/manageUser"
           },
           error:function (result) {
               alert(result.info);
           }
       });
       return false;
   });

   //选中当前菜单选项
   $("#manage_user_ul").css("display","block");
   $("#manage_user_ul > li:nth-child(2)  a").addClass("menu-selected");
</script>
</body>
</html>
