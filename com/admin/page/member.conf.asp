<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim CMS_CONFIG_LST_Table
   CMS_CONFIG_LST_Table = "CMS_CONFIG_LST"

   Dim CC_KEY,CC_VALUE
   Dim CC_TYPE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   CC_TYPE = "member"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   MC_CONFIRM = f_arr_value(CC_KEY, CC_VALUE, "MC_CONFIRM")
   MC_REJOIN = f_arr_value(CC_KEY, CC_VALUE, "MC_REJOIN")
   MC_GROUP = f_arr_value(CC_KEY, CC_VALUE, "MC_GROUP")

   MUSE_NICKNAME = f_arr_value(CC_KEY, CC_VALUE, "MUSE_NICKNAME")
   MUSE_JUMIN = f_arr_value(CC_KEY, CC_VALUE, "MUSE_JUMIN")
   MUSE_SEX = f_arr_value(CC_KEY, CC_VALUE, "MUSE_SEX")
   MUSE_BIRTH = f_arr_value(CC_KEY, CC_VALUE, "MUSE_BIRTH")
   MUSE_CALENDAR = f_arr_value(CC_KEY, CC_VALUE, "MUSE_CALENDAR")
   MUSE_MARRI_YN = f_arr_value(CC_KEY, CC_VALUE, "MUSE_MARRI_YN")
   MUSE_MERRI_DATE = f_arr_value(CC_KEY, CC_VALUE, "MUSE_MERRI_DATE")
   MUSE_HP = f_arr_value(CC_KEY, CC_VALUE, "MUSE_HP")
   MUSE_TEL = f_arr_value(CC_KEY, CC_VALUE, "MUSE_TEL")
   MUSE_FAX = f_arr_value(CC_KEY, CC_VALUE, "MUSE_FAX")
   MUSE_EMAIL = f_arr_value(CC_KEY, CC_VALUE, "MUSE_EMAIL")
   MUSE_CNO = f_arr_value(CC_KEY, CC_VALUE, "MUSE_CNO")
   MUSE_CNAME = f_arr_value(CC_KEY, CC_VALUE, "MUSE_CNAME")
   MUSE_CSERVICE = f_arr_value(CC_KEY, CC_VALUE, "MUSE_CSERVICE")
   MUSE_CITEM = f_arr_value(CC_KEY, CC_VALUE, "MUSE_CITEM")
   MUSE_ADDR = f_arr_value(CC_KEY, CC_VALUE, "MUSE_ADDR")
   MUSE_JOB = f_arr_value(CC_KEY, CC_VALUE, "MUSE_JOB")
   MUSE_INTEREST = f_arr_value(CC_KEY, CC_VALUE, "MUSE_INTEREST")
   MUSE_SMS_YN = f_arr_value(CC_KEY, CC_VALUE, "MUSE_SMS_YN")
   MUSE_EMAIL_YN = f_arr_value(CC_KEY, CC_VALUE, "MUSE_EMAIL_YN")
   MUSE_ADD1 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_ADD1")
   MUSE_ADD2 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_ADD2")
   MUSE_ADD3 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_ADD3")
   MUSE_ADD4 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_ADD4")

   MUSE_FIELD1 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_FIELD1")
   MUSE_FIELD2 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_FIELD2")
   MUSE_FIELD3 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_FIELD3")
   MUSE_FIELD4 = f_arr_value(CC_KEY, CC_VALUE, "MUSE_FIELD4")

   MREQ_NICKNAME = f_arr_value(CC_KEY, CC_VALUE, "MREQ_NICKNAME")
   MREQ_JUMIN = f_arr_value(CC_KEY, CC_VALUE, "MREQ_JUMIN")
   MREQ_SEX = f_arr_value(CC_KEY, CC_VALUE, "MREQ_SEX")
   MREQ_BIRTH = f_arr_value(CC_KEY, CC_VALUE, "MREQ_BIRTH")
   MREQ_CALENDAR = f_arr_value(CC_KEY, CC_VALUE, "MREQ_CALENDAR")
   MREQ_MARRI_YN = f_arr_value(CC_KEY, CC_VALUE, "MREQ_MARRI_YN")
   MREQ_MERRI_DATE = f_arr_value(CC_KEY, CC_VALUE, "MREQ_MERRI_DATE")
   MREQ_HP = f_arr_value(CC_KEY, CC_VALUE, "MREQ_HP")
   MREQ_TEL = f_arr_value(CC_KEY, CC_VALUE, "MREQ_TEL")
   MREQ_FAX = f_arr_value(CC_KEY, CC_VALUE, "MREQ_FAX")
   MREQ_EMAIL = f_arr_value(CC_KEY, CC_VALUE, "MREQ_EMAIL")
   MREQ_CNO = f_arr_value(CC_KEY, CC_VALUE, "MREQ_CNO")
   MREQ_CNAME = f_arr_value(CC_KEY, CC_VALUE, "MREQ_CNAME")
   MREQ_CSERVICE = f_arr_value(CC_KEY, CC_VALUE, "MREQ_CSERVICE")
   MREQ_CITEM = f_arr_value(CC_KEY, CC_VALUE, "MREQ_CITEM")
   MREQ_ADDR = f_arr_value(CC_KEY, CC_VALUE, "MREQ_ADDR")
   MREQ_JOB = f_arr_value(CC_KEY, CC_VALUE, "MREQ_JOB")
   MREQ_INTEREST = f_arr_value(CC_KEY, CC_VALUE, "MREQ_INTEREST")
   MREQ_SMS_YN = f_arr_value(CC_KEY, CC_VALUE, "MREQ_SMS_YN")
   MREQ_EMAIL_YN = f_arr_value(CC_KEY, CC_VALUE, "MREQ_EMAIL_YN")
   MREQ_ADD1 = f_arr_value(CC_KEY, CC_VALUE, "MREQ_ADD1")
   MREQ_ADD2 = f_arr_value(CC_KEY, CC_VALUE, "MREQ_ADD2")
   MREQ_ADD3 = f_arr_value(CC_KEY, CC_VALUE, "MREQ_ADD3")
   MREQ_ADD4 = f_arr_value(CC_KEY, CC_VALUE, "MREQ_ADD4")

   If MC_CONFIRM = "" Then MC_CONFIRM = "0"
   If MC_REJOIN = "" Then MC_REJOIN = "0"
   If MC_GROUP = "" Then MC_GROUP = "09"

   'If MUSE_JUMIN = "" Then MUSE_JUMIN = "1"
   If MUSE_ADDR = "" Then MUSE_ADDR = "1"
   If MUSE_HP = "" Then MUSE_HP = "1"
   If MUSE_TEL = "" Then MUSE_TEL = "1"
   If MUSE_EMAIL = "" Then MUSE_EMAIL = "1"
   If MUSE_SMS_YN = "" Then MUSE_SMS_YN = "1"
   If MUSE_EMAIL_YN = "" Then MUSE_EMAIL_YN = "1"

   'If MREQ_JUMIN = "" Then MREQ_JUMIN = "1"
   If MREQ_ADDR = "" Then MREQ_ADDR = "1"
   If MREQ_HP = "" Then MREQ_HP = "1"
   'If MREQ_TEL = "" Then MREQ_TEL = "1"
   If MREQ_EMAIL = "" Then MREQ_EMAIL = "1"
   If MREQ_SMS_YN = "" Then MREQ_SMS_YN = "1"
   If MREQ_EMAIL_YN = "" Then MREQ_EMAIL_YN = "1"
