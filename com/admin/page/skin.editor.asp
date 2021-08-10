<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim CMS_SKIN_LST_Table
   CMS_SKIN_LST_Table = "CMS_SKIN_LST"

   Dim CS_CODE,CS_STATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   WHERE = "CS_STATE < '90'"
   ORDER_BY = "CS_STATE DESC, CS_CODE"
   SQL = "SELECT * FROM " & CMS_SKIN_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         CS_CODE = Rs("CS_CODE")
         CS_STATE = Rs("CS_STATE")

         If CS_STATE = "01" Then ACTIVE_CODE = CS_CODE

         SKIN_OPT = SKIN_OPT & "<option value='" & CS_CODE & "'>" & CS_CODE & "</option>"

         Rs.MoveNext
      Loop
   End If
   Rs.close

   If request("cs_code") <> "" Then
      CS_CODE = request("cs_code")
   Else
      CS_CODE = ACTIVE_CODE
   End If

   Dim CMS_LAYOUT_LST_Table
   CMS_LAYOUT_LST_Table = "CMS_LAYOUT_LST"

   Dim CMS_ITEM_LST_Table
   CMS_ITEM_LST_Table = "CMS_ITEM_LST"

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CL_CODE,CL_NAME
   Dim CI_CODE,CI_TYPE,CI_NAME,CI_CONT,CI_SKIN,CI_WDATE,CI_MDATE,CI_STATE
   Dim CP_CODE,CP_NAME

   WHERE = "CL_STATE<'90' AND CS_CODE='" & CS_CODE & "'"
   SQL = "SELECT CL_CODE,CL_NAME FROM " & CMS_LAYOUT_LST_Table & " WHERE " & WHERE & " ORDER BY CL_NAME"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   i = 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = i + 1
         CL_CODE = Rs("CL_CODE")
         CL_NAME = Rs("CL_NAME")

         If CL_CODE = "main" OR CL_CODE = "sub" Then
            CL_LST = CL_LST & "          <li class='list-group-item'><a href=""javascript:layout_edit('" & CS_CODE & "','" & CL_CODE & "');"">" & i & ". " & CL_NAME & " 레이아웃</a></li>" & vbNewLine
         Else
            CL_LST = CL_LST & "          <li class='list-group-item'><a href=""javascript:layout_edit('" & CS_CODE & "','" & CL_CODE & "');"">" & i & ". " & CL_NAME & " 레이아웃</a> <button type='button' class='btn btn-warning btn-xs pull-right' onclick=""layout_delete('" & CS_CODE & "','" & CL_CODE & "');"">삭제</button></li>" & vbNewLine
         End If

         Rs.MoveNext
      Loop
   End If
   Rs.close

   Dim css_path
   css_path = Server.MapPath("/skin") & "/" & CS_CODE & "/css"
   Set fso = Server.CreateObject("Scripting.FileSystemObject")
   Set oFolder = fso.GetFolder(css_path)

   Dim oFile

   i = 0
   For Each oFile In oFolder.Files
      filename = oFile.name

      If Right(filename,4) = ".css" Then
         i = i + 1

         CSS_CODE = Left(filename,Len(filename)-4)
         CSS_LST = CSS_LST & "          <li class='list-group-item'><a href=""javascript:css_edit('" & CS_CODE & "','" & CSS_CODE & "');"">" & i & ". " & filename & "</a> <button type='button' class='btn btn-warning btn-xs pull-right' onclick=""css_delete('" & CS_CODE & "','" & CSS_CODE & "');"">삭제</button></li>" & vbNewLine
      End If
   Next

   Dim js_path
   js_path = Server.MapPath("/skin") & "/" & CS_CODE & "/js"
   Set fso = Server.CreateObject("Scripting.FileSystemObject")
   Set oFolder = fso.GetFolder(js_path)

   i = 0
   For Each oFile In oFolder.Files
      filename = oFile.name

      If Right(filename,3) = ".js" Then
         i = i + 1

         JS_CODE = Left(filename,Len(filename)-3)
         JS_LST = JS_LST & "          <li class='list-group-item'><a href=""javascript:js_edit('" & CS_CODE & "','" & JS_CODE & "');"">" & i & ". " & filename & "</a> <button type='button' class='btn btn-warning btn-xs pull-right' onclick=""js_delete('" & CS_CODE & "','" & JS_CODE & "');"">삭제</button></li>" & vbNewLine
      End If
   Next

   i = 0
   CI_LST1 = GetItem("menu","CI_NAME")

   i = 0
   CI_LST2 = GetItem("main","CI_NAME")

   i = 0
   CI_LST3 = GetItem("page","CI_NAME")

   Function GetItem(itemtype,sortkey)
      SQL = "SELECT CI_CODE,CI_NAME FROM " & CMS_ITEM_LST_Table & " WHERE CI_TYPE='" & itemtype & "' AND CI_STATE < '90'  AND CS_CODE='" & CS_CODE & "' ORDER BY " & sortkey
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            i = i + 1
            CI_CODE = Rs("CI_CODE")
            CI_NAME = Rs("CI_NAME")

            ITEM_LST = ITEM_LST & "          <li class='list-group-item'><a href=""javascript:item_edit('" & CS_CODE & "','" & itemtype & "','" & CI_CODE & "');"">" & i & ". " & CI_NAME & "</a> <button type='button' class='btn btn-warning btn-xs pull-right' onclick=""item_delete('" & CS_CODE & "','" & CI_CODE & "');"">삭제</button></li>" & vbNewLine

            Rs.MoveNext
         Loop
      End If
      Rs.close

      GetItem = ITEM_LST
   End Function
