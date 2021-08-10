<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc"-->
<!-- #include virtual = "/conf/member_config.inc"-->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_NAME,MEM_NICKNAME,MEM_ID,MEM_PWD,MEM_LEVEL,MEM_JUMIN,MEM_JUMIN_CK,MEM_SEX,MEM_BIRTH
   Dim MEM_CALENDAR,MEM_MARRI_YN,MEM_MERRI_DATE,MEM_HP,MEM_TEL,MEM_FAX,MEM_EMAIL,MEM_CNO,MEM_CNAME,MEM_CSERVICE
   Dim MEM_CITEM,MEM_ZIPCODE,MEM_ADDR1,MEM_ADDR2,MEM_URL,MEM_JOB,MEM_INTEREST,MEM_SMS_YN,MEM_EMAIL_YN,MEM_LOG_IP
   Dim MEM_LOG_DATE,MEM_LOG_CNT,MEM_RECOMM_ID,MEM_MEMO,MEM_ADD1,MEM_ADD2,MEM_ADD3,MEM_ADD4,MEM_SALE,MEM_MONEY
   Dim MEM_WDATE,MEM_MDATE,MEM_STATE,ARA_CODE

   MEM_SEQ = request("mem_seq")

   If IsNumeric(MEM_SEQ) = false Then response.end

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & MEM_LST_Table & " WHERE MEM_SEQ=" & MEM_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MEM_SEQ = Rs("MEM_SEQ")
      MEM_ID = Rs("MEM_ID")
      MEM_NAME = Rs("MEM_NAME")
      MEM_SECEDE = Rs("MEM_SECEDE")
      MEM_SECEDE_DETAIL = Rs("MEM_SECEDE_DETAIL")
   End If
   Rs.close
%>
<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">회원관리</a>
    </li>
    <li class="active">회원정보</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">회원탈퇴</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 회원탈퇴</div>
        <div class="panel-body no-padding">

<form name="sform" id="sform" target="sframe" method="post" class="form">
<input type="hidden" name="action" value="member.secede">
<input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">

  <header>
    회원탈퇴
    <p class="note">탈퇴한 아이디는 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-sm-2">아이디</label>
      <section class="col col-sm-4">
        <p class="form-control-static"><%=MEM_ID%></p>
      </section>
      <label class="label col col-sm-2">이름</label>
      <section class="col col-sm-4">
        <p class="form-control-static"><%=MEM_NAME%></p>
      </section>
    </div>

    <div class="row">
      <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 탈퇴사유</label>
      <section class="col col-sm-4">
        <label class="select">
          <select name="mem_secede">
            <option value="">탈퇴사유를 선택해주세요</option>
            <option value="">----------------------------</option>
<%=f_arr_opt(MEM_SECEDE_CD,MEM_SECEDE_NAME)%>
          </select><i></i>
        </label>
      </section>
    </div>

    <div class="row">
      <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 남기고 싶은 말</label>
      <section class="col col-sm-10">
        <label class="textarea">
          <textarea name="mem_secede_detail" id="mem_secede_detail" rows="10"></textarea>
        </label>
      </section>
    </div>
  </fieldset>

  <footer class="text-center">
    <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 회원탈퇴</button>
  </footer>
</form>

<script type="text/javascript">
  runParsley();

  function runParsley(){

    $("#sform").validate({
      rules:{
        mem_secede:{required:true}
        ,mem_secede_detail:{required:true,maxlength:200}
      },
      messages:{
        mem_secede:{
          required:"탈퇴사유를 선택 주세요.",
        }
        ,mem_secede_detail:{
          required:"남기고 싶은말을 입력해 주세요.",
          maxlength:jQuery.validator.format("남기고 싶은말은 최대 {0}자 이하로 입력해주세요.")
        }
      },
      errorPlacement: function(error, element) {
        error.insertAfter(element);
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
  }
</script>

        </div>
      </div>

    </div>
  </div>
</div>
