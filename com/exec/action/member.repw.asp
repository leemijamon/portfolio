<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ
   Dim MEM_PWD,MEM_STATE

   MEM_SEQ = Trim(Request.Form("mem_seq"))
   MEM_PWD = Replace(Trim(Request.form("mem_pwd")),"'","''")

   WHERE = "MEM_SEQ=" & MEM_SEQ & " AND MEM_STATE='01'"

   SQL = "SELECT * FROM " & MEM_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MEM_SEQ = Rs("MEM_SEQ")
      MEM_HASH = Rs("MEM_HASH")
      MEM_HASH_PWD = Rs("MEM_PWD")
   Else
      Page_Msg_Back "회원정보를 찾을수 없습니다."
      response.end
   End If
   Rs.close

   MEM_GET_PWD = GetHash(MEM_HASH,MEM_PWD)

   Conn.Close
   Set Conn = nothing

   If MEM_GET_PWD = MEM_HASH_PWD Then
      Response.Redirect "?method=modify"
      Response.End
   Else
      Page_Msg_Back "비밀번를 다시 확인해주십시오."
      Response.End
   End If

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