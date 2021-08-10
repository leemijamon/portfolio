<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   CS_CODE = Trim(Request("cs_code"))
   CSS_CODE = Trim(Request("css_code"))

   CSS_METHOD = "register"

   skin_path = "/skin/" & CS_CODE
   skin_mappath = Server.MapPath(skin_path)

   If CSS_CODE <> "" Then
      css_file_path = skin_mappath & "\css\" & CSS_CODE & ".css"
      'response.write css_file_path

      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      CSS_CONT = FileControl.ReadFile(css_file_path, "UTF-8")

      Set FileControl = Nothing

      CSS_METHOD = "modify"
   End If
%>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-edit"></i> CSS 관리</div>
        <div class="panel-body no-padding">

        <form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
        <input type="hidden" name="action" value="skin.css">
        <input type="hidden" name="cs_code" value="<%=CS_CODE%>">
        <input type="hidden" name="method" value="<%=CSS_METHOD%>">
        <input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

          <header>
            CSS 관리
            <p class="note">CSS 파일을 등록/수정 할수 있습니다.</p>
          </header>

          <fieldset>
            <table class="table table-bordered table-striped">
              <colgroup>
                <col class="col-md-2 col-sm-4 col-xs-4">
                <col class="col-md-10 col-sm-8 col-xs-8">
              </colgroup>
              <tbody>
<% If CSS_METHOD = "register" Then %>
                <tr>
                  <td>CSS 파일 위치</td>
                  <td class="left"><%=skin_path%>/css/파일명.css</td>
                </tr>
                <tr>
                  <td>CSS 파일명</td>
                  <td class="left">
                    <label class="input col-md-3 col-xs-12">
                      <input type="text" name="css_code" data-parsley-maxlength="30" data-parsley-required value="<%=CSS_CODE%>">
                    </label>
                  </td>
                </tr>
<% Else %>
                <tr>
                  <td>CSS 파일</td>
                  <td class="left"><input type="hidden" name="css_code" value="<%=CSS_CODE%>"> <%=skin_path%>/css/<%=CSS_CODE%>.css</td>
                </tr>
<% End If %>
              </tbody>
            </table>

            <section style="margin-top:10px;">
              <label class="textarea">
                <textarea rows="35" name="css_cont" class="resizable"><%=CSS_CONT%></textarea>
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
