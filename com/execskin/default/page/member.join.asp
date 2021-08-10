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

   PG_METHOD = Trim(Request("method"))
%>
<% If PG_METHOD = "" OR PG_METHOD = "agreement" Then %>
<div class="row">
  <div class="col-sm-10 col-sm-offset-1 margin-bottom-30">
    <div class="steps margin-bottom-30 hidden-xs">
      <ul>
        <li data-target="#step1" class="active">
          <span class="badge badge-info">1</span>회원가입동의<span class="chevron"></span>
        </li>
        <li data-target="#step2">
          <span class="badge">2</span>회원정보입력<span class="chevron"></span>
        </li>
        <li data-target="#step3">
          <span class="badge">3</span>회원가입완료<span class="chevron"></span>
        </li>
      </ul>
    </div>

    <form name="w_form" method="get" class="form">

    <label style="margin-bottom:15px;"><strong>이용약관</strong></label>
    <pre style="border:1px solid #C8C8C8;height:250px;overflow:auto;position:relative; margin-bottom:15px;padding:5px;border-radius: 0 !important;">
<%
      Server.Execute("/skin/" & SKIN & "/items/clause.asp")
%>
    </pre>

    <label class="checkbox">
      <input type="checkbox" name="use_check" value="1">
      <i></i><font color="#666666">위의 '이용약관'에 동의합니다.</font>
    </label>
    <br>

    <label style="margin-bottom:15px;"><strong>개인정보보호정책</strong></label>
    <pre style="border:1px solid #C8C8C8;height:250px;overflow:auto;position:relative; margin-bottom:15px;padding:5px;border-radius: 0 !important;">
<%
      Server.Execute("/skin/" & SKIN & "/items/privacy.asp")
%>
    </pre>

    <label class="checkbox">
      <input type="checkbox" name="row_check" value="1">
      <i></i><font color="#666666">위의 '개인정보보호취급방침'에 동의합니다.</font>
    </label>
    <br>

    <footer class="text-center">
      <a href="javascript:form_check();" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 가입동의</a>
      <a href="javascript:document.location.href='/';" class="btn btn-default">가입취소</a>
    </footer>
    </form>
  </div>
</div>

<script language="javascript">
<!--
  var form = document.w_form;

  function form_check(){
    if(form.use_check.checked == false){
      alert("이용약관에 동의해 주세요");
      return;
    }

    if(form.row_check.checked == false){
      alert("개인정보 보호정책에 동의해 주세요");
      return;
    }

    document.location.href = "?method=join";
    return;
  }
-->
</script>

<% End If %>