%>

<style type="text/css">
  div.grippie {
    background:#EEEEEE url(images/grippie.png) no-repeat scroll center 2px;
    border-color:#DDDDDD;
    border-style:solid;
    border-width:0pt 1px 1px;
    cursor:s-resize;
    height:9px;
    overflow:hidden;
  }
  .resizable-textarea textarea {
    border: 1px solid #DDDDDD;
    background: #f9f9f9;
    display:block;
    margin-bottom:0pt;
    width:100%;
    height:20%;
  }
</style>

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">디자인관리</a>
    </li>
    <li class="active">스킨 편집</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">스킨 편집</h2>
    </div>
  </div>

  <div class="row">
    <div class='col-sm-4 col-lg-3'>
    <strong><label for="skin">편집할 스킨 선택</label></strong>
    <form id="f_skin" name="f_skin" action="#skin/editor" method="get" class="form">
      <label class="select">
        <select id="cs_code" name="cs_code" onchange="goskin();">
<%=SKIN_OPT%>
        </select><i></i>
      </label>
      </form>
      <br>
    </div>
  </div>

  <div class="row">
    <div class='col-sm-4 col-lg-3'>
      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="layout_edit('<%=CS_CODE%>','');">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><a data-toggle="collapse" href="#collapseLayout">레이아웃 관리</a></div>
        <ul class="list-group collapse in" id="collapseLayout">
<%=CL_LST%>
        </ul>
      </div>

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="css_edit('<%=CS_CODE%>','');">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><a data-toggle="collapse" href="#collapseCss">CSS 관리</a></div>
        <ul class="list-group collapse in" id="collapseCss">
<%=CSS_LST%>
        </ul>
      </div>

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="js_edit('<%=CS_CODE%>','');">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><a data-toggle="collapse" href="#collapseJs">Script 관리</a></div>
        <ul class="list-group collapse" id="collapseJs">
<%=JS_LST%>
        </ul>
      </div>

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="item_edit('<%=CS_CODE%>','main','');">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><a data-toggle="collapse" href="#collapseMenu">메뉴 아이템</a></div>
        <ul class="list-group collapse in" id="collapseMenu">
<%=CI_LST1%>
        </ul>
      </div>

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="item_edit('<%=CS_CODE%>','menu','');">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><a data-toggle="collapse" href="#collapseMain">메인 아이템</a></div>
        <ul class="list-group collapse in" id="collapseMain">
