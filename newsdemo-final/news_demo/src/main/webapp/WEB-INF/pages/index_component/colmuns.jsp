<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/12
  Time: 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="nav">
    <c:forEach items="${sessionScope.menuList}" var="menu">
        <li>
            <a href="/newsList?menuId=${menu.menuId}">${menu.menuName}</a>
            <ul>
                <c:forEach items="${menu.subMenuNames}" var="submenu">
                    <li><a href="/newsList?submenuId=${submenu.submenuId}">${submenu.submenuName}</a></li>
                </c:forEach>
            </ul>
        </li>
    </c:forEach>
</div><!--nav结束-->
<script>
    /*菜单栏的显示*/
    $(".nav>li>a").on('mouseover',function(){
        $(this).next().css("display","block");
        $(this).css("color","#CE0000").css("background-color","#fff");
    });

    $(".nav>li>a").on('mouseout',function(){
        $(this).next().css("display","none");
        $(this).css("color","#fff").css("background-color","#CE0000");
    });

    $(".nav>li>ul").on('mouseover',function(e){
        $(this).prev().css("color","#CE0000").css("background-color","#fff");
        $(this).css("display","block");
    })

    $(".nav>li>ul").on('mouseout',function(e){
        $(this).css("display","none");
        $(this).prev().css("color","#fff").css("background-color","#CE0000");
    })
</script>