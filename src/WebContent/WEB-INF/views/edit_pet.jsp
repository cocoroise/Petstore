<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>-管理宠物-</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/main.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/pace.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/static/css/index.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/dataTables.semanticui.css" rel="stylesheet"
          type="text/css">
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
        <div class="ui equal width aligned padded grid stackable">
            <div class="row">
                <div class="sixteen wide column">
                    <div class="ui segments">
                        <div class="ui segment">
                            <h3 class="ui header">
                                宠物数据库
                            </h3>
                        </div>
                        <div class="ui segment">
                            <table id="data_table"
                                   class="editable ui compact selectable striped celled table tablet stackable"
                                   cellspacing="0" width="100%">
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>type</th>
                                    <th>age</th>
                                    <th>price</th>
                                    <th>keyword</th>
                                    <th>description</th>
                                    <th>picture</th>
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

<script>
    let loading = layer.load(0)
    listAllPet()
    layer.close(loading)

    function listAllPet() {
        let allPet = getAllPets()
        let petArea = $("#show_tbody")
        let html = ''
        for (let i = 0; i < allPet.length; i++) {
            let imgURL = "${cp}/static/img/pet/" + allPet[i].id + ".jpg"
            html += `
                 <tr id="${'${allPet[i].id}'}">
                    <td >${"${allPet[i].name}"}</td>
                    <td>${"${allPet[i].type}"}</td>
                    <td >${"${allPet[i].age}"}</td>
                    <td >${"${allPet[i].price}"}</td>
                    <td >${"${allPet[i].keyWord}"}</td>
                    <td >${"${allPet[i].description}"}</td>
                    <td><img class="ui small image" src="${cp}/static/img/pet/${'${allPet[i].id}'}.jpg"></td>
                    <td class="del-col">
                <div class="ui buttons center aligned segment">
                <button id="delBtn"
        class="ui positive button"
            onclick="updatePet(${"${allPet[i].id}"})">save</button>
                <div class="or"></div>
                <button class= "ui negative button" onclick="deletePet(${'${allPet[i].id}'})">delete</button>
                </div>
                </td>
                 </tr>
            `
        }
        html += `
                 <tr class="append-row">
                    <td colspan="8" align="right">
                        <input type="button"
                        id="addBtn"
                        class="ui primary large button right floated" value="Add a new Pet">
                    </td>
                 </tr>
            `
        petArea.html(html)
    }

    function getAllPets() {
        let allPets = '';
        let nothing = {};
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getAllPets',
            data: nothing,
            dataType: 'json',
            success: function (result) {
                if (result != null) {
                    allPets = result.all_pet;
                }
            },
            error: function (resoult) {
                layer.alert('查询所有宠物错误');
            }
        });
        allPets = JSON.parse(allPets)
        return allPets;
    }

    function addPet() {
        let pet = {}
        pet.name = Number($("#pet_name").text())
        pet.age = Number($("#pet_age").text())
        pet.counts = Number($("#pet_counts").text())
        pet.price = parseFloat($("#pet_price").text())
        pet.keyword = $("#pet_keyword").text()
        pet.description = $("#pet_description").text()
        if ((pet.name | pet.age | pet.counts | pet.price | pet.keyword) === "") {
            alert("请填写完整再提交")
        } else {
            $.ajax({
                async: false,
                type: 'POST',
                url: '${cp}/addPet',
                data: pet,
                dataType: 'json',
                success: function (result) {
                    if (result.result === 'success') {
                        layer.alert("add success")
                    }
                },
                error: function (result) {
                    layer.alert('添加商品错误');
                }
            });
        }
        listAllPet()
    }

    function updatePet(id) {
        <%--,${allPet[i].name},${allPet[i].type},${allPet[i].age},${allPet[i].price},${allPet[i].keyWord},${allPet[i].description}--%>
        let all = {}
        let allElm=$("#"+id)
        all.id =Number(id)
        all.name =$(allElm.find("td").get(0)).text().toString()
        all.type =Number($(allElm.find("td").get(1)).text())
        all.age = Number($(allElm.find("td").get(2)).text())
        all.price = Number($(allElm.find("td").get(3)).text())
        all.keyword = $(allElm.find("td").get(4)).text().toString()
        all.description = $(allElm.find("td").get(5)).text().toString()
        console.log("update:id"+all.id+"name"+all.name+"type:"+all.type+"age:"+all.age+"price:"+all.price+"keyword"+all.keyword)
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/updatePet',
            data: all,
            dataType: 'json',
            success: function (result) {
                if (result.result === 'success') {
                    layer.alert("add success")
                }
            },
            error: function (result) {
                layer.alert('update商品错误');
            }
        });
        listAllPet()
    }

    function deletePet(id) {
        let pet = {};
        pet.id = id;
        let deleteResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/deletePet',
            data: pet,
            dataType: 'json',
            success: function (result) {
                deleteResult = result.result;
            },
            error: function (result) {
                layer.alert('删除商品错误');
            }
        });
        listAllPet();
    }

    function fileUpload() {
        let results = "";
        let name =(Number)($("#pet_name").parent("tr").attr("id"));
        console.log("pic name:"+name)
        $.ajaxFileUpload({
            url:'${cp}/uploadFile?name='+name,
            secureuri:false ,
            fileElementId:'productImgUpload',
            type:'POST',
            dataType : 'text',
            success: function (result){
                result = result.replace(/<pre.*?>/g, '');  //ajaxFileUpload会对服务器响应回来的text内容加上<pre style="....">text</pre>前后缀
                result = result.replace(/<PRE.*?>/g, '');
                result = result.replace("<PRE>", '');
                result = result.replace("</PRE>", '');
                result = result.replace("<pre>", '');
                result = result.replace("</pre>", '');
                result = JSON.parse(result);
                results = result.result;
                if(results === "success") {
                    layer.alert("图片上传成功", {icon: 1});
                    window.location.href = "${cp}/edit_pet";
                    //var imgPreSee = document.getElementById("imgPreSee");
                    //var imgSrc = '${cp}/img/'+name+'.jpg';
                    //imgPreSee.innerHTML +='<img src="'+imgSrc+')" class="col-sm-12 col-md-12 col-lg-12"/>';
                }
                else {
                    layer.alert("图片上传失败", {icon: 0});
                }

            },
            error: function ()
            {
                layer.alert("上传错误");
            }}
        );
    }

</script>

<script src="${pageContext.request.contextPath}/static/js/jquery.nicescroll.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/js.cookie.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/main.js" type="text/javascript"></script>
<script data-pace-options='{"ajax":false}' src="${cp}/static/js/pace.js"
        type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.dataTables.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/editTable.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/dataTables.semanticui.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/layer.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/ajaxfileupload.js" type="text/javascript"></script>

</body>
</html>