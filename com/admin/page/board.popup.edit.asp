<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim POPUP_LST_Table
   POPUP_LST_Table = "POPUP_LST"

   Dim P_SEQ,P_TITLE,P_CONT,P_READCNT,P_DISP,P_TOP,P_LEFT,P_WHDTH,P_HEIGHT,P_SDATE
   Dim P_EDATE,P_WDATE,P_MDATE

   If request("p_seq") <> "" Then
      P_SEQ = Trim(Request("p_seq"))

      If IsNumeric(P_SEQ) = false Then Response.End

      SQL = "SELECT * FROM " & POPUP_LST_Table & " WHERE P_SEQ=" & P_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         P_SEQ = Rs("P_SEQ")
         P_TYPE = Rs("P_TYPE")
         P_TITLE = Rs("P_TITLE")
         P_CONT = Rs("P_CONT")
         P_READCNT = Rs("P_READCNT")
         P_DISP = Rs("P_DISP")
         P_TOP = Rs("P_TOP")
         P_LEFT = Rs("P_LEFT")
         P_CENTER = Rs("P_CENTER")
         P_WHDTH = Rs("P_WHDTH")
         P_HEIGHT = Rs("P_HEIGHT")
         P_SDATE = Replace(f_chang_date(Rs("P_SDATE")),"/","-")
         P_EDATE = Replace(f_chang_date(Rs("P_EDATE")),"/","-")
      End If
      Rs.close

      P_METHOD = "modify"
   Else
      P_TYPE = "default"
      P_TOP = 0
      P_LEFT = 0
      P_WHDTH = 0
      P_HEIGHT = 0
      P_DISP = 0

      P_METHOD = "register"
      P_CONT = "<p><br></p>"
   End If

   P_TITLE = Replace(P_TITLE, chr(34), "&quot;")

   P_CONT = Replace(P_CONT,"&","&amp;")
   P_CONT = Replace(P_CONT, chr(34), "&quot;")
   P_CONT = Replace(P_CONT,"<","&lt;")
   P_CONT = Replace(P_CONT,">","&gt;")

   P_CONT = Replace(P_CONT,"img src=&quot;../","img src=&quot;/")
   P_CONT = Replace(P_CONT,"background=&quot;../","background=&quot;/")

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
    <li class="active">팝업창 관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">팝업창 관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 팝업창 관리</div>
        <div class="panel-body no-padding">

<form id="w_form" name="w_form" target="sframe" method="post" class="form">
<input type="hidden" name="action" value="board.popup">
<input type="hidden" name="method" value="<%=P_METHOD%>">
<input type="hidden" name="p_seq" value="<%=P_SEQ%>">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="rtnquery" value="<%=Request.ServerVariables("QUERY_STRING")%>">

  <fieldset>
    <div class="row">
      <label class="label col col-sm-2">팝업창구분</label>
      <section class="col col-sm-10">
      <div class="inline-group">
<%
   With response
      s_code = Split(P_TYPE_CD,",")
      s_name = Split(P_TYPE_NAME,",")

      For fn = 0 to UBound(s_code)
         .write "      <label class='radio'>" & vbNewLine
         .write "        <input type='radio' name='p_type' value='" & s_code(fn) & "'>" & vbNewLine
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
          <input type="text" name="p_title" value="<%=P_TITLE%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">노출여부</label>
      <section class="col col-sm-6">
      <div class="inline-group">
        <label class="radio">
          <input name="p_disp" type="radio" value="1">
          <i></i>노출함
        </label>
        <label class="radio">
          <input name="p_disp" type="radio" value="0">
          <i></i>노출안함
        </label>
      </div>
      </section>
      <section class="col col-sm-4">
      <div class="inline-group">
        <label class="checkbox">
          <input name="p_center" type="checkbox" value="1">
          <i></i>가운데위치
        </label>
      </div>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">TOP</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="p_top" value="<%=P_TOP%>">
        </label>
      </section>
      <label class="label col col-sm-2">LEFT</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="p_left" value="<%=P_LEFT%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">WIDTH</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="p_whdth" value="<%=P_WHDTH%>">
        </label>
      </section>
      <label class="label col col-sm-2">HEIGHT</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="p_height" value="<%=P_HEIGHT%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">게시일</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="p_sdate" id="p_sdate" class="indate" value="<%=P_SDATE%>">
        </label>
      </section>
      <label class="label col col-sm-2">종료일</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="p_edate" id="p_edate" class="indate" value="<%=P_EDATE%>">
        </label>
      </section>
    </div>

    <textarea id="paste" name="paste" style="display:none"><%=P_CONT%></textarea>
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

<script language="javascript">
<!--
  runPopupList();

  function runPopupList(){
    $("input:radio[name='p_type']:radio[value='<%=P_TYPE%>']").attr("checked",true);
    $("input:radio[name='p_disp']:radio[value='<%=P_DISP%>']").attr("checked",true);
    $("input:checkbox[name='p_center']:checkbox[value='<%=P_CENTER%>']").attr("checked",true);

    $('#p_sdate').datepicker({
      dateFormat : 'yy-mm-dd',
      onSelect : function(selectedDate) {
        $('#p_edate').datepicker('option', 'minDate', selectedDate);
      }
    });

    $('#p_edate').datepicker({
      dateFormat : 'yy-mm-dd',
      onSelect : function(selectedDate) {
        $('#p_sdate').datepicker('option', 'maxDate', selectedDate);
      }
    });

    $("#w_form").validate({
      rules:{
        p_title:{required:true,maxlength:50}
        ,p_top:{required:true,number:true,maxlength:4}
        ,p_left:{required:true,number:true,maxlength:4}
        ,p_whdth:{required:true,number:true,maxlength:4}
        ,p_height:{required:true,number:true,maxlength:4}
        ,p_sdate:{required:true}
        ,p_edate:{required:true}
      },
      messages:{
        p_title:{
          required:"제목을 입력해 주세요.",
          maxlength:jQuery.validator.format("제목은 최대 {0}자 이하로 입력해주세요.")
        }
        ,p_top:{
          required:"입력해 주세요.",
          number:"숫자로 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,p_left:{
          required:"입력해 주세요.",
          number:"숫자로 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,p_whdth:{
          required:"입력해 주세요.",
          number:"숫자로 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,p_height:{
          required:"입력해 주세요.",
          number:"숫자로 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,p_sdate:{
          required:"게시일을 선택해 주세요.",
        }
        ,p_edate:{
          required:"종료일을 선택해 주세요.",
        }
      },
      errorPlacement: function(error, element) {
        error.insertAfter(element);
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
      'uploadpath': '/file/popup', /* 업로드경로 */
      'bgcolor': false, /* 배경적용 */
      'fileboxview': false
    };

    loadEditor(editorConfig);
  }

  function go_list(){
    AjaxloadURL("page/board.popup.asp?<%=Request.ServerVariables("QUERY_STRING")%>", $('#main-content'));
  }
-->
</script>

        </div>
      </div>
    </div>
  </div>
</div>
