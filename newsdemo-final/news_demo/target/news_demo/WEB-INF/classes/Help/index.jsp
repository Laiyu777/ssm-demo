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
            <a href="#" index=0>${menu.menuName}</a>
            <ul>
                <c:forEach items="${menu.subMenuNames}" var="submenu">
                <li><a href="#">${submenu.submenuName}</a></li>
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
                <a href="#">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <c:forEach items="${requestScope.lastNewList}" var="news">
                        <li>
                            <span>[${news.user.department.departmentName}]</span>
                            <a href="#">${news.title}</a>
                            <span style="line-height:20px;background-color: #CE002B;color: #ffffff;border-radius: 5px;">新</span>
                            <span class="date"><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate> </span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="floor-1-right">
            <div class="floor-header">
                <span>最新通知</span>
                <a href="#">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <li>
                        <a href="#">新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题</a>
                        <span>2018-5-21</span>
                    </li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="floor-2 clearfix">
        <div class="floor-2-header">
            <span>留守信息</span><a href="javascript:void(0)">查看全部</a>
        </div>
        <div class="floor-2-body clearfix">
            <a href="#" class="floor-2-body-btn">台领导</a>
            <a href="#" class="floor-2-body-btn">台办室</a>
            <a href="#" class="floor-2-body-btn">技办室</a>
            <a href="#" class="floor-2-body-btn">甲机房</a>
            <a href="#" class="floor-2-body-btn">乙机房</a>
            <a href="#" class="floor-2-body-btn">节传机房</a>
            <a href="#" class="floor-2-body-btn">人事科</a>
            <a href="#" class="floor-2-body-btn">离退科</a>
            <a href="#" class="floor-2-body-btn">行政科</a>
            <a href="#" class="floor-2-body-btn">器材科</a>
            <a href="#" class="floor-2-body-btn">维修室</a>
            <a href="#" class="floor-2-body-btn">保卫科</a>
        </div>
    </div>
    <!-- 第三层 三栏-->
    <div class="floor-3">
        <div class="floor-3-box">
            <div class="floor-header">
                <span>传输发射</span>
                <a href="#">查看更多</a>
            </div>
            <div class="floor-body">
                <ul>
                    <li><a href="#">新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>部门动态</span>
                <a href="#">查看更多</a></div>
            <div class="floor-body">
                <ul>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>

                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>党的建设</span>
                <a href="#">查看更多</a></div>
            <div class="floor-body">
                <ul>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>技术管理</span>
                <a href="#">查看更多</a></div>
            <div class="floor-body">
                <ul>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>安全月专题</span>
                <a href="#">查看更多</a></div>
            <div class="floor-body">
                <ul>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                </ul>
            </div>
        </div>
        <div class="floor-3-box">
            <div class="floor-header"><span>精神文明</span>
                <a href="#">查看更多</a></div>
            <div class="floor-body">
                <ul>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
                    <li><a href="#">新闻标题新闻标题</a><span>2018-5-21</span></li>
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

<!-- 留守模态框 -->
<div class="modal" id="stay_modal">
    <div class="modal-content">
        <table>
            <thead>
            <th>科室</th>
            <th>留守人员</th>
            </thead>
            <tbody>
            <tr>
                <td>台领导</td>
                <td>小明，小红</td>
            </tr>
            <tr>
                <td>台办室</td>
                <td>小明，小红</td>
            </tr>
            <tr>
                <td>技办室</td>
                <td>小明，小红</td>
            </tr>
            <tr>
                <td>甲机房</td>
                <td></td>
            </tr>
            <tr>
                <td>乙机房</td>
                <td>小明，小红,小明，小红小,xiaomign</td>
            </tr>
            <tr>
                <td>节传机房</td>
                <td>小明，小红</td>
            </tr>
            <tr>
                <td>人事科</td>
                <td>小明，小红</td>
            </tr>
            <tr>
                <td>离退科</td>
                <td>小明，小红</td>
            </tr>
            <tr>
                <td>行政科</td>
                <td>小明，小红</td>
            </tr>
            <tr>
                <td>器材科</td>
                <td></td>
            </tr>
            <tr>
                <td>维修室</td>
                <td></td>
            </tr>
            <tr>
                <td>保卫科</td>
                <td></td>
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









<script type="text/javascript" src="${path}/static/js/index.js"></script>
</body>
</html>
