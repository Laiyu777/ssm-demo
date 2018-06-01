<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理订单</title>

    <link rel="stylesheet" type="text/css" href="../static/assets/css/amazeui.min.css">
    <script type="text/javascript" src="../static/assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="../static/assets/js/amazeui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../static/assets/css/admin.css">
</head>
<body>

<!--顶部页面-->
<%@include file="../parts/top.jsp"%>

<div class="am-cf admin-main">
    <!--导航条-->
    <%@include file="../parts/nav.jsp"%>
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">管理订单</strong> / <small>Manage Orders</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-9 am-u-md-centered">
                    <!--页面内容-->
                        <table class="am-table am-table-striped am-table-hover am-table-centered">
                            <thead>
                                <tr>
                                    <td>订单编号</td>
                                    <td>用户</td>
                                    <td>创建时间</td>
                                    <td>总价/元</td>
                                    <td>状态</td>
                                    <td>操作</td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${sessionScope.pageInfo.list}" var="order">
                                    <tr>
                                        <td>${order.orderId}</td>
                                        <td>${order.username}</td>
                                        <td>${order.createTime}</td>
                                        <td>${order.total}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status=='等待审核'}">
                                                    <span class="am-badge am-badge-warning am-text-default">${order.status}</span>
                                                </c:when>
                                                <c:when test="${order.status=='已审核，正在出库'}">
                                                    <span class="am-badge am-badge-primary am-text-default">${order.status}</span>
                                                </c:when>
                                                <c:when test="${order.status=='订单已取消'}">
                                                    <span class="am-badge am-text-default">${order.status}</span>
                                                </c:when>
                                                <c:when test="${order.status=='订单已完成'}">
                                                    <span class="am-badge am-badge-success am-text-default">${order.status}</span>
                                                </c:when>
                                                <c:when test="${order.status=='审核未通过'}">
                                                    <span class="am-badge am-badge-danger
                                                     am-text-default">${order.status}</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td><!--操作的td-->
                                            <c:choose>
                                                <c:when test="${order.status=='等待审核'}">
                                                    <select class="statusChoose" data-am-selected>
                                                        <option value="已审核，正在出库">审核出库</option>
                                                        <option value="审核未通过">审核未通过</option>
                                                        <option value="订单已取消">取消订单</option>
                                                    </select>
                                                    <button status="${order.orderId}" class="am-btn am-btn-default am-round">确定</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <select data-am-selected disabled>
                                                    <option value="a" selected>该订单状态不能修改</option>
                                                    </select>
                                                    <button class="am-btn am-btn-default am-round" disabled>确定</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button look_detail_btn class="am-btn am-btn-primary">查看详情</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    <!--分页条-->
                    <div class="am-g">
                        <div class="am-u-md-4">
                            <span><strong>总共有${pageInfo.total}条记录，总共有${pageInfo.pages}页，当前第${pageInfo.pageNum}页</strong></span>
                        </div>
                        <div class="am-u-md-8">
                            <ul class="am-pagination am-pagination-right">
                                <li><a href="managerOrders?page=${pageInfo.prePage}">&laquo;</a></li>
                                <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                                    <li <c:if test="${page==pageInfo.pageNum}">class="am-active"</c:if>>
                                        <a href="managerOrders?page=${page}">${page}</a>
                                    </li>
                                </c:forEach>
                                <li><a href="managerOrders?page=${pageInfo.nextPage}">&raquo;</a></li>
                            </ul>
                        </div>
                    </div><!--分页条-->
                    <!--页面内容-->
                </div>
            </div>


            <!--页脚-->
            <%@include file="../parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->


<!--订单详情模态框-->
<div class="am-modal am-modal-no-btn" tabindex="-1" id="doc-modal-1">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">订单详情<small><font color="red" id="ss"></font></small>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <table class="am-table  am-table-bordered am-table-striped am-table-hover am-table-centered">
                <thead>
                <tr>
                    <td>商品名称</td>
                    <td>商品数量/条</td>
                    <td>成本/元</td>
                    <td>条目总价/元</td>
                </tr>
                </thead>
                <tbody id="detail">

                </tbody>
            </table>
            <div class="am-cf">
                <div class="am-fr">
                    <h1 id="h1"></h1>
                </div>
            </div>
        </div>
    </div>
