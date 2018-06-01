<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/7
  Time: 12:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    request.setAttribute("path",path);
%>
<header class="am-topbar admin-header" >
    <div class="am-topbar-brand">
        <strong>烟草管理系统</strong> <small>Tobacco Manage System</small>
    </div>

    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-left admin-header-list">
            <li><a href="javascript:;"><span class="am-icon-envelope-o"></span> 未读信息
                <c:if test="${sessionScope.no_read_count!=0}">
                    <span class="am-badge am-badge-warning">
                        ${sessionScope.no_read_count}
                    </span></a></li>
                </c:if>
            <li><a href="${path}/cartPage"><span class="am-icon-shopping-cart"></span> 购物车 </a></li>
            <li class="am-dropdown" data-am-dropdown="">
                <a class="am-dropdown-toggle" data-am-dropdown-toggle="" href="javascript:;">
                    <span class="am-icon-users"></span> ${user.realName} <span class="am-icon-caret-down"></span>
                </a>
                <ul class="am-dropdown-content">
                    <li><a href="${path}/index"><span class="am-icon-user"></span> 资料</a></li>
                    <li><a href="${path}/logout"><span \class="am-icon-power-off"></span> 退出</a></li>
                </ul>
            </li>
            <li><a href="#">${user.role.roleName}</a></li>
        </ul>
    </div>
</header>