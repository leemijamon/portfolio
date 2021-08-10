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

   Dim POPUP_LST_Table
   POPUP_LST_Table = "POPUP_LST"

   Dim P_SEQ,P_TITLE,P_CONT,P_READCNT,P_DISP,P_TOP,P_LEFT,P_WHDTH,P_HEIGHT,P_SDATE
   Dim P_EDATE,P_WDATE,P_MDATE,P_STATE,ADM_SEQ

   P_SEQ = Trim(Request("p_seq"))
   P_TYPE = Trim(Request.Form("p_type"))
   P_TITLE = Replace(Trim(Request.form("p_title")),"'","''")
   P_CONT = Replace(Trim(Request.form("content")),"'","''")
   P_CONT = Replace(P_CONT, "http://" & SERVER_NAME, "")
   'P_CONT = Replace(P_CONT,"target=_blank","")
   P_READCNT = 0
   P_DISP = Trim(Request.Form("p_disp"))
   P_TOP = Trim(Request.Form("p_top"))
   P_LEFT = Trim(Request.Form("p_left"))
   P_CENTER = Trim(Request.Form("p_center"))
   P_WHDTH = Trim(Request.Form("p_whdth"))
   P_HEIGHT = Trim(Request.Form("p_height"))
   P_SDATE = Replace(Trim(Request.form("p_sdate")),"-","") & "0000"
   P_EDATE = Replace(Trim(Request.form("p_edate")),"-","") & "0000"
   P_WDATE = NowDate
   P_MDATE = NowDate
   ADM_SEQ = Trim(Request.Form("adm_seq"))
   If ADM_SEQ = "" Then ADM_SEQ = "NULL"

   If P_CENTER = "" Then P_CENTER = "0"

   RTNQUERY = Trim(Request.Form("rtnquery"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "cont" : pro_cont
      Case "delete" : pro_delete
   End Select

   Conn.Close
   Set Conn = nothing

   Sub pro_register()
      P_STATE = "00"

      SQL = "INSERT INTO " & POPUP_LST_Table _
          & " (P_TYPE,P_TITLE,P_CONT,P_READCNT,P_DISP,P_TOP,P_LEFT,P_CENTER,P_WHDTH,P_HEIGHT,P_SDATE,P_EDATE,P_WDATE,P_MDATE,P_STATE)" _
          & " VALUES (N'" _
          & P_TYPE & "',N'" _
          & P_TITLE & "','" _
          & P_CONT & "'," _
          & P_READCNT & ",'" _
          & P_DISP & "'," _
          & P_TOP & "," _
          & P_LEFT & ",'" _
          & P_CENTER & "'," _
          & P_WHDTH & "," _
          & P_HEIGHT & ",'" _
          & P_SDATE & "','" _
          & P_EDATE & "','" _
          & P_WDATE & "','" _
          & P_MDATE & "','" _
          & P_STATE & "')"

      Conn.Execute SQL, ,adCmdText

      Msg = "팝업창을 등록하였습니다."
      AjaxURL Msg, "page/board.popup.asp"
   End Sub

   Sub pro_modify()
      SQL = "UPDATE " & POPUP_LST_Table & " SET " _
          & "P_TYPE=N'" & P_TYPE & "', " _
          & "P_TITLE=N'" & P_TITLE & "', " _
          & "P_CONT='" & P_CONT & "', " _
          & "P_DISP='" & P_DISP & "', " _
          & "P_TOP=" & P_TOP & ", " _
          & "P_LEFT=" & P_LEFT & ", " _
          & "P_CENTER=" & P_CENTER & ", " _
          & "P_WHDTH=" & P_WHDTH & ", " _
          & "P_HEIGHT=" & P_HEIGHT & ", " _
          & "P_SDATE='" & P_SDATE & "', " _
          & "P_EDATE='" & P_EDATE & "', " _
          & "P_MDATE='" & P_MDATE & "' " _
          & "WHERE " _
          & "P_SEQ=" & P_SEQ

      Conn.Execute SQL, ,adCmdText

      Msg = "팝업창을 수정하였습니다."
      AjaxURL Msg, "page/board.popup.asp?" & RTNQUERY
   End Sub

   Sub pro_cont()
      P_CONT = Trim(Request.Form("content"))

      SQL = "UPDATE " & POPUP_LST_Table & " SET " _
          & "P_CONT='" & P_CONT & "' " _
          & "WHERE " _
          & "P_SEQ=" & P_SEQ

      Conn.Execute SQL, ,adCmdText

      Msg = "팝업창을 수정하였습니다."
      AjaxURL Msg, "page/board.popup.asp"
   End Sub

   Sub pro_delete()
      P_STATE = "99"

      SQL = "UPDATE " & POPUP_LST_Table & " SET " _
          & "P_MDATE='" & P_MDATE & "', " _
          & "P_STATE='" & P_STATE & "' " _
          & "WHERE " _
          & "P_SEQ=" & P_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "팝업창을 삭제하였습니다."
      AjaxURL Msg, "page/board.popup.asp"
   End Sub
%>
