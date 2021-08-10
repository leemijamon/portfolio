<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim FAQ_LST_Table
   FAQ_LST_Table = "FAQ_LST"

   Dim F_SEQ,F_TYPE,F_TITLE,F_CONT,F_READCNT,F_DISP,F_SORT

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   If request("f_seq") <> "" Then
      F_SEQ = Trim(Request("f_seq"))

      If IsNumeric(F_SEQ) = false Then Response.End

      SQL = "SELECT * FROM " & FAQ_LST_Table & " WHERE F_SEQ=" & F_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         F_SEQ = Rs("F_SEQ")
         F_TYPE = Rs("F_TYPE")
         F_TITLE = Rs("F_TITLE")
         F_CONT = Rs("F_CONT")
         F_READCNT = Rs("F_READCNT")
         F_DISP = Rs("F_DISP")
         F_SORT = Rs("F_SORT")
      End If
      Rs.close

      F_METHOD = "modify"
   Else
      F_DISP = "1"
      F_METHOD = "register"
      F_TYPE = Trim(Request("f_type"))
   End If

   F_CONT = Replace(F_CONT,"&","&amp;")
   F_CONT = replace(F_CONT, chr(34), "&quot;")
   F_CONT = Replace(F_CONT,"<","&lt;")
   F_CONT = Replace(F_CONT,">","&gt;")

   F_CONT = Replace(F_CONT,"img src=&quot;../","img src=&quot;/")
   F_CONT = Replace(F_CONT,"background=&quot;../","background=&quot;/")

   Conn.Close
   Set Conn = nothing
%>
<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li class="active">컨텐츠관리</li>
    <li class="active">온라인문의 관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">온라인문의 관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 온라인문의 관리</div>
        <div class="panel-body no-padding">

<form id="w_form" name="w_form" target="sframe" method="post" class="form">
<input type="hidden" name="action" value="board.faq">
<input type="hidden" name="method" value="<%=F_METHOD%>">
<input type="hidden" name="f_seq" value="<%=F_SEQ%>">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="rtnquery" value="<%=Request.ServerVariables("QUERY_STRING")%>">

  <fieldset>
    <div class="row">
      <label class="label col col-sm-2">분류</label>
      <section class="col col-sm-10">
      <div class="inline-group">
<%
   With response
      s_code = Split(F_TYPE_CD,",")
      s_name = Split(F_TYPE_NAME,",")

      For fn = 0 to UBound(s_code)
         .write "      <label class='radio'>" & vbNewLine
         .write "        <input type='radio' name='f_type' value='" & s_code(fn) & "'>" & vbNewLine
         .write "        <i></i>" & s_name(fn) & vbNewLine
         .write "      </label>" & vbNewLine
      Next
   End With
%>
      </div>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">제목</label>
      <section class="col col-sm-10">
        <label class="input">
          <input type="text" name="f_title" value="<%=F_TITLE%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">표시여부</label>
      <section class="col col-sm-6">
      <div class="inline-group">
        <label class="radio">
          <input name="f_disp" type="radio" value="1">
          <i></i>표시함
        </label>
        <label class="radio">
          <input name="f_disp" type="radio" value="0">
          <i></i>표시안함
        </label>
      </div>
      </section>
    </div>

    <textarea id="paste" name="paste" style="display:none"><%=F_CONT%></textarea>
    <textarea id="content" name="content" style="display:none"></textarea>

    <div style="float:left; margin-top:10px; width:100%;">
      <div id="editor_div">
        <!-- 에디터 삽입 -->
      </div>
    </div>
  </fieldset>

  <footer style="background:#ffffff;">
    <button type="submit" class="btn btn-primary">
      <i class="fa fa-pencil fa-lg"></i> 저장
    </button>
    <button class="btn btn-default" type="button" onclick="go_list();">목록보기</button>
  </footer>
</form>

        </div>
      </div>
    </div>
  </div>
</div>

<script language="javascript">
<!--
  runConsultList();

  function runConsultList(){
    $("input:radio[name='f_type']:radio[value='<%=F_TYPE%>']").attr("checked",true);
    $("input:radio[name='f_disp']:radio[value='<%=F_DISP%>']").attr("checked",true);

    $("#w_form").validate({
      rules:{
        f_title:{required:true,maxlength:50}
      },
      messages:{
        f_title:{
          required:"제목을 입력해 주세요.",
          maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
        }
      },
      errorPlacement: function(error, element) {
        error.insertAfter(element);
        parent.resize();
      },
      submitHandler:function(form){
        if(!editorcheck()) return;

        var msg = "등록하시겠습니까?"
        if(confirm(msg)){
          form.submit();
        }else{
          return;
        }
      }
    });

    var editorConfig = {
      'editorpath': '/exec/ezeditor', /* 에디터경로 */
      'editorelement': 'editor_div', /* 에디터삽입element */
      'editorwidth': '100%', /* 에디터폭 */
      'editorheight': '300px', /* 에디터높이 */
      'contwidth': null, /* 컨텐츠폭 null(100%) */
      'imgmaxwidth': 900, /* 이미지최대폭 */
      'formname': 'w_form', /* 폼이름 */
      'loadcontent': 'paste', /* 로드element */
      'savehtml': 'content', /* HTML저장element */
      'uploadpath': '/file/faq', /* 업로드경로 */
      'bgcolor': false, /* 배경적용 */
      'fileboxview': false
    };

    loadEditor(editorConfig);
  }

  function go_list(){
    AjaxloadURL("page/board.faq.asp?<%=Request.ServerVariables("QUERY_STRING")%>", $('#main-content'));
  }
-->
</script>
