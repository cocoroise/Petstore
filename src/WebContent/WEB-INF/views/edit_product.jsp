<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>-管理商品-</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/index.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/main.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/dataTables.semanticui.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/pace.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
    <style>
        body {
            background: url("${pageContext.request.contextPath}/static/img/assets/admin_bg.jpg") no-repeat 100% 100%;
        }
    </style>
</head>
<body>
<div id="app">
    <div id="header">
        <%@include file="header.jsp" %>
    </div>
    <%--main content--%>
    <div class="container">
        <div class="row">
            <div class="fourteen wide column">
                <div class="ui segments">
                    <div class="ui segment">
                        <h3 class="ui header">
                            宠物用品数据库
                        </h3>
                    </div>
                    <div class="ui segment">
                        <table id="data_table" class="ui compact selectable striped celled table tablet stackable"
                               cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>type</th>
                                <th>price</th>
                                <th>counts</th>
                                <th>keyword</th>
                                <th>description</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Kylynn Peck</td>
                                <td>(09) 3054 1828</td>
                                <td>Donec Est LLC</td>
                                <td>Colombia</td>
                                <td>Sed.nec@enim.net</td>
                                <td>$2966.98</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>

<script src="${pageContext.request.contextPath}/static/js/jquery.nicescroll.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/main.js" type="text/javascript"></script>
<script data-pace-options='{"ajax":false}' src="${pageContext.request.contextPath}/static/js/pace.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.dataTables.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/mindmup-editabletable.js" type="text/javascript"></script>
<script>

</script>
</body>
</html>