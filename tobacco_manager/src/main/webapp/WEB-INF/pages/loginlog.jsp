<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/22
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>登录日志</title>
    <link rel="stylesheet" type="text/css" href="static/assets/css/amazeui.min.css">
    <script type="text/javascript" src="static/assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/assets/js/amazeui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="static/assets/css/admin.css">
</head>
<body>
<%@include file="parts/top.jsp"%>
<div class="am-cf admin-main">
    <!--导航条-->
    <%@include file="parts/nav.jsp"%>
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">登录日志</strong> / <small>Look LoginLogs</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-11 am-u-md-centered">
                    <!--页面内容-->
                    <table class="am-table am-table-striped am-table-hover am-table-centered">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>日期</th>
                            <th>登录时间</th>
                            <th>IP地址</th>
                            <th>登录结果</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach varStatus="count" items="${pageInfo.list}" var="log">
                            <tr>
                                <td>${count.count}</td>
                                <td><fmt:formatDate value="${log.loginTime}" pattern="yyyy年MM月dd日"/></td>
                                <td><fmt:formatDate value="${log.loginTime}" pattern="HH时mm分ss秒"/></td>
                                <td>${log.ipAddress}</td>
                                <td>${log.result}</td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>

            <!--分页条部分-->
            <div class="am-g">
                <div class="am-u-md-7 am-u-md-centered">
                    <ul data-am-widget="pagination" class="am-pagination am-pagination-default">
                        <li class="am-pagination-prev ">
                            <a href="#" class="">上一页</a>
                        </li>

                       <c:forEach var="page" items="${pageInfo.navigatepageNums}">
                           <li <c:if test="${pageInfo.pageNum==page}">class="am-active"</c:if>>
                               <a href="${path}/loginlog?username=${user.username}&pageNum=${page}">
                                    ${page}
                               </a>
                           </li>
                       </c:forEach>

                        <li class="am-pagination-next ">
                            <a href="#" class="">下一页</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
</div><!--<div class="am-cf admin-main">-->
</body>
</html>
