<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/29
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/7
  Time: 7:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>查看消息列表</title>

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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">查看消息列表</strong> / <small>Look Message List</small></div>
            </div>
            <hr>
            &nbsp;&nbsp;
            <%--请选择类型：--%>
            <%--<select data-am-selected onchange="window.location.href=this.value;">--%>
                <%--<option>---------</option>--%>
                <%--<option>已读信息</option>--%>
                <%--<option>未读信息</option>--%>
                <%--<option>已发送的信息</option>--%>
            <%--</select>--%>
            <br>
            <!--是否是管理员-->
            <c:set var="ifAdmin" value="${sessionScope.user.role.roleId==0}"></c:set>
            <div class="am-g">
                <div class="am-u-md-9 am-u-md-centered">
                        <table class="am-table  am-table-hover am-table-striped am-table-centered">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>主题</th>
                                <th>发送人</th>
                                <th>发送时间</th>
                                <c:if test="${ifAdmin==true}">
                                    <th>操作</th>
                                </c:if>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${requestScope.pageInfo.total == 0}">
                               <tr><td colspan="4">暂时没有消息</td></tr>
                            </c:if>
                                <!--select * from msg where to=username，显示这个用户的所有信息-->
                                <c:forEach varStatus="count" items="${requestScope.pageInfo.list}" var="message">
                                    <tr>
                                            <td>${count.count}</td>
                                            <td>
                                                <input type="hidden" value="${message.id}">
                                                <div style="display: none">${message.content}</div>
                                                <a href="#" look_detail>${message.theme}</a>
                                                <!--如果是普通用户，并且还没有读取信息-->
                                                <c:if test="${message.userIfRead==0 and sessionScope.user.role.roleId!=0}">
                                                    <span class="am-badge am-badge-danger am-radius" markspan>未读</span>
                                                </c:if>
                                                <!--如果是普通用户，并且读取信息-->
                                                <c:if test="${message.userIfRead==1 and sessionScope.user.role.roleId!=0}">
                                                    <span class="am-badge am-badge-success am-radius" markspan>已读</span>
                                                </c:if>
                                                <!--如果是管理员，并且还没有读取信息-->
                                                <c:if test="${message.adminIfRead==0 and sessionScope.user.role.roleId==0}">
                                                    <span class="am-badge am-badge-danger am-radius" markspan>未读</span>
                                                </c:if>
                                                <!--如果是普通用户，并且读取两年信息-->
                                                <c:if test="${message.adminIfRead==1 and sessionScope.user.role.roleId==0}">
                                                    <span class="am-badge am-badge-success am-radius" markspan>已读</span>
                                                </c:if>

                                            </td>
                                            <td>
                                                ${message.from}
                                            </td>
                                            <td>${message.date}</td>
                                        <c:if test="${ifAdmin==true}">
                                            <td><button class="am-btn am-btn-primary" id="msg_btn">回复</button></td>
                                        </c:if>
                                        </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                </div>
            </div><!--<div class="am-g">-->

            <!--信息具体内容的模态框-->
            <div class="am-modal am-modal-no-btn" tabindex="-1" id="msg-modal">
                <div class="am-modal-dialog">
                    <div class="am-modal-hd">
                        <small style="color: #757575;">主题：</small>
                        <strong id="theme"></strong>
                        <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
                    </div>
                    <hr data-am-widget="divider" style="" class="am-divider am-divider-dotted" />
                    <div class="am-modal-bd">
                        <small style="color: #757575;">内容：</small>
                        <textarea rows="20" cols="70" id="content" disabled></textarea>
                    </div>
                </div>
            </div>

            <!--信息具体内容的模态框-->
            <div class="am-modal am-modal-no-btn" tabindex="-1" id="return_msg_modal">
                <div class="am-modal-dialog">
                    <div class="am-modal-hd">
                        <small style="color: #757575;">主题：</small><input type="text"  id="reply_theme">
                        <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
                    </div>
                    <hr data-am-widget="divider" style="" class="am-divider am-divider-dotted" />
                    <div class="am-modal-bd">
                        <small style="color: #757575;">内容：</small>
                        <textarea id="original_content" rows="20" cols="100"></textarea>
                        <br>
                        <button id="reply_btn" class="am-btn am-btn-primary">回复</button>
                        <button id="cancel_btn" class="am-btn am-btn-default" >取消</button>
                    </div>
                </div>
            </div>


            <!--页脚-->
            <%@include file="parts/footer.jsp"%>
        </div><!--div class="admin-content"-->
    </div>
</div><!--div class="am-cf admin-main"-->

<script type="text/javascript">
    $(function () {

        $('a[look_detail]').click(function () {
            //去除未读按钮
            $('span[markspan]').removeClass("am-badge-danger").addClass("am-badge-success").text('已读');
            //弹出模态框
            $('#msg-modal').modal();
            //发送一个ajax请求标识这个内容被用户读取过了
            var id = $(this).siblings('input:eq(0)').val();
            $.ajax({
                url:"markAlreadyRead",
                type:'post',
                data:{
                    id:id,
                    role:${sessionScope.user.role.roleId}
                }
            });
            //获取要填充的数据
            var theme = $(this).text();
            var content = $(this).siblings('div').text();
            //alert(content)


            //填充数据
            $('#theme').text(theme);
            $('#content').val(content);
        });

        var data = new Object();
        //回复按钮 弹出模态框的回复
        $('#msg_btn').click(function () {
            //填充原文内容,到#original_content 的textarea
            var td = $(this).parents('tr').find('td:eq(1)');
            var theme = td.find('a').text();
            var content = td.find('div').text()
            var str = "------原文如下------\r\n主题："+theme+"\r\n内容："+content+"\r\n------------\r\n";
            $('#original_content').val(str);
            //找到发送人的账号
            var from = $(this).parents('tr').find('td:eq(-3)').text().trim();
            //填充发送数据的data
            data.to = from;
            data.from = '${sessionScope.user.username}';
            data.theme = theme;
            //弹出模态框
            $('#return_msg_modal').modal({
                width:1000,
                height:800
            });
        });


        //取消模态框的按钮
        $('#cancel_btn').click(function () {
            $('#return_msg_modal').modal('close');
        });
        //确认回复按钮  真正发送post请求的按钮
        $('#reply_btn').click(function () {
            //检查信息的正确性
            data.content = $('#original_content').val();
            data.theme = $('#reply_theme').val();
            if(data.theme==""){
                return
            }
            //发送post请求
            $.ajax({
                url:'sendMessage',
                type:'post',
                data:data
            })
            alert('回复成功');
            //关闭模态框
            $('#return_msg_modal').modal('close');
        })
    })
</script>
</body>
</html>

