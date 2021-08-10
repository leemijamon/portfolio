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

   PRO_METHOD = Trim(Request("method"))

   Dim MSG,GO_PAGE
   Dim M_ITEM,M_TITLE,M_CONT

   Select Case PRO_METHOD
      Case "send" : pro_send
      Case "certify" : pro_certify
   End Select

   Sub pro_send()
      Dim MEM_LST_Table
      MEM_LST_Table = "MEM_LST"

      Dim MEM_SEQ,MEM_EMAIL

      MEM_SEQ = Session("MEM_SEQ")
      MEM_EMAIL = Replace(Trim(Request.Form("mem_email")),"'","''")

      If MC_CONFIRM <> "2" Then
         response.write "0"
         response.end
      End If

      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      If MEM_SEQ = "" Then
         SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_STATE < '90'"
      Else
         SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_SEQ <> " & MEM_SEQ & " AND MEM_STATE < '90'"
      End If

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         response.write "1"
         response.end
      End If
      Rs.close

      Conn.Close
      Set Conn = nothing

      '### 인증번호
      Randomize()
      strNum = ""
      For fc = 1 to 6
         strNum = strNum & Cstr(Int(10 * Rnd))
      Next

      '#### 메일발송
      If AM_CERTIFY = "1" Then
         M_ITEM = "certify"
         M_TITLE = "이메일 인증번호 입니다. - {{사이트명}}"

         Call MailRead()

         M_CONT = Replace(M_CONT, "{{제목}}", M_TITLE)
         M_CONT = Replace(M_CONT, "{{인증메일}}", MEM_EMAIL)
         M_CONT = Replace(M_CONT, "{{인증번호}}", strNum)

         mFrom = CS_NAME & "<" & CM_EMAIL & ">"
         mTo = MEM_EMAIL
         mSubject = M_TITLE
         mbody = M_CONT

         Call Send_Mail(mFrom,mTo,mSubject,mbody)
      End If

      Session("CERTIFY_NUM") = strNum
      Session("CERTIFY_EMAIL") = MEM_EMAIL

      response.write "ok"
      response.End
   End Sub

   Sub pro_certify()
      Dim MEM_CERTIFY_NUM

      MEM_CERTIFY_NUM = Replace(Trim(Request.Form("mem_certify_num")),"'","''")

      If Session("CERTIFY_NUM") = MEM_CERTIFY_NUM Then
         response.write "Y"
      Else
         response.write "N"
      End If
      response.end
   End Sub
%>