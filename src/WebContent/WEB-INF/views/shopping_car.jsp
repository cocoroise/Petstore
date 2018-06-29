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
    <script src="${cp}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/semantic.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/layer.js" type="text/javascript"></script>
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
                <table class="ui compact celled definition table tablet stackable"
                id="shoppingCarTable">
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
        let allShoppingCar=getShoppingCar()
        let shoppingCarTable=$("#shoppingCarTable")
        shoppingCarTable.innerHTML=""
        let html=`
            <thead class="full-width aligned">
                    <tr>
                        <th></th>
                        <th>商品名称</th>
                        <th>价格</th>
                        <th>数量</th>
                    </tr>
                    </thead>
            `

        for(let i=0;i<allShoppingCar.length;i++){
            let item=getCommodityById(allShoppingCar[i].productId)
            // let item_type=item.type

            html+=`
                <tbody>
                    <tr>
                        <td class="collapsing">
                            <div class="ui checkbox">
                                <input type="checkbox" name="check_buy">
                                <label class="colored green"></label>
                            </div>
                        </td>
                        <td>${"${item.name}"}</td>
                        <td>${"${item.price}"}</td>
                        <td>${"${allShoppingCar[i].counts}"}</td>
                    </tr>
                    </tbody>
            `
        }
        html+=`
            <tfoot class="full-width">
                    <tr>
                        <td colspan="1" class="collapsing">
                            <div class="ui checkbox">
                                <input type="checkbox" name="check_all">
                                <label class="colored red">全选</label>
                            </div>
                        </td>
                        <td colspan="3">
                            <div class="ui large centered primary labeled icon button "
                                 onclick="perConfirm()">
                                <i class="add icon"></i> 结算
                            </div>
                        </td>
                    </tr>
                    </tfoot>
        `
        shoppingCarTable.html(html)
    }

    function getShoppingCar() {
        isLogin()
        let shoppingCarItems = ""
        let user = {}
        user.id =Number(${currentUser.id})
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
        let item = {}
        item.userId =Number(${currentUser.id})
        item.commodityId =Number(id)
        console.log("deleteshoppingcar->userId:"+item.userId)
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/deleteShoppingCar',
            data: item,
            dataType: 'json',
            success: function (result) {
                if(result.result=='success'){
                }
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
            let id=allShoppingCar[i].productId
            let checkBox= $("input[name='check_buy']")

            //全选
            if($("input[name='check_all']").attr("checked")==true){
                console.log("all check")
                for(let j = 0; j < allShoppingCar.length; j++){
                    checkBox[i].checked=true
                }
            }

            // console.log("id:"+id+"checked:"+checkBox.getAttribute("checked"))
            if (checkBox[i].checked) {
                buyCommodity[buyCounts] = allShoppingCar[i].productId
                buyCommodityCounts[buyCounts] = allShoppingCar[i].counts
                buyCounts++
            }
        }
        if (buyCounts === 0) {
            layer.alert("未选中商品", {icon: 2})
        } else {
            buyConfirm(buyCommodity, buyCommodityCounts)
        }
    }

    function buyConfirm(id, counts) {
        console.log("buyconfirm->id:"+id+"counts"+counts)
        let userId=${currentUser.id}
        var email = getUserEmail(Number(userId))
        var phone = getUserPhone(Number(userId))
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
            <th>商品：${"${i+1}"}</th>
            <td>${"${item.name}"}</td>
            </tr>
            <tr>
            <th>价格： </th>
            <td>${"${item.price}"}</td>
            </tr>
            <tr>
            <th>数量： </th>
            <td>${"${counts[i]}"}</td>
            </tr>
            <tr>
            `
            totalPrice+=item.price*counts[i]
        }
        html+=`
        <th>总金额：</th>
        <td>${"${totalPrice}"}</td>
        </tr>
        <tr>
        <th>邮箱</th>
        <td>${"${email}"}</td>
        </tr>
        <tr>
        <th>联系电话：</th>
        <td>${"${phone}"}</td>
        </tr>
        <tfoot class="full-width">
        <tr>
              <th></th>
              <td colspan="2">
              <div class="ui  primary labeled icon button "
                         id="buy_button">
                   确认购买
              </div>
              </td>
        </tr>
        </tfoot>
        </div>
        </div>
        </div>
        `

        $("#buy_button").on("click",perAddToShoppingRecord(id,counts))

        layer.open({
            type:1,
            title:'确认订单信息',
            content:html,
            area:['700px','400px']
        })
    }


    function getCommodityById(id) {
        let commodityResult = ""
        let commodity = {}
        commodity.id = id
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

    //获取用户信息
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

    //添加到订单页
    function perAddToShoppingRecord(id, counts) {
        for (let i = 0; i < id.length; i++) {
            addToShoppingRecord(id[i], counts[i])
            deleteShoppingCar(id[i])
        }
        top.layer.confirm('恭喜你', {
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
        let buyResult = " "
        let shoppingRecord = {}
        shoppingRecord.userId =Number(${currentUser.id})
            shoppingRecord.id = Number(id)
        shoppingRecord.counts = Number(counts)
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/addShoppingRecord',
            data: shoppingRecord,
            dataType: 'json',
            success: function (result) {
                buyResult = result.result
            },
            error: function (result) {
                layer.alert("unexpected error")
            }
        })
        let commodity = getCommodityById(id)
        if (buyResult === "success") {
            layer.alert(commodity.name + "购买成功", {icon: 1})
        } else if (buyResult === "unEnough") {
            layer.alert(commodity.name + "库存不足", {icon: 2})
        }
    }

    //判断是否登录
    function isLogin() {
        if ("${currentUser.id}"==null || "${currentUser.id}"==undefined
            || "${currentUser.id}" == "") {
            window.location.href = "${cp}/login"
        }
    }

</script>
</body>
</html>
