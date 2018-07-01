<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2018-07-01
  Time: 0:02
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>-管理用户-</title>
    <link href="${cp}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/main.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/pace.css" rel="stylesheet" type="text/css">
    <script src="${cp}/static/js/jquery.min.js" type="text/javascript"></script>
    <link href="${cp}/static/css/index.css" rel="stylesheet" type="text/css">
    <link href="${cp}/static/css/dataTables.semanticui.css" rel="stylesheet"
          type="text/css">
    <script src="${cp}/static/js/semantic.min.js" type="text/javascript"></script>
    <style>
        body {
            background: url("${cp}/static/img/assets/admin_bg.jpg") no-repeat 100% 100%;
        }
    </style>
<body>
<div id="app">
    <div id="header">
        <%@include file="header.jsp" %>
    </div>
    <%--main content--%>
    <div class="container">
        <div class="ui equal width aligned padded grid stackable">
            <div class="row">
                <div class="sixteen wide column">
                    <div class="ui segments">
                        <div class="ui segment">
                            <h3 class="ui header">
                                用户数据库
                            </h3>
                        </div>
                        <div class="ui segment">
                            <table id="data_table"
                                   class="editable ui compact selectable striped celled table tablet stackable"
                                   cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>姓名</th>
                                    <th>性别</th>
                                    <th>地址</th>
                                    <th>电话</th>
                                    <th>密码</th>
                                    <th>角色</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody id="show_tbody">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.nicescroll.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/js.cookie.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/main.js" type="text/javascript"></script>
<script data-pace-options='{"ajax":false}' src="${cp}/static/js/pace.js"
        type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.dataTables.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/editTable.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/dataTables.semanticui.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/layer.js" type="text/javascript"></script>

<script>
    let loading = layer.load(0)
    listAllUser()
    layer.close(loading)

    function listAllUser() {
        let allUser = getAllUsers()
        let userArea = $("#show_tbody")
        let html = ''
        for (let i = 0; i < allUser.length; i++) {
            html += `
                 <tr id="${'${allUser[i].id}'}">
                    <td>${"${allUser[i].name}"}</td>
                    <td>${"${allUser[i].sex}"}</td>
                    <td>${"${allUser[i].email}"}</td>
                    <td>${"${allUser[i].phone}"}</td>
                    <td>${"${allUser[i].password}"}</td>
                    <td>${'${allUser[i].role}'}</td>
                    <td class="del-col">
                <div class="ui buttons center aligned segment">
                <button id="delBtn"
        class="ui positive button"
            onclick="updateUser(${"${allUser[i].id}"})">save</button>
                <div class="or"></div>
                <button class= "ui negative button" onclick="deleteUser(${'${allUser[i].id}'})">delete</button>
                </div>
                </td>
                 </tr>
            `
        }

        userArea.html(html)
    }

    function getAllUsers() {
        let allUsers = '';
        let nothing = {};
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getAllUsers',
            data: nothing,
            dataType: 'json',
            success: function (result) {
                if (result != null) {
                    allUsers = result.all_user;
                }
            },
            error: function (resoult) {
                layer.alert('查询所有user错误');
            }
        });
        allUsers = JSON.parse(allUsers)
        return allUsers;
    }

    function updateUser(id) {
    // <th>姓名</th> <th>性别</th> <th>地址</th> <th>电话</th> <th>密码</th> <th>角色</th>
        let all = {}
        let allElm=$("#"+id)
        all.id =Number(id)
        all.name =$(allElm.find("td").get(0)).text().toString()
        all.sex =$(allElm.find("td").get(1)).text()
        all.email = $(allElm.find("td").get(2)).text()
        all.phone = $(allElm.find("td").get(3)).text()
        all.password = $(allElm.find("td").get(4)).text().toString()
        all.role = $(allElm.find("td").get(5)).text().toString()
        // console.log("update:id"+all.id+"name"+all.name+"sex:"+all.sex+"email:"+all.emali+"phone:"+all.phone)
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/updateUser',
            data: all,
            dataType: 'json',
            success: function (result) {
                if (result.result === 'success') {
                    layer.alert("update user success")
                    window.location.href="${cp}/admin"
                }
            },
            error: function (result) {
                layer.alert('update user错误');
            }
        });
    }

    function deleteUser(id) {
        let pet = {};
        pet.id = id;
        let deleteResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/deleteUser',
            data: pet,
            dataType: 'json',
            success: function (result) {
                deleteResult = result.result;
            },
            error: function (result) {
                layer.alert('删除商品错误');
            }
        });
        listAllUser();
    }
</script>
</body>
</html>
