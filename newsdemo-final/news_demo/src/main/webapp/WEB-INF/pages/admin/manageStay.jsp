<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/26
  Time: 0:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>留守管理</title>
    <%@include file="../back_component/import.jsp"%>
    <%--时间插件--%>
    <link rel="stylesheet" href="${path}/static/css/bootstrap-datetimepicker.min.css">
    <script src="${path}/static/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${path}/static/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${path}/static/js/select.js"></script>
    <link rel="stylesheet" href="${path}/static/css/select.css">
</head>
<body>
<div class="container-fluid">
    <%@include file="../back_component/top.jsp"%>
    <div class="row">
        <%@include file="../back_component/menu.jsp"%>
        <div class="col-md-10" style="margin-top: 82px;"><%--主体内容--%>
            <div class="page-header">
                <h3>排班留守 <small>Manage Stay</small></h3>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <button class="btn btn-default" data-toggle="modal" data-target="#addEmpModal">添加员工</button>
                    <button class="btn btn-default" data-toggle="modal" data-target="#delEmpModal">删除员工</button>
                </div>
            </div><br>

            <div class="panel panel-default">
                <div class="panel-heading"><h4>您部门当前拥有的员工<small>(点击可以编辑员工)</small></h4></div>
                <div class="panel-body">
                    <c:forEach items="${requestScope.empList}" var="emp">
                        <a class="btn btn-default" id=${emp.id} dorm=${emp.dorm} tel=${emp.tel} >${emp.name}</a>
                    </c:forEach>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <button class="btn btn-primary" data-toggle="modal" data-target="#addStayInfoModal">按天添加留守记录</button>
                    <button class="btn btn-primary" data-toggle="modal" data-target="#addStayInfoModalByMonth">按月添加留守记录</button>
                </div>
            </div><br>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>日期</th>
                        <th>白天</th>
                        <th>晚上</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.infoList}" var="info">
                    <tr>
                        <td>${info.date}</td>
                        <td>
                            <c:forEach items="${info.dayEmps}" var="emp">
                                <a class="btn btn-info">${emp.name}</a>
                            </c:forEach>

                        </td>
                        <td>
                            <c:forEach items="${info.nightEmps}" var="emp">
                                <a class="btn btn-info">${emp.name}</a>
                            </c:forEach>
                        </td>
                        <td>
                            <button class="btn btn-danger" editId=${info.id}>编辑</button>
                            <button class="btn btn-danger" delId=${info.id}>删除</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="row" aList>
               <c:forEach items="${requestScope.dateList}" var="date">
                   <div class="col-md-2" style="width:12%;">
                        <a  href="#" class="btn btn-default">${date}</a>
                   </div>
               </c:forEach>
            </div>

            <script>
                $("div[aList] a").each(function (index,obj) {
                    var str = $(obj).html();
                    var year = str.substr(0,4);
                    var month = str.substr(5,2);
                    month = year+"-"+month
                   $(obj).attr("href","/user/stay/manageStay?month="+ month)
                });
            </script>


<br><br>

        </div><%--主体内容--%>
    </div>
</div>


