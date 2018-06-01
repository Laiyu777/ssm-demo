<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>主页</title>

    <link rel="stylesheet" type="text/css" href="static/assets/css/amazeui.min.css">
    <script type="text/javascript" src="static/assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/assets/js/amazeui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="static/assets/css/admin.css">
</head>
<body>

<!--顶部页面-->
<%@include file="parts/top.jsp"%>

<div class="am-cf admin-main">

    <%@include file="parts/nav.jsp"%>
    <!--显示的主题内容-->
    <div class="admin-content">
        <div class="admin-content-body">
            <!--个人资料标题-->
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">个人资料</strong> / <small>Personal information</small></div>
            </div>
            <hr>
            <!--表单内容-->
            <div class="am-g">
                <br><br>
                <div class="am-u-md-6 am-u-md-push-2">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label class="am-u-sm-4 am-text-right">账号 / account</label>
                            <div class="am-u-sm-8">
                                ${user.username}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-4 am-text-right">真实姓名 / real name</label>
                            <div class="am-u-sm-8">
                                ${user.realName}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-4 am-text-right">注册时间 / create time</label>
                            <div class="am-u-sm-8">
                                ${user.createTime}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-4  am-text-right">角色 / role</label>
                            <div class="am-u-sm-8">
                                ${user.role.roleName}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-4  am-text-right">地址 / address</label>
                            <div class="am-u-sm-8">
                                ${user.shopAddress}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-4  am-text-right">电话 / phone</label>
                            <div class="am-u-sm-8">
                                ${user.phone}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-4  am-text-right">身份号码 / card number</label>
                            <div class="am-u-sm-8">
                                ${user.cardNumber}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-4  am-text-right">身份编码 / code</label>
                            <div class="am-u-sm-8">
                                ${user.code}
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-9 am-u-sm-push-3">
                                <button type="button" class="am-btn am-btn-primary" data-am-modal="{target: '#doc-modal-1', closeViaDimmer: true,closeOnConfirm:false, width: 800, height: 600}">修改信息</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>




        <!--模块框内容-->
        <div class="am-modal am-modal-no-btn" tabindex="-1" id="doc-modal-1">
            <div class="am-modal-dialog">
                <div class="am-modal-hd">
                    <strong class="am-text-primary am-text-lg">修改个人资料  </strong><small>/ Modify Personal Information</small>
                    <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
                    <hr>
                    <br><br>
                </div>


                <div class="am-modal-bd">
                    <form class="am-form am-form-horizontal" id="updateFrom" method="post" action="update">
                        <div class="am-form-group">
                            <label class="am-u-sm-5 am-text-right">真实姓名 / real name</label>
                            <div class="am-u-sm-7">
                               <input  minlength="2" value=" ${user.realName}" name="realName" type="text" required>
                            </div>
                        </div>



                        <div class="am-form-group">
                            <label class="am-u-sm-5  am-text-right">地址 / address</label>
                            <div class="am-u-sm-7">
                                <input value="${user.shopAddress}" name="shopAddress" type="text" required>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-5  am-text-right">电话 / phone</label>
                            <div class="am-u-sm-7">
                                <input value="${user.phone}" name="phone" type="number" minlength="11" maxlength="11" data-validation-message="请填写正确的手机号码" required>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-5  am-text-right">身份号码 / card number</label>
                            <div class="am-u-sm-7">
                                <input value="${user.cardNumber}" name="cardNumber" type="number" minlength="18" ata-validation-message="请填写正确的身份证号码(18位)" required>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-12">
                                <button type="submit" id="updateBtn" class="am-btn am-btn-primary" >确认修改</button>
                                <a href="javascript: void(0)" class="am-btn" data-am-modal-close>取消</a>
                            </div>
                        </div>

                    </form>
                </div><!--模块框内容-->

            </div>
        </div>
        <!--页脚-->
        <%@include file="parts/footer.jsp"%>
    </div><!--div class="admin-content"-->
</div><!--div class="am-cf admin-main"-->






<script type="text/javascript">
    $(function () {
//        $('#updateBtn').click(function () {
//            alert('开始了发送')
//            $.ajax({
//                url:"update",
//                type:"POST",
//                data:$('#updateFrom').serialize(),
//                success:function (data) {
//                    console.log(data)
//                }
//            });
//        });

        // 验证弹出信息提示
        $('#updateFrom').validator({
            onValid: function(validity) {
                $(validity.field).closest('.am-form-group').find('.am-alert').hide();
            },

            onInValid: function(validity) {
                var $field = $(validity.field);
                var $group = $field.closest('.am-u-sm-7');
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
    })
</script>
</body>
</html>
