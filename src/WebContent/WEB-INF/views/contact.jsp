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
                                <div class="article">
                                    在花事荼靡的人生市街，敢于独自走入无人幽径的人，最能品味独处之美。虽然，红杏枝头春意闹，一直是人所向往的风景，但我愿意说，青萝拂行衣更能涌生感叹！

                                    独处，为了重新勘察距离，使自己与人情世事、锱铢生计及逝日苦多的生命悄悄地对谈。

                                    独处的时候，可怜身是眼中人，过往的人生故事一幕幕地放给自己看，挚爱过的、挣扎过的、怨恨过的情节，都可以追溯其必然。不管我们喜不喜欢那些结局，也不管我们曾经为那些故事付出多少徒然的心血，重要的是，它们的的确确是生命史册里的篇章，应该毫不羞愧、毫不逃避地予以收藏——在记忆的地下室，让它们一一陈列着，一一守口如瓶。

                                    独处，也是一种短暂的自我放逐，不是真的为了摒弃什么，也许只是在一盏茶时间，回到童年某一刻，再次欢喜；也许在一段路的行进中，揣测自己的未来；也许在独自进餐时，居然对自己小小地审判着；也许，什么事也想不起来，只有一片空白，安安静静地若有所悟。

                                    如果，你的妻子、丈夫或情侣，在一个风雨交加的夜晚，忽然拿着一把伞要出门而又无法交代去哪里，你就让他去吧。因为，再亲密的人的谈笑风生，也比不上独处时不为人知的咏叹。
                                </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script>
    $(".avt").popup({
        position: "top center"
    });
    $(".menu .item").tab();

</script>
</body>
</html>