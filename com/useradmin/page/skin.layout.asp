<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<!-- #include virtual = "/exec/module/cms_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim CMS_LAYOUT_LST_Table
   CMS_LAYOUT_LST_Table = "CMS_LAYOUT_LST"

   Dim CMS_ITEM_LST_Table
   CMS_ITEM_LST_Table = "CMS_ITEM_LST"

   Dim CI_CODE,CI_TYPE,CI_NAME,CI_CONT,CI_EXECSKIN,CI_WDATE,CI_MDATE,CI_STATE
   Dim CL_CODE,CL_NAME,CL_TOP_ITEM,CL_SIDE_ITEM,CL_BODY_ITEM,CL_SCROLL_ITEM,CL_BOTTOM_ITEM

   CS_CODE = Trim(Request("cs_code"))
   CL_CODE = Trim(Request("cl_code"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   If CL_CODE <> "" Then
      WHERE = "CS_CODE='" & CS_CODE & "' AND CL_CODE='" & CL_CODE & "'"

      SQL = "SELECT * FROM " & CMS_LAYOUT_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         CL_CODE = Rs("CL_CODE")
         CL_NAME = Rs("CL_NAME")
      End If
      Rs.close

      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      skin_path = "/skin/" & CS_CODE
      skin_mappath = Server.MapPath(skin_path)

      temp_file_path = skin_mappath & "/layout/" & CL_CODE & ".temp"
      make_file_path = skin_mappath & "/layout/" & CL_CODE & ".asp"

      temp_date = File_ModifyDate(temp_file_path)
      make_date = File_ModifyDate(make_file_path)
      'response.write temp_date & "|" & make_date

      If make_date <> "" Then
         If make_date > temp_date Then
            LAYOUT_CONT = FileControl.ReadFile(make_file_path, "UTF-8")
            LAYOUT_CONT = layoutExecCodeChange(CS_CODE,LAYOUT_CONT)
            LAYOUT_TXET = "<font color=red>실행파일 " & skin_path & "/layout/" & CL_CODE & ".asp</font>"
         Else
            LAYOUT_CONT = FileControl.ReadFile(temp_file_path, "UTF-8")
            LAYOUT_TXET = "디자인파일 " & skin_path & "/layout/" & CL_CODE & ".temp"
         End If

         LAYOUT_CONT = Replace(LAYOUT_CONT,Chr(60) & Chr(37),"{{%")
         LAYOUT_CONT = Replace(LAYOUT_CONT,Chr(37) & Chr(62),"%}}")
         LAYOUT_CONT = Replace(LAYOUT_CONT,"&","&amp;")
         LAYOUT_CONT = replace(LAYOUT_CONT, chr(34), "&quot;")
         LAYOUT_CONT = Replace(LAYOUT_CONT,"<","&lt;")
         LAYOUT_CONT = Replace(LAYOUT_CONT,">","&gt;")
      End If

      Set FileControl = Nothing

      CL_METHOD = "modify"
   Else
      CL_METHOD = "register"
   End If

   Conn.Close
   Set Conn = nothing
%>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-edit"></i> 레이아웃 관리</div>
        <div class="panel-body no-padding">

        <form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
        <input type="hidden" name="action" value="skin.layout">
        <input type="hidden" name="cs_code" value="<%=CS_CODE%>">
        <input type="hidden" name="method" value="<%=CL_METHOD%>">
        <input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

          <header>
            레이아웃 관리
            <p class="note">페이지 컨텐츠를 등록/수정 할수 있습니다.</p>
          </header>

          <fieldset>
            <table class="table table-bordered table-striped">
              <colgroup>
                <col class="col-md-2 col-sm-4 col-xs-4">
                <col class="col-md-10 col-sm-8 col-xs-8">
              </colgroup>
              <tbody>
                <tr>
                  <td>레이아웃코드</td>
                  <td>
                    <label class="input col-md-3 col-xs-12">
                      <input type="text" name="cl_code" data-parsley-maxlength="15" data-parsley-required value="<%=CL_CODE%>">
                    </label>
                  </td>
                </tr>
                <tr>
                  <td>레이아웃명</td>
                  <td>
                    <label class="input col-md-3 col-xs-12">
                      <input type="text" name="cl_name" data-parsley-maxlength="15" data-parsley-required value="<%=CL_NAME%>">
                    </label>
                  </td>
                </tr>
<% If LAYOUT_TXET <> "" Then %>
                <tr>
                  <td>편집소스 경로</td>
                  <td class="left"><%=LAYOUT_TXET%></td>
                </tr>
<% End If %>
              </tbody>
            </table>

            <section style="margin-top:10px;">
              <label class="textarea">
                <textarea rows="35" name="layoutcont" class="resizable"><%=LAYOUT_CONT%></textarea>
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
