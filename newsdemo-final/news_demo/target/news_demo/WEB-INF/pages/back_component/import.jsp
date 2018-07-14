<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>


<%
    String contextPath = request.getContextPath();
    request.setAttribute("contextPath",contextPath);
%>
<script type="text/javascript" src="${contextPath}/static/js/jquery1.12.4.min.js"></script>
<!-- bootstrap -->
<link rel="stylesheet" href="${contextPath}/static/css/bootstrap.css">
<script type="text/javascript" src="${contextPath}/static/js/bootstrap.js"></script>
<!-- summernote编辑器 -->
<%--<link rel="stylesheet" href="${contextPath}/static/css/summernote.css">--%>
<%--<script src="${contextPath}/static/js/summernote.js"></script>--%>
<%--<script src="${contextPath}/static/js/summernote-zh-CN.js"></script>--%>
<!-- 自带admin.css -->
<link rel="stylesheet" type="text/css" href="${contextPath}/static/css/admin.css">