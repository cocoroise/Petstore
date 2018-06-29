<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2018-06-06
  Time: 11:08
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
    <title>-edit-</title>
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
                                在下面修改您的个人信息：
                            </h3>
                        </div>
                        <form class="ui form segment">
                            <div class="field">
                                <label>姓名</label>
                                <input placeholder="First Name" name="name" type="text" id="input_name">
                            </div>
                            <div class="field">
                                <label>性别</label>
                                <div class="ui dropdown selection" tabindex="0">
                                    <select name="gender" id="input_gender">
                                        <option value="">性别</option>
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                    </select><i class="dropdown icon"></i>
                                    <div class="default text">性别</div>
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
                                <label>密码</label>
                                <input type="password" name="password" id="input_password">
                            </div>
                            <div class="field">
                                <label>联系方式</label>
                                <input type="tel" name="phone" id="input_phone">
                            </div>
                            <div class="ui blue submit button"
                                 onclick="startUpdate()">提交</div>
                            <div class="ui error message"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    //初始化数据
    initMessage();
    function initMessage() {
        var user_id=${currentUser.id}
        var user=getMessageById(user_id)
        $("#input_name").val(user.name)
        $("#input_email").val(user.email)
        $("#input_password").val(user.password)
        $("#input_gender option:selected").val(user.gender)
        $("#input_phone").val(user.phone)
    }
    function getMessageById(id){
        let user={}
        let userResult=''
        user.id=id
        $.ajax({
            async:false, //设置了false之后就是同步执行的
            url:'${cp}/getUserById',
            type:'POST',
            data:user,
            dataType:'json',
            success:function(result){
                userResult=result.result
            },
            error:function(result){
                layer.alert('查询错误，请重试')
            }
        })
        userResult=JSON.parse(userResult)
        return userResult
    }

    //提交更新的数据
    function startUpdate() {
        let loading=layer.load(0)
        let user={}
        user.name=$("#input_name").val()
        user.email=$("#input_email").val()
        user.password=$("#input_password").val()
        user.phone=$("#input_phone").val()
        user.gender=(($("#input_gender option:selected").val())==='male'?'男':'女')
        let registerResult=null
        //这个ajax是异步的所以我把判断逻辑放到了success回调里
        $.ajax({
            type:'POST',
            data:user,
            dataType:'json',
            success:function(result){
                registerResult=result.result
                layer.close(loading)
                layer.msg('success edit',{icon:1})
                window.location.href="${cp}"
            },
            error:function(result){
                layer.alert('error query')
            }
        })
    }
</script>

</body>
</html>
