<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/29
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/7
  Time: 7:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>填写意见</title>

    <link rel="stylesheet" type="text/css" href="static/assets/css/amazeui.min.css">
    <script type="text/javascript" src="static/assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/assets/js/amazeui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="static/assets/css/admin.css">
</head>
<body>

<!--顶部页面-->
<%@include file="parts/top.jsp"%>

<div class="am-cf admin-main">
    <!--导航条-->
    <%@include file="parts/nav.jsp"%>
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">发送信息给管理员</strong> / <small>Fill Advice</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-9 am-u-md-centered">
                    <form action="sendMessage" class="am-form am-form-horizontal"  method="post"  data-am-validator>
                        <div class="am-form-group">
                            <label   class="am-u-sm-2 am-form-label">主题：</label>
                            <div class="am-u-sm-10">
                                <input type="text" name="theme" placeholder="请输入主题" required>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">内容：</label>
                            <div class="am-u-sm-10">
                                <textarea rows="20"   name="content" placeholder="请输入内容" required></textarea>
                            </div>
                        </div>


                        <div class="am-form-group">
                            <div class="am-u-sm-10 am-u-sm-offset-2">
                                <button type="submit" class="am-btn am-btn-primary">确认发送</button>
                                <button type="reset" class="am-btn am-btn-default">重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>


            <!--页脚-->
            <%@include file="parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->

<script type="text/javascript">
    $(function () {

    })
</script>
</body>
</html>

