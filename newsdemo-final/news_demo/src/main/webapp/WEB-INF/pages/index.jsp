<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%
    String path = request.getContextPath();
    request.setAttribute("path",path);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>六四一台网站</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/index.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/icon.css">
    <script type="text/javascript" src="${path}/static/js/jquery1.12.4.min.js"></script>
</head>
<body>
<div class="header">
    <div class="header-top">
        <div class="header-login">
            <c:if test="${sessionScope.user == null}">
                <form  id="login_form" method="post">
                    <label for="">用户名:</label>
                    <input type="text" name="username" required>
                    <label for="">密码:</label>
                    <input type="password" name="password" required>
                    <button type="button" id="login_btn" >登录</button>
                    <button type="button" id="register_btn">注册</button>
                </form>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <form style="padding: 9px 5px;"> 欢迎你,
                    <a style="text-decoration: none;" href="/user/userInfo" target="_blank">
                       ${sessionScope.user.realName}
                    </a>
                    <a style="text-decoration: none" href="/loginout">退出登录</a>
                </form>
            </c:if>
            <form class="search">
                <input type="text" placeholder="请输入关键词">
                <button type="submit">搜索</button>
            </form>
        </div>
    </div>
    <div class="header-text">国家广播电视总局六四一台</div>
</div>
<div class="container">
    <div class="nav">
        <c:forEach items="${sessionScope.menuList}" var="menu">
        <li>
            <a href="/newsList?menuId=${menu.menuId}" >${menu.menuName}</a>
            <ul>
                <c:forEach items="${menu.subMenuNames}" var="submenu">
                <li><a href="/newsList?submenuId=${submenu.submenuId}" >${submenu.submenuName}</a></li>
                </c:forEach>
            </ul>
        </li>
        </c:forEach>
    </div><!--nav结束-->
    <div class="banner">
        <div class="banner-text">
            <a  href="#">1习近平：开创新时代中国特色社会主义事业新局面局面88888888888888888888888888888局面88888888888888888888888888888</a>
            <a href="#">2习近平：开创新时代中国特色社会主义事业新局面888888888888888888888888888888</a>
            <a href="#">33开创新时代中国特色社会主义事业新局面888888888888888888888888888888888888888888888888888888888888</a>
        </div>
        <div class="banner-slide-img">
            <div class="banner-slide-img-1 overlap"></div>
            <div  class="banner-slide-img-2 overlap"></div>
            <div  class="banner-slide-img-3 overlap"></div>
            <div class="pre-img"></div>
            <div class="next-img"></div>
            <div class="banner-footer">
                <div class="banner-footer-title">
                    <a href="#">11习近平：开创新时代中国特色社会主义事业新局面66666666666666666666666666666666666666666</a><a href="#">22习近平：开创新时代中国特色社会主义事业新局面</a><a href="#">33习近平：开创新时代中国特色社会主义事业新局面</a>
                </div>
                <div class="dots">
                    <a href="javasrcipt:void(0)" index=0></a>
                    <a href="javasrcipt:void(0)" index=1></a>
                    <a href="javasrcipt:void(0)" index=2></a>
                </div>
            </div>
        </div>
    </div>
    <!-- 轮播图下边的内容 -->
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <div class="floor-1 clearfix">
        <div class="floor-1-left">
            <div class="floor-header">
                <span>最新发文</span>
                <a href="/newsList" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:set value="<%=System.currentTimeMillis()%>" var="now"></c:set>
                    <c:set value="<%=3*24*60*60*1000%>" var="offset"/>
                    <%--<c:out value="${offset}"/>--%>
                    <%--<c:out value="${now}"/>--%>
                    <c:forEach items="${requestScope.lastNewList}" var="news">
                        <li>
                            <span class="department">[${news.user.department.departmentName}]</span>
                            <a style="width: 373px;" href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                            <c:set value="${news.id}" var="before"></c:set>
                            <c:if test="${now-before<offset}">
                                <span style="line-height:20px;background-color: #CE002B;color: #ffffff;border-radius: 5px;">新</span>
                            </c:if>
                            <span class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate> </span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="floor-1-right">
            <div class="floor-header">
                <span>最新通知</span>
                <a href="/newsList?submenuId=18" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:set value="<%=System.currentTimeMillis()%>" var="now"></c:set>
                    <c:set value="<%=3*24*60*60*1000%>" var="offset"/>
                    <%--<c:out value="${offset}"/>--%>
                    <%--<c:out value="${now}"/>--%>
                    <c:forEach items="${requestScope.lastNotificationList}" var="news" begin="0" end="9">
                        <li>
                            <%--<span class="department">[${news.user.department.departmentName}]</span>--%>
                            <a style="width: 350px;" href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                            <c:set value="${news.id}" var="before"></c:set>
                            <c:if test="${now-before<offset}">
                                <span style="line-height:20px;background-color: #CE002B;color: #ffffff;border-radius: 5px;">新</span>
                            </c:if>
                            <span class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate> </span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <div class="floor-2 clearfix">
        <div class="floor-2-header">
            <span>留守信息</span>
            <a href="javascript:void(0)" id="lookToday">查看今日</a>
            <a href="javascript:void(0)" id="lookMoreStay">查看更多</a>
        </div>
        <div class="floor-2-body clearfix">
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>台领导</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>台办室</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>技办室</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>甲机房</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>乙机房</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>节传机房</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>人事科</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>离退科</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>行政科</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>器材科</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>维修室</a>
            <a href="javascript:void(0)" class="floor-2-body-btn" dept_modal>保卫科</a>
        </div>
    </div>
    <!-- 第三层 三栏-->
    <div class="floor-3">
        <div class="floor-3-box">
            <div class="floor-header">
                <span>传输发射</span>
                <a href="/newsList?menuId=2" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:forEach items="${requestScope.list1}" var="news" begin="0" end="5">
                        <li>
                            <a href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                            <span style="float: none" class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>部门动态</span>
                <a href="/newsList?submenuId=19" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:forEach items="${requestScope.list2}" var="news" begin="0" end="5">
                    <li>
                        <span class="department">[${news.user.department.departmentName}]</span>
                        <a style="width:322px;" href="/newsDetail?news_id=${news.id}">${news.title}</a>
                        <span class="date" style="float: none"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>党的建设</span>
                <a href="/newsList?menuId=5" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:forEach items="${requestScope.list3}" var="news" begin="0" end="5">
                        <li>
                            <a href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                            <span style="float: none" class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>技术管理</span>
                <a href="/newsList?menuId=6" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:forEach items="${requestScope.list4}" var="news" begin="0" end="5">
                        <li>
                            <a href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                            <span style="float: none" class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>安全月专题</span>
                <a href="/newsList?menuId=7" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:forEach items="${requestScope.list5}" var="news" begin="0" end="5">
                        <li>
                            <a href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                            <span style="float: none" class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>规章制度</span>
                <a href="/newsList?menuId=4" target="_blank">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:forEach items="${requestScope.list6}" var="news" begin="0" end="5">
                        <li>
                            <a href="/newsDetail?news_id=${news.id}" target="_blank">${news.title}</a>
                            <span style="float: none" class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <!-- 第四层 十九大报告 -->
    <div class="floor-4">
        <div class="floor-header">
            <span>十九大报告</span>
            <a href="#">查看更多</a>
        </div>
        <div class="floor-4-body">
            <ul>
                <li><a href="#">新闻标题新闻标题.floor-4-bodyv新闻标题新闻标题66666666666666666</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-bodyv新闻标题新闻标题</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-bodyv新闻标题新闻标题</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-bodyv新闻标题新闻标题</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-bodyv新闻标题新闻标题</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-body</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-body</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-body</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-body</a></li>
                <li><a href="#">新闻标题新闻标题.floor-4-body</a></li>
            </ul>
            <ul>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
                <li><p>新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容新闻内容</p><a href="#">[阅读全文]</a></li>
            </ul>
        </div>
    </div>
    <!-- 第五层 图片展示 -->
    <div class="floor-5">
        <div class="floor-header">
            <span>台区风采</span>
            <a href="#">查看更多</a>
        </div>
        <div class="floor-5-body"><!--十张图片的宽度-->
            <div style="display: inline-block;">
                <div class="floor-5-body-box" ><a style="background-image: url(${path}/static/images/banner1.jpg);" href="#"></a>
                </div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
                <div class="floor-5-body-box"><a href="#"></a></div>
            </div>
            <div style="display: inline-block;" ><!--十张图片的宽度-->
            <div class="floor-5-body-box"><a style="background-image: url(static/images/banner2.jpg);" href="#"></a>
            </div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
            <div class="floor-5-body-box"><a href="#"></a></div>
        </div>
    </div>
