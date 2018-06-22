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
    <div class="ui equal width left aligned padded grid">
        <!--Site Content-->
        <div class="row">
            <div class="sixteen wide computer column">
                <div class="ui segments">
                    <div class="ui segment">
                        <h3 class="ui header">lovely pets</h3>
                    </div>
                    <div class="ui segment fullheight">
                        <div class="blue buttons">
                            <button class="ui button" data-filter="all">All Pets</button>
                            <button class="ui button" data-filter="1">Dogs</button>
                            <button class="ui button" data-filter="2">Cats</button>

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
                        <div class="ui segement">
                            <div class="filtr-container">
                                <div class="ui five stackable cards" onclick="getPetDetail(event)">
                                    <div id="x" class="filtr-item"
                                         data-category="1"
                                         data-sort="value">
                                        <div class="ui link card">
                                            <div class="image">
                                                <img src="${cp}/static/img/pet/1.jpg" alt="pic"
                                                     class="transition visible">
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
        $("#pet_show").addClass("active")
        $("#product_show").removeClass("active")
    })


    var loading = layer.load(0)

    //get all pet
    function getAllpets() {
        var allPets = ''
        var nothing = {}
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/getAllPets',
            data: nothing,
            dataType: 'json',
            success: function (result) {
                if (result != null) {
                    allPets = result.all_pet
                } else {
                    layer.alert('error')
                }
            },
            error: function (result) {
                layer.alert('unexpected error')
            }
        })
        allPets = JSON.parse(allPets)
        return allPets
    }

    //转到详情页
    function getPetDetail(e) {
        var pet = {}
        pet.id = e.target.getAttribute("data-value")
        console.log("pet.id:" + pet.id)
        $.ajax({
            type: 'GET',
            url: '${cp}/getPetDetail',
            async: false,
            data: pet,
            dataType: 'json',
            success: function (result) {
                if (result.result == 'success') {
                    window.open("${cp}/petDetail", "_self")
                    window.event.returnValue = false
                }
            }
        })
    }

    function listPets() {
        var all = getAllpets()
        for (var i = 1; i < all.length; i++) {
            var type = all[i].type
            var id = all[i].id
            var imgUrl = "${cp}/static/img/pet/" + all[i].id + ".jpg"

            var addItem = $("#x").clone(true)
            //返回的是数组
            addItem.find("img")[0].src = imgUrl

            addItem.find(".content a").text(all[i].name)
            addItem.find(".content a").attr("data-value", id)
            addItem.attr("data-category", type)

            addItem.find(".content .meta").text("￥" + all[i].price)
            addItem.find(".content .description").text(all[i].description)

            $(".filtr-container").children().append(addItem)

        }

        layer.close(loading)
    }

    listPets()
</script>
</body>
</html>