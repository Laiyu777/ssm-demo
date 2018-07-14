<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<html>
<head>
    <title>栏目管理</title>
    <%@include file="../back_component/import.jsp"%>
</head>
<body>
<div class="container-fluid">
    <%@include file="../back_component/top.jsp"%>
    <div class="row">
        <%@include file="../back_component/menu.jsp"%>

        <div class="col-md-10" style="padding-top: 82px;">
            <div class="page-header">
                <h3>栏目管理 <small>Manage Columns</small></h3>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <form class="form-horizontal" id="columns_form">
                        <div class="row" style="padding-left:5%">
                            <c:forEach var="menu" items="${requestScope.menus}">
                                <div class="col-md-1" style="width: 150px;" col="${menu.menuId}">
                                    <input required menuName class="form-control" value="${menu.menuName}" style="display: inline-block;width: 93px;border-bottom: 2px solid #CE0000">
                                    <button type="button" onclick="modifyMenuName(this)" class="btn btn-default" style="padding: 9px 3px;" menuId=${menu.menuId}>
                                        <span class="glyphicon glyphicon-pencil"></span>
                                    </button>
                                    <c:forEach items="${menu.subMenuNames}" var="submenu">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <input required class="form-control" value="${submenu.submenuName}" style="width: 85px;" submenuName>
                                            </div>
                                            <div class="col-md-4" style="padding-left:0px;padding-right: 0px;">
                                                <button type="button" class="btn btn-default" style="padding: 9px 3px;" confirm_edit_btn submenuId=${submenu.submenuId}>
                                                    <span class="glyphicon glyphicon-pencil"></span>
                                                </button>
                                                <button type="button" class="btn btn-default" style="padding: 9px 3px;" sub submenuId=${submenu.submenuId}>
                                                    <span class="glyphicon glyphicon-remove-sign"></span>
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <button menuId=${menu.menuId}  type="button" class="btn btn-default" style="padding: 9px 3px;width:133px;margin-top: 5px;border: 1px solid #CE002B" add>添加子栏目</button>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="row" style="height: 2px;background-color: #CE0000;margin:5px;"></div>
                        <div class="row">
                            <div class="col-md-10 col-md-offset-2">

                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div><!--row结束-->



<br><br><br>
</div><!--container-fluid结束-->

<%--添加子菜单的模态框--%>
<div class="modal fade" id="addSubmenuModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog" role="document" style="margin-top: 100px;width:650px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加子菜单</h4>
            </div>
            <div class="modal-body">

                    <div class="form-group">
                        <label class="col-md-3 control-label">子菜单</label>
                        <div class="col-md-5">
                            <input required class="form-control" placeholder="请输入子菜单名字" name="submenuName">
                        </div>
                    </div>

                    <input type="hidden" name="menuId">

                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary">添加</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>

            </div>
        </div>
    </div>
</div>

<script>
    //选中当前菜单选项
    $("#manage_news_ul").css("display","block");
    $("#manage_news_ul > li:nth-child(3)  a").addClass("menu-selected");

    // 弹出模态框增加一个子模块         （之前点击加号添加子菜单）
    $("div[class=col-md-1]").on('click','button[add]',function () {
        <%--var html = $("<div class='row'>" +
            "<div class='col-md-8'>" +
            "<input required submenuName class='form-control'  style='width: 85px;'>" +
            "</div>" +
            "<div class='col-md-4' style='padding-left:0px;padding-right: 0px;'>" +
            "<button type='button' class='btn btn-default' style='padding: 9px 3px;' add> " +
            "<span class='glyphicon glyphicon-pencil'></span></button>" +
            "<button type='button' class='btn btn-default' style='padding: 9px 3px;margin-left: 4px;' sub> " +
            "<span class='glyphicon glyphicon-remove-sign'></span>" +
            "</button>" +
            "</div>" +
            "</div>");
        $(this).before(html);--%>
        var menuId = $(this).attr("menuId");
        $("#addSubmenuModal input:eq(1)").val(menuId );
        $("#addSubmenuModal").modal();
    })
    //点击 pencil按钮 提交数据到服务器 修改菜单
    $("div[class=col-md-1]").on('click','button[confirm_edit_btn]',function (){
        var val = $(this).parent().prev().find("input").val();
        var submenuId = $(this).attr('submenuId');
        $.ajax({
            url:"/user/news/modifySubmenu",
            method:"post",
            data:"submenuName="+val+"&submenuId="+submenuId,
            success:function (result) {
                alert(result.info);
                location.href="manageColumns";
            }
        });
    })

    //点减号删除子菜单
    $("div[class=col-md-1]").on('click','button[sub]',function () {
        var submenuId = $(this).attr('submenuId');
        $.ajax({
            url:"/user/news/delSubmenu",
            method:"post",
            data:"submenuId="+submenuId,
            success:function (result) {
                alert(result.info);
                location.href="manageColumns";
            }
        });
    });

    //处理submenuId的变量
    var submenuId = 1;
    function prepareData(){
        var data = [];
        $("div[col]").each(function(index,ele){
            var menu = new Object();
            var menuName = $(ele).find("input[menuName]").val();
            menu.menuName = menuName;
            menu.menuId = $(this).attr('col');

            var menuNames = [];
            $(ele).find("input[submenuName]").each(function(index,obj){
                var subMenu = new Object();
                subMenu.submenuId = submenuId;
                submenuId++;
                subMenu.submenuName = $(obj).val();
                subMenu.menuId = menu.menuId;
                menuNames.push(subMenu);
            });
            menu.subMenuNames = menuNames;
            data.push(menu);
        });
        return data;
    }
    //console.log(data);


    //整个表单提交的时候获取数据
    <%--$("#columns_form").submit(function(){
        $.ajax({
            url:"/user/news/manageColumns",
            method:"post",
            data:JSON.stringify(prepareData()),
            headers:{'Content-Type':'application/json;charset=utf-8'},
            success:function(result){
                submenuId = 1;
                alert(result.info);
                //location.href = "/user/news/manageColumns";
            },
            error:function(result){
                alert(result.info);
            }
        });
        return false;
    });--%>

    //修改主菜单的名字
    function modifyMenuName(obj){
        var menuId = $(obj).attr("menuId");
        var menuName = $(obj).prev().val();
        $.ajax({
            url:"/user/news/modifyMenuName",
            method:"post",
            data:"menuId="+menuId+"&menuName="+menuName,
            success:function (result) {
                alert(result.info);
                location.href="manageColumns";
            }
        });
    }
</script>
</body>
</html>
