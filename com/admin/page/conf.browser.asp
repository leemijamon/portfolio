<%
   CC_TYPE = "browser"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   SITE_TITLE = f_arr_value(CC_KEY, CC_VALUE, "SITE_TITLE")
   SITE_KEYWORDS = f_arr_value(CC_KEY, CC_VALUE, "SITE_KEYWORDS")
   SITE_DESCRIPTION = f_arr_value(CC_KEY, CC_VALUE, "SITE_DESCRIPTION")
%>
<form id="browserform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf">
<input type="hidden" name="rtnurl" value="conf/site">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">
  <header>
    브라우저타이틀정보
    <p class="note">사이트의 브라우저 타이틀, 메타테그를 관리 하실 수 있습니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2">브라우저 타이틀</label>
      <section class="col col-md-10">
        <label class="input">
          <input type="text" name="site_title" data-parsley-maxlength="100" data-parsley-required value="<%=SITE_TITLE%>">
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-md-2">메타테그 키워드</label>
      <section class="col col-md-10">
        <label class="input">
		  <input type ="text" name="site_keywords"  value="<%=SITE_KEYWORDS%>">
          <!--<textarea rows="4" name="site_keywords"><%=SITE_KEYWORDS%></textarea>-->
        </label>
      </section>
    </div>

    <div class="row">
      <label class="label col col-md-2">메타테그 설명</label>
      <section class="col col-md-10">
        <label class="input">
		  <input type ="text" name="site_description"  value="<%=SITE_DESCRIPTION%>">
          <!--<textarea rows="4" name="site_description"><%=SITE_DESCRIPTION%></textarea>-->
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
