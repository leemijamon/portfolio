<%
   CC_TYPE = "automail"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   AM_DEFAULT = f_arr_value(CC_KEY, CC_VALUE, "AM_DEFAULT")
   AM_JOIN = f_arr_value(CC_KEY, CC_VALUE, "AM_JOIN")
   AM_CERTIFY = f_arr_value(CC_KEY, CC_VALUE, "AM_CERTIFY")
   AM_IDSEARCH = f_arr_value(CC_KEY, CC_VALUE, "AM_IDSEARCH")
   AM_PWSEARCH = f_arr_value(CC_KEY, CC_VALUE, "AM_PWSEARCH")
   AM_SECEDE = f_arr_value(CC_KEY, CC_VALUE, "AM_SECEDE")
   AM_CONSULT = f_arr_value(CC_KEY, CC_VALUE, "AM_CONSULT")
   AM_QNA = f_arr_value(CC_KEY, CC_VALUE, "AM_QNA")
   AM_MEMBER = f_arr_value(CC_KEY, CC_VALUE, "AM_MEMBER")

   If AM_DEFAULT = "" Then AM_DEFAULT = "0"
   If AM_JOIN = "" Then AM_JOIN = "0"
   If AM_CERTIFY = "" Then AM_CERTIFY = "0"
   If AM_IDSEARCH = "" Then AM_IDSEARCH = "0"
   If AM_PWSEARCH = "" Then AM_PWSEARCH = "0"
   If AM_SECEDE = "" Then AM_SECEDE = "0"
   If AM_CONSULT = "" Then AM_CONSULT = "0"
   If AM_QNA = "" Then AM_QNA = "0"
   If AM_MEMBER = "" Then AM_MEMBER = "0"
%>
<form id="automailform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf">
<input type="hidden" name="rtnurl" value="conf/send">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">

  <header>
    메일발송 설정
    <p class="note">자동 전송하는 메일의 사용여부를 변경할 수 있습니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <section class="col col-md-6">
        <label class="toggle"><input type="checkbox" name="am_default" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>기본메일폼</label>
        <label class="toggle"><input type="checkbox" name="am_join" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>회원가입메일</label>
        <label class="toggle"><input type="checkbox" name="am_certify" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>회원가입 메일인증</label>
        <label class="toggle"><input type="checkbox" name="am_idsearch" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>아이디찾기메일</label>
        <label class="toggle"><input type="checkbox" name="am_pwsearch" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>비밀번호찾기메일</label>
      </section>

      <section class="col col-md-6">
        <label class="toggle"><input type="checkbox" name="am_secede" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>회원탈퇴메일</label>
        <label class="toggle"><input type="checkbox" name="am_consult" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>온라인문의답변메일</label>
        <label class="toggle"><input type="checkbox" name="am_qna" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>1:1문의답변메일</label>
        <label class="toggle"><input type="checkbox" name="am_member" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" class="toggleright"></i>회원메일(그룹발송)</label>
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
  $('input[name=am_default]:input[value="<%=AM_DEFAULT%>"]').attr("checked", true);
  $('input[name=am_join]:input[value="<%=AM_JOIN%>"]').attr("checked", true);
  $('input[name=am_certify]:input[value="<%=AM_CERTIFY%>"]').attr("checked", true);
  $('input[name=am_idsearch]:input[value="<%=AM_IDSEARCH%>"]').attr("checked", true);
  $('input[name=am_pwsearch]:input[value="<%=AM_PWSEARCH%>"]').attr("checked", true);
  $('input[name=am_secede]:input[value="<%=AM_SECEDE%>"]').attr("checked", true);
  $('input[name=am_consult]:input[value="<%=AM_CONSULT%>"]').attr("checked", true);
  $('input[name=am_qna]:input[value="<%=AM_QNA%>"]').attr("checked", true);
  $('input[name=am_member]:input[value="<%=AM_MEMBER%>"]').attr("checked", true);
</script>