%>
<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/dataTables.bootstrap.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">회원관리</a>
    </li>
    <li class="active">회원가입관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">회원가입관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-edit"></i> 회원가입관리</div>
        <div class="panel-body no-padding">

<form id="memberform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf">
<input type="hidden" name="rtnurl" value="member/conf">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">

  <header>
    회원가입 정책관리
    <p class="note">회원가입에 필요한 각종 정책을 정합니다</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2">회원인증절차</label>
      <section class="col col-md-10">
        <div class="inline-group">
        <label class="radio">
          <input type="radio" name="mc_confirm" value="0">
          <i></i>인증절차없음
        </label>
        <label class="radio">
          <input type="radio" name="mc_confirm" value="1">
          <i></i>관리자 인증 후 가입 <span class="note">(관리자 승인 후 가입처리할 수 있습니다)</span>
        </label>
        <label class="radio">
          <input type="radio" name="mc_confirm" value="2">
          <i></i>이메일 인증 후 가입 <span class="note">(이메일 인증을 통하여 가입승인 됩니다)</span>
        </label>
        </div>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2">회원재가입기간</label>
      <section class="col col-md-10">
        <label class="input">
          <input type="text" name="mc_rejoin" data-parsley-maxlength="3" data-parsley-type="number" value="<%=MC_REJOIN%>" style="width:75px;">
        </label>
        <p class="note">회원탈퇴 및 회원삭제 후 지정일 동안 재가입할 수 없습니다.</p>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2">가입시 회원그룹</label>
      <section class="col col-md-2">
        <label class="select">
          <select name="mc_group">
