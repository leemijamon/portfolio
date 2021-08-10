<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT COUNT(*) AS TOT_CNT FROM " & MEM_LST_Table & " WHERE MEM_EMAIL <> '' AND MEM_EMAIL IS NOT NULL AND MEM_EMAIL_YN='1' AND MEM_STATE < '90'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   TOT_CNT = Rs("TOT_CNT")
   Rs.close

   SQL = "SELECT MEM_LEVEL, COUNT(*) FROM " & MEM_LST_Table & " WHERE MEM_EMAIL <> '' AND MEM_EMAIL IS NOT NULL AND MEM_EMAIL_YN='1' AND MEM_STATE < '90' GROUP BY MEM_LEVEL ORDER BY MEM_LEVEL"
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   If Rs.BOF = false AND Rs.EOF = false Then
      EMAIL_ROWS = Rs.GetRows
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   Dim M_ITEM,M_TITLE,M_CONT

   M_ITEM = "member"
   M_TITLE = ""

   Call MailRead()

   M_CONT = Replace(M_CONT,"&","&amp;")
   M_CONT = replace(M_CONT, chr(34), "&quot;")
   M_CONT = Replace(M_CONT,"<","&lt;")
   M_CONT = Replace(M_CONT,">","&gt;")

   M_CONT = Replace(M_CONT,"img src=&quot;../","img src=&quot;/")
   M_CONT = Replace(M_CONT,"background=&quot;../","background=&quot;/")
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>[ <%=CS_NAME%> Admin Version 2.0]</title>

<link href="/exec/css/bootstrap.min.css" rel="stylesheet">
<link href="/exec/css/font-awesome.min.css" rel="stylesheet">
<link href="/admin/css/admin.css" rel="stylesheet">

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/jquery-ui.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>
<script src="/exec/js/jquery.validate.min.js"></script>
<script src="/exec/js/messages_ko.js"></script>
<script src="/admin/js/admin.js"></script>
</head>

<body style="background:#f1f1f1;">
<div id="wrapper">

  <link rel="stylesheet" href="/exec/ezeditor/css/editor.css" type="text/css" charset="utf-8"/>
  <script src="/exec/ezeditor/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>

  <div class="panel panel-default">
    <div class="panel-heading"><i class="fa fa-table"></i> 메일보내기</div>
    <div class="panel-body no-padding">
      <div class="panel-body-toolbar">
      </div>

        <form id="w_form" name="w_form" target="sendmailframe" method="post" action=".." class="form">
        <input type="hidden" name="action" value="member.send.mail">
        <input type="hidden" name="send_cnt" value="<%=TOT_CNT%>">
        <textarea id="paste" name="paste" style="display:none"><%=M_CONT%></textarea>
        <textarea id="content" name="content" style="display:none"></textarea>

          <header>
            메일보내기
            <p class="note">이메일을 통해 이벤트, 공지 등을 효과적으로 알리세요.</p>
          </header>

          <fieldset>
            <div class="row">
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 보내는사람 이름</label>
              <section class="col col-sm-4">
                <label class="input">
                  <input type="text" name="m_name" value="<%=CS_NAME%>">
                </label>
              </section>
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 보내는사람 이메일</label>
              <section class="col col-sm-4">
                <label class="input">
                  <input type="text" name="m_from" value="<%=CM_EMAIL%>">
                </label>
              </section>
            </div>

            <div class="row">
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 받는사람</label>
              <section class="col col-sm-4">
                <label class="radio">
                  <input type="radio" name="mem_level" value="00" onclick="incnt(<%=TOT_CNT%>);"><i></i><font color="262626">전체회원</font> (<%=FormatNumber(TOT_CNT,0)%>명)
                </label>
<%
      If IsArray(EMAIL_ROWS) Then
         For k = 0 To UBound(EMAIL_ROWS, 2)
            MEM_LEVEL = EMAIL_ROWS(0,k)
            MEM_CNT = EMAIL_ROWS(1,k)

            MEM_LEVEL_TXT = f_arr_value(MEM_LEVEL_CD, MEM_LEVEL_NAME, Cstr(MEM_LEVEL))

            response.write "        <label class='radio'>" & vbNewLine
            response.write "          <input type='radio' name='mem_level' value='" & MEM_LEVEL & "' onclick='incnt(" & MEM_CNT & ");'><i></i><font color='262626'>" & MEM_LEVEL_TXT & "</font> (" & FormatNumber(MEM_CNT,0) & "명)" & vbNewLine
            response.write "        </label>" & vbNewLine
         Next
      End If
%>
                <label class="radio">
                  <input type="radio" name="mem_level" value="99" onclick="incnt(1);" checked><i></i><font color="262626">테스트발송</font>
                </label>

              </section>
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 테스트이메일</label>
              <section class="col col-sm-4">
                <label class="input">
                  <input type="text" name="m_test" value="<%=CM_EMAIL%>">
                </label>
              </section>
            </div>
            <div class="row">
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 메일제목</label>
              <section class="col col-sm-10">
                <label class="input">
                  <input type="text" name="m_title" value="<%=M_TITLE%>">
                </label>
                <p class="note">{{회원명}}, {{아이디}} 변환코드 사용이 가능합니다.</p>
              </section>
            </div>

            <div style="float:left; width:100%;">
              <div id="editor_div">
                <!-- 에디터 삽입 -->
              </div>
            </div>
          </fieldset>

          <footer>
            <button type="submit" class="btn btn-primary">
              <i class="fa fa-paper-plane"></i>&nbsp; 보내기
            </button>
          </footer>
        </form>

      </div>
    </div>
  </div>

<script type="text/javascript">
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
    'uploadpath': '/file/board', /* 업로드경로 */
    'bgcolor': false, /* 배경적용 */
    'fileboxview': false
  };

  loadEditor(editorConfig);

  Editor.getCanvas().observeJob('canvas.height.change', function () {
    parent.resize();
  });
</script>

<script language="javascript">
<!--
  $(function() {
    $("#w_form").validate({
      rules:{
        m_name:{required:true,maxlength:30}
        ,m_from:{required:true,email:true,maxlength:50}
        ,m_test:{required:true,email:true,maxlength:50}
        ,m_title:{required:true,maxlength:100}
      },
      messages:{
        m_name:{
          required:"이름을 입력해 주세요.",
          maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
        }
        ,m_from:{
          required:"이메일을 입력해 주세요.",
          email:"이메일 형식에 맞게 입력해 주세요."
        }
        ,m_test:{
          required:"이메일을 입력해 주세요.",
          email:"이메일 형식에 맞게 입력해 주세요."
        }
        ,m_title:{
          required:"제목을 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
      },
      errorPlacement: function(error, element) {
        error.insertAfter(element);
        parent.resize();
      },
      submitHandler:function(form){
        if(!editorcheck()) return;

        var msg = "메일을 발송 하시겠습니까?"
        if(confirm(msg)){
          form.submit();
        }else{
          return;
        }
      }
    });

    setTimeout("parent.resize()",300);
  });
-->
</script>

</div>
<!-- /#wrapper -->

<div style="display:none"><iframe name='sendmailframe' style="width:0px;height:0px;"></iframe></div>

</body>
</html>