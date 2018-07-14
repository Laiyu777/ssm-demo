<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>用户信息</title>
    <%@include file="../back_component/import.jsp"%>
</head>
<body>
<div class="container-fluid">
    <%@include file="../back_component/top.jsp"%>
    <div class="row">
        <%@include file="../back_component/menu.jsp"%>

        <div class="col-md-10" style="margin-top: 82px;">
            <div class="page-header">
                <h3>个人信息 <small>Personal Information</small></h3>
            </div>
            <style>
                .table-help{
                    text-align: center;font-size: 20px;margin-top: 20px;
                    box-shadow: 0px 0px 26px -7px #000;
                }
            </style>
            <div class="row">
                <div class="col-md-offset-3 col-md-6">
                    <table class="table table-hover table-help">
                        <tr>
                            <td>用户名</td>
                            <td>${sessionScope.user.username}</td>
                        </tr>
                        <tr>
                            <td>真实姓名</td>
                            <td>${sessionScope.user.realName}</td>
                        </tr>
                        <tr>
                            <td>电话</td>
                            <td>${sessionScope.user.phone}</td>
                        </tr>
                        <tr>
                            <td>部门</td>
                            <td>${sessionScope.user.department.departmentName}</td>
                        </tr>
                        <tr>
                            <td>角色</td>
                            <td>${sessionScope.user.role.roleName}</td>
                        </tr>
                        <tr>
                            <td>创建时间</td>
                            <td>${sessionScope.user.createTime}</td>
                        </tr>
                        <tr>
                            <td colspan="2"><button class="btn btn-default btn-lg" data-toggle="modal" data-target="#modify_info">修改</button></td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>

    </div><!--row结束-->






    <!-- Modal -->
    <div class="modal fade" id="modify_info" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="min-width: 650px; padding-top: 180px;">
            <form  class="form-horizontal" method="post" id="modify_user_form" action="/user/modifyUser">
                <input type="hidden" value="${sessionScope.user.username}" name="username">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">修改信息</h4>
                </div>
                <div class="modal-body">

                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">真实姓名</label>
                            <div class="col-md-10">
                                <input class="form-control" type="text" name="realName"
                                       required minlength="2" max="8" value="${sessionScope.user.realName}">
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-2 control-label">部门</label>
                            <div class="col-md-10">
                                <select class="form-control" type="text" name="department.departmentId" id="select_department"
                                        required  value="${sessionScope.user.department.departmentId}">
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

                    <script>
                        $("#select_department > option").each(function(){
                            if($(this).attr("value") == ${sessionScope.user.department.departmentId}){
                                $(this).attr("selected","selected");
                            }
                        });
                    </script>
                </div>
                <div class="modal-footer">
                    <button  class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
            </form>
        </div>
    </div>
    

</div>


<script>
    //修改表单的提交
    $("#modify_user_form").submit(function () {
        var data = $(this).serialize();
        console.log(data);
        $.ajax({
            url: $(this).attr("action"),
            type: "post",
            data:data,
            success:function (result) {
                alert(result.info);
                $("#modify_info").modal("hide");
                location.href = "userInfo";
            },
            error:function(){
                alert("服务器繁忙，请稍后再试")
            }
        });
        return false;
    });
    //选中当前菜单选项
    $("#user_info_ul").css("display","block");
    $("#user_info_ul > li:nth-child(1)  a").addClass("menu-selected");
//    $(".aside > ul > li:nth-child(1) > a > span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
</script>
</body>
</html>
