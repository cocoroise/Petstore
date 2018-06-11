<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=2, user-scalable=no" name="viewport" />
    <title>Login</title>
    <link href="${pageContext.request.contextPath}/static/css/semantic.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/js/skin/default/layer.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/layer.js" type="text/javascript"></script>
</head>
<body>
<div id="header"><%@include file="header.jsp"%></div>
<div class="ui middle aligned center aligned grid">
    <div class="column">
        <h2 class="ui teal image header">
            <div class="content">
                Log-in to your account
            </div>
        </h2>
        <form class="ui large form">
            <div class="ui stacked segment">
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input id="userEmail" name="email" placeholder="E-mail address" type="text" />
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="lock icon"></i>
                        <input id="userPassword" name="password" placeholder="Password" type="password" />
                    </div>
                </div>
                <div class="ui fluid large teal button submit" onclick="onLogin()" type="submit">
                    Submit
                </div>
            </div>
            <div class="ui error message"></div>
        </form>
        <div class="ui message">
            New to us? &nbsp;<a href="${pageContext.request.contextPath}/register"> Sign Up</a>
        </div>
    </div>
</div>
<div id="footer"><%@include file="footer.html"%></div>
<style type="text/css">
    body {
        background-image: url("${pageContext.request.contextPath}/static/img/assets/login_bg.png");
        background-size: 100% 100%;
        overflow: hidden;
    }
    .content{
        margin-bottom: 10px;
        margin-top: -50px;
        font-size: xx-large;
    }
    body > .grid {
        height: 100%;
    }
    .column {
        max-width: 450px;
    }
</style>
<script>
    $(document).ready(function() {
            $('.ui.form')
                .form({
                    fields: {
                        email: {
                            identifier  : 'email',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter your e-mail'
                                },
                                {
                                    type   : 'email',
                                    prompt : 'Please enter a valid e-mail'
                                }
                            ]
                        },
                        password: {
                            identifier  : 'password',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter your password'
                                },
                                {
                                    type   : 'length[6]',
                                    prompt : 'Your password must be at least 6 characters'
                                }
                            ]
                        }
                    }
                });
        });
    function onLogin() {
        var loading=layer.load(0);
        var user={};
        var loginResult="";
        user.email=$("#userEmail").val();
        user.password=$("#userPassword").val();
        $.ajax({
            async:false,
            type:'POST',
            url:'${pageContext.request.contextPath}/doLogin',
            data:user,
            dataType:'json',
            success:function (result) {
                loginResult=result;
                layer.close(loading);
            },
            error:function (result) {
                layer.alert('unexpected error');
                layer.close(loading);
            }
        });
        // console.log("result:"+loginResult.result)
        if(loginResult.result == 'success'){
            layer.msg('login success',{icon:1});
            window.location.href="${pageContext.request.contextPath}"
        }
        else if(loginResult.result == 'unexist'){
            layer.msg('用户不存在',{icon:2});
        }
        else if(loginResult.result == 'wrong'){
            layer.msg('密码不正确',{icon:2});
        }
        else if(loginResult.result == 'fail'){
            layer.msg('服务器异常',{icon:2});
        }
    }
</script>
</body>
</html>
