<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2018-06-18
  Time: 18:00
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
    <title>订单页</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/main.css" rel="stylesheet" type="text/css">
    <link data-pace-options='{ "ajax": false }' href="${cp}/static/css/pace.css" rel="stylesheet"/>
    <script src="${cp}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/semantic.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/layer.js" type="text/javascript"></script>
    <script src="${cp}/static/js/main.js"></script>
    <script src="${cp}/static/js/pace.js"></script>
    <script src="${cp}/static/js/js.cookie.js"></script>
    <script src="${cp}/static/js/jquery.nicescroll.min.js"></script>
</head>
<body>
<div id="app">
    <div id="header">
        <%@include file="header.jsp" %>
    </div>
    <div class="ui container">
        <div class="row">
            <div class="twelve wide tablet twelve wide computer column">
                <div class="ui segments">
                    <div class="ui segment">
                        <h2 class="ui  header">
                            管理订单页
                        </h2>
                    </div>
                    <div class="ui segment">
                        <div class="ui pointing secondary menu tabfour stackable">
                            <a class="item active" data-tab="first">
                                全部订单
                                <div class="ui red label mini circular" id="allRecordCount">0</div>
                            </a>
                            <a class="item" data-tab="second">
                                未发货订单
                                <div class="ui red label mini circular" id="unHandleCount">0</div>
                            </a>
                            <a class="item" data-tab="third">
                                已发货订单
                                <div class="ui red label mini circular" id="handledCount">0</div>
                            </a>
                            <a class="item" data-tab="forth">
                                已收货订单
                                <div class="ui red label mini circular" id="receivedCount">0</div>
                            </a>
                        </div>
                    </div>
                    <div class="ui tab segment active" data-tab="first" id="allRecord"></div>
                    <div class="ui tab segment" data-tab="second" id="unHandleRecord"></div>
                    <div class="ui tab segment" data-tab="third" id="handledRecord"></div>
                    <div class="ui tab segment" data-tab="forth" id="receivedRecord"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(".menu .item").tab()
    let loading = layer.load(0)
    updateShoppingRecords()

    function updateShoppingRecords() {
        let orderArray = []
        orderArray[0] = "未发货"
        orderArray[1] = "配送中"
        orderArray[2] = "已收货"
        let allRecordCount = $("#allRecordCount")
        let handledCount = $("#handledCount")
        let unhandedCount = $("#unHandleCount")
        let receivedCount = $("#receivedCount")

        let allRecord = $("#allRecord")
        let handledRecord = $("#handledRecord")
        let unHandledRecord = $("#unHandleRecord")
        let receivedRecord = $("#receivedRecord")

        let allRecordCounts = Number(allRecordCount.text())
        let handledCounts = Number(handledCount.text())
        let unhandedCounts = Number(unhandedCount.text())
        let receivedCounts = Number(receivedCount.text())

        let allShoppingRecords = getShoppingRecords()

        let preHtml = `
        <div class="row">
             <div class="twelve wide column">
                <div class="ui segment">
                    <table class="ui large striped table">
                        <thead>
                           <tr>
                              <th>商品名称</th>
                              <th>数量</th>
                              <th>价格</th>
                              <th>发货状态</th>
                              <th></th>
                           </tr>
                        </thead>
                        <tbody>
        `

        let unHandleHTML = preHtml + ''
        let handledHTML = preHtml + ''
        let receivedHTML = preHtml + ''
        let allHTML = preHtml + ''

        for (let i = 0; i < allShoppingRecords.length; i++) {
            let product = getCommodityById(allShoppingRecords[i].productId)
            allHTML +=
                '<tr>' +
                '<td>' + product.name + '</td>' +
                '<td>' + allShoppingRecords[i].count + '</td>' +
                '<td>' + allShoppingRecords[i].price + '</td>' +
                '<td>' + orderArray[allShoppingRecords[i].orderStatus] + '</td>' +
                '<td></td>'+
                '</tr>' ;
            allRecordCounts++;

            //未发货
            if (allShoppingRecords[i].orderStatus === 0) {
                unHandleHTML +=
                    '<tr>' +
                    '<td>' + product.name + '</td>' +
                    '<td>' + allShoppingRecords[i].count + '</td>' +
                    '<td>' + allShoppingRecords[i].price + '</td>' +
                    '<td>' + orderArray[allShoppingRecords[i].orderStatus] + '</td>' +
                    '<td>'+
                    '<button class="ui primary button" onclick="sendCommodity('+allShoppingRecords[i].userId+','+allShoppingRecords[i].productId+',\''+allShoppingRecords[i].time+'\')">发货</button>'+
                    '</td>'+
                    '</tr>' ;
                unhandedCounts++;
                //已发货
            } else if (allShoppingRecords[i].orderStatus === 1) {
                let email = getUserEmail(allShoppingRecords[i].userId);
                var phone = getUserPhone(allShoppingRecords[i].userId)
                handledHTML +=
                    '<tr>' +
                    '<td>' + product.name + '</td>' +
                    '<td>' + allShoppingRecords[i].count + '</td>' +
                    '<td>' + allShoppingRecords[i].price + '</td>' +
                    '<td>' + orderArray[allShoppingRecords[i].orderStatus] + '</td>' +
                    '<td></td>'+
                    '</tr>' ;
                handledCounts++;
                //已收货
            } else if (allShoppingRecords[i].orderStatus === 2) {
                receivedHTML +=
                    '<tr>' +
                    '<td>' + product.name + '</td>' +
                    '<td>' + allShoppingRecords[i].count + '</td>' +
                    '<td>' + allShoppingRecords[i].price + '</td>' +
                    '<td>' + orderArray[allShoppingRecords[i].orderStatus] + '</td>' +
                    '<td></td>'+
                    '</tr>' ;
                receivedCounts++;
            }
        }

        let tailHtml=`</tbody></table></div></div></div>`;
        unHandleHTML+=tailHtml;
        handledHTML+=tailHtml;
        receivedHTML+=tailHtml
        allHTML+=tailHtml

        unhandedCount.text(unhandedCounts)
        handledCount.text(handledCounts)
        receivedCount.text(receivedCounts)
        allRecordCount.text(allRecordCounts)

        unHandledRecord.html(unHandleHTML)
        handledRecord.html(handledHTML)
        receivedRecord.html(receivedHTML)
        allRecord.html(allHTML)

        layer.close(loading)
    }

    function getShoppingRecords() {
        isLogin()
        let shoppingRecord = ""
        let user = {}
        user.id = Number(${currentUser.id})
        $.ajax({
            async: false,
            type: 'POST',
            url: "${cp}/getShoppingRecords",
            data: user,
            dataType: 'json',
            success: function (result) {
                shoppingRecord = result.result
            },
            error: function (result) {
                layer.alert('unexpected error')
            }
        })
        shoppingRecord = JSON.parse(shoppingRecord)
        return shoppingRecord
    }
    
    function sendCommodity(userId,id,time) {
        let sendResult = "";
        let shoppingRecord = {};
        shoppingRecord.userId = userId;
        shoppingRecord.productId = id;
        shoppingRecord.time = time;
        //改成已发货状态
        shoppingRecord.orderStatus = 1;
        $.ajax({
            async : false, //设置同步
            type : 'POST',
            url : '${cp}/changeShoppingRecord',
            data : shoppingRecord,
            dataType : 'json',
            success : function(result) {
                sendResult = result.result;
            },
            error : function(result) {
                layer.alert('发货错误');
            }
        });
        if(sendResult === "success")
            window.location.href = "${cp}/shopping_handle";
    }

    function getCommodityById(id) {
        let commodityResult = ""
        let commodity = {}
        commodity.id = id
        // console.log("before ajax->id:"+commodity.id)
        $.ajax({
            type: 'POST',
            async: false,
            url: '${cp}/getCommodityById',
            data: commodity,
            dataType: 'json',
            success: function (result) {
                commodityResult = result.result
            },
            error: function (result) {
                layer.alert("unexpected error")
            }
        })
        // console.log(commodityResult)
        commodityResult = JSON.parse(commodityResult)
        return commodityResult
    }

    function getUserEmail(id) {
        let email = ""
        let user = {}
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserEmail',
            data: user,
            dataType: 'json',
            success: function (result) {
                email = result.email;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        return email;
    }

    function getUserPhone(id) {
        let phone = "";
        let user = {}
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserPhone',
            data: user,
            dataType: 'json',
            success: function (result) {
                phone = result.phone;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        return phone;
    }

    function isLogin() {
        if ("${currentUser.id}" == null || "${currentUser.id}" == undefined || "${currentUser.id}" == "") {
            window.location.href = "${cp}/login";
        }
    }
</script>

</body>
</html>
