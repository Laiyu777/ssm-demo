<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/5/27
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台管理系统</title>
   <%@include file="../back_component/import.jsp"%>
    <!-- summernote编辑器 -->
    <link rel="stylesheet" href="${contextPath}/static/css/summernote.css">
    <script src="${contextPath}/static/js/summernote.js"></script>
    <script src="${contextPath}/static/js/summernote-zh-CN.js"></script>

</head>
<body>
<div class="container-fluid">
    <%@include file="../back_component/top.jsp"%>

    <div class="row">
        <%@include file="../back_component/menu.jsp"%>


        <div class="col-md-10" style="margin-top: 82px;">
            <div class="page-header">
                <h3>发布新闻<small>Publish News</small></h3>
            </div>
            <div class="news-body">
                <form action="/user/news/publishNews" class="form-horizontal" enctype="multipart/form-data" method="post" id="news_form">
                    <div class="form-group form-group-lg">
                        <label for="" class="col-md-2 control-label">新闻标题</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="title" required>
                        </div>
                    </div>
                    <div class="form-group form-group-lg">
                        <label for="" class="col-md-2 control-label">新闻分类</label>
                        <div class="col-md-2">
                            <select class="form-control"  id="menu_select" name="menuId">
                                <c:forEach items="${requestScope.menuList}" var="menu">
                                    <option value="${menu.menuId}">${menu.menuName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-control" name="submenu.submenuId" id="submenu_select"></select>
                        </div>
                    </div>
                    <div class="form-group form-group-lg">
                        <label for="" class="col-md-2 control-label">浏览权限</label>
                        <div class="col-md-4">
                            <select class="form-control" name="checkAuth">
                                <option value="0">不需要登录查看</option>
                                <option value="1">需要登录查看</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group form-group-lg">
                        <label for="" class="col-md-2 control-label" style="white-space: nowrap">新闻内容</label>
                        <div class="col-md-10" style="width: 83.3%;">
                            <textarea  name="content" id="news-edit" cols="30" rows="10" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="form-group form-group-lg">
                        <label for="" class="col-md-2 control-label">选择文件</label>
                        <div class="col-md-4">
                            <input multiple  name="files" type="file" class="hide-input form-control" style="border:0;-webkit-box-shadow: 0 0 0 0 #fff;box-shadow: 0 0 0 0 #fff;">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-1 col-md-10">
                            <button class="btn btn-default btn-lg">发布</button>
                            <button class="btn btn-default btn-lg">取消</button>
                        </div>
                    </div>
                </form>
            </div><!--news-body结束-->

        </div><!--col-md-10结束-->
    </div><!--下半部分row的结束-->




</div><!--container-fluid结束-->







<script type="text/javascript">
    $(document).ready(function(){

        //处理图片上传
        function processImageUpload(files){
            var data = new FormData();
            $(files).each(function(index,file){
                data.append("files",file);
            })
            $.ajax({
                url:"/user/news/uploadNewsImage",
                method:"post",
                data:data,
                processData:false,
                contentType:false,
                cache:false,
                success:function (result) {
                   for(var i = 0;i<result.length;i++){
                       var file = result[i];
                       $("#news-edit").summernote('insertImage',file['file'+i]);
                   }
                }
            });
        }

        $('#news-edit').summernote({
            placeholder: '请在这里输入新闻内容',
            tabsize: 2,
            height: 100,
            lang:"zh-CN",
            minHeight:600,
            dialogsFade:true,
            dialogsInBody:true,
            callbacks:{
                onImageUpload:function(files){
                    processImageUpload(files);
                }
            }
        });
    });

    //选中当前菜单选项
    $("#manage_news_ul").css("display","block");
    $("#manage_news_ul > li:nth-child(1)  a").addClass("menu-selected");

    //为submenu子菜单填充内容
    var menus = ${requestScope.menuList};

    //最开始的时候默认显示第一个
    var menu = menus[0];
    $(menu.subMenuNames).each(function(index,obj){
        var option = $("<option></option>");
        option.attr("value",obj.submenuId);
        option.append(obj.submenuName);
        $("#submenu_select").append(option);
    });
    //加载相关的子菜单
    $("#menu_select").change(function(){
        $("#submenu_select").empty();
        var index = parseInt($(this).val());
        var menu = menus[index-1];
        $(menu.subMenuNames).each(function(index,obj){
            var option = $("<option></option>");
            option.attr("value",obj.submenuId);
            option.append(obj.submenuName);
            $("#submenu_select").append(option);
        })
    });

    //表单提交的时候
    $("#news_form").submit(function(){
        var $textarea = $("#news-edit");
        console.log("=="+$textarea)
        if($textarea.val()==""){
            alert("新闻内容不能为空");
            return false;
        }
        var data = new FormData(this);
        $.ajax({
            url:"/user/news/publishNews",
            method:"post",
            data:data,
            processData:false,
            contentType:false,
            success:function(result){
                alert(result.info);
                if(result.code == 200){
                    location.href = "/user/news/manageNews";
                    window.open("/newsDetail?news_id="+result.info.substr(11));
                }else{
                    //location.href = "/user/news/publishNews";
                }
            },
            error:function(result){
                alert("服务器出了点小问题，请稍后再试");
            }
        });
        return false;
    });

</script>
</body>
</html>
