<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/7
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理库存</title>

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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">管理货源</strong> / <small>Manage Stock</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-6">
                    <button class="am-btn am-btn-primary" data-am-modal="{target: '#doc-modal-1', closeViaDimmer: 0, width: 700}">
                        <i class="am-icon-add"></i>
                        添加
                    </button>
                </div>
            </div><!--class="am-g"-->

            <!--添加商品模态框模态框-->
            <div class="am-modal am-modal-no-btn" tabindex="-1" id="doc-modal-1">
                <div class="am-modal-dialog">
                    <div class="am-modal-hd"><strong class="am-text-primary">添加商品</strong><small>/ Add Goods</small>
                        <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
                    </div><hr>
                    <div class="am-modal-bd">
                        <!--添加表单-->
                        <form class="am-form am-form-horizontal" enctype="multipart/form-data" method="post" action="addGoods" data-am-validator>

                            <div class="am-form-group">
                                <label class="am-u-sm-5 am-text-right">商品图片 / Goods Image</label>
                                <div class="am-u-sm-7">
                                    <input name="file" type="file">
                                </div>
                            </div>

                            <div class="am-form-group">
                                <label class="am-u-sm-5 am-text-right">商品名称 / Goods Name</label>
                                <div class="am-u-sm-7">
                                    <input  minlength="2"  name="goodName" type="text" required>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <label class="am-u-sm-5  am-text-right">库存数量 / Goods Stock</label>
                                <div class="am-u-sm-7">
                                    <input  name="stock" type="text" required>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <label class="am-u-sm-5  am-text-right">一级零售商成本价格</label>
                                <div class="am-u-sm-7">
                                    <input  name="costList[0].costPrice" type="text" required>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-5  am-text-right">二级零售商成本价格</label>
                                <div class="am-u-sm-7">
                                    <input  name="costList[1].costPrice" type="text" required>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-5  am-text-right">三级零售商成本价格</label>
                                <div class="am-u-sm-7">
                                    <input  name="costList[2].costPrice" type="text" required>
                                </div>
                            </div>


                            <div class="am-form-group">
                                <label class="am-u-sm-5  am-text-right">最大价格 / Max Price</label>
                                <div class="am-u-sm-7">
                                    <input  name="maxPrice" type="text" required>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <label class="am-u-sm-5  am-text-right">最小价格 / Min Price</label>
                                <div class="am-u-sm-7">
                                    <input  name="minPrice" type="text" required>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-5  am-text-right">商品描述 / Goods Description</label>
                                <div class="am-u-sm-7">
                                    <textarea n name="description" type="text" required></textarea>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <div class="am-u-sm-12">
                                    <button type="submit" id="updateBtn" class="am-btn am-btn-primary" >确认添加</button>
                                    <a href="javascript: void(0)" class="am-btn am-btn-default" data-am-modal-close>取消</a>
                                </div>
                            </div>
                        </form>
                        <!--表格-->
                    </div>
                </div>
            </div><!--模态框-->

            <!--表格-->
            <div class="am-g">
                <div class="am-u-md-10 am-u-md-push-1">
                    <table class="am-table am-table-bordered am-table-striped am-table-hover am-table-centered">
                        <thead>
                        <tr>
                            <th rowspan="2" class="am-text-middle">商品ID</th>
                            <th rowspan="2" class="am-text-middle">商品名称</th>
                            <th rowspan="2" class="am-text-middle">当前库存</th>
                            <th colspan="3" class="am-text-middle">成本价格</th>
                            <th rowspan="2" class="am-text-middle">最大销售价格</th>
                            <th rowspan="2" class="am-text-middle">最小销售价格</th>
                            <th rowspan="2" class="am-text-middle">添加时间</th>
                            <th rowspan="2" class="am-text-middle">操作</th>
                        </tr>
                        <tr>
                            <th>一级</th>
                            <th>二级</th>
                            <th>三级</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach items="${pageInfo.list}" var="good">
                            <tr>
                                <td >${good.goodId}</td>
                                <td>${good.goodName}</td>
                                <td>${good.stock}</td>
                                <c:forEach var="cost" items="${good.costList}">
                                    <td>${cost.costPrice}</td>
                                </c:forEach>
                                <td>${good.maxPrice}</td>
                                <td>${good.minPrice}</td>
                                <td><fmt:formatDate value="${good.createTime}" pattern="yyyy年MM月dd日 hh时mm分"/> </td>
                                <td><a edit_btn="getGoods?goodId=${good.goodId}" href="#"  class="am-btn am-btn-primary" data-am-modal="{target: '#edit_modal',width:700}">编辑</a>
                                    <a goodName="${good.goodName}" href="#" del_btn="delGoods?goodId=${good.goodId}"  class="am-btn am-btn-default">删除</a>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
            <!--分页条-->
            <div class="am-g">
                <div class="am-u-md-4">
                    <span><strong>总共有${pageInfo.total}条记录，总共有${pageInfo.pages}页，当前第${pageInfo.pageNum}页</strong></span>
                </div>
                <div class="am-u-md-8">
                    <ul class="am-pagination am-pagination-right">
                        <li><a href="managerGoods?page=${pageInfo.prePage}">&laquo;</a></li>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <li <c:if test="${page==pageInfo.pageNum}">class="am-active"</c:if>>
                                <a href="managerGoods?page=${page}">${page}</a>
                            </li>
                        </c:forEach>
                        <li><a href="managerGoods?page=${pageInfo.nextPage}">&raquo;</a></li>
                    </ul>
                </div>
            </div> <!--分页条-->


            <!--页脚-->
            <%@include file="../parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->


