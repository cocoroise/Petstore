<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>-product-</title>
    <link href="${cp}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/main.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/pace.css" rel="stylesheet" type="text/css">
    <script src="${cp}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/semantic.min.js" type="text/javascript"></script>
    <style>
        .ui.link.card{
            margin: 2px 2px;
        }
    </style>
</head>
<body>
<div id="app">
    <div id="header">
        <%@include file="header.jsp" %>
    </div>

    <%--main--%>
    <div class="ui equal width left aligned padded grid stackable">
        <!--Site Content-->
        <div class="row">
            <div class="sixteen wide computer column">
                <div class="ui segments">
                    <div class="ui segment">
                        <h3 class="ui header">lovely pets</h3>
                    </div>
                    <div class="ui segment fullheight">
                        <div class="blue buttons">
                            <button class="ui button" data-filter="all">All Products</button>
                            <button class="ui button" data-filter="3">Dog Use</button>
                            <button class="ui button" data-filter="4">Cat Use</button>
                            <div class="ui buttons">
                                <button class="ui button yellowli" data-shuffle>
                                    乱序
                                </button>
                                <button class="ui button redli" data-sortAsc>
                                    升序
                                </button>
                                <button class="ui button greenli" data-sortDesc>
                                    降序
                                </button>
                            </div>
                        </div>
                        <div class="ui divider"></div>
                        <div class="ui segment">
                            <div class="filtr-container">
                                <div class="ui five stackable cards" onclick="getProductDetail(event)">
                                    <div id="x" class="filtr-item"
                                         data-category="3"
                                         data-sort="value">
                                        <div class="ui link card">
                                            <div class="image">
                                                <img src="${cp}/static/img/pet/18.jpg" alt="pic"
                                                     class="transition visible">
                                            </div>
                                            <div class="content">
                                                <a data-value="18" class="header">Fromm福摩
                                                    全犬粮鸭肉甜薯蔬菜配方狗粮(5LB)2.27kg</a>
                                                <div class="meta">￥258</div>
                                                <div class="description">fromm鸭肉甜薯蔬菜配方，新鲜原料，科学配比，氨基酸成分健康皮毛，维护爱宠良好身体
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${cp}/static/js/jquery.filterizr.min.js"></script>
<script src="${cp}/static/js/js.cookie.js"></script>
<script src="${cp}/static/js/js.cookie.js"></script>
<script src="${cp}/static/js/jquery.nicescroll.min.js"></script>
<script src="${cp}/static/js/main.js"></script>
<script data-pace-options='{ "ajax": false }'
        src="${cp}/static/js/pace.js"></script>

<script>
    $(document).ready(function () {
        // filter
        var filterizd = $('.filtr-container').filterizr({
            delay: 10, delayMode: 'alternate',
            filterInCss: {
                opacity: 1,
                transform: 'scale(0.95)',
            },
        });
        $("#pet_show").removeClass("active")
        $("#product_show").addClass("active")
    })

    var loading = layer.load(0)

    //get all pet
    function getAllproducts() {
        var allProducts = ''
        var nothing = {}
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/getAllProducts',
            data: nothing,
            dataType: 'json',
            success: function (result) {
                if (result != null) {
                    allProducts = result.all_product
                } else {
                    layer.alert('error')
                }
            },
            error: function (result) {
                layer.alert('unexpected error')
            }
        })
        allProducts = JSON.parse(allProducts)
        return allProducts
    }

    //转到详情页
    function getProductDetail(e) {
        var product = {}
        product.productId =e.target.getAttribute("data-value")
        console.log("product.id:" + product.productId)
        $.ajax({
            type: 'POST',
            url: '${cp}/getProductDetail',
            async: false,
            data: product,
            dataType: 'json',
            success: function (result) {
                if (result.result == 'success') {
                    window.open("${cp}/productDetail", "_self")
                    window.event.returnValue = false
                }
            }
        })
    }

    function listProducts() {
        var all = getAllproducts()
        for (var i = 1; i < all.length; i++) {
            var type = all[i].type
            var id = all[i].productId
            var imgUrl = "${cp}/static/img/pet/" + all[i].productId + ".jpg"

            var addItem = $("#x").clone(true)
            addItem.attr("data-category", type)

            //返回的是数组
            addItem.find("img")[0].src = imgUrl
            addItem.find(".content a").text(all[i].name)
            addItem.find(".content a").attr("data-value", id)

            addItem.find(".content .meta").text("￥" + all[i].price)
            addItem.find(".content .description").text(all[i].description)

            $(".filtr-container").children().append(addItem)

        }
        layer.close(loading)
    }

    listProducts()
</script>
</body>
</html>