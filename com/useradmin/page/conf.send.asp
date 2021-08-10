<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
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
    <li class="active">메일/SMS설정</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">메일/SMS설정</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-6">

      <div class="panel panel-pink">
        <div class="panel-heading"><i class="fa fa-edit"></i> 메일발송 설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.automail.asp" -->
        </div>
      </div>

      <div class="panel panel-greenLight">
        <div class="panel-heading"><i class="fa fa-edit"></i> 메일발송(SMTP) 서버설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.smtp.asp" -->
        </div>
      </div>

      <div class="panel panel-magenta">
        <div class="panel-heading"><i class="fa fa-edit"></i> SMS 설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.sms.asp" -->
        </div>
      </div>

    </div>
    <div class="col-sm-12 col-md-12 col-lg-6">

      <div class="panel panel-blue">
        <div class="panel-heading"><i class="fa fa-edit"></i> SMS발송 설정</div>
        <div class="panel-body no-padding">
<!-- #include virtual = "/admin/page/conf.autosms.asp" -->
        </div>
      </div>

    </div>
  </div>
</div>

<script type="text/javascript">
  runParsley();

  function runParsley(){
    $("#automailform").parsley();
    $("#smtpform").parsley();
    $("#smsform").parsley();
    $("#autosmsform").parsley();
  }

</script>

<%
   Conn.Close
   Set Conn = nothing
%>
