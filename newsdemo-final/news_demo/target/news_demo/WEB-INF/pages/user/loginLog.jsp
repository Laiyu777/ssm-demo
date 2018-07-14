<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<html>
<head>
    <title>用户信息</title>
    <%@include file="../back_component/import.jsp"%>
</head>
<body>
<div class="container-fluid">
    <%@include file="../back_component/top.jsp"%>
    <div class="row">
        <%@include file="../back_component/menu.jsp"%>

        <div class="col-md-10" style="margin-top: 82px;">
            <div class="page-header">
                <h3>登录日志 <small>Login Log</small></h3>
            </div>

            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    <style>
                        table{vertical-align: middle}
                        table>thead th{text-align: center}

                    </style>
                    <table class="table table-striped text-center table-hover">
                       <thead>
                           <tr>
                               <th>序号</th>
                               <th>登录时间</th>
                               <th>IP</th>
                               <th>登录结果</th>
                           </tr>
                       </thead>
                        <tbody>
                           <c:forEach items="${requestScope.pageInfo.list}" varStatus="calc" var="loginLog">
                               <tr>
                                   <td>${(requestScope.pageInfo.pageNum-1) * 10 + calc.count}</td>
                                   <td>${loginLog.loginTime}</td>
                                   <td>${loginLog.ipAddress}</td>
                                   <td>${loginLog.result}</td>
                               </tr>
                           </c:forEach>
                        </tbody>
                    </table>
                    <style>

                    </style>
                    <div class="center-block" style="width: 700px;">
                        <nav aria-label="Page navigation">
                            <ul class="pagination pagination-lg">
                                <li>
                                    <a href="/user/loginLog?pageNumber=${requestScope.pageInfo.prePage}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach items="${requestScope.pageInfo.navigatepageNums}"  var="num">
                                    <li <c:if test="${requestScope.pageInfo.pageNum == num}">class="active"</c:if>>
                                        <a href="/user/loginLog?pageNumber=${num}">${num}</a>
                                    </li>
                                </c:forEach>
                                <li>
                                    <a href="/user/loginLog?pageNumber=${requestScope.pageInfo.pageNum+1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

    </div><!--row结束-->



    

</div>


<script>
    $("#modify_user_form").submit(function () {
        var data = $(this).serialize();
        console.log(data);
        $.ajax({
            url: $(this).attr("action"),
            type: "post",
            data:data,
            success:function (result) {
                alert(result.info);
                $("#modify_info").modal("hide");
                location.href = "userInfo";
            },
            error:function(){
                alert("服务器繁忙，请稍后再试")
            }
        });
        return false;
    });

    //改变选中菜单
    $("#user_info_ul").css("display","block");
    $("#user_info_ul > li:nth-child(3)  a").addClass("menu-selected");
//    $(".aside > ul > li:nth-child(1) > a > span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
</script>
</body>
</html>
