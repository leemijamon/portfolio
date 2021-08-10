<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   CS_CODE = Trim(Request("cs_code"))
   MAIL_CODE = Trim(Request("mail_code"))

   MAIL_METHOD = "register"

   If MAIL_CODE <> "" Then
      M_ITEM = MAIL_CODE
      SKIN = CS_CODE

      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      file_path = Server.MapPath("/skin") & "\" & SKIN & "\mail\" & M_ITEM & ".html"

      If FileControl.FileExists(file_path) Then
         MAIL_CONT = FileControl.ReadFile(file_path, "UTF-8")
      Else
         file_path = Server.MapPath("/exec") & "\mail\" & M_ITEM & ".html"

         MAIL_CONT = FileControl.ReadFile(file_path, "UTF-8")
      End If

      Set FileControl = Nothing

      MAIL_METHOD = "modify"
   End If
%>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-edit"></i> 메일폼 관리</div>
        <div class="panel-body no-padding">

        <form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
        <input type="hidden" name="action" value="skin.mail">
        <input type="hidden" name="cs_code" value="<%=CS_CODE%>">
        <input type="hidden" name="method" value="<%=MAIL_METHOD%>">
        <input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

          <header>
            메일폼 관리
            <p class="note">메일폼 디자인을 등록/수정 할수 있습니다.</p>
          </header>

          <fieldset>
            <table class="table table-bordered table-striped">
              <colgroup>
                <col class="col-md-2 col-sm-4 col-xs-4">
                <col class="col-md-10 col-sm-8 col-xs-8">
              </colgroup>
              <tbody>
<% If MAIL_METHOD = "register" Then %>
                <tr>
                  <td>메일폼 파일 위치</td>
                  <td class="left"><%=skin_path%>/mail/파일명.html</td>
                </tr>
                <tr>
                  <td>메일폼 파일명</td>
                  <td class="left">
                    <label class="input col-md-3 col-xs-12">
                      <input type="text" name="mail_code" data-parsley-maxlength="30" data-parsley-required value="<%=MAIL_CODE%>">
                    </label>
                  </td>
                </tr>
<% Else %>
                <tr>
                  <td>메일폼 파일</td>
                  <td class="left"><input type="hidden" name="mail_code" value="<%=MAIL_CODE%>"> <%=skin_path%>/mail/<%=MAIL_CODE%>.html</td>
                </tr>
<% End If %>
              </tbody>
            </table>

            <section style="margin-top:10px;">
              <label class="textarea">
                <textarea rows="35" name="mail_cont" class="resizable"><%=MAIL_CONT%></textarea>
              </label>
            </section>
          </fieldset>

          <footer>
            <button type="submit" class="btn btn-primary">
              <i class="fa fa-pencil fa-lg"></i> 저장
            </button>
          </footer>
        </form>
        </div>
      </div>

<script type="text/javascript">
  $('textarea.resizable:not(.processed)').TextAreaResizer();
  $("#editform").parsley();
</script>
