<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck_non.inc" -->
<%
   Dim CMS_CODE_LST_Table
   CMS_CODE_LST_Table = "CMS_CODE_LST"

   Dim CC_TYEP,CC_CODE,CC_NAME,CC_DISP,CC_SORT

   CC_TYPE = Trim(Request("cc_type"))
   CC_SEQ = Trim(Request("cc_seq"))

   If CC_SEQ <> "" Then
      If IsNumeric(CC_SEQ) = false Then Response.End

      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      SQL = "SELECT * FROM " & CMS_CODE_LST_Table & " WHERE CC_SEQ=" & CC_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         CC_TYPE = Rs("CC_TYPE")
         CC_CODE = Rs("CC_CODE")
         CC_NAME = Rs("CC_NAME")
         CC_DISP = Rs("CC_DISP")
      End If
      Rs.close

      Conn.Close
      Set Conn = nothing

      CC_METHOD = "modify"
   Else
      CC_METHOD = "register"
      CC_DISP = "1"
   End If
%>
<form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf.code">
<input type="hidden" name="method" value="<%=CC_METHOD%>">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">
<input type="hidden" name="cc_seq" value="<%=CC_SEQ%>">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

<fieldset>
  <div class="row">
    <label class="label col col-md-3">코드분류</label>
    <section class="col col-md-9"><%=f_arr_value(CC_TYPE_CD, CC_TYPE_NAME, Cstr(CC_TYPE))%></section>
  </div>
  <div class="row">
    <label class="label col col-md-3">코드번호</label>
    <section class="col col-md-9">
      <label class="input">
        <input type="text" name="cc_code" data-parsley-maxlength="40" required value="<%=CC_CODE%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">코드명</label>
    <section class="col col-md-9">
      <label class="input">
        <input type="text" name="cc_name" data-parsley-maxlength="40" required value="<%=CC_NAME%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">사용여부</label>
    <section class="col col-md-9">
    <div class="inline-group">
      <label class="radio">
        <input type="radio" name="cc_disp" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input type="radio" name="cc_disp" value="0">
        <i></i>미사용
      </label>
    </div>
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
  $("input:radio[name='cc_disp']:radio[value='<%=CC_DISP%>']").attr("checked",true);

  $("#editform").parsley();
</script>