<%=CI_LST2%>
        </ul>
      </div>

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="item_edit('<%=CS_CODE%>','page','');">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><a data-toggle="collapse" href="#collapsePage">페이지 아이템</a></div>
        <ul class="list-group collapse in" id="collapsePage">
<%=CI_LST3%>
        </ul>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading"><a data-toggle="collapse" href="#collapseMail">메일 디자인</a></div>
        <ul class="list-group collapse" id="collapseMail">
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','default');">기본메일폼</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','join');">회원가입메일</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','certify');">회원가입 메일인증</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','idsearch');">아이디찾기메일</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','pwsearch');">비밀번호찾기메일</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','secede');">회원탈퇴메일</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','consult');">온라인문의답변메일</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','qna');">1:1문의답변메일</a></li>
          <li class='list-group-item'><a href="javascript:mail_edit('<%=CS_CODE%>','member');">회원메일(그룹발송)</a></li>
        </ul>
      </div>
    </div>

    <div class='col-sm-8 col-lg-9' id="sub-content">
      <p class="alert alert-info">좌측에서 작업하고자 하시는 메뉴를 클릭해주세요~</p>
    </div>
  </div>
</div>

<script type="text/javascript">
  loadScripts();
  function loadScripts() {
    loadScript("js/jquery.textarearesizer.compressed.js", runScripts);
  }

  function runScripts(){
    //$("select[name='cs_code']").val("<%=CS_CODE%>");
    $('select[name=cs_code]').find('option[value="<%=CS_CODE%>"]').prop('selected', true);
  }

  var navigationFn = {
    goToSection: function(id) {
      $('html, body').animate({
        scrollTop: $(id).offset().top
      }, 0);
    }
  }

  function goskin(){
    AjaxloadURL('page/skin.editor.asp?cs_code=' + $('#cs_code').val(), $('#main-content'));
  }

  function layout_edit(cs_code,cl_code){
    AjaxloadURL('page/skin.layout.asp?cs_code=' + cs_code + '&cl_code=' + cl_code, $('#sub-content'));
    navigationFn.goToSection('#sub-content');
  }

  function layout_delete(cs_code,cl_code){
    var msg = "레이아웃을 삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = '?action=skin.layout&method=delete&cs_code=' + cs_code + '&cl_code=' + cl_code;
    }else{
      return;
    }
  }

  function js_edit(cs_code,js_code){
    AjaxloadURL('page/skin.js.asp?cs_code=' + cs_code + '&js_code=' + js_code, $('#sub-content'));
    navigationFn.goToSection('#sub-content');
  }

  function js_delete(cs_code,js_code){
    var msg = "Script 파일을 삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = '?action=skin.js&method=delete&cs_code=' + cs_code + '&js_code=' + js_code;
    }else{
      return;
    }
  }

  function css_edit(cs_code,css_code){
    AjaxloadURL('page/skin.css.asp?cs_code=' + cs_code + '&css_code=' + css_code, $('#sub-content'));
    navigationFn.goToSection('#sub-content');
  }

  function css_delete(cs_code,css_code){
    var msg = "CSS 파일을 삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = '?action=skin.css&method=delete&cs_code=' + cs_code + '&css_code=' + css_code;
    }else{
      return;
    }
  }

  function item_edit(cs_code,ci_type,ci_code){
    AjaxloadURL('page/skin.item.asp?cs_code=' + cs_code + '&ci_type=' + ci_type + '&ci_code=' + ci_code, $('#sub-content'));
    navigationFn.goToSection('#sub-content');
  }

  function item_delete(cs_code,ci_code){
    var msg = "아이템을 삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = '?action=skin.item&method=delete&cs_code=' + cs_code + '&ci_code=' + ci_code;
    }else{
      return;
    }
  }

  function mail_edit(cs_code,mail_code){
    AjaxloadURL('page/skin.mail.asp?cs_code=' + cs_code + '&mail_code=' + mail_code, $('#sub-content'));
    navigationFn.goToSection('#sub-content');
  }

  function page_reload(){
    document.location.reload();
  }
</script>
