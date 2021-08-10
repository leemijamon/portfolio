<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
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

   BC_SEQ = Trim(Request("bc_seq"))
   BC_METHOD = Trim(Request("method"))
   B_CATE = Trim(Request("b_cate"))

   If IsNumeric(BC_SEQ) = false Then Response.End

   search_key = trim(request("search_key"))
   search_word = trim(request("search_word"))
   If search_word <> "" Then search_word = Replace(search_word,"'","")
   If search_word <> "" Then search_word = Replace(search_word,"""","")

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_SEQ = Rs("BC_SEQ")
      BC_TYPE = Rs("BC_TYPE")
      BC_NAME = Rs("BC_NAME")
      BC_SKIN = RS("BC_SKIN")
      BC_CATE = RS("BC_CATE")
      BC_READ_MT = Rs("BC_READ_MT")
      BC_WRITE_MT = Rs("BC_WRITE_MT")
      BC_REPLY_MT = Rs("BC_REPLY_MT")
      BC_COMM_MT = Rs("BC_COMM_MT")
      BC_NOTICE = Rs("BC_NOTICE")
      BC_SECRET = Rs("BC_SECRET")
      BC_COMMENT = Rs("BC_COMMENT")
      BC_REPLY = Rs("BC_REPLY")
      BC_LIST_CNT = Rs("BC_LIST_CNT")
      BC_MEM_SEQ = Rs("MEM_SEQ")
      If IsNULL(BC_MEM_SEQ) Then BC_MEM_SEQ = -1
   End If
   Rs.close

   WRITE_BTN = "1"
   LIST_BTN = "1"
   'If BC_READ_MT <> "00" Then BC_READ_MT = "99"
   'If BC_WRITE_MT <> "00" Then BC_WRITE_MT = "99"
   'If BC_REPLY_MT <> "00" Then BC_REPLY_MT = "99"
   'If BC_COMM_MT <> "00" Then BC_COMM_MT = "99"

   If BC_WRITE_MT = "00" AND MEM_LEVEL <> "00" AND Cstr(BC_MEM_SEQ) <> Cstr(MEM_SEQ) Then WRITE_BTN = "0"

   If IsNULL(BC_SKIN) OR BC_SKIN = "" Then BC_SKIN = "default"
   SKIN_PATH = "/exec/board/" & BC_SKIN

   'response.write URL
   If URL = "" OR InStr(URL,"/admin/") > 0 Then
      SelfUrl = Request.ServerVariables("URL")
   Else
      SelfUrl = "/" & URL
   End If

   List_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','list','','','','');"

   '## 쓰기권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_WRITE_MT) Then
      Write_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','write','','','','');"
   Else
      If Cstr(MEM_LEVEL) = "99" Then
         Write_Script = "not_login('" & LINK_MEM_LOGIN & "','" & Rtn_Page & "');"
      Else
         Write_Script = "alert('글쓰기 권한이 없습니다.');"
      End If
   End If

   Dim page : page = request("page")
   if page = "" then page = 1
   page = int(page)

   Dim pageSize
   Dim recordCount, recentCount

   pageSize = BC_LIST_CNT

   WHERE = "B_STATE < '90' AND BC_SEQ=" & BC_SEQ
   If B_CATE <> "" Then WHERE = WHERE & " AND B_CATE = '" & B_CATE & "'"
   If BC_NOTICE = "1" Then WHERE = WHERE & " AND (B_NOTICE <> '1' OR B_NOTICE IS NULL)"

   If search_key <> "" AND search_word <> "" Then
      If search_key = "b_total" Then
         WHERE = WHERE & " AND (B_TITLE LIKE '%" & search_word & "%' OR B_CONT LIKE '%" & search_word & "%')"
      Else
         WHERE = WHERE & " AND " & search_key & " LIKE '%" & search_word & "%'"
      End If
   End If

   SQL = "SELECT COUNT(*) FROM " & BOARD_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   recordCount = Rs(0)
   Rs.close

   Dim n_from,n_to,s_desc,s_asc,n_range,n_limit
   Dim pageCount : pageCount=int((recordCount-1)/pageSize)+1

   If page > pageCount Then page = pageCount
   If page = 0 Then page = 1

   ORDER_BY = "B_PTSEQ DESC, B_PSORT ASC"

   S_ROWNUM = (page-1) * pageSize + 1
   E_ROWNUM = page * pageSize

   SQL = "SELECT *, " _
       & "MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=T.MEM_SEQ), " _
       & "COMM_CNT = (SELECT COUNT(*) FROM BOARD_COMMENT_LST WHERE BOARD_COMMENT_LST.B_SEQ = T.B_SEQ AND BCM_STATE < '90') " _
       & "FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & BOARD_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   Dim LB_LINK(30)
   Dim LB_NUM(30),LB_TITLE(30),LB_FILE_NAME(30),LB_READ_CNT(30)
   Dim LB_IMG(30),LB_WDATE(30),LB_MEM_SEQ(30),LB_MEM_NAME(30)
   Dim LB_TEXT(30),LB_SDATE(30),LB_ADD1(30),LB_ADD2(30),LB_ADD3(30),LB_ADD4(30),LB_CATE(30)

   DisplayNum = recordCount - (Page-1) * pageSize

   i = 0
   fcnt = 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         TB_SEQ = Rs("B_SEQ")
         TB_PTSEQ = Rs("B_PTSEQ")
         TB_PSEQ = Rs("B_PSEQ")
         TB_PDEPTH = Rs("B_PDEPTH")
         TB_HEADER = Rs("B_HEADER")
         TB_CATE = Rs("B_CATE")
         TB_TITLE = Rs("B_TITLE")
         TB_TEXT = Rs("B_TEXT")
         TB_FILE_NAME = Rs("B_FILE_NAME")
         TB_READ_CNT = Rs("B_READ_CNT")
         TB_IP = Rs("B_IP")
         TB_WDATE = Rs("B_WDATE")
         TB_MEM_SEQ = Rs("MEM_SEQ")
         TB_MEM_NAME = Rs("MEM_NAME")
         TB_COMM_CNT = Rs("COMM_CNT")
         TB_SDATE = trim(Rs("B_SDATE"))
         TB_ADD1 = trim(Rs("B_ADD1"))
         TB_ADD2 = trim(Rs("B_ADD2"))
         TB_ADD3 = trim(Rs("B_ADD3"))
         TB_ADD4 = trim(Rs("B_ADD4"))
         TB_URL = trim(Rs("B_URL"))
         TB_SECRET = trim(Rs("B_SECRET"))

         If Len(TB_TEXT) > 200 Then TB_TEXT = Left(TB_TEXT,200) & ".."

         If IsNULL(TB_MEM_SEQ) Then
            TB_MEM_SEQ = 0
            TB_MEM_NAME = Rs("B_GUEST_NAME")
         End If

         If BC_SECRET = "1" AND Cstr(BC_MEM_SEQ) <> Cstr(MEM_SEQ) AND Cstr(TB_MEM_SEQ) <> Cstr(MEM_SEQ) Then TB_MEM_NAME = Left(TB_MEM_NAME,1) & "****"

         If TB_PDEPTH = 0 Then
            DEPTH_IMG = ""
         Else
            DEPTH_IMG = "<img src='" & SKIN_PATH & "/img/blank.gif' width='" & TB_PDEPTH*10 & "' height='10' border='0'><i class='fa fa-arrow-right'></i>&nbsp;"
         End If

         If TB_SECRET = "1" Then TB_TITLE = TB_TITLE & "<i class='fa fa-unlock-alt'></i>"
         If TB_HEADER <> "" Then TB_TITLE = "[" & TB_HEADER & "] " & TB_TITLE
         If TB_COMM_CNT > 0 Then TB_TITLE = TB_TITLE & " <i class='fa fa-comments'></i> <font size='1' face='Tahoma, 돋움' color='#666666'>[" & TB_COMM_CNT & "]</font>"
         If TB_WDATE > PreDate Then TB_TITLE = TB_TITLE & " <span class='badge badge-u'>New</span>"

         '## 읽기권한 체크
         If TB_SECRET = "1" Then
            If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(TB_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("board" & TB_PTSEQ) = Cstr(TB_PTSEQ) Then
               View_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & TB_SEQ & "','" & search_key & "','" & search_word & "');"
            Else
               If TB_PTSEQ <> TB_SEQ Then
                  View_Script = "pass('passlist','" & TB_SEQ & "');"
               Else
                  View_Script = "pass('passview','" & TB_SEQ & "');"
               End If
            End If
         Else
            If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(TB_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_READ_MT) OR Session("board" & TB_PSEQ) = Cstr(TB_PSEQ) Then
               View_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & TB_SEQ & "','" & search_key & "','" & search_word & "');"
            Else
               If TB_MEM_SEQ = 0 Then
                  View_Script = "pass('passview','" & TB_SEQ & "');"
               Else
                  If Cstr(MEM_LEVEL) = "99" Then
                     View_Script = "not_login('" & link_login & "','" & Rtn_Page & "');"
                  Else
                     View_Script = "alert('읽기 권한이 없습니다.');"
                  End If
               End If
            End If
         End If

         LB_NUM(i) = DisplayNum - i
         LB_TEXT(i) = TB_TEXT

         LB_MEM_SEQ(i) = TB_MEM_SEQ
         LB_MEM_NAME(i) = TB_MEM_NAME
         LB_READ_CNT(i) = FormatNumber(TB_READ_CNT,0)
         LB_WDATE(i) = f_chang_date(TB_WDATE)
         LB_SDATE(i) = f_chang_date(TB_SDATE)
         LB_FILE_NAME(i) = TB_FILE_NAME

         LB_ADD1(i) = TB_ADD1
         LB_ADD2(i) = TB_ADD2
         LB_ADD3(i) = TB_ADD3
         LB_ADD4(i) = TB_ADD4
         LB_CATE(i) = TB_CATE

         If BC_TYPE = "02" OR BC_TYPE = "03" Then
            LB_TITLE(i) = TB_TITLE
         Else
            LB_TITLE(i) = DEPTH_IMG & "<a href=""javascript:" & View_Script & """>" & TB_TITLE & "</a>"
         End If

         LB_LINK(i) = "javascript:" & View_Script

         If TB_FILE_NAME <> "" Then LB_IMG(i) = "<img class='img-responsive' src='/file/board_thumbnail/" & TB_FILE_NAME & "'>" & vbNewLine

         i = i + 1
         fcnt = i

         Rs.MoveNext
      Loop
   End If
   Rs.close

   If BC_NOTICE = "1" AND BC_TYPE = "01" Then
      WHERE = "B_NOTICE = '1' AND B_STATE < '90' AND BC_SEQ=" & BC_SEQ

      SQL = "SELECT *, " _
          & "MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=BOARD_LST.MEM_SEQ), " _
          & "COMM_CNT = (SELECT COUNT(*) FROM BOARD_COMMENT_LST WHERE BOARD_COMMENT_LST.B_SEQ = BOARD_LST.B_SEQ AND BCM_STATE < '90') " _
          & "FROM " & BOARD_LST_Table & " WHERE " & WHERE & " " _
          & "ORDER BY B_SEQ"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      i = 0
      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            TB_SEQ = Rs("B_SEQ")
            TB_PTSEQ = Rs("B_PTSEQ")
            TB_PSEQ = Rs("B_PSEQ")
            TB_PDEPTH = Rs("B_PDEPTH")
            TB_HEADER = Rs("B_HEADER")
            TB_TITLE = Rs("B_TITLE")
            TB_FILE_NAME = Rs("B_FILE_NAME")
            TB_READ_CNT = Rs("B_READ_CNT")
            TB_IP = Rs("B_IP")
            TB_WDATE = Rs("B_WDATE")
            TB_MEM_SEQ = Rs("MEM_SEQ")
            TB_MEM_NAME = Rs("MEM_NAME")
            TB_COMM_CNT = Rs("COMM_CNT")
            TB_SECRET = Rs("B_SECRET")

            If IsNULL(B_MEM_SEQ) Then
               TB_MEM_SEQ = 0
               TB_MEM_NAME = Rs("B_GUEST_NAME")
            End If

            If TB_HEADER <> "" Then TB_TITLE = "[" & TB_HEADER & "] " & TB_TITLE
            If TB_COMM_CNT > 0 Then TB_TITLE = TB_TITLE & " <i class='fa fa-comments'></i> <font size='1' face='Tahoma, 돋움' color='#666666'>[" & TB_COMM_CNT & "]</font>"
            If TB_WDATE > PreDate Then TB_TITLE = TB_TITLE & " <span class='badge badge-u'>New</span>"

            '## 읽기권한 체크
            If TB_SECRET = "1" Then
               If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(TB_MEM_SEQ) = Cstr(MEM_SEQ) OR Session("board" & TB_PTSEQ) = Cstr(TB_PTSEQ) Then
                  View_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & TB_SEQ & "','" & search_key & "','" & search_word & "');"
               Else
                  If TB_PTSEQ <> TB_SEQ Then
                     View_Script = "pass('passlist','" & TB_SEQ & "');"
                  Else
                     View_Script = "pass('passview','" & TB_SEQ & "');"
                  End If
               End If
            Else
               If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(TB_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_READ_MT) OR Session("board" & TB_PSEQ) = Cstr(TB_PSEQ) Then
                  View_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & TB_SEQ & "','" & search_key & "','" & search_word & "');"
               Else
                  If TB_MEM_SEQ = 0 Then
                     View_Script = "pass('passview','" & TB_SEQ & "');"
                  Else
                     If Cstr(MEM_LEVEL) = "99" Then
                        View_Script = "not_login('" & link_login & "','" & Rtn_Page & "');"
                     Else
                        View_Script = "alert('읽기 권한이 없습니다.');"
                     End If
                  End If
               End If
            End If

            'View_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"

            LT_TITLE = "<a href=""javascript:" & View_Script & """>" & B_TITLE & "</a>"

            LT_MEM_SEQ = B_MEM_SEQ
            LT_MEM_NAME = B_MEM_NAME
            LT_READ_CNT = FormatNumber(B_READ_CNT,0)
            LT_WDATE = f_chang_date(B_WDATE)
            LT_FILE_NAME = B_FILE_NAME

            LT_HTML = LT_HTML & "          <tr>" & vbNewLine
            LT_HTML = LT_HTML & "            <td class='hidden-xs'><strong>공지</strong></td>" & vbNewLine
            LT_HTML = LT_HTML & "            <td class='left'><strong>" & LT_TITLE & "</strong></td>" & vbNewLine
            LT_HTML = LT_HTML & "            <td>" & LT_MEM_NAME & "</td>" & vbNewLine
            LT_HTML = LT_HTML & "            <td>" & LT_WDATE & "</td>" & vbNewLine
            LT_HTML = LT_HTML & "            <td class='hidden-xs'>" & LT_READ_CNT & "</td>" & vbNewLine
            LT_HTML = LT_HTML & "          </tr>" & vbNewLine

            i = i + 1

            Rs.MoveNext
         Loop
      End If
      Rs.close
   End If

   If BC_CATE <> "" Then
      With response
         .write "      <ul class='breadcrumb board-cate'>" & vbNewLine
         If InStr(BC_CATE,",") > 0 Then
            BSP_CATE = Split(BC_CATE,",")

            For fn = 0 to UBound(BSP_CATE)
               BS_CATE = trim(BSP_CATE(fn))
               Cate_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & BS_CATE & "','list','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"

               If B_CATE = BS_CATE Then
                  .write "        <li class='active'>" & BS_CATE & vbNewLine
               Else
                  .write "        <li><a href=""javascript:" & Cate_Script & """>" & BS_CATE & "</a>" & vbNewLine
               End If

               'If fn < UBound(BSP_CATE) Then .write "        <span class='divider'>/</span>" & vbNewLine

               .write "        </li>" & vbNewLine
            Next
         Else
            Cate_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & BC_CATE & "','list','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"

            If B_CATE = BS_CATE Then
               .write "        <li class='active'>" & BC_CATE & "</li>" & vbNewLine
            Else
               .write "        <li><a href=""javascript:" & Cate_Script & """>" & BC_CATE & "</a></li>" & vbNewLine
            End If

         End If
         .write "      </ul>" & vbNewLine
      End With
   End If

   With response
      .write "      <div class='board-search'>" & vbNewLine
      .write "        <form name='f_search' method='get' class='form-inline' role='form'>" & vbNewLine
      .write "        <input type='hidden' name='pagenum' value='" & request("pagenum") & "' />" & vbNewLine
      .write "        <input type='hidden' name='item' value='" & request("item") & "' />" & vbNewLine
      .write "        <input type='hidden' name='bc_seq' value='" & BC_SEQ & "' />" & vbNewLine
      .write "        <input type='hidden' name='b_cate' value='" & B_CATE & "' />" & vbNewLine
      .write "        <input type='hidden' name='method' value='list' />" & vbNewLine
      '.write "        <input type='hidden' name='search_key' value='" & request("search_key") & "' />" & vbNewLine

      .write "          <div class='form-group'>" & vbNewLine
      .write "            <select name='search_key' id='search_key' class='form-control'>" & vbNewLine
      .write "              <option value='B_TITLE'>제목</option>" & vbNewLine
      .write "              <option value='B_GUEST_NAME'>작성자</option>" & vbNewLine
      .write "            </select>" & vbNewLine
      .write "            <input type='text' name='search_word' id='search_word' class='form-control' value=""" & search_word & """>" & vbNewLine
      .write "          </div>" & vbNewLine

      .write "          <button type='submit' class='btn btn-default'>Search</button>" & vbNewLine
      .write "        </form>" & vbNewLine
      .write "      </div>" & vbNewLine

   End With

   If BC_TYPE = "01" Then '일반형
      With response
         .write "<div class='table-responsive'>" & vbNewLine

         .write "  <table class='table table-striped'>" & vbNewLine
         .write "    <thead>" & vbNewLine
         .write "      <tr>" & vbNewLine
         .write "        <th class='hidden-xs' width='70'>번호</th>" & vbNewLine
         .write "        <th width='*'>제목</th>" & vbNewLine
         .write "        <th width='95'>등록자</th>" & vbNewLine
         .write "        <th width='95'>등록일</th>" & vbNewLine
         .write "        <th class='hidden-xs' width='80'>조회수</th>" & vbNewLine
         .write "      </tr>" & vbNewLine
         .write "    </thead>" & vbNewLine
         .write "    <tbody>" & vbNewLine

         .write LT_HTML

         For i = 0 to pageSize - 1
            .write "      <tr>" & vbNewLine
            .write "        <td class='hidden-xs'>" & LB_NUM(i) & "</td>" & vbNewLine
            .write "        <td class='left'>&nbsp;" & LB_TITLE(i) & "</td>" & vbNewLine
            .write "        <td>" & LB_MEM_NAME(i) & "</td>" & vbNewLine
            .write "        <td>" & LB_WDATE(i) & "</td>" & vbNewLine
            .write "        <td class='hidden-xs'>" & LB_READ_CNT(i) & "</td>" & vbNewLine
            .write "      </tr>" & vbNewLine
         Next

         .write "    </tbody>" & vbNewLine
         .write "  </table>" & vbNewLine

         .write "</div>" & vbNewLine
      End With
   End If

   If BC_TYPE = "02" OR BC_TYPE = "03" Then '작은이미지,큰이미지
      With response
         .write "<div class='board-box'>" & vbNewLine
         .write "  <ul class='row board-img'>" & vbNewLine

         For i = 0 to pageSize - 1
            If LB_LINK(i) <> "" Then
               If BC_TYPE = "02" Then
                  .write "  <li class='col-md-3 col-sm-6 col-xs-12 box'>" & vbNewLine
               Else
                  .write "  <li class='col-md-4 col-sm-6 col-xs-12 box'>" & vbNewLine
               End If
               .write "    <a href=""" & LB_LINK(i) & """>" & vbNewLine
               .write "      " & LB_IMG(i) & vbNewLine
               .write "      <span class='img-cover'>" & vbNewLine
               .write "        <span>" & LB_TITLE(i) & "</span>" & vbNewLine
               If BC_WRITE_MT <> "00" Then
                 .write "        <p>" & LB_WDATE(i) & " " & LB_MEM_NAME(i) & "</p>" & vbNewLine
               Else
                 .write "        <p>" & LB_WDATE(i) & "</p>" & vbNewLine
               End If
               .write "      </span>" & vbNewLine
               .write "    </a>" & vbNewLine
               .write "  </li>" & vbNewLine
            End If
         Next

         .write "  </ul>" & vbNewLine
         .write "</div>" & vbNewLine
      End With
   End If

   If BC_TYPE = "04" Then '컬럼형
      With response
         For i = 0 to pageSize - 1
            If LB_TITLE(i) <> "" Then
               .write "<hr>" & vbNewLine

               .write "<div class='row board-column'>" & vbNewLine
               If LB_IMG(i) <> "" Then
                  .write "  <div class='col-md-3'>" & vbNewLine
                  .write "    " & LB_IMG(i) & vbNewLine
                  .write "  </div>" & vbNewLine
                  .write "  <div class='col-md-9'>" & vbNewLine
               Else
                  .write "  <div class='col-md-12'>" & vbNewLine
               End If
               .write "    <h2>" & LB_TITLE(i) & "</h2>" & vbNewLine
               .write "    <ul class='list-unstyled list-inline board-column-info'>" & vbNewLine
               .write "      <li><i class='fa fa-calendar'></i> " & LB_WDATE(i) & "</li>" & vbNewLine
               If BC_WRITE_MT <> "00" Then
               .write "      <li><i class='fa fa-user'></i> " & LB_MEM_NAME(i) & "</li>" & vbNewLine
               End If
               .write "    </ul>" & vbNewLine
               .write "    <p>" & LB_TEXT(i) & "</p>" & vbNewLine
               .write "    <p><a class='btn btn-theme' href=""" & LB_LINK(i) & """><i class='fa fa-location-arrow'></i> Read More</a></p>" & vbNewLine
               .write "  </div>" & vbNewLine
               .write "</div>" & vbNewLine
            End If
         Next

         .write "<hr>" & vbNewLine
      End With
   End If

   %><!-- #include virtual = "/exec/board/default/goto_page.inc" --><%

   With response
      .write "<div class='board-page'>" & vbNewLine
      goto_directly page, pagecount, 10
      .write "</div>" & vbNewLine

      .write "<div class='board-btn pull-right'>" & vbNewLine
      If WRITE_BTN <> "0" Then .write "  <button type='button' class='btn btn-primary' onclick=""javascript:" & Write_Script & """>글쓰기</button>" & vbNewLine
      If LIST_BTN <> "0" Then .write "   <button type='button' class='btn btn-default' onclick=""javascript:" & List_Script & """>목록보기</button>" & vbNewLine
      .write "</div>" & vbNewLine
   End With
%>

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

<script language="javascript">
<!--
  function goto(page){
    goBoard('<%=SelfUrl%>','<%=BC_SEQ%>','<%=B_CATE%>','list',page,'','<%=search_key%>','<%=search_word%>');
  }

  function pass(method,b_seq){
    AjaxloadURL('<%=SKIN_PATH%>/password.asp?acturl=<%=ActCUrl%>&method=' + method + '&b_seq=' + b_seq, $('#pass-body'));
    $('#passModal').modal('show');
  }

  function nopass(){
    $('#passModal').modal('hide');
  }

  function goboardmethod(method){
    goBoard('<%=SelfUrl%>','<%=BC_SEQ%>','<%=B_CATE%>',method,'<%=page%>','<%=B_SEQ%>','<%=search_key%>','<%=search_word%>');
  }
-->
</script>