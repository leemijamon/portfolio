<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<link rel="stylesheet" href="/exec/ezeditor/css/editor.css" type="text/css" charset="utf-8"/>

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">회원관리</a>
    </li>
    <li class="active">메일/SMS보내기</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">메일/SMS보내기</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-6 col-lg-6">
      <iframe name="ifrm1" id="ifrm1" src="" scrolling="no" frameborder="0" style="width:100%; height:100%;" allowtransparency="false"></iframe>
    </div>
    <div class="col-sm-12 col-md-6 col-lg-6">
      <iframe name="ifrm2" id="ifrm2" src="" scrolling="no" frameborder="0" style="width:100%; height:100%;" allowtransparency="false"></iframe>
    </div>
  </div>
</div>

<script type="text/javascript">
  runEditor();

  function runEditor(){
    $("#ifrm1").attr("src","page/member.send.mail.asp");
    $("#ifrm2").attr("src","page/member.send.sms.asp");
  }

  $('#ifrm1').load(function() {
    //resize();
  });

  $('#ifrm2').load(function() {
    //resize();
  });

  function resize(){
    $('#ifrm1').css("height", $('#ifrm1').contents().find("body").height() + "px");
    $('#ifrm2').css("height", $('#ifrm2').contents().find("body").height() + 20 + "px");
    //alert("4");
  }

  function page_reload(){
    setTimeout("loadURL('member/send')",500);
  }
</script>
