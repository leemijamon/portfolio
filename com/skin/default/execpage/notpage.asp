<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
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
<link href="/exec/css/animate.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>

<style>
html {
  -webkit-font-smoothing: antialiased;
}
body {
  background-color: #fff;
  color: #666;
  font-family: "Open Sans", sans-serif;
  font-size: 14px;
  line-height: 1.75em;
}
h1,
h2,
h3,
h4,
h5,
h6 {
  font-family: "Lato", sans-serif;
  font-weight: 300;
  line-height: 120%;
  color: #0099da;
  margin: 20px 0 17px 0;
}
h1 {
  font-size: 2.3em;
}
h2 {
  font-size: 2em;
}
h3 {
  font-size: 1.7em;
}
h4 {
  font-size: 1.4em;
}
.paper-back {
  background-image: url(/skin/default/img/breadcrumbs.png);
  background-repeat: repeat;
  position: fixed;
  height: 100%;
  width: 100%;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
}
.transparent-div {
  -webkit-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2), inset 0 0 2px #ffffff;
  -moz-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2), inset 0 0 2px #ffffff;
  box-shadow: 0 0 4px rgba(0, 0, 0, 0.2), inset 0 0 2px #ffffff;
  border: solid 1px #c3c3c3;
  background-color: rgba(255, 255, 255, 0.4);
  padding: 20px;
  color: #7e8488;
}
.transparent-div h1,
.transparent-div h2,
.transparent-div h3 {
  color: #7e8488;
}
.transparent-div h1 {
  font-size: 4em;
}
.transparent-div h2 {
  margin-bottom: 50px;
}
.transparent-div p {
  font-size: 1.2em;
  font-family: "Lato", sans-serif;
  font-weight: 300;
  margin-bottom: 25px;
}
.transparent-div .btn-ar.btn-primary {
  border: solid 1px #00638e;
  background-image: -webkit-linear-gradient(top, #0099da, #0080b6);
  background-image: -moz-linear-gradient(top, #0099da, #0080b6);
  background-image: -o-linear-gradient(top, #0099da, #0080b6);
  background-image: linear-gradient(to bottom, #0099da, #0080b6);
  font-size: 14px;
  padding-left: 30px;
  padding-right: 30px;
  border-radius: 0;
}
.absolute-center {
  height: 768px;
}
@media (min-width: 768px) {
  .absolute-center {
    width: 768px;
    height: 500px;
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    margin: auto;
  }
}

</style>
</head>
<body>

<div class="paper-back">
    <div class="absolute-center">
        <div class="text-center">
            <div class="transparent-div animated fadeInUp">
                <h1>Error 404</h1>
                <h2>Page Not Found</h2>
                <p>찾고 있는 리소스가 제거되었거나, 이름이 변경되었거나 일시적으로 사용할 수 없습니다.</p>
                <p><a href="/" class="btn btn-ar btn-primary btn-lg">Go Home</a></p>
            </div>
        </div>
    </div>
</div>

</body>
</html>