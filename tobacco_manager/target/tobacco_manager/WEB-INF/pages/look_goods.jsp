<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>查看货源</title>
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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">查看货源</strong> / <small>Look Goods</small></div>
            </div>
            <hr>
            <!--查询部分-->
            <div class="am-g">
                <div class="am-u-md-3">
                    <form action="lookGoods">
                        <div class="am-input-group">
                              <span class="am-input-group-btn">
                                <button class="am-btn am-btn-default" type="submit"><span class="am-icon-search"></span></button>
                              </span>
                                <input type="hidden" name="page" value="1">
                                <input type="hidden" name="row" value="${pageInfo.pageSize}">
                                <input name="keyword" type="text" class="am-form-field" placeholder="请输入商品名称" value="${requestScope.keyword}">
                        </div>
                    </form>
                </div>
                <div class="am-u-md-4 am-u-md-pull-5">
                    <select data-am-selected onchange="window.location.href=this.value;">
                        <option value="lookGoods?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=create_time&order=DESC" <c:if test="${requestScope.orderName=='create_time' and requestScope.order=='DESC'}">selected</c:if>>按添加时间降序</option>
                        <option value="lookGoods?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=create_time&order=ASC" <c:if test="${requestScope.orderName=='create_time' and requestScope.order=='ASC'}">selected</c:if>>按添加时间升序</option>
                        <option value="lookGoods?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=stock&order=DESC" <c:if test="${requestScope.orderName eq 'stock' and requestScope.order eq 'DESC'}">selected</c:if>>按库存降序</option>
                        <option value="lookGoods?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=stock&order=ASC" <c:if test="${requestScope.orderName eq 'stock' and requestScope.order eq 'ASC'}">selected</c:if>>按库存升序</option>
                        <option value="lookGoods?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=cost&order=DESC" <c:if test="${requestScope.orderName=='cost' and requestScope.order=='DESC'}">selected</c:if>>按成本排序降序</option>
                        <option value="lookGoods?page=1&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=cost&order=ASC" <c:if test="${requestScope.orderName=='cost' and requestScope.order=='ASC'}">selected</c:if>>按成本排序升序</option>
                    </select>

                </div>
            </div><!--查询部分-->
            <hr>
            <div class="am-g">
                <div class="am-u-md-11 am-u-md-centered">
                    <!--页面内容-->
                    <table class="am-table am-table-striped am-table-hover am-table-centered am-text-middle">
                        <thead>
                        <tr>
                            <th>商品ID</th>
                            <th>商品名称</th>
                            <th>成本/元</th>
                            <th>当前库存/条</th>
                            <th>最大销售价格/元</th>
                            <th>最小销售价格/元</th>
                            <th>添加时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach items="${pageInfo.list}" var="good">
                            <c:set var="roleId" value="${sessionScope.user.role.roleId}"/>
                            <tr>
                                <td>${good.goodId}</td>
                                <td>${good.goodName}</td>
                                <td>
                                    <c:set value="一级零售商价格:${good.costList[0].costPrice}<br>
                                        二级级零售商价格:${good.costList[1].costPrice}<br>
                                        三级零售商价格:${good.costList[2].costPrice}<br>" var="content"/>
                                    <a href="javascript:void(0);" id="price_popover" data-am-popover="{content: '一级零售商价格:${good.costList[0].costPrice}<br>二级零售商价格:${good.costList[1].costPrice}<br> 三级零售商价格:${good.costList[2].costPrice}', trigger: 'hover'}">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role.roleId == 0}">
                                                一级零售商价格:${good.costList[0].costPrice}<br>
                                                二级级零售商价格:${good.costList[1].costPrice}<br>
                                                三级零售商价格:${good.costList[2].costPrice}<br>
                                            </c:when>
                                        </c:choose>
                                            ${good.costList[roleId-1].costPrice}
                                    </a>
                                </td>
                                <td>${good.stock}</td>
                                <td>${good.maxPrice}</td>
                                <td>${good.minPrice}</td>
                                <td><fmt:formatDate value="${good.createTime}" pattern="yyyy年MM月dd日 hh时mm分"/> </td>
                                <td><a look_btn="getGoods?goodId=${good.goodId}" href="#"  class="am-btn am-btn-primary" data-am-modal="{target: '#doc-modal-1', width: 600}">查看详情</a>
                                    <c:if test="${sessionScope.user.role.roleId != 0}">
                                        <a add_shopcart_btn="" goodName="${good.goodName}" href="#" class="am-btn am-btn-default">添加至购物车</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
            <!--分页条-->
            <div class="am-g">
                <div class="am-u-md-5">
                    <span>
                        <strong>
                            总共有${pageInfo.total}条记录，总共有${pageInfo.pages}页，当前第${pageInfo.pageNum}页，
                            <c:set var="url" value="lookGoods?page=1&keyword=${requestScope.keyword}"/>
                            每页显示
                            <select onchange="window.location=this.value">
                                <option value="lookGoods?page=1&keyword=${requestScope.keyword}&row=5&orderName=${requestScope.orderName}&order=${requestScope.order}" <c:if test="${pageInfo.pageSize==5}">selected</c:if>>5</option>
                                <option value="lookGoods?page=1&keyword=${requestScope.keyword}&row=10&orderName=${requestScope.orderName}&order=${requestScope.order}" <c:if test="${pageInfo.pageSize==10}">selected</c:if>>10</option>
                                <option value="lookGoods?page=1&keyword=${requestScope.keyword}&row=15&orderName=${requestScope.orderName}&order=${requestScope.order}" <c:if test="${pageInfo.pageSize==15}">selected</c:if>>15</option>
                                <option value="lookGoods?page=1&keyword=${requestScope.keyword}&row=20&orderName=${requestScope.orderName}&order=${requestScope.order}" <c:if test="${pageInfo.pageSize==20}">selected</c:if>>20</option>
                            </select>条
                        </strong>
                    </span>
                </div>
                <div class="am-u-md-7">
                    <ul class="am-pagination am-pagination-right">
                        <li><a href="lookGoods?page=${pageInfo.prePage}&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=${requestScope.orderName}&order=${requestScope.order}">&laquo;</a></li>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <li <c:if test="${page==pageInfo.pageNum}">class="am-active"</c:if>>
                                <a href="lookGoods?page=${page}&row=${pageInfo.pageSize}&keyword=${requestScope.keyword}&orderName=${requestScope.orderName}&order=${requestScope.order}">${page}</a>
                            </li>
                        </c:forEach>
                        <li><a href="lookGoods?page=${pageInfo.nextPage}&row=${pageInfo.pageSize}
                        &keyword=${requestScope.keyword}&orderName=${requestScope.orderName}&order=${requestScope.order}">&raquo;</a></li>
                    </ul>
                </div>
            </div><!--分页条-->
        </div> <!--页面内容-->
    </div>


            <!--页脚-->
            <%@include file="parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->

