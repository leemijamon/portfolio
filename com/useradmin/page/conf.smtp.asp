<%
   CC_TYPE = "smtp"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   AM_SMTP_USE = f_arr_value(CC_KEY, CC_VALUE, "AM_SMTP_USE")
   AM_SMTP_DOMAIN = f_arr_value(CC_KEY, CC_VALUE, "AM_SMTP_DOMAIN")
   AM_SMTP_PORT = f_arr_value(CC_KEY, CC_VALUE, "AM_SMTP_PORT")
   AM_SMTP_SSL = f_arr_value(CC_KEY, CC_VALUE, "AM_SMTP_SSL")
   AM_SMTP_ID = f_arr_value(CC_KEY, CC_VALUE, "AM_SMTP_ID")
   AM_SMTP_PWD = f_arr_value(CC_KEY, CC_VALUE, "AM_SMTP_PWD")

   If AM_SMTP_USE = "" Then AM_SMTP_USE = "0"
   If AM_SMTP_PORT = "" Then AM_SMTP_PORT = "25"
   If AM_SMTP_SSL = "" Then AM_SMTP_SSL = "0"
%>
<form id="smtpform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf">
<input type="hidden" name="rtnurl" value="conf/send">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">

  <header>
    SMTP 서버설정
    <p class="note">아이디/비밀번호는 필요시만 입력.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2">사용여부</label>
      <section class="col col-md-10">
      <div class="inline-group">
        <label class="radio">
          <input type="radio" name="am_smtp_use" value="1">
          <i></i>별도서버
        </label>
        <label class="radio">
          <input type="radio" name="am_smtp_use" value="0">
          <i></i>기본서버
        </label>
      </div>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2">메일서버(도메인 or IP)</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="am_smtp_domain" data-parsley-maxlength="50" value="<%=AM_SMTP_DOMAIN%>">
        </label>
      </section>
      <label class="label col col-md-2">포트</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="am_smtp_port" data-parsley-maxlength="10" data-parsley-type="number" value="<%=AM_SMTP_PORT%>">
        </label>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2">메일계정 아이디</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="am_smtp_id" data-parsley-maxlength="60" value="<%=AM_SMTP_ID%>">
        </label>
      </section>
      <label class="label col col-md-2">메일계정 비밀번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="am_smtp_pwd" data-parsley-maxlength="30" value="<%=AM_SMTP_PWD%>">
        </label>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2">SSL 사용여부</label>
      <section class="col col-md-10">
      <div class="inline-group">
        <label class="radio">
          <input type="radio" name="am_smtp_ssl" value="1">
          <i></i>사용
        </label>
        <label class="radio">
          <input type="radio" name="am_smtp_ssl" value="0">
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
  </footer>
</form>

<script type="text/javascript">
  $('input[name=am_smtp_use]:input[value="<%=AM_SMTP_USE%>"]').attr("checked", true);
  $('input[name=am_smtp_ssl]:input[value="<%=AM_SMTP_SSL%>"]').attr("checked", true);
</script>
