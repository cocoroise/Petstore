<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>-admin-</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/js/skin/default/layer.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/layer.js" type="text/javascript"></script>
</head>
<body>
<div id="contextWrap">
    <div id="header"><%@include file="header.jsp"%></div>

    <div class="mainWrap">
        <div class="ui equal centered width aligned grid very padded stackable">
            <div class="row">
                <div class="ten wide tablet eight wide computer column">
                    <div class="ui segments">
                        <div class="ui segment">
                            <h3 class="ui header">
                                Please enter your information
                            </h3>
                        </div>
                        <form class="ui form segment">
                                <div class="field">
                                    <label>Name</label>
                                    <input placeholder="First Name" name="name" type="text" id="input_name">
                                </div>
                                <div class="field">
                                    <label>Gender</label>
                                    <div class="ui dropdown selection" tabindex="0">
                                        <select name="gender" id="input_gender">
                                            <option value="">Gender</option>
                                            <option value="male">Male</option>
                                            <option value="female">Female</option>
                                        </select><i class="dropdown icon"></i>
                                        <div class="default text">Gender</div>
                                        <div class="menu" tabindex="-1">
                                            <div class="item" data-value="male">Male</div>
                                            <div class="item" data-value="female">Female</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="field">
                                    <label>Email</label>
                                    <input placeholder="Email" name="email" type="email" id="input_email">
                                </div>
                                <div class="field">
                                    <label>Password</label>
                                    <input type="password" name="password" id="input_password">
                                </div>
                            <div class="field">
                                <label>Phone</label>
                                <input type="tel" name="phone" id="input_phone">
                            </div>
                            <div class="ui blue submit button"
                            onclick="onRegister()">Submit</div>
                            <div class="ui error message"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    body {
        background-image: url("${pageContext.request.contextPath}/static/img/assets/register_bg.jpg");
        background-size: 100% 100%;
        overflow: hidden;
    }
    .mainWrap{
        margin-top: 5%;
        opacity: .9;
    }
    .ui.segments:hover{
        transition: all .2s ease-in-out;
        box-shadow: 2px 2px 2px snow,-2px -2px 2px snow;
    }
</style>
<script>
    function onRegister() {
        var loading=layer.load(0)
        console.log("registering...")
        var user={}
        user.name=$("#input_name").val()
        user.gender=(($("#input_gender option:selected").val())==='male'?'男':'女')
        user.phone=$("#input_phone").val()
        user.email=$("#input_email").val()
        user.password=$("#input_password").val()
        user.role=0;
        var registerResult="";
        console.log(user)
        $.ajax({
            type:'POST',
            url:'${pageContext.request.contextPath}/doRegister',
            data:user,
            dataType:'json',
            success:function(result){
                registerResult=result.result;
                layer.close(loading);
                // 一开始提示register为Null是因为程序先执行了后面的然后ajax才返回的
                if(registerResult=='success'){
                    layer.close(loading);
                    layer.msg('register success',{icon:1});
                    window.location.href='${pageContext.request.contextPath}/login';
                }else if(registerResult=='emailExist'){
                    layer.close(loading);
                    layer.msg('email exist',{icon:2});
                }else{
                    layer.close(loading);
                    layer.msg('fail',{icon:2});
                }
            },
            error:function (result) {
                layer.alert('error');
                layer.close(loading);
            }
        })

    }
</script>
</body>
</html>