<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>--CocoRoise Pet Store--</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
</head>
<body>
<div id="app">
    <div id="header">
        <%@include file="header.jsp" %>
    </div>


    <div class="ui internal borderless celled row grid ">
        <%--nav bar--%>
        <div class="two wide column">
            <div id="menu" class="ui vertical aligned pointing menu">
                <a href="#dogs" class="active item">Dogs</a>
                <a href="#cats" class="item">Cats</a>
                <a href="#dog_use" class="item">Dogs Use</a>
                <a href="#cat_use" class="item">Cats Use</a>
            </div>
        </div>

        <%--content--%>
        <div class="fourteen wide column borderless">
            <%--dogs--%>
            <div class="ui segments">
                <div class="ui segment">
                    <h5 class="ui header">
                        Dogs
                    </h5>
                </div>
                <div id="dogs" class="ui segment">
                    <div class="ui five stackable cards" onclick="getPetDetail(event)">
                        <div id="1" class="ui link card">
                            <div class="image">
                                <img src="${cp}/static/img/pet/1.jpg" alt="pic" class="transition visible">
                            </div>
                            <div class="content">
                                <a data-value="1" href="" class="header">Coco</a>
                                <div class="meta">￥2000</div>
                                <div class="description">柯基 品种纯正 宠物级</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--cats--%>
            <div class="ui segments">
                <div class="ui segment">
                    <h5 class="ui header">
                        Cats
                    </h5>
                </div>
                <div id="cats" class="ui segment">
                    <div class="ui five stackable cards" onclick="getPetDetail(event)">
                    </div>
                </div>
            </div>
            <%--dog use--%>
            <div class="ui segments">
                <div class="ui segment">
                    <h5 class="ui header">
                        Dog-use
                    </h5>
                </div>
                <div id="dog_use" class="ui segment">
                    <div class="ui five stackable cards" onclick="getProductDetail(event)">
                    </div>
                </div>
            </div>
            <%--cat use--%>
            <div class="ui segments">
                <div class="ui segment">
                    <h5 class="ui header">
                        Cats-use
                    </h5>
                </div>
                <div id="cat_use" class="ui segment">
                    <div class="ui five stackable cards" onclick="getProductDetail(event)">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    #menu {
        position: fixed;
        border: 1px gainsboro solid;
        box-shadow:2px 2px 2px #00B5AD ;
        width: auto;
        transition: all .3s ease-in-out;
    }
</style>
<script>
    var loading = layer.load(0)

    //往页面里填返回的东西
    function listCommodity() {
        //因为是两个数组，pet在0，product在1
        var temp=getAllCommodity()
        var all_pet = temp[0]
        var all_product = temp[1]
        var all = all_pet.concat(all_product)

        for (var i = 1; i < all.length; i++) {
            var type = all[i].type
            var id =type<=2? all[i].id:all[i].productId

            var imgUrl = type <= 2 ? ("${cp}/static/img/pet/" + all[i].id + ".jpg")
                : ("${cp}/static/img/pet/" + all[i].productId + ".jpg")

            //复制结点，改变属性然后append到它的child里面
            var addItem = $("#1").clone(true)
            //返回的是数组
            addItem.find("img")[0].src = imgUrl

            addItem.find(".content a").text(all[i].name)
            addItem.find(".content a").attr("data-value",id)

            addItem.find(".content .meta").text("￥" + all[i].price)
            addItem.find(".content .description").text(all[i].description)

            if (type === 1) {
                var dogArea = $("#dogs").children()
                dogArea.append(addItem)
            } else if (type === 2) {
                var catArea = $("#cats").children()
                catArea.append(addItem)
            } else if (type === 3) {
                // console.log("type=3:"+all)
                var dogUseArea = $("#dog_use").children()
                dogUseArea.append(addItem)
            } else if (type === 4) {
                var catUseArea = $("#cat_use").children()
                catUseArea.append(addItem)
            }
        }

        layer.close(loading)
    }

    function getAllCommodity() {
        var allCommodity = null
        //即使不传东西也要给个{}过去
        var nothing = {}
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/getAllCommodity',
            data: nothing,
            dataType: 'json',
            success: function (result) {
                if (result != null) {
                    allCommodity = result.all
                } else {
                    layer.alert('error')
                }
            },
            error: function (result) {
                layer.alert('unexpected error')
            }
        })

        //分清楚用parse还是stringify
        allCommodity = JSON.parse(allCommodity)
        return allCommodity
    }

    //转到详情页
    function getPetDetail(e) {
        var pet = {}
        pet.id = e.target.getAttribute("data-value")
        console.log("pet.id:"+pet.id)
        $.ajax({
            type: 'GET',
            url: '${cp}/getPetDetail',
            async: false,
            data: pet,
            dataType: 'json',
            success: function (result) {
                if(result.result=='success'){
                    <%--document.location.href="${cp}/petDetail"--%>
                    window.open("${cp}/petDetail","_self")
                    window.event.returnValue=false
                }
            }
        })

    }
    function getProductDetail(e) {
        var product={}
        product.id=e.target.getAttribute("data-value")
        $.ajax({
            type: 'GET',
            url: '${cp}/getProductDetail',
            async: false,
            data: product,
            dataType: 'json',
            success: function (result) {
                if (result.result === 'success') {
                    window.open('${cp}/productDetail','_self')
                    window.event.returnValue=false
                }
            }
        })
    }

    //入口
    listCommodity()
</script>
</body>
</html>