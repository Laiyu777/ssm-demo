<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<div class="col-md-2" style="padding:0">
    <div class="aside" id="aside">
        <ul style="margin-top: 2px">
            <li>
                <a href="javascript:void(0)">个人信息
                    <span class="glyphicon glyphicon-user"></span>
                </a>
                <ul id="user_info_ul">
                    <li><a href="/user/userInfo">个人信息</a></li>
                    <li><a href="/user/updatePassword">修改密码</a></li>
                    <li><a href="/user/loginLog">登录日志</a></li>
                </ul>
            </li>
            <c:if test="${sessionScope.user.role.roleId==0}">
                <li>
                    <a href="javascript:void(0)">用户管理
                        <span class="glyphicon glyphicon-cog"></span>
                    </a>
                    <ul id="manage_user_ul">
                        <li><a href="/admin/manageUser/userList">用户列表</a></li>
                        <li><a href="/admin/manageUser/addUser">添加用户</a></li>
                    </ul>
                </li>
            </c:if>
            <c:if test="${sessionScope.user.role.roleId == 0 or sessionScope.user.role.roleId == 1}">
                <li>
                    <a href="javascript:void(0)">新闻管理
                        <span class="glyphicon glyphicon-list-alt"></span>
                    </a>
                    <ul id="manage_news_ul">
                        <li><a href="/user/news/publishNews">发布新闻</a></li>
                        <li><a href="/user/news/manageNews">管理新闻</a></li>
                <c:if test="${sessionScope.user.role.roleId ==0 }">
                        <li><a href="/user/news/manageColumns">栏目管理</a></li>
                </c:if>
                    </ul>
                </li>
            </c:if>
        <c:if test="${sessionScope.user.role.roleId == 0 or sessionScope.user.role.roleId == 1}">
            <li>
                <a href="/user/stay/manageStay">排班留守
                <span class="glyphicon glyphicon-time"></span>
                </a>
            </li>
        </c:if>
            <li>
                <a href="#">功能2</a>
            </li>
            <li>
                <a href="#">功能3</a>
            </li>
            <li>
                <a href="#">功能4</a>
                <ul>
                    <li><a href="#">子功能4-1</a></li>
                    <li><a href="#">子功能4-2</a></li>
                    <li><a href="#">子功能4-3</a></li>
                    <li><a href="#">子功能4-4</a></li>
                </ul>
            </li>
            <li>
                <a href="#">功能5</a>
            </li>
            <li>
                <a href="#">功能6</a>
            </li>
        </ul>
    </div>
</div>


<div class="left-arrow" id="leftArrow"></div>

<script>
    var i = 0 ;
    $(".aside>ul>li>a").click(function(){
        $($(this).next()[0]).toggle(500);
//        //交换上下图标
//        var $icon = $($(this).children().get(0));
//        if(i==0){
//            $icon.removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
//            i = 1;
//        }else{
//            $icon.removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
//            i = 0;
//        }
    });

    //处理左侧菜单按钮
    var flag = 0;
    $("#leftArrow").click(function () {
        if(flag == 0){
            $(".aside").removeClass("left-229").addClass("left0");
            $(this).removeClass("left0").addClass("left229").removeClass("rotate360").addClass("rotate180");
            flag = 1;
        }else{
            $(".aside").removeClass("left0").addClass("left-229");
            $(this).removeClass("left229").addClass("left0").removeClass("rotate180").addClass("rotate360");
            flag = 0;
        }
    });
    //检测屏幕大小，然后清除Class
    $(window).resize(function () {
        //console.log($(document).width());
        var width = $(document).width();
        if(width > 1300){
            $(".aside").removeClass("left-229").removeClass("left0");
            $("#leftArrow").removeClass("left229").removeClass("left0").removeClass("rotate180").removeClass("rotate360");
            flag = 0;
        }
    });



</script>