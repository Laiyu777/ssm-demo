<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/25
  Time: 0:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>新闻列表-${requestScope.title}</title>
    <%@include file="../index_component/import.jsp"%>
    <link href="${path}/static/css/news-list.css" rel="stylesheet" type="text/css">
</head>
<body>

<%--头部内容  宽度100%--%>
<%@include file="../index_component/header.jsp"%>
<%--头部内容  宽度100%--%>

<div class="container">
    <%--栏目--%>
    <%@include file="../index_component/colmuns.jsp"%>
    <%--栏目--%>
        <style>
            .sep-line::before{
                content: ">>";
                color: #CE002B;
            }
            .position a:hover{
                background-color: #F4F4F4;
                color:#CE002B;
            }
        </style>
    <div class="position">
        <span><a href="/index">首页</a></span>
        <span class="sep-line"></span>
        <span><a href="/newsList">新闻列表</a></span>
        <c:if test="${requestScope.menuName!=null}">
            <span class="sep-line"></span>
            <span><a  href="/newsList<c:if test="${requestScope.menuId!=null}">?menuId=${requestScope.menuId}</c:if>">${requestScope.menuName}</a></span>
        </c:if>
        <c:if test="${requestScope.submenuName!=null}">
            <span class="sep-line"></span>
            <span><a href="/newsList<c:if test="${requestScope.submenuId!=null}">?submenuId=${requestScope.submenuId}</c:if>">${requestScope.submenuName}</a></span>
        </c:if>
            <a href="/index" style="float: right">返回首页</a>
        </span>
    </div>
        <div class="news-list">
            <div class="news-list-left">
                <div class="floor-header">
                    <span>${requestScope.title}</span>
                </div>

                <div class="floor-body">
                    <c:if test="${fn:length(requestScope.pageInfo.list)==0}">
                        暂时没有新闻
                    </c:if>
                    <ul>
                        <c:forEach items="${requestScope.pageInfo.list}" var="news">
                            <li>
                                <span style="color: #CE0000;float:left;padding-right: 5px;font-size: 18px; ">[${news.user.department.departmentName}]</span>
                                <a href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                                <span><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
                            </li>
                        </c:forEach>
                    </ul>
                </div><!--floor-body结束-->
            </div><!--news-list-left结束-->
        </div><!--news-list结束-->


        <div class="page">
            <div class="page-area">
                <ul>
                    <li><a href="/newsList?pageNum=${requestScope.pageInfo.pageNum-1}<c:if test="${requestScope.menuId!=null}">&menuId=${requestScope.menuId}</c:if><c:if test="${requestScope.submenuId!=null}">&menuId=${requestScope.submenuId}</c:if>">&lt;&lt;</a></li>
                    <c:forEach items="${requestScope.pageInfo.navigatepageNums}" var="num">
                        <li>
                            <a <c:if test="${num == requestScope.pageInfo.pageNum}">class="page-active"</c:if> href="/newsList?pageNum=${num}
<c:if test="${requestScope.menuId!=null}">&menuId=${requestScope.menuId}</c:if><c:if test="${requestScope.submenuId!=null}">&menuId=${requestScope.submenuId}</c:if>">
                                ${num}
                            </a>
                        </li>
                    </c:forEach>
                    <li><a href="/newsList?pageNum=${requestScope.pageInfo.pageNum+1}<c:if test="${requestScope.menuId!=null}">&menuId=${requestScope.menuId}</c:if><c:if test="${requestScope.submenuId!=null}">&submenuId=${requestScope.submenuId}</c:if>">&gt;&gt;</a></li>
                </ul>
            </div>
        </div>



</div><!--container结束-->

<%@include file="../index_component/bottom.jsp"%>
</body>
</html>
