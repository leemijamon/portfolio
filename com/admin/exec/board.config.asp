<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")
   SERVER_NAME = Request.ServerVariables("SERVER_NAME")

   Dim MSG,GO_PAGE

   PRO_METHOD = Trim(Request("method"))

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_MEMO,BC_READ_MT,BC_WRITE_MT,BC_WDATE,BC_MDATE,BC_STATE,BC_HEADER

   BC_SEQ = Trim(Request("bc_seq"))
   BC_TYPE = Trim(Request.Form("bc_type"))
   BC_SKIN = Trim(Request.Form("bc_skin"))
   BC_CATE = Replace(Trim(Request.form("bc_cate")),"'","''")
   BC_HEADER = Replace(Trim(Request.form("bc_header")),"'","''")
   BC_NAME = Replace(Trim(Request.form("bc_name")),"'","''")
   BC_MEMO = Replace(Trim(Request.form("bc_memo")),"'","''")
   BC_READ_MT = Trim(Request.Form("bc_read_mt"))
   BC_WRITE_MT = Trim(Request.Form("bc_write_mt"))
   BC_REPLY_MT = Trim(Request.Form("bc_reply_mt"))
   BC_COMM_MT = Trim(Request.Form("bc_comm_mt"))
   BC_NOTICE = Trim(Request.Form("bc_notice"))
   BC_SECRET = Trim(Request.Form("bc_secret"))
   BC_COMMENT = Trim(Request.Form("bc_comment"))
   BC_REPLY = Trim(Request.Form("bc_reply"))
   BC_LIST = Trim(Request.Form("bc_list"))
   BC_LIST_CNT = Trim(Request.Form("bc_list_cnt"))
   BC_SYNDI = Trim(Request.Form("bc_syndi"))
   BC_WDATE = NowDate
   BC_MDATE = NowDate
   MEM_SEQ = Trim(Request.Form("mem_seq"))
   If MEM_SEQ = "" Then MEM_SEQ = "NULL"
   ADM_SEQ = Trim(Request.Form("adm_seq"))
   If ADM_SEQ = "" Then ADM_SEQ = "NULL"

   RTNQUERY = Trim(Request.Form("rtnquery"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
   End Select

   Conn.Close
   Set Conn = nothing

   Sub pro_register()
      BC_STATE = "00"

      SQL = "SELECT MAX(BC_SEQ) AS MAX_SEQ FROM " & BOARD_CONFIG_LST_Table
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      BC_SEQ = Rs("MAX_SEQ")
      Rs.close

      If IsNULL(BC_SEQ) Then BC_SEQ = 0
      BC_SEQ = BC_SEQ + 1

      SQL = "INSERT INTO " & BOARD_CONFIG_LST_Table _
          & " (BC_SEQ,BC_TYPE,BC_NAME,BC_SKIN,BC_MEMO,BC_READ_MT,BC_WRITE_MT,BC_REPLY_MT,BC_COMM_MT,BC_CATE,BC_HEADER,BC_NOTICE,BC_SECRET,BC_COMMENT,BC_REPLY,BC_LIST,BC_LIST_CNT,BC_SYNDI,BC_WDATE,BC_MDATE,BC_STATE,MEM_SEQ)" _
          & " VALUES (" _
          & BC_SEQ & ",'" _
          & BC_TYPE & "',N'" _
          & BC_NAME & "',N'" _
          & BC_SKIN & "',N'" _
          & BC_MEMO & "',N'" _
          & BC_READ_MT & "',N'" _
          & BC_WRITE_MT & "',N'" _
          & BC_REPLY_MT & "',N'" _
          & BC_COMM_MT & "',N'" _
          & BC_CATE & "',N'" _
          & BC_HEADER & "','" _
          & BC_NOTICE & "','" _
          & BC_SECRET & "','" _
          & BC_COMMENT & "','" _
          & BC_REPLY & "','" _
          & BC_LIST & "'," _
          & BC_LIST_CNT & ",'" _
          & BC_SYNDI & "','" _
          & BC_WDATE & "','" _
          & BC_MDATE & "','" _
          & BC_STATE & "'," _
          & MEM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      Msg = "게시판을 등록하였습니다."
      'loadURL Msg, "board/config"
      AjaxURL Msg, "page/board.config.asp"
   End Sub

   Sub pro_modify()
      SQL = "UPDATE " & BOARD_CONFIG_LST_Table & " SET " _
          & "BC_TYPE='" & BC_TYPE & "', " _
          & "BC_NAME=N'" & BC_NAME & "', " _
          & "BC_SKIN=N'" & BC_SKIN & "', " _
          & "BC_MEMO=N'" & BC_MEMO & "', " _
          & "BC_READ_MT=N'" & BC_READ_MT & "', " _
          & "BC_WRITE_MT=N'" & BC_WRITE_MT & "', " _
          & "BC_REPLY_MT=N'" & BC_REPLY_MT & "', " _
          & "BC_COMM_MT=N'" & BC_COMM_MT & "', " _
          & "BC_CATE=N'" & BC_CATE & "', " _
          & "BC_HEADER=N'" & BC_HEADER & "', " _
          & "BC_NOTICE='" & BC_NOTICE & "', " _
          & "BC_SECRET='" & BC_SECRET & "', " _
          & "BC_COMMENT='" & BC_COMMENT & "', " _
          & "BC_REPLY='" & BC_REPLY & "', " _
          & "BC_LIST='" & BC_LIST & "', " _
          & "BC_LIST_CNT=" & BC_LIST_CNT & ", " _
          & "BC_SYNDI='" & BC_SYNDI & "', " _
          & "BC_MDATE='" & BC_MDATE & "', " _
          & "BC_STATE='" & BC_STATE & "', " _
          & "MEM_SEQ=" & MEM_SEQ & " " _
          & "WHERE " _
          & "BC_SEQ=" & BC_SEQ

      Conn.Execute SQL, ,adCmdText

      'response.write SQL
      'response.end

      Msg = "게시판을 수정하였습니다."
      'loadURL Msg, "board/config"
      AjaxURL Msg, "page/board.config.asp?" & RTNQUERY
   End Sub

   Sub pro_delete()
      BC_STATE = "99"

      SQL = "UPDATE " & BOARD_CONFIG_LST_Table & " SET " _
          & "BC_MDATE='" & BC_MDATE & "', " _
          & "BC_STATE='" & BC_STATE & "' " _
          & "WHERE " _
          & "BC_SEQ=" & BC_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "게시판을 삭제하였습니다."
      'loadURL Msg, "board/config"
      AjaxURL Msg, "page/board.config.asp"
   End Sub
%>