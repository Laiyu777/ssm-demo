<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<div class="header row">
    <div class="col-md-12">
        <div class="header-left">641后台管理系统</div>
        <div class="header-right">
            当前登录用户:<span>${sessionScope.user.realName}</span>
            部门:<span>${sessionScope.user.department.departmentName}</span>
            角色:<span>${sessionScope.user.role.roleName}</span>
            时间:<span id="date"></span>
            <script>
                var today = new Date();
                var nextDay = today.getFullYear()+"年"+(today.getMonth()+1)+"月"+(today.getDate()+1)+"日 " +
                    today.getHours()+"时"+today.getMinutes()+"分";
                $("#date").html(nextDay);
            </script>
        </div>
    </div>
</div><!--header row 结束-->
