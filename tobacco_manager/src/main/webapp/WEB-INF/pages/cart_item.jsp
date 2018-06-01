<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/7
  Time: 7:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>查看我的购物车</title>
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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">购物车条目</strong> / <small>Cart Item</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-9 am-u-md-centered">
                    <!--页面内容-->
                    <table class="am-table am-table-striped am-table-hover am-table-centered">
                        <thead>
                        <tr>
                            <th>选择</th>
                            <th>商品ID</th>
                            <th>商品名称</th>
                            <th>最大销售价格</th>
                            <th>最小销售价格</th>
                            <th>当前库存</th>
                            <th>数量</th>
                            <th>进货价</th>
                            <th>条目总价</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:if test="${sessionScope.cartItemList.size()==0}">
                            <tr><td colspan="9" align="center"><h2>购物车里没有商品</h2></td></tr>
                        </c:if>
                        <c:if test="${cartItemList.size()!=0}">
                            <c:forEach items="${sessionScope.cartItemList}" var="cartItem">
                                <c:set var="roleId" value="${sessionScope.user.role.roleId}"/>
                                <tr>
                                    <td><input type="checkbox" checked></td>
                                    <td goodId>${cartItem.good.goodId}</td>
                                    <td>${cartItem.good.goodName}</td>
                                    <td>${cartItem.good.maxPrice}</td>
                                    <td>${cartItem.good.minPrice}</td>
                                    <td>${cartItem.good.stock}</td>
                                    <td><input count value="${cartItem.count}" style="width: 30px" required></td>
                                    <td >${cartItem.good.costList[roleId-1].costPrice}</td>
                                    <td cost>${cartItem.count*cartItem.good.costList[roleId-1].costPrice}</td>
                                </tr>
                            </c:forEach>
                        </c:if>

                        </tbody>
                    </table>
                    <div class="am-cf">
                        <div class="am-fl">
                            <button  id="add_order" href="#" type="submit" class="am-btn am-btn-primary" <c:if test="${sessionScope.cartItemList.size()==0}">disabled</c:if>>生成订单</button>
                        </div>
                        <div class="am-fr">
                            <h1 id="total">总价：</h1>
                        </div>
                    </div>
                    <!--页面内容-->
                </div>
            </div>


            <!--页脚-->
            <%@include file="parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->

<script type="text/javascript">
    $(function () {

       // var itemList = eval('('+"${cartItemList}"+')');
       // var itemList = JSON.parse("${cartItemList}")
//        if(itemList.length===0){
//            $("#add_order").attr('disabled','disabled');
//        }

        var $costArray = $('td[cost]');
       // alert($countArray);
        var lenth = $costArray.length;
        var total = 0;
        for(var i= 0;i<lenth;i++){
            var $cost = $($costArray[i]).text();
           total +=parseInt($cost);
        }
        $("#total").text("订单总价："+total);

        //点击生成订单按钮
        $("#add_order").click(function () {
            //选中勾选的元素
            var input = $("input:checked");
            if(input.length==0){
                alert("没有选中的条目!");
                return;
            }
            var items = [];
            var flag = true;
           $.each(input,function () {
               var goodId =  $(this).parents('tr').find('td:eq(1)').text();
               var count = $(this).parents('tr').find('td:eq(6)').find('input').val();
               var stock =  $(this).parents('tr').find('td:eq(5)').text();
               count=parseInt(count);
               stock=parseInt(stock);
               //alert('信息：'+count+"="+goodId+"="+stock);
               var r = /^\+?[1-9][0-9]*$/;//正整数正则表达式
               if(!r.test(count)||stock<count){
                   flag=false;
                   alert("输入的数字非法！");
                   return;
               }
               //alert(goodId+"=="+count);
               items.push({"good":{"goodId":goodId},
                            "count":count
               });
           });
            if(!flag){return;}
            //发送ajax请求
            $.ajax({
                url:"addOrder",
                data:JSON.stringify(items),//把array对象转换为json形式的字符串，spring可以接受并且入参。
                type:"post",
                contentType:"application/json",
                success:function (data) {

                }
            })
            alert("添加订单成功");
            window.location.href="orderPage";
        });

        //全选功能,默认全选
//        var ifCheck = true;
//        $("#checkAll").click(function () {
//            if(ifCheck){
//                $('input[type=checkbox]').attr('checked','checked');
//                ifCheck=false;
//            }else {
//                $('input[type=checkbox]').removeAttr('checked');
//            }
//        });
    })
</script>
</body>
</html>

