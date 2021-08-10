<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_SECEDE,MEM_SECEDE_DETAIL,MEM_MDATE,MEM_STATE

   MEM_SEQ = Trim(Request.Form("mem_seq"))
   MEM_PWD = Replace(Trim(Request.form("mem_pwd")),"'","''")
   MEM_SECEDE = Trim(Request.Form("mem_secede"))
   MEM_SECEDE_DETAIL = Replace(Trim(Request.Form("mem_secede_detail")),"'","''")
   MEM_MDATE = NowDate
   MEM_STATE = "91" '본인탈퇴

   SQL = "SELECT * FROM " & MEM_LST_Table _
       & " WHERE MEM_SEQ=" & MEM_SEQ & " AND MEM_STATE < '90'"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MEM_HASH = Rs("MEM_HASH")
      MEM_HASH_PWD = Rs("MEM_PWD")
   Else
      Page_Msg_Back "회원정보를 찾을수 없거나, 비밀번호가 일치하지 않습니다."
      response.end
   End If
   Rs.close

   MEM_GET_PWD = GetHash(MEM_HASH,MEM_PWD)

   If MEM_GET_PWD = MEM_HASH_PWD Then
      Session("MEM_SEQ") = ""
      Session("MEM_NAME") = ""
      Session("MEM_ID") = ""
      Session("MEM_HP") = ""
      Session("MEM_EMAIL") = ""
      Session("MEM_LEVEL") = ""
      Session("ARA_CODE") = ""

      SQL = "UPDATE " & MEM_LST_Table & " SET " _
          & "MEM_SECEDE='" & MEM_SECEDE & "', " _
          & "MEM_SECEDE_DETAIL=N'" & MEM_SECEDE_DETAIL & "', " _
          & "MEM_MDATE='" & MEM_MDATE & "', " _
          & "MEM_STATE='" & MEM_STATE & "' " _
          & "WHERE " _
          & "MEM_SEQ=" & MEM_SEQ

      Conn.Execute SQL, ,adCmdText

      Page_Msg_Href "정상적으로 탈퇴처리 되었습니다.", "/"
   Else
      Page_Msg_Back "회원정보를 찾을수 없거나, 비밀번호가 일치하지 않습니다."
      response.end
   End If

   Conn.Close
   Set Conn = nothing

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
