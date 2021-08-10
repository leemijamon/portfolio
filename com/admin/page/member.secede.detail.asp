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
      MEM_SECEDE = Rs("MEM_SECEDE")
      MEM_SECEDE_DETAIL = Rs("MEM_SECEDE_DETAIL")
   End If
   Rs.close
%>
<form name="sform" id="sform" method="post" class="form" role="form">
  <fieldset>
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
          <textarea name="mem_secede_detail" id="mem_secede_detail" rows="10"><%=MEM_SECEDE_DETAIL%></textarea>
        </label>
      </section>
    </div>
  </fieldset>

  <footer class="text-center">
    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
  </footer>
</form>

<script type="text/javascript">
  //$("select[name='mem_secede']").val("<%=MEM_SECEDE%>");
  $('select[name=mem_secede]').find('option[value="<%=MEM_SECEDE%>"]').prop('selected', true);
</script>

