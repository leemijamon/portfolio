<%
   CC_TYPE = "webmastertools"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   GOOGLE_META = f_arr_value(CC_KEY, CC_VALUE, "GOOGLE_META")
   NAVER_META = f_arr_value(CC_KEY, CC_VALUE, "NAVER_META")
   NAVER_TOKEN = f_arr_value(CC_KEY, CC_VALUE, "NAVER_TOKEN")
%>
<form id="toolsform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="conf">
<input type="hidden" name="rtnurl" value="conf/site">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">
  <header>
    검색엔진 연동
    <p class="note">검색엔진 연결시 메타테그 및 연동키를 입력합니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-12">google-site-verification</label>
      <section class="col col-md-12">
        <label class="input">
          <input type="text" name="google_meta" data-parsley-maxlength="100" value="<%=GOOGLE_META%>">
        </label>
      </section>
      <label class="label col col-md-12">naver-site-verification</label>
      <section class="col col-md-12">
        <label class="input">
          <input type="text" name="naver_meta" data-parsley-maxlength="100" value="<%=NAVER_META%>">
        </label>
      </section>
      <label class="label col col-md-12">naver 신디케이션 연동키(token)</label>
      <section class="col col-md-12">
        <label class="input">
          <input type="text" name="naver_token" data-parsley-maxlength="100" value="<%=NAVER_TOKEN%>">
        </label>
      </section>
    </div>

    <div class="alert alert-info">
      <b>구글</b><br>
      <p class="note txt-color-blueDark">
      1. google-site-verification는 웹마스터도구에 사이트 등록시 메타테그 방식으로 등록할때 입력하여 사용합니다.<br>
      2. 구글 sitemap에 /sitemap.xml을 제출하실 수 있으며 sitemap 제출시 구글 크롤링에 도움이 됩니다.
      </p>
    </div>
    <div class="alert alert-info">
      <b>네이버</b><br>
      <p class="note txt-color-blueDark">
      1. naver-site-verification는 웹마스터도구에 사이트 등록시 메타테그 방식으로 등록할때 입력하여 사용합니다.<br>
      2. 신디케이션이란 실시간으로 검색엔진에 등록하는 기능입니다. 검색엔진에 빠르게 노출 또는 제거 처리에 이용됩니다.<br>
      &nbsp;&nbsp;&nbsp; 사이트의 컨텐츠 및 게시판 컨텐츠가 연동되어 네이버 검색엔진으로 전송됩니다.
      </p>
    </div>
  </fieldset>

  <footer>
    <button type="submit" class="btn btn-primary">
      <i class="fa fa-pencil fa-lg"></i> 저장
    </button>
  </footer>
</form>
