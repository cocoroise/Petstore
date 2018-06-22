<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2018-06-18
  Time: 17:59
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
    <title>购物车</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="header">
    <%@include file="header.jsp" %>
</div>

<div class="row">
    <div class="sixteen wide column">
        <div class="ui segments">
            <div class="ui segment">
                <h5 class="ui center aligned icon header">
                    <i class="circular smile yellow icon"></i>
                    Shopping Car
                </h5>
            </div>
            <div class="ui segment">
                <table class="ui compact celled definition table tablet stackable">
                    <thead class="full-width">
                    <tr>
                        <th></th>
                        <th>商品名称</th>
                        <th>价格</th>
                        <th>数量</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="collapsing">
                            <div class="ui fitted slider checkbox">
                                <input type="checkbox" name="check_buy">
                                <label class="colored green"></label>
                            </div>
                        </td>
                        <td>John Lilki</td>
                        <td>September 14, 2013</td>
                        <td>jhlilk22@yahoo.com</td>
                    </tr>
                    </tbody>
                    <tfoot class="full-width">
                    <tr>
                        <th colspan="1">
                            <div class="ui checkbox">
                                <input type="checkbox" name="check_all">
                                <label class="colored red">全选</label>
                            </div>
                        </th>
                        <th colspan="2">
                            <div class="ui large primary labeled icon button hiddenui"
                                 onclick="perConfirm()">
                                <i class="add icon"></i> 结算
                            </div>
                        </th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>


<script>
    //更新购物车页面

    updateShoppingCar()

    //处理购物车
    function updateShoppingCar() {

    }

    function getShoppingCar() {
        isLogin()
        let shoppingCarItems = ""
        let user = {}
        user.userId = ${currentUser.id}
            $.ajax({
                async: false,
                type: 'POST',
                url: "${cp}/getShoppingCar",
                data: user,
                dataType: 'json',
                success: function (result) {
                    shoppingCarItems = result.result
                },
                error: function (result) {
                    layer.alert('unexpected error')
                }
            })
        shoppingCarItems = JSON.parse(shoppingCarItems)
        return shoppingCarItems
    }

    function deleteShoppingCar(id) {
        var item = {}
        item.userId = ${currentUser.id}
            item.commodityId = id
        var deleteResult = ""
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/deleteShoppingCar',
            data: item,
            dataType: 'json',
            success: function (result) {
                deleteResult = result.result
            },
            error: function (result) {
                layer.alert("unexpected error")
            }
        })
    }

    //购买确认
    function perConfirm() {
        let allShoppingCar = getShoppingCar()
        let buyCommodity = new Array
        let buyCommodityCounts = new Array
        let buyCounts = 0
        for (let i = 0; i < allShoppingCar.length; i++) {
            let checkBox = $("input[name='check_buy']")[allShoppingCar[i].id]
            if (checkBox.checked) {
                buyCommodity[buyCounts] = allShoppingCar[i].id
                buyCommodityCounts[buyCounts] = allShoppingCar[i].counts
                buyCounts++
            }
        }
        if (buyCounts === 0) {
            layer.msg("未选中商品", {icon: 2})
        } else {
            buyConfirm(buyCommodity, buyCommodityCounts)
        }
    }

    function buyConfirm(id, counts) {
        let address = getUserAddress(id)
        let phone = getUserPhone(id)
        let totalPrice = 0
        let html = `<div class="ui segments">
                        <div class="ui segment">
                            <div class="ui header"> 确认购买信息</div>
                        </div>
                        <div class="ui segment">
                            <div class="ui celled table tablet stackable">
                      `
        for(let i=0;i<id.length;i++){
            let item=getCommodityById(id[i])
            html+=`
            <tr>
            <th>商品： ${i+1}</th>
            <td>${item.name}</td>
            </tr>
            <tr>
            <th>价格： </th>
            <td>${item.price}</td>
            </tr>
            <tr>
            <th>数量： </th>
            <td>${counts[i]}</td>
            </tr>
            <tr>
            `
            totalPrice+=item.price*counts[i]
        }
        html+=`
        <th>总金额：</th>
        <td>${totalPrice}</td>
        </tr>
        <tr>
        <th>收获地址</th>
        <td>${address}</td>
        </tr>
        <tr>
        <th>联系电话：</th>
        <td>${phone}</td>
        </tr>
        <tfoot class="full-width">
        <tr>
              <th></th>
              <th colspan="2">
              <div class="ui right floated small primary labeled icon button hiddenui"
                         onclick="perAddToShoppingRecord(id,counts)">
                   确认购买
              </div>
              </th>
        </tr>
        </tfoot>
        </div>
        </div>
        </div>
        `
        layer.open({
            type:1,
            title:'确认订单信息',
            content:html,
            area:['700px','400px']
        })
    }

    //获取用户信息
    function getCommodityById(id, type) {
        var commodityResult = ""
        var commodity = {}
        commodity.id = id
        commodity.type = type
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
        commodityResult = JSON.parse(commodityResult)
        return commodityResult
    }

    function getUserAddress(id) {
        var address = "";
        var user = {};
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserAddress',
            data: user,
            dataType: 'json',
            success: function (result) {
                address = result.address;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        return address;
    }

    function getUserPhone(id) {
        var phoneNumber = "";
        var user = {};
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserPhone',
            data: user,
            dataType: 'json',
            success: function (result) {
                phoneNumber = result.phoneNumber;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        return phoneNumber;
    }

    //添加到订单页
    function perAddToShoppingRecord(id, counts) {
        for (let i = 0; i < id.length; i++) {
            addToShoppingRecord(id[i], counts[i])
        }
        layer.confirm('恭喜你', {
                icon: 1,
                title: '购买成功啦', btn: ['前往订单', '继续逛逛']
            },
            function () {
                window.location.href = "${cp}/shopping_record"
            },
            function (index) {
                window.location.href = "${cp}/shopping_car"
            })
    }

    function addToShoppingRecord(id, counts) {
        isLogin()
        let butResult = " "
        let shoppingRecord = {}
        shoppingRecord.userId = ${currentUser.id}
            shoppingRecord.id = id
        shoppingRecord.counts = counts
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/addShoppingRecord',
            data: shoppingRecord,
            dataType: 'json',
            success: function (result) {
                butResult = result.result
            },
            error: function (result) {
                layer.alert("unexpected error")
            }
        })
        let commodity = getCommodityById(id)
        if (butResult === "success") {
            deleteShoppingCar(id)
            layer.msg(commodity.name + "购买成功", {icon: 1})
        } else if (butResult === "unEnough") {
            layer.msg(commodity.name + "库存不足", {icon: 2})
        }
    }

    //判断是否登录
    function isLogin() {
        if ("${currentUser.id}==null" || "${currentUser.id}==undefined"
            || "${currentUser.id}" == "") {
            window.location.href = "${cp}/login"
        }
    }

</script>
<script src="${cp}/static/js/jquery.min.js" type="text/javascript"></script>
<script src="${cp}/static/js/semantic.min.js" type="text/javascript"></script>
<script src="${cp}/static/js/layer.js" type="text/javascript"></script>
</body>
</html>
