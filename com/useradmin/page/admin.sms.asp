<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<form id="sendsms" name="sendsms" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="admin.sms">
<input type="hidden" name="adm_seq" value="<%=Session("ADM_SEQ")%>">
<input type="hidden" id="r_key" name="r_key" value="rnumber">

<fieldset>
  <label class="textarea">
    <textarea rows="5" name="msg" data-parsley-maxlength="80" onkeydown='CalByte(this)' onchange='CalByte(this)' onkeyup='CalByte(this)' required><%=SMS_CONSULT_ADM%></textarea>
  </label>
  <div style="text-align:right; font-size:11px; font-family: 돋움;"><strong><span id='msglen'>0</span></strong> / 80 bytes</div>

  <section>
    <label class="label">받는번호</label>
    <label class="input"> <i class="icon-append fa fa-phone"></i>
      <input name="rnumber" id="rnumber" type="text" data-parsley-maxlength="15" parsley-type="phone" value="<%=request("hp")%>" required>
    </label>
  </section>

  <section>
    <label class="label">보내는번호</label>
    <label class="input"> <i class="icon-append fa fa-phone"></i>
      <input name="cbnumber" id="cbnumber" type="text" data-parsley-maxlength="15" parsley-type="phone" value="<%=SMS_SITE_TEL%>" required>
    </label>
  </section>
</fieldset>
<footer>
  <button type="submit" class="btn btn-primary" onclick="form_check();">
    <i class="fa fa-pencil fa-lg"></i> 전송
  </button>
  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
</footer>
</form>

<script language="javascript">
<!--
  runSms();

  function runSms(){
    $('#sendsms').parsley();
    CalByte(document.sendsms.msg);
  }

  function CalByte(tg){
    var curText;
    var strLen;
    var byteIs;
    var lastByte;
    var thisChar;
    var escChar;
    var curTotalMsg;
    var okMsg;

    curText = new String(tg.value);
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
        tg.value = thisText;
        byteIs = lastByte;
        break;
      }

      lastByte = byteIs;
    }

    document.getElementById("msglen").innerHTML = byteIs;
  }
-->
</script>
