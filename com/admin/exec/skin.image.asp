<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE

   Dim CMS_IMAGE_LST_Table
   CMS_IMAGE_LST_Table = "CMS_IMAGE_LST"

   Dim CI_SEQ,CI_CODE,CI_NAME,CI_FILE,CI_WIDTH,CI_HEIGHT,CI_WDATE,CI_MDATE,CI_STATE,ADM_SEQ

   PRO_METHOD = Trim(Request("method"))

   CI_SEQ = Trim(Request("ci_seq"))
   'CI_CODE = Replace(Trim(Request.form("ci_code")),"'","''")
   CI_NAME = Replace(Trim(Request.form("ci_name")),"'","''")
   'CI_FILE = Trim(Request.Form("ci_file"))
   CI_DESCRIPTION = Replace(Trim(Request.form("ci_description")),"'","''")
   'CI_WIDTH = Trim(Request.Form("ci_width"))
   'CI_HEIGHT = Trim(Request.Form("ci_height"))
   CI_WDATE = NowDate
   CI_MDATE = NowDate
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "modify" : pro_modify
      Case "delete" : pro_delete
   End Select

   Conn.Close
   Set Conn = nothing

   Page_Msg_Parent_ScriptReload MSG

   Sub pro_modify()
      SQL = "UPDATE " & CMS_IMAGE_LST_Table & " SET " _
          & "CI_NAME=N'" & CI_NAME & "', " _
          & "CI_DESCRIPTION=N'" & CI_DESCRIPTION & "', " _
          & "CI_MDATE='" & CI_MDATE & "' " _
          & "WHERE " _
          & "CI_SEQ=" & CI_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "이미지정보를 수정하였습니다."
   End Sub

   Sub pro_delete()
      CI_STATE = "99"

      SQL = "UPDATE " & CMS_IMAGE_LST_Table & " SET " _
          & "CI_MDATE='" & CI_MDATE & "', " _
          & "CI_STATE='" & CI_STATE & "' " _
          & "WHERE " _
          & "CI_SEQ=" & CI_SEQ

      Conn.Execute SQL, ,adCmdText

      WHERE = "CI_SEQ=" & CI_SEQ

      SQL = "SELECT CI_FILE FROM " & CMS_IMAGE_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         CI_FILE = Rs("CI_FILE")
      End If
      Rs.close

      If CI_FILE <> "" Then
         FilePath = Server.Mappath("/file") & "\img\" & CI_FILE

         Delete_File(FilePath)
      End If

      MSG = "이미지를 삭제하였습니다."
   End Sub
%>
