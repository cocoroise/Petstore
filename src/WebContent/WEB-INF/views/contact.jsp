<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>-contact me-</title>
    <link href="${cp}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/main.css" rel="stylesheet" />
    <link data-pace-options='{ "ajax": false }' href="${cp}/static/css/pace.css" rel="stylesheet" />
    <script src="${cp}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/jquery.address.js" type="text/javascript"></script>
    <script src="${cp}/static/js/semantic.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/js.cookie.js" type="text/javascript"></script>
    <script src="${cp}/static/js/jquery.nicescroll.min.js" type="text/javascript"></script>
</head>
<body>
<div id="app">
    <div id="header"><%@include file="header.jsp"%></div>
    <div class="mainWrap  profilepage">
        <div class="ui equal width left aligned padded grid stackable">
            <!--Site Content-->

            <div class="sixteen wide tablet sixteen wide computer column profileheader row no-padding">
                <div class="column  left floated">
                    <div class="ui items">
                        <div class="item">
                            <a class="ui small circular image">
                                <img src="${cp}/static/img/assets/crocodile_128px.png" alt="label-image" />
                                <i class="circle mini red icon avt" data-content="Offline" data-variation="inverted redli"></i>
                            </a>
                            <div class="middle aligned content hiddenui">
                                <div class="header">
                                    <i class="like icon"></i>
                                    CocoRoise
                                </div>
                                <div class="meta">
                                    Student, <i class="icon map marker"></i>Zhongshan,GuangDong
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="sixteen wide tablet sixteen wide computer column">
                    <div class="ui segments">
                        <div class="ui segment">
                            <div class="ui top attached tabular menu stackable">
                                <a class="item" data-tab="one">Sweeties</a>
                                <a class="item" data-tab="two">Cookies</a>
                                <a class="item active" data-tab="three">About Me</a>
                            </div>
                            <div class="ui bottom attached tab segment" data-tab="one">
                                sweeties
                            </div>
                            <div class="ui bottom attached tab segment" data-tab="two">
                               cookies
                            </div>
                            <div class="ui bottom attached tab segment active" data-tab="three">
                                about me
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div id="footer"><%@include file="footer.html"%></div>
</div>
<script>
    $(".avt").popup({
        position: "top center"
    });
    $(".menu .item").tab();

</script>
</body>
</html>