</div>

<!-- 第六层 -->
<div class="floor-6">
    <div class="floor-6-body">
        <div class="floor-6-box"><a href="#">考试系统</a></div>
        <div class="floor-6-box"><a href="#">订餐系统</a></div>
        <div class="floor-6-box"><a href="#">资产管理</a></div>
        <div class="floor-6-box"><a href="#">技术笔记</a></div>
        <div class="floor-6-box"><a href="#">意见反馈</a></div>
    </div>
</div>

</div>  <!--container 结束-->

<div class="footer">
    <div class="footer-top">
        <div class="footer-top-header">常用链接
            <div class="line"></div>
        </div>
        <div class="footer-top-body  clearfix">
            <ul>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
            </ul>
            <ul>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
            </ul>
            <ul>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
            </ul>
            <ul>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
                <li><a href="#">链接</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        Copyright © 2018 国家广播电视总局六四一台
    </div>
</div><!--footer 结束-->
<!-- 向上下滑动按钮-->

<div class="top-btn" id="btn-up">
    <span class="glyphicon glyphicon-menu-up"></span>
</div>
<div class="bottom-btn" id="btn-down">
    <span class="glyphicon glyphicon-menu-down"></span>
</div>
<%--左侧常用链接--%>
    <div class="nav-left" id="nav_left_btn">
        <span>常用链接</span>
    </div>

