<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<!-- #include virtual = "/exec/module/cms_function.inc" -->
<%
   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CS_CODE,CP_CODE

   CS_CODE = Trim(Request("cs_code"))
   CP_CODE = Trim(Request("cp_code"))
   CP_MODE = Trim(Request("cp_mode"))

   If CP_MODE = "" Then CP_MODE = "html"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   WHERE = "CS_CODE='" & CS_CODE & "' AND CP_CODE='" & CP_CODE & "' AND CP_STATE<'90'"

   SQL = "SELECT CL_CODE FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CL_CODE = Rs("CL_CODE")
   End If
   Rs.close

   Dim FileControl
   Set FileControl = Server.CreateObject("Server.FileControl")

   skin_path = "/skin/" & CS_CODE
   skin_mappath = Server.MapPath(skin_path)

   If CP_MODE = "html" Then
      layout_file_path = skin_mappath & "/layout/" & CL_CODE & ".asp"
      Const ForReading = 1, ForWriting = 2
      Dim fso, ReadFile

      Set fso = SERVER.CreateObject("Scripting.FileSystemObject")
      Set ReadFile = fso.OpenTextFile(layout_file_path, ForReading)

      WHILE ((NOT ReadFile.AtEndOfStream))
         LINE_CONT = trim(ReadFile.ReadLine)

         If InStr(LINE_CONT,".css") > 0 Then
            LINE_CONT = Replace(LINE_CONT,"<link href=","")
            LINE_CONT = Replace(LINE_CONT,"rel=","")
            LINE_CONT = Replace(LINE_CONT,"stylesheet","")
            LINE_CONT = Replace(LINE_CONT,">","")
            LINE_CONT = Replace(LINE_CONT,"""","")

            CSS_LST = CSS_LST & "@import url('" & trim(LINE_CONT) & "');" & vbNewLine
         End If
      WEND

      css_path = skin_path & "/css/editor.css"
      css_file_path = skin_mappath & "/css/editor.css"

      '에디터CSS 저장
      FileControl.CreateFile css_file_path, "UTF-8", CSS_LST
   End If

   temp_file_path = skin_mappath & "/page/" & Replace(CP_CODE,"/",".") & ".temp"
   make_file_path = skin_mappath & "/page/" & Replace(CP_CODE,"/",".") & ".asp"

   temp_date = File_ModifyDate(temp_file_path)
   make_date = File_ModifyDate(make_file_path)

   inc_start = "<" & chr(37) & "@ LANGUAGE=""VBSCRIPT"" CODEPAGE=65001 " & chr(37) & ">" & vbNewLine
   inc_start = inc_start & "<!-- #include virtual = ""/conf/site_config.inc"" -->" & vbNewLine

   CP_TXET = "신규등록"

   If make_date <> "" Then
      If make_date > temp_date Then
         CP_CONT = FileControl.ReadFile(make_file_path, "UTF-8")

         CP_CONT = Replace(CP_CONT,inc_start,"")
         CP_CONT = ExecCodeChange(CS_CODE,CP_CONT)
         CP_TXET = "<font color=red>실행파일 " & skin_path & "/page/" & Replace(CP_CODE,"/",".") & ".asp</font>"
      Else
         CP_CONT = FileControl.ReadFile(temp_file_path, "UTF-8")
         CP_CONT = Replace(CP_CONT,inc_start,"")
         CP_TXET = "디자인파일 " & skin_path & "/page/" & Replace(CP_CODE,"/",".") & ".temp"
      End If

      CP_METHOD = "modify"
   Else
      CP_METHOD = "register"
   End If

   Set FileControl = Nothing

   If CP_MODE = "html" Then
      CP_CONT = Replace(CP_CONT,Chr(60) & Chr(37),"{{%")
      CP_CONT = Replace(CP_CONT,Chr(37) & Chr(62),"%}}")
      CP_CONT = Replace(CP_CONT,"&","&amp;")
      CP_CONT = replace(CP_CONT, chr(34), "&quot;")
      CP_CONT = Replace(CP_CONT,"<","&lt;")
      CP_CONT = Replace(CP_CONT,">","&gt;")
   End If

   Conn.Close
   Set Conn = nothing
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>[ <%=CS_NAME%> Admin Version 2.0]</title>

<link href="/exec/css/bootstrap.min.css" rel="stylesheet">
<link href="/exec/css/font-awesome.min.css" rel="stylesheet">
<link href="/admin/css/nestedsortablewidget.css" rel="stylesheet">
<link href="/admin/css/admin.css" rel="stylesheet">

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/jquery-ui.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>
<script src="/admin/js/admin.js"></script>
</head>

<body style="background:#ffffff;">
<div id="wrapper">

<% If CP_MODE = "html" Then %>
  <link rel="stylesheet" href="/exec/ezeditor/css/editor.css" type="text/css" charset="utf-8"/>
  <script src="/exec/ezeditor/js/editor_loader.js"></script>
<% End If %>

  <div class="panel panel-default">
    <div class="panel-heading"><i class="fa fa-table"></i> 페이지관리</div>
    <div class="panel-body no-padding">
      <div class="panel-body-toolbar">
      </div>

        <form id="w_form" name="w_form" target="sframe2" method="post" action=".." class="form" data-parsley-validate>
        <input type="hidden" name="action" value="skin.page">
        <input type="hidden" name="cs_code" value="<%=CS_CODE%>">
        <input type="hidden" name="cp_code" value="<%=CP_CODE%>">
        <input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
        <input type="hidden" name="method" value="cont">

          <header>
            페이지 관리
            <p class="note">페이지 컨텐츠를 등록/수정 할수 있습니다.</p>
          </header>

          <fieldset>
            <table class="table table-bordered table-striped">
              <colgroup>
                <col class="col-sm-3 col-lg-1">
                <col class="col-sm-5 col-lg-7">
              </colgroup>
              <tbody>
                <tr>
                  <td>페이지주소</td>
                  <td class="left"><%=CP_CODE%></td>
                </tr>
                <tr>
                  <td>편집소스 경로</td>
                  <td class="left"><%=CP_TXET%></td>
                </tr>
              </tbody>
            </table>

<% If CP_MODE = "html" Then %>
            <textarea id="paste" name="paste" style="display:none"><%=CP_CONT%></textarea>
            <textarea id="content" name="content" style="display:none"></textarea>

            <div style="float:left; margin-top:10px; width:100%;">
              <div id="editor_div">
                <!-- 에디터 삽입 -->
              </div>
            </div>
<% Else %>
            <section style="margin-top:10px;">
              <label class="textarea">
                <textarea rows="40" name="content"><%=CP_CONT%></textarea>
              </label>
            </section>
<% End If %>
          </fieldset>

          <footer>
            <button type="button" class="btn btn-primary" onclick="form_check();">
              <i class="fa fa-pencil fa-lg"></i> 저장
            </button>
          </footer>
        </form>

      </div>
    </div>
  </div>

<% If CP_MODE = "html" Then %>
<script type="text/javascript">
  var editorConfig = {
    'editorpath': '/exec/ezeditor', /* 에디터경로 */
    'editorelement': 'editor_div', /* 에디터삽입element */
    'editorwidth': '100%', /* 에디터폭 */
    'editorheight': '500px', /* 에디터높이 */
    'contwidth': null, /* 컨텐츠폭 null(100%) */
    'imgmaxwidth': 900, /* 이미지최대폭 */
    'formname': 'w_form', /* 폼이름 */
    'loadcontent': 'paste', /* 로드element */
    'savehtml': 'content', /* HTML저장element */
    'uploadpath': '/file/img_page', /* 업로드경로 */
    'uploadmax': 10, /* 업로드용량 */
    'bgcolor': false, /* 배경적용 */
    'fileboxview': false
  };

  loadEditor(editorConfig);

  Editor.getCanvas().observeJob('canvas.height.change', function () {
    parent.resize();
  });

  $('#tx_canvas_wysiwyg').contents().find('#editorcss').attr('href', '<%=css_path%>');
</script>
<% End If %>

<script language="javascript">
<!--
  var form = document.w_form;

  function page_reload(){
    document.location.reload();
  }

  function form_check(){
<% If CP_MODE = "html" Then %>
    setForm();
<% End If %>
    var msg = "등록하시겠습니까?"
    if(confirm(msg)){
      form.submit();
    }else{
      return;
    }
  }
-->
</script>

</div>
<!-- /#wrapper -->

<div style="display:none"><iframe name='sframe2' style="width:0px;height:0px;"></iframe></div>

</body>
</html>