<!--详情模态框-->
<div class="am-modal am-modal-confirm" tabindex="-1" id="doc-modal-1">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">商品详情
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div><hr>
        <div class="am-modal-bd">
            <div class="am-g">
                <div class="am-u-md-5">
                    <img id="good_image" src="${path}/static/images/goods/default.jpg" width="200px" height="200px">
                </div>
                <div class="am-u-md-7">

                    <p align="left" id="good_name"></p>
                    <p align="left" id="good_stock"></p>
                    <p align="left" id="good_cost"></p>
                    <p align="left" id="good_minPrice"></p>
                    <p align="left" id="good_maxPrice"></p>
                </div>
            </div>
            <br>
            <div class="am-g">
                <div class="am-u-md-6 am-u-md-pull-2">
                    <h2>商品介绍：</h2>
                </div>
            </div>

            <div class="am-g">
                <div class="am-u-md-12" style="text-align: left;">
                    <p id="good_description"></p>
                </div>
            </div>

        </div>
        <%--<div class="am-modal-footer">--%>
            <%--<span class="am-modal-btn" data-am-modal-confirm id="addCart">添加至购物车</span>--%>
            <%--<span class="am-modal-btn" data-am-modal-cancel>取消</span>--%>
        <%--</div>--%>
    </div>