<!-- 留守模态框 -->
<div class="modal" id="stay_modal">
    <div class="modal-content">
        <table>
            <thead>
            <tr>
                <th>科室</th>
                <th colspan="2">留守人员</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="stayInfo" items="${requestScope.stayInfoList}">
                    <tr>
                        <td rowspan="2">${stayInfo.deptName}</td>
                        <td style="width: 150px;">白天:</td>
                        <td style='white-space: nowrap;text-align: left;color: #CE002B'>
                            <c:forEach items="${stayInfo.dayEmps}" var="emp">
                                ${emp.name}
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px;">晚上:</td>
                        <td style='white-space: nowrap;text-align: left;color: #3c763d;'>
                            <c:forEach items="${stayInfo.nightEmps}" var="emp">
                             ${emp.name}
                            </c:forEach>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
            <tr>
                <td></td>
                <td></td>
            </tr>

            </tfoot>
        </table>
    </div>
</div>

<!-- 注册模态框 -->
<div class="modal" id="register_modal">
    <div class="modal-content" style="margin-left: -250px">
        <div class="modal-content-header">
            <h3 style="display: inline-block;border-bottom: 2px solid red;height: 29px">注册</h3>
        </div>
        <form action="" id="register_form" method="post">
            <div class="form-row">
                <label for="">用户名</label>
                <input id="register_input_username" type="text" name="username" required pattern="[0-9a-zA-Z]{3,15}" minlength="3" maxlength="15"  placeholder="请输入3-15个英文数字" autofocus>

            </div>
            <div class="form-row">
                <label for="">真实姓名</label>
                <input type="text" name="realName" required pattern="[\u4e00-\u9fa5]{2,8}" placeholder="请输入2-8个中文">
            </div>
            <div class="form-row">
                <label for="">电话</label>
                <input type="text" name="phone" required pattern="[0-9]{7,11}" placeholder="请输入7-11个数字" minlength="7" maxlength="11">
            </div>
            <div class="form-row">
                <label for="">密码</label>
                <input type="password" name="password" required minlength="6" maxlength="20" placeholder="请输入6-20个字符">
            </div>
            <div class="form-row">
                <label for="">密码确认</label>
                <input type="password" name="confirm_password" required placeholder="请确认密码">
            </div>
            <div class="form-row" required>
                <label for="">部门</label>
                <select name="department.departmentId" id="">
                    <option value="1">甲机房</option>
                    <option value="2">乙机房</option>
                    <option value="3">节传机房</option>
                    <option value="4">台办室</option>
                    <option value="5">台领导</option>
                    <option value="6">技办室</option>
                    <option value="7">人事科</option>
                    <option value="8">离退科</option>
                    <option value="9">行政科</option>
                    <option value="10">器材科</option>
                    <option value="11">维修室</option>
                    <option value="12">保卫科</option>
                </select>
            </div>
            <div class="form-row">
                <div class="button-group">
                    <button id="confirm_register_btn">注册</button>
                    <button id="cancel_register">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%--常用链接的模态框--%>
<div class="modal" id="common_link_modal">
    <div class="modal-content" style="height: 200px;width: 600px;">
        <div class="modal-content-header">
            <h3>常用链接</h3>
        </div>
        <div class="modal-content-body">
            <a href="#" class="link-box">台FTP</a>
            <a href="#" class="link-box">局FTP</a>
            <a href="#" class="link-box">无线局网站</a>
            <a href="#" class="link-box">技术业务</a>
            <a href="#" class="link-box">网络办公</a>
            <a href="#" class="link-box">物资管理</a>
            <a href="#" class="link-box">教育系统</a>
            <a href="#" class="link-box">质量保证</a>
        </div>
    </div>
</div>

<%--单个部门的模态框--%>
<div class="modal" id="dept_modal">
    <div class="modal-content">
        <table>
            <thead>
            <tr>
                <th>科室</th>
                <th colspan="2">留守人员</th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td rowspan="2" deptName>保卫科</td>
                    <td style="width: 150px;">白天:</td>
                    <td style='white-space: nowrap;text-align: left;color: #CE002B' dayEmps>
                        杨威
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px;">晚上:</td>
                    <td style='white-space: nowrap;text-align: left;color: #3c763d;' nightEmps>
                        李汉明
                    </td>
                </tr>
            </tbody>
            <tfoot>
            <tr>
                <td></td>
                <td></td>
            </tr>

            </tfoot>
        </table>
    </div>
</div>






<script type="text/javascript" src="${path}/static/js/index.js"></script>
</body>
</html>
