<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   M_NAME = Replace(Trim(Request.form("m_name")),"'","''")
   M_FROM = Replace(Trim(Request.form("m_from")),"'","''")

   M_TITLE = Trim(Request.form("m_title"))
   M_CONT = Trim(Request.form("content"))

   MEM_LEVEL = Trim(Request.form("mem_level"))

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_NAME,MEM_ID,MEM_EMAIL

   If MEM_LEVEL = "99" Then
      M_TEST = Replace(Trim(Request.form("m_test")),"'","''")
      MEM_NAME = "테스트"
      MEM_ID = "test"

      S_TITLE = M_TITLE
      S_CONT = M_CONT

      S_TITLE = Replace(S_TITLE, "{{회원명}}", MEM_NAME)
      S_TITLE = Replace(S_TITLE, "{{아이디}}", MEM_ID)
      S_CONT = Replace(S_CONT, "{{제목}}", S_TITLE)
      S_CONT = Replace(S_CONT, "{{회원명}}", MEM_NAME)
      S_CONT = Replace(S_CONT, "{{아이디}}", MEM_ID)

      mFrom = M_NAME & "<" & M_FROM & ">"
      mTo = M_TEST
      mSubject = S_TITLE
      mbody = S_CONT

      Call Send_Mail(mFrom,mTo,mSubject,mbody)
   Else
      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      SQL = "SELECT MEM_NAME, MEM_ID, MEM_EMAIL FROM " & MEM_LST_Table & " WHERE MEM_EMAIL <> '' AND MEM_EMAIL IS NOT NULL AND MEM_EMAIL_YN='1' AND MEM_STATE < '90'"
      If MEM_LEVEL <> "00" Then SQL = SQL & " AND MEM_LEVEL = '" & MEM_LEVEL & "'"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            MEM_NAME = Rs("MEM_NAME")
            MEM_ID = Rs("MEM_ID")
            MEM_EMAIL = Rs("MEM_EMAIL")

            S_TITLE = M_TITLE
            S_CONT = M_CONT

            S_TITLE = Replace(S_TITLE, "{{회원명}}", MEM_NAME)
            S_TITLE = Replace(S_TITLE, "{{아이디}}", MEM_ID)
            S_CONT = Replace(S_CONT, "{{제목}}", S_TITLE)
            S_CONT = Replace(S_CONT, "{{회원명}}", MEM_NAME)
            S_CONT = Replace(S_CONT, "{{아이디}}", MEM_ID)

            mFrom = M_NAME & "<" & M_FROM & ">"
            mTo = MEM_NAME & "<" & MEM_EMAIL & ">"
            mSubject = S_TITLE
            mbody = S_CONT

            Call Send_Mail(mFrom,mTo,mSubject,mbody)

            Rs.MoveNext
         Loop
      End If
      Rs.close

      Conn.Close
      Set Conn = nothing
   End If

   Page_Msg_ParentReload "메일을 발송하였습니다."
   response.end
%>
