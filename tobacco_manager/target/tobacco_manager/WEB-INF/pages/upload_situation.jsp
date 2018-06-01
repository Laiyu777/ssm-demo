<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/23
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>上传销售情况</title>

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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">上传销售情况</strong> / <small>Upload Situation</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-9 am-u-md-centered">
                    <h2>当日已上传&nbsp;&nbsp;<small style="color: #999768;">最后上传时间：${requestScope.lastTime}</small></h2>
                    <table class="am-table am-table-centered am-table-hover am-table-bordered">
                        <thead>
                        <th>序号</th>
                        <th>商品名称</th>
                        <th>销售价格/元</th>
                        <th>成本价格/元</th>
                        <th>销售数量/包</th>
                        <th>操作</th>
                        </thead>
                        <tbody>
                        <c:if test="${requestScope.details!=null}">
                            <c:forEach items="${requestScope.details}" varStatus="count" var="detail">
                                <tr>
                                    <td>${count.count}</td>
                                    <td>${detail.goodName}</td>
                                    <td>${detail.sellPrice}</td>
                                    <td>${detail.sellCost}</td>
                                    <td>${detail.sellCount}</td>
                                    <input type="hidden" value="${detail.situationId}">
                                    <td><button class="am-btn"  modifyBtn data-am-modal="{target: '#doc-modal-1',width:1000}">修改</button></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                        <tbody>
                        </tbody>
                    </table>
                    <br>
                    <h2>上传：</h2>
                    <table class="am-table am-table-centered am-table-hover am-table-bordered">
                        <thead>
                            <th>序号</th>
                            <th>商品名称</th>
                            <th>销售价格/元</th>
                            <th>成本价格/元</th>
                            <th>销售数量/包</th>
                        </thead>
                        <tbody id="tbody">
                            <tr>
                                <td>1</td>
                                <td>
                                    <input>
                                </td>
                                <td>
                                    <input>
                                </td>
                                <td>
                                    <input>
                                </td>
                                <td>
                                    <input>
                                </td>
                            </tr>
                        </tbody>
                        <tbody>
                        </tbody>
                    </table>

                    <div class="am-g">
                        <div class="cf">
                            <button class="am-btn am-btn-primary am-fr" id="submit">提交</button>
                            <button class="am-btn am-btn-primary am-fl" id="add_tr">添加</button>&nbsp;&nbsp;
                            <button class="am-btn am-fl" id="del_tr">删除</button>
                        </div>
                    </div>
                    <br>
                </div>
            </div>



            <!--页脚-->
            <%@include file="parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->

<!--模态框-->
<div class="am-modal am-modal-confirm" tabindex="-1" id="doc-modal-1">

    <div class="am-modal-dialog">
        <div class="am-modal-hd">修改条目
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div><hr>
        <div class="am-modal-bd">
            <div class="am-g">
                <table class="am-table am-table-bordered am-table-centered">
                    <thead>
                        <th>商品名称</th>
                        <th>销售价格/元</th>
                        <th>成本价格/元</th>
                        <th>销售数量/包</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td id="good_name"></td>
                            <td id="sell_price"></td>
                            <td id="sell_cost"></td>
                            <td id="sell_count"></td>
                            <input type="hidden" id="situation_id">
                        </tr>
                    </tbody>
                </table>
            </div>
            <br>
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" id="confirm_modify">确定修改</span>
            <span class="am-modal-btn" id="">取消</span>
        </div>
        </div>

    </div>
</div><!--模态框-->

