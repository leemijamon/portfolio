<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<!-- #include virtual = "/skin/default/conf/menu_config.inc" -->
<%
   SelfUrl = Request.ServerVariables("URL")
   SelfQuery = Replace(Request.ServerVariables("QUERY_STRING"),"&","|")

   PreDate = Replace(FormatDateTime(DateAdd("d", -2, now()),2),"-","") & Replace(FormatDateTime(now(),4),":","")

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

   Dim BOARD_COMMENT_LST_Table
   BOARD_COMMENT_LST_Table = "BOARD_COMMENT_LST"

   Dim BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_WDATE,BCM_MEM_SEQ

   BC_SEQ = Trim(Request("bc_seq"))
   BC_METHOD = Trim(Request("method"))
   B_CATE = Trim(Request("b_cate"))
   page = Trim(Request("page"))
   B_SEQ = Trim(Request("b_seq"))
   search_key = trim(request("search_key"))
   search_word = trim(replace(request("search_word"), chr(34), "&#34;"))

   If page = "" Then page = 1

   If IsNumeric(BC_SEQ) = false Then Response.End

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_SEQ = Rs("BC_SEQ")
      BC_TYPE = Rs("BC_TYPE")
      BC_NAME = Rs("BC_NAME")
      BC_SKIN = RS("BC_SKIN")
      BC_READ_MT = Rs("BC_READ_MT")
      BC_WRITE_MT = Rs("BC_WRITE_MT")
      BC_REPLY_MT = Rs("BC_REPLY_MT")
      BC_COMM_MT = Rs("BC_COMM_MT")
      BC_NOTICE = Rs("BC_NOTICE")
      BC_SECRET = Rs("BC_SECRET")
      BC_COMMENT = Rs("BC_COMMENT")
      BC_REPLY = Rs("BC_REPLY")
      BC_LIST = RS("BC_LIST")
      BC_MEM_SEQ = Rs("MEM_SEQ")
   End If
   Rs.close

   WRITE_BTN = "1"
   'If BC_READ_MT <> "00" Then BC_READ_MT = "99"
   'If BC_WRITE_MT <> "00" Then BC_WRITE_MT = "99"
   'If BC_REPLY_MT <> "00" Then BC_REPLY_MT = "99"
   'If BC_COMM_MT <> "00" Then BC_COMM_MT = "99"

   If BC_WRITE_MT = "00" AND MEM_LEVEL <> "00" AND Cstr(BC_MEM_SEQ) <> Cstr(MEM_SEQ) Then WRITE_BTN = "0"

   If IsNULL(BC_SKIN) OR BC_SKIN = "" Then BC_SKIN = "default"
   SKIN_PATH = "/skin/board/" & BC_SKIN

   If URL =	"" OR InStr(URL,"/admin/") > 0 Then
	  SelfUrl =	Request.ServerVariables("URL")
	  ActBUrl =	"/exec/action/board.asp"
	  ActCUrl =	"/exec/action/comment.asp"
   Else
	  SelfUrl =	"/"	& URL
	  ActBUrl =	"/"	& URL
	  ActCUrl =	"/"	& URL
   End If


   response.write "<link href='" & SKIN_PATH & "/board.css' rel='stylesheet' type='text/css'>" & vbNewLine

   '조회수 UPDATE
   SQL = "UPDATE " & BOARD_LST_Table & " SET " _
       & "B_READ_CNT=B_READ_CNT + 1 " _
       & "WHERE B_SEQ=" & B_SEQ

   Conn.Execute SQL, ,adCmdText

   SQL = "SELECT *, MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=BOARD_LST.MEM_SEQ) FROM " & BOARD_LST_Table _
       & " WHERE B_SEQ=" & B_SEQ

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      B_SEQ = Rs("B_SEQ")
      B_PTSEQ = Rs("B_PTSEQ")
      B_PSEQ = Rs("B_PSEQ")
      B_PSORT = Rs("B_PSORT")
      B_PDEPTH = Rs("B_PDEPTH")
      B_SECRET = Rs("B_SECRET")
      B_HEADER = Rs("B_HEADER")
      B_TITLE = Rs("B_TITLE")
      B_CONT = Rs("B_CONT")
      B_FILE_NAME = Rs("B_FILE_NAME")
      B_FILE_SIZE = Rs("B_FILE_SIZE")
      B_READ_CNT = FormatNumber(Rs("B_READ_CNT"),0)
      B_RECO_CNT = FormatNumber(Rs("B_RECO_CNT"),0)
      B_IP = Rs("B_IP")
      B_WDATE = f_chang_date(Rs("B_WDATE"))
      B_SDATE = f_chang_date(Rs("B_SDATE"))
      B_MDATE = f_chang_date(Rs("B_MDATE"))
      B_MEM_SEQ = Rs("MEM_SEQ")
      B_MEM_NAME = Rs("MEM_NAME")

      B_ADD1 = Rs("B_ADD1")
      B_ADD2 = Rs("B_ADD2")
      B_ADD3 = Rs("B_ADD3")

      If IsNULL(B_MEM_SEQ) Then
         B_MEM_SEQ = 0
         B_MEM_NAME = Rs("B_GUEST_NAME")
         'B_GUEST_PWD = Rs("B_GUEST_PWD")
      End If

      If B_HEADER <> "" Then B_TITLE = "[" & B_HEADER & "] " & B_TITLE

      If BC_SECRET = "1" AND Cstr(BC_MEM_SEQ) <> Cstr(MEM_SEQ) AND Cstr(B_MEM_SEQ) <> Cstr(MEM_SEQ) Then B_MEM_NAME = Left(B_MEM_NAME,1) & "****"

      If B_FILE_NAME <> "" AND BC_TYPE < "03" Then B_FILE_LINK = "<a href='/exec/file/download.asp?filepath=/file/board&filename=" & B_FILE_NAME & "' class=p11>" & B_FILE_NAME & "&nbsp;(" & f_size(B_FILE_SIZE) & ")</a>&nbsp;&nbsp;"

      If BC_TYPE = "06" OR BC_TYPE = "07" Then
         If B_FILE_NAME <> "" Then B_FILE_VIEW = "<img src='/file/board/" & B_FILE_NAME & "' border='0' style='cursor:hand;' onclick=openImage('/file/board/" & B_FILE_NAME & "');><br>"
      End If
   End If
   Rs.close

   If BC_SECRET = "1" AND B_PTSEQ <> B_SEQ Then
      SQL = "SELECT * FROM " & BOARD_LST_Table & " WHERE B_SEQ=" & B_PTSEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         B_SECRET = Rs("B_SECRET")
      End If
      Rs.close
   End If

   List_Script = "goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','list','" & page & "','','" & search_key & "','" & search_word & "');"

   '## 읽기권한 체크
   If B_SECRET = "1" Then
      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("board" & B_PTSEQ) = Cstr(B_PTSEQ) Then
      Else
         If B_PTSEQ <> B_SEQ Then
            response.write "<script language='javascript'>goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','passlist','" & page & "','" & B_PTSEQ & "','" & search_key & "','" & search_word & "');</script>"
            response.end
         Else
            response.write "<script language='javascript'>goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','passview','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');</script>"
            response.end
         End If
      End If
   Else
      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_READ_MT) OR Session("board" & B_PSEQ) = Cstr(B_PSEQ) Then
      Else
         If B_MEM_SEQ = 0 Then
            response.write "<script language='javascript'>goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','passview','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');</script>"
            response.end
         Else
            Page_Msg_Back "읽기 권한이 없습니다."
            response.end
         End If
      End If
   End If

   '## 쓰기권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_WRITE_MT) Then
      Write_Script = "goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','write','','','','');"
   Else
      Write_Script = "alert('글쓰기 권한이 없습니다.');"
   End If

   '## 수정/삭제권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("board" & B_SEQ) = Cstr(B_SEQ) Then
      Edit_Script = "goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','edit','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
      Del_Script = "board_del();"
   Else
      If B_MEM_SEQ = 0 Then
         Edit_Script = "goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','passedit','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
         Del_Script = "goBoard('" & SelfUrl & PageQuery & "','" & BC_SEQ & "','" & B_CATE & "','passdel','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
      Else
         Edit_Script = "alert('회원님은 수정권한이 없습니다.');"
         Del_Script = "alert('회원님은 삭제권한이 없습니다.');"
      End If
   End If

   Conn.Close
   Set Conn = nothing
