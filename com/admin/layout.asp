<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc"-->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc"-->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   'SMS 잔여량 구함
   SmsCount = Sms_Count(SMS_ID,SMS_PWD)

   HST_IP = Request.ServerVariables("Remote_Addr")
   MALL_URL = Request.ServerVariables("SERVER_NAME")
   HST_WEB_INDEX = Request.ServerVariables("INSTANCE_ID")

   HST_PATH = Server.MapPath("/")
   SP_PATH = Split(HST_PATH,"\")
   SP_CNT = UBound(SP_PATH)
   HST_USER_ID = SP_PATH(SP_CNT)

'   ACCESS_URL = "http://custom.helloweb.co.kr/exec/mall/check.asp?mall_url=" & MALL_URL & "&hst_web_index=" & HST_WEB_INDEX & "&hst_user_id=" & HST_USER_ID
'   ACCESS_VAL = GetHTMLBin(ACCESS_URL)
'   MALL_CHECK = Split(ACCESS_VAL,"|")

'   HST_DOMAIN = MALL_CHECK(0)
'   HST_WDATE = MALL_CHECK(1)
'   HST_EDATE_TXT = MALL_CHECK(2)
'   HST_EDAY_TXT = MALL_CHECK(3)
'   HSVC_NAME = MALL_CHECK(4)
'   HST_HDD_USE_SIZE = MALL_CHECK(5)
'   HST_HDD_MAX_SIZE = MALL_CHECK(6)
'   HST_TRAFFIC_USE_SIZE = MALL_CHECK(7)
'   HST_TRAFFIC_MAX_SIZE = MALL_CHECK(8)

'   If HST_EDAY_TXT <> "무제한" Then HST_EDATE_TXT = HST_EDATE_TXT & " (" & HST_EDAY_TXT & ")"

   Dim DbConn
   Set DbConn = Server.CreateObject("ADODB.Connection")
   DbConn.Open Application("connect")

   'DB정보
   SQL = "SELECT SIZE, MAXSIZE, GROWTH FROM SYSFILES WHERE FILEID = 1"
   Set Rs = DbConn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      DB_SIZE = Rs("SIZE")
      DB_MAXSIZE = Rs("MAXSIZE")
      DB_GROWTH = Rs("GROWTH")
   End If
   Rs.close

   DbConn.Close
   Set DbConn = nothing

   '폴더사용량
   SiteFolder = Server.MapPath("/")

   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set sfolder = fso.GetFolder(SiteFolder)
   SiteSize = sfolder.size
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>[ <%=CS_NAME%> Admin Version 3.0]</title>

<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
<!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!--[if lt IE 8]>
<script src="/exec/js/srcset.min.js"></script>
<![endif]-->

<link href="/exec/css/bootstrap.min.css" rel="stylesheet">
<link href="/exec/css/font-awesome.min.css" rel="stylesheet">
<link href="/exec/css/jquery-ui.custom.css" rel="stylesheet">
<link href="css/nestedsortablewidget.css" rel="stylesheet">
<link href="css/admin.css" rel="stylesheet">

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/jquery-ui.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>
<script src="/exec/js/jquery.validate.min.js"></script>
<script src="/exec/js/messages_ko.js"></script>
<script src="/exec/js/parsley.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<link rel="stylesheet" href="/exec/ezeditor/css/editor.css" type="text/css" charset="utf-8"/>
<script src="/exec/ezeditor/js/editor_loader.js"></script>

<script src="js/admin.js"></script>
</head>

<body>
<div id="wrapper">

  <header id="header">
    <h1 id="site-logo">
      <a href="#index">
        <img src="images/logo.png" alt="Site Logo" />
      </a>
    </h1>

    <a href="javascript:;" data-toggle="collapse" data-target=".top-bar-collapse" id="top-bar-toggle" class="navbar-toggle collapsed">
      <i class="fa fa-cog"></i>
    </a>

    <a href="javascript:;" data-toggle="collapse" data-target=".sidebar-collapse" id="sidebar-toggle" class="navbar-toggle collapsed">
      <i class="fa fa-bars"></i>
    </a>
  </header> <!-- header -->

  <nav id="top-bar" class="collapse top-bar-collapse">
    <ul class="nav navbar-nav pull-right">
      <li>
        <a href="#index">
          <i class="fa fa-home"></i> 관리자 메인페이지
        </a>
      </li>
      <li>
        <a href="skin.asp" target="_blank">
          <i class="fa fa-desktop"></i> 홈페이지 바로가기
        </a>
      </li>
      <!--li>
        <a href="#member/calendar">
          <i class="fa fa-mobile"></i> 일정관리
        </a>
      </li-->
      <li>
        <a href="javascript:opensms('');">
          <i class="fa fa-mobile"></i> SMS
        </a>
      </li>
      <li>
        <a href="javascript:openprofile();">
          <i class="fa fa-user"></i> My Profile
        </a>
      </li>
      <li>
        <a href="#" id="logout">
          <i class="fa fa-sign-out"></i> Logout
        </a>
      </li>
    </ul>
  </nav> <!-- top-bar -->

  <div id="sidebar-wrapper" class="collapse sidebar-collapse side-content">
    <nav id="sidebar">
      <ul id="main-nav" class="open-active">
        <li class="notop">
          <a href="index">
            <i class="fa fa-home"></i>
            메인페이지
          </a>
        </li>

        <li class="dropdown">
          <a href="#">
            <i class="fa fa-desktop"></i>
            디자인관리
            <span class="caret"></span>
          </a>
          <ul class="sub-nav">
            <li>
              <a href="skin/active">
                <i class="fa fa-desktop"></i>
                스킨
              </a>
            </li>
            <li>
              <a href="skin/editor">
                <i class="fa fa-edit"></i>
                스킨 편집
              </a>
            </li>
            <li>
              <a href="skin/page">
                <i class="fa fa-clipboard"></i>
                페이지 관리
              </a>
            </li>
            <li>
              <a href="skin/menu">
                <i class="fa fa-list"></i>
                메뉴 관리
              </a>
            </li>
            <li class="">
              <a href="skin/image">
                <i class="fa fa-picture-o"></i>
                이미지 관리
              </a>
            </li>
          </ul>
        </li>

        <li class="dropdown">
          <a href="#">
            <i class="fa fa-users"></i>
            회원관리
            <span class="caret"></span>
          </a>

          <ul class="sub-nav">
            <li>
              <a href="member/list">
                <i class="fa fa-user"></i>
                회원리스트
              </a>
            </li>
            <li>
              <a href="member/conf">
                <i class="fa fa-cog"></i>
                회원가입관리
              </a>
            </li>
            <li>
              <a href="member/group">
                <i class="fa fa-users"></i>
                회원그룹관리
              </a>
            </li>
            <li>
              <a href="member/secede">
                <i class="fa fa-trash-o"></i>
                회원탈퇴내역
              </a>
            </li>
            <li>
              <a href="member/send">
                <i class="fa fa-envelope-o"></i>
                메일/SMS보내기
              </a>
            </li>
          </ul>
        </li>

        <li class="dropdown">
          <a href="#">
            <i class="fa fa-list-alt"></i>
            컨텐츠관리
            <span class="caret"></span>
          </a>

          <ul class="sub-nav">
            <li>
              <a href="board/config">
                <i class="fa fa-list-alt"></i>
                게시판관리
              </a>
            </li>
            <li>
              <a href="board/popup">
                <i class="fa fa-list-alt"></i>
                팝업창관리
              </a>
            </li>
            <li>
              <a href="board/consult">
                <i class="fa fa-list-alt"></i>
                온라인문의 관리
              </a>
            </li>
            <li>
              <a href="board/qna">
                <i class="fa fa-list-alt"></i>
                Q&amp;A관리
              </a>
            </li>
            <li>
              <a href="board/faq">
                <i class="fa fa-list-alt"></i>
                FAQ관리
              </a>
            </li>
          </ul>
        </li>

        <li class="dropdown">
          <a href="#">
            <i class="fa fa-bar-chart-o"></i>
            접속통계
            <span class="caret"></span>
          </a>

          <ul class="sub-nav">
            <li>
              <a href="state/chart">
                <i class="fa fa-bar-chart-o"></i>
                접속통계
              </a>
            </li>
            <li>
              <a href="state/ip">
                <i class="fa fa-bar-chart-o"></i>
                IP상세 분석
              </a>
            </li>
          </ul>
        </li>

        <li class="dropdown">
          <a href="#">
            <i class="fa fa-cogs"></i>
            설정
            <span class="caret"></span>
          </a>

          <ul class="sub-nav">
            <li>
              <a href="conf/site">
                <i class="fa fa-cog"></i>
                사이트설정
              </a>
            </li>
            <li>
              <a href="conf/admin">
                <i class="fa fa-user"></i>
                관리자 설정
              </a>
            </li>
            <li>
              <a href="conf/send">
                <i class="fa fa-envelope-o"></i>
                메일/SMS 설정
              </a>
            </li>
            <li>
              <a href="conf/code">
                <i class="fa fa-code"></i>
                코드관리
              </a>
            </li>
          </ul>
        </li>
      </ul>

      <div class="well well-sm" style="margin:5px;">
        <ul class="list-unstyled font-xs" style="margin:0px;">
          <li>웹호스팅 : <span class="text-success"><%=HSVC_NAME%></span></li>
          <li>설치일 : <span class="text-success"><%=HST_WDATE%></span></li>
          <li>만료일 : <span class="text-success"><%=HST_EDATE_TXT%></span></li>
          <li>SMS : <span class="text-success"><%=FormatNumber(SmsCount,0)%>건</span></li>
          <li>HDD : <span class="text-success"><%=f_file_size(SiteSize)%></span> / <%=f_file_size(HST_HDD_MAX_SIZE)%></li>
          <li>DB : <span class="text-success"><%=Round(DB_SIZE/128,2)%>MB</span> / <%=Round(DB_MAXSIZE/128,0)%>MB</li>
        </ul>
      </div>

    </nav> <!-- #sidebar -->
  </div> <!-- /#sidebar-wrapper -->

  <div class="main-content">
    <div id="main-content">

    </div>
  </div>
  <!-- /#main-content -->

  <footer class="footer">
    Helloweb Admin designed and created by Helloweb.co.kr ⓒ 2014
  </footer>

</div>
<!-- /#wrapper -->

<!-- Modal -->
<div class="modal fade" id="smsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title"><i class="fa fa-mobile"></i> SMS 전송</h4>
      </div>
      <div class="modal-body" id="sms-body" style="padding:1px;">
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">관리자정보 입력/수정</h4>
      </div>
      <div class="modal-body" id="profile-body" style="padding:1px;">

      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  function opensms(hp){
    AjaxloadURL('page/admin.sms.asp?hp='+hp, $('#sms-body'));
    $('#smsModal').modal('show');
  }

  function closesms(){
    $('#smsModal').modal('hide');
  }

  function openprofile(){
    AjaxloadURL('page/admin.profile.asp', $('#profile-body'));
    $('#profileModal').modal('show');
  }

  function closeprofile(){
    $('#profileModal').modal('hide');
  }

  function boardview(bc_seq,b_seq){
    if(b_seq == undefined){
       b_link = "page/board.config.view.asp?rtn=index&bc_seq=" + bc_seq;
    }else{
       b_link = "page/board.config.view.asp?rtn=index&bc_seq=" + bc_seq + "&method=view&b_seq=" + b_seq;
    }

    AjaxloadURL(b_link, $('#main-content'));
  }
</script>

<% If InStr(Request.ServerVariables("Remote_Addr"), "61.40.205.") > 0 Then %>
<iframe id='sframe' name='sframe' style="width:100%;height:100px;"></iframe>
<% Else %>
<div style="display:none"><iframe id='sframe' name='sframe' style="width:0px;height:0px;"></iframe></div>
<% End If %>

</body>
</html>