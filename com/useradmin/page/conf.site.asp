<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc"-->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc"-->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim CMS_CONFIG_LST_Table
   CMS_CONFIG_LST_Table = "CMS_CONFIG_LST"

   Dim CC_KEY,CC_VALUE
   Dim CC_TYPE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   'SMS 잔여량 구함
   SmsCount = Sms_Count(SMS_ID,SMS_PWD)
%>

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">설정</a>
    </li>
    <li class="active">사이트설정</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">사이트설정</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-6">

      <div class="panel panel-pink">
        <div class="panel-heading"><i class="fa fa-edit"></i> 사이트설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.default.asp" -->
        </div>
      </div>

      <div class="panel panel-greenLight">
        <div class="panel-heading"><i class="fa fa-edit"></i> 보안서버/암호화 설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.ssl.asp" -->
        </div>
      </div>

    </div>
    <div class="col-sm-12 col-md-12 col-lg-6">

      <div class="panel panel-magenta">
        <div class="panel-heading"><i class="fa fa-edit"></i> 웹브라우저 타이틀설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.browser.asp" -->
        </div>
      </div>

      <div class="panel panel-blue">
        <div class="panel-heading"><i class="fa fa-edit"></i> 로고설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.logo.asp" -->
        </div>
      </div>

      <div class="panel panel-blue">
        <div class="panel-heading"><i class="fa fa-edit"></i> 검색엔진 툴</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.tools.asp" -->
        </div>
      </div>

    </div>
  </div>
</div>

<script type="text/javascript">
  runParsley();

  function runParsley(){
    $("#defaultform").parsley();
    $("#sslform").parsley();
    $("#browserform").parsley();
    $("#logoform").parsley();
    $("#toolsform").parsley();
  }
</script>

<%
   Conn.Close
   Set Conn = nothing
%>
