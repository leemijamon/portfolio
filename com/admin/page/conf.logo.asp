<%
   CC_TYPE = "logo"
   WHERE = "CC_TYPE='" & CC_TYPE & "'"

   SQL = "SELECT CC_KEY,CC_VALUE FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CC_KEY = Rs("CC_KEY")
      CC_VALUE = Rs("CC_VALUE")
   End If
   Rs.close

   LOGO1_FILE = f_arr_value(CC_KEY, CC_VALUE, "LOGO1_FILE")
   LOGO2_FILE = f_arr_value(CC_KEY, CC_VALUE, "LOGO2_FILE")

   TOPLOGO = f_arr_value(CC_KEY, CC_VALUE, "TOPLOGO")
   BOTTOMLOGO = f_arr_value(CC_KEY, CC_VALUE, "BOTTOMLOGO")
%>
<form id="logoform" target="sframe" method="post" action="exec/conf.logo.asp" enctype="multipart/form-data" class="form" data-parsley-validate>
<input type="hidden" name="rtnurl" value="conf/site">
<input type="hidden" name="cc_type" value="<%=CC_TYPE%>">
  <header>
    로고설정
    <p class="note">사이트의 로고를 관리 하실 수 있습니다.</p>
  </header>

  <fieldset>
    <div class="row">
      <label class="label col col-md-2">상단로고</label>
      <section class="col col-md-10">
        <span id="logo1_img"><%=TOPLOGO%></span>
        <label for="file" class="input input-file">
          <div class="button"><input type="file" name="file1" onchange="this.parentNode.nextSibling.value=this.value.replace('C:\\fakepath\\', '');">Browse</div><input type="text" name="logo1_file" value="<%=LOGO1_FILE%>" readonly>
        </label>
      </section>
    </div>
    <div class="row">
      <label class="label col col-md-2">하단로고</label>
      <section class="col col-md-10">
        <span id="logo2_img"><%=BOTTOMLOGO%></span>
        <label for="file" class="input input-file">
          <div class="button"><input type="file" name="file2" onchange="this.parentNode.nextSibling.value=this.value.replace('C:\\fakepath\\', '');">Browse</div><input type="text" name="logo2_file" value="<%=LOGO2_FILE%>" readonly>
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
