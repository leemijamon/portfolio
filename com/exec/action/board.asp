<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   USER_AGENT = LCase(Request.ServerVariables("HTTP_USER_AGENT"))

   If InStr(USER_AGENT, "bot/") > 0 OR InStr(USER_AGENT, "bots/") > 0 OR InStr(USER_AGENT, "slurp/") > 0 Then Response.end

   SERVER_NAME = Request.ServerVariables("SERVER_NAME")

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim BOARD_LST_Table
   BOARD_LST_Table = "BOARD_LST"

   Dim B_SEQ,B_PTSEQ,B_PSEQ,B_PSORT,B_PDEPTH,B_TITLE,B_CONT,B_FILE_NAME,B_FILE_SIZE,B_READ_CNT
   Dim B_RECO_CNT,B_IP,B_WDATE,B_MDATE,B_STATE,MEM_SEQ,BC_SEQ

   Dim msg,go_script

   rtn_url = Replace(Trim(Request("self_url")),"|","&")
   BC_METHOD = Trim(Request("method"))

   B_SEQ = Trim(Request("b_seq"))
   B_PTSEQ = Trim(Request.Form("b_ptseq"))
   B_PSEQ = Trim(Request.Form("b_pseq"))
   B_PSORT = Trim(Request.Form("b_psort"))
   B_PDEPTH = Trim(Request.Form("b_pdepth"))
   B_NOTICE = Trim(Request.Form("b_notice"))
   B_SECRET = Trim(Request.Form("b_secret"))
   B_CATE = Replace(Trim(Request("b_cate")),"'","''")
   B_HEADER = Replace(Trim(Request.Form("b_header")),"'","''")
   B_TITLE = Replace(Trim(Request.Form("b_title")),"'","''")
   B_CONT = Replace(Trim(Request.Form("bodyhtml")),"'","''")
   B_CONT = Replace(B_CONT, "http://" & SERVER_NAME, "")
   B_TEXT = Replace(Trim(Request.Form("bodytxt")),"'","''")
   B_FILE_NAME = Trim(Request.Form("file_name"))
   B_FILE_SIZE = Trim(Request.Form("file_size"))
   B_EMAIL = Replace(Trim(Request.Form("b_email")),"'","''")
   B_URL = Replace(Trim(Request.Form("b_url")),"'","''")
   If Request.form("b_read_cnt") <> "" Then
      B_READ_CNT = Request.form("b_read_cnt")
   Else
      B_READ_CNT = 0
   End If
   B_RECO_CNT = 0
   B_IP = Request.ServerVariables("Remote_Addr")
   B_GUEST_NAME = Replace(Trim(Request.Form("b_guest_name")),"'","''")
   B_GUEST_PWD = Replace(Trim(Request.Form("b_guest_pwd")),"'","''")
   B_SDATE = Replace(Trim(Request.form("b_sdate")),"-","")
   If Request.form("b_wdate") <> "" Then
      B_WDATE = Replace(Trim(Request.form("b_wdate")),"-","") & "0000"
   Else
      B_WDATE = NowDate
   End If
   B_MDATE = NowDate
   B_STATE = "00"
   MEM_SEQ = Trim(Request.Form("mem_seq"))
   BC_SEQ = Trim(Request("bc_seq"))

   B_ADD1 = Replace(Trim(Request.Form("b_add1")),"'","''")
   B_ADD2 = Replace(Trim(Request.Form("b_add2")),"'","''")
   B_ADD3 = Replace(Trim(Request.Form("b_add3")),"'","''")
   B_ADD4 = Replace(Trim(Request.Form("b_add4")),"'","''")

   If B_FILE_SIZE = "" Then B_FILE_SIZE = "0"
   If MEM_SEQ = "" Then MEM_SEQ = "NULL"

   B_ATTACHIMAGE = Trim(Request.Form("attachimage"))
   B_ATTACHFILE = Trim(Request.Form("attachfile"))

   B_IMAGES = B_ATTACHIMAGE
   B_FILES = B_ATTACHFILE

   If B_TITLE <> "" Then B_TITLE = f_html_title(B_TITLE)

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case BC_METHOD
      Case "write" : board_write
      Case "edit" : board_edit
      Case "reply" : board_reply
      Case "delete" : board_delete
      Case "passlist","passview","passedit" : board_pass
      Case "passdel" : board_pass_delete
      Case "recommend" : board_recommend
   End Select

   If BC_METHOD = "write" OR BC_METHOD = "edit" OR BC_METHOD = "reply" OR BC_METHOD = "delete" OR BC_METHOD = "passdel" Then
      '##네이버
      'Server.Execute("/exec/action/board.syndiping.asp")
   End If

   Conn.Close
   Set Conn = nothing

   '## 수정/삭제권한 체크
   Function board_mt()
      SQL = "SELECT * FROM " & BOARD_LST_Table & " WHERE B_SEQ=" & B_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         B_MEM_SEQ = Rs("MEM_SEQ")
      End If
      Rs.close

      Dim BOARD_CONFIG_LST_Table
      BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

      Dim BC_MEM_SEQ

      SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         BC_MEM_SEQ = Rs("MEM_SEQ")
      End If
      Rs.close

      If IsNULL(B_MEM_SEQ) Then B_MEM_SEQ = ""
      If IsNULL(BC_MEM_SEQ) Then BC_MEM_SEQ = ""
      If IsNull(Session("ADM_SEQ")) Then ADM_SEQ = ""

      If Cstr(BC_MEM_SEQ) = Cstr(Session("MEM_SEQ")) OR Cstr(B_MEM_SEQ) = Cstr(Session("MEM_SEQ")) OR Session("board" & B_SEQ) = Cstr(B_SEQ) OR ADM_SEQ Then
         board_mt = "1"
      Else
         board_mt = "0"
      End If
   End Function

   Sub board_write()
      call files_pro()

      '글번호 만들기
      Call MAX_ID

      B_PTSEQ = B_SEQ
      B_PSEQ = B_SEQ
      B_PSORT = 1
      B_PDEPTH = 0

      SQL = "INSERT INTO " & BOARD_LST_Table _
          & "(B_SEQ,B_PTSEQ,B_PSEQ,B_PSORT,B_PDEPTH,B_NOTICE,B_SECRET,B_CATE,B_HEADER,B_TITLE,B_CONT,B_TEXT,B_FILE_NAME,B_FILE_SIZE,B_EMAIL,B_URL" _
          & ",B_READ_CNT,B_RECO_CNT,B_IP,B_GUEST_NAME,B_GUEST_PWD,B_SDATE,B_IMAGES,B_FILES,B_ADD1,B_ADD2,B_ADD3,B_ADD4,B_WDATE,B_MDATE,B_STATE,MEM_SEQ,BC_SEQ)" _
          & " VALUES (" _
          & B_SEQ & "," _
          & B_PTSEQ & "," _
          & B_PSEQ & "," _
          & B_PSORT & "," _
          & B_PDEPTH & ",'" _
          & B_NOTICE & "','" _
          & B_SECRET & "',N'" _
          & B_CATE & "',N'" _
          & B_HEADER & "',N'" _
          & B_TITLE & "',N'" _
          & B_CONT & "',N'" _
          & B_TEXT & "',N'" _
          & B_FILE_NAME & "'," _
          & B_FILE_SIZE & ",'" _
          & B_EMAIL & "','" _
          & B_URL & "'," _
          & B_READ_CNT & "," _
          & B_RECO_CNT & ",'" _
          & B_IP & "',N'" _
          & B_GUEST_NAME & "',N'" _
          & B_GUEST_PWD & "','" _
          & B_SDATE & "','" _
          & B_IMAGES & "','" _
          & B_FILES & "','" _
          & B_ADD1 & "','" _
          & B_ADD2 & "','" _
          & B_ADD3 & "','" _
          & B_ADD4 & "','" _
          & B_WDATE & "','" _
          & B_MDATE & "','" _
          & B_STATE & "'," _
          & MEM_SEQ & "," _
          & BC_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      msg = "입력이 완료 되었습니다."

      go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','list','','','','');"
   End Sub

   Sub board_reply()
      call files_pro()

      B_PSEQ = B_SEQ

      '글번호 만들기
      Call MAX_ID

      '최상위번호 같은 것중 받은 번호순서 보다 큰거는 + 1
      SQL = "UPDATE " & BOARD_LST_Table & " SET " _
          & "B_PSORT = B_PSORT + 1 " _
          & "WHERE B_PTSEQ=" & B_PTSEQ & " AND B_PSORT > " & B_PSORT

      Conn.Execute SQL, ,adCmdText

      B_PSORT = int(B_PSORT) + 1
      B_PDEPTH = int(B_PDEPTH) + 1

      SQL = "INSERT INTO " & BOARD_LST_Table _
          & "(B_SEQ,B_PTSEQ,B_PSEQ,B_PSORT,B_PDEPTH,B_SECRET,B_CATE,B_HEADER,B_TITLE,B_CONT,B_TEXT,B_FILE_NAME,B_FILE_SIZE,B_EMAIL,B_URL,B_READ_CNT,B_RECO_CNT,B_IP,B_GUEST_NAME,B_GUEST_PWD,B_IMAGES,B_FILES,B_WDATE,B_MDATE,B_STATE,MEM_SEQ,BC_SEQ)" _
          & " VALUES (" _
          & B_SEQ & "," _
          & B_PTSEQ & "," _
          & B_PSEQ & "," _
          & B_PSORT & "," _
          & B_PDEPTH & ",'" _
          & B_SECRET & "',N'" _
          & B_CATE & "',N'" _
          & B_HEADER & "',N'" _
          & B_TITLE & "',N'" _
          & B_CONT & "',N'" _
          & B_TEXT & "',N'" _
          & B_FILE_NAME & "'," _
          & B_FILE_SIZE & ",'" _
          & B_EMAIL & "','" _
          & B_URL & "'," _
          & B_READ_CNT & "," _
          & B_RECO_CNT & ",'" _
          & B_IP & "',N'" _
          & B_GUEST_NAME & "',N'" _
          & B_GUEST_PWD & "','" _
          & B_IMAGES & "','" _
          & B_FILES & "','" _
          & B_WDATE & "','" _
          & B_MDATE & "','" _
          & B_STATE & "'," _
          & MEM_SEQ & "," _
          & BC_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      msg = "입력이 완료 되었습니다."

      go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','list','','','','');"
   End Sub

   Sub board_edit()
      If board_mt <> "1" Then
         msg = "수정 권한이 없습니다."
         go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
         Exit Sub
      End If

      call files_pro()

      Session("board" & B_SEQ) = ""

      SQL = "UPDATE " & BOARD_LST_Table & " SET " _
          & "B_NOTICE='" & B_NOTICE & "', " _
          & "B_SECRET='" & B_SECRET & "', " _
          & "B_CATE=N'" & B_CATE & "', " _
          & "B_HEADER=N'" & B_HEADER & "', " _
          & "B_TITLE=N'" & B_TITLE & "', " _
          & "B_CONT=N'" & B_CONT & "', " _
          & "B_TEXT=N'" & B_TEXT & "', " _
          & "B_FILE_NAME=N'" & B_FILE_NAME & "', " _
          & "B_FILE_SIZE=" & B_FILE_SIZE & ", " _
          & "B_EMAIL='" & B_EMAIL & "', " _
          & "B_URL='" & B_URL & "', " _
          & "B_GUEST_NAME=N'" & B_GUEST_NAME & "', " _
          & "B_GUEST_PWD=N'" & B_GUEST_PWD & "', " _
          & "B_SDATE='" & B_SDATE & "', " _
          & "B_IMAGES='" & B_IMAGES & "', " _
          & "B_FILES='" & B_FILES & "', " _
          & "B_ADD1='" & B_ADD1 & "', " _
          & "B_ADD2='" & B_ADD2 & "', " _
          & "B_ADD3='" & B_ADD3 & "', " _
          & "B_ADD4='" & B_ADD4 & "', " _
          & "B_MDATE='" & B_MDATE & "' " _
          & "WHERE " _
          & "B_SEQ=" & B_SEQ

      Conn.Execute SQL, ,adCmdText

      msg = "수정이 완료 되었습니다."
      go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
   End Sub

   Sub board_delete()
      If board_mt <> "1" Then
         msg = "삭제 권한이 없습니다."
         go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','list','','','','');"
         Exit Sub
      End If

      call board_delete_files_pro()

      B_STATE = "99"

      SQL = "UPDATE " & BOARD_LST_Table & " SET " _
          & "B_MDATE='" & B_MDATE & "', " _
          & "B_STATE='" & B_STATE & "' " _
          & "WHERE " _
          & "B_PTSEQ=" & B_SEQ & " OR B_SEQ=" & B_SEQ

      Conn.Execute SQL, ,adCmdText

      msg = "글이 삭제 되었습니다."
      go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','list','','','','');"
   End Sub

   Sub board_recommend()
      If Session("boardreco" & B_SEQ) <> B_SEQ Then
         SQL = "UPDATE " & BOARD_LST_Table & " SET " _
             & "B_RECO_CNT=B_RECO_CNT + 1 " _
             & "WHERE B_SEQ=" & B_SEQ

         Conn.Execute SQL, ,adCmdText

         Session("boardreco" & B_SEQ) = B_SEQ
      End If

      go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
   End Sub

   Sub board_pass()
      SQL = "SELECT * FROM " & BOARD_LST_Table & " WHERE B_SEQ=" & B_SEQ & " AND B_GUEST_PWD='" & B_GUEST_PWD & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Session("board" & B_SEQ) = B_SEQ
         PassCheck = "Y"
      End If
      Rs.close

      If BC_METHOD = "passlist" Then
         If PassCheck <> "Y" Then
            msg = "인증에 실패하였습니다."
            go_script = "parent.nopass();"
         Else
            go_script = "parent.goboardmethod('view'," & B_SEQ & ");"
            'go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','list','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
         End If
      End If

      If BC_METHOD = "passview" Then
         If PassCheck = "Y" Then
            go_script = "parent.goboardmethod('view'," & B_SEQ & ");"
            'go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','view','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
         Else
            msg = "인증에 실패하였습니다."
            go_script = "parent.nopass();"
         End If
      End If
      If BC_METHOD = "passedit" Then
         If PassCheck = "Y" Then
            go_script = "parent.goboardmethod('edit');"
         Else
            msg = "인증에 실패하였습니다."
            go_script = "parent.nopass();"
         End If
      End If
   End Sub

   Sub board_pass_delete()
      SQL = "SELECT * FROM " & BOARD_LST_Table & " WHERE B_SEQ=" & B_SEQ & " AND B_GUEST_PWD='" & B_GUEST_PWD & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Session("board" & B_SEQ) = B_SEQ
         PassCheck = "Y"
      End If
      Rs.close

      If PassCheck = "Y" Then
         B_STATE = "99"

         SQL = "UPDATE " & BOARD_LST_Table & " SET " _
             & "B_MDATE='" & B_MDATE & "', " _
             & "B_STATE='" & B_STATE & "' " _
             & "WHERE " _
             & "B_PTSEQ=" & B_SEQ & " OR B_SEQ=" & B_SEQ

         Conn.Execute SQL, ,adCmdText

         msg = "글이 삭제 되었습니다."

         call board_delete_files_pro()
         go_script = "parent.goboardmethod('list');"
         'go_script = "goBoard('" & rtn_url & "','" & BC_SEQ & "','" & B_CATE & "','list','','','','');"
      Else
         msg = "인증에 실패하였습니다."
         go_script = "parent.nopass();"
      End If
   End Sub

   Sub MAX_ID()
      SQL = "SELECT MAX(B_SEQ) AS MAX_SEQ FROM " & BOARD_LST_Table

      Set Rs = Conn.Execute(SQL, ,adCmdText)
      B_SEQ = Rs("MAX_SEQ")
      If IsNULL(B_SEQ) Then B_SEQ = 0
      B_SEQ = B_SEQ + 1
      Rs.close
   End Sub

   Sub board_delete_files_pro()
      SQL = "UPDATE " & BOARD_LST_Table & " SET " _
          & "B_IMAGES=Replace(B_IMAGES,'yes','no'), " _
          & "B_FILES=Replace(B_FILES,'yes','no') " _
          & "WHERE " _
          & "B_PTSEQ=" & B_SEQ & " OR B_SEQ=" & B_SEQ

      Conn.Execute SQL, ,adCmdText

      SQL = "SELECT B_IMAGES,B_FILES FROM " & BOARD_LST_Table & " WHERE B_PTSEQ=" & B_SEQ & " OR B_SEQ=" & B_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            B_ATTACHIMAGE = Rs("B_IMAGES")
            B_ATTACHFILE = Rs("B_FILES")

            Call files_pro()

            Rs.MoveNext
         Loop
      End If
      Rs.close
   End Sub

   Sub files_pro()
      B_UPLOADPATH = Trim(Request("up_dir"))
      If B_UPLOADPATH = "" Then B_UPLOADPATH = "/file/board"
      DirectoryPath = server.mappath("/") & Replace(B_UPLOADPATH,"/","\")

      S_ATTACHIMAGES = Split(B_ATTACHIMAGE, ",")

      If UBound(S_ATTACHIMAGES) > 0 Then
         For i = 0 To UBound(S_ATTACHIMAGES)
            S_ATTACHIMAGE = Split(trim(S_ATTACHIMAGES(i)), "|")
            If UBound(S_ATTACHIMAGE) > 0 Then
               If S_ATTACHIMAGE(UBound(S_ATTACHIMAGE)) = "no" Then
                  DeletePath = DirectoryPath & "\" & S_ATTACHIMAGE(1)
                  Call Delete_File(DeletePath)
                  B_ATTACHIMAGE = Replace(B_ATTACHIMAGE, S_ATTACHIMAGES(i), "")
               End If
            End If
         Next
      End If

      S_ATTACHFILES = Split(B_ATTACHFILE, ",")

      If UBound(S_ATTACHFILES) > 0 Then
         For i = 0 To UBound(S_ATTACHFILES)
            S_ATTACHFILE = Split(trim(S_ATTACHFILES(i)), "|")
            If UBound(S_ATTACHFILE) > 0 Then
               If S_ATTACHFILE(UBound(S_ATTACHFILE)) = "no" Then
                  DeletePath = DirectoryPath & "\" & S_ATTACHFILE(1)
                  Call Delete_File(DeletePath)
                  B_ATTACHFILE = Replace(B_ATTACHFILE, S_ATTACHFILES(i), "")
               End If
            End If
         Next
      End If

      B_IMAGES = B_ATTACHIMAGE
      B_FILES = B_ATTACHFILE
   End Sub

   Sub Delete_File(file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      If (fso.FileExists(file)) Then
         fso.DeleteFile(file)
      End If
   End Sub
%>
<script language="javascript" src="/exec/js/scripts.js"></script>

<script language='javascript'>
<!--
<% If msg <> "" Then %>alert("<%=msg%>");<% End If %>
<% If go_script <> "" Then %>
<%=go_script%>
<% End If %>
//-->
</script>
