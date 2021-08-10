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

   '### 인증번호
   Randomize()
   strNum = ""
   For fc = 1 to 6
      strNum = strNum & Cstr(Int(10 * Rnd))
   Next

   MEM_HASH = HASH_TYPE
   MEM_MDATE = NowDate
   MEM_PWD = strNum

   MEM_PWD = GetHash(MEM_HASH,MEM_PWD)

   SQL = "UPDATE " & MEM_LST_Table & " SET " _
       & "MEM_HASH=N'" & MEM_HASH & "', " _
       & "MEM_PWD=N'" & MEM_PWD & "', " _
       & "MEM_MDATE='" & MEM_MDATE & "' " _
       & "WHERE MEM_SEQ=" & MEM_SEQ

   Conn.Execute SQL, ,adCmdText

   '#### 메일발송
   If AM_PWSEARCH = "1" Then
      M_ITEM = "pwsearch"
      M_TITLE = "{{회원명}}님 임시비밀번호 입니다. - [{{사이트명}}]"

      Call MailRead()

      M_TITLE = Replace(M_TITLE, "{{회원명}}", MEM_NAME)
      M_TITLE = Replace(M_TITLE, "{{아이디}}", MEM_ID)
      M_TITLE = Replace(M_TITLE, "{{사이트명}}", CS_NAME)

      M_CONT = Replace(M_CONT, "{{제목}}", M_TITLE)
      M_CONT = Replace(M_CONT, "{{회원명}}", MEM_NAME)
      M_CONT = Replace(M_CONT, "{{아이디}}", MEM_ID)
      M_CONT = Replace(M_CONT, "{{비밀번호}}", strNum)

      mFrom = CS_NAME & "<" & CM_EMAIL & ">"
      mTo = MEM_NAME & "<" & MEM_EMAIL & ">"
      mSubject = M_TITLE
      mbody = M_CONT

      Call Send_Mail(mFrom,mTo,mSubject,mbody)
   End If

   Conn.Close
   Set Conn = nothing

   Page_Msg_Back "임시비밀번호를 이메일로 전송하였습니다."
   response.end

   Function GetHash(HashType,HashValue)
      If IsNULL(HashType) OR HashType = "" Then
         GetHash = HashValue
      ElseIf HashType = "MySQL4" OR HashType = "MySQL5" Then
         Set Hash = Server.CreateObject("EzWebUtil.Hash")
         GetHash = Hash.GetHash(HashValue,HashType)
         Set Hash = Nothing
      Else
         If HashType = "SHA256" Then HashType = "SHA2_256"
         If HashType = "SHA512" Then HashType = "SHA2_512"

         SQL = "SELECT SubString(master.dbo.fn_varbintohexstr(HashBytes('" & HashType & "', CONVERT(nvarchar(4000),'" & HashValue & "'))), 3, 150) AS HashValue"
         Set Rs = Conn.Execute(SQL, ,adCmdText)
         GetHash = Rs("HashValue")
         Rs.close
      End If
   End Function
%>