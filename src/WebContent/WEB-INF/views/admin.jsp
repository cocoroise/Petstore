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
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/semantic.min.js" type="text/javascript"></script>
</head>
<body>
    <div id="contextWrap">
    <div id="header"><%@include file="header.jsp"%></div>

    <div class="mainWrap">
        <div class="ui equal width left aligned padded grid stackable">
            <div class="row">
                <div class="sixteen wide tablet eight wide computer column">
                    <div class="ui segments">
                        <div class="ui segment">
                            <h5 class="ui header">
                                Please enter your information
                            </h5>
                        </div>
                        <form class="ui form segment form1">
                            <p>Tell Us About Yourself</p>
                            <div class="two fields">
                                <div class="field">
                                    <label>Name</label>
                                    <input placeholder="First Name" name="name" type="text">
                                </div>
                                <div class="field">
                                    <label>Gender</label>
                                    <div class="ui dropdown selection" tabindex="0">
                                        <select name="gender">
                                            <option value="">Gender</option>
                                            <option value="male">Male</option>
                                            <option value="female">Female</option>
                                        </select><i class="dropdown icon"></i><div class="default text">Gender</div><div class="menu" tabindex="-1"><div class="item" data-value="male">Male</div><div class="item" data-value="female">Female</div></div>
                                    </div>
                                </div>
                            </div>
                            <div class="two fields">
                                <div class="field">
                                    <label>Email</label>
                                    <input placeholder="Email" name="email" type="email">
                                </div>
                                <div class="field">
                                    <label>Password</label>
                                    <input type="password" name="password">
                                </div>
                            </div>
                            <div class="field">
                                <label>Phone</label>
                                <input type="tel" name="phone" id="phone">
                            </div>
                            <div class="inline field">
                                <div class="ui checkbox">
                                    <input type="checkbox" name="terms" tabindex="0" class="hidden">
                                    <label>I agree to the terms and conditions</label>
                                </div>
                            </div>
                            <div class="ui blue submit button">Submit</div>
                            <div class="ui error message"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div id="footer"><%@include file="footer.html"%></div>
</body>
</html>