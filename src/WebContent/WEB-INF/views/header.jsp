<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=2, user-scalable=no" name="viewport" />
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/js/skin/default/layer.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/layer.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
</head>
<body>
<div class="ui borderless huge menu ">

    <a href="${pageContext.request.contextPath}" class="header item">
        <img id="head_img"
             class="ui image"
             src="${pageContext.request.contextPath}/static/img/assets/cocoroise1.png"
             alt="CocoRoise">
    </a>
    <a id="pet_show" href="${pageContext.request.contextPath}/petshow" class="item">宠物</a>
    <a id="product_show" href="${pageContext.request.contextPath}/productshow" class="item">宠物用品</a>

        <div class="ui container grid ">
            <div class="right menu item">
                <div class="ui icon input">
                    <input id="search" type="text" placeholder="Search...">
                    <i class="circular search link icon" onclick="onSearch()"></i>
                </div>
                <div class="ui dropdown item">
                    <c:if test="${empty currentUser}">
                        <img class="ui mini circular image"
                             src="${pageContext.request.contextPath}/static/img/assets/sheep_grey.png"
                             alt="label-image" />
                        <div class="menu">
                            <a class="item" href="${pageContext.request.contextPath}/login">登录</a>
                            <a class="item" href="${pageContext.request.contextPath}/register">注册</a>
                            <div class="ui divider"></div>
                            <a class="grey item">Need Help?</a>
                            <a class="item" href="${pageContext.request.contextPath}/contact">联系我们</a>
                        </div>
                    </c:if>
                    <c:if test="${not empty currentUser}">
                        <img class="ui mini circular image"
                             src="${pageContext.request.contextPath}/static/img/assets/sheep.png"
                             alt="label-image" />
                        <div class="ui text aligned">你好,${currentUser.name}</div>
                        <div class="menu">
                            <a class="item" href="${pageContext.request.contextPath}/shopping_car">购物车</a>
                            <a class="item" href="${pageContext.request.contextPath}/shopping_record">订单</a>
                            <div class="ui divider"></div>
                            <a class="item" href="${pageContext.request.contextPath}/reLogin">重新登录</a>
                            <a class="item" href="${pageContext.request.contextPath}/register">新用户注册</a>
                            <a class="item" href="${pageContext.request.contextPath}/editMessage">个人中心</a>
                            <c:if test="${currentUser.role==1}">
                                <div class="ui divider"></div>
                                <a class="item" href="${pageContext.request.contextPath}/admin">用户管理</a>
                                <a class="item" href="${pageContext.request.contextPath}/edit_pet">管理宠物</a>
                                <a class="item" href="${pageContext.request.contextPath}/shopping_handle">发货管理</a>
                            </c:if>
                            <div class="ui divider"></div>
                            <a class="grey item">Need Help?</a>
                            <a class="item" href="${pageContext.request.contextPath}/contact">联系我们</a>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</div>
<style type="text/css">

    .ui.borderless.huge.menu {
        background-color: #f8f8f8;
        margin-top: 0;
        margin-bottom:0;
        max-height: 4rem;
    }
    .ui.container.grid{
        margin-left: 0.5em!important;
        margin-top: 0;
        margin-bottom:0;
        max-height: 4rem;
    }
    .ui.menu .item{
        max-height: 4rem;
    }
    .header.item {
        background-color: white !important;
    }
    #head_img{
       max-width: 10rem;
       height: 2rem;
    }
    .ui.vertical.menu > .item {
        padding-left: 1.428em;
    }
    .ui.vertical.menu .item .title .dropdown.icon {
        float: none;
    }
    .ui.vertical.menu .item .content .item {
        padding: 0.5em 1em;
    }
    .ui.vertical.menu .header.item {
        text-transform: uppercase;
    }
    .circular.search.link.icon{
        top:0.25em!important;
    }
    .ui.text.aligned{
        margin-left: 5px;
    }
</style>
<script>
    $(document).ready(function() {
        $('.ui.dropdown').dropdown();
        $('.ui.accordion').accordion();

        // bind "hide and show vertical menu" event to top right icon button
        $('.ui.toggle.button').click(function() {
            $('.ui.vertical.menu').toggle("250", "linear")
        });
    });
    function onSearch() {
        let search={}
        search.text=$("#search").val()
        $.ajax({
            type:'POST',
            url:"${pageContext.request.contextPath}/onSearch",
            data:search,
            dataType:'json',
            success:function (result) {
                if(result.result=='success'){
                    window.location.href="${pageContext.request.contextPath}/search"
                    window.event.returnValue=false
                }
            },
            error:function (result) {
                layer.alert("search unexpected error")
            }
        })
    }
</script>
</body>
</html>
