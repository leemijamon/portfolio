<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
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

   Dim MEM_SEQ,MEM_TYPE,MEM_NAME,MEM_REGNO,MEM_ID,MEM_PWD,MEM_REGNO_CK,MEM_SEX,MEM_HP
   Dim MEM_EMAIL,MEM_SAVE_MONEY,MEM_LOG_IP,MEM_LOG_DATE,MEM_LOG_CNT,ARA_CODE

   MEM_ID = Replace(Trim(Request.form("mem_id")),"'","''")
   MEM_PWD = Replace(Trim(Request.form("mem_pwd")),"'","''")
   MEM_LOG_IP = Request.ServerVariables("Remote_Addr")
   MEM_LOG_DATE = NowDate

   SQL = "SELECT * FROM " & MEM_LST_Table & " WHERE MEM_ID='" & MEM_ID & "' AND MEM_STATE = '01'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MEM_SEQ = Rs("MEM_SEQ")
      MEM_NAME = Rs("MEM_NAME")
      MEM_ID = Rs("MEM_ID")
      MEM_HASH = Rs("MEM_HASH")
      MEM_HASH_PWD = Rs("MEM_PWD")
      MEM_HP = Rs("MEM_HP")
      MEM_EMAIL = Rs("MEM_EMAIL")
      MEM_LEVEL = Rs("MEM_LEVEL")
      ARA_CODE = Rs("ARA_CODE")
   Else
      Page_Msg_Back "사용자 아이디/비밀번호가 일치하지 않습니다.\n\n다시 로그인하여주십시오."
      Response.End
   End If
   Rs.close

   MEM_GET_PWD = GetHash(MEM_HASH,MEM_PWD)

   If MEM_GET_PWD = MEM_HASH_PWD Then
      Session("MEM_SEQ") = MEM_SEQ
      Session("MEM_NAME") = MEM_NAME
      Session("MEM_ID") = MEM_ID
      Session("MEM_HP") = MEM_HP
      Session("MEM_EMAIL") = MEM_EMAIL
      Session("MEM_LEVEL") = MEM_LEVEL
      Session("ARA_CODE") = ARA_CODE
      Session("MEM_IP") = Request.ServerVariables("Remote_Addr")

      SQL = "UPDATE " & MEM_LST_Table & " SET " _
          & "MEM_LOG_IP='" & MEM_LOG_IP & "', " _
          & "MEM_LOG_DATE='" & MEM_LOG_DATE & "', " _
          & "MEM_LOG_CNT=MEM_LOG_CNT+1 " _
          & "WHERE " _
          & "MEM_SEQ=" & Session("MEM_SEQ")

      Conn.Execute SQL, ,adCmdText

      NewDate = DateSerial(year(now), month(now)+1, day(now))
      Response.Cookies("member").expires = NewDate

      If Trim(Request.form("idsave")) = "1" Then
         Response.Cookies("member")("mem_id") = Session("MEM_ID")
         Response.Cookies("member")("idsave") = "1"
         Response.cookies("member").domain = Request.ServerVariables("SERVER_NAME")
      Else
         Response.Cookies("member")("mem_id") = ""
         Response.Cookies("member")("idsave") = "0"
         Response.cookies("member").domain = Request.ServerVariables("SERVER_NAME")
      End If

      rtn_page = request("rtn_page")
      If rtn_page = "" Then rtn_page = "/"
      If InStr(rtn_page, "/member/login") > 0 Then rtn_page = "/"

      Response.Redirect Replace(rtn_page,"|","&")
      Response.End
   Else
      Page_Msg_Back "사용자 아이디/비밀번호가 일치하지 않습니다.\n\n다시 로그인하여주십시오."
      Response.End
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