<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
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

        <div class="col-md-10" style="padding-top: 82px;">
            <div class="page-header">
                <h3>用户管理 <small>Manager User</small></h3>
            </div>

            <div class="row">
                <div class="col-md-offset-1 col-md-9">
                    <style>
                        table{vertical-align: middle}
                        table>thead th{text-align: center}

                    </style>
                    <table class="table table-striped text-center table-hover">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>角色</th>
                            <th>部门</th>
                            <th>注册时间</th>
                            <th>#</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.pageInfo.list}" varStatus="calc" var="user">
                            <tr>
                                <td>${(requestScope.pageInfo.pageNum-1) * 10 + calc.count}</td>
                                <td>${user.username}</td>
                                <td>${user.realName}</td>
                                <td <c:if test="${user.role.roleId==3}">class="bg-danger text-danger"</c:if>
                                    <c:if test="${user.role.roleId==1}">class="bg-success text-success"</c:if>
                                    <c:if test="${user.role.roleId==2}">class="bg-info text-info"</c:if>
                                    <c:if test="${user.role.roleId==4}">class="bg-warning text-warning"</c:if>>
                                        ${user.role.roleName}
                                </td>
                                <td>${user.department.departmentName}</td>
                                <td>${user.createTime}</td>
                                <td><button edit_btn  class="btn btn-primary" username="${user.username}">编辑</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <style>

                    </style>
                    <div class="center-block" style="width: 700px;">
                        <nav aria-label="Page navigation">
                            <ul class="pagination pagination-lg">
                                <li>
                                    <a href="userList?pageNum=${requestScope.pageInfo.pageNum-1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach items="${requestScope.pageInfo.navigatepageNums}"  var="num">
                                    <li <c:if test="${requestScope.pageInfo.pageNum == num}">class="active"</c:if>>
                                        <a href="userList?pageNum=${num}">${num}</a>
                                    </li>
                                </c:forEach>
                                <li>
                                    <a href="userList?pageNum=${requestScope.pageInfo.pageNum+1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

    </div><!--row结束-->




    <!-- Modal -->
    <div class="modal fade" id="modify_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="padding-top: 150px;">
            <div class="modal-content">
                <form class="form-horizontal" id="modify_form" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">编辑用户</h4>
                </div>
                <div class="modal-body">
                        <div class="form-group form-group-lg">
                            <label class="control-label col-md-3">用户名</label>
                            <div class="col-md-9">
                                <input class="form-control" type="text" disabled  id="username_input" name="username">
                            </div>
                            <input type="hidden" name="username" id="username_input_hidden">
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="control-label col-md-3">创建时间</label>
                            <div class="col-md-9">
                                <input required class="form-control" type="text" disabled  id="create_time_input">
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="control-label col-md-3">密码</label>
                            <div class="col-md-9">
                                <input required class="form-control" type="password"   id="password_input" name="password">
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="control-label col-md-3">真实姓名</label>
                            <div class="col-md-9">
                                <input class="form-control" type="text"  id="real_name_input" name="realName" required>
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="control-label col-md-3">角色</label>
                            <div class="col-md-5">
                                <select class="form-control"  id="role_select" name="role.roleId">
                                    <option value="0">管理员</option>
                                    <option value="1">部门用户</option>
                                    <option value="2">普通用户</option>
                                    <option value="3">待审核</option>
                                    <option value="4">禁止使用</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="control-label col-md-3">部门</label>
                            <div class="col-md-5">
                                <select class="form-control" id="department_select" name="department.departmentId">
                                    <option value="1" >甲机房</option>
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

                </div>
                <div class="modal-footer">
                    <button type="submit"  class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
                </form>
            </div>
        </div>
    </div>


</div><!--container-fluid结束-->


<script>
    $("button[edit_btn]").click(function(){
        var username = $(this).attr("username");
        $.ajax({
            url:"/admin/manageUser/getUser",
            method:"get",
            data:"username="+ username,
            success:function(result){
                fillModal(result);
            }
        });
        $("#modify_modal").modal();
    })
    function fillModal(result){
        var username = result.username;
        var realName = result.realName;
        var createTime = result.createTime;
        var department = result.department;
        var role = result.role;
        var password = result.password;
        $("#username_input_hidden").val(username);
        $("#username_input").val(username);
        $("#real_name_input").val(realName);
        $("#password_input").val(password);
        $("#create_time_input").val(processTime(createTime));
        $.each($("#role_select option"),function(index,obj){
            if($(obj).val() == role.roleId){
                $(obj).attr("selected","selected");
            }
        })
        $.each($("#department_select option"),function(index,obj){
            if($(obj).val() == department.departmentId){
                $(obj).attr("selected","selected");
            }
        })
    }
    //处理毫秒时间
    function processTime(milliseconds){
        var date = new Date(milliseconds);
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var seconds = date.getSeconds();
        return year+"年"+month+"月"+day+"日"+" "+hour+"时"+minute+"分"+seconds+"秒"
    }


    //处理表单提交
    $("#modify_form").submit(function () {
        var data = $("#modify_form").serialize();
        console.log("数据是："+data);
        $.ajax({
            url:"/admin/manageUser/modifyUser",
            method:"post",
            data:data,
            method:"post",
            success:function(result){
               alert(result.info)
                location.href = "/admin/manageUser/userList"
            },
            error:function () {

            }
        });
        return false;
    });

    //选中当前菜单选项
    $("#manage_user_ul").css("display","block");
    $("#manage_user_ul > li:nth-child(1)  a").addClass("menu-selected");
</script>
</body>
</html>
