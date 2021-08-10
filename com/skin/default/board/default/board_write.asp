<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT,BC_MEM_SEQ

   Dim BOARD_LST_Table
   BOARD_LST_Table = "BOARD_LST"

   Dim B_SEQ,B_PTSEQ,B_PSEQ,B_PSORT,B_PDEPTH,B_TITLE,B_CONT,B_FILE_NAME,B_FILE_SIZE,B_READ_CNT
   Dim B_RECO_CNT,B_IP,B_WDATE,B_MDATE,B_STATE,B_MEM_SEQ,B_MEM_NAME

   Dim BOARD_FILE_LST_Table
   BOARD_FILE_LST_Table = "BOARD_FILE_LST"

   Dim BF_SEQ,BF_NAME,BF_TYPE,BF_SIZE

   BC_SEQ = Trim(Request("bc_seq"))
   BC_METHOD = Trim(Request("method"))
   B_CATE = Trim(Request("b_cate"))
   page = Trim(Request("page"))
   B_SEQ = Trim(Request("b_seq"))
   search_key = trim(request("search_key"))
   search_word = trim(replace(request("search_word"), chr(34), "&#34;"))

   If IsNumeric(BC_SEQ) = false Then Response.End

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_SEQ = Rs("BC_SEQ")
      BC_TYPE = Rs("BC_TYPE")
      BC_NAME = Rs("BC_NAME")
      BC_SKIN = RS("BC_SKIN")
      BC_CATE = RS("BC_CATE")
      BC_HEADER = Rs("BC_HEADER")
      BC_NOTICE = Rs("BC_NOTICE")
      BC_SECRET = Rs("BC_SECRET")
      BC_READ_MT = Rs("BC_READ_MT")
      BC_WRITE_MT = Rs("BC_WRITE_MT")
      BC_MEM_SEQ = Rs("MEM_SEQ")

      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) Then MEM_LEVEL = "00"
   End If
   Rs.close

   If BC_CATE <> "" Then
      If InStr(BC_CATE,",") > 0 Then
         BSP_CATE = Split(BC_CATE,",")
         For fn = 0 to UBound(BSP_CATE)
            If B_CATE = trim(BSP_CATE(fn)) Then
               cate_opt = cate_opt & "  <option value=""" & trim(BSP_CATE(fn)) & """ selected>" & trim(BSP_CATE(fn)) & "</option>" & vbNewLine
            Else
               cate_opt = cate_opt & "  <option value=""" & trim(BSP_CATE(fn)) & """>" & trim(BSP_CATE(fn)) & "</option>" & vbNewLine
            End If
         Next
      Else
         cate_opt = cate_opt & "  <option value=""" & BC_CATE & """>" & BC_CATE & "</option>" & vbNewLine
      End If
   End If

   If BC_HEADER <> "" Then
      If InStr(BC_HEADER,",") > 0 Then
         BSP_HEADER = Split(BC_HEADER,",")
         For fn = 0 to UBound(BSP_HEADER)
            If B_HEADER = trim(BSP_HEADER(fn)) Then
               header_opt = header_opt & "  <option value=""" & trim(BSP_HEADER(fn)) & """ selected>" & trim(BSP_HEADER(fn)) & "</option>" & vbNewLine
            Else
               header_opt = header_opt & "  <option value=""" & trim(BSP_HEADER(fn)) & """>" & trim(BSP_HEADER(fn)) & "</option>" & vbNewLine
            End If
         Next
      Else
         header_opt = header_opt & "  <option value=""" & BC_HEADER & """>" & BC_HEADER & "</option>" & vbNewLine
      End If
   End If

   If IsNULL(BC_SKIN) OR BC_SKIN = "" Then BC_SKIN = "default"
   SKIN_PATH = "/exec/board/" & BC_SKIN

   If URL = "" OR InStr(URL,"/admin/") > 0 Then
      SelfUrl = Request.ServerVariables("URL")
      ActUrl = "/exec/action/board.asp"
   Else
      SelfUrl = "/" & URL
      ActUrl = "/" & URL
   End If

   If BC_METHOD = "edit" Then
      SQL = "SELECT * FROM " & BOARD_LST_Table & " WHERE B_SEQ=" & B_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         B_SEQ = Rs("B_SEQ")
         B_PTSEQ = Rs("B_PTSEQ")
         B_PSEQ = Rs("B_PSEQ")
         B_PSORT = Rs("B_PSORT")
         B_PDEPTH = Rs("B_PDEPTH")
         B_NOTICE = Rs("B_NOTICE")
         B_SECRET = Rs("B_SECRET")
         B_CATE = RS("B_CATE")
         B_GUEST_NAME = Rs("B_GUEST_NAME")
         B_HEADER = Rs("B_HEADER")
         B_TITLE = Rs("B_TITLE")
         B_CONT = Rs("B_CONT")
         B_FILE_NAME = Rs("B_FILE_NAME")
         B_FILE_SIZE = Rs("B_FILE_SIZE")
         B_IMAGES = Rs("B_IMAGES")
         B_FILES = Rs("B_FILES")
         B_ADD1 = Rs("B_ADD1")
         B_ADD2 = Rs("B_ADD2")
         B_ADD3 = Rs("B_ADD3")
         B_ADD4 = Rs("B_ADD4")
         B_MEM_SEQ = Rs("MEM_SEQ")
         B_URL = Rs("B_URL")

         B_SDATE = Replace(f_chang_date(Rs("B_SDATE")),"/","-")

         If IsNULL(B_MEM_SEQ) Then
            B_MEM_SEQ = 0
            B_MEM_NAME = B_GUEST_NAME
         End If

         If B_FILE_NAME <> "" AND BC_TYPE <> "01" Then FILE_Script = "insert_img(0,'img','board','board_thumbnail','" & B_FILE_NAME & "','" & B_FILE_SIZE & "',600,360,360);"

         B_CONT = Replace(B_CONT,"&","&amp;")
         B_CONT = replace(B_CONT, chr(34), "&quot;")
         B_CONT = Replace(B_CONT,"<","&lt;")
         B_CONT = Replace(B_CONT,">","&gt;")

         B_CONT = Replace(B_CONT,"img src=&quot;../","img src=&quot;/")
         B_CONT = Replace(B_CONT,"background=&quot;../","background=&quot;/")
      End If
      Rs.close
   End If

   '## 쓰기권한 체크
   If BC_METHOD = "write" OR BC_METHOD = "reply" Then
      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_WRITE_MT) Then
      Else
         Page_Msg_Back "글쓰기 권한이 없습니다."
         response.end
      End If
   Else
      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("board" & B_SEQ) = Cstr(B_SEQ) Then
      Else
         Page_Msg_Back "수정 권한이 없습니다."
         response.end
      End If
   End If

   If BC_METHOD = "reply" Then
      SQL = "SELECT * FROM " & BOARD_LST_Table & " WHERE B_SEQ=" & B_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         B_SEQ = Rs("B_SEQ")
         B_PTSEQ = Rs("B_PTSEQ")
         B_PSEQ = Rs("B_PSEQ")
         B_PSORT = Rs("B_PSORT")
         B_PDEPTH = Rs("B_PDEPTH")
         B_TITLE = Rs("B_TITLE")
         B_CONT = Rs("B_CONT")

         B_CONT = Replace(B_CONT,"&","&amp;")
         B_CONT = replace(B_CONT, chr(34), "&quot;")
         B_CONT = Replace(B_CONT,"<","&lt;")
         B_CONT = Replace(B_CONT,">","&gt;")

         B_CONT = Replace(B_CONT,"img src=&quot;../","img src=&quot;/")
         B_CONT = Replace(B_CONT,"background=&quot;../","background=&quot;/")

         B_TITLE = "Re : " & B_TITLE
         B_CONT = "<br><br>------------------- 원문내용 -------------------<br>" & B_CONT
      End If
      Rs.close
   End If

   Conn.Close
   Set Conn = nothing

   List_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','list','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
%>
<%=b_cate%>
<link rel="stylesheet" href="/exec/ezeditor/css/editor.css" type="text/css" charset="utf-8"/>
<script src="/exec/ezeditor/js/editor_loader.js"></script>

<form id="w_form" name="w_form" method="post" action="<%=ActUrl%>" class="form wform">
<input type="hidden" name="action" value="board">
<input type="hidden" name="self_url" value="<%=SelfUrl%>">

<input type="hidden" name="pageid" value="<%=PageID%>">
<input type="hidden" name="pagenum" value="<%=PageNum%>">

<input type="hidden" name="bc_seq" value="<%=BC_SEQ%>">
<input type="hidden" name="bc_type" value="<%=BC_TYPE%>">
<input type="hidden" name="method" value="<%=BC_METHOD%>">

<input type="hidden" name="b_seq" value="<%=B_SEQ%>">
<input type="hidden" name="b_ptseq" value="<%=B_PTSEQ%>">
<input type="hidden" name="b_pseq" value="<%=B_PSEQ%>">
<input type="hidden" name="b_psort" value="<%=B_PSORT%>">
<input type="hidden" name="b_pdepth" value="<%=B_PDEPTH%>">

<input type="hidden" name="up_dir" value="/file/board">
<input type="hidden" name="file_name" value="<%=B_FILE_NAME%>">
<input type="hidden" name="file_size" value="<%=B_FILE_SIZE%>">

<input type="hidden" id="attachimage" name="attachimage" value="<%=B_IMAGES%>">
<input type="hidden" id="attachfile" name="attachfile" value="<%=B_FILES%>">

<% If BC_CATE = "" Then %>
<input type="hidden" name="b_cate" value="<%=B_CATE%>">
<% End If %>

<textarea id="paste" name="paste" style="display:none"><%=B_CONT%></textarea>
<textarea id="bodyhtml" name="bodyhtml" style="display:none"></textarea>
<textarea id="bodytxt" name="bodytxt" style="display:none"></textarea>

  <header>
    게시글 관리
    <p class="note">게시글을 등록/수정 할수 있습니다.</p>
  </header>

  <fieldset>
<% If MEM_LEVEL = "99" OR (B_MEM_SEQ = 0 AND BC_METHOD = "edit") Then %>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 작성자</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="b_guest_name" id="b_guest_name" value="<%=B_GUEST_NAME%>">
        </label>
      </section>
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 비밀번호</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="password" name="b_guest_pwd" id="b_guest_pwd" value="<%=B_GUEST_PWD%>">
        </label>
      </section>
    </div>
<% Else %>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 작성자</label>
      <section class="col col-md-4">
        <p class="form-control-static"><%=MEM_NAME%></p>
        <input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">
      </section>
    </div>
<% End If %>
<% If BC_CATE <> "" Then %>
    <div class="row">
      <label class="label col col-md-2">카테고리</label>
      <section class="col col-md-4">
        <label class="select">
          <select name="b_cate" id="b_cate">
            <option value="">선택하세요</option>
<%=cate_opt%>
          </select>
        </label>
      </section>
    </div>
<% End If %>
<% If BC_HEADER <> "" Then %>
    <div class="row">
      <label class="label col col-md-2">구분/머리말</label>
      <section class="col col-md-4">
        <label class="select">
          <select name="b_header" id="b_header">
            <option value="">선택하세요</option>
<%=header_opt%>
          </select>
        </label>
      </section>
    </div>
<% End If %>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 제목</label>
      <section class="col col-md-7">
        <label class="input">
          <input type="text" name="b_title" id="b_title" value="<%=B_TITLE%>">
        </label>
      </section>
      <section class="col col-md-3">
        <div class="inline-group">
<% If BC_NOTICE = "1" AND MEM_LEVEL = "00" AND BC_METHOD <> "reply" Then %>
          <label class="checkbox"><input type="checkbox" name="b_notice" value="1"><i></i> 공지글</label>
<% End If %>
<% If BC_SECRET = "1" AND B_PTSEQ = B_SEQ AND BC_METHOD <> "reply" Then %>
          <label class="checkbox"><input type="checkbox" name="b_secret" value="1"><i></i> 비밀글</label>
<% End If %>
        </div>
      </section>
    </div>

<% If BC_TYPE = "01" Then %>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 첨부파일</label>
      <section class="col col-md-4">
        <label class="input">
          <input type="text" name="file_name_view" id="file_name_view" value="<%=B_FILE_NAME%>" readonly>
        </label>
      </section>
      <section class="col col-md-4">
        <button type="button" class="btn btn-default" onclick="upload_file(1,'file','board');">검색</button>
      </section>
    </div>
<% Else %>
    <div class="row">
      <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 목록이미지</label>
      <section class="col col-md-4">
        <span id="show_img"><a href="javascript:upload_img(0,'img','board',600,360,360);"><img src="<%=SKIN_PATH%>/img/noimg.gif" border="0" /></a></span>
      </section>
    </div>
<% End If %>

    <div style="margin-top:10px; width:100%;">
      <div id="editor_div">
        <!-- 에디터 삽입 -->
      </div>
    </div>
  </fieldset>

  <div class="text-center" style="clear:both;">
    <button type="button" class="btn btn-theme btn-primary" onclick="form_check();"><i class="fa fa-pencil fa-lg"></i> 글쓰기</button>
    <button type="button" class="btn btn-default" onclick="<%=List_Script%>">목록보기</button>
  </div>
</form>

<script type="text/javascript">
  var editorConfig = {
    'editorpath': '/exec/ezeditor', /* 에디터경로 */
    'editorelement': 'editor_div', /* 에디터삽입element */
    'editorwidth': '100%', /* 에디터폭 */
    'editorheight': '400px', /* 에디터높이 */
    'contwidth': null, /* 컨텐츠폭 null(100%) */
    'imgmaxwidth': 650, /* 이미지최대폭 */
    'imgzoom': true, /* 이미지줌사용여부 */
    'formname': 'w_form', /* 폼이름 */
    'loadcontent': 'paste', /* 로드element */
    'savehtml': 'bodyhtml', /* HTML저장element */
    'savetxt': 'bodytxt', /* Text저장element */
    'uploadpath': '/file/board', /* 업로드경로 */
    'bgcolor': false, /* 배경적용 */
    'fileboxview': true, /* 첨부박스표시여부 */
    'attachimage': 'attachimage', /* 첨부이미지element */
    'attachfile': 'attachfile' /* 첨부파일element */
  };

  loadEditor(editorConfig);

  //Editor.getCanvas().observeJob('canvas.height.change', function () {
  //  parent.resize();
  //});
</script>

</div>

<script language="javascript">
<!--
  $(document).ready(function(){
    $("input:radio[name='bc_list']:radio[value='<%=BC_LIST%>']").attr("checked",true);

    //$("select[name='b_cate']").val("<%=B_CATE%>");
    $('select[name=b_cate]').find('option[value="<%=B_CATE%>"]').prop('selected', true);
  });

  var form = document.w_form;

  if(form!=null && form!=undefined){
    if(form.b_notice != null) set_value(form.b_notice, "<%=B_NOTICE%>");
    if(form.b_secret != null) set_value(form.b_secret, "<%=B_SECRET%>");
    if(form.b_header != null) set_value(form.b_header, "<%=B_HEADER%>");
  }

  function upload_file(f_num,f_type,f_path){
    window.open("/exec/file/upload.asp?f_num=" + f_num + "&f_path=" + f_path,"upload","width=400,height=278,toolbar=0,menubar=0,status=0,scrollbars=0,resizable=0");
  }

  function insert_file(f_num,f_type,f_path,f_spath,f_name,f_size){
    form.file_name_view.value = f_name;
    form.file_name.value = f_name;
    form.file_size.value = f_size;
  }

  function upload_img(f_num,f_type,f_path,m_with,s_with,s_height){
    window.open("/exec/file/upload.asp?f_num=" + f_num + "&f_type=" + f_type + "&f_path=" + f_path + "&m_with=" + m_with + "&s_with=" + s_with + "&s_height=" + s_height,"upload","width=400,height=278,toolbar=0,menubar=0,status=0,scrollbars=0,resizable=0");
  }

  function insert_img(f_num,f_type,f_path,f_spath,f_name,f_size,m_with,s_with,s_height){
    form.file_name.value = f_name;
    form.file_size.value = f_size;

    var frm = document.all;
    var tmp = "<a href=\"javascript:upload_img(" + f_num + ",'" + f_type + "','" + f_path + "'," + m_with + "," + s_with + "," + s_height + ");\"><img src='/file/" + f_spath + "/" + f_name + "' border='0'></a>";

    frm.show_img.innerHTML = tmp;
<% If InStr(URL,"/admin/") > 0 Then %>
    setTimeout("parent.viewfrmresize($('#wrapper').height() + 50);",300);
<% End If %>
  }

<%=FILE_Script%>

  function form_check(){
<% If MEM_LEVEL = "99" OR (B_MEM_SEQ = 0 AND BC_METHOD = "edit") Then %>
    if(!chkNull(form.b_guest_name, "\'작성자\'를 입력해 주세요")) return;
    if(!chkNull(form.b_guest_pwd, "\'비밀번호\'를 입력해 주세요")) return;
<% End If %>
    if(!chkNull(form.b_title, "\'제목\'을 입력해 주세요")) return;

    if(!editorcheck()) return;

    var msg = "등록하시겠습니까?"
    if(confirm(msg)){
      form.submit();
    }else{
      return;
    }
  }
-->
</script>
