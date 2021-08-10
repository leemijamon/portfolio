<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim QNA_VIEW_Table
   QNA_VIEW_Table = "QNA_VIEW"

   Dim Q_SEQ,Q_TYPE,Q_TITLE,Q_CONT,Q_ANSER,Q_ADATE,Q_RTN_MAIL,Q_RTN_SMS,Q_READCNT,Q_IP
   Dim Q_WDATE,Q_MDATE,Q_STATE,MEM_SEQ,Q_NAME

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Q_SEQ = Trim(Request("q_seq"))
   WHERE = "Q_SEQ=" & Q_SEQ

   SQL = "SELECT * FROM " & QNA_VIEW_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Q_SEQ = Rs("Q_SEQ")
      Q_TYPE = Rs("Q_TYPE")
      Q_TITLE = Rs("Q_TITLE")
      Q_CONT = Rs("Q_CONT")
      Q_ANSER = Rs("Q_ANSER")
      Q_ADATE = Rs("Q_ADATE")
      Q_RTN_MAIL = Rs("Q_RTN_MAIL")
      Q_RTN_SMS = Rs("Q_RTN_SMS")
      Q_READCNT = Rs("Q_READCNT")
      Q_IP = Rs("Q_IP")
      Q_WDATE = Rs("Q_WDATE")
      Q_MDATE = Rs("Q_MDATE")
      Q_STATE = Rs("Q_STATE")
      MEM_SEQ = Rs("MEM_SEQ")
      Q_NAME = Rs("Q_NAME")

      'Q_TYPE = f_arr_value(Q_TYPE_CD,Q_TYPE_NAME,Q_TYPE)
      'Q_RTN_MAIL = f_arr_value(Q_RTN_MAIL_CD,Q_RTN_MAIL_NAME,Q_RTN_MAIL)
      'Q_RTN_SMS = f_arr_value(Q_RTN_SMS_CD,Q_RTN_SMS_NAME,Q_RTN_SMS)
   End If
   Rs.close

   Q_TITLE = Replace(Q_TITLE, chr(34), "&quot;")

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
    <li class="active">Q&amp;A 관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">Q&amp;A 관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> Q&amp;A 관리</div>
        <div class="panel-body no-padding">

<form id="w_form" name="w_form" target="sframe" method="post" class="form">
<input type="hidden" name="action" value="board.qna">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="q_seq" value="<%=Q_SEQ%>">
<input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">
<input type="hidden" name="rtnquery" value="<%=Request.ServerVariables("QUERY_STRING")%>">

  <header>
    상담신청
    <p class="note">상담신청 내용을 수정하실 수 있습니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-sm-2">이름</label>
      <section class="col col-sm-4">
        <p class="form-control-static"><%=Q_NAME%></p>
      </section>
    </div>

    <div class="row">
      <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 문의유형</label>
      <section class="col col-sm-4">
        <label class="select">
          <select name="q_type" id="q_type">
            <option value="">문의유형</option>
            <option value="">--------------</option>
<%=f_arr_opt(Q_TYPE_CD,Q_TYPE_NAME)%>
          </select><i></i>
        </label>
      </section>
      <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 답변수신</label>
      <section class="col col-sm-4">
      <div class="inline-group">
        <label class="checkbox">
          <input type="checkbox" name="q_rtn_mail" value="1" checked>
          <i></i>메일수신
        </label>
        <label class="checkbox">
          <input type="checkbox" name="q_rtn_sms" value="1" checked>
          <i></i>SMS수신
        </label>
      </div>
      </section>
    </div>

    <div class="row">
      <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 제목</label>
      <section class="col col-sm-10">
        <label class="input">
          <i class="icon-append fa fa-tag"></i>
          <input type="text" name="q_title" id="q_title" value="<%=Q_TITLE%>">
        </label>
      </section>
    </div>

    <div class="row">
      <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 내용</label>
      <section class="col col-sm-10">
        <label class="textarea">
          <textarea rows="14" name="q_cont" id="q_cont"><%=Q_CONT%></textarea>
        </label>
      </section>
    </div>
  </fieldset>

  <header>
    상담 답변
    <p class="note">문의에 대한 답변을 입력하세요..</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-sm-2">발송여부</label>
      <section class="col col-sm-10">
        <div class="inline-group">
          <label class="radio">
            <input name="method" type="radio" value="modify" checked>
            <i></i>미발송
          </label>
          <label class="radio">
            <input name="method" type="radio" value="register">
            <i></i>발송(메일+SMS)
          </label>
        </div>
      </section>
    </div>

    <textarea id="paste" name="paste" style="display:none"><%=Q_ANSER%></textarea>
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
  runQnaList();

  function runQnaList(){
    //$("select[name='q_type']").val("<%=Q_TYPE%>");
    $('select[name=q_type]').find('option[value="<%=Q_TYPE%>"]').prop('selected', true);

    $("#w_form").validate({
      rules:{
        q_type:{required:true}
        ,q_title:{required:true,maxlength:50}
        ,q_cont:{required:true,maxlength:500}
      },
      messages:{
        q_type:{
          required:"문의유형을 선택해 주세요."
        }
        ,q_title:{
          required:"문의 제목을 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,q_cont:{
          required:"내용을 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
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
      'uploadpath': '/file/img_page', /* 업로드경로 */
      'bgcolor': false, /* 배경적용 */
      'fileboxview': false
    };

    loadEditor(editorConfig);
  }

  function go_list(){
    AjaxloadURL("page/board.qna.asp?<%=Request.ServerVariables("QUERY_STRING")%>", $('#main-content'));
  }
-->
</script>