<%=f_arr_opt(MEM_LEVEL_CD, MEM_LEVEL_NAME)%>
          </select><i></i>
        </label>
        <p class="note">회원가입시 선택한 그룹에 속하도록 합니다.</p>
      </section>
    </div>
  </fieldset>

  <header>
    회원가입 항목관리
    <p class="note">회원가입에 필요한 각종 항목 사용 및 필수 여부를 정합니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <section class="col col-md-6 col-xs-12">

        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th style="width:60%;">가입항목</th>
              <th style="width:20%;">사용</th>
              <th style="width:20%;">필수</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>닉네임</td>
              <td><label class="toggle"><input type="checkbox" name="muse_nickname" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_nickname" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>주민등록번호</td>
              <td><label class="toggle"><input type="checkbox" name="muse_jumin" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_jumin" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>휴대전화</td>
              <td><label class="toggle"><input type="checkbox" name="muse_hp" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_hp" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>팩스번호</td>
              <td><label class="toggle"><input type="checkbox" name="muse_fax" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_fax" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>사업자번호</td>
              <td><label class="toggle"><input type="checkbox" name="muse_cno" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_cno" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>업태</td>
              <td><label class="toggle"><input type="checkbox" name="muse_cservice" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_cservice" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>메일링</td>
              <td><label class="toggle"><input type="checkbox" name="muse_email_yn" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_email_yn" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>생년월일</td>
              <td><label class="toggle"><input type="checkbox" name="muse_birth" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_birth" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>직업</td>
              <td><label class="toggle"><input type="checkbox" name="muse_job" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_job" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>추가항목1</td>
              <td><label class="toggle"><input type="checkbox" name="muse_add1" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_add1" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>추가항목3</td>
              <td><label class="toggle"><input type="checkbox" name="muse_add3" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_add3" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
          </tbody>
        </table>

      </section>
      <section class="col col-md-6 col-xs-12">

        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th style="width:60%;">가입항목</th>
              <th style="width:20%;">사용</th>
              <th style="width:20%;">필수</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>이메일</td>
              <td><label class="toggle"><input type="checkbox" name="muse_email" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_email" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>성별</td>
              <td><label class="toggle"><input type="checkbox" name="muse_sex" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_sex" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>전화번호</td>
              <td><label class="toggle"><input type="checkbox" name="muse_tel" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_tel" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>주소</td>
              <td><label class="toggle"><input type="checkbox" name="muse_addr" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_addr" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>회사명</td>
              <td><label class="toggle"><input type="checkbox" name="muse_cname" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_cname" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>종목</td>
              <td><label class="toggle"><input type="checkbox" name="muse_citem" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_citem" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>SMS 수신</td>
              <td><label class="toggle"><input type="checkbox" name="muse_sms_yn" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_sms_yn" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>결혼기념일</td>
              <td><label class="toggle"><input type="checkbox" name="muse_merri_date" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_merri_date" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>관심분야</td>
              <td><label class="toggle"><input type="checkbox" name="muse_interest" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_interest" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>추가항목2</td>
              <td><label class="toggle"><input type="checkbox" name="muse_add2" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_add2" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
            <tr>
              <td>추가항목4</td>
              <td><label class="toggle"><input type="checkbox" name="muse_add4" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
              <td><label class="toggle"><input type="checkbox" name="mreq_add4" value="1"><i data-swchon-text="ON" data-swchoff-text="OFF" style="top:-2px;"></i></label></td>
            </tr>
          </tbody>
        </table>

      </section>
    </div>


  </fieldset>

  <header>
    회원가입 추가항목
    <p class="note">회원가입 추가항목명을 변경할 수 있습니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2">추가항목1</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="muse_field1" data-parsley-maxlength="30" value="<%=MUSE_FIELD1%>">
        </label>
      </section>
      <label class="label col col-md-2">추가항목2</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="muse_field2" data-parsley-maxlength="30" value="<%=MUSE_FIELD2%>">
        </label>
      </section>
      <label class="label col col-md-2">추가항목3</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="muse_field3" data-parsley-maxlength="30" value="<%=MUSE_FIELD3%>">
        </label>
      </section>
      <label class="label col col-md-2">추가항목4</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="muse_field4" data-parsley-maxlength="30" value="<%=MUSE_FIELD4%>">
        </label>
      </section>
    </div>
  </fieldset>

  <footer>
    <button type="submit" class="btn btn-primary">
      <i class="fa fa-pencil fa-lg"></i> 저장
    </button>
  </footer>
