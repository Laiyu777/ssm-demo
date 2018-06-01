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
<%


%>
<!DOCTYPE html>
<html>
<head>
    <title>管理零售商</title>

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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">管理零售商</strong> / <small>Manage Seller</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-md-6">
                    <a class="am-btn am-btn-primary" href="managerSeller/addSeller">
                        <i class="am-icon-add"></i>
                        添加零售商
                    </a>
                </div>
            </div><!--class="am-g"-->
            <br/>

            <div class="am-g ">
                <div class="am-u-md-10 am-u-md-centered">
                    <table class="am-table am-table-hover am-table-striped am-table-centered">
                        <thead>
                        <tr>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>收货地址</th>
                            <th>电话号码</th>
                            <th>身份证号码</th>
                            <th>可证编码</th>
                            <th>角色</th>
                            <th>创建时间</th>
                            <th colspan="2" >操作</th>
                        </tr>
                        </thead>
                        <tbody>
                       <c:forEach items="${requestScope.pageInfo.list}" var="user">
                           <tr>
                               <td>${user.username}</td>
                               <td>${user.realName}</td>
                               <td>${user.shopAddress}</td>
                               <td>${user.phone}</td>
                               <td>${user.cardNumber}</td>
                               <td>${user.code}</td>
                               <td>${user.role.roleName}</td>
                               <td><fmt:formatDate value="${user.createTime}" pattern="yyyy年MM月dd日 hh时mm分"/></td>
                               <td><a edit_href="${path}/admin/getSellerForModal?username=${user.username}" data-am-modal="{target: '#edit_modal',width:700}" class="am-btn am-btn-primary">编辑</a></td>
                               <td><c:if test="${user.status eq 1}">
                                        <a href="${path}/admin/managerSeller/forbiddenSeller?username=${user.username}&page=${pageInfo.pageNum}" class="am-btn am-btn-danger">禁用</a>
                                    </c:if>
                                   <c:if test="${user.status eq 0}">
                                       <a href="${path}/admin/managerSeller/enabledSeller?username=${user.username}&page=${pageInfo.pageNum}" class="am-btn am-btn-success">启用</a>
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
                <div class="am-u-md-4">
                    <span><strong>总共有${pageInfo.total}条记录，总共有${pageInfo.pages}页，当前第${pageInfo.pageNum}页</strong></span>
                </div>
                <div class="am-u-md-8">
                    <ul class="am-pagination am-pagination-right">
                        <li><a href="managerSeller?page=${pageInfo.prePage}">&laquo;</a></li>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <li <c:if test="${page==pageInfo.pageNum}">class="am-active"</c:if>>
                                <a href="managerSeller?page=${page}">${page}</a>
                            </li>
                        </c:forEach>
                        <li><a href="managerSeller?page=${pageInfo.nextPage}">&raquo;</a></li>
                    </ul>
                </div>
            </div> <!--分页条-->

            <!--页脚-->
            <%@include file="../parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->

!--编辑模态框-->
<div class="am-modal am-modal-no-btn" tabindex="-1" id="edit_modal">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><strong class="am-text-primary">用户详细信息</strong><small>/ Edit Seller</small>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div><hr>
        <div class="am-modal-bd">
            <!--表格-->
            <form class="am-form am-form-horizontal" enctype="multipart/form-data"  method="post" action="${path}/admin/updateSeller" data-am-validator>
                <input type="hidden" name="page" value="${pageInfo.pageNum}">
                <div class="am-form-group">
                    <label class="am-u-sm-5 am-text-right"> 用户头像 / Seller Image</label>
                    <div class="am-u-sm-7">
                        <img id="image" src="" style="width: 200px;height: 200px"><hr>
                        <input id=""  name="file" type="file">
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5 am-text-right">用户名/ username</label>
                    <div class="am-u-sm-7">
                        <input id="edit_username" minlength="2"  name="username" type="text" required>
                    </div>
                </div>


                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">真实姓名/Real Name</label>
                    <div class="am-u-sm-7">
                        <input  name="realName" id="real_name" type="text" required>
                    </div>
                </div>
                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">收货地址/Shop Address</label>
                    <div class="am-u-sm-7">
                        <input  name="shopAddress" id="shop_address" type="text" required>
                    </div>
                </div>
                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">电话号码/Phone</label>
                    <div class="am-u-sm-7">
                        <input  name="phone" id="phone" type="text" required>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">身份证号码 / Card Number</label>
                    <div class="am-u-sm-7">
                        <input id="card_number"  name="cardNumber" type="text" required>
                    </div>
                </div>

                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">可证编码 / Code</label>
                    <div class="am-u-sm-7">
                        <input id="code" name="code" type="text" required>
                    </div>
                </div>



                <div class="am-form-group">
                    <label class="am-u-sm-5  am-text-right">注册时间 / Register Time</label>
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

<script type="text/javascript">

    function isImageExist(url) {
        if(url.length==0){
            return false;
        }
        var isExist = true;
        $.ajax(url,{
            type:"get",
            async:false,
            success:function (data,textStatus) {

            },
            error:function(){
                isExist = false;
            }
        });
        return isExist;
    }

    $(function () {
        $('a[edit_href]').click(function () {
            var href = $(this).attr('edit_href');
            $.ajax({
                url:href,
                type:"get",
                success:function (result) {
                    //处理用户头像
                    if(isImageExist("${path}/static/images/goods/"+result.username+".jpg")){
                        $('#image').attr('src',"${path}/static/images/goods/"+result.username+".jpg");
                    }else{
                        $('#image').attr('src',"${path}/static/images/goods/default.jpg");
                    }
                    //填充数据
                    $('#edit_username').val(result.username);
                    $('#real_name').val(result.realName);
                    $('#phone').val(result.phone);
                    $('#shop_address').val(result.shopAddress);
                    $('#card_number').val(result.cardNumber);
                    $('#code').val(result.code);
                    var d = new Date();
                    d.setTime(result.createTime);
                    $('#edit_createTime').text(d.getMonth()+"月"+d.getDay()+"日 "+d.getHours()+'时'+d.getMinutes()+'分'+d.getSeconds()+'秒');
                }
            });
        });
    })
</script>

</body>
</html>
