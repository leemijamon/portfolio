<%
   CC_TYPE = "autosms"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   SMS_JOIN = f_arr_value(CC_KEY, CC_VALUE, "SMS_JOIN")
   OnScript = OnScript & "  CalByte(document.autosmsform.sms_join);" & vbNewLine
   SEND_JOIN = f_arr_value(CC_KEY, CC_VALUE, "SEND_JOIN")
   If SEND_JOIN = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_join']"").attr(""checked"", true);" & vbNewLine

   SMS_JOIN_ADM = f_arr_value(CC_KEY, CC_VALUE, "SMS_JOIN_ADM")
   OnScript = OnScript & "  CalByte(document.autosmsform.sms_join_adm);" & vbNewLine
   SEND_JOIN_ADM = f_arr_value(CC_KEY, CC_VALUE, "SEND_JOIN_ADM")
   SEND_JOIN_MA = f_arr_value(CC_KEY, CC_VALUE, "SEND_JOIN_MA")
   If SEND_JOIN_ADM = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_join_adm']"").attr(""checked"", true);" & vbNewLine
   If SEND_JOIN_MA = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_join_ma']"").attr(""checked"", true);" & vbNewLine

   SMS_IDPASS = f_arr_value(CC_KEY, CC_VALUE, "SMS_IDPASS")
   OnScript = OnScript & "  CalByte(document.autosmsform.sms_idpass);" & vbNewLine
   SEND_IDPASS = f_arr_value(CC_KEY, CC_VALUE, "SEND_IDPASS")
   If SEND_IDPASS = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_idpass']"").attr(""checked"", true);" & vbNewLine

   SMS_QUESTION_ADM = f_arr_value(CC_KEY, CC_VALUE, "SMS_QUESTION_ADM")
   OnScript = OnScript & "  CalByte(document.autosmsform.sms_question_adm);" & vbNewLine
   SEND_QUESTION_ADM = f_arr_value(CC_KEY, CC_VALUE, "SEND_QUESTION_ADM")
   SEND_QUESTION_MA = f_arr_value(CC_KEY, CC_VALUE, "SEND_QUESTION_MA")
   If SEND_QUESTION_ADM = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_question_adm']"").attr(""checked"", true);" & vbNewLine
   If SEND_QUESTION_MA = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_question_ma']"").attr(""checked"", true);" & vbNewLine

   SMS_QUESTION_ANSWER = f_arr_value(CC_KEY, CC_VALUE, "SMS_QUESTION_ANSWER")
   OnScript = OnScript & "  CalByte(document.autosmsform.sms_question_answer);" & vbNewLine
   SEND_QUESTION_ANSWER = f_arr_value(CC_KEY, CC_VALUE, "SEND_QUESTION_ANSWER")
   If SEND_QUESTION_ANSWER = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_question_answer']"").attr(""checked"", true);" & vbNewLine

   SMS_CONSULT_ADM = f_arr_value(CC_KEY, CC_VALUE, "SMS_CONSULT_ADM")
   OnScript = OnScript & "  CalByte(document.autosmsform.sms_consult_adm);" & vbNewLine
   SEND_CONSULT_ADM = f_arr_value(CC_KEY, CC_VALUE, "SEND_CONSULT_ADM")
   SEND_CONSULT_MA = f_arr_value(CC_KEY, CC_VALUE, "SEND_CONSULT_MA")
   If SEND_CONSULT_ADM = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_consult_adm']"").attr(""checked"", true);" & vbNewLine
   If SEND_CONSULT_MA = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_consult_ma']"").attr(""checked"", true);" & vbNewLine

   SMS_CONSULT_ANSWER = f_arr_value(CC_KEY, CC_VALUE, "SMS_CONSULT_ANSWER")
   OnScript = OnScript & "  CalByte(document.autosmsform.sms_consult_answer);" & vbNewLine
   SEND_CONSULT_ANSWER = f_arr_value(CC_KEY, CC_VALUE, "SEND_CONSULT_ANSWER")
   If SEND_CONSULT_ANSWER = "1" Then SetScript = SetScript & "   $(""input:checkbox[name='send_consult_answer']"").attr(""checked"", true);" & vbNewLine
%>

<form id="autosmsform" name="autosmsform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf">
<input type="hidden" name="rtnurl" value="conf/send">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">

