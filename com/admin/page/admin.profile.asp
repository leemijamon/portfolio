<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim ADMIN_LST_Table
   ADMIN_LST_Table = "ADMIN_LST"

   Dim ADM_SEQ,ADM_TYPE,ADM_NAME,ADM_JUMIN,ADM_ID,ADM_PWD,ADM_HP,ADM_TEL,ADM_FAX,ADM_ZIPCODE
   Dim ADM_ADDR1,ADM_ADDR2,ADM_EMAIL,ADM_POST,ADM_ACCOUNT,ADM_PERMIT,ADM_LOG_IP,ADM_LOG_DATE,ADM_WDATE,ADM_MDATE

   ADM_SEQ = Session("ADM_SEQ")

   If IsNumeric(ADM_SEQ) = false Then Response.End

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & ADMIN_LST_Table & " WHERE ADM_SEQ=" & ADM_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      ADM_SEQ = Rs("ADM_SEQ")
      ADM_TYPE = Rs("ADM_TYPE")
      ADM_NAME = Rs("ADM_NAME")
      ADM_ID = Rs("ADM_ID")
      ADM_PWD = Rs("ADM_PWD")
      ADM_HP = Rs("ADM_HP")
      ADM_TEL = Rs("ADM_TEL")
      ADM_FAX = Rs("ADM_FAX")
      ADM_EMAIL = Rs("ADM_EMAIL")
      ADM_POST = Rs("ADM_POST")
      ADM_ACCOUNT = Rs("ADM_ACCOUNT")
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing
%>
<form id="profileform" name="profileform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="admin.profile">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

<fieldset>
  <div class="row">
    <label class="label col col-md-2">아이디</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_id" data-parsley-type="alphanum" data-parsley-maxlength="15" required value="<%=ADM_ID%>">
      </label>
    </section>
    <label class="label col col-md-2">비밀번호</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_pwd" data-parsley-maxlength="15" value="">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">이름</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_name" data-parsley-maxlength="10" required value="<%=ADM_NAME%>">
      </label>
    </section>
    <label class="label col col-md-2">부서/직급</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_post" data-parsley-maxlength="10" value="<%=ADM_POST%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">휴대전화</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_hp" data-parsley-maxlength="15" value="<%=ADM_HP%>">
      </label>
    </section>
    <label class="label col col-md-2">일반전화</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_tel" data-parsley-maxlength="15" value="<%=ADM_TEL%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">FAX</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_fax" data-parsley-maxlength="15" value="<%=ADM_FAX%>">
      </label>
    </section>
    <label class="label col col-md-2">E-MAIL</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_email" data-parsley-maxlength="60" value="<%=ADM_EMAIL%>">
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
  $("#profileform").parsley();
</script>
