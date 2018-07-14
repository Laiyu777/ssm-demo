<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/12
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>新闻详情</title>
    <%@include file="../index_component/import.jsp"%>
    <link >
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
                .position{
                    /*background: orange;*/
                    margin-top: 17px;
                    margin-bottom: 20px;
                    padding-bottom: 10px;
                    border-bottom: 3px solid #F4F4F4;
                }
                .sep-line::before{
                    content: ">>";
                    color:#CE002B;
                }
                .position a:link,.position a:visited{
                    text-decoration: none;
                    color:#000;
                }
                .position a:hover{
                    background-color: #F4F4F4;
                    color:#CE002B;
                }
            </style>
        <div class="position">
            <span><a href="/index">首页</a></span>
            <%--<span class="sep-line"></span>--%>
            <%--<span>新闻详情</span>--%>
            <span class="sep-line"></span>
            <span><a href="/newsList?menuId=${requestScope._new.menuId}">${requestScope._new.menuName}</a></span>
            <span class="sep-line"></span>
            <span><a href="/newsList?submenuId=${requestScope._new.submenu.submenuId}">${requestScope._new.submenu.submenuName}</a></span>
            <span class="sep-line"></span>
            <span>${requestScope._new.title}</span>
            <span style="float: right"><a href="/index">返回首页</a></span>
        </div>

            <style>
                .news-table{
                    width: 100%;
                }
                .news-table td{

                }
            </style>
        <table cellspacing="15" style="text-align: center" class="news-table">
            <tr>
                <td>
                    <h1>${requestScope._new.title}</h1>
                </td>
            </tr>
            <tr>
                <td>
                    <span>发布部门：${requestScope._new.user.department.departmentName}</span>
                    <span style="margin-left: 35px;">发布时间：<fmt:formatDate value="${requestScope._new.createTime}" pattern="yyyy年MM月dd日 HH时mm分"></fmt:formatDate> </span>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <style>
                        p{
                            line-height: 40px !important;
                            text-indent: 2em !important;
                        }
                    </style>
                    ${requestScope._new.content}
                </td>
            </tr>
            <c:if test="${fn:length(requestScope._new.newFileList)>0}">
                <tr>
                    <td style="text-align: left">
                        相关文件:<br>
                        <c:forEach items="${requestScope._new.newFileList}" var="file">
                            <a href="/static/news_files/${file.fileName}">${file.fileName}</a><br>
                        </c:forEach>
                    </td>
                </tr>
            </c:if>

            <tr>
                <td>
                    <div style="border-bottom: 2px solid #F4F4F4;height: 20px;margin-bottom: 20px;"></div>
                </td>
            </tr>
        </table>


    </div>

<%@include file="../index_component/bottom.jsp"%>
</body>
</html>