<script type="text/javascript">
    //验证框输入的值
    function verify(type,str,msg) {
        var intRex = /^\+?[1-9][0-9]*$/;
        var doubleRex=/^[1-9]\d*(\.\d+)?$/
        if(type=='不能为空'){
            if(str==''){
                alert(msg)
                return false;
            }
        }
        if(type=='大于0的正整数'){
            if(!intRex.test(str)){
                alert(msg)
                return false;
            }
        }
        if(type == '大于0的数字'){
            if(!doubleRex.test(str)){
                alert(msg);
                return false;
            }
        }
        return true;
    }
    $(function () {
        //添加行按钮
        $('#add_tr').click(function () {
            var trCount = $('#tbody tr').length;
            var str = "<tr><td>"+(trCount+1)+"</td>" +
                "<td><input></td>" +
                "<td><input></td>" +
                "<td><input></td>" +
                "<td><input></td></tr>"
            var tr = $(str);
            $('#tbody').append(tr);
        });

        //删除行按钮，删除最下面的一行
        $('#del_tr').click(function () {
            var trCount = $('#tbody tr').length;
            var flag = trCount+1
            //选中最后的一个tr
            $lasttr = $('#tbody tr:last')
            $lasttr.remove()
        })

        $('#submit').click(function(){
            //用jquery抓取表格中内容
            var trs = $('#tbody tr');//选取每一行
            var data = [];
            var result = true;
            $.each(trs,function () {//遍历每一行
                var detail = new Object();
                $.each($(this).find('input'),function(i,n){//遍历每一行中的input元素,i索引，n是每个遍历的对象,是一个js对象
                      if(i==0){//第一个遍历到的是名称
                          if(!verify('不能为空',n.value,"名称不能为空")){
                              result = false;
                          }
                          detail.goodName = n.value;
                      }else if(i==1){//第二个是销售价格
                          if(!verify('大于0的数字',n.value,'销售价格必须是大于0的数字')){
                              result = false;
                          }
                          detail.sellPrice = n.value;
                      }else if(i==2){//第三个是成本价格
                          if(!verify('大于0的数字',n.value,'成本价格必须是大于0的数字')){
                              result = false;
                          }
                            detail.sellCost = n.value;
                      }else {//第三个是销售价格
                          if(!verify('大于0的正整数',n.value,'销售价格必须是大于0的数字')){
                              result = false;
                          }
                          detail.sellCount = n.value;
                    }
                });
                data.push(detail);
                console.log(data);
            });
            if(result==false){
                return;
            }
            var databack = JSON.stringify(data);//[{},{},{}...]

            console.log(databack)
            //发送数据到后台
            $.ajax({
                type:"post",
                url:"uploadSellSituation",
                data:databack,
                //dataType:"json",
                contentType:"application/json;charset=utf-8",
                success:function (result) {
                    if(result=='上传成功'){
                        alert('上传成功');
                        window.location.href = "lookSituation";
                    }else {
                        alert('上传失败,请检查输入的项');
                    }
                }
            });
        });

        //修改按钮的点击
        $('button[modifyBtn]').click(function () {
            //需要获取一个situationid用来标识修改条件
            var situationId = $(this).parents('tr').find('input').val();
            var goodName =  $(this).parents('tr').find('td:eq(1)').html();
            var sellPrice =  $(this).parents('tr').find('td:eq(2)').html();
            var sellCost =  $(this).parents('tr').find('td:eq(3)').html();
            var sellCount =  $(this).parents('tr').find('td:eq(4)').html();

            //数据回显到模态框中
            $('#good_name').html("<input name='goodName' value='"+goodName+"'required>");
            $('#sell_price').html("<input name='sellPrice' value='"+sellPrice+"'>");
            $('#sell_cost').html("<input name='sellCost' value='"+sellCost+"'>");
            $('#sell_count').html("<input name='sellCount' value='"+sellCount+"'>");
            $('#situation_id').val(situationId);
        });

        //确定修改的按钮
            $('#confirm_modify').click(function () {
                $('#detail_form').submit();
            var situationDetail = new Object();
            situationDetail.goodName = $('input[name=goodName]').val();
            situationDetail.sellPrice = $('input[name=sellPrice]').val();
            situationDetail.sellCost = $('input[name=sellCost]').val();
            situationDetail.sellCount = $('input[name=sellCount]').val();
            situationDetail.situationId = $('#situation_id').val();

            //对数据进行校验
            if((!verify('不能为空',situationDetail.goodName,'名称不能为空'))
                ||(!verify('大于0的数字',situationDetail.sellPrice,'销售价格必须是大于0的数字'))
                ||(!verify('大于0的数字',situationDetail.sellCost,'成本价格必须是大于0的数字'))
                ||(!verify('大于0的正整数',situationDetail.sellCount,'销售数量必须是大于0的正整数'))){
                //如何在amazeui的模态框中对form的验证 2018.3.26
                return;
            }
            //发送ajax请求给后台
            $.ajax({
                type:"post",
                url:"updateSituationDetail",
                data:situationDetail,
                success:function (result) {
                    if(result=="修改成功"){
                        alert("修改成功!");
                        window.location.href="uploadSituation";
                    }
                }
            });
         })
    })
</script>
</body>
</html>

