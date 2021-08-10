<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   WHERE = Trim(Request.Form("where"))

   If WHERE <> "" Then
      SQL = "SELECT COUNT(*) AS SMS_CNT FROM " & MEM_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      SMS_CNT = Rs("SMS_CNT")
      Rs.close
   Else
      SQL = "SELECT COUNT(*) AS SMS_CNT FROM " & MEM_LST_Table & " WHERE MEM_HP <> '' AND MEM_HP IS NOT NULL AND MEM_SMS_YN='1' AND MEM_STATE < '90'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      SMS_CNT = Rs("SMS_CNT")
      Rs.close

      SQL = "SELECT MEM_LEVEL, COUNT(*) FROM " & MEM_LST_Table & " WHERE MEM_HP <> '' AND MEM_HP IS NOT NULL AND MEM_SMS_YN='1' AND MEM_STATE < '90' GROUP BY MEM_LEVEL ORDER BY MEM_LEVEL"
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      If Rs.BOF = false AND Rs.EOF = false Then
         SMS_CNT_ROWS = Rs.GetRows
      End If
      Rs.close
   End If

   Conn.Close
   Set Conn = nothing

   'SMS 잔여량 구함
   SmsCount = Sms_Count(SMS_ID,SMS_PWD)
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>[ <%=CS_NAME%> Admin Version 2.0]</title>

<link href="/exec/css/bootstrap.min.css" rel="stylesheet">
<link href="/exec/css/font-awesome.min.css" rel="stylesheet">
<link href="/admin/css/admin.css" rel="stylesheet">

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/jquery-ui.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>
<script src="/exec/js/jquery.validate.min.js"></script>
<script src="/exec/js/messages_ko.js"></script>
<script src="/admin/js/admin.js"></script>
</head>

<body style="background:#f1f1f1;">
<div id="wrapper">

  <link rel="stylesheet" href="/exec/ezeditor/css/editor.css" type="text/css" charset="utf-8"/>
  <script src="/exec/ezeditor/js/editor_loader.js"></script>

  <div class="panel panel-default">
    <div class="panel-heading"><i class="fa fa-table"></i> SMS보내기</div>
    <div class="panel-body no-padding">
      <div class="panel-body-toolbar">
      </div>

        <form id="w_form" name="w_form" target="sendsmsframe" method="post" action=".." class="form">
        <input type="hidden" name="action" value="member.send.sms">
        <input type="hidden" name="sms_cnt" value="<%=SmsCount%>">
        <input type="hidden" name="send_cnt" value="<%=SMS_CNT%>">
        <input type="hidden" name="where" value="<%=WHERE%>">

          <header>
            SMS보내기
            <p class="note">SMS 문자메세지를 통해 이벤트, 공지등을 효과적으로 알리세요.</p>
          </header>

          <fieldset>
            <div class="row">
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 잔여건수</label>
              <section class="col col-sm-4">
                <label class="input">
                  <input type="text" name="sms_cnt_view" value="<%=FormatNumber(SmsCount,0)%>" readonly>
                </label>
              </section>
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 보내는사람</label>
              <section class="col col-sm-4">
                <label class="input">
                  <input type="text" name="s_from" value="<%=SMS_SITE_TEL%>">
                </label>
              </section>
            </div>

            <div class="row">
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 받는사람</label>
              <section class="col col-sm-4">
<% If WHERE <> "" Then %>
                <label class="radio">
                  <input type="radio" name="mem_level" value="00" onclick="incnt(<%=SMS_CNT%>);"><i></i><font color="262626">검색회원</font> (<%=FormatNumber(SMS_CNT,0)%>명)
                </label>
<% Else %>
                <label class="radio">
                  <input type="radio" name="mem_level" value="00" onclick="incnt(<%=SMS_CNT%>);"><i></i><font color="262626">전체회원</font> (<%=FormatNumber(SMS_CNT,0)%>명)
                </label>
