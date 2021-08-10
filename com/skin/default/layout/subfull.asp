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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="description" content="<%=SITE_DESCRIPTION%>" />
<meta name="keywords" content="<%=SITE_KEYWORDS%>" />
<meta name="author" content="<%=CS_NAME%>" />

<link href="/exec/css/bootstrap.min.css" rel="stylesheet">
<link href="/exec/css/font-awesome.min.css" rel="stylesheet">
<link href="/exec/css/simple-line-icons.css" rel="stylesheet">
<link href="/exec/css/animate.min.css" rel="stylesheet">
<link href="/exec/css/jquery.bxslider.css" rel="stylesheet">
<link href="/exec/css/owl.carousel.css" rel="stylesheet">
<link href="/skin/default/css/style.css" rel="stylesheet">
<link href="/skin/default/css/sub.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/jquery-ui.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>
<script src="/exec/js/jquery.validate.min.js"></script>
<script src="/exec/js/messages_ko.js"></script>
<script src="/skin/default/js/back-to-top.js"></script>
<script src="/skin/default/js/sub.js"></script>
<script src="/exec/js/scripts.js"></script>
</head>

<body class="header-fixed">
<div id="wrapper">

<!-- #include virtual = "/skin/default/items/top.inc" -->

<!-- #include virtual = "/skin/default/items/title.inc" -->

  <div class="container">
<!-- #include virtual = "/skin/default/execpage/content.asp" -->
  </div>

<!-- #include virtual = "/skin/default/items/bottom.inc" -->

</div>

<div style="display:none"><iframe name='sframe' style="width:0px;height:0px;"></iframe></div>

</body>
</html>