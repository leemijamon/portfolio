<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/member_config.inc" -->
<!-- #include virtual = "/conf/send_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_NAME,MEM_ID,MEM_EMAIL,MEM_CERTIFY_KEY,MEM_WDATE,MEM_STATE
   Dim MEM_SEQ

   Dim M_ITEM,M_TITLE,M_CONT

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   '#### 검색
   SQL = "SELECT * FROM " & MEM_LST_Table & " WHERE MEM_SEQ=" & Trim(Request("mem_seq"))
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MEM_SEQ = Rs("MEM_SEQ")
      MEM_NAME = Rs("MEM_NAME")
      MEM_ID = Rs("MEM_ID")
      MEM_EMAIL = Rs("MEM_EMAIL")
   End If
   Rs.close

   '#### 메일발송
   If AM_IDSEARCH = "1" Then
      M_ITEM = "idsearch"
      M_TITLE = "{{회원명}}님 아이디 입니다. - [{{사이트명}}]"

      Call MailRead()

      M_TITLE = Replace(M_TITLE, "{{회원명}}", MEM_NAME)
      M_TITLE = Replace(M_TITLE, "{{아이디}}", MEM_ID)
      M_TITLE = Replace(M_TITLE, "{{사이트명}}", CS_NAME)

      M_CONT = Replace(M_CONT, "{{제목}}", M_TITLE)
      M_CONT = Replace(M_CONT, "{{회원명}}", MEM_NAME)
      M_CONT = Replace(M_CONT, "{{아이디}}", MEM_ID)

      mFrom = CS_NAME & "<" & CM_EMAIL & ">"
      mTo = MEM_NAME & "<" & MEM_EMAIL & ">"
      mSubject = M_TITLE
      mbody = M_CONT

      Call Send_Mail(mFrom,mTo,mSubject,mbody)
   End If

   Conn.Close
   Set Conn = nothing

   Page_Msg_Back "아이디를 이메일로 전송하였습니다."
   response.end
%>