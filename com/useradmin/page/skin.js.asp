<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   CS_CODE = Trim(Request("cs_code"))
   JS_CODE = Trim(Request("js_code"))

   JS_METHOD = "register"

   skin_path = "/skin/" & CS_CODE
   skin_mappath = Server.MapPath(skin_path)

   If JS_CODE <> "" Then
      js_file_path = skin_mappath & "\js\" & JS_CODE & ".js"
      'response.write js_file_path

      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      JS_CONT = FileControl.ReadFile(js_file_path, "UTF-8")

      Set FileControl = Nothing

      JS_METHOD = "modify"
   End If
%>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-edit"></i> Script 관리</div>
        <div class="panel-body no-padding">

        <form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
        <input type="hidden" name="action" value="skin.js">
        <input type="hidden" name="cs_code" value="<%=CS_CODE%>">
        <input type="hidden" name="method" value="<%=JS_METHOD%>">
        <input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

          <header>
            Script 관리
            <p class="note">Script 파일을 등록/수정 할수 있습니다.</p>
          </header>

          <fieldset>
            <table class="table table-bordered table-striped">
              <colgroup>
                <col class="col-md-2 col-sm-4 col-xs-4">
                <col class="col-md-10 col-sm-8 col-xs-8">
              </colgroup>
              <tbody>
<% If JS_METHOD = "register" Then %>
                <tr>
                  <td>Script 파일 위치</td>
                  <td class="left"><%=skin_path%>/js/파일명.js</td>
                </tr>
                <tr>
                  <td>Script 파일명</td>
                  <td class="left">
                    <label class="input col-md-3 col-xs-12">
                      <input type="text" name="js_code" data-parsley-maxlength="30" data-parsley-required value="<%=JS_CODE%>">
                    </label>
                  </td>
                </tr>
<% Else %>
                <tr>
                  <td>Script 파일</td>
                  <td class="left"><input type="hidden" name="js_code" value="<%=JS_CODE%>"> <%=skin_path%>/js/<%=JS_CODE%>.js</td>
                </tr>
<% End If %>
              </tbody>
            </table>

            <section style="margin-top:10px;">
              <label class="textarea">
                <textarea rows="35" name="js_cont" class="resizable"><%=JS_CONT%></textarea>
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
