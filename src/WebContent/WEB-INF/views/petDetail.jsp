<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2018-06-13
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>-pet detail-</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
</head>
<body>
<div id="app">
    <%--header--%>
    <div id="header">
        <%@include file="header.jsp" %>
    </div>
    <%--main content--%>
    <div class="ui main container" style="-webkit-transition-duration: 0.1s; transition-duration: 0.1s;">
        <div class="ui internal borderless celled row grid">
            <%--img content--%>
            <div class="six wide column">
                <div class="ui segment centered aligned vertical ">
                    <div class="aligned image">
                        <img src="${cp}/static/img/pet/${currentCommodity.id}.jpg" alt="pic here">
                    </div>
                </div>
            </div>
            <%--table content--%>
            <div class="ten wide column">
                <div class="ui equal width left aligned padded grid stackable">
                    <div class="row">
                        <div class="sixteen wide mobile sixteen wide tablet sixteen wide computer column">
                            <div class="ui segments">
                                <div class="ui segment">
                                    <h5 class="ui header">
                                        宠物介绍
                                    </h5>
                                </div>
                                <div class="ui segment">
                                    <table class="ui celled table tablet stackable">
                                        <tbody>
                                        <tr>
                                            <td>姓名</td>
                                            <td>${currentCommodity.name}</td>
                                        </tr>
                                        <tr>
                                            <td>种类</td>
                                            <td>${currentCommodity.type}</td>
                                        </tr>
                                        <tr>
                                            <td>年龄</td>
                                            <td>${currentCommodity.age}</td>
                                        </tr>
                                        <tr>
                                            <td>价格</td>
                                            <td>${currentCommodity.price}</td>
                                        </tr>
                                        <tr>
                                            <td>描述</td>
                                            <td>${currentCommodity.description}</td>
                                        </tr>
                                        <tfoot class="full-width">
                                        <tr>
                                            <th></th>
                                            <td colspan="4">
                                                <div class="ui right floated  primary labeled icon button "
                                                     onclick="addShoppingCar(${currentCommodity.id})">
                                                    <i class="add icon"></i> 加入购物车
                                                </div>
                                            </td>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    body {
        overflow: hidden;
    }

    .ui.main.container {
        margin-top: 5%;
    }

    .aligned.image img {
        border-radius: .4rem;
        box-shadow: 1px 1px 3px 0 #d4d4d5, 0 0 0 1px #d4d4d5;
    }
</style>
<script>
    function addShoppingCar(commodityId) {
        judgeIsLogin()
        //pet的counts为1,每一只都是独特有名字的
        let pet = new Object
        pet.userId =Number(${currentUser.id})
        pet.productId =Number(commodityId)
        pet.type =Number(${currentCommodity.type})
        pet.counts=Number(1)
        $.ajax({
            async: false,
            url: '${cp}/addShoppingCar',
            type:'POST',
            data:pet,
            dataType: 'json',
            success: function (result) {
                if (result.result == 'success') {
                    layer.confirm('前往购物车？', {icon: 1, title: '添加成功', btn: ['前往购物车', '继续浏览']},
                        function () {
                            window.location.href = "${cp}/shopping_car";
                        },
                        function (index) {
                            layer.close(index);
                        }
                    );
                }
            }
        })
    }

    function judgeIsLogin() {
        if ("${currentUser.id}" == null || "${currentUser.id}" == undefined || "${currentUser.id}" == "") {
            window.location.href = "${cp}/login";
        }
    }
</script>
</body>
</html>
