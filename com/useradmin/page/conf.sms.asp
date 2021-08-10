<%
   CC_TYPE = "sms"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   SMS_ID = f_arr_value(CC_KEY, CC_VALUE, "SMS_ID")
   SMS_PWD = f_arr_value(CC_KEY, CC_VALUE, "SMS_PWD")

   SMS_SITE_TEL = f_arr_value(CC_KEY, CC_VALUE, "SMS_SITE_TEL")
   SMS_ADMIN_HP = f_arr_value(CC_KEY, CC_VALUE, "SMS_ADMIN_HP")
   SMS_MA_HP = f_arr_value(CC_KEY, CC_VALUE, "SMS_MA_HP")

   'SMS 잔여량 구함
   SmsCount = Sms_Count(SMS_ID,SMS_PWD)
%>
            <form id="smsform" target="sframe" method="post" class="form" data-parsley-validate>
            <input type="hidden" name="action" value="conf">
            <input type="hidden" name="rtnurl" value="conf/send">
            <input type="hidden" name="cc_type" value="<%=CC_TYPE%>">
              <header>
                SMS정보
                <p class="note">SMS정보 및 관리자정보를 입력하세요. 잔여건수 : <%=SmsCount%>건</p>
              </header>

              <fieldset>
                <div class="row">
                  <label class="label col col-md-2">SMS 아이디</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="sms_id" data-parsley-maxlength="15" data-parsley-type="alphanum" value="<%=SMS_ID%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">SMS 비밀번호</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="sms_pwd" data-parsley-maxlength="15" value="<%=SMS_PWD%>">
                    </label>
                  </section>
                </div>
                <div class="row">
                  <label class="label col col-md-2">회신전화번호</label>
                  <section class="col col-md-4">
                    <label class="input"> <i class="icon-append fa fa-phone"></i>
                      <input type="tel" name="sms_site_tel" data-parsley-maxlength="15" data-parsley-pattern="^\d{2,3}-\d{3,4}-\d{4}" value="<%=SMS_SITE_TEL%>">
                    </label>
                  </section>
                </div>
              </fieldset>

              <header>
                관리자 SMS정보
                <p class="note">관리자에게 메시지 통보시 필요한 관리자 휴대폰 정보를 입력하세요.</p>
              </header>

              <fieldset>
                <div class="row">
                  <label class="label col col-md-2">관리자 핸드폰</label>
                  <section class="col col-md-4">
                    <label class="input"> <i class="icon-append fa fa-phone"></i>
                      <input type="tel" name="sms_admin_hp" data-parsley-maxlength="15" data-parsley-pattern="^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})" value="<%=SMS_ADMIN_HP%>">
                    </label>
                  </section>
                </div>
                <div class="row">
                  <label class="label col col-md-2">추가 관리자</label>
                  <section class="col col-md-4">
                    <label class="input"> <i class="icon-append fa fa-phone"></i>
                      <input type="tel" name="sms_ma_hp" data-parsley-maxlength="15" data-parsley-pattern="^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})" value="<%=SMS_MA_HP%>">
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
