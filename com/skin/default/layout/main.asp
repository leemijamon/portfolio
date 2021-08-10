<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/skin/default/conf/menu_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck.inc" -->
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="utf-8">
<title><%=SITE_TITLE%></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=yes">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="google-site-verification" content="<%=GOOGLE_META%>">
<meta name="naver-site-verification" content="0b9ed21d138cca1f3e3dc621652e544acbf3178d"/>
<meta name="description" content="<%=SITE_DESCRIPTION%>" />
<meta name="keywords" content="<%=SITE_KEYWORDS%>" />
<meta name="author" content="<%=CS_NAME%>" />
<meta property="og:title" content="<%=SITE_TITLE%>" />
<meta property="og:description" content="<%=SITE_DESCRIPTION%>" />

<link rel="shortcut icon" href="/skin/default/img/common/favicon.ico">
<link href="/skin/default/fonts/notosans/style.css" rel="stylesheet">
<link href="/skin/default/css/bootstrap.css" rel="stylesheet">
<link href="/skin/default/css/owl.carousel.css" rel="stylesheet">
<link href="/skin/default/css/flexslider.css" rel="stylesheet">
<link href="/skin/default/css/animate.css" rel="stylesheet">
<link href="/skin/default/css/font-awesome.css" rel="stylesheet">
<link href="/skin/default/css/style.css" rel="stylesheet">
<link href="/skin/default/css/main.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/skin/default/js/bootstrap.min.js"></script>
<script src="/skin/default/js/pack.js"></script>
<script src="/skin/default/js/Draggable.min.js"></script>
<script src="/exec/js/scripts.js"></script>
<script src="/skin/default/js/cookie.js"></script>
</head>

<body class="main header-fixed">
  <div class="pre-loader">
    <div class="load-con">
      <img src="/skin/default/img/common/logo.png" class="animated fadeInDown" alt="">
      <div class="spinner">
        <div class="bounce1"></div>
        <div class="bounce2"></div>
        <div class="bounce3"></div>
      </div>
    </div>
  </div>
  <div class="wrap">

  <!--## 팝업 /skin/default/popup/content.asp ##-->

  <!-- #include virtual = "/skin/default/userskin/top.inc" -->

  <!-- #include virtual = "/skin/default/execpage/content.asp" -->

  <!-- #include virtual = "/skin/default/items/bottom.inc" -->

  </div>

<!-- #include virtual = "/skin/default/userskin/popup.inc" -->

<div style="display:none"><iframe name='sframe' style="width:0px;height:0px;"></iframe></div>
</body>
<script src="/skin/default/js/common.js"></script>
<script src="/skin/default/js/main.js"></script>
<script src="/skin/default/js/back-to-top.js"></script>
</html>