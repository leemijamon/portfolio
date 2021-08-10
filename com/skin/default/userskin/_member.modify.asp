<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/member_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   PG_METHOD = Trim(Request("method"))
%>
<% If PG_METHOD = "" OR PG_METHOD = "repass" Then %>
<div class="row">
  <div class="col-sm-12 margin-bottom-30">

<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">회원정보수정</h4>
  </div>
  <div class="panel-body no-padding">

<form name="modify_form" id="modify_form" method="post" class="form">
<input type="hidden" name="action" value="member.repw">
<input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">

  <header>
    비밀번호확인
    <p class="note">개인정보 보호를 위해 비밀번호를 한 번 더 입력하세요. 항상 비밀번호는 타인에게 노출되지 않도록 주의해 주세요.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 비밀번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="password" name="mem_pwd" id="mem_pwd" value="<%=MEM_PWD%>">
        </label>
      </section>
    </div>
  </fieldset>

  <footer class="text-center">
    <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 확인</button>
    <button type="button" class="btn btn-default" onclick="document.location.href='/';">취소</button>
  </footer>
</form>
  </div>
</div>

  </div>
</div>

<script type="text/javascript">
  $(function() {
    $("#modify_form").validate({
      rules:{
        mem_pwd:{required:true,minlength:4,maxlength:15}
      },
      messages:{
        mem_pwd:{
          required:"비밀번호를 입력해 주세요.",
          minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하로 입력해주세요.")
        }
      }
    });
  });
</script>
<% End If %>

<% If PG_METHOD = "modify" Then %>
<%
   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_NAME,MEM_NICKNAME,MEM_ID,MEM_PWD,MEM_LEVEL,MEM_JUMIN,MEM_JUMIN_CK,MEM_SEX,MEM_BIRTH
   Dim MEM_CALENDAR,MEM_MARRI_YN,MEM_MERRI_DATE,MEM_HP,MEM_TEL,MEM_FAX,MEM_EMAIL,MEM_CNO,MEM_CNAME,MEM_CSERVICE
   Dim MEM_CITEM,MEM_ZIPCODE,MEM_ADDR1,MEM_ADDR2,MEM_URL,MEM_JOB,MEM_INTEREST,MEM_SMS_YN,MEM_EMAIL_YN,MEM_LOG_IP
   Dim MEM_LOG_DATE,MEM_LOG_CNT,MEM_RECOMM_ID,MEM_MEMO,MEM_ADD1,MEM_ADD2,MEM_ADD3,MEM_ADD4,MEM_SALE,MEM_MONEY
   Dim MEM_WDATE,MEM_MDATE,MEM_STATE,ARA_CODE

   If IsNumeric(MEM_SEQ) = false Then Response.End

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & MEM_LST_Table & " WHERE MEM_SEQ=" & MEM_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MEM_SEQ = Rs("MEM_SEQ")
      MEM_NAME = Rs("MEM_NAME")
      MEM_NICKNAME = Rs("MEM_NICKNAME")
      MEM_ID = Rs("MEM_ID")
      MEM_PWD = Rs("MEM_PWD")
      MEM_LEVEL = Rs("MEM_LEVEL")
      MEM_SEX = trim(Rs("MEM_SEX"))
      MEM_BIRTH = trim(Rs("MEM_BIRTH"))
      MEM_CALENDAR = Rs("MEM_CALENDAR")
      MEM_MARRI_YN = Rs("MEM_MARRI_YN")
      MEM_MERRI_DATE = Rs("MEM_MERRI_DATE")
      MEM_HP = Rs("MEM_HP")
      MEM_TEL = Rs("MEM_TEL")
      MEM_FAX = Rs("MEM_FAX")
      MEM_EMAIL = Rs("MEM_EMAIL")
      MEM_CNO = Rs("MEM_CNO")
      MEM_CNAME = Rs("MEM_CNAME")
      MEM_CSERVICE = Rs("MEM_CSERVICE")
      MEM_CITEM = Rs("MEM_CITEM")
      MEM_ZIPCODE = Trim(Rs("MEM_ZIPCODE"))
      MEM_ADDR1 = Rs("MEM_ADDR1")
      MEM_ADDR2 = Rs("MEM_ADDR2")
      MEM_URL = Rs("MEM_URL")
      MEM_JOB = Rs("MEM_JOB")
      MEM_INTEREST = Rs("MEM_INTEREST")
      MEM_SMS_YN = Rs("MEM_SMS_YN")
      MEM_EMAIL_YN = Rs("MEM_EMAIL_YN")
      MEM_ADD1 = Rs("MEM_ADD1")
      MEM_ADD2 = Rs("MEM_ADD2")
      MEM_ADD3 = Rs("MEM_ADD3")
      MEM_ADD4 = Rs("MEM_ADD4")
      ARA_CODE = Rs("ARA_CODE")

      If MEM_BIRTH <> "" Then MEM_BIRTH = f_date(MEM_BIRTH, "-")
      If MEM_MERRI_DATE <> "" Then MEM_MERRI_DATE = f_date(MEM_MERRI_DATE, "-")

      If IsNULL(MEM_INTEREST) Then MEM_INTEREST = ""
      SP_INTEREST = Split(MEM_INTEREST,",")

      For fn = 0 to UBound(SP_INTEREST)
         CK_INTEREST = CK_INTEREST & "  $(""input:checkbox[name='mem_interest']:checkbox[value='" & trim(SP_INTEREST(fn)) & "']"").attr(""checked"",true);" & vbNewLine
      Next
   End If
   Rs.close

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
<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">회원정보수정</h4>
  </div>
  <div class="panel-body no-padding">

