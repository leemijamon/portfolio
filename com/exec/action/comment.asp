<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   rtn_url = Replace(Trim(Request("rtn_url")),"|","&")
   BCM_METHOD = Trim(Request("method"))

   Dim BOARD_COMMENT_LST_Table
   BOARD_COMMENT_LST_Table = "BOARD_COMMENT_LST"

   Dim BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_IP,BCM_WDATE,BCM_MDATE,BCM_STATE,MEM_SEQ,B_SEQ

   BCM_SEQ = Trim(Request("bcm_seq"))
   BCM_PSEQ = Trim(Request.Form("bcm_pseq"))
   BCM_CONT = Replace(Trim(Request.form("bcm_cont")),"'","''")
   BCM_IP = Request.ServerVariables("Remote_Addr")
   BCM_GUEST_NAME = Replace(Trim(Request("bcm_guest_name")),"'","''")
   BCM_GUEST_PWD = Replace(Trim(Request("bcm_guest_pwd")),"'","''")
   BCM_WDATE = NowDate
   BCM_MDATE = NowDate
   BCM_STATE = "00"
   MEM_SEQ = Trim(Request.Form("mem_seq"))
   B_SEQ = Trim(Request.Form("b_seq"))

   If MEM_SEQ = "" Then MEM_SEQ = "NULL"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case BCM_METHOD
      Case "write" : com_write
      Case "edit" : com_edit
      Case "reply" : com_reply
      Case "delete" : com_delete
      Case "passcommdel" : com_guest_delete
   End Select

   Conn.Close
   Set Conn = nothing

   Call Page_ParentReload()
   Response.End

   Sub com_write()
      '글번호 만들기
      Call MAX_ID

      BCM_PSEQ = BCM_SEQ

      SQL = "INSERT INTO " & BOARD_COMMENT_LST_Table _
          & "(BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_IP,BCM_GUEST_NAME,BCM_GUEST_PWD,BCM_WDATE,BCM_MDATE,BCM_STATE,MEM_SEQ,B_SEQ)" _
          & " VALUES (" _
          & BCM_SEQ & "," _
          & BCM_PSEQ & ",'" _
          & BCM_CONT & "','" _
          & BCM_IP & "','" _
          & BCM_GUEST_NAME & "','" _
          & BCM_GUEST_PWD & "','" _
          & BCM_WDATE & "','" _
          & BCM_MDATE & "','" _
          & BCM_STATE & "'," _
          & MEM_SEQ & "," _
          & B_SEQ & ")"

      'response.write SQL
      Conn.Execute SQL, ,adCmdText
   End Sub

   Sub com_edit()
      'F_CNT = int(Trim(Request.Form("f_cnt"))) + 1
      'BCM_CONT = Replace(Trim(Request.form("bcm_cont")(F_CNT)),"'","''")

      SQL = "UPDATE " & BOARD_COMMENT_LST_Table & " SET " _
          & "BCM_CONT='" & BCM_CONT & "', " _
          & "BCM_IP='" & BCM_IP & "', " _
          & "BCM_GUEST_NAME='" & BCM_GUEST_NAME & "', " _
          & "BCM_GUEST_PWD='" & BCM_GUEST_PWD & "', " _
          & "BCM_MDATE='" & BCM_MDATE & "' " _
          & "WHERE " _
          & "BCM_SEQ=" & BCM_SEQ

      Conn.Execute SQL, ,adCmdText
   End Sub

   Sub com_reply()
      '글번호 만들기
      Call MAX_ID

      SQL = "INSERT INTO " & BOARD_COMMENT_LST_Table _
          & "(BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_IP,BCM_GUEST_NAME,BCM_GUEST_PWD,BCM_WDATE,BCM_MDATE,BCM_STATE,MEM_SEQ,B_SEQ)" _
          & " VALUES (" _
          & BCM_SEQ & "," _
          & BCM_PSEQ & ",'" _
          & BCM_CONT & "','" _
          & BCM_IP & "','" _
          & BCM_GUEST_NAME & "','" _
          & BCM_GUEST_PWD & "','" _
          & BCM_WDATE & "','" _
          & BCM_MDATE & "','" _
          & BCM_STATE & "'," _
          & MEM_SEQ & "," _
          & B_SEQ & ")"

      Conn.Execute SQL, ,adCmdText
   End Sub

   Sub com_delete()
      BCM_STATE = "99"

      SQL = "UPDATE " & BOARD_COMMENT_LST_Table & " SET " _
          & "BCM_MDATE='" & BCM_MDATE & "', " _
          & "BCM_STATE='" & BCM_STATE & "' " _
          & "WHERE " _
          & "BCM_SEQ=" & BCM_SEQ

      Conn.Execute SQL, ,adCmdText
   End Sub

   Sub com_guest_delete()
      SQL = "SELECT * FROM " & BOARD_COMMENT_LST_Table & " WHERE BCM_SEQ=" & BCM_SEQ & " AND BCM_GUEST_PWD='" & BCM_GUEST_PWD & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         PassCheck = "Y"
      End If
      Rs.close

      If PassCheck = "Y" Then
         rtn_url = Replace(rtn_url,"method=passcommdel","method=view")

         BCM_STATE = "99"

         SQL = "UPDATE " & BOARD_COMMENT_LST_Table & " SET " _
             & "BCM_MDATE='" & BCM_MDATE & "', " _
             & "BCM_STATE='" & BCM_STATE & "' " _
             & "WHERE " _
             & "BCM_PSEQ=" & BCM_SEQ

         Conn.Execute SQL, ,adCmdText
      End If
   End Sub

   Sub MAX_ID()
      SQL = "SELECT MAX(BCM_SEQ) AS MAX_SEQ FROM " & BOARD_COMMENT_LST_Table

      Set Rs = Conn.Execute(SQL, ,adCmdText)
      BCM_SEQ = Rs("MAX_SEQ")
      If IsNULL(BCM_SEQ) Then BCM_SEQ = 0
      BCM_SEQ = BCM_SEQ + 1
      Rs.close
   End Sub
%>