%>
<link rel="stylesheet" href="/exec/editor/css/contents4view.css" type="text/css">
<link rel="stylesheet" href="/exec/editor/css/highslide.css" type="text/css">
<script src="/exec/editor/js/highslide.js" type="text/javascript"></script>
<div class="biz_biz1">
	<div class="container">
		<% If InStr(URL,"/admin/") = 0 Then %>
			<div class="sub-title">일정</div>
			<div class="sub-stitle">울산과학기술원의 일정을 알려드립니다.</div>
		<%End If%>
		<div class="news_view">
			<div class="tit">
				<%=B_TITLE%>
				<div class="info">
					<span><%=B_WDATE%></span>
				</div>
			</div>
			<div class="cont">
				<div class="real"><%=B_CONT%></div>
				<%If B_FILE_NAME <> "" Then%>
					<div class="file"><a href="/exec/file/download.asp?filepath=/file/board&filename=<%=Server.URLPathEncode(B_FILE_NAME)%>"><%=B_FILE_NAME%></a></div>
				<%End If%>
			</div>
		</div>
		<div class="board_form_btn">
			<input type="button" value="목록보기" onclick="<%=List_Script%>">
		</div>
	</div>
</div>
<% If (WRITE_BTN <> "0" OR BC_PRINT = "1") And InStr(URL,"/admin/") > 0 Then %>
<div class="board-view-foot">
<% If WRITE_BTN <> "0" Then %>
	<a class='btn btn-default' href="javascript:<%=Edit_Script%>">수정</a>
	<a class='btn btn-default' href="javascript:<%=Del_Script%>">삭제</a>
<% End If %>
</div>
<% End If %>
<%If InStr(URL,"/admin/") > 0 Then%>
<div class="tRight" style="margin-top:20px;">
	<a class="btn btn-default" href="javascript:<%=List_Script%>">목록</a>
	<% If WRITE_BTN <> "0" Then %>
	<a class="btn btn-default" href="javascript:<%=Write_Script%>">글쓰기</a>
	<% End If %>
</div>
<%End If%>
</form>

<br style="line-height:30px" />

<script language="javascript">
<!--
  function board_del(){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.location.href = "<%=ActBUrl%>?action=board&self_url=<%=SelfUrl & Replace(PageQuery,"&","|")%>&bc_seq=<%=BC_SEQ%>&b_cate=<%=B_CATE%>&method=delete&b_seq=<%=B_SEQ%>";
    }else{
      return;
    }
  }
-->
</script>
