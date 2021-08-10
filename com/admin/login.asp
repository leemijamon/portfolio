<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   IDSAVE = Request.Cookies("AdminInfo")("idsave")

   IN_FOCUS = "window.document.focus();"

   If Request.Cookies("AdminInfo")("adm_id") <> "" Then
      ADM_ID = Request.Cookies("AdminInfo")("adm_id")
      IN_FOCUS = "document.form1.adm_pwd.focus();"
   End If

   If Request.Cookies("AdminLogin")("ADM_ID") <> "" Then
      ADM_ID = Request.Cookies("AdminLogin")("ADM_ID")
      ADM_PWD = Request.Cookies("AdminLogin")("ADM_PWD")
   End If
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<title>Admin Version 2.0 Demo</title>

<!-- Core CSS - Include with every page -->
<link href="/exec/css/bootstrap.min.css" rel="stylesheet">
<link href="/exec/css/font-awesome.min.css" rel="stylesheet">

<!-- Admin CSS - Include with every page -->
<link href="css/admin.css" rel="stylesheet">
<style type="text/css">
html, body {
  height: 100%;
}
</style>

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/jquery-ui.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>
<script src="/exec/js/parsley.js"></script>
<script src="js/admin.js"></script>
</head>

<body id="login">

<div class="wrapper full-page-wrapper page-login text-center">
  <header id="header">
    <h1 id="site-logo">
      <img src="images/logo.png" alt="Site Logo" />
    </h1>
  </header>

  <div class="inner-page">

    <div class="login-box center-block no-padding">

        <form id="login-form" target="sframe" method="post" class="form client-form" data-parsley-validate>
        <input type="hidden" name="action" value="admin.login">
          <header>
            로그인
          </header>

          <fieldset>
            <section>
              <label class="label">아이디</label>
              <label class="input"> <i class="icon-append fa fa-user"></i>
                <input type="input" name="adm_id" value="<%=ADM_ID%>" tabIndex="1" data-parsley-type="alphanum" data-parsley-length="[3, 15]" data-parsley-error-message="<strong>아이디</strong>를 입력하세요." required>
                <b class="tooltip tooltip-top-right"><i class="fa fa-user color-teal"></i> 아이디를 입력하세요.</b></label>
            </section>

            <section>
              <label class="label">비밀번호</label>
              <label class="input"> <i class="icon-append fa fa-lock"></i>
                <input type="password" name="adm_pwd" value="<%=ADM_PWD%>" tabIndex="2" data-parsley-length="[4, 15]" data-parsley-error-message="<strong>비밀번호</strong>를 입력하세요." required>
                <b class="tooltip tooltip-top-right"><i class="fa fa-lock color-teal"></i> 비밀번호를 입력하세요.</b> </label>
            </section>

            <section>
              <label class="checkbox">
                <input type="checkbox" id="idsave" name="idsave" value="1">
                <i></i>아이디저장</label>
            </section>
          </fieldset>
          <footer>
            <button type="submit" class="btn btn-primary" tabIndex="3">
              로그인
            </button>
          </footer>
        </form>

    </div>
  </div>
  <div class="push-sticky-footer"></div>
</div>

<footer class="footer login-footer">
  Helloweb Admin designed and created by Hellweb.co.kr ⓒ 2014
</footer>


<script type="text/javascript">
  $(function() {
    $("#login-form").parsley();

<% If IDSAVE = "1" Then %>
    $("input:checkbox[name='idsave']").attr("checked", true);
<% End If %>
  });
</script>

<div style="display:none"><iframe name='sframe' style="width:0px;height:0px;"></iframe></div>

</body>
</html>
