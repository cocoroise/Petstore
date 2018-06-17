<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8" />
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=2, user-scalable=no" name="viewport" />
    <title>404 | error</title>
    <link href="${cp}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/default.css" rel="stylesheet" type="text/css">
    <script src="${cp}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/static/js/semantic.min.js" type="text/javascript"></script>
</head>
<body>
<div class="error404">
<div class="ui container" style="padding-top:5%">
    <div class="ui grid center aligned">
        <div class="row">
            <div class="sixteen wide tablet ten wide computer column">
                <div class="ui container center aligned errorcontainer">
                    <h1 class="ui header inverted">
                        Oooops! Sorry The Page Not Found :(
                    </h1>
                    <a class="ui button" href="${cp}">
                        Return the Homepage
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<style>
    .error404{
        background: url("${cp}/static/img/assets/404.png") no-repeat top center #6a8733 !important;
        background-size: cover;
        width:100%;
        min-height: 100%;
        overflow: hidden;
    }
</style>
</body>
</html>
