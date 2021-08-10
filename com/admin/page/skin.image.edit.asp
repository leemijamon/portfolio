<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim CMS_IMAGE_LST_Table
   CMS_IMAGE_LST_Table = "CMS_IMAGE_LST"

   Dim CI_SEQ,CI_CODE,CI_NAME,CI_FILE,CI_WIDTH,CI_HEIGHT,CI_WDATE,CI_MDATE,CI_STATE,ADM_SEQ

   CI_SEQ = Trim(Request("ci_seq"))

   If CI_SEQ <> "" Then
      If IsNumeric(CI_SEQ) = false Then Response.End

      SQL = "SELECT * FROM " & CMS_IMAGE_LST_Table & " WHERE CI_SEQ=" & CI_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         CI_SEQ = Rs("CI_SEQ")
         CI_CODE = Rs("CI_CODE")
         CI_NAME = Rs("CI_NAME")
         CI_FILE = Rs("CI_FILE")
         CI_DESCRIPTION = Rs("CI_DESCRIPTION")
         CI_WIDTH = Rs("CI_WIDTH")
         CI_HEIGHT = Rs("CI_HEIGHT")
      End If
      Rs.close

      CI_METHOD = "modify"
   Else
      CI_WIDTH = 0
      CI_HEIGHT = 0
      CI_METHOD = "register"
   End If

   Conn.Close
   Set Conn = nothing
%>
<form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="skin.image">
<input type="hidden" name="ci_seq" value="<%=CI_SEQ%>">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="method" value="<%=CI_METHOD%>">

<fieldset>
  <div class="row">
    <label class="label col col-md-3">파일명</label>
    <section class="col col-md-9">
      <p class="form-control-static"><%=CI_FILE%></p>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">제목</label>
    <section class="col col-md-9">
      <label class="input">
        <input type="text" name="ci_name" data-parsley-maxlength="50" required value="<%=CI_NAME%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">대체 텍스트</label>
    <section class="col col-md-9">
      <label class="input">
        <input type="text" name="ci_description" data-parsley-maxlength="100" value="<%=CI_DESCRIPTION%>">
      </label>
    </section>
  </div>
</fieldset>

<footer>
  <button type="submit" class="btn btn-primary">
    <i class="fa fa-pencil fa-lg"></i> 저장
  </button>
  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
</footer>
</form>

<script type="text/javascript">
  $("#editform").parsley();
</script>
