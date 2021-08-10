<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

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
      BC_LIST = Rs("BC_LIST")
      BC_MEM_SEQ = Rs("MEM_SEQ")
   End If
   Rs.close

   WRITE_BTN = "1"

   If BC_WRITE_MT = "00" AND MEM_LEVEL <> "00" AND Cstr(BC_MEM_SEQ) <> Cstr(MEM_SEQ) Then WRITE_BTN = "0"

   If IsNULL(BC_SKIN) OR BC_SKIN = "" Then BC_SKIN = "default"

   If BC_SKIN = "userskin" Then
      SKIN_PATH = "/skin/" & SKIN & "/board"
   Else
      SKIN_PATH = "/exec/board/" & BC_SKIN
   End If

   If URL = "" OR InStr(URL,"/admin/") > 0 Then
      SelfUrl = Request.ServerVariables("URL")
      ActBUrl = "/exec/action/board.asp"
      ActCUrl = "/exec/action/comment.asp"
   Else
      SelfUrl = "/" & URL
      ActBUrl = "/" & URL
      ActCUrl = "/" & URL
   End If

   '조회수 UPDATE
   SQL = "UPDATE " & BOARD_LST_Table & " SET " _
       & "B_READ_CNT=B_READ_CNT + 1 " _
       & "WHERE B_SEQ=" & B_SEQ

   Conn.Execute SQL, ,adCmdText

   SQL = "SELECT *, MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=BOARD_LST.MEM_SEQ) FROM " & BOARD_LST_Table _
       & " WHERE B_STATE < '90' AND B_SEQ=" & B_SEQ

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
      B_ADD4 = Rs("B_ADD4")

      If IsNULL(B_MEM_SEQ) Then
         B_MEM_SEQ = 0
         B_MEM_NAME = Rs("B_GUEST_NAME")
         'B_GUEST_PWD = Rs("B_GUEST_PWD")
      End If

      If B_HEADER <> "" Then B_TITLE = "[" & B_HEADER & "] " & B_TITLE

      If BC_SECRET = "1" AND Cstr(BC_MEM_SEQ) <> Cstr(MEM_SEQ) AND Cstr(B_MEM_SEQ) <> Cstr(MEM_SEQ) Then B_MEM_NAME = Left(B_MEM_NAME,1) & "****"

      If B_FILE_NAME <> "" AND BC_TYPE < "02" Then B_FILE_LINK = "<a href='/exec/file/download.asp?filepath=/file/board&filename=" & B_FILE_NAME & "' class=p11>" & B_FILE_NAME & "&nbsp;(" & f_size(B_FILE_SIZE) & ")</a>&nbsp;&nbsp;"

      If BC_TYPE = "02" OR BC_TYPE = "03" Then
         If B_FILE_NAME <> "" Then B_FILE_VIEW = "<img src='/file/board/" & B_FILE_NAME & "' style='cursor:hand;' onclick=openImage('/file/board/" & B_FILE_NAME & "');><br>"
      End If
   Else
      with response
         .write "<script language='javascript'>" & vbNewLine
         .write "  alert('게시글 정보를 찾을 수 없습니다.');" & vbNewLine
         .write "  history.back();" & vbNewLine
         .write "</script>" & vbNewLine
      End with
      response.end
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

   List_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','list','" & page & "','','" & search_key & "','" & search_word & "');"

   '## 읽기권한 체크
   If B_SECRET = "1" Then
      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("board" & B_PTSEQ) = Cstr(B_PTSEQ) Then
      Else
         Page_Msg_Back "읽기 권한이 없습니다."
         response.end
      End If
   Else
      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_READ_MT) OR Session("board" & B_PSEQ) = Cstr(B_PSEQ) Then
      Else
         Page_Msg_Back "읽기 권한이 없습니다."
         response.end
      End If
   End If

   '## 쓰기권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_WRITE_MT) Then
      Write_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','write','','','','');"
   Else
      Write_Script = "alert('글쓰기 권한이 없습니다.');"
   End If

   '## 답글쓰기권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_REPLY_MT) Then
      Reply_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','reply','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
   Else
      Reply_Script = "alert('글쓰기 권한이 없습니다.');"
   End If

   '## 수정/삭제권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("board" & B_SEQ) = Cstr(B_SEQ) Then
      Edit_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','edit','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
      Del_Script = "board_del();"
   Else
      If B_MEM_SEQ = 0 Then
         Edit_Script = "pass('passedit');"
         Del_Script = "pass('passdel');"
      Else
         Edit_Script = "alert('회원님은 수정권한이 없습니다.');"
         Del_Script = "alert('회원님은 삭제권한이 없습니다.');"
      End If
   End If

   '## 쓰기권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_COMM_MT) Then
      Comm_Write_Script = "comm_write();"
   Else
      Comm_Write_Script = "alert('글쓰기 권한이 없습니다.');"
   End If

   If BC_COMMENT = "1" Then
      SQL = "SELECT *, MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=BOARD_COMMENT_LST.MEM_SEQ) FROM " & BOARD_COMMENT_LST_Table _
          & " WHERE BCM_STATE < '90' AND B_SEQ=" & B_SEQ & " ORDER BY BCM_PSEQ, BCM_SEQ"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      i = 0
      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            BCM_SEQ = Rs("BCM_SEQ")
            BCM_PSEQ = Rs("BCM_PSEQ")
            BCM_CONT = Rs("BCM_CONT")
            BCM_WDATE = Rs("BCM_WDATE")
            BCM_MEM_SEQ = Rs("MEM_SEQ")
            BCM_MEM_NAME = Rs("MEM_NAME")

            If IsNULL(BCM_MEM_SEQ) Then
               BCM_MEM_SEQ = 0
               BCM_MEM_NAME = Rs("BCM_GUEST_NAME")
            End If

            COMM_LIST = COMM_LIST & comm_box(i,BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_WDATE,BCM_MEM_SEQ,BCM_MEM_NAME)

            i = i + 1
            Rs.MoveNext
         Loop
      End If
      Rs.close
   End If

   Function comm_box(BCM_NUM,BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_WDATE,BCM_MEM_SEQ,BCM_MEM_NAME)
      'If BCM_WDATE > PreDate Then BTN_IMG = BTN_IMG & " <img src='" & SKIN_PATH & "/img/new2.gif' border='0' align='absmiddle'>"

      BTN_IMG = ""
      If BCM_SEQ = BCM_PSEQ Then BTN_IMG = BTN_IMG & " <a href=""javascript:comm_reply(" & BCM_PSEQ & ");"">Reply</a>"

      If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(BCM_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("comment" & BCM_SEQ) = Cstr(BCM_SEQ) Then
         If Cstr(BCM_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("comment" & BCM_SEQ) = Cstr(BCM_SEQ) Then BTN_IMG = BTN_IMG & " <a href=""javascript:comm_edit(" & BCM_SEQ & ");"">Edit</a>"
         BTN_IMG = BTN_IMG & " <a href=""javascript:comm_del(" & BCM_SEQ & ");"">Del</a>"
      Else
         If BCM_MEM_SEQ = 0 Then
            BTN_IMG = BTN_IMG & " <a href=""javascript:comm_pass('passcommdel','" & BCM_SEQ & "');"">del</a>"
         End If
      End If

      If BTN_IMG <> "" Then BTN_IMG = " / " & BTN_IMG

      E_CONT = BCM_CONT
      E_CONT = Replace(E_CONT,"&","&amp;")
      E_CONT = replace(E_CONT, chr(34), "&quot;")
      E_CONT = Replace(E_CONT,"<","&lt;")
      E_CONT = Replace(E_CONT,">","&gt;")

      If BCM_SEQ = BCM_PSEQ Then
         Box_html = Box_html & "  <div class='media'>" & vbNewLine
      Else
         Box_html = Box_html & "  <div class='media sub-comments'>" & vbNewLine
      End If
      Box_html = Box_html & "    <div class='media-body'>" & vbNewLine
      Box_html = Box_html & "      <div class='media-heading'><i class='fa fa-user'></i> " & BCM_MEM_NAME & " <span>" & Replace(f_chang_date(BCM_WDATE),"/",".") & BTN_IMG & "</span></div>" & vbNewLine
      Box_html = Box_html & "      <p>" & BCM_CONT & "</p>" & vbNewLine
      Box_html = Box_html & "    </div>" & vbNewLine
      Box_html = Box_html & "    <hr>" & vbNewLine
      Box_html = Box_html & "  </div>" & vbNewLine

      comm_box = Box_html
   End Function

   If BC_LIST <> "1" Then
      WHERE = "B_STATE < '90' AND BC_SEQ=" & BC_SEQ
      If B_CATE <> "" Then WHERE = WHERE & " AND B_CATE = '" & B_CATE & "'"

      If search_key <> "" AND search_word <> "" Then
         If search_key = "b_total" Then
            WHERE = WHERE & " AND (B_TITLE LIKE '%" & search_word & "%' OR B_CONT LIKE '%" & search_word & "%')"
         Else
            WHERE = WHERE & " AND " & search_key & " LIKE '%" & search_word & "%'"
         End If
      End If

      'If search_key <> "" AND search_word <> "" Then WHERE = WHERE & " AND " & search_key & " LIKE '%" & search_word & "%'"

      SQL = "SELECT COUNT(*) AS B_CNT FROM " & BOARD_LST_Table & " WHERE " & WHERE & " AND B_PTSEQ=" & B_PTSEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      B_CNT = Rs("B_CNT")
      If IsNULL(B_CNT) Then B_CNT = 0
      Rs.close

      If B_CNT > 1 Then
         SQL = "SELECT MAX(B_PSORT) AS MAX_SEQU FROM " & BOARD_LST_Table & " WHERE " & WHERE & " AND B_PTSEQ=" & B_PTSEQ
         Set Rs = Conn.Execute(SQL, ,adCmdText)
         MAX_SEQU = Rs("MAX_SEQU")
         If IsNULL(MAX_SEQU) Then MAX_SEQU = 0
         Rs.close
      End If

      If B_CNT > 1 Then
         If B_PSORT = 1 Then
            PREV_WHERE = " AND B_PTSEQ > " & B_PTSEQ
         Else
            PREV_WHERE = " AND B_PTSEQ >= " & B_PTSEQ & " AND B_PSORT < " & B_PSORT
         End If

         If B_PSORT < MAX_SEQU Then
            NEXT_WHERE = " AND B_PTSEQ <= " & B_PTSEQ & " AND B_PSORT > " & B_PSORT
         Else
            NEXT_WHERE = " AND B_PTSEQ < " & B_PTSEQ
         End If
      Else
         PREV_WHERE = " AND B_PTSEQ > " & B_PTSEQ
         NEXT_WHERE = " AND B_PTSEQ < " & B_PTSEQ
      End If

      SQL = "SELECT TOP 1 B_SEQ,B_TITLE,B_WDATE FROM " & BOARD_LST_Table _
          & " WHERE " & WHERE & PREV_WHERE _
          & " ORDER BY B_PTSEQ ASC, B_PSORT DESC"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         BACK_LINK = "javascript:goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & Rs("B_SEQ") & "','" & search_key & "','" & search_word & "');"
         BACK_TITLE = "<strong>이전글</strong><span>" & Rs("B_TITLE") & "</span><span>" & f_chang_date(Rs("B_WDATE")) & "</span>"
      Else
         BACK_LINK = "#"
         BACK_TITLE = "<strong>이전글</strong><span>이전 목록이 없습니다.</span>"
      End If
      Rs.close

      SQL = "SELECT TOP 1 B_SEQ,B_TITLE,B_WDATE FROM " & BOARD_LST_Table _
          & " WHERE " & WHERE & NEXT_WHERE _
          & " ORDER BY B_PTSEQ DESC, B_PSORT ASC"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         NEXT_LINK = "javascript:goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & Rs("B_SEQ") & "','" & search_key & "','" & search_word & "');"
         NEXT_TITLE = "<strong>다음글</strong><span>" & Rs("B_TITLE") & "</span><span>" & f_chang_date(Rs("B_WDATE")) & "</span>"
      Else
         NEXT_LINK = "#"
         NEXT_TITLE = "<strong>다음글</strong><span>다음 목록이 없습니다.</span>"
      End If
      Rs.close
   End If

   '### 파일사이즈
   Function f_size(size)
      If int(size) < 1024 Then
         f_size = size & " Byte"
      ElseIf int(size) < 1024 * 1024 Then
         f_size = Round((size/1024),2) & " KB"
      Else
         f_size = Round((size/(1024 * 1024)),2) & " MB"
      End If
   End Function

   Conn.Close
   Set Conn = nothing

   With response
      .write "<div class='board-view'>" & vbNewLine
      .write "  <h2>" & B_TITLE & "</h2>" & vbNewLine
      .write "  <div class='board-view-tags'>" & vbNewLine
      .write "    <ul class='list-unstyled list-inline board-view-info'>" & vbNewLine
      .write "      <li><i class='fa fa-user'></i> " & B_MEM_NAME & "</li>" & vbNewLine
      .write "      <li><i class='fa fa-calendar'></i> " & B_WDATE & "</li>" & vbNewLine
      .write "      <li><i class='fa fa-check-square'></i> " & B_READ_CNT & "</li>" & vbNewLine
      If B_FILE_LINK <> "" Then .write "      <li><i class='fa fa-file'></i> " & B_FILE_LINK & "</li>" & vbNewLine
      .write "    </ul>" & vbNewLine
      .write "  </div>" & vbNewLine

      .write "  <div class='board-view-content'>" & vbNewLine
      .write B_FILE_VIEW
      .write B_CONT
      .write "  </div>" & vbNewLine
      .write "</div>" & vbNewLine
   End With
%>

<% If BC_COMMENT = "1" Then %>

<div class="comments">
  <hr>
<%=COMM_LIST%>
</div>

<div class="board-btn">
  <button type="button" class="btn btn-theme btn-primary" onclick="<%=Comm_Write_Script%>"><i class="fa fa-check"></i> 댓글입력</button>
</div>

<!-- Modal -->
<div class="board-modal modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">댓글 입력</h4>
      </div>
      <div class="modal-body" id="modal-body" style="padding:1px;">

      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="board-modal modal fade" id="passModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">비밀번호 입력</h4>
      </div>
      <div class="modal-body" id="pass-body" style="padding:1px;">

      </div>
    </div>
  </div>
</div>

<% End If %>

<% If WRITE_BTN <> "0" Then %>
<div class="board-btn-mod">
<% If WRITE_BTN <> "0" Then %>
<%If BC_TYPE = "01" AND BC_REPLY = "1" Then %>
  <a class='btn btn-default' href="javascript:<%=Reply_Script%>">답글</a>
<% End If %>
  <a class='btn btn-default' href="javascript:<%=Edit_Script%>">수정</a>
  <a class='btn btn-default' href="javascript:<%=Del_Script%>">삭제</a>
<% End If %>
</div>
<% End If %>

<% If BC_LIST <> "1" Then %>
<ul class="list-unstyled prev-next">
  <li><a href="<%=BACK_LINK%>"><%=BACK_TITLE%></a><i class="fa fa-angle-right"></i></li>
  <li><a href="<%=NEXT_LINK%>"><%=NEXT_TITLE%></a><i class="fa fa-angle-right"></i></li>
</ul>

<div class="board-btn">
  <a class='btn btn-default' href="javascript:<%=List_Script%>">목록보기</a>
<% If WRITE_BTN <> "0" Then %>
  <a class='btn btn-primary' href="javascript:<%=Write_Script%>">글쓰기</a>
<% End If %>
</div>
<% End If %>

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

  function pass(method){
    AjaxloadURL('<%=SKIN_PATH%>/password.asp?acturl=<%=ActCUrl%>&method=' + method + '&b_seq=<%=B_SEQ%>', $('#pass-body'));
    $('#passModal').modal('show');
  }

  function nopass(){
    $('#passModal').modal('hide');
  }

  function goboardmethod(method){
    goBoard('<%=SelfUrl%>','<%=BC_SEQ%>','<%=B_CATE%>',method,'<%=page%>','<%=B_SEQ%>','<%=search_key%>','<%=search_word%>');
  }

<% If BC_COMMENT = "1" Then %>
  function comm_write(){
    AjaxloadURL('<%=SKIN_PATH%>/comment.asp?acturl=<%=ActCUrl%>&method=write&b_seq=<%=B_SEQ%>', $('#modal-body'));
    $('#myModal').modal('show');
  }

  function comm_reply(bcm_pseq){
    AjaxloadURL('<%=SKIN_PATH%>/comment.asp?acturl=<%=ActCUrl%>&method=reply&b_seq=<%=B_SEQ%>&bcm_pseq=' + bcm_pseq, $('#modal-body'));
    $('#myModal').modal('show');
  }

  function comm_edit(bcm_seq){
    AjaxloadURL('<%=SKIN_PATH%>/comment.asp?acturl=<%=ActCUrl%>&method=edit&b_seq=<%=B_SEQ%>&bcm_seq=' + bcm_seq, $('#modal-body'));
    $('#myModal').modal('show');
  }

  function comm_pass(method,bcm_seq){
    AjaxloadURL('<%=SKIN_PATH%>/password.asp?acturl=<%=ActCUrl%>&method=' + method + '&b_seq=<%=B_SEQ%>&bcm_seq=' + bcm_seq, $('#pass-body'));
    $('#passModal').modal('show');
  }

  function comm_del(bcm_seq){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.bframe.location.href = "<%=ActBUrl%>?action=comment&method=delete&bcm_seq=" + bcm_seq;
    }else{
      return;
    }
  }
<% End If %>
-->
</script>

<div style="display:none"><iframe id='bframe' name='bframe' style="width:0px;height:0px;"></iframe></div>
