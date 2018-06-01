<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单列表</title>

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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">订单列表</strong> / <small>Order List</small></div>
            </div>
            <hr>
            <!--查询部分-->
            <div class="am-g">
                <div class="am-u-md-3">
                    <form action="orderPage">
                        <div class="am-input-group">
                              <span class="am-input-group-btn">
                                <button class="am-btn am-btn-default" type="submit"><span class="am-icon-search"></span></button>
                              </span>
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="row" value="${pageInfo.pageSize}">
                            <input name="keyword" type="text" class="am-form-field" placeholder="请输入商品名称查询相应订单" value="${requestScope.keyword}">
                        </div>
                    </form>
                </div>
                <div class="am-u-md-4">
                    <select data-am-selected onchange="window.location.href=this.value;">
                        <option value="orderPage?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&status=" <c:if test="${requestScope.status==''}">selected</c:if>>全部</option>
                        <option value="orderPage?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&status=等待审核" <c:if test="${requestScope.status=='等待审核'}">selected</c:if>>等待审核</option>
                        <option value="orderPage?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&status=已审核，正在出库" <c:if test="${requestScope.status=='已审核，正在出库'}">selected</c:if>>已审核，正在出库</option>
                        <option value="orderPage?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&status=审核未通过" <c:if test="${requestScope.status=='审核未通过'}">selected</c:if>>审核未通过</option>
                        <option value="orderPage?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&status=订单已取消" <c:if test="${requestScope.status eq '订单已取消'}">selected</c:if>>订单已取消</option>
                        <option value="orderPage?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&status=订单已完成" <c:if test="${requestScope.status eq '订单已完成'}">selected</c:if>>订单已完成</option>
                    </select>
                </div>
                <div class="am-u-md-5 am-u-md-pull-1">
                    <form class="am-form am-form-inline" action="orderPage" data-am-validator>
                        <div class="am-form-group">
                            <div class="am-input-group am-datepicker-date" data-am-datepicker="{format: 'yyyy-mm-dd'}">
                                <input value="${requestScope.startDay}" type="text" name="startDay" class="am-form-field" placeholder="选择起始时间" readonly required>
                                <span class="am-input-group-btn am-datepicker-add-on">
                                    <button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>
                                </span>
                            </div>
                        </div>-
                        <div class="am-form-group">
                            <div class="am-input-group am-datepicker-date" data-am-datepicker="{format: 'yyyy-mm-dd'}">
                                <input value="${requestScope.endDay}" type="text" name="endDay" class="am-form-field" placeholder="选择结束时间" readonly required>
                                <span class="am-input-group-btn am-datepicker-add-on">
                                        <button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>
                                    </span>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <button class="am-btn am-btn-default">确定</button>
                        </div>

                    </form>
                </div>
            </div><!--查询部分-->
            <hr>
            <div class="am-g">
                <div class="am-u-md-11 am-u-md-centered">
                    <!--页面内容-->
                    <!--如果没有订单，显示图片-->
                    <c:if test="${sessionScope.pageInfo.total==0}">
                        <figure data-am-widget="figure" class="am am-figure am-figure-default "   data-am-figure="{  pureview: 'true' }">
                            <img src="${path}/static/images/noorder.jpg">
                        </figure>

                    </c:if>
                    <!--如果有订单，则显示出来-->
                    <c:if test="${sessionScope.pageInfo.total!=0}">
                        <table class="am-table am-table-striped am-table-hover am-table-centered">
                        <thead>
                        <tr>
                            <th>订单编号</th>
                            <th>订单内容</th>
                            <th>创建时间</th>
                            <th>订单状态</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sessionScope.pageInfo.list}" var="order">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><button class="am-btn am-btn-default am-round" detail>点击查看详情</button></td>
                                    <td><fmt:formatDate value="${order.createTime}" pattern="yyyy年MM月dd日 hh时mm分ss秒"/> </td>
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
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status=='等待审核'}">
                                                <button btn-cancel="${order.orderId}" type="button" class="am-btn am-btn-warning am-radius">取消订单</button>
                                            </c:when>
                                            <c:when test="${order.status=='已审核，正在出库'}">
                                                <button btn-confirm="${order.orderId}" type="button" class="am-btn am-btn-success am-radius">确认收货</button>
                                            </c:when>
                                            <c:when test="${order.status=='审核未通过'||order.status=='订单已取消'}">
                                                <button btn-reason="${order.orderId}" type="button" class="am-btn am-btn-default am-radius">查看原因</button>
                                            </c:when>
                                           <c:otherwise>
                                               <button  type="button" class="am-btn am-btn-default am-radius" disabled>不可操作</button>
                                           </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    </c:if>
                    <!--分页条-->
                    <div class="am-g">
                        <div class="am-u-md-4">
                            <span><strong>总共有${pageInfo.total}条记录，总共有${pageInfo.pages}页，当前第${pageInfo.pageNum}页</strong></span>
                        </div>
                        <div class="am-u-md-8">
                            <ul class="am-pagination am-pagination-right">
                                <li><a href="orderPage?page=${pageInfo.prePage}">&laquo;</a></li>
                                <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                                    <li <c:if test="${page==pageInfo.pageNum}">class="am-active"</c:if>>
                                        <a href="orderPage?page=${page}">${page}</a>
                                    </li>
                                </c:forEach>
                                <li><a href="orderPage?page=${pageInfo.nextPage}">&raquo;</a></li>
                            </ul>
                        </div>
                    </div><!--分页条-->
                    <!--页面内容-->
                </div>
            </div>


            <!--页脚-->
            <%@include file="parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->