<% If PG_METHOD = "join" Then %>
<%
   MUSE_EMAIL = "1"
   MREQ_EMAIL = "1"
   MUSE_HP = "1"
   MREQ_HP = "1"

   Function f_checkbox(input_nm,cd_code,cd_name)
      If InStr(cd_code,",") > 0 Then
         s_code = Split(cd_code,",")
         s_name = Split(cd_name,",")

         For fn = 0 to UBound(s_code)
            'if fn mod 3 = 0 AND fn > 0 Then rtn_str = rtn_str & "<br>"
            rtn_str = rtn_str & "      <label class=""checkbox"">" & vbNewLine
            rtn_str = rtn_str & "        <input type=""checkbox"" id=""" & input_nm & """ name=""" & input_nm & """ value=""" & s_code(fn) & """ class=""require-one""><i></i>" & s_name(fn) & vbNewLine
            rtn_str = rtn_str & "      </label>" & vbNewLine
         Next
      Else
         rtn_str = rtn_str & "      <label class=""checkbox"">" & vbNewLine
         rtn_str = rtn_str & "        <input type=""checkbox"" id=""" & input_nm & """ name=""" & input_nm & """ value=""" & cd_code & """ class=""require-one""><i></i>" & cd_name & vbNewLine
         rtn_str = rtn_str & "      </label>" & vbNewLine
      End If

      f_checkbox = rtn_str
   End Function
%>
<div class="row">
  <div class="col-sm-10 col-sm-offset-1 margin-bottom-30">

<div class="steps margin-bottom-30 hidden-xs">
  <ul>
    <li data-target="#step1">
      <span class="badge">1</span>회원가입동의<span class="chevron"></span>
    </li>
    <li data-target="#step2" class="active">
      <span class="badge badge-info">2</span>회원정보입력<span class="chevron"></span>
    </li>
    <li data-target="#step3">
      <span class="badge">3</span>회원가입완료<span class="chevron"></span>
    </li>
  </ul>
</div>

<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">회원가입</h4>
  </div>
  <div class="panel-body no-padding">

<form name="join_form" id="join_form" method="post" class="form">
<input type="hidden" name="action" value="member.join">
<input type="hidden" name="ara_code" value="<%=ARA_CODE%>">
<input type="hidden" name="mem_certify" id="mem_certify">

  <header>
    아이디/비밀번호
    <p class="note">사용하실 아이디/비밀번호를 입력하세요.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 아이디</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_id" id="mem_id" value="<%=MEM_ID%>">
        </label>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 비밀번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="password" name="mem_pwd" id="mem_pwd" value="<%=MEM_PWD%>">
        </label>
      </section>
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 비밀번호 확인</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="password" name="mem_pwd2" id="mem_pwd2" value="<%=MEM_PWD2%>">
        </label>
      </section>
    </div>
  </fieldset>

  <header>
    기본정보
    <p class="note">회원 정보를 입력하세요..</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 이름</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_name" id="mem_name" value="<%=MEM_NAME%>">
        </label>
      </section>
<% If MUSE_NICKNAME = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_NICKNAME = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>닉네임</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_nickname" id="mem_nickname" value="<%=MEM_NICKNAME%>">
        </label>
      </section>
<% End If %>
    </div>

<% If MUSE_SEX = "1" OR MUSE_BIRTH = "1" Then %>
    <div class="row">
<% If MUSE_SEX = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_SEX = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>성별</label>
      <section class="col col-md-4">

      <div class="inline-group">
        <label class="radio">
          <input type="radio" name="mem_sex" id="mem_sex" value="1" checked>
          <i></i>남
        </label>
        <label class="radio">
          <input type="radio" name="mem_sex" id="mem_sex" value="2">
          <i></i>여
        </label>
      </div>
      </section>
<% End If %>
<% If MUSE_BIRTH = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_BIRTH = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>생년월일</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_birth" id="mem_birth" value="<%=MEM_BIRTH%>">
        </label>
      </section>
<% End If %>
    </div>
<% End If %>

    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 휴대전화</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_hp" id="mem_hp" value="<%=MEM_HP%>">
        </label>
      </section>
<% If MUSE_TEL = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_TEL = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>전화번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_tel" id="mem_tel" value="<%=MEM_TEL%>">
        </label>
      </section>
<% End If %>
    </div>

<% If MC_CONFIRM = "2" Then %>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 이메일</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="email" name="mem_email" id="mem_email" value="<%=MEM_EMAIL%>">
          <p class="note">* 인증메일받기를 클릭하여 인증메일을 받으실 수 있습니다.</p>
        </label>
        <label class="input" style="margin-top:5px;" id="btn_sned">
          <button type="button" class="btn btn-default pull-right" onclick="emailcertify();">인증메일발송</button>
        </label>
      </section>
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 이메일인증</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_certify_num" id="mem_certify_num" value="<%=MEM_CERTIFY_NUM%>">
          <p class="note">* 메일로 수신한 인증번호를 입력해주세요.</p>
        </label>
        <label class="input" style="margin-top:5px;" id="btn_certify">
          <button type="button" class="btn btn-default pull-right" onclick="emailcertifyGo();">인증하기</button>
        </label>
      </section>
    </div>
<% End If %>

<% If MC_CONFIRM <> "2" OR MUSE_FAX = "1" Then %>
    <div class="row">
<% If MC_CONFIRM <> "2" Then %>
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 이메일</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="email" name="mem_email" id="mem_email" value="<%=MEM_EMAIL%>">
        </label>
      </section>
<% End If %>

<% If MUSE_FAX = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_FAX = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>팩스번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_fax" id="mem_fax" value="<%=MEM_FAX%>">
        </label>
      </section>
<% End If %>
    </div>
<% End If %>

<% If MUSE_ADDR = "1" Then %>
    <div class="row">
      <label class="label col col-md-2"><% If MREQ_ADDR = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>주소</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" style="width:25%;display:inline-block;" id="mem_zipcode" name="mem_zipcode" value="<%=MEM_ZIPCODE%>" readonly>
          <button type="button" class="btn btn-default" style="display:inline-block;" onclick="javascript:openDaumPostcode();">주소찾기</button>
        </label>
        <label class="input" style="margin-top:5px;">
          <input type="text" name="mem_addr1" id="mem_addr1" value="<%=MEM_ADDR1%>" readonly>
        </label>
        <label class="input"  style="margin-top:5px;">
          <input type="text" name="mem_addr2" id="mem_addr2" value="<%=MEM_ADDR2%>">
        </label>
      </section>
    </div>
<% End If %>

<% If MUSE_EMAIL_YN = "1" OR MUSE_SMS_YN = "1" Then %>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i>  수신동의</label>
      <section class="col col-md-4">
      <div class="inline-group">
<% If MUSE_EMAIL_YN = "1" Then %>
        <label class="checkbox">
          <input type="checkbox" name="mem_email_yn" id="mem_email_yn" value="1" checked>
          <i></i>EMAIL 수신동의
        </label>
<% End If %>
<% If MUSE_SMS_YN = "1" Then %>
        <label class="checkbox">
          <input type="checkbox" name="mem_sms_yn" id="mem_sms_yn" value="1" checked>
          <i></i>SMS 수신동의
        </label>
<% End If %>
      </div>
      </section>
    </div>
<% End If %>
  </fieldset>

<% If MUSE_CNO = "1" OR MUSE_CNAME = "1" OR MUSE_CSERVICE = "1" OR MUSE_CITEM = "1" Then %>
  <header>
    사업자정보
    <p class="note">사업자정보를 입력하세요..</p>
  </header>

  <fieldset>
<% If MUSE_CNO = "1" OR MUSE_CNAME = "1" Then %>
    <div class="row">
<% If MUSE_CNO = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_CNO = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>사업자번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_cno" id="mem_cno" value="<%=MEM_CNO%>">
        </label>
      </section>
<% End If %>
<% If MREQ_CNAME = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_CNAME = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>회사명</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_cname" id="mem_cname" value="<%=MEM_CNAME%>">
        </label>
      </section>
<% End If %>
    </div>
<% End If %>

<% If MUSE_CSERVICE = "1" OR MUSE_CITEM = "1" Then %>
    <div class="row">
<% If MUSE_CSERVICE = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_CSERVICE = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>업태</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_cservice" id="mem_cservice" value="<%=MEM_CSERVICE%>">
        </label>
      </section>
<% End If %>
<% If MUSE_CITEM = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_CITEM = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>종목</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_citem" id="mem_citem" value="<%=MEM_CITEM%>">
        </label>
      </section>
<% End If %>
    </div>
<% End If %>
  </fieldset>
<% End If %>

<% If MUSE_MERRI_DATE = "1" OR MUSE_JOB = "1" OR MUSE_INTEREST = "1" OR MUSE_RECOMM_ID = "1" OR MUSE_ADD1 = "1" OR MUSE_ADD2 = "1" OR MUSE_ADD3 = "1" OR MUSE_ADD4 = "1" OR MUSE_MEMO = "1" Then %>
  <header>
    추가정보
    <p class="note">추가정보를 입력하세요..</p>
  </header>

  <fieldset>
<% If MUSE_MERRI_DATE = "1" Then %>
    <div class="row">
      <label class="label col col-md-2"><% If MREQ_MERRI_DATE = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>결혼기념일</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_merri_date" id="mem_merri_date" value="<%=MEM_MERRI_DATE%>">
        </label>
      </section>
    </div>
<% End If %>
<% If MUSE_JOB = "1" Then %>
    <div class="row">
      <label class="label col col-md-2"><% If MREQ_JOB = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>직업</label>
      <section class="col col-md-4">
        <label class="select">
          <select name="mem_job" id="mem_job">
            <option value="">직업선택</option>
<%=f_arr_opt(MEM_JOB_CD, MEM_JOB_NAME)%>
          </select>
        </label>
      </section>
    </div>
<% End If %>
<% If MUSE_INTEREST = "1" Then %>
    <div class="row">
      <label class="label col col-md-2"><% If MREQ_INTEREST = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>관심분야</label>
      <section class="col col-md-10">
      <div class="inline-group" id="mem_interest">
<%=f_checkbox("mem_interest", MEM_INTEREST_CD, MEM_INTEREST_NAME)%>
      </div>
      </section>
    </div>
<% End If %>
<% If (MUSE_FIELD1 <> "" AND MUSE_ADD1 = "1") OR MUSE_FIELD2 <> "" AND MUSE_ADD2 = "1" Then %>
    <div class="row">
<% If MUSE_FIELD1 <> "" AND MUSE_ADD1 = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_ADD1 = "1" Then %><i class="fa fa-check color-red"></i> <% End If %><%=MUSE_FIELD1%></label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_add1" id="mem_add1" value="<%=MEM_ADD1%>">
        </label>
      </section>
<% End If %>
<% If MUSE_FIELD2 <> "" AND MUSE_ADD2 = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_ADD2 = "1" Then %><i class="fa fa-check color-red"></i> <% End If %><%=MUSE_FIELD2%></label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_add2" id="mem_add2" value="<%=MEM_ADD2%>">
        </label>
      </section>
<% End If %>
    </div>
<% End If %>
<% If (MUSE_FIELD3 <> "" AND MUSE_ADD3 = "1") OR (MUSE_FIELD4 <> "" AND MUSE_ADD4 = "1") Then %>
    <div class="row">
<% If MUSE_FIELD3 <> "" AND MUSE_ADD3 = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_ADD3 = "1" Then %><i class="fa fa-check color-red"></i> <% End If %><%=MUSE_FIELD3%></label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_add3" id="mem_add3" value="<%=MEM_ADD3%>">
        </label>
      </section>
<% End If %>
<% If MUSE_FIELD4 <> "" AND MUSE_ADD4 = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_ADD4 = "1" Then %><i class="fa fa-check color-red"></i> <% End If %><%=MUSE_FIELD4%></label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_add4" id="mem_add4" value="<%=MEM_ADD4%>">
        </label>
      </section>
<% End If %>
    </div>
<% End If %>
  </fieldset>
<% End If %>

  <footer class="text-center">
    <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 가입하기</button>
    <button type="button" class="btn btn-default" onclick="document.location.href='/';">가입취소</button>
  </footer>
</form>
  </div>
</div>

  </div>
</div>

<script language="javascript">
<!--
<% If MC_CONFIRM = "2" Then %>
  function emailcertify(){
    var mem_email = $("#mem_email");
    var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    if(!mem_email.val()){
      alert('이메일을 입력해 주세요.');
      mem_email.focus();
      return;
    } else {
      if(!regEmail.test(mem_email.val())) {
        alert('이메일 형식에 맞게 입력해 주세요.');
        mem_email.focus();
        return;
      }
    }

    $("#btn_sned").html('<button type="button" class="btn btn-default pull-right" onclick="return false;" style="font-weight:bold;">메일발송중..</button>');

    try{
      var sUrl = "/member/emailcertify";
      var params = "action=member.emailcertify&method=send&mem_email=" + mem_email.val();

      $("#mem_certify").val("0");

      $.ajax({
        type:"POST",
        url:sUrl,
        data:params,
        dataType:"text",
        success:function(args){
          if( args == "0" ){
            alert("이메일 인증 사이트가 아닙니다.");
          }else if( args == "1" ){
            alert("이미 사용중인 이메일 입니다.\n\n감사합니다.");
          }else if( args == "ok" ){
             alert("요청하신 메일이 전송 되었습니다.");
          }else{
            alert("새로고침 후 다시 시도해 주세요!");
          }
          $("#btn_sned").html('<button type="button" class="btn btn-default pull-right" onclick="emailcertify();">인증메일 다시받기</button>');
        },
        error:function(E){
          alert("Error : " + E.responseText);
          $("#btn_sned").html('<button type="button" class="btn btn-default pull-right" onclick="emailcertify();">인증메일받기</button>');
        }
      });
    }catch(E){
      alert("Error");
      $("#btn_sned").html('<button type="button" class="btn btn-default pull-right" onclick="emailcertify();">인증메일받기</button>');
    }
  }

  function emailcertifyGo(){
    var mem_certify_num = $("#mem_certify_num");
    if( !mem_certify_num.val() ){
      alert('\'인증번호\'를 입력해 주세요.');
      mem_certify_num.focus();
      return;
    }

    try{
      var sUrl = "/member/emailcertify";
      var params = "action=member.emailcertify&method=certify&mem_certify_num=" + mem_certify_num.val();

      $.ajax({
        type:"POST",
        url:sUrl,
        data:params,
        dataType:"text",
        success:function(args){
          if( args == "Y" ){
            $("#btn_certify").html('<button type="button" class="btn btn-default pull-right" onclick="return false;" style="font-weight:bold;">인증완료..</button>');
            $("#mem_certify").val("1");
          }else{
            alert("죄송합니다. 입력한 인증 코드가 올바르지 않습니다. \n\n다시 시도해 주세요.");
            return;
          }
        },
        error:function(E){
          alert("Error : " + E.responseText);
        }
      });
    }catch(E){
        alert("Error");
    }
  }
<% End If %>
  $(function() {
    $.validator.addMethod("alphanumeric", function(value, element) {
      return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
    });

    $.validator.addMethod("hpnumber", function(value, element) {
      return this.optional(element) || /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/.test(value);
    });

    $.validator.addMethod("telnumber", function(value, element) {
      return this.optional(element) || /^\d{2,3}-\d{3,4}-\d{4}$/.test(value);
    });

    $.validator.addMethod("isdate", function(value, element) {
      return this.optional(element) || /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/.test(value);
    });

    $.validator.addMethod("biznumber", function(value, element) {
      return this.optional(element) || /^\d{3}-{0,1}\d{2}-{0,1}\d{5}$/.test(value);
    });

    var checkboxes = $('.require-one');
    var checkbox_names = $.map(checkboxes, function(e,i) { return $(e).attr("name")}).join(" ");

    $("#join_form").validate({
      rules:{
        mem_id:{required:true,minlength:4,maxlength:15,alphanumeric:true,remote:{type:"post",url:"/exec/action/member.idcheck.asp"}}
        ,mem_pwd:{required:true,minlength:4,maxlength:15}
        ,mem_pwd2:{required:true,equalTo:"#mem_pwd"}
        ,mem_name:{required:true,minlength:2,maxlength:10}
        ,mem_nickname:{required:<% If MREQ_NICKNAME = "1" Then %>true<% Else %>false<% End If %>,minlength:2,maxlength:10}
        ,mem_sex:{required:<% If MREQ_SEX = "1" Then %>true<% Else %>false<% End If %>}
        ,mem_birth:{required:<% If MREQ_BIRTH = "1" Then %>true<% Else %>false<% End If %>,isdate:true}
        ,mem_hp:{required:<% If MREQ_HP = "1" Then %>true<% Else %>false<% End If %>,hpnumber:true,maxlength:15}
        ,mem_tel:{required:<% If MREQ_TEL = "1" Then %>true<% Else %>false<% End If %>,telnumber:true,maxlength:15}
        ,mem_fax:{required:<% If MREQ_FAX = "1" Then %>true<% Else %>false<% End If %>,telnumber:true,maxlength:15}
        ,mem_email:{required:true,email:true,remote:{type:"post",url:"/exec/action/member.emailcheck.asp"}}
        ,mem_addr1:{required:<% If MREQ_ADDR = "1" Then %>true<% Else %>false<% End If %>}
        ,mem_addr2:{required:<% If MREQ_ADDR = "1" Then %>true<% Else %>false<% End If %>,maxlength:30}
        ,mem_cno:{required:<% If MREQ_CNO = "1" Then %>true<% Else %>false<% End If %>,biznumber:true,maxlength:15}
        ,mem_cname:{required:<% If MREQ_CNAME = "1" Then %>true<% Else %>false<% End If %>,maxlength:15}
        ,mem_cservice:{required:<% If MREQ_CSERVICE = "1" Then %>true<% Else %>false<% End If %>,maxlength:15}
        ,mem_citem:{required:<% If MREQ_CITEM = "1" Then %>true<% Else %>false<% End If %>,maxlength:15}
        ,mem_merri_date:{required:<% If MREQ_BIRTH = "1" Then %>true<% Else %>false<% End If %>,isdate:true}
        ,mem_job:{required:<% If MREQ_JOB = "1" Then %>true<% Else %>false<% End If %>}
        ,mem_interest:{required:<% If MREQ_INTEREST = "1" Then %>true<% Else %>false<% End If %>}
        ,mem_add1:{required:<% If MREQ_ADD1 = "1" Then %>true<% Else %>false<% End If %>,maxlength:30}
        ,mem_add2:{required:<% If MREQ_ADD2 = "1" Then %>true<% Else %>false<% End If %>,maxlength:30}
        ,mem_add3:{required:<% If MREQ_ADD3 = "1" Then %>true<% Else %>false<% End If %>,maxlength:30}
        ,mem_add4:{required:<% If MREQ_ADD4 = "1" Then %>true<% Else %>false<% End If %>,maxlength:30}
      },
      groups: {
        SendofYn:"mem_email_yn mem_sms_yn"
        ,checks: checkbox_names
      },
      messages:{
        mem_id:{
          required:"아이디를 입력해 주세요.",
          minlength:jQuery.validator.format("아이디는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("아이디는 최대 {0}자 이하로 입력해주세요."),
          alphanumeric:"알파벳과 숫자만 사용가능합니다.",
          remote:"이미 등록된 아이디입니다."
        }
        ,mem_pwd:{
          required:"비밀번호를 입력해 주세요.",
          minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_pwd2:{
          required:"비밀번호 확인을 입력해 주세요.",
          equalTo:"비밀번호가 일치하지 않습니다."
        }
        ,mem_name:{
          required:"이름을 입력해 주세요.",
          minlength:jQuery.validator.format("이름은 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_nickname:{
          required:"닉네임을 입력해 주세요.",
          minlength:jQuery.validator.format("닉네임은 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("닉네임은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_birth:{
          required:"생년월일을 입력해 주세요.",
          isdate:"날짜 형식(YYYY-MM-DD)에 맞게 입력하세요."
        }
        ,mem_hp:{
          required:"휴대전화 번호를 입력해 주세요.",
          hpnumber:"휴대전화 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_tel:{
          required:"전화번호를 입력해 주세요.",
          telnumber:"전화번호 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_fax:{
          required:"팩스번호를 입력해 주세요.",
          telnumber:"전화번호 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_email:{
          required:"이메일을 입력해 주세요.",
          email:"이메일 형식에 맞게 입력해 주세요.",
          remote:"이미 등록된 이메일 입니다."
        }
        ,mem_addr1:{
          required:"주소찾기로 주소를 찾아 주세요."
        }
        ,mem_addr2:{
          required:"상세 주소를 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_cno:{
          required:"사업자번호를 입력해 주세요.",
          biznumber:"사업자번호 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("사업자번호는 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_cname:{
          required:"회사명을 입력해 주세요.",
          maxlength:jQuery.validator.format("회사명은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_cservice:{
          required:"업태를 입력해 주세요.",
          maxlength:jQuery.validator.format("업내는 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_citem:{
          required:"종목을 입력해 주세요.",
          maxlength:jQuery.validator.format("종목은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_merri_date:{
          required:"결혼기념일 입력해 주세요.",
          isdate:"날짜 형식(YYYY-MM-DD)에 맞게 입력하세요."
        }
        ,mem_job:{
          required:"직업을 선택해 주세요."
        }
        ,mem_interest:{
          required:"관심분야를 선택해 주세요."
        }
        ,mem_add1:{
          required:"<%=MUSE_FIELD1%>을 입력해 주세요.",
          maxlength:jQuery.validator.format("<%=MUSE_FIELD1%>은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_add2:{
          required:"<%=MUSE_FIELD2%>을 입력해 주세요.",
          maxlength:jQuery.validator.format("<%=MUSE_FIELD2%>은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_add3:{
          required:"<%=MUSE_FIELD3%>을 입력해 주세요.",
          maxlength:jQuery.validator.format("<%=MUSE_FIELD3%>은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_add4:{
          required:"<%=MUSE_FIELD4%>을 입력해 주세요.",
          maxlength:jQuery.validator.format("<%=MUSE_FIELD4%>은 최대 {0}자 이하로 입력해주세요.")
        }
      },
      errorPlacement: function(error, element) {
        if (element.attr("name") == "mem_email_yn" || element.attr("name") == "mem_sms_yn") error.insertAfter("#send_yn");
        else if (element.attr("name") == "mem_interest") error.insertAfter("#mem_interest");
        else error.insertAfter(element);
      },
      highlight:function(element, errorClass, validClass){
        $(element).parents('.control-group').removeClass('success');
        $(element).parents('.control-group').addClass('error');
      },
      unhighlight: function(element, errorClass, validClass){
        $(element).parents('.control-group').removeClass('error');
        $(element).parents('.control-group').addClass('success');
      },
      submitHandler:function(form){
<% If MC_CONFIRM = "2" Then %>
        if($("#mem_certify").val() != "1"){
          alert("이메일 인증을 받으셔야 합니다.");
        }
<% End If %>
        var msg = "등록하시겠습니까?"
        if(confirm(msg)){
          form.submit();
        }else{
          return;
        }
      }
    });
  });
-->
</script>

<script src="<% If HTTPS_STATE = "on" Then %>https://spi.maps.daum.net/imap<% Else %>http://dmaps.daum.net<% End If %>/map_js_init/postcode.v2.js"></script>
<script>
  function openDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        var fullAddr = '';
        var extraAddr = '';

        if (data.userSelectedType === 'R') {
          fullAddr = data.roadAddress;
        } else {
          fullAddr = data.jibunAddress;
        }

        if(data.userSelectedType === 'R'){
          if(data.bname !== ''){
            extraAddr += data.bname;
          }
          if(data.buildingName !== ''){
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
        }

        document.getElementById('mem_zipcode').value = data.zonecode; //5자리 새우편번호 사용
        document.getElementById('mem_addr1').value = fullAddr;
        document.getElementById('mem_addr2').focus();
      }
    }).open();
  }
</script>

<% End If %>

<% If PG_METHOD = "join_end" Then %>
<div class="row">
  <div class="col-sm-10 col-sm-offset-1 margin-bottom-30">

    <div class="steps margin-bottom-30 hidden-xs">
      <ul>
        <li data-target="#step1">
          <span class="badge">1</span>회원가입동의<span class="chevron"></span>
        </li>
        <li data-target="#step2">
          <span class="badge">2</span>회원정보입력<span class="chevron"></span>
        </li>
        <li data-target="#step3" class="active">
          <span class="badge badge-info">3</span>회원가입완료<span class="chevron"></span>
        </li>
      </ul>
    </div>

    <div class="jumbotron">
      <h3>회원가입완료!!</h3>
      <p><%=CS_NAME%> 회원이 되신 것을 축하드립니다.</p>
      <p><a href="/" class="btn btn-theme btn-primary" role="button">처음으로 가기 &raquo;</a></p>
    </div>
  </div>
</div>
<% End If %>