<!-- 添加留守信息的模态框(按天) -->
<div class="modal fade" id="addStayInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="margin-top: 100px;width:650px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="date">添加
                    <span style="color: #CE002B;">${sessionScope.user.department.departmentName}</span>
                    留守记录</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" action="/user/stay/addStayInfo">
                    <div class="form-group">
                        <label class="col-md-3 control-label">日期</label>
                        <div class="col-md-5">
                            <input class="form-control" id="date_input" placeholder="请选择日期 输入格式:*年*月*日"  name="dateStr" required>
                            <script>
                                $("#date_input").datetimepicker({
                                    format: "yyyy年mm月dd日",
                                    autoclose: true,
                                    todayBtn: true,
                                    language:'zh-CN',
                                    pickerPosition:"bottom-left",
                                    minView:2,
                                    //timepicker:false,
                                    startDate:"2000-01-01",
                                    endDate:"2050-01-01",
                                    weekStart:1,
                                });
                                //$("#date_input").datetimepicker('setEn')
                            </script>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">白天留守人员</label>
                            <div class="col-md-4" style="width:15%;margin-left: 0px;margin-right: 15px;padding-left: 0;padding-right: 0;">
                                <select  class="form-control" name="content1">
                                    <c:forEach items="${requestScope.empList}" var="emp">
                                        <option value="${emp.id}">${emp.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4" style="width:15%;margin-left: 0px;margin-right: 15px;padding-left: 0;padding-right: 0;">
                                <select class="form-control" name="content1">
                                    <c:forEach items="${requestScope.empList}" var="emp">
                                        <option value="${emp.id}">${emp.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button class="btn btn-default btn-sm"  type="button" addEmp1>+</button>
                            <button class="btn btn-default btn-sm"  type="button" subEmp1>-</button>
                        <script>
                            var subCount1 = 2;
                            $("button[addEmp1]").click(function(){
                                subCount1 ++;
                                var input = $(this).prev();
                                $(this).before(input.clone(true));
                            });
                            $("button[subEmp1]").click(function(){
                                if(subCount1==1){
                                    return;
                                }
                                subCount1--;
                                $(this).prev().prev().remove();
                            })
                        </script>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">晚上留守人员</label>
                        <div class="col-md-4" style="width:15%;margin-left: 0px;margin-right: 15px;padding-left: 0;padding-right: 0;">
                            <select  class="form-control"   name="content2">
                                <c:forEach items="${requestScope.empList}" var="emp">
                                    <option value="${emp.id}">${emp.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4" style="width:15%;margin-left: 0px;margin-right: 15px;padding-left: 0;padding-right: 0;">
                            <select  class="form-control"  name="content2">
                                <c:forEach items="${requestScope.empList}" var="emp">
                                    <option value="${emp.id}">${emp.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button class="btn btn-default btn-sm"  type="button" addEmp2>+</button>
                        <button class="btn btn-default btn-sm"  type="button" subEmp2>-</button>
                        <script>
                            var subCount2 = 2;
                            $("button[addEmp2]").click(function(){
                                subCount2 ++;
                                var input = $(this).prev();
                                $(this).before(input.clone(true));
                            });
                            $("button[subEmp2]").click(function(){
                                if(subCount2==1){
                                    return;
                                }
                                subCount2--;
                               $(this).prev().prev().remove();
                            })
                        </script>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">添加</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--添加员工的模态框--%>
<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="margin-top: 100px;width:650px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加
                    <span style="color: #CE002B;">${sessionScope.user.department.departmentName}</span>
                    员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" action="/user/stay/addEmp">
                    <div class="form-group">
                        <label class="col-md-3 control-label">姓名</label>
                        <div class="col-md-5">
                            <input required class="form-control" placeholder="请输入姓名" name="name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">电话</label>
                        <div class="col-md-5">
                            <input class="form-control" name="tel" placeholder="请输入电话" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">宿舍号</label>
                        <div class="col-md-5">
                            <input class="form-control" name="dorm" placeholder="请输入该员工的宿舍号" required>
                        </div>
                    </div>
                    <input type="hidden" name="deptName" value="${sessionScope.user.department.departmentName}">

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">添加</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--删除员工模态框--%>
<div class="modal fade" id="delEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="margin-top: 100px;width:650px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除
                    <span style="color: #CE002B;">${sessionScope.user.department.departmentName}</span>
                    员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" action="/user/stay/delEmp">
                    <div class="form-group">
                        <label class="col-md-3 control-label">请选择要删除的员工</label>
                        <div class="col-md-5">
                           <select name="id" class="form-control">
                               <c:forEach items="${requestScope.empList}" var="emp">
                                   <option value="${emp.id}">${emp.name}</option>
                               </c:forEach>
                           </select>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">确定</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--编辑模态框editStayInfoModal--%>
<div class="modal fade" id="editStayInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="margin-top: 100px;width:830px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑
                    <span style="color: #CE002B;" id="id_span"></span>
                    留守记录</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" action="/user/stay/editStayInfo">
                    <div class="form-group">
                        <label class="col-md-3 control-label">日期</label>
                        <div class="col-md-5">
                            <input id="date_edit_input" class="form-control"  placeholder="请选择日期 输入格式:*年*月*日"  name="date" required>
                            <script>
                                $("#date_edit_input").datetimepicker({
                                    format: "yyyy年mm月dd日",
                                    autoclose: true,
                                    todayBtn: true,
                                    language:'zh-CN',
                                    pickerPosition:"bottom-left",
                                    minView:2,
                                    //timepicker:false,
                                    startDate:"2000-01-01",
                                    endDate:"2050-01-01",
                                    weekStart:1,
                                });
                                //$("#date_input").datetimepicker('setEn')
                            </script>
                        </div>
                    </div>
                    <style>
                        #day_form_group div.col-md-4:nth-of-type(4n+5),
                        #night_form_group div.col-md-4:nth-of-type(4n+5){
                            margin-left:206px;
                        }
                    </style>
                    <div class="form-group" id="day_form_group">
                        <label class="col-md-3 control-label">白天留守人员</label>
                        <%--<div class="col-md-4" style="width:15%;margin-left: 0px;margin-right: 15px;padding-left: 0;padding-right: 0;">--%>
                            <%--<select  class="form-control" name="content1">--%>
                                <%--<c:forEach items="${requestScope.empList}" var="emp">--%>
                                    <%--<option value="${emp.id}">${emp.name}</option>--%>
                                <%--</c:forEach>--%>
                            <%--</select>--%>
                        <%--</div>--%>

                        <button class="btn btn-default btn-sm"  type="button" addEmp1>+</button>
                        <button class="btn btn-default btn-sm"  type="button" subEmp1>-</button>
                        <script>
                            var subCount1 = 2;
                            $("#day_form_group").on('click',"button[addEmp1]",function(){
                                subCount1 ++;
                                buildSelect(this,'content1');
                            });
                            $("#day_form_group").on('click',"button[subEmp1]",function(){
                                if(subCount1==0){
                                    return;
                                }
                                subCount1--;
                                $(this).parent().find("div:last-child").remove();
                            })
                        </script>
                    </div>

                    <div class="form-group" id="night_form_group">
                        <label class="col-md-3 control-label">晚上留守人员</label>
                        <button class="btn btn-default btn-sm"  type="button" addEmp2>+</button>
                        <button class="btn btn-default btn-sm"  type="button" subEmp2>-</button>
                        <script>
                            var subCount2 = 2;
                            $("button[addEmp2]").click(function(){
                                subCount2 ++;
                                var input = $(this).prev();
                                buildSelect(this,'content2');
                            });
                            $("button[subEmp2]").click(function(){
                                if(subCount2==0){
                                    return;
                                }
                                subCount2--;
                                $(this).parent().find("div:last-child").remove();
                            })
                        </script>
                    </div>
                    <input name="id" type="hidden" id="id_input">

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">修改</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--修改员工的模态框--%>
<div class="modal fade" id="editEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="margin-top: 100px;width:650px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑
                    <span style="color: #CE002B;">${sessionScope.user.department.departmentName}</span>
                    员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" action="/user/stay/editEmp" id="edit_emp_form">
                    <input type="hidden" name="id">
                    <div class="form-group">
                        <label class="col-md-3 control-label">姓名</label>
                        <div class="col-md-5">
                            <input required class="form-control" placeholder="请输入姓名" name="name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">电话</label>
                        <div class="col-md-5">
                            <input class="form-control" name="tel" placeholder="请输入电话" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">宿舍号</label>
                        <div class="col-md-5">
                            <input class="form-control" name="dorm" placeholder="请输入该员工的宿舍号" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">修改</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- 添加留守信息的模态框(按月) -->
<div class="modal fade" id="addStayInfoModalByMonth" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="margin-top: 100px;width:650px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">按月添加留守记录</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" action="/user/stay/addStayInfoByMonth">
                    <input type="hidden" name="deptName" value="${sessionScope.user.department.departmentName}">
                    <div class="form-group">
                        <label class="col-md-3 control-label">日期</label>
                        <div class="col-md-5">
                            <input class="form-control" id="date_input_month" placeholder="请选择月份 输入格式:*年*月"  name="dateStr" required>
                            <script>
                                $("#date_input_month").datetimepicker({
                                    format: "yyyy年mm月",
                                    autoclose: true,
                                    todayBtn: true,
                                    language:'zh-CN',
                                    pickerPosition:"bottom-left",
                                    minView:3,
                                    startView:3,
                                    //timepicker:false,
                                    startDate:"2000-01-01",
                                    endDate:"2050-01-01",
                                    weekStart:1,
                                });
                                //$("#date_input").datetimepicker('setEn')
                            </script>
                        </div>
                    </div>



                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">添加</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    var emps = ${requestScope.empListJson};
    //编辑员工
    $("button[editid]").click(function(){

        $("#day_form_group .col-md-4").remove();
        $("#night_form_group .col-md-4").remove();

        var time = $(this).parent().parent().find("td:eq(0)").html();
        var id = $(this).attr("editid");
        $("#id_span").html(time);
        $("#date_edit_input").val(time);
        $("#id_input").val(id);

        var as = $(this).parent().parent().find("td:eq(1)").find('a');
        var as2 = $(this).parent().parent().find("td:eq(2)").find('a');



        as.each(function(i,a){
                var div = $("<div class='col-md-4'' style='width:15%;margin-right: 15px;padding-right: 0;'></div>");
                var select = $("<select  class='form-control'' name='content1'></select>");

                $.each(emps,function(i,n){
                    var option = $("<option></option>");
                    option.attr("value",n.id);
                    option.html(n.name);
                    //console.log(a.innerHTML+"=="+n.name)
                    if(a.innerHTML == n.name){
                        option.attr("selected","selected");
                    }
                    select.append(option);
                });
                div.append(select);
                $("#day_form_group").append(div);
        });

        as2.each(function(i,a){
            var div = $("<div class='col-md-4'' style='width:15%;margin-right: 15px;padding-right: 0;'></div>");
            var select = $("<select  class='form-control'' name='content2'></select>");

            $.each(emps,function(i,n){
                var option = $("<option></option>");
                option.attr("value",n.id);
                option.html(n.name);
                //console.log(a.innerHTML+"=="+n.name)
                if(a.innerHTML == n.name){
                    option.attr("selected","selected");
                }
                select.append(option);
            });
            div.append(select);
            $("#night_form_group").append(div);
        });

        $("#editStayInfoModal").modal('show');

    });

    //构建员工的select
    function buildSelect(obj,name){
        var div = $("<div class='col-md-4'' style='width:15%;margin-right: 15px;padding-right: 0;'></div>");
        var select = $("<select  class='form-control' name="+name+"></select>");
        var parent = $(obj).parent();
        $.each(emps,function(i,n){
            var option = $("<option></option>");
            option.attr("value",n.id);
            option.html(n.name);
            select.append(option);
        });
        div.append(select);
        parent.append(div);
    }
    //删除员工
    $("button[delid]").click(function(){
        var date = $(this).parent().parent().find("td:eq(0)").html();
        var id = $(this).attr("delid");
        if(confirm("你确认删除"+date+"这一天的记录吗")){
            $.ajax({
                url:"delStayInfo?id="+id,
                method:"post",
                success:function(result){
                    location.href = "manageStay?month="+date.substr(0,7);
                },
                error:function(result){
                    alert("系统繁忙，请稍后再试");
                }
            });
        }
    });

    //编辑员工
    $(".panel-body a[id]").click(function(){
        var id = $(this).attr("id");
        var name = $(this).html();
        var tel = $(this).attr("tel");
        var dorm = $(this).attr("dorm");
        $("#edit_emp_form input[name=id]").val(id);
        $("#edit_emp_form input[name=name]").val(name);
        $("#edit_emp_form input[name=tel]").val(tel);
        $("#edit_emp_form input[name=dorm]").val(dorm);
        $("#editEmpModal").modal();
    });

</script>

</body>
</html>
