<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/20
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<!--顶部页面-->
<%@include file="../parts/top.jsp"%>
<head>
    <title>添加零售商</title>

    <link rel="stylesheet" type="text/css" href="${path}/static/assets/css/amazeui.min.css">
    <script type="text/javascript" src="${path}/static/assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/assets/js/amazeui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${path}/static/assets/css/admin.css">
</head>



<div class="am-cf admin-main">
    <!--导航条-->
    <%@include file="../parts/nav.jsp"%>
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">添加零售商</strong> / <small>Add Seller</small></div>
            </div>
            <hr>

            <br/>

            <div class="am-g">
                <div class="am-u-md-8 am-u-md-centered">

                    <form id="addseller_form" class="am-form am-form-horizontal" method="post" action="${path}/admin/managerSeller/addSeller">
                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">用户名</label>
                            <div class="am-u-sm-10">
                                <input type="text" name="username" placeholder="请输入零售商用户名" minlength="6" data-validation-message="用户名至少要6位">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">密码</label>
                            <div class="am-u-sm-10">
                                <input type="password" name="password" placeholder="请输入零售商密码" minlength="8" data-validation-message="密码至少要8位">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">真实姓名</label>
                            <div class="am-u-sm-10">
                                <input type="text" name="realName"  placeholder="请输入零售商真实姓名" minlength="2">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">收货地址</label>
                            <div class="am-u-sm-10">
                                <input type="text" name="shopAddress"  placeholder="请输入零售商收货地址" minlength="3">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">电话</label>
                            <div class="am-u-sm-10">
                                <input type="text" name="phone" placeholder="请输入零售商电话" minlength="11" maxlength="11" data-validation-message="手机号码必须是11位的">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">身份证号码</label>
                            <div class="am-u-sm-10">
                                <input type="text" name="cardNumber"  placeholder="请输入零售商身份证号码" minlength="18" maxlength="18" data-validation-message="身份证号码必须是18位">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-2 am-form-label">可证编码</label>
                            <div class="am-u-sm-10">
                                <input type="text" name="code"  placeholder="请输入零售商可证编码" minlength="5">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">选择零售商类型</label>
                            <div class="am-u-sm-10">
                                <select data-am-selected name="role.roleId" required>
                                    <option value="">-=请选择一项=-</option>
                                    <option value="1" >一级零售商</option>
                                    <option value="2">二级零售商</option>
                                    <option value="3">三级零售商</option>
                                </select>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-10 am-u-sm-offset-2">
                                <button type="submit" class="am-btn am-btn-primary">确定添加</button>
                                <button type="reset" class="am-btn am-btn-default">重置</button>
                                <a type="reset" class="am-btn am-btn-default" href="${path}/admin/managerSeller">取消</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div><!-- <div class="am-g"> -->

            <!--页脚-->
            <%@include file="../parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->


</body>

<script type="text/javascript">
    $(function() {
        $('#addseller_form').validator({
            onValid: function(validity) {
                $(validity.field).closest('.am-form-group').find('.am-alert').hide();
            },

            onInValid: function(validity) {
                var $field = $(validity.field);
                var $group = $field.closest('.am-u-sm-10');
                var $alert = $group.find('.am-alert');
                // 使用自定义的提示信息 或 插件内置的提示信息
                var msg = $field.data('validationMessage') || this.getValidationMessage(validity);

                if (!$alert.length) {
                    $alert = $('<div class="am-alert am-alert-danger"></div>').hide().
                    appendTo($group);
                }

                $alert.html(msg).show();
            }
        });
    });
</script>
</html>
