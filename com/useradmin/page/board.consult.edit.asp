<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim CONSULT_LST_Table
   CONSULT_LST_Table = "CONSULT_LST"

   Dim C_AREA,C_TYPE,C_NAME,C_ZIPCODE,C_ADDR1,C_ADDR2,C_MA_NAME,C_MA_HP,C_HOMEPAGE,C_BLOG
   Dim C_CONT,C_YN,C_IP,C_WDATE
   Dim C_SEQ,C_STATE

   C_SEQ = Trim(Request("c_seq"))

   WHERE = "C_SEQ=" & C_SEQ

   SQL = "SELECT * FROM " & CONSULT_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      C_TYPE = Rs("C_TYPE")
      C_NAME = Rs("C_NAME")
      C_EMAIL = Rs("C_EMAIL")
      C_HP = Rs("C_HP")
      C_TEL = Rs("C_TEL")
      C_TITLE = Rs("C_TITLE")
      C_CONT = Rs("C_CONT")
      C_ANSER = Rs("C_ANSER")
      C_ADATE = Rs("C_ADATE")
      C_IP = Rs("C_IP")
      C_WDATE = Rs("C_WDATE")

      C_TITLE = Replace(C_TITLE,"<","&lt;")
      C_TITLE = Replace(C_TITLE,">","&gt;")

      If IsNULL(C_EMAIL) OR C_EMAIL = "" Then C_EMAIL = "@"
      If IsNULL(C_HP) OR C_HP = "" Then C_HP = "--"
      If IsNULL(C_TEL) OR C_TEL = "" Then C_TEL = "--"

      S_C_EMAIL = Split(C_EMAIL,"@")
      C_EMAIL1 = S_C_EMAIL(0)
      C_EMAIL2 = S_C_EMAIL(1)

      S_C_HP = Split(C_HP,"-")
      C_HP1 = S_C_HP(0)
      C_HP2 = S_C_HP(1)
      C_HP3 = S_C_HP(2)

      S_C_TEL = Split(C_TEL,"-")
      C_TEL1 = S_C_TEL(0)
      C_TEL2 = S_C_TEL(1)
      C_TEL3 = S_C_TEL(2)

      C_CONT = replace(C_CONT,chr(13) & chr(10),"<br>")

      If CONSULT_CD <> "" Then
         SP_ADD = Split(CONSULT_CD,",")
         SP_CNT = UBound(SP_ADD)

         ReDim C_ADD(SP_CNT)

         For i = 0 to SP_CNT
            C_ADD(i) = Rs(SP_ADD(i))
         Next
      End If
   End If
   Rs.close

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
<input type="hidden" name="action" value="board.consult">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="c_seq" value="<%=C_SEQ%>">
<input type="hidden" name="rtnquery" value="<%=Request.ServerVariables("QUERY_STRING")%>">

  <header>
    온라인문의
    <p class="note">문의 내용을 수정하실 수 있습니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-sm-2">이름</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="c_name" value="<%=C_NAME%>">
        </label>
      </section>
      <label class="label col col-sm-2">이메일</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="email" name="c_email" value="<%=C_EMAIL%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">휴대전화</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="c_hp" value="<%=C_HP%>">
        </label>
      </section>
      <label class="label col col-sm-2">일반전화</label>
      <section class="col col-sm-4">
        <label class="input">
          <input type="text" name="c_tel" value="<%=C_TEL%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">제목</label>
      <section class="col col-sm-2">
        <label class="select">
        <select name="c_type">
          <option value="">문의구분</option>
<%=f_arr_opt(C_TYPE_CD, C_TYPE_NAME)%>
        </select>
        </label>
      </section>
      <section class="col col-sm-8">
        <label class="input">
          <input type="text" name="c_title" value="<%=C_TITLE%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-sm-2">내용</label>
      <section class="col col-sm-10">
        <label class="textarea">
          <textarea rows="14" name="c_cont" id="c_cont"><%=C_CONT%></textarea>
        </label>
      </section>
    </div>
  </fieldset>

  <header>
    온라인문의 답변
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
            <input name="method" type="radio" value="registerall">
            <i></i>발송(메일+SMS)
          </label>
          <label class="radio">
            <input name="method" type="radio" value="registermall">
            <i></i>발송(메일)
          </label>
          <label class="radio">
            <input name="method" type="radio" value="registersms">
            <i></i>발송(SMS)
          </label>
        </div>
      </section>
    </div>

    <textarea id="paste" name="paste" style="display:none"><%=C_ANSER%></textarea>
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
    //$("select[name='c_type']").val("<%=C_TYPE%>");
    $('select[name=c_type]').find('option[value="<%=C_TYPE%>"]').prop('selected', true);

    $.validator.addMethod("hpnumber", function(value, element) {
      return this.optional(element) || /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/.test(value);
    });

    $.validator.addMethod("telnumber", function(value, element) {
      return this.optional(element) || /^\d{2,3}-\d{3,4}-\d{4}$/.test(value);
    });

    $("#w_form").validate({
      rules:{
        c_name:{required:true,maxlength:10}
        ,c_hp:{required:true,hpnumber:true,maxlength:15}
        ,c_tel:{required:false,telnumber:true,maxlength:15}
        ,c_email:{required:true,email:true,maxlength:50}
        ,c_type:{required:true}
        ,c_title:{required:true,maxlength:50}
        ,c_cont:{required:true}
      },
      messages:{
        c_name:{
          required:"이름을 입력해 주세요.",
          maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
        }
        ,c_hp:{
          required:"휴대전화 번호를 입력해 주세요.",
          hpnumber:"휴대전화 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,c_tel:{
          required:"전화번호를 입력해 주세요.",
          telnumber:"전화번호 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,c_email:{
          required:"이메일을 입력해 주세요.",
          email:"이메일 형식에 맞게 입력해 주세요."
        }
        ,c_type:{
          required:"문의 분류를 선택해 주세요.",
        }
        ,c_title:{
          required:"문의 제목을 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,c_cont:{
          required:"내용을 입력해 주세요."
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
    AjaxloadURL("page/board.consult.asp?<%=Request.ServerVariables("QUERY_STRING")%>", $('#main-content'));
  }
-->
</script>