<!--编辑模态框-->
<div class="am-modal am-modal-no-btn" tabindex="-1" id="edit_modal">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><strong class="am-text-primary">编辑商品</strong><small>/ Edit Goods</small>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div><hr>
        <div class="am-modal-bd">
            <!--表格-->
            <form class="am-form am-form-horizontal" enctype="multipart/form-data"  method="post" action="updateGoods" data-am-validator>

                <div class="am-form-group">
                    <label class="am-u-sm-5 am-text-right">商品图片 / Goods Image</label>
                    <div class="am-u-sm-7">
                        <img id="image" src="" style="width: 200px;height: 200px"><hr>
                        <input id=""  name="file" type="file">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5 am-text-right">商品名称 / Goods Name</label>
                    <div class="am-u-sm-7">
                        <input id="edit_goodName" minlength="2"  name="goodName" type="text" required>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">库存数量 / Stock</label>
                    <div class="am-u-sm-7">
                        <input id="edit_stock"  name="stock" type="text" required>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">一级零售商成本价格</label>
                    <div class="am-u-sm-7">
                        <input  name="costList[0].costPrice" id="top_price" type="text" required>
                    </div>
                </div>
                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">二级零售商成本价格</label>
                    <div class="am-u-sm-7">
                        <input  name="costList[1].costPrice" id="second_price" type="text" required>
                    </div>
                </div>
                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">三级零售商成本价格</label>
                    <div class="am-u-sm-7">
                        <input  name="costList[2].costPrice" id="third_price" type="text" required>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">最大销售价格 / Max Price</label>
                    <div class="am-u-sm-7">
                        <input id="edit_maxPrice"  name="maxPrice" type="text" required>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">最小销售价格 / Min Price</label>
                    <div class="am-u-sm-7">
                        <input id="edit_minPrice" name="minPrice" type="text" required>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">商品描述 / Goods Description</label>
                    <div class="am-u-sm-7">
                        <textarea id="edit_description" name="description"></textarea>
                    </div>
                </div>


                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">添加时间 / Add Time</label>
                    <div class="am-u-sm-7">
                        <p id="edit_createTime"></p>
                    </div>
                </div>

                <input id="edit_goodId" name="goodId" type="hidden">

                <div class="am-form-group">
                    <div class="am-u-sm-12">
                        <button type="submit"  class="am-btn am-btn-primary" >确认修改</button>
                        <a href="javascript: void(0)" class="am-btn am-btn-default" data-am-modal-close>取消</a>
                    </div>
                </div>
            </form>
            <!--表格-->
        </div>
    </div>
</div>
<!--模态框-->

<!--删除模态框-->
<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><strong>删除记录</strong></div>
        <div class="am-modal-bd" id="msg">

        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-confirm>确定</span>
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
        </div>
    </div>
</div>
<!--删除模态框-->

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
            },
            error: function() {
                isExist = false;
            }
        });
        return isExist;
    }

    $(function () {
        $('a[edit_btn]').click(function () {
            var href = $(this).attr('edit_btn');
            $.ajax({
                url:href,
                type:"get",
                success:function (result) {
                    $('#edit_goodName').val(result.goodName);
                    $('#edit_maxPrice').val(result.maxPrice);
                    $('#edit_stock').val(result.stock);
                    $('#edit_minPrice').val(result.minPrice);
                    //$('#image').attr('src',"${path}/static/images/goods/"+result.goodId+".jpg");
                    var d = new Date();
                    d.setTime(result.createTime);
                    $('#edit_createTime').text(d.getMonth()+"月"+d.getDay()+"日 "+d.getHours()+'时'+d.getMinutes()+'分'+d.getSeconds()+'秒');
                    $('#edit_goodId').val(result.goodId);
                    $('#edit_description').val(result.description);

                    $('#top_price').val(result.costList[0].costPrice);
                    $('#second_price').val(result.costList[1].costPrice);
                    $('#third_price').val(result.costList[2].costPrice);

                    if(isImageExist("${path}/static/images/goods/"+result.goodId+".jpg")){
                        $('#image').attr('src',"${path}/static/images/goods/"+result.goodId+".jpg");
                    }else{
                        $('#image').attr('src',"${path}/static/images/goods/default.jpg");
                    }
                }
            });
        });

        $('a[del_btn]').click(function () {
            var goodName = $(this).attr('goodName');
            var msg = '你确认要删除 <font color="red">'+goodName+'</font>吗？';
            var url = $(this).attr('del_btn');
            $('#msg').html(msg);

            var $confirm = $('#my-confirm');
            $('#my-confirm').modal({
                onConfirm:function () {
                    $.ajax({
                        url:url,
                        type:'get'
                    });
                    window.location.reload();
                }
            });
        });
    })
</script>
</body>
</html>
