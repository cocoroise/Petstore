<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2018-06-12
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <meta content="width=device-width, initial-scale=1, maximum-scale=2, user-scalable=no" name="viewport"/>
    <title>Search Page</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/js/skin/default/layer.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/layer.js" type="text/javascript"></script>
</head>
<body>
<div id="app">
    <div id="header">
        <%@include file="header.jsp" %>
    </div>
    <div class="ui aligned padded grid stackable">
        <div class="row">
            <div class="ui five wide column large icon input centered ">
                <input type="text" placeholder="Search here..." id="search_input">
                <i class="inverted circular search link icon"
                onclick="searchPre()"></i>
            </div>
        </div>

        <div class="ui divider"></div>

        <div class="row">
            <div class="fourteen wide column borderless centered">
                <div class="ui segments">
                    <div class="ui segment">
                        <h5 class="ui header">
                            Search Result
                        </h5>
                    </div>
                    <div class="ui segment">
                        <div class="ui four stackable cards"
                             onclick="getCommodityDetail(event)"
                             id="searchArea">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>

    searchInit()

    function searchInit() {
        let searchKeyWord = "${searchKeyWord}"
        $("#search_input").val(searchKeyWord)
        if (searchKeyWord !== "" && searchKeyWord !== undefined && searchKeyWord != null) {
            updateList(searchKeyWord);
        }
    }

    function searchPre() {
        let searchKeyWord = $("#search_input").val()
        updateList(searchKeyWord)
    }

    function updateList(searchKeyWord) {
        let searchArea = $("#searchArea")
        let searchResult = getSearchResult(searchKeyWord)
        let resultList = searchResult[0].concat(searchResult[1])
        let html = ''

        for (let i = 0; i < resultList.length; i++) {
            let type = resultList[i].type
            let id = type <= 2 ? resultList[i].id : resultList[i].productId
            let imgURL = "${cp}/static/img/pet/" + id + ".jpg"
            let name=resultList[i].name
            let price = resultList[i].price
            let description = resultList[i].description
            let location=type<=2?"getPetDetail(event)":"getProductDetail(event)"
            html += `
                <div id="${"${id}"}" class="ui link card">
                            <div class="image">
                                <img src="${"${imgURL}"}" alt="pic" class="transition visible">
                            </div>
                            <div class="content">
                                <a data-value="${"${id}"}" onclick="${"${location}"}" class="header">${"${name}"}</a>
                                <div class="meta">￥${"${price}"}</div>
                                <div class="description">${"${description}"}</div>
                            </div>
                        </div>
                `

        }
        searchArea.html(html)
    }

    function getSearchResult(searchKeyWord) {
        let searchResult = ''
        let search = {}
        search.text = searchKeyWord

        console.log("get search result->keyword:" + search.text)
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/searchResult',
            data: search,
            dataType: 'json',
            success: function (result) {
                searchResult = result.searchResult
                searchResult = JSON.parse(searchResult)
            },
            error: function () {
                layer.alert('查询错误');
            }
        })
        return searchResult
    }

    function getPetDetail(e) {
        var pet = {}
        pet.id = e.target.getAttribute("data-value")
        console.log("pet.id:"+pet.id)
        $.ajax({
            type: 'POST',
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
        product.productId=e.target.getAttribute("data-value")
        $.ajax({
            type: 'POST',
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
</script>


</body>
</html>
