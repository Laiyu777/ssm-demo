<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/13
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/2
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>管理新闻</title>
    <%@include file="../back_component/import.jsp"%>
    <%--时间插件--%>
    <link rel="stylesheet" href="${path}/static/css/bootstrap-datetimepicker.min.css">
    <script src="${path}/static/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${path}/static/js/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
<body>
<div class="container-fluid">
    <%@include file="../back_component/top.jsp"%>
    <div class="row">
        <%@include file="../back_component/menu.jsp"%>

        <div class="col-md-10" style="margin-top: 82px;">
            <div class="page-header">
                <h3>新闻管理 <small>Manager News</small></h3>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <form class="form-inline" method="get" action="/user/news/searchNewsByKeyword">
                        <div class="form-group">
                            <div class="input-group">
                                <input name="keyword" type="text" class="form-control" placeholder="请输入新闻关键字">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit">搜索</button>
                                </span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-2">
                    <select class="form-control" onchange="location.href = this.value">
                        <option>按状态选择</option>
                        <option value="/user/news/searchNewsByStatus?status=0">待审核</option>
                        <option value="/user/news/searchNewsByStatus?status=1">已锁定</option>
                        <option value="/user/news/searchNewsByStatus?status=2">审核未通过</option>
                    </select>
                </div>
                <c:if test="${sessionScope.user.role.roleId == 0}">
                    <button class="btn btn-default" type="button" style="margin-left: 50px;" data-toggle="modal" data-target="#checkModal">高级</button>
                </c:if>
                <a class="btn btn-default" href="/user/news/manageNews" style="background-color:#fff;color:#000">显示全部</a>
            </div>


            <%--新闻数据表格--%>
            <br>
            <div class="row">
                <div class="col-md-12">
                    <style>
                        table{vertical-align: middle}
                        table>thead th{text-align: center}
                        table td[check]:hover{
                            background-color: #CE002B;
                            color:#ffffff !important;
                            cursor: pointer;
                        }
                        table thead tr th{
                            white-space: nowrap;
                        }
                        .table > tbody > tr > td{
                            vertical-align: middle;
                            max-width:600px;
                        }
                    </style>
                    <table class="table table-striped text-center table-hover">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>新闻编号</th>
                            <th>发布人</th>
                            <th>新闻标题</th>
                            <th>发布时间</th>
                            <th>最后修改时间</th>
                            <th>状态</th>
                            <th>#</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.pageInfo.list}" varStatus="calc" var="news">
                            <tr>
                                <td>${(requestScope.pageInfo.pageNum-1) * 10 + calc.count}</td>
                                <td>${news.id}</td>
                                <td>${news.user.realName}</td>
                                <td>${news.title}</td>
                                <td><fmt:formatDate value="${news.createTime}" pattern="yyyy年MM月dd日 hh时mm分"></fmt:formatDate> </td>
                                <td><fmt:formatDate value="${news.lastTime}" pattern="yyyy年MM月dd日 hh时mm分"></fmt:formatDate></td>
                                <td check="${news.id}" status="${news.status}" style="white-space: nowrap">
                                    <c:if test="${news.status == 0}">
                                        <span>待审核</span>
                                    </c:if>
                                    <c:if test="${news.status == 1}">
                                        <span class="text-danger">被锁定</span>
                                    </c:if>
                                    <c:if test="${news.status == 2}">
                                        <span>审核不通过</span>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="javascript:void(0)" onclick="window.open('/newsDetail?news_id=${news.id}')" class="btn btn-default">预览</a>
                                    <a href="javascript:void(0)" onclick="window.open('/user/news/modifyNews?news_id=${news.id}')" class="btn btn-default" username="${user.username}"
                                             <c:if test="${news.status == 1 and sessionScope.user.role.roleId == 1}">disabled</c:if>>编辑</a>
                                    <a del="${news.title}"  href="/user/news/deleteNews?news_id=${news.id}" class="btn btn-default">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="center-block" style="width: 700px;">
                        <nav aria-label="Page navigation">
                            <ul class="pagination pagination-lg">
                                <li>
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach items="${requestScope.pageInfo.navigatepageNums}"  var="num">
                                    <li <c:if test="${requestScope.pageInfo.pageNum == num}">class="active"</c:if>>
                                        <a href="/user/news/manageNews?pageNum=${num}">${num}</a>
                                    </li>
                                </c:forEach>
                                <li>
                                    <a href="#" aria-label="Next">
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

    <%--审核文章模态框--%>
    <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="padding-top: 100px;">
            <form class="form-horizontal" id="statusForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">审核新闻</h4>
                </div>
                <div class="modal-body">
                        <div class="form-group form-group-lg">
                            <label class="col-md-3 control-label">编号</label>
                            <div class="col-md-5">
                                <p class="form-control-static" id></p>
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-3 control-label">文章标题</label>
                            <div class="col-md-9">
                                <p class="form-control-static" title></p>
                            </div>
                        </div>
                        <div class="form-group form-group-lg">
                            <label class="col-md-3 control-label">审核状态</label>
                            <div class="col-md-5">
                                <select class="form-control" id="statusSelect" name="status">
                                    <option value="0">待审核</option>
                                    <option value="1">锁定</option>
                                    <option value="2">审核不通过</option>
                                </select>
                            </div>
                        </div>
                </div>
                <div class="modal-footer">
                    <button  class="btn btn-primary">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
            </form>
        </div>
    </div>

    <%--高级检索模态框--%>
    <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="padding-top: 100px;">
            <form class="form-horizontal" id="checkForm" method="post" action="/user/news/advancedSearchNews">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">高级检索</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label">新闻关键字</label>
                            <div class="col-md-5">
                                <input class="form-control" type="text" name="newsKeyword" placeholder="请输入新闻关键字(内容或标题)">
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-md-3 control-label">发布部门</label>
                            <div class="col-md-5">
                                <input class="form-control" type="text" name="userKeyword" placeholder="请输入发布部门">
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-md-3 control-label">新闻状态</label>
                            <div class="col-md-5">
                                <select class="form-control"  name="status">
                                    <option value="">全部</option>
                                    <option value="0">待审核</option>
                                    <option value="1">锁定</option>
                                    <option value="2">审核不通过</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-md-3 control-label">发布时间</label>
                            <div class="col-md-4">
                                <input id="from_date_input" class="form-control" type="text" name="fromDate" readonly placeholder="点击选择起始时间">
                            </div>
                            <div class="col-md-4">
                                <input id="to_date_input" class="form-control" type="text" name="toDate" readonly placeholder="点击选择结束时间">
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-md-3 control-label">新闻类别</label>
                            <div class="col-md-4">
                                <select class="form-control"  name="menuId" id="menu_select">
                                    <option value="">全部</option>
                                    <c:forEach items="${sessionScope.menuList}" var="menu">
                                        <option value="${menu.menuId}">${menu.menuName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select class="form-control"  name="submenuId" id="submenu_select">
                                    <option value="">全部</option>
                                    <%--jq填充--%>
                                </select>
                            </div>
                            <script type="text/javascript">
                                var menus = ${requestScope.menuList};
                                //加载相关的子菜单
                                $("#menu_select").change(function(){
                                    var value = $(this).val();
                                    if(value == ""){//如果选择全部的主菜单
                                        $("#submenu_select").empty();
                                        $("#submenu_select").append("<option value=''>全部</option>");
                                    }else{
                                        $("#submenu_select").empty();
                                        var index = parseInt($(this).val());
                                        var menu = menus[index-1];
                                        $("#submenu_select").append("<option value=''>全部</option>");
                                        $(menu.subMenuNames).each(function(index,obj){
                                            var option = $("<option></option>");
                                            option.attr("value",obj.submenuId);
                                            option.append(obj.submenuName);
                                            $("#submenu_select").append(option);
                                        })
                                    }
                                });
                            </script>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button  class="btn btn-primary">确定</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </form>
        </div>
    </div>



</div><!--container-fluid结束-->


<script>

    //处理毫秒时间
    function processTime(milliseconds){
        var date = new Date(milliseconds);
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var seconds = date.getSeconds();
        return year+"年"+month+"月"+day+"日"+" "+hour+"时"+minute+"分"+seconds+"秒"
    }




    //选中当前菜单选项
    $("#manage_news_ul").css("display","block");
    $("#manage_news_ul > li:nth-child(2)  a").addClass("menu-selected");
    //删除按钮
    $("a[del]").click(function(){
        if(confirm("确认删除  ["+$(this).attr("del")+"]  吗？")){
            $.get($(this).attr('href'));
            location.href = "/user/news/manageNews";
        }
        return false;
    });

    //审核部分的处理
    var $check = $("td[check]");
    var $currentNode = null;
    var statusText = null;
    $check.click(function () {
        $currentNode = $(this);
        var status = $(this).attr("status");
        var id = $(this).attr("check");
        var title = $(this).parent().find('td:eq(3)').html();
        $("#statusForm").find("p[id]").html(id);
        $("#statusForm").find("p[title]").html(title);
        //选中当前的状态
        $("#statusSelect option").each(function(index,obj){
            if($(obj).attr("value")==status){
                $(obj).attr("selected","selected");
            }
        });
        $("#statusModal").modal();
    });

    //状态选择变动的时候
    $("#statusSelect").change(function(){
        statusText = $(this).find('option:selected').text();
    });


    //状态模态框表单的提交
    $("#statusForm").submit(function(){
        var data = new FormData(this);
        var id = $(this).find("p[id]").html();
        //console.log("=="+id);
        data.append("id",id);
        $.ajax({
            url:"/user/news/updateNewStatus",
            data:data,
            method:"post",
            processData:false,
            contentType:false,
            cache:false,
            success:function(result){
                console.log("=="+$currentNode.html())
                console.log("=="+statusText);
                $("#statusModal").modal('hide');
                if(statusText == '锁定'){
                    $currentNode.html("<span class='text-danger'>被锁定</span>");
                }else{
                    $currentNode.html("<span >"+statusText+"</span>")
                }

            },
            error:function(result){
                alert("服务器出了点小问题，请稍后再试");
                $("#statusModal").modal('hide');
            }
        });
        return false;
    });

    //日期框的处理
    $("#from_date_input").datetimepicker({
        format: "yyyy-mm-dd",
        autoclose: true,
        todayBtn: true,
        language:'zh-CN',
        pickerPosition:"bottom-left",
        minView:2
    });
    $("#to_date_input").datetimepicker({
        format: "yyyy-mm-dd",
        autoclose: true,
        todayBtn: true,
        language:'zh-CN',
        pickerPosition:"bottom-left",
        minView:2
    });
</script>
</body>
</html>

