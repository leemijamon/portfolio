<%
   CC_TYPE = "ssl"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   SSL_USE = f_arr_value(CC_KEY, CC_VALUE, "SSL_USE")
   SSL_DOMAIN = f_arr_value(CC_KEY, CC_VALUE, "SSL_DOMAIN")
   SSL_PORT = f_arr_value(CC_KEY, CC_VALUE, "SSL_PORT")

   HASH_TYPE = f_arr_value(CC_KEY, CC_VALUE, "HASH_TYPE")

   If SSL_USE = "" Then SSL_USE = "0"
%>
            <form id="sslform" target="sframe" method="post" class="form" data-parsley-validate>
            <input type="hidden" name="action" value="conf">
            <input type="hidden" name="rtnurl" value="conf/site">
            <input type="hidden" name="cc_type" value="<%=CC_TYPE%>">

              <header>
                보안서버 설정
                <p class="note">보안서버(SSL) 설정을 합니다.</p>
              </header>

              <fieldset>

                <div class="row">
                  <label class="label col col-md-2">사용여부</label>
                  <section class="col col-md-10">
                  <div class="inline-group">
                    <label class="radio">
                      <input type="radio" name="ssl_use" value="1">
                      <i></i>사용
                    </label>
                    <label class="radio">
                      <input type="radio" name="ssl_use" value="0">
                      <i></i>미사용
                    </label>
                  </div>
                  </section>
                </div>

                <div class="row">
                  <label class="label col col-md-2">도메인</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="url" name="ssl_domain" data-parsley-maxlength="50" value="<%=SSL_DOMAIN%>">
                    </label>
                  </section>
                  <label class="label col col-md-2">포트</label>
                  <section class="col col-md-4">
                    <label class="input">
                      <input type="text" name="ssl_port" data-parsley-maxlength="10" data-parsley-type="number" value="<%=SSL_PORT%>">
                    </label>
                  </section>
                </div>
              </fieldset>

              <header>
                암호화설정
                <p class="note">비밀번호 암호화 방법을 지정합니다.</p>
              </header>

              <fieldset>
                <div class="row">
                  <label class="label col col-md-2">암호화방법</label>
                  <section class="col col-md-4">
                    <label class="select">
                      <select name="hash_type">
                        <option value="">없음</option>
                        <option value="MD5">MD5</option>
                        <option value="SHA1">SHA1</option>
                        <!--option value="SHA2_256">SHA256</option>
                        <option value="SHA2_512">SHA512</option-->
                        <option value="MySQL4">MySQL4</option>
                        <option value="MySQL5">MySQL5</option>
                      </select><i></i>
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

            <script type="text/javascript">
              $('input[name=ssl_use]:input[value="<%=SSL_USE%>"]').attr("checked", true);
              //$("select[name='hash_type']").val("<%=HASH_TYPE%>");
              $('select[name=hash_type]').find('option[value="<%=HASH_TYPE%>"]').prop('selected', true);
            </script>