<div class="row">
  <section class="col col-md-6">
    <header>
      회원가입시 발송
      <p class="note">회원가입시 SMS메시지를 변경할 수 있습니다.</p>
    </header>

    <fieldset>
      <div class="row">
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="sms_join" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_JOIN%></textarea>
          </label>

          <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='smslen_join'>0</span></strong> / 80 bytes</div>

          <label class="checkbox">
            <input type="checkbox" name="send_join" value="1">
            <i></i>고객에게 자동발송
          </label>
        </section>
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="sms_join_adm" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_JOIN_ADM%></textarea>
          </label>
          <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='smslen_join_adm'>0</span></strong> / 80 bytes</div>
          <label class="checkbox">
            <input type="checkbox" name="send_join_adm" value="1">
            <i></i>관리자에게 발송
          </label>
          <label class="checkbox">
            <input type="checkbox" name="send_join_ma" value="1">
            <i></i>추가관리자에게 발송
          </label>
        </section>
      </div>
    </fieldset>
  </section>

  <section class="col col-md-6">
    <header>
      비밀번호찾기시 발송
      <p class="note">비밀번호찾기시 SMS메시지를 변경할 수 있습니다.</p>
    </header>

    <fieldset>
      <div class="row">
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="sms_idpass" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_IDPASS%></textarea>
          </label>

          <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='smslen_idpass'>0</span></strong> / 80 bytes</div>

          <label class="checkbox">
            <input type="checkbox" name="send_idpass" value="1">
            <i></i>고객에게 자동발송
          </label>
        </section>
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="blank" style="background-color: #f5f5f5;" disabled></textarea>
          </label>
        </section>
      </div>
    </fieldset>
  </section>
</div>

<div class="row">
  <section class="col col-md-6">
    <header>
      1:1문의 등록시 발송
      <p class="note">1:1문의 등록시 SMS메시지를 변경할 수 있습니다.</p>
    </header>

    <fieldset>
      <div class="row">
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="blank" style="background-color: #f5f5f5;" disabled></textarea>
          </label>
        </section>
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="sms_question_adm" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_QUESTION_ADM%></textarea>
          </label>
          <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='smslen_question_adm'>0</span></strong> / 80 bytes</div>
          <label class="checkbox">
            <input type="checkbox" name="send_question_adm" value="1">
            <i></i>관리자에게 발송
          </label>
          <label class="checkbox">
            <input type="checkbox" name="send_question_ma" value="1">
            <i></i>추가관리자에게 발송
          </label>
        </section>
      </div>
    </fieldset>
  </section>

  <section class="col col-md-6">
    <header>
      1:1문의 답변시 발송
      <p class="note">1:1문의 답변시 SMS메시지를 변경할 수 있습니다.</p>
    </header>

    <fieldset>
      <div class="row">
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="sms_question_answer" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_QUESTION_ANSWER%></textarea>
          </label>

          <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='smslen_question_answer'>0</span></strong> / 80 bytes</div>

          <label class="checkbox">
            <input type="checkbox" name="send_question_answer" value="1">
            <i></i>고객에게 자동발송
          </label>
        </section>
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="blank" style="background-color: #f5f5f5;" disabled></textarea>
          </label>
        </section>
      </div>
    </fieldset>
  </section>
</div>

<div class="row">
  <section class="col col-md-6">
    <header>
      온라인문의 등록시 발송
      <p class="note">온라인문의 등록시 SMS메시지를 변경할 수 있습니다.</p>
    </header>

    <fieldset>
      <div class="row">
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="blank" style="background-color: #f5f5f5;" disabled></textarea>
          </label>
        </section>
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="sms_consult_adm" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_CONSULT_ADM%></textarea>
          </label>
          <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='smslen_consult_adm'>0</span></strong> / 80 bytes</div>
          <label class="checkbox">
            <input type="checkbox" name="send_consult_adm" value="1">
            <i></i>관리자에게 발송
          </label>
          <label class="checkbox">
            <input type="checkbox" name="send_consult_ma" value="1">
            <i></i>추가관리자에게 발송
          </label>
        </section>
      </div>
    </fieldset>
  </section>

  <section class="col col-md-6">
    <header>
      온라인문의 답변시 발송
      <p class="note">온라인문의 답변시 SMS메시지를 변경할 수 있습니다.</p>
    </header>

    <fieldset>
      <div class="row">
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="sms_consult_answer" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_CONSULT_ANSWER%></textarea>
          </label>

          <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='smslen_consult_answer'>0</span></strong> / 80 bytes</div>

          <label class="checkbox">
            <input type="checkbox" name="send_consult_answer" value="1">
            <i></i>고객에게 자동발송
          </label>
        </section>
        <section class="col col-md-6">
          <label class="textarea">
            <textarea rows="5" name="blank" style="background-color: #f5f5f5;" disabled></textarea>
          </label>
        </section>
      </div>
    </fieldset>
  </section>
</div>

<footer>
  <button type="submit" class="btn btn-primary">
    <i class="fa fa-pencil fa-lg"></i> 저장
  </button>
</footer>
</form>

<script language="javascript">
<!--
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

    var msglen = obj.name.replace('sms_','smslen_');
    document.getElementById(msglen).innerHTML = byteIs;
  }

<%=OnScript%>
<%=SetScript%>
-->
</script>

