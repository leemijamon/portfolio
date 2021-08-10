<%
   CC_TYPE = "default"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   CS_NAME = f_arr_value(CC_KEY, CC_VALUE, "CS_NAME")
   CS_URL = f_arr_value(CC_KEY, CC_VALUE, "CS_URL")

   CB_NAME = f_arr_value(CC_KEY, CC_VALUE, "CB_NAME")
   CB_CORPNUM = f_arr_value(CC_KEY, CC_VALUE, "CB_CORPNUM")
   CB_MALLNUM = f_arr_value(CC_KEY, CC_VALUE, "CB_MALLNUM")
   CB_CEO = f_arr_value(CC_KEY, CC_VALUE, "CB_CEO")
   CB_ADDR = f_arr_value(CC_KEY, CC_VALUE, "CB_ADDR")
   CB_ITEM = f_arr_value(CC_KEY, CC_VALUE, "CB_ITEM")
   CB_SERVICE = f_arr_value(CC_KEY, CC_VALUE, "CB_SERVICE")
   CB_TEL = f_arr_value(CC_KEY, CC_VALUE, "CB_TEL")
   CB_FAX = f_arr_value(CC_KEY, CC_VALUE, "CB_FAX")

   CM_NAME = f_arr_value(CC_KEY, CC_VALUE, "CM_NAME")
   CM_EMAIL = f_arr_value(CC_KEY, CC_VALUE, "CM_EMAIL")

   MAP_CODE1 = f_arr_value(CC_KEY, CC_VALUE, "MAP_CODE1")
   MAP_CODE2 = f_arr_value(CC_KEY, CC_VALUE, "MAP_CODE2")

   If CS_URL = "" Then CS_URL = Request.Servervariables("SERVER_NAME")
%>
            <form id="defaultform" target="sframe" method="post" class="form" data-parsley-validate>
            <input type="hidden" name="action" value="conf">
            <input type="hidden" name="rtnurl" value="conf/site">
            <input type="hidden" name="cc_type" value="<%=CC_TYPE%>">
              <header>
                기본정보사이트
                <p class="note">사이트 기본정보를 입력해주세요.</p>
              </header>

              <fieldset>
                <div class="row">
                  <label class="label col col-md-2">사이트이름</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="cs_name" data-parsley-maxlength="15" required value="<%=CS_NAME%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">사이트 URL</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="url" name="cs_url" data-parsley-maxlength="50" required value="<%=CS_URL%>">
                    </label>
                  </section>
                </div>
              </fieldset>

              <header>
                회사정보
                <p class="note">사이트 화면하단의 카피라이트 부분에 표시됩니다.</p>
              </header>

              <fieldset>
                <div class="row">
                  <label class="label col col-md-2">상호명</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="cb_name" data-parsley-maxlength="15" required value="<%=CB_NAME%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">대표자명</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="cb_ceo" data-parsley-maxlength="10" required value="<%=CB_CEO%>">
                    </label>
                  </section>
                </div>

                <div class="row">
                  <label class="label col col-md-2">사업자번호</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="cb_corpnum" data-parsley-maxlength="15" value="<%=CB_CORPNUM%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">통신판매신고번호</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="cb_mallnum" data-parsley-maxlength="20" value="<%=CB_MALLNUM%>">
                    </label>
                  </section>
                </div>

                <div class="row">
                  <label class="label col col-md-2">전화번호</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="tel" name="cb_tel" data-parsley-maxlength="15" data-parsley-pattern="^\d{2,3}-\d{3,4}-\d{4}" required value="<%=CB_TEL%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">팩스번호</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="tel" name="cb_fax" data-parsley-maxlength="15" data-parsley-pattern="^\d{2,3}-\d{3,4}-\d{4}" value="<%=CB_FAX%>">
                    </label>
                  </section>
                </div>

                <div class="row">
                  <label class="label col col-md-2">업태</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="cb_service" data-parsley-maxlength="25" value="<%=CB_SERVICE%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">종목</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="cb_item" data-parsley-maxlength="20" value="<%=CB_ITEM%>">
                    </label>
                  </section>
                </div>

                <div class="row">
                  <label class="label col col-md-2">사업장 주소</label>
                  <section class="col col-md-10">
                    <label class="input">
                      <input type="text" name="cb_addr" data-parsley-maxlength="100" required value="<%=CB_ADDR%>">
                    </label>
                  </section>
                </div>
              </fieldset>

              <header>
                개인정보책임자(관리자)
                <p class="note">사이트 관리자 정보를 입력해주세요.</p>
              </header>

              <fieldset>
                <div class="row">
                  <label class="label col col-md-2">관리자명</label>
                  <section class="col col-md-4">
                    <label class="input"> <i class="icon-append fa fa-user"></i>
                      <input type="text" name="cm_name" data-parsley-maxlength="50" required value="<%=CM_NAME%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">관리자 Email</label>
                  <section class="col col-md-4">
                    <label class="input"> <i class="icon-append fa fa-envelope-o"></i>
                      <input type="email" name="cm_email" data-parsley-maxlength="50" required value="<%=CM_EMAIL%>">
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
