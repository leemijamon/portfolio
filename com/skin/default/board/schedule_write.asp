<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->

<!-- container -->
<!-- 페이지 타이틀 -->
<script src="/skin/default/js/jquery-ui-1.9.2.custom.min.js"></script>
<link href="/skin/default/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet">
<div class="catalog-wrap sub-box">
	<div class="row">
		<div class="col-md-12">
			<section class="board-content">
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

							 If B_FILE_NAME <> "" AND BC_TYPE <> "01" Then FILE_Script = "insert_img(0,'img','board','board_thumbnail','" & B_FILE_NAME & "','" & B_FILE_SIZE & "',600,456,360);"

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
					<input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">

					<% If BC_CATE = "" Then %>
					<input type="hidden" name="b_cate" value="<%=B_CATE%>">
					<% End If %>

					<textarea id="paste" name="paste" style="display:none"><%=B_CONT%></textarea>
					<textarea id="bodyhtml" name="bodyhtml" style="display:none"></textarea>
					<textarea id="bodytxt" name="bodytxt" style="display:none"></textarea>

					  <!--
					  <header>
						게시글 관리
						<p class="note">게시글을 등록/수정 할수 있습니다.</p>
					  </header>
					  -->

					  <fieldset class="board-write">
							<div class="row">
							  <label class="col col-md-2"><i class="fa fa-check color-red"></i> 시작일자</label>
							  <section class="col col-md-1">
								  <input type="text" name="b_sdate" class="form-control calandar" id="b_sdate" value="<%=B_SDATE%>" readonly style="width:150px;">
							  </section>
							</div>
							<div class="row" style="margin-top:15px;">
							  <label class="col col-md-2"><i class="fa fa-check color-red"></i> 종료일자</label>
							  <section class="col col-md-1">
								   <input type="text" name="b_add1" class="form-control calandar" id="b_add1" value="<%=B_ADD1%>" readonly  style="width:150px;">
							  </section>
							</div>

							<div class="row" style="margin-top:15px;">
							  <label class="col col-md-2"><i class="fa fa-check color-red"></i> 제목</label>
							  <section class="col col-md-7">
								  <input type="text" name="b_title" class="form-control" id="b_title" value="<%=B_TITLE%>">
							  </section>
							</div>

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

			</section>
		</div>
	</div>
</div>
<!-- //container -->

<script type="text/javascript">
  var editorConfig = {
    'editorpath': '/exec/ezeditor', /* 에디터경로 */
    'editorelement': 'editor_div', /* 에디터삽입element */
    'editorwidth': '100%', /* 에디터폭 */
    'editorheight': '400px', /* 에디터높이 */
    'contwidth': null, /* 컨텐츠폭 null(100%) */
    'imgmaxwidth': 710, /* 이미지최대폭 */
    'imgzoom': true, /* 이미지줌사용여부 */
    'formname': 'w_form', /* 폼이름 */
    'loadcontent': 'paste', /* 로드element */
    'savehtml': 'bodyhtml', /* HTML저장element */
    'savetxt': 'bodytxt', /* Text저장element */
    'uploadpath': '/file/board', /* 업로드경로 */
    'bgcolor': false, /* 배경적용 */
    'fileboxview': false, /* 첨부박스표시여부 */
    'attachimage': 'attachimage', /* 첨부이미지element */
    'attachfile': 'attachfile' /* 첨부파일element */
  };

  loadEditor(editorConfig);

  //Editor.getCanvas().observeJob('canvas.height.change', function () {
  //  parent.resize();
  //});
</script>

<script language="javascript">
<!--
var form = document.w_form;
  $.datepicker.setDefaults({
    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    showMonthAfterYear:true,
    dateFormat: 'yy-mm-dd'
  });

  $(document).ready(function(){
  		$(".calandar").datepicker();
		});

  function form_check(){
    if(!chkNull(form.b_sdate, "\'일자\'를 입력해 주세요")) return;
    if(!chkNull(form.b_add1, "\'일자\'를 입력해 주세요")) return;
    if(!chkNull(form.b_title, "\'일정명\'을 입력해 주세요")) return;

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