<form name="join_form" id="join_form" method="post" class="form">
<input type="hidden" name="action" value="member.modify">
<input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">
<input type="hidden" name="mem_calendar" value="1">
<input type="hidden" name="ara_code" value="<%=ARA_CODE%>">

  <header>
    아이디/비밀번호
    <p class="note">비밀번호 입력시만 비밀번호가 변경됩니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2">아이디</label>
      <section class="col col-md-4">
        <p class="form-control-static"><%=MEM_ID%></p>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2">비밀번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="password" name="mem_pwd" id="mem_pwd" value="">
        </label>
      </section>
      <label class="label col col-md-2">비밀번호 확인</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="password" name="mem_pwd2" id="mem_pwd2" value="">
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
      <label class="label col col-md-2">이름</label>
      <section class="col col-md-4">
        <p class="form-control-static"><%=MEM_NAME%></p>
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
          <input type="radio" name="mem_sex" id="mem_sex" value="1">
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

    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 이메일</label>
      <section class="col col-md-4">
<% If MC_CONFIRM = "2" Then %>
        <p class="form-control-static"><%=mem_email%></p>
        <input type="hidden" name="mem_email" id="mem_email" value="<%=MEM_EMAIL%>">
<% Else %>
        <label class="input">
          <input type="email" name="mem_email" id="mem_email" value="<%=MEM_EMAIL%>">
        </label>
<% End If %>
      </section>
<% If MUSE_FAX = "1" Then %>
      <label class="label col col-md-2"><% If MREQ_FAX = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>팩스번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_fax" id="mem_fax" value="<%=MEM_FAX%>">
        </label>
      </section>
<% End If %>
    </div>

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
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 수신동의</label>
      <section class="col col-md-10">
      <div class="inline-group">
<% If MUSE_EMAIL_YN = "1" Then %>
        <label class="checkbox">
          <input type="checkbox" name="mem_email_yn" id="mem_email_yn" value="1">
          <i></i>EMAIL 수신동의
        </label>
<% End If %>
<% If MUSE_SMS_YN = "1" Then %>
        <label class="checkbox">
          <input type="checkbox" name="mem_sms_yn" id="mem_sms_yn" value="1">
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
<% If MUSE_RECOMM_ID = "1" Then %>
    <div class="row">
      <label class="label col col-md-2"><% If MREQ_RECOMM_ID = "1" Then %><i class="fa fa-check color-red"></i> <% End If %>추천인 아이디</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="mem_recomm_id" id="mem_recomm_id" value="<%=MEM_RECOMM_ID%>">
        </label>
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
    <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 회원정보수정</button>
    <button type="button" class="btn btn-default" onclick="document.location.href='/';">취소</button>
    <button type="button" class="btn btn-warning" onclick="document.location.href='?method=secede';">회원탈퇴</button>
  </footer>
</form>
  </div>
</div>