<%
      If IsArray(SMS_CNT_ROWS) Then
         For k = 0 To UBound(SMS_CNT_ROWS, 2)
            MEM_LEVEL = SMS_CNT_ROWS(0,k)
            MEM_CNT = SMS_CNT_ROWS(1,k)

            MEM_LEVEL_TXT = f_arr_value(MEM_LEVEL_CD, MEM_LEVEL_NAME, Cstr(MEM_LEVEL))

            response.write "        <label class='radio'>" & vbNewLine
            response.write "          <input type='radio' name='mem_level' value='" & MEM_LEVEL & "' onclick='incnt(" & MEM_CNT & ");'><i></i><font color='262626'>" & MEM_LEVEL_TXT & "</font> (" & FormatNumber(MEM_CNT,0) & "명)" & vbNewLine
            response.write "        </label>" & vbNewLine
         Next
      End If
%>
                <label class="radio">
                  <input type="radio" name="mem_level" value="99" onclick="incnt(1);" checked><i></i><font color="262626">테스트발송</font>
                </label>
<% End If %>
              </section>
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> 테스트발송</label>
              <section class="col col-sm-4">
                <label class="input">
                  <input type="text" name="sms_test" value="<%=SMS_ADMIN_HP%>">
                </label>
              </section>
            </div>

            <div class="row">
              <label class="label col col-sm-2"><i class="fa fa-check color-red"></i> SMS내용</label>
              <section class="col col-sm-10">
                <label class="textarea">
                  <textarea rows="7" name="s_cont" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)'></textarea>
                </label>
                <p class="note">{{회원명}}, {{아이디}} 변환코드 사용이 가능합니다.</p>

                <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='s_len'>0</span></strong> / 80 bytes</div>
              </section>
            </div>
          </fieldset>

          <footer>
            <button type="submit" class="btn btn-primary">
              <i class="fa fa-paper-plane"></i>&nbsp; 보내기
            </button>
          </footer>
        </form>

      </div>
    </div>
  </div>

<script language="javascript">
<!--
  $(function() {
    //$("select[name='c_type']").val("<%=C_TYPE%>");
    $('select[name=c_type]').find('option[value="<%=C_TYPE%>"]').prop('selected', true);

    $.validator.addMethod("hpnumber", function(value, element) {
      return this.optional(element) || /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/.test(value);
    });

    $.validator.addMethod("telnumber", function(value, element) {
      return this.optional(element) || /^\d{2,3}-\d{3,4}-\d{4}$/.test(value);
    });

    $("#w_form").validate({
      rules:{
        s_from:{required:false,telnumber:true,maxlength:15}
        ,sms_test:{required:true,hpnumber:true,maxlength:15}
        ,s_cont:{required:true,maxlength:80}
      },
      messages:{
        s_from:{
          required:"전화번호를 입력해 주세요.",
          telnumber:"전화번호 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,sms_test:{
          required:"휴대전화 번호를 입력해 주세요.",
          hpnumber:"휴대전화 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,s_cont:{
          required:"내용을 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
      },
      errorPlacement: function(error, element) {
        error.insertAfter(element);
        parent.resize();
      },
      submitHandler:function(form){
        var msg = "발송 하시겠습니까?"
        if(confirm(msg)){
          form.submit();
        }else{
          return;
        }
      }
    });
  });

  function CalByte(obj){
    var curText;
    var strLen;
    var byteIs;
    var lastByte;
    var thisChar;
    var escChar;
    var curTotalMsg;
    var okMsg;

    curText = new String(obj.value);
    strLen = curText.length;
    byteIs = 0;

    for(i=0; i<strLen; i++) {
      thisChar = curText.charAt(i);
      escChar = escape(thisChar);

      // ´,¨, ¸ : 2byte 임에도 브라우져에서 1byte로 계산
      if(thisChar == "´" || thisChar == "¨" || thisChar == "¸" || thisChar == "§" ){
        byteIs++;
      }

      if (escChar.length > 4) {
        byteIs += 2;  //특수문자 한글인 경우.
      }else if(thisChar != '\r') {  //개행을 제외한 이외의 경우
        byteIs += 1;
      }

      if(byteIs > 80){ // 3페이지까지
        alert('[안 내] 80byte를 초과하실 수 없습니다.');
        thisText = curText.substring(0, i);
        obj.value = thisText;
        byteIs = lastByte;
        break;
      }

      lastByte = byteIs;
    }

    document.getElementById("s_len").innerHTML = byteIs;
  }
-->
</script>

</div>
<!-- /#wrapper -->

<div style="display:none"><iframe name='sendsmsframe' style="width:0px;height:0px;"></iframe></div>

</body>
</html>