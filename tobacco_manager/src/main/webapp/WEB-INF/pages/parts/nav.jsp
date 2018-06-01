<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/7
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>

<!--导航条-->
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar">
        <ul class="am-list admin-sidebar-list">

            <li class="admin-parent">
                <a class="am-cf" data-am-collapse="{target: '#collapse-nav'}">
                    <span class="am-icon-home"></span> 个人中心 <span class="am-icon-angle-double-down am-fr am-margin-right"></span>
                </a>
                <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
                    <li><a href="${path}/index" class="am-cf"> 个人信息</a></li>
                    <li><a href="${path}/password"> 修改密码</a></li>
                    <li><a href="${path}/loginlog?username=${sessionScope.user.username}"> 登录日志</a></li>
                </ul>
            </li>
            <li><a href="${path}/lookGoods?page=1&size=15"><span class="am-icon-table"></span> 查看货源</a></li>
            <c:if test="${sessionScope.user.role.roleId != 0}">
                <li><a href="${path}/orderPage"><span class="am-icon-pencil-square-o"></span>订单查询</a></li>
                <li class="admin-parent">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-nav2'}">
          	    <span class="am-icon-line-chart">
                </span> 销售情况 <span class="am-icon-angle-double-down am-fr am-margin-right"></span>
                    </a>
                    <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav2">
                        <li><a href="${path}/lookSituation" class="am-cf">查看销售情况</a></li>
                        <li><a href="${path}/uploadSituation"> 上传销售情况</a></li>
                    </ul>
                </li>
            </c:if>
            <li class="admin-parent">
                <a class="am-cf" data-am-collapse="{target: '#collapse-nav4'}">
          	    <span class="am-icon-line-chart">
                </span> 投诉反馈 <span class="am-icon-angle-double-down am-fr am-margin-right"></span>
                </a>
                <ul id="collapse-nav4" class="am-list am-collapse admin-sidebar-sub am-in">
                    <c:if test="${sessionScope.user.role.roleId != 0}">
                        <li><a href="${path}/fillAdvice" class="am-cf">发送信息给管理员</a></li>
                    </c:if>
                    <li><a href="${path}/lookAdvice"> 查看消息列表</a></li>
                </ul>
            </li>
            <li><a href="${path}/logout"><span class="am-icon-sign-out"></span> 退出登录</a></li>
            <c:if test="${sessionScope.user.role.roleId==0}">
                <li class="admin-parent">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-nav3'}">
                        <span class="am-icon-home"></span> 管理员功能 <span class="am-icon-angle-double-down am-fr am-margin-right"></span>
                    </a>
                    <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav3">
                        <li><a href="${path}/admin/managerGoods">管理货源</a></li>
                        <li><a href="${path}/admin/managerOrders">管理订单</a></li>
                        <li><a href="${path}/admin/managerSeller">管理零售商</a></li>
                        <li><a href="${path}/lookAdvice">管理消息</a></li>
                    </ul>
                </li>
            </c:if>
        </ul>
    </div>
</div><!--导航条-->