</div><!--订单详情模态框-->

<!--原因填写模态框-->
<div class="am-modal am-modal-no-btn am-modal-active" tabindex="-1" id="cancel-modal">
    <div class="am-modal-dialog">
        <div class="am-modal-bd">
            <form action="../cancelOrder" class="am-form" method="post" data-am-validator="" novalidate="novalidate">
                <input name="orderId" type="hidden">
                <input name="status" type="hidden">
                <fieldset>
                    <div class="am-form-group am-form-error">
                        <label class="am-cf am-fl">请输入理由：</label>
                        <textarea name="notes" class="am-field-error am-active" rows="5" required=""></textarea>
                    </div>
                    <button type="submit" class="am-btn am-btn-primary">提交</button>
                </fieldset>
            </form>
        </div>
    </div>
</div><!--原因填写模态框-->

<script type="text/javascript">

    function getRoleIdByUsername(username) {
        var roleId =0;
        $.ajax({
            url:'${path}/getUserByUserName?name='+username,
            type:'get',
            async:false,
            success:function(user){
                roleId = user.role.roleId;
            }
        });
        return parseInt(roleId);
    }

    $(function () {
        //查看订单安按钮
        $('button[look_detail_btn]').click(function () {
            //清空表格内容
            $("#detail").empty();
            //获取订单编号
            var orderId = $(this).parent().prevAll('td:eq(-1)').text();
            var username = $(this).parent().prevAll('td:eq(-2)').text();
            //alert(username)
            //alert(orderId);
            $.ajax({
                type:"get",
                url:"../getOrderDetail?orderId="+orderId,
                success:function (data) {
                    //这个data已经是一个json对象了
                    var alltotal = 0;
                    $('#ss').text(data.status);
                    $.each(data.orderDetails,function (index,o) {
                        /*
                         <tr>
                         <td>商品名称</td>
                         <td>商品数量</td>
                         <td>成本</td>
                         <td>条目总价</td>
                         </tr>
                         */
                        var tbody = $("#detail");
                        var tr = $("<tr></tr>");
                        var name=$("<td>"+o.good.goodName+"</td>");
                        var count = $("<td>"+o.count+"</td>");
                        var roleId = getRoleIdByUsername(username);
                        var cost = $("<td>"+o.good.costList[roleId-1].costPrice+"</td>");
                        var total = $("<td>"+o.good.costList[roleId-1].costPrice*o.count+"</td>");
                        tr.append(name);
                        tr.append(count);
                        tr.append(cost);
                        tr.append(total);
                        tbody.append(tr);
                        alltotal+=o.good.costList[roleId-1].costPrice*o.count;
                    });
                    $('#h1').text('总价：'+alltotal);
                    $('#doc-modal-1').modal();
                }
            });
        });

        //点击确定修改订单状态
        $('button[status]').click(function () {
            //获取订单id和选中的值
            var orderId = $(this).attr('status');
            var statusValue = $(this).prevAll('select').val();
           //alert(orderId+statusValue+"...");
            //如果是审核未通过或者取消订单，应该要填写原因
            if(statusValue=='审核未通过'||statusValue=='订单已取消'){
                $('#cancel-modal input[name=orderId]').val(orderId);
                $('#cancel-modal input[name=status]').val(statusValue);
                $('#cancel-modal').modal();
                return;
            }


            //发送ajax请求到后台
            $.ajax({
                async:false,
                url:"updateOrderStatus",
                type:"post",
                data:{
                    'orderId':orderId,
                    'status':statusValue
                },
                success:function (result) {
                    alert(result);
                    window.location.href="managerOrders";
                },
                error:function(result){
                    alert("修改失败")
                }
            });
        });
    })
</script>
</body>
</html>
