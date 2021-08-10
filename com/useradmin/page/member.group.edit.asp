<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim MEM_LEVEL_LST_Table
   MEM_LEVEL_LST_Table = "MEM_LEVEL_LST"

   Dim MEM_LEVEL,ML_NAME,ML_USE_YN,ML_WDATE,ML_MDATE

   MEM_LEVEL = Trim(Request("mem_level"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & MEM_LEVEL_LST_Table & " WHERE MEM_LEVEL='" & MEM_LEVEL & "'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MEM_LEVEL = Rs("MEM_LEVEL")
      ML_NAME = Rs("ML_NAME")
      ML_USE_YN = Rs("ML_USE_YN")
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing
%>
<form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="member.group">
<input type="hidden" name="method" value="modify">
<input type="hidden" name="mem_level" value="<%=MEM_LEVEL%>">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

<fieldset>
  <div class="row">
    <label class="label col col-md-4">그룹레벨</label>
    <section class="col col-md-8">
      <label class="input">
        <input type="text" name="mem_level_view" data-parsley-maxlength="15" value="<%=MEM_LEVEL%>" style="border:0px;">
      </label>
    </section>
  </div>

  <div class="row">
    <label class="label col col-md-4">그룹명</label>
    <section class="col col-md-8">
      <label class="input">
        <input type="text" name="ml_name" data-parsley-maxlength="15" required value="<%=ML_NAME%>">
      </label>
    </section>
  </div>

  <div class="row">
    <label class="label col col-md-4">SSL 사용여부</label>
    <section class="col col-md-8">
    <div class="inline-group">
<% If MEM_LEVEL < "09" Then %>
      <label class="radio">
        <input type="radio" name="ml_use_yn" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input type="radio" name="ml_use_yn" value="0">
        <i></i>미사용
      </label>
<% Else %>
      <label class="radio">
        <input type="radio" name="ml_use_yn" value="1">
        <i></i>사용
      </label>
<% End If %>
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
  $("input:radio[name='ml_use_yn']:radio[value='<%=ml_use_yn%>']").attr("checked",true);
  $("#editform").parsley();
</script>