</div><!--详情模态框-->

<!--数量确认模态框-->
<div class="am-modal am-modal-alert" tabindex="-1" id="count_confirm">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">添加 商品6 到购物车</div>
        <form id="count_form" action="addCartItem" method="post">
            <div class="am-modal-bd">
               请输入你要添加的数量：<input id="input_count" name="count" required type="number">
                <input name="goodId" type="hidden">
            </div>
            <div class="am-modal-footer">
                <span class="am-modal-btn" data-am-modal-confirm>确认</span>
                <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            </div>
        </form>
    </div>
</div><!--数量确认模态框-->

<script type="text/javascript">

    function isImageExist(url){
        if(url.length==0){
            return false;
        }
        var isExist=true;
        $.ajax(url, {
            type: 'get',
            async:false,//取消ajax的异步实现
            success: function(data,textStatus) {
                isExist=true;
            },
            error: function() {
                isExist = false;
            }
        });
        return isExist;
    }

    $(function () {
        //alert(isImageExist("${path}/static/images/goods/1.jpg"));
        var stock;
        //处理添加数量模态框
        $('a[add_shopcart_btn]').click(function () {
            var goodName = $(this).parent().parent().children().eq(1).text();
            //设置标题
            $('#count_confirm .am-modal-hd').text("添加 "+goodName+" 到购物车");
            //找到商品id和name
            var goodId = $(this).parent().parent().children().eq(0).text();
            $('input[name=goodId]').val(goodId);

            //获取库存数量
            var stock1 = $(this).parent().parent().children().eq(3).text();
            stock = parseInt(stock1);
            var count = parseInt($('#input_count').val());
            //alert(stock===count)
            $('#count_confirm').modal();
        });

        $('#count_confirm span:eq(0)').click(function () {
            var $count = $('#input_count').val();
           // alert('当前库存是:'+stock);
            var r = /^\+?[1-9][0-9]*$/;
            if(!r.test($count)){
                alert('请输入正整数！')
                return;
            }
            if(stock<parseInt($count)){
                alert("请输入比库存小的数字，当前库存为："+stock);
                return;
            }
            $("#count_form").submit();
        });

        //详情按钮
        $('a[look_btn]').click(function () {
            var href = $(this).attr('look_btn');
            var goodId =null;
            var cost = $(this).parent().prevAll('td').eq(-3).children('a').html().trim();
            $.ajax({
                url:href,
                type:"get",
                success:function (result) {
                    goodId = result.goodId;
                    $('#good_name').text("商品名称："+result.goodName);
                    $('#good_stock').text("商品库存："+result.stock+"条");
                    $('#good_cost').text("商品成本："+cost+"元");
                    $('#good_minPrice').text("最低销售价格："+result.minPrice+"元");
                    $('#good_maxPrice').text("最高销售价格："+result.maxPrice+"元");
                   if(result.description==null){
                       $('#good_description').text("暂无商品描述");
                   }else {
                       $('#good_description').text(result.description);
                   }
                    //$('#good_image').attr('src',"${path}/static/images/goods/"+result.goodId+".jpg");
                    if(isImageExist("${path}/static/images/goods/"+result.goodId+".jpg")){
                        $('#good_image').attr('src',"${path}/static/images/goods/"+result.goodId+".jpg");
                    }else{
                        $('#good_image').attr('src',"${path}/static/images/goods/default.jpg");
                    }

                }
            });


        });

        //按库存排序按钮
        $('#order_stock').click(function () {
            var urlDESC = "lookGoods?page=1&size=15&orderName=stock&order=DESC";
            var urlASC = "lookGoods?page=1&size=15&orderName=stock&order=ASC";
            var flag = true;
            if(flag){
                window.location.href=urlDESC;
                flag=false;
                alert(flag);
            }else{
                window.location.href=urlASC;
                flag=true;
                alert(flag);
            }
        })



    })
</script>
</body>
</html>