<script language="javascript">
<!--
  $(function() {
    $('input:radio[name=mem_sex]:input[value="<%=MEM_SEX%>"]').attr("checked", true);
    $('input:checkbox[name=mem_email_yn]:input[value="<%=trim(MEM_EMAIL_YN)%>"]').attr("checked", true);
    $('input:checkbox[name=mem_sms_yn]:input[value="<%=trim(MEM_SMS_YN)%>"]').attr("checked", true);
    //$("select[name='mem_job']").val("<%=MEM_JOB%>");
    $('select[name=mem_job]').find('option[value="<%=MEM_JOB%>"]').prop('selected', true);
<%=CK_INTEREST%>

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
        mem_pwd:{minlength:4,maxlength:15}
        ,mem_pwd2:{equalTo:"#mem_pwd"}
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
        mem_pwd:{
          minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_pwd2:{
          equalTo:"비밀번호가 일치하지 않습니다."
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
        ,mem_recomm_id:{
          required:"추천인 아이디를 입력해 주세요.",
          maxlength:jQuery.validator.format("추천인 아이디를는 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_add1:{
          required:"<%=MUSE_FIELD4%>을 입력해 주세요.",
          maxlength:jQuery.validator.format("<%=MUSE_FIELD4%>은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_add2:{
          required:"<%=MUSE_FIELD4%>을 입력해 주세요.",
          maxlength:jQuery.validator.format("<%=MUSE_FIELD4%>은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_add3:{
          required:"<%=MUSE_FIELD4%>을 입력해 주세요.",
          maxlength:jQuery.validator.format("<%=MUSE_FIELD4%>은 최대 {0}자 이하로 입력해주세요.")
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

<% If PG_METHOD = "secede" Then %>
<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">회원탈퇴</h4>
  </div>
  <div class="panel-body no-padding">

    <form name="sform" id="sform" method="post" class="form" role="form">
    <input type="hidden" name="action" value="member.secede">
    <input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">

      <header>
        회원탈퇴
        <p class="note">탈퇴한 아이디는 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.</p>
      </header>

      <fieldset>
        <div class="row">
          <label class="label col col-md-2">아이디</label>
          <section class="col col-md-4">
            <p class="form-control-static"><%=MEM_ID%></p>
          </section>
        </div>

        <div class="row">
          <label class="label col col-md-2">이름</label>
          <section class="col col-md-4">
            <p class="form-control-static"><%=MEM_NAME%></p>
          </section>
        </div>

        <div class="row">
          <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 비밀번호</label>
          <section class="col col-md-4">
            <label class="input">
              <input type="password" id="mem_pwd" name="mem_pwd">
            </label>
          </section>
        </div>

        <div class="row">
          <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 탈퇴사유</label>
          <section class="col col-md-4">
            <label class="select">
              <select name="mem_secede">
                <option value="">탈퇴사유를 선택해주세요</option>
                <option value="">----------------------------</option>
<%=f_arr_opt(MEM_SECEDE_CD,MEM_SECEDE_NAME)%>
              </select>
            </label>
          </section>
        </div>

        <div class="row">
          <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 남기고 싶은 말</label>
          <section class="col col-md-10">
            <label class="textarea">
              <textarea name="mem_secede_detail" id="mem_secede_detail" rows="10"></textarea>
            </label>
          </section>
        </div>
      </fieldset>

      <footer class="text-center">
        <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 회원탈퇴</button>
        <button type="button" class="btn btn-default" onclick="document.location.href='/';">취소</button>
      </footer>
    </form>

  </div>
</div>

<script type="text/javascript">
  $(function() {
    $("#sform").validate({
      rules:{
        mem_pwd:{required:true,minlength:4,maxlength:15}
        ,mem_secede:{required:true}
        ,mem_secede_detail:{required:true,maxlength:200}
      },
      messages:{
        mem_pwd:{
          required:"비밀번호를 입력해 주세요.",
          minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_secede:{
          required:"탈퇴사유를 선택 주세요.",
        }
        ,mem_secede_detail:{
          required:"남기고 싶은말을 입력해 주세요.",
          maxlength:jQuery.validator.format("남기고 싶은말은 최대 {0}자 이하로 입력해주세요.")
        }
      },
      submitHandler:function(form){
        var msg = "회원탈퇴 하시겠습니까?"
        if(confirm(msg)){
          form.submit();
        }else{
          return;
        }
      }
    });
  });
</script>
<% End If %>