</form>

        </div>
      </div>

    </div>
  </div>
</div>

<script type="text/javascript">
  runParsley();

  function runParsley(){
    $('input[name=mc_confirm]:input[value="<%=MC_CONFIRM%>"]').attr("checked", true);
    $('input[name=mc_group]:input[value="<%=MC_GROUP%>"]').attr("checked", true);

    $('input[name=muse_nickname]:input[value="<%=MUSE_NICKNAME%>"]').attr("checked", true);
    $('input[name=mreq_nickname]:input[value="<%=MREQ_NICKNAME%>"]').attr("checked", true);

    $('input[name=muse_jumin]:input[value="<%=MUSE_JUMIN%>"]').attr("checked", true);
    $('input[name=mreq_jumin]:input[value="<%=MREQ_JUMIN%>"]').attr("checked", true);
    $('input[name=muse_sex]:input[value="<%=MUSE_SEX%>"]').attr("checked", true);
    $('input[name=mreq_sex]:input[value="<%=MREQ_SEX%>"]').attr("checked", true);
    $('input[name=muse_birth]:input[value="<%=MUSE_BIRTH%>"]').attr("checked", true);
    $('input[name=mreq_birth]:input[value="<%=MREQ_BIRTH%>"]').attr("checked", true);
    $('input[name=muse_calendar]:input[value="<%=MUSE_CALENDAR%>"]').attr("checked", true);
    $('input[name=mreq_calendar]:input[value="<%=MREQ_CALENDAR%>"]').attr("checked", true);
    $('input[name=muse_marri_yn]:input[value="<%=MUSE_marri_yn%>"]').attr("checked", true);
    $('input[name=mreq_marri_yn]:input[value="<%=MREQ_marri_yn%>"]').attr("checked", true);
    $('input[name=muse_merri_date]:input[value="<%=MUSE_merri_date%>"]').attr("checked", true);
    $('input[name=mreq_merri_date]:input[value="<%=MREQ_merri_date%>"]').attr("checked", true);
    $('input[name=muse_hp]:input[value="<%=MUSE_hp%>"]').attr("checked", true);
    $('input[name=mreq_hp]:input[value="<%=MREQ_hp%>"]').attr("checked", true);
    $('input[name=muse_tel]:input[value="<%=MUSE_tel%>"]').attr("checked", true);
    $('input[name=mreq_tel]:input[value="<%=MREQ_tel%>"]').attr("checked", true);
    $('input[name=muse_fax]:input[value="<%=MUSE_fax%>"]').attr("checked", true);
    $('input[name=mreq_fax]:input[value="<%=MREQ_fax%>"]').attr("checked", true);
    $('input[name=muse_email]:input[value="<%=MUSE_email%>"]').attr("checked", true);
    $('input[name=mreq_email]:input[value="<%=MREQ_email%>"]').attr("checked", true);
    $('input[name=muse_cno]:input[value="<%=MUSE_cno%>"]').attr("checked", true);
    $('input[name=mreq_cno]:input[value="<%=MREQ_cno%>"]').attr("checked", true);
    $('input[name=muse_cname]:input[value="<%=MUSE_cname%>"]').attr("checked", true);
    $('input[name=mreq_cname]:input[value="<%=MREQ_cname%>"]').attr("checked", true);
    $('input[name=muse_cservice]:input[value="<%=MUSE_cservice%>"]').attr("checked", true);
    $('input[name=mreq_cservice]:input[value="<%=MREQ_cservice%>"]').attr("checked", true);
    $('input[name=muse_citem]:input[value="<%=MUSE_citem%>"]').attr("checked", true);
    $('input[name=mreq_citem]:input[value="<%=MREQ_citem%>"]').attr("checked", true);
    $('input[name=muse_addr]:input[value="<%=MUSE_addr%>"]').attr("checked", true);
    $('input[name=mreq_addr]:input[value="<%=MREQ_addr%>"]').attr("checked", true);
    $('input[name=muse_job]:input[value="<%=MUSE_job%>"]').attr("checked", true);
    $('input[name=mreq_job]:input[value="<%=MREQ_job%>"]').attr("checked", true);
    $('input[name=muse_interest]:input[value="<%=MUSE_interest%>"]').attr("checked", true);
    $('input[name=mreq_interest]:input[value="<%=MREQ_interest%>"]').attr("checked", true);
    $('input[name=muse_sms_yn]:input[value="<%=MUSE_sms_yn%>"]').attr("checked", true);
    $('input[name=mreq_sms_yn]:input[value="<%=MREQ_sms_yn%>"]').attr("checked", true);
    $('input[name=muse_email_yn]:input[value="<%=MUSE_email_yn%>"]').attr("checked", true);
    $('input[name=mreq_email_yn]:input[value="<%=MREQ_email_yn%>"]').attr("checked", true);
    $('input[name=muse_add1]:input[value="<%=MUSE_add1%>"]').attr("checked", true);
    $('input[name=mreq_add1]:input[value="<%=MREQ_add1%>"]').attr("checked", true);
    $('input[name=muse_add2]:input[value="<%=MUSE_add2%>"]').attr("checked", true);
    $('input[name=mreq_add2]:input[value="<%=MREQ_add2%>"]').attr("checked", true);
    $('input[name=muse_add3]:input[value="<%=MUSE_add3%>"]').attr("checked", true);
    $('input[name=mreq_add3]:input[value="<%=MREQ_add3%>"]').attr("checked", true);
    $('input[name=muse_add4]:input[value="<%=MUSE_add4%>"]').attr("checked", true);
    $('input[name=mreq_add5]:input[value="<%=MREQ_add4%>"]').attr("checked", true);

    $("#memberform").parsley();
  }

</script>
