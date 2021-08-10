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

   Dim FAQ_LST_Table
   FAQ_LST_Table = "FAQ_LST"

   Dim F_SEQ,F_TYPE,F_TITLE,F_CONT,F_READCNT,F_DISP,F_SORT,F_WDATE,F_MDATE,F_STATE
   Dim ADM_SEQ

   F_SEQ = Trim(Request("f_seq"))
   F_TYPE = Trim(Request.Form("f_type"))
   F_TITLE = Replace(Trim(Request.Form("f_title")),"'","''")
   F_CONT = Replace(Trim(Request.Form("content")),"'","''")
   F_READCNT = 0
   F_DISP = Trim(Request.Form("f_disp"))
   F_SORT = Trim(Request.Form("f_sort"))
   F_WDATE = NowDate
   F_MDATE = NowDate
   ADM_SEQ = Trim(Request("adm_seq"))

   If IsNumeric(F_SORT) = false Then F_SORT = 0

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
      Case "sort" : pro_sort
   End Select

   Conn.Close
   Set Conn = nothing

   Sub pro_register()
      F_STATE = "00"

      SQL = "INSERT INTO " & FAQ_LST_Table _
          & " (F_TYPE,F_TITLE,F_CONT,F_READCNT,F_DISP,F_SORT,F_WDATE,F_MDATE,F_STATE,ADM_SEQ)" _
          & " VALUES ('" _
          & F_TYPE & "','" _
          & F_TITLE & "','" _
          & F_CONT & "'," _
          & F_READCNT & ",'" _
          & F_DISP & "'," _
          & F_SORT & ",'" _
          & F_WDATE & "','" _
          & F_MDATE & "','" _
          & F_STATE & "'," _
          & ADM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      Msg = "FAQ를 등록하였습니다."
      AjaxURL Msg, "page/board.faq.asp?f_type=" & F_TYPE
   End Sub

   Sub pro_modify()
      SQL = "UPDATE " & FAQ_LST_Table & " SET " _
          & "F_TYPE='" & F_TYPE & "', " _
          & "F_TITLE='" & F_TITLE & "', " _
          & "F_CONT='" & F_CONT & "', " _
          & "F_DISP='" & F_DISP & "', " _
          & "F_SORT=" & F_SORT & ", " _
          & "F_MDATE='" & F_MDATE & "', " _
          & "ADM_SEQ=" & ADM_SEQ & " " _
          & "WHERE " _
          & "F_SEQ=" & F_SEQ

      Conn.Execute SQL, ,adCmdText

      Msg = "FAQ를 수정하였습니다."
      AjaxURL Msg, "page/board.faq.asp?f_type=" & F_TYPE
   End Sub

   Sub pro_delete()
      F_STATE = "99"

      SQL = "UPDATE " & FAQ_LST_Table & " SET " _
          & "F_MDATE='" & F_MDATE & "', " _
          & "F_STATE='" & F_STATE & "', " _
          & "ADM_SEQ=" & ADM_SEQ & " " _
          & "WHERE " _
          & "F_SEQ=" & F_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "FAQ를 삭제하였습니다."
      AjaxURL Msg, "page/board.faq.asp"
   End Sub

   Sub pro_sort()
      FAQLIST = Trim(Request("items"))
      If FAQLIST <> "" Then
         F_SORT = 0
         SP_SEQ = Split(FAQLIST,",")

         For fn = 0 to UBound(SP_SEQ)
            F_SEQ = trim(Replace(SP_SEQ(fn),"item",""))

            F_SORT = F_SORT + 1

            SQL = "UPDATE " & FAQ_LST_Table & " SET " _
                & "F_SORT=" & F_SORT & " " _
                & "WHERE F_SEQ=" & F_SEQ

            Conn.Execute SQL, ,adCmdText
         Next
      End If
   End Sub
%>
