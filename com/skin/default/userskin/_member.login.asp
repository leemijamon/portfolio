<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/member_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   If Login_check = "Y" Then
      Response.Redirect "/member/modify"
      Response.End
   End If

   MEM_SID = Request.Cookies("member")("mem_id")
   IDSAVE = Request.Cookies("member")("idsave")

   RTN_PAGE = request("rtn_page")
%>
  <div class="row">
    <div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3">
      <div class="login-page">
        <form name="f_login" method="post" class="loginform" onsubmit="return login_check(this)">
          <input type="hidden" name="action" value="member.login">
          <input type="hidden" name="method" value="member">
          <input type="hidden" name="rtn_page" value="<%=RTN_PAGE%>">
<%
   For each item in Request.Form
      For fcnt = 1 to Request.Form(item).Count
         response.write "          <input type=""hidden"" name=""" & item & """ value=""" & Replace(Request.form(item)(fcnt),",","") & """>" & vbNewLine
      Next
   Next
%>
          <div class="login-header">
            <h2><strong><%=CS_NAME%></strong>에 오신것을 환영합니다.</h2>
          </div>
          <h5><i class="fa fa-lock"></i> 회원로그인</h5>

          <div class="input-group margin-bottom-20" id="msg_id">
            <span class="input-group-addon"><i class="fa fa-user"></i></span>
            <input type="text" name="mem_id" maxlength="15" tabindex="1" value="<%=MEM_SID%>" placeholder="아이디" class="form-control">
          </div>
          <div class="input-group margin-bottom-20" id="msg_pwd">
            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
            <input type="password" name="mem_pwd" maxlength="15" tabindex="2" placeholder="비밀번호" class="form-control">
          </div>
          <div class="row">
            <div class="col-md-6">
              <label class="checkbox"><input type="checkbox" name="idsave" value="1"><i></i>아이디 저장</label>
            </div>
            <div class="col-md-6">
              <button class="btn btn-theme btn-primary pull-right" type="submit" tabindex="3"><i class="fa fa-sign-in"></i> 로그인</button>
            </div>
          </div>
        </form>

        <hr>
        <p>
          <a href="/member/join"><%=SCM_NAME%> 회원이 아니세요?</a>&nbsp;&nbsp;<a href="/member/join" class="btn btn-xs btn-theme btn-primary">회원가입</a>
        </p>
        <p>
          <a href="/member/idsearch">아이디를 잊어버리셨나요?</a>&nbsp;&nbsp;<a href="/member/idsearch" class="btn btn-xs btn-theme btn-primary">아이디찾기</a>
        </p>
      </div>
    </div>
  </div>
<br>

<script language="javascript">
<!--
<% If IDSAVE = "1" Then %>
  $(function() {
    $("input:checkbox[name='idsave']").attr("checked", true);
  });
<% End If %>

  function login_check(form){
    if(!chkNull(form.mem_id, "\'사용자 ID\'을 입력해 주세요")) return false;
    if(!chkNull(form.mem_pwd, "\'비밀번호\'을 입력해 주세요")) return false;
    return true;
  }
-->
</script>
