<%@ page import="Help.Utils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/1
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<%
    String contextPath = request.getContextPath();
    request.setAttribute("contextPath",contextPath);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>排班留守</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/static/css/bootstrap.css">
    <script type="text/javascript" src="${contextPath}/static/js/jquery1.12.4.min.js"></script>
    <script type="text/javascript" src="${contentPath}/static/js/bootstrap.js"></script>
</head>
<body>
<div class="container" /*style="background: red;"*/>
<div class="jumbotron">
    <h3>六四一留守值班</h3>
</div><!--jumbotron结束-->
<div class="row">
    <div class="col-md-2" style="width:22%;">
        <a class="btn btn-default" href="/moreStay">按周显示</a>
        <a class="btn btn-default" href="/moreStay?show=month&monthOffset=0">按月显示</a>
    </div>
    <div class="col-md-2" style="width:20%;">
        <a class="btn btn-default" href="/moreStay?weekOffset=${requestScope.weekOffsetPre}">上一周</a>
        <a class="btn btn-default" href="/moreStay">本周</a>
        <a class="btn btn-default" href="/moreStay?weekOffset=${requestScope.weekOffsetNext}">下一周</a>
    </div>
    <div class="col-md-2" style="width:20%;">
        <a class="btn btn-default" href="/moreStay?show=month&monthOffset=${requestScope.monthOffsetPre}">上个月</a>
        <a class="btn btn-default" href="/moreStay?show=month&monthOffset=0">本月</a>
        <a class="btn btn-default" href="/moreStay?show=month&monthOffset=${requestScope.monthOffsetNext}">下个月</a>
    </div>
    <div class="col-md-2" style="width:16%;">
        <c:set var="href"/>
        <select class="form-control" name="deptName" onchange="showByDept(this.value)">
            <option>按部门显示</option>
            <%--<option value="/moreStay">全部</option>--%>
            <%--<option value="/moreStay?deptName=台领导<c:if test="${requestScope.show!=null}">&show=month&monthOffset=0</c:if>">台领导</option>--%>
            <%--<option value="/moreStay?deptName=维修室<c:if test="${requestScope.show!=null}">&show=month&monthOffset=0</c:if>">维修室</option>--%>
            <%--<option value="/moreStay?deptName=行政科<c:if test="${requestScope.show!=null}">&show=month&monthOffset=0</c:if>">行政科</option>--%>
            <%--<option value="/moreStay?deptName=台办室<c:if test="${requestScope.show!=null}">&show=month&monthOffset=0</c:if>">台办室</option>--%>
            <option value="all">显示全部</option>
            <option value="台领导">台领导</option>
            <option value="维修室">维修室</option>
            <option value="行政科">行政科</option>
            <option value="台办室">台办室</option>
        </select>
        <a class="btn btn-default" href="javascript:void(0)" style="display: none" return>返回</a>
    </div>
    <div class="col-md-2" style="width:20%;">
        <div class="input-group" id="input_group">
            <input type="text" class="form-control" placeholder="请输入留守人的名字" id="name_input">
            <span class="input-group-btn">
					<button id="searchBtn" class="btn btn-default">搜索</button>
            </span>
        </div>
        <a class="btn btn-default" href="javascript:void(0)" style="display: none" return>返回</a>
    </div>
</div><!--row结束-->

<br>


<div class="row">
    <c:forEach var="map" items="${requestScope.stayWeekMap}">
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span>${map.key}</span>
                    <span style="padding-left: 10px;">星期一</span>
                </div>
                <div class="panel-body">
                    <p>白天:</p>
                    <p>
                        <c:forEach items="${map.value}" var="info">
                            <c:forEach var="emp" items="${info.dayEmps}">
                                <a deptName=${emp.deptName} tabindex="0" class="btn btn-sm btn-default" role="button" data-toggle="popover" data-trigger="focus" data-placement="top"  title="详细信息" data-content="姓名:${emp.name} <br>电话:${emp.tel}888888<br>宿舍:${emp.dorm}<br>科室：${emp.deptName}">${emp.name}</a>
                            </c:forEach>
                        </c:forEach>
                    </p>
                    <p>晚上:</p>
                    <p>
                        <c:forEach items="${map.value}" var="info">
                            <c:forEach var="emp" items="${info.nightEmps}">
                                <a deptName=${emp.deptName} tabindex="0" class="btn btn-sm btn-default" role="button" data-toggle="popover" data-trigger="focus" data-placement="top"  title="详细信息" data-content="姓名:${emp.name} <br>电话:${emp.tel}888888<br>宿舍:${emp.dorm}<br>科室：${emp.deptName}">${emp.name}</a>
                            </c:forEach>
                        </c:forEach>
                    </p>
                </div>
            </div>
        </div>
    </c:forEach>






</div>
</div>
</div><!--container结束-->

<script>
    $(function(){
        $('[data-toggle="popover"]').popover({
            html : true
        })
    });

    function showByDept(value){
        if(value == "all"){
            location.reload();
            return;
        }
        $(".col-md-3 a").each(function (index,obj) {
            var deptName = $(obj).attr("deptName");
            if(deptName != value){
                $(obj).hide();
            }
            $("select[name=deptName]").hide();
            $("a[return]:eq(0)").show();
        });
    }

    $("a[return]").click(function(){
        location.reload();
    });

    $("#searchBtn").click(function(){
        var name = $("#name_input").val();
        if(name == ''){
            location.reload();
        }else{
            $(".col-md-3 a").each(function (index,obj) {
                var aName = $(obj).html();
                console.log(aName)
                if(aName.indexOf(name)<0){
                    $(obj).hide();
                }
            });
            $("a[return]:eq(1)").show();
            $("#input_group").hide();
        }
    });

    //判断是星期几的
    var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    $.each($(".panel-heading"),function (i,obj) {
        var dateStr =$(obj).find("span:eq(0)").html();
        var date = new Date(dateStr);
        $(obj).find("span:eq(1)").html(weekDay[date.getDay()]);
        if(date.toDateString()==new Date().toDateString()){
            $(obj).parent().removeClass("panel-default").addClass("panel-primary");
        }
    });


</script>

</body>
</html>