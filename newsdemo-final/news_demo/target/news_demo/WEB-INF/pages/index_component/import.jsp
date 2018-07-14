<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String contextPath = request.getContextPath();
    request.setAttribute("contextPath",contextPath);
%>
<script type="text/javascript" src="${contextPath}/static/js/jquery1.12.4.min.js"></script>

<!-- 主页相关的内容 -->
<link rel="stylesheet" type="text/css" href="${contextPath}/static/css/index.css">