<!--订单详情模态框-->
<div class="am-modal am-modal-no-btn" tabindex="-1" id="doc-modal-1">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">订单详情
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <table class="am-table  am-table-bordered am-table-striped am-table-hover am-table-centered">
                <thead>
                    <tr>
                        <td>商品名称</td>
                        <td>商品数量</td>
                        <td>成本</td>
                        <td>条目总价</td>
                    </tr>
                </thead>
                <tbody id="detail">

                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4">
                            <small><font color="red" id="ss"></font></small>
                        </td>
                    </tr>
                </tfoot>
            </table>
            <div class="am-cf">
                <div class="am-fr">
                    <h1 id="h1"></h1>
                </div>
            </div>
        </div>
    </div>
</div><!--订单详情模态框-->

<!--订单取消原因的输入模态框-->
<div class="am-modal am-modal-no-btn" tabindex="-1" id="cancel-modal">
    <div class="am-modal-dialog">
        <div class="am-modal-bd">
            <form action="cancelOrder" class="am-form" method="post" data-am-validator>
                <input name="orderId" type="hidden">
                <input name="status" type="hidden">
                <fieldset>
                        <div class="am-form-group">
                            <label class="am-cf am-fl">请输入理由：</label>
                            <textarea name="notes" class="" rows="5" required></textarea>
                        </div>
                        <button type="submit" class="am-btn am-btn-primary">提交</button>
                </fieldset>
            </form>
        </div>
    </div>
</div><!--订单取消原因的输入模态框-->

<!--查看订单取消原因模态框-->
<div class="am-modal am-modal-no-btn" tabindex="-1" id="reason-modal">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">
            <label>审核未通过原因</label>
        </div>
        <div class="am-modal-bd">
           <label id="reasonText" style="color: red">中华货物没到</label>
        </div>
    </div>
</div><!--查看订单取消原因模态框-->

 <script type="text/javascript">
     $(function () {
        $('button[detail]').click(function () {
            //清空上一次查询的
            $("#detail").empty();
            //发送ajax请求加载数据
            var orderId = $(this).parent().prev().text();
            $.ajax({
                type:"get",
                url:"getOrderDetail?orderId="+orderId,
                success:function (data) {
                    console.log(data)
                    $('#ss').text(data.status);
                    if(data.status=='审核未通过'||data.status=='订单已取消'){
                        $('#ss').append(":"+data.notes);
                    }
                    //这个data已经是一个json对象了
                    var alltotal = 0;
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
                       var roleId ='${sessionScope.user.role.roleId}';
                       //alert(roleId);
                       var cost = $("<td>"+o.good.costList[parseInt(roleId-1)].costPrice+"</td>");
                       var total = $("<td>"+o.good.costList[parseInt(roleId-1)].costPrice*o.count+"</td>");
                       tr.append(name);
                       tr.append(count);
                       tr.append(cost);
                       tr.append(total);
                       tbody.append(tr);
                       alltotal+=o.good.costList[parseInt(roleId-1)].costPrice*o.count;
                    });
                    $('#h1').text('总价：'+alltotal);
                }
            });
           $('#doc-modal-1').modal();
        });

        //取消的按钮,弹出模态框并且填充orderId
         $('button[btn-cancel]').click(function () {
            //填充orderId的input
             var orderId = $(this).attr('btn-cancel');
             $('#cancel-modal input[name=orderId]').val(orderId);
             $('#cancel-modal input[name=status]').val('订单已取消');
            $('#cancel-modal').modal();
         });

         //确认收货按钮
         $('button[btn-confirm]').click(function () {
            var orderId = $(this).attr('btn-confirm');
            $.ajax({
                type:"post",
                url:"confirmReceipt",
                data:{
                    "orderId":orderId
                },
                success:function (result) {
                    alert(result);
                    window.location.href="orderPage";
                }
            });
         });

         //查看取消原因的按钮
         $('button[btn-reason]').click(function(){
             var orderId = $(this).attr('btn-reason');
             //alert(orderId);
             $.ajax({
                 url:"getOrderDetail?orderId="+orderId,
                 type:"get",
                success:function (data) {
                    var reason = data.notes;
                    $('#reasonText').text(reason);
                }
             });
             $('#reason-modal').modal();
         });

     })
 </script>
</body>
</html>
