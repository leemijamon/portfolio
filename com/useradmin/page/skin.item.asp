<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<!-- #include virtual = "/exec/module/cms_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim CMS_ITEM_LST_Table
   CMS_ITEM_LST_Table = "CMS_ITEM_LST"

   Dim CI_CODE,CI_TYPE,CI_NAME,CI_CONT,CI_SKIN,ADM_SEQ

   CS_CODE = Trim(Request("cs_code"))
   CI_CODE = Trim(Request("ci_code"))
   CI_TYPE = Trim(Request("ci_type"))

   CI_METHOD = "register"
   CI_TYPE = "main"

   If CI_CODE <> "" Then
      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      WHERE = "CI_CODE='" & CI_CODE & "' AND CS_CODE='" & CS_CODE & "'"

      SQL = "SELECT * FROM " & CMS_ITEM_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         CI_CODE = Rs("CI_CODE")
         CI_TYPE = Rs("CI_TYPE")
         CI_NAME = Rs("CI_NAME")
         CI_SKIN = Rs("CI_SKIN")
         CI_METHOD = "modify"
      End If
      Rs.close

      If CI_SKIN = "" Then
         skin_path = "/skin/" & CS_CODE
         skin_mappath = Server.MapPath(skin_path)

         temp_file_path = skin_mappath & "\items\" & CI_CODE & ".temp"
         make_file_path = skin_mappath & "\items\" & CI_CODE & ".inc"

         temp_date = File_ModifyDate(temp_file_path)
         make_date = File_ModifyDate(make_file_path)

         If make_date <> "" Then
            Dim FileControl
            Set FileControl = Server.CreateObject("Server.FileControl")

            If make_date > temp_date Then
               CI_CONT = FileControl.ReadFile(make_file_path, "UTF-8")
               CI_CONT = ExecCodeChange(CS_CODE,CI_CONT)
               CI_TXET = "<font color=red>실행파일 " & skin_path & "/items/" & CI_CODE & ".inc</font>"
            Else
               CI_CONT = FileControl.ReadFile(temp_file_path, "UTF-8")
               CI_TXET = "디자인파일 " & skin_path & "/items/" & CI_CODE & ".temp"
            End If

            Set FileControl = Nothing

            CI_CONT = Replace(CI_CONT,Chr(60) & Chr(37),"{{%")
            CI_CONT = Replace(CI_CONT,Chr(37) & Chr(62),"%}}")
            CI_CONT = Replace(CI_CONT,"&","&amp;")
            CI_CONT = replace(CI_CONT, chr(34), "&quot;")
            CI_CONT = Replace(CI_CONT,"<","&lt;")
            CI_CONT = Replace(CI_CONT,">","&gt;")
         End If
      End If

      Conn.Close
      Set Conn = nothing
   End If

   folder_dir = Server.MapPath("/execskin")

   Set objFile = Server.CreateObject("Scripting.FileSystemObject")
   Set objFolder = objFile.GetFolder(folder_dir)

   For Each folders in objFolder.subfolders
      SKIN_OPT = SKIN_OPT & "<option value='" & folders.name & "'>" & folders.name & "</option>"
   Next
%>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-edit"></i> 아이템 관리</div>
        <div class="panel-body no-padding">

        <form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
        <input type="hidden" name="action" value="skin.item">
        <input type="hidden" name="cs_code" value="<%=CS_CODE%>">

        <input type="hidden" name="method" value="<%=CI_METHOD%>">
        <input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

          <header>
            아이템 관리
            <p class="note">아이템 정보를 등록/수정 할수 있습니다.</p>
          </header>

          <fieldset>
            <table class="table table-bordered table-striped">
              <colgroup>
                <col class="col-md-2 col-sm-4 col-xs-4">
                <col class="col-md-10 col-sm-8 col-xs-8">
              </colgroup>
              <tbody>
                <tr>
                  <td height="22">아이템구분</td>
                  <td class="left">
                  <div class="inline-group">
                    <label class="radio">
                      <input type="radio" name="ci_type" value="main">
                      <i></i>메인
                    </label>
                    <label class="radio">
                      <input type="radio" name="ci_type" value="menu">
                      <i></i>메뉴
                    </label>
                    <label class="radio">
                      <input type="radio" name="ci_type" value="page">
                      <i></i>페이지
                    </label>
                  </div>
                  </section>
                  </td>
                </tr>
                <tr>
                  <td height="22">아이템코드</td>
                  <td class="left">
<% If CI_METHOD = "register" Then %>
                    <label class="input col-md-3 col-xs-12">
                      <input type="text" name="ci_code" data-parsley-type="alphanum" data-parsley-maxlength="15" data-parsley-required value="<%=CI_CODE%>">
                    </label>
<% Else %>
                    <input type="hidden" name="ci_code" value="<%=CI_CODE%>"> {{item.<%=CI_CODE%>}}
<% End If %>
                  </td>
                </tr>
                <tr>
                  <td>아이템명</td>
                  <td class="left">
                    <label class="input col-md-3 col-xs-12">
                      <input type="text" name="ci_name" data-parsley-maxlength="15" data-parsley-required value="<%=CI_NAME%>">
                    </label>
                  </td>
                </tr>
                <tr>
                  <td>스킨선택</td>
                  <td class="left">
                    <label class="select col-md-3 col-xs-12">
                      <select name="ci_skin">
                        <option value="">사용자입력</option>
                        <option value="userskin">사용자스킨</option>
<%=SKIN_OPT%>
                      </select><i></i>
                    </label>
                  </td>
                </tr>
<% If CI_TXET <> "" Then %>
                <tr>
                  <td>편집소스 경로</td>
                  <td class="left"><%=CI_TXET%></td>
                </tr>
<% End If %>
              </tbody>
            </table>

            <section style="margin-top:10px;">
              <label class="textarea">
                <textarea rows="35" name="ci_cont" class="resizable"><%=CI_CONT%></textarea>
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
  $("input:radio[name='ci_type']:radio[value='<%=CI_TYPE%>']").attr("checked",true);
  //$("select[name='ci_skin']").val("<%=CI_SKIN%>");
  $('select[name=ci_skin]').find('option[value="<%=CI_SKIN%>"]').prop('selected', true);

  $('textarea.resizable:not(.processed)').TextAreaResizer();
  $("#editform").parsley();
</script>
