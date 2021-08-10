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

   If request("adm_seq") <> "" Then
      ADM_SEQ = request("adm_seq")

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
         'ADM_JUMIN = Rs("ADM_JUMIN")
         ADM_ID = Rs("ADM_ID")
         ADM_PWD = Rs("ADM_PWD")
         ADM_HP = Rs("ADM_HP")
         ADM_TEL = Rs("ADM_TEL")
         ADM_FAX = Rs("ADM_FAX")
         'ADM_ZIPCODE = Rs("ADM_ZIPCODE")
         'ADM_ADDR1 = Rs("ADM_ADDR1")
         'ADM_ADDR2 = Rs("ADM_ADDR2")
         ADM_EMAIL = Rs("ADM_EMAIL")
         ADM_POST = Rs("ADM_POST")
         ADM_ACCOUNT = Rs("ADM_ACCOUNT")
         ADM_PERMIT = Rs("ADM_PERMIT")

         'ADM_JUMIN1 = Left(ADM_JUMIN,6)
         'ADM_JUMIN2 = Right(ADM_JUMIN,7)

         'ADM_ZIPCODE1 = Left(ADM_ZIPCODE,3)
         'ADM_ZIPCODE2 = Right(ADM_ZIPCODE,3)

         If IsNULL(ADM_PERMIT) Then ADM_PERMIT = ""

         SP_PERMIT = Split(ADM_PERMIT,",")

         For fn = 0 to UBound(SP_PERMIT)
            CK_PERMIT = CK_PERMIT & "  $(""input:checkbox[name='adm_permit']:checkbox[value='" & trim(SP_PERMIT(fn)) & "']"").attr(""checked"",true);" & vbNewLine
         Next
      End If
      Rs.close

      Conn.Close
      Set Conn = nothing

      ADM_METHOD = "modify"
   Else
      ADM_TYPE = "02"
      ADM_METHOD = "register"
   End If
%>
<form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf.admin">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="method" value="<%=ADM_METHOD%>">

<fieldset>
  <div class="row">
    <label class="label col col-md-2">관리자구분</label>
    <section class="col col-md-10">
    <div class="inline-group">
<%
   With response
   If Session("ADM_TYPE") = "00" AND ADM_TYPE = "00" Then
      .write "      <label class='radio'>" & vbNewLine
      .write "        <input type='radio' name='adm_type' value='00'>" & vbNewLine
      .write "        <i></i>관리자" & vbNewLine
      .write "      </label>" & vbNewLine
   Else
      s_code = Split(ADM_TYPE_CD,",")
      s_name = Split(ADM_TYPE_NAME,",")

      For fn = 0 to UBound(s_code)
         .write "      <label class='radio'>" & vbNewLine
         .write "        <input type='radio' name='adm_type' value='" & s_code(fn) & "'>" & vbNewLine
         .write "        <i></i>" & s_name(fn) & vbNewLine
         .write "      </label>" & vbNewLine
      Next
   End If
   End With
%>
    </div>
    </section>
  </div>
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
        <input type="text" name="adm_hp" data-parsley-maxlength="15" value="<%=ADM_HP%>" data-parsley-pattern="^^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$" placeholder="ex)010-1234-5678">
      </label>
    </section>
    <label class="label col col-md-2">일반전화</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_tel" data-parsley-maxlength="15" value="<%=ADM_TEL%>" data-parsley-pattern="^\d{2,3}-\d{3,4}-\d{4}$" placeholder="ex)02-1234-5678">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">FAX</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="adm_fax" data-parsley-maxlength="15" value="<%=ADM_FAX%>" data-parsley-pattern="^\d{2,3}-\d{3,4}-\d{4}$" placeholder="ex)02-1234-5678">
      </label>
    </section>
    <label class="label col col-md-2">E-MAIL</label>
    <section class="col col-md-4">
      <label class="input">
        <input type="email" name="adm_email" data-parsley-maxlength="60" value="<%=ADM_EMAIL%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">접근권한</label>
    <section class="col col-md-3">
      <label class="select">
        <input type="checkbox" name="adm_permit" value="config"> 설정관리
      </label>
      <label class="select">
        <input type="checkbox" name="adm_permit" value="design"> 디자인관리
      </label>
    </section>
    <section class="col col-md-3">
      <label class="select">
        <input type="checkbox" name="adm_permit" value="member"> 회원관리
      </label>
      <label class="select">
        <input type="checkbox" name="adm_permit" value="board"> 컨텐츠관리
      </label>
    </section>
    <section class="col col-md-3">
      <label class="select">
        <input type="checkbox" name="adm_permit" value="state"> 통계
      </label>
      <label class="select">
        <input type="checkbox" name="adm_permit" value="service"> 서비스관리
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
  $("input:radio[name='adm_type']:radio[value='<%=ADM_TYPE%>']").attr("checked",true);
<%=CK_PERMIT%>

  $("#editform").parsley();
</